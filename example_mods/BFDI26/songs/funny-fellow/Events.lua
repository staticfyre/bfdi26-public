function onStepHit()
if curStep == 1295 then
miniani = true
elseif curStep == 1823 then
	miniani = false
end

if curStep == 32 then
	doTweenAlpha('hudstart','camHUD',1,2.25,'quadOut')
elseif curStep == 256 then
	cameraFlash('camHUD', 'FFFFFF',0.5);
	doTweenZoom('camGamehihi2','camGame',getProperty('defaultCamZoom'),0.001)
	setProperty('textmiss.alpha',1)
	setProperty('bars.alpha',1)
	doTweenAlpha('logoshit','logo',1,2,'quadOut')
	doTweenAlpha('logoshit3','f',1,2,'quadOut')
	doTweenX('logoshit5','f',725,1.75,'circOut')
	setProperty('camZooming',true)
	setProperty('textacc.alpha',1)
elseif curStep == 284 then
	doTweenX('logoshit6','f',1585,2,'quadIn')
	doTweenAlpha('logoshit2','logo',0,2,'quadOut')
	doTweenAlpha('logoshit4','f',0,2,'quadOut')
	elseif curStep == 368 then
		setProperty('dad.visible',true)
		setProperty('isCameraOnForcedPos', true)
		setProperty("camFollow.y",1450)
		setProperty("camFollow.x",650)
	doTweenX('camX3', 'camFollow',getProperty("dad.x") + (getProperty("dad.width") / 2)+175,1.25,'cubeInOut')
	doTweenY('camY4', 'camFollow',getProperty("dad.y")-300,1.5,'cubeInOut')
	setProperty('defaultCamZoom',0.625)
	doTweenZoom('camGamehihi2','camGame',getProperty('defaultCamZoom'),1.75,'cubeInOut')
	setProperty('iconP2.visible',true)
	doTweenY('hivgome','hive',1225,1.5,'elasticOut')
	doTweenY('demoncoreoh','demoncore',1325,1.13231235,'elasticInOut')
	for i = 0,3 do
		setPropertyFromGroup('strumLineNotes',i,'alpha',1)
	end
elseif curStep == 768 then
    addAnimationByPrefix('shift', 'oh', 'shifty oh nah instance 1',24,false)
elseif curStep == 1823 then
	setProperty('defaultCamZoom',0.625)
elseif curStep == 2079 then
	doTweenX('dadmovw2','dad',getProperty('dad.x')-550,2,'quadIn')
	setProperty('defaultCamZoom',1)
	doTweenZoom('camGamehihi3','camGame',1,3,'cubeInOut')
	setProperty('camZooming',false)
end
	end

	function onSectionHit()
		if not mustHitSection and miniani == true then
			setProperty("camFollow.y",1450)
			setProperty('defaultCamZoom',0.85)
		elseif mustHitSection and miniani == true then
			setProperty('defaultCamZoom',0.625)
		end
		end