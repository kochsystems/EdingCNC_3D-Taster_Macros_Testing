; -----------------------------------
; 3D Taster Makro fuer EdingCNC
; Version: 1.0
; Ersteller: Markus Koch
; -----------------------------------
; Kreismittelpunkt innen finden
; -----------------------------------
; Verwendete Parameter fuer 3D Taster
; -----------------------------------
; #4201 Aktuelle Startposition X Achse
; #4202 Aktuelle Startposition Y Achse
; #4203 Merker Punkt 1 X/Y  Werkstueck Koordinatensystem #5001/#5002
; #4204 Merker Punkt 2 X/Y  Werkstueck Koordinatensystem #5001/#5002
; #4205 Ergebnis X/Y
; #4230 Tastweg X/Y max
; #4231 Suchgeschw. 
; #4032 Tastgeschw.

sub user_4 ; Kreismittelpunkt innen finden
	#4201 = #5001
	#4202 = #5002
	#4230 = 100
	#4231 = 200
	#4032 = 20
	; ----------------------------------------------------
	; Antasten X Achse
	; ----------------------------------------------------
	G91
	G38.2 X-[#4230] F#4231
	if [#5067 == 1]	; Wenn sich das Tastersignal geaendert hat dann ->
		G38.2 X+[#4230] F#4032	
		if [#5067 == 1]	; Wenn sich das Tastersignal geaendert hat dann ->
			G4 P0.5
			#4203 = #5001 ; Merker Punkt 1 X setzen
		endif
	endif
	G90
	G0 X#4201 ; Fahre auf Startposition 
	G91
	G38.2 X+[#4230] F#4231
	if [#5067 == 1]	; Wenn sich das Tastersignal geaendert hat dann ->
		G38.2 X-[#4230] F#4032
		if [#5067 == 1]	; Wenn sich das Tastersignal geaendert hat dann ->
			G4 P0.5
			#4204 = #5001 ; Merker Punkt 2 X setzen
		endif
	endif
	#4205 = [[[#4204 - #4203]/2] + #4203]
	G90
	G0 X[#4205]
	
	; ----------------------------------------------------
	; Antasten Y Achse
	; ----------------------------------------------------
	G91
	G38.2 Y-[#4230] F#4231
	if [#5067 == 1]	; Wenn sich das Tastersignal geaendert hat dann ->
		G38.2 Y+[#4230] F#4032	
		if [#5067 == 1]	; Wenn sich das Tastersignal geaendert hat dann ->
			G4 P0.5
			#4203 = #5002
		endif
	endif
	G90
	G0 Y#4202
	G91
	G38.2 Y+[#4230] F#4231
	if [#5067 == 1]	; Wenn sich das Tastersignal geaendert hat dann ->
		G38.2 Y-[#4230] F#4032
		if [#5067 == 1]	; Wenn sich das Tastersignal geaendert hat dann ->
			G4 P0.5
			#4204 = #5002
		endif
	endif
	#4205 = [[[#4204 - #4203]/2] + #4203]
	G90
	G0 Y[#4205]
	G92 X0 Y0 ; Setze Werkstueck Nullpunkt
endsub
