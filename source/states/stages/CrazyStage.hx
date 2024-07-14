package states.stages;

import backend.BaseStage;
import states.stages.objects.*;

class CrazyStage extends BaseStage
{
	override function create()
	{
		var bg:BGSprite = new BGSprite('crazystage', -600, -200, 0.9, 0.9);
		add(bg);
	}
}