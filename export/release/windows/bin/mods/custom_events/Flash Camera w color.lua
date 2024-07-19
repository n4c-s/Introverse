function onEvent(n,v1,v2)


	if n == 'Flash Camera' then

	   makeLuaSprite('flashc', '', 0, 0);
        makeGraphic('flashc',5280,3720,v2)
	      addLuaSprite('flashc', true);
	      setLuaSpriteScrollFactor('flashc',0,0)
	      setProperty('flashc.scale.x',2)
	      setProperty('flashc.scale.y',2)
	      setProperty('flashc.alpha',0)
		setProperty('flashc.alpha',1)
		doTweenAlpha('flTw','flashc',0,v1,'linear')
	end



end