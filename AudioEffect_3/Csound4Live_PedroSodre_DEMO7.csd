;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;		Inspired by the work of Iain McCurdy and Colman O'Reilly
;;		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

<CsoundSynthesizer>
<CsOptions>
-old parser
</CsOptions>
<CsInstruments>
sr		=	44100
ksmps		=	256
nchnls	=	2
0dbfs		=	1

instr 1
gainL, gainR ins

ktrig	metro	100
if (ktrig == 1)	then
gkampint chnget "ampint"
gkfrqint chnget "frqint"
gkspeed chnget "speed"

endif
endin



instr 2
//Smooths values
kampint tonek gkampint, 20
kfrqint tonek gkfrqint, 20

//Scales amp values
kampint = kampint * 0.001
kfrqint = kfrqint * 0.001

//Gets string from Max
gSfilename chnget "filename"
ichn	filenchnls gSfilename

//Handles stereo and mono channels 
if ichn == 1 then
	adiskinL diskin2 gSfilename, gkspeed ,0, 1
	adiskinR = adiskinL
else

	adiskinL, adiskinR diskin2 gSfilename, gkspeed ,0, 1
endif


ifftsize = 1024
//FFT analysis
fsigL1 pvsanal gainL, ifftsize, ifftsize/4, ifftsize, 1
fsigR1 pvsanal gainR, ifftsize, ifftsize/4, ifftsize, 1
fsigL2 pvsanal adiskinL, ifftsize, ifftsize/4, ifftsize, 1
fsigR2 pvsanal adiskinR, ifftsize, ifftsize/4, ifftsize, 1

//Spectral Morphing
foutL pvsmorph fsigL1, fsigL2, kampint, kfrqint
foutR pvsmorph fsigR1, fsigR2, kampint, kfrqint

//Resynthesis
aoutL pvsynth foutL
aoutR pvsynth foutR

outs aoutL, aoutR

endin

instr 3
turnoff2 2, 0, 0
gSfilename chnget "filename" ;redundancy to make sure gSfilename always has a value.
endin


instr 4 ;;; ACTIVE monitoring instrument.

//Verifies if instrument 2 has an instance running
kactive active 2
//If not make the input go to the output
if kactive == 0 then
outs gainL, gainR
endif

//If instrument 2 has more than 2 instances running turn then off
if kactive > 1 then
turnoff2 2, 1, 0
endif

endin


</CsInstruments>
<CsScore>
i1 0 99999
i4 0 99999

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>787</x>
 <y>193</y>
 <width>400</width>
 <height>200</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>231</r>
  <g>46</g>
  <b>255</b>
 </bgcolor>
 <bsbObject type="BSBVSlider" version="2">
  <objectName>slider1</objectName>
  <x>5</x>
  <y>5</y>
  <width>20</width>
  <height>100</height>
  <uuid>{92339812-90b8-4da6-a4bb-61365d2d5e51}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
