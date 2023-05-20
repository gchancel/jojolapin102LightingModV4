/*
jojolapin102
Wolven kit - 7.2.0.0
23/04/2023
*/

exec function jl102GetWorld()
{
	GetWitcherPlayer().DisplayHudMessage("This function does nothing.");
}

class CJL102LightingMod extends CEntityMod
{
	default modName = 'CJL102LightingMod';
    default modAuthor = "jojolapin102";
    default modUrl = "";
    default modVersion = '3.1';
    default logLevel = MLOG_DEBUG;

	var envJL102Corrections : CEnvironmentDefinition;
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
	var envInteriorEnable : bool;
	var jliter : int;
	var jlSize : int;
	var jl102Debug : bool; default jl102Debug = true;
	var jl102Region : string;
	var ssaoState : string;


	function initJL102LM()
	{
		// jl102Debug = false;
		jl102WorldName = theGame.GetWorld().GetDepotPath();

		envJL102SSR = (CEnvironmentDefinition)LoadResource("dlc\dlcjl102envs\data\environment\definitions\env_jl102_ssr_fogOnly.env", true);
		blendInTime = 1.0f;
		envInteriorEnable = true;
		jl102Region = "Région : Générique";
	}

	function updateSsaoEnvDef()
	{
		if (ssaoState != theGame.GetInGameConfigWrapper().GetVarValue('Graphics', 'SSAOEnabled'))
		{
			ssaoState = theGame.GetInGameConfigWrapper().GetVarValue('Graphics', 'SSAOEnabled');

			if (ssaoState == "1" || ssaoState == "0")
			{
				envJL102Corrections = (CEnvironmentDefinition)LoadResource("dlc\dlcjl102envs\data\environment\definitions\env_jl102_global_ssao.env", true);
			}
			else if (ssaoState == "2")
			{
				envJL102Corrections = (CEnvironmentDefinition)LoadResource("dlc\dlcjl102envs\data\environment\definitions\env_jl102_global_hbao.env", true);
			}

			DeactivateEnvironment(envJL102Cid, 0.0f);
			envJL102Cid = ActivateEnvironmentDefinition(envJL102Corrections, 900, 1.0f, 1.0f);
		}
	}
	
	function custom_world_shadow()
	{
		// Load and enable the global environment containing corrections.
		ssaoState = theGame.GetInGameConfigWrapper().GetVarValue('Graphics', 'SSAOEnabled');
		if (ssaoState == "1" || ssaoState == "0")
		{
			envJL102Corrections = (CEnvironmentDefinition)LoadResource("dlc\dlcjl102envs\data\environment\definitions\env_jl102_global_ssao.env", true);
		}
		else if (ssaoState == "2")
		{
			envJL102Corrections = (CEnvironmentDefinition)LoadResource("dlc\dlcjl102envs\data\environment\definitions\env_jl102_global_hbao.env", true);
		}
		envJL102Cid = ActivateEnvironmentDefinition(envJL102Corrections, 900, 1.0f, 1.0f);
		
		jl102LM_world = theGame.GetWorld();
		
		//TEST PURPOSES ONLY
		filterSize = "SMOOTH";
		//TEST PURPOSES ONLY
		
		// Overwrite the global world shadow configuration for better looking results. (best compromise)
		jl102LM_world.shadowConfig.numCascades = 4;
		jl102LM_world.shadowConfig.cascadeRange1 = 7;
		jl102LM_world.shadowConfig.cascadeRange2 = 25;
		jl102LM_world.shadowConfig.cascadeRange3 = 110;
		jl102LM_world.shadowConfig.cascadeRange4 = 210;
		jl102LM_world.shadowConfig.terrainShadowsDistance = 5000;
		
		if (filterSize == "SMOOTH")
		{
			// SMOOTH -> CascadeShadowMapsize = 4096 for optimal results
			jl102LM_world.shadowConfig.cascadeFilterSize1 = 0.03;
			jl102LM_world.shadowConfig.cascadeFilterSize2 = 0.05;
			jl102LM_world.shadowConfig.cascadeFilterSize3 = 0.05;
			jl102LM_world.shadowConfig.cascadeFilterSize4 = 0.05;
		}
		
		else if (filterSize == "MEDIUM")
		{
			// MEDIUM sharpness -> CascadeShadowMapsize = 5120 or 6144 for optimal results
			jl102LM_world.shadowConfig.cascadeFilterSize1 = 0.02;
			jl102LM_world.shadowConfig.cascadeFilterSize2 = 0.02;
			jl102LM_world.shadowConfig.cascadeFilterSize3 = 0.03;
			jl102LM_world.shadowConfig.cascadeFilterSize4 = 0.03;
		}
		
		else if (filterSize == "SHARP")
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
		if (envInteriorEnable)
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


statemachine class CJL102StateMachine extends CMod
{
	default modName = "Jojolapin102's Lighting Mod";
    default modAuthor = "jojolapin102";
    default modUrl = "";
    default modVersion = '3.1';
    default logLevel = MLOG_DEBUG;
}

state SGC_init in CJL102StateMachine
{
	event OnEnterState(previousStateName: name)
	{
		this.entryFunctionExample();
	}
	
	entry function entryFunctionExample()
	{
		this.latentFunctionExample();
	}

	latent function latentFunctionExample()
	{
		GetWitcherPlayer().DisplayHudMessage(parent.modName);
	}
}