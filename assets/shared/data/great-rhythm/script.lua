function onSongStart()
    noteTweenAlpha("GeNoteAlpha1", 0, -1, 0.0, circInOut)
    noteTweenX("", 0, nil, 0.0, "") 
end

function onStepHit()
    if curStep == 496 then
       noteTweenAlpha("NoteAlpha1", 4, -1, 0.5, cubeInOut) 
    end
end