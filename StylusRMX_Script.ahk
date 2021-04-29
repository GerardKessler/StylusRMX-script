CoordMode, Mouse, Window
Menu, Tray, NoStandard
Menu, Tray, Tip, Stylus Script
Menu, Tray, Add, Abrir las instrucciones en el navegador, Instructions
Menu, Tray, Add, Pausar el script, Suspend
Menu, Tray, Add, Cerrar el script, Exit

SoundPlay Files\1.mp3

;Menú del Keygen
Menu,M,Add,Stylus,stylus
Menu,M,Add,Trillian,trillian
Menu,M,Add,Omnisphere,omnisphere

Loop, 8
Menu, K, Add,% "Chanel: " A_Index,% "#!^+" A_Index

Gui, Add, ListView,, Comando|Atajo
Gui, Default
Comandos:=["Abrir las instrucciones en el navegador","Moverse a la siguiente pestaña","Moverse a la pestaña anterior","Moverse a la siguiente opción en la pestaña con el foco","Moverse a la opción anterior en la pestaña con el foco","Activar la opción con el foco","Enfocar el primer preset de la lista","Enfocar el preset siguiente de la lista","Enfocar el preset anterior de la lista","Moverse al último preset de la lista","Siguiente página de presets","Anterior página de presets","Reproducir y pausar el preset con el foco","Pausar y reanudar el script","Cerrar el script"]
Atajos:=["F 1","Shift flecha derecha","Shift flecha izquierda","Shift flecha abajo","Shift flecha arriba","Shift Énter","Tecla inicio","Letra s","Letra a","Tecla fin","Avance de página","Retroceso de página","Barra espaciadora","Control Q","Alt Q"]
For i, Commands in comandos
LV_Add("",Commands,Atajos[i])

Class Stylus {
	__New(xCoord:="",yCoord:="",Text:="") {
		This.xCoord:=xCoord
		This.yCoord:=yCoord
		This.Text:=Text
		}
	
	Menu() {
		Menu, K, Show
		Return      
		}

	Clicks() {
		Click,% xCoord "," yCoord
		Sleep 250
		Process, Exist, jfw.exe
		If ErrorLevel != 0
			{
			Jaws := ComObjCreate("FreedomSci.JawsApi")
			Jaws.SayString(This.Text)
			}
	Else {
			return DllCall("Files\nvdaControllerClient" A_PtrSize*8 ".dll\nvdaController_speakText", "wstr", This.Text)
			}
		}

Speak() {
	Process, Exist, jfw.exe
	If ErrorLevel != 0
		{
		Jaws := ComObjCreate("FreedomSci.JawsApi")
		Jaws.SayString(This.Text)
		}
	Else {
		return DllCall("Files\nvdaControllerClient" A_PtrSize*8 ".dll\nvdaController_speakText", "wstr", This.Text)
		}
	}
	
Library() {
		Click,370,170
		Sleep 50
		Click,82,117
		}
	}

Sleep 750
Speech := New Stylus(,,"Script Iniciado.`nPara ver la lista de atajos, pulse windows h")
Speech.Speak()

#If WinActive("ahk_class REAPERb32host")

ar := Array()
	ar[1,0] := New Stylus(303,552,"Ventana principal")
	ar[2,0] := New Stylus(520,553,"Ventana Mixer")
	ar[1,1] := New Stylus(,,"Menú chanels")
	ar[1,2] := New Stylus(587,545,"Midi mode")
	ar[1,3] := New Stylus(101,146,"Category menu")
	ar[1,4] := New Stylus(,,"Library menu")
	ar[2,1] := New Stylus(102,105,"Output 1")
	ar[2,2] := New Stylus(102,156,"Output 2")
	ar[2,3] := New Stylus(102,205,"Output 3")
	ar[2,4] := New Stylus(102,252,"Output 4")
	ar[2,5] := New Stylus(102,301,"Output 5")
	ar[2,6] := New Stylus(102,352,"Output 6")
	ar[2,7] := New Stylus(102,400,"Output 7")
	ar[2,8] := New Stylus(102,448,"Output 8")

x=1
y=0

+Down::
	y++
	If y < % ar[x].Count()
		{
		ar[x,y].Speak()
		}
	Else 	{
		y=1
		ar[x,1].Speak()
		}
	Return

+Up::
	y--
	If y >= 1
		{
		ar[x,y].Speak()
		}
	Else {
		y= % ar[x].Count()
		y--
		ar[x,y].Speak()
		}
	Return

+Right::
	y=0
	x++
	If x <= 2
		{
		ar[x,y].Clicks() 
		}
	Else {
		x=1
		ar[1,0].Clicks()
		}
	Return

+Left::
	y=0
	x--
	If x >= 1
		{
		ar[x,y].Clicks() 
		}
	Else {
		x=2
		ar[2,0].Clicks()
		}
	Return

+Enter::
	If ar[x,y] = ar[1,1]
		ar[1,1].Menu()
	If ar[x,y] = ar[1,4]
		ar[x,y].Library()
	Else
		ar[x,y].Clicks()
	Return
   
#!^+1::Click(320,508,0,"Chanel 1")
#!^+2::Click(346,506,0,"Chanel 2")
#!^+3::Click(373,509,0,"Chanel 3")
#!^+4::Click(397,511,0,"Chanel 4")
#!^+5::Click(424,509,0,"Chanel 5")
#!^+6::Click(449,509,0,"Chanel 6")
#!^+7::Click(473,509,0,"Chanel 7")
#!^+8::Click(500,509,0,"Chanel 8")

Space::
	MouseGetPos, xCoord, yCoord
	Sleep 25
	Click,570,114
	Click, %xCoord%, %yCoord%, 0
	Return

Home::Click(305,114,250,"Primer Preset.")
End::Click(305,450,250,"Ultimo preset")

s::
	MouseMove, 0, 16,,R
	Sleep 25
	Click
	SoundPlay Files\3.mp3
	MouseGetPos, xCoord, yCoord
	If (xCoord = 305 && yCoord = 450)
		{
		SoundBeep,880,500
		Sleep 250
		Speech.Speak("Final de la lista")
		}
	Return

a::
	MouseMove, 0, -16,,R
	Sleep 25
	Click
	SoundPlay Files\2.mp3
	Return

PgDn::
	Click,429,309,0
	Sleep 25
	Loop 22
		{
		Click, WheelDown
		Sleep 10
		}
	Speech := New Stylus(,,"Pagina Siguiente")
	Speech.Speak()
	Return

PgUp::
	Click,429,309,0
	Sleep 25
	Loop 22
		{
		Click, WheelUp
		Sleep 10
		}
	Speech := New Stylus(,,"Pagina Anterior")
	Speech.Speak()
	Return

Click(xCoord,yCoord,Time,Text) {
	Click,%xCoord%,%yCoord%
	Sleep %Time%
	return DllCall("Files\nvdaControllerClient" A_PtrSize*8 ".dll\nvdaController_speakText", "wstr", text)
	}
Return

#If winActive("Lista de atajos")
Esc::
Gui, Hide
Return

#If

#h::
Hotkeys:
Sleep 250
Gui, Show,, Lista de atajos
Return

f1::
Instructions:
Run Files\Instrucciones.html
Return

#k::Menu,m,Show

   ;KeygenTages
stylus:
	Sleep 25
	Click,92,224
	Return

trillian:
	Sleep 25
	Click,84,257
	Return

omnisphere:
	Sleep 25
	Click,86,191
	Return

^q::
	Suspend:
	Suspend
	If (A_IsSuspended)
		{
		Speech := New Stylus(,,"Atajos desactivados.")
		Speech.Speak()
		Menu, Tray, Tip, Script en pausa
		}
	Else {
		Speech := New Stylus(,,"Atajos reactivados")
		Speech.Speak()
		Menu, Tray, Tip, Stylus Script
		}
	Return

!q::
Exit:	
Speech := New Stylus(,,"Script Finalizado")
	Speech.Speak()
	Sleep 50
	ExitApp
	Return
