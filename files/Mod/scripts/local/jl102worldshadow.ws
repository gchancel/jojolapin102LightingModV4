/*
jojolapin102 - Gchancel
Wolven kit - 7.2.0.0
23/04/2023 - Original v?
20/05/2023 - Update v4
*/

function modCreateJL102Lighting() : CModJL102LM
{
    return new CModJL102LM in thePlayer;
}

exec function jl102LMStartMod()
{
    var mod: CModJL102LM;
    jlmod = CModJL102LM();
    jlmod.init();
}

exec function jl102GetWorld()
{
	GetWitcherPlayer().DisplayHudMessage("This function does nothing.");
}

statemachine class CModJL102LM extends CMod
{
	default modName = "Jojolapin102's Lighting Mod";
    default modAuthor = "jojolapin102";
    default modUrl = "https://github.com/gchancel/jojolapin102LightingModV4";
    default modVersion = '4.0';
    default logLevel = MLOG_DEBUG;

	private var jl102LM : CJL102LightingMod;

	public function init()
	{
		super.init();
		jl102LM = new CJL102LightingMod in this;
		PushState('sgcInit');
	}
}

state sgcIdle in CJL102StateMachine
{
	event onEnterState(prevState : name)
	{
		if (thePlayer.OnInteriorStateChanged(thePlayer.IsInInterior()))
		{
			parent.PushState('sgcInteriorEnv')
		}
	}
}

state sgcInit in CJL102StateMachine
{
	event OnEnterState(prevState : name)
	{
		parent.jl102LM.initJL102LM(theGame.GetInGameConfigWrapper().GetVarValue('jl102LightingMenu', 'envIntEnable'));
		parent.PushState('sgcCustomWorldShadow')
	}
}

state sgcCustomWorldShadow in CJL102StateMachine
{
	event OnEnterState(prevState : name)
	{
		parent.jl102LM.custom_world_shadow(theGame.GetInGameConfigWrapper().GetVarValue('jl102LightingMenu', 'shadowFilterSize'));
		parent.jl102lm.displayModEnabledJL102();
		parent.PushState('sgcIdle');
	}
}
