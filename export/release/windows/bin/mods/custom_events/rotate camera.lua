function onEvent(n,v1,v2)


	if n == 'rotate camera' then
    setProperty('camGame.angle', v1)
	doTweenAngle('Bop', 'camGame', 0, v2, 'cubeIn')
	end



end