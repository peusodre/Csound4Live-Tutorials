
;;		Inspired by the work of Iain McCurdy and Colman O'Reilly


<CsoundSynthesizer>
<CsOptions>
-old parser
</CsOptions>
<CsInstruments>
sr		=	44100
ksmps		=	256
nchnls	=	2
0dbfs		=	1

instr 2

//Receives values from Max
gkfrqscl chnget "frqscl"
kfftsize   chnget "FFTSIZE" 
kwintype   chnget "WINSIZE" 

gainL, gainR ins

//Smooths values
kfrqscale tonek gkfrqscl, 20


ifftsize =1024
iwintype = i(kwintype)

//fft-analysis of the audio-signal
fsigL pvsanal gainL, ifftsize, ifftsize/4, ifftsize, iwintype
fsigR pvsanal gainR, ifftsize, ifftsize/4, ifftsize, iwintype

//Scale
foutL pvscale fsigL, kfrqscale
foutR pvscale fsigR, kfrqscale

//Resynthesis
aoutL pvsynth foutL
aoutR pvsynth foutR

outs aoutL, aoutR

endin


</CsInstruments>
<CsScore>
i2 0 100000

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
