<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

turnon	1

instr 1

gisaw ftgen 1, 0, 16384, 10, 1, 0.5, 0.3, 0.25, 0.2, 0.167, 0.14, 0.125, 0.111  

icps cpsmidi 
iamp ampmidi 0.5
kenv linsegr 0,  0.01,  1, 0.01, 0

kcof chnget "CutOffFrequency" 
;kcof port kcof, 0.02

asig oscil iamp, icps, gisaw
ares moogladder asig, kcof, 0.6

outs ares*kenv, ares*kenv

endin

</CsInstruments>
<CsScore> 
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
