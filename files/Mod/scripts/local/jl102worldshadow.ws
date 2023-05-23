/*
jojolapin102 - Gchancel
Wolven kit - 7.2.0.0
23/04/2023 - Original v?
20/05/2023 - Update v4
*/

exec function checkEnvInteriorSetting()
{
	GetWitcherPlayer().DisplayHudMessage(theGame.GetInGameConfigWrapper().GetVarValue('jl102Config', 'envIntEnable'));
}

// exec function jl102EnvsDebug()
// {
// 	var i : int;
// 	var envList : array< string >;

// 	GetActiveAreaEnvironmentDefinitions(envList);
// 	for (i = 0; i < envList.Size(); i += 1)
// 	{

// 	}
// }

exec function jl102_disable_envs()
{
    var null: CEnvironmentDefinition;
    var i : int;

    for (i = 0; i < 50000; i += 1)
	{
        DeactivateEnvironment(i, 0.0);
    }
}

exec function enableEnv(regionName : string)
{
    var null: CEnvironmentDefinition;
    var i : int;

    for (i = 0; i < 50000; i += 1)
	{
        DeactivateEnvironment(i, 0.0);
    }

	// Novigrad City
	if (regionName == "novigrad")
	{
		ActivateEnvironmentDefinition((CEnvironmentDefinition)LoadResource("environment\definitions\env_novigrad\env_novigrad_sunset.env", true), 0, 1.0, 0.0);
		ActivateEnvironmentDefinition((CEnvironmentDefinition)LoadResource("environment\definitions\env_novigrad\env_novigrad_global\env_novigrad_city.env", true), 1, 1.0, 0.0);
	}
	else if (regionName == "novigradInterior")
	{
		ActivateEnvironmentDefinition((CEnvironmentDefinition)LoadResource("environment\definitions\env_novigrad\env_novigrad_sunset.env", true), 0, 1.0, 0.0);
		ActivateEnvironmentDefinition((CEnvironmentDefinition)LoadResource("environment\definitions\env_novigrad\env_novigrad_global\env_novigrad_city.env", true), 1, 1.0, 0.0);
		ActivateEnvironmentDefinition((CEnvironmentDefinition)LoadResource("dlc\dlcjl102envs\data\environment\definitions\env_jl102_interior_generic.env", true), 2, 1.0, 0.0);
	}

	// Velen No Swamp
	else if (regionName == "velen")
	{
		ActivateEnvironmentDefinition((CEnvironmentDefinition)LoadResource("environment\definitions\env_novigrad\env_novigrad_sunset.env", true), 0, 1.0, 0.0);
	}
	else if (regionName == "velenInterior")
	{
		ActivateEnvironmentDefinition((CEnvironmentDefinition)LoadResource("environment\definitions\env_novigrad\env_novigrad_sunset.env", true), 0, 1.0, 0.0);
		ActivateEnvironmentDefinition((CEnvironmentDefinition)LoadResource("dlc\dlcjl102envs\data\environment\definitions\env_jl102_interior_generic.env", true), 1, 1.0, 0.0);
	}
}

class CJL102LightingMod extends CEntityMod
{
	default modName = 'CJL102LightingMod';
    default modAuthor = "jojolapin102";
    default modUrl = "https://github.com/gchancel/jojolapin102LightingModV4";
    default modVersion = '4.0';
    default logLevel = MLOG_DEBUG;

	var envJL102CorrectionsSSAO : CEnvironmentDefinition;
	var envJL102CorrectionsHBAO : CEnvironmentDefinition;
	var envJL102Cid : int; default envJL102Cid = -1;
	var envJL102idSSR : int; default envJL102idSSR = -1;
	var colorSceneMul : SSimpleCurve;
	var colorSkyMul : SSimpleCurve;
	var colorSkyAdd : SSimpleCurve;
	var envJL102SSR : CEnvironmentDefinition;
	var envCutDefGlo : CEnvironmentDefinition;
	var jl102LM_world : CWorld;
	var filterSize : string;
	var jl102WorldName : string;
	var blendInTime : float;
	// var envInteriorEnable : string;
	var jliter : int;
	var jlSize : int;
	var jl102Debug : bool; default jl102Debug = true;
	var jl102Region : string;
	var ssaoState : string;
	var gameConfigWrapper : CInGameConfigWrapper;


	function initJL102LM()
	{
		// envInteriorEnable = gameConfigWrapper.GetVarValue('jl102Config', 'envIntEnable');
		envJL102SSR = (CEnvironmentDefinition)LoadResource("dlc\dlcjl102envs\data\environment\definitions\env_jl102_interior_generic.env", true);
		gameConfigWrapper = theGame.GetInGameConfigWrapper();
		jl102LM_world = theGame.GetWorld();
		blendInTime = 1.0f;
		jl102Region = "Région : Générique";
	}

	function updateSsaoEnvDef()
	{
		ssaoState = gameConfigWrapper.GetVarValue('Graphics', 'SSAOEnabled');

		if (ssaoState == "1" || ssaoState == "0")
		{
			DeactivateEnvironment(envJL102Cid, 0.0f);
			envJL102Cid = ActivateEnvironmentDefinition(envJL102CorrectionsSSAO, 900, 1.0f, 1.0f);
			// if (jl102Debug) GetWitcherPlayer().DisplayHudMessage("SSAO CORRECTIONS");
		}
		else if (ssaoState == "2")
		{
			DeactivateEnvironment(envJL102Cid, 0.0f);
			envJL102Cid = ActivateEnvironmentDefinition(envJL102CorrectionsHBAO, 900, 1.0f, 1.0f);
			// if (jl102Debug) GetWitcherPlayer().DisplayHudMessage("HBAO CORRECTIONS");
		}
	}

	function updateJL102Settings()
	{
		var localFilterSize : string;
		// envInteriorEnable = gameConfigWrapper.GetVarValue('jl102Config', 'envIntEnable');
		localFilterSize = gameConfigWrapper.GetVarValue('jl102Config', 'shadowFilterSize');
		if (filterSize != localFilterSize)
		{
			filterSize = localFilterSize;
			// if (jl102Debug) GetWitcherPlayer().DisplayHudMessage("NEW FILTER SIZE");
			worldShadowFilter();
		}
	}

	function globalEnvCorrections()
	{
		// Load and enable the global environment containing corrections.
		ssaoState = gameConfigWrapper.GetVarValue('Graphics', 'SSAOEnabled');
		envJL102CorrectionsSSAO = (CEnvironmentDefinition)LoadResource("dlc\dlcjl102envs\data\environment\definitions\env_jl102_global_ssao.env", true);
		envJL102CorrectionsHBAO = (CEnvironmentDefinition)LoadResource("dlc\dlcjl102envs\data\environment\definitions\env_jl102_global_hbao.env", true);

		if (ssaoState == "1" || ssaoState == "0" && envJL102Cid == -1)
		{
			envJL102Cid = ActivateEnvironmentDefinition(envJL102CorrectionsSSAO, 900, 1.0f, 1.0f);
		}
		else if (ssaoState == "1" || ssaoState == "0" && envJL102Cid > -1)
		{
			DeactivateEnvironment(envJL102Cid, 0.0f);
			envJL102Cid = ActivateEnvironmentDefinition(envJL102CorrectionsSSAO, 900, 1.0f, 1.0f);
		}

		else if (ssaoState == "2" && envJL102Cid == -1)
		{
			envJL102Cid = ActivateEnvironmentDefinition(envJL102CorrectionsHBAO, 900, 1.0f, 1.0f);
		}
		else if (ssaoState == "2" && envJL102Cid > -1)
		{
			DeactivateEnvironment(envJL102Cid, 0.0f);
			envJL102Cid = ActivateEnvironmentDefinition(envJL102CorrectionsHBAO, 900, 1.0f, 1.0f);
		}
	}

	function worldShadowRange()
	{
		// Overwrite the global world shadow configuration for better looking results. (best compromise)
		jl102LM_world.shadowConfig.numCascades = 4;
		jl102LM_world.shadowConfig.cascadeRange1 = 7;
		jl102LM_world.shadowConfig.cascadeRange2 = 25;
		jl102LM_world.shadowConfig.cascadeRange3 = 110;
		jl102LM_world.shadowConfig.cascadeRange4 = 210;
		jl102LM_world.shadowConfig.terrainShadowsDistance = 5000;
	}

	function worldShadowFilter()
	{
		filterSize = gameConfigWrapper.GetVarValue('jl102Config', 'shadowFilterSize');
		if (filterSize == "0")
		{
			// SMOOTH -> CascadeShadowMapsize = 4096 for optimal results
			jl102LM_world.shadowConfig.cascadeFilterSize1 = 0.03;
			jl102LM_world.shadowConfig.cascadeFilterSize2 = 0.05;
			jl102LM_world.shadowConfig.cascadeFilterSize3 = 0.05;
			jl102LM_world.shadowConfig.cascadeFilterSize4 = 0.05;
		}
		
		else if (filterSize == "1")
		{
			// MEDIUM sharpness -> CascadeShadowMapsize = 5120 or 6144 for optimal results
			jl102LM_world.shadowConfig.cascadeFilterSize1 = 0.02;
			jl102LM_world.shadowConfig.cascadeFilterSize2 = 0.02;
			jl102LM_world.shadowConfig.cascadeFilterSize3 = 0.03;
			jl102LM_world.shadowConfig.cascadeFilterSize4 = 0.03;
		}
		
		else if (filterSize == "2")
		{
			// SHARP -> CascadeShadowMapsize = 8192 for optimal results
			jl102LM_world.shadowConfig.cascadeFilterSize1 = 0.015;
			jl102LM_world.shadowConfig.cascadeFilterSize2 = 0.015;
			jl102LM_world.shadowConfig.cascadeFilterSize3 = 0.025;
			jl102LM_world.shadowConfig.cascadeFilterSize4 = 0.025;
		}
	}
	
	function playerInteriorState(inInterior : bool)
	{
		if (gameConfigWrapper.GetVarValue('jl102Config', 'envIntEnable'))
		{
			if (inInterior)
			{
				if (jl102Debug)
				{
					GetWitcherPlayer().DisplayHudMessage("Enabling custom interior env.");
				}
				if (envJL102idSSR == -1)
				{
					envJL102idSSR = ActivateEnvironmentDefinition(envJL102SSR, 999, 1.0f, blendInTime);
				}
			}
			else
			{
				if (envJL102idSSR > -1)
				{
					DeactivateEnvironment(envJL102idSSR, blendInTime);
					envJL102idSSR = -1;
					if (jl102Debug)
					{
						GetWitcherPlayer().DisplayHudMessage("Disabling custom interior env.");
					}
				}
			}
		}
	}
	
	function displayModEnabledJL102()
	{
		GetWitcherPlayer().DisplayHudMessage("Jojolapin102 lighting mod enabled.");
	}
}

// On laisse tomber ce qui suit, la méthode simple ci-dessus marche mieux.
// function modCreateJL102Lighting() : CModJL102LM
// {
//     return new CModJL102LM in thePlayer;
// }

// exec function jl102LMStartMod()
// {
//     var mod: CModJL102LM;
//     jlmod = CModJL102LM();
//     jlmod.init();
// }

// exec function jl102GetWorld()
// {
// 	GetWitcherPlayer().DisplayHudMessage("This function does nothing.");
// }

// statemachine class CModJL102LM extends CMod
// {
// 	default modName = "Jojolapin102's Lighting Mod";
//     default modAuthor = "jojolapin102";
//     default modUrl = "https://github.com/gchancel/jojolapin102LightingModV4";
//     default modVersion = '4.0';
//     default logLevel = MLOG_DEBUG;

// 	protected var jl102LM : CJL102LightingMod;
// 	protected var gameConfigWrapper : CInGameConfigWrapper;

// 	public function startJL102()
// 	{
// 		jl102LM = new CJL102LightingMod in this;
// 		gameConfigWrapper = theGame.GetInGameConfigWrapper();
// 		this.GotoState("sgcInit");
// 	}
// }

// state sgcInit in CModJL102LM
// {
// 	event OnEnterState(prevState : name)
// 	{
// 		parent.jl102LM.initJL102LM(gameConfigWrapper.GetVarValue('jl102Config', 'envIntEnable')); //Initialize interior envs
// 		parent.jl102LM.custom_world_shadow(gameConfigWrapper.GetVarValue('jl102Config', 'shadowFilterSize')); //Setting global env and world shadow config
// 		parent.jl102lm.displayModEnabledJL102(); //Notify that the mod is enabled in the HUD
// 		this.GotoState("sgcIdle"); //go to next state
// 	}
// }

// state sgcIdle in CModJL102LM
// {
// 	if (thePlayer.OnInteriorStateChanged(thePlayer.IsInInterior()))
// 	{
// 		parent.PushState('sgcInteriorEnv');
// 	}

// 	if 
// }

// state sgcInteriorEnv in CModJL102LM
// {
// 	event OnEnterState(prevState : name)
// 	{
// 		parent.jl102lm.playerInteriorState(thePlayer.IsInInterior());
// 		parent.PushState('sgcIdle');
// 	}
// }
