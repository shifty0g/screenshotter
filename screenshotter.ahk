/* Screenshots
11/01/21


Currently Takes Screenshots of the following 
	secpol
	



To Do
============
Fix issue with firewall - not full screen and image is blacks
Scrolling not working on secpol


winupdate
installed update
system info
winver
checks for java and if it exists ge a screenshot
check registry sufff
try and get the secpol to sort columns out 









*/

; functions 
secpol() {
; opens secpol.msc takes screenshots and exports sections out 
; on windows 7 the scrolling doesnt seem to work 

WinActivate, Local Security Policy  
WinClose, Local Security Policy  
sleep 600


IfWinNotExist, Local Security Policy
    Run, secpol.msc

WinWait, Local Security Policy   
WinActivate, Local Security Policy    

sleep 600  
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {down}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
send {up}
sleep 600  

send {down}
send {right}
send {down}

;Password Policy
sleep 1200

pToken := Gdip_Startup()
WinGet, hwnd, ID, Local Security Policy
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "secpol_password-policy.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
sleep 600


sleep 300      
send {down}
sleep 1200

; Account Lockout 

pToken := Gdip_Startup()
WinGet, hwnd, ID, Local Security Policy
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "secpol_account-lockout-policy.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)

    
sleep 600    
send {down}
send {right}
send {down}


;Audit Policy 
sleep 1200

;audit policy - screenshot
pToken := Gdip_Startup()
WinGet, hwnd, ID, Local Security Policy
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "secpol_audit-policy.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
    

sleep 300  
send {down}
WinMaximize 


;URA
sleep 1200

; need to figure out how to set columns here 

; URA - screenshot
pToken := Gdip_Startup()
WinGet, hwnd, ID, Local Security Policy
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "secpol_ura-policy.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
    
send {down}
WinMaximize 

;Security Options 
sleep 1200


;p1
pToken := Gdip_Startup()
WinGet, hwnd, ID, Local Security Policy
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "secpol_security-options1.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)

sleep 1200
send, {WheelDown 15}

;p2
pToken := Gdip_Startup()
WinGet, hwnd, ID, Local Security Policy
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "secpol_security-options2.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)

sleep 1200
send, {WheelDown 15}

;p3
pToken := Gdip_Startup()
WinGet, hwnd, ID, Local Security Policy
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "secpol_security-options3.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)

WinClose, Local Security Policy 

sleep 900
FileMove, secpol_*.png, %outdir%
}
firewall() {
sleep 1800

Run, wf.msc, Max

WinWait, Windows
WinActivate, Windows
WinMaximize ; use the window found above
WinGet, hwnd,ID,A  ;get handle of active window 
;WinMaximize, A

Sleep 1800
pToken:=Gdip_Startup()
pBitmap:=Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "firewall.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
Sleep 1200

FileMove, firewall.png, %outdir%

WinClose, Windows
}
windef() {
; opens windows security - AV and screenshots it
; currently this is not working 
WinActivate, Windows Security 
WinClose, Windows Security 
sleep 300

IfWinNotExist, Windows Security 
    Run, windowsdefender:virus, ,max

WinMaximize, A
WinWait, Windows Security 
WinActivate, Windows Security 
WinGet, hwnd,ID,A  ;get handle of active window 

sleep 600
send {enter}
sleep 300
send {enter}

Sleep 1800
WinGet, hwnd,ID,A  ;get handle of active window 
pToken:=Gdip_Startup()
;pBitmap:=Gdip_BitmapFromHWND(hwnd)
pBitmap:=Gdip_BitmapFromScreen()
Gdip_SaveBitmapToFile(pBitmap, "windows-defender.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
Sleep 1200

WinClose, Windows Security 

sleep 300 
FileMove, windows-defender.png, %outdir%
}
software() {
; will open installed programs and take screenshots 
; need to tidy this up so it is a bit smarter at getting screenshots
sleep 300

; close if already open just to keep things fresh
WinActivate, Programs and Features   
WinClose, Programs and Features 
sleep 300

IfWinNotExist, Programs and Features
    Run, rundll32.exe shell32.dll`,Control_RunDLL appwiz.cpl

WinWait, Programs and Features
WinActivate, Programs and Features   
WinMaximize
sleep 600

pToken := Gdip_Startup()
WinGet, hwnd, ID, Programs and Features
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "installed-programs.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
sleep 2400


sleep 600
send, {WheelDown 15}

pToken := Gdip_Startup()
WinGet, hwnd, ID, Programs and Features
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "installed-programs2.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
sleep 2400


sleep 600
send, {WheelDown 15}

pToken := Gdip_Startup()
WinGet, hwnd, ID, Programs and Features
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "installed-programs3.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
sleep 2400


sleep 600
send, {WheelDown 15}

pToken := Gdip_Startup()
WinGet, hwnd, ID, Programs and Features
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "installed-programs4.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
sleep 2400


sleep 600
send, {WheelDown 15}

pToken := Gdip_Startup()
WinGet, hwnd, ID, Programs and Features
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "installed-programs5.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
sleep 2100
sleep 2100

FileMove, installed-progra*.png, %outdir%
WinClose, Programs and Features 
sleep 300   
}
eventlogs() {
; clean up 
WinActivate, Log Properties 
WinClose, Log Properties 
sleep 300
WinActivate, Event Viewer 
WinClose, Event Viewer 
sleep 300

; start fresh
IfWinNotExist, Event Viewer
    Run, eventvwr

WinWait, Event Viewer  
WinActivate, Event Viewer  

sleep 600  
send {down}
send {down}
send {down}
send {up}
send {up}
send {up}
send {up}
send {down}
send {down}
send {right}
send {down}


sleep 300
send !a
sleep 300
send {p}
WinWait, Log Properties 
WinActivate, Log Properties  

; Application

sleep 600
pToken := Gdip_Startup()
WinGet, hwnd, ID, Log Properties 
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "eventvwr_application.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)

sleep 300   
WinClose, Log Properties 
WinActivate, Event Viewer  

sleep 300   
send {down}
send !a
sleep 600
send {p}
WinWait, Log Properties 
WinActivate, Log Properties  

; Security


sleep 600
pToken := Gdip_Startup()
WinGet, hwnd, ID, Log Properties 
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "eventvwr_security.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)

sleep 300   
WinClose, Log Properties 
WinActivate, Event Viewer 
sleep 300

send {down}
send {down}
send !a
sleep 600
send {p}
WinWait, Log Properties 
WinActivate, Log Properties  

; System

sleep 600
pToken := Gdip_Startup()
WinGet, hwnd, ID, Log Properties 
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "eventvwr_system.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)

sleep 300   
WinClose, Log Properties 
WinActivate, Event Viewer 
WinClose, Event Viewer 
sleep 300

sleep 600
FileMove, eventvwr_*.png, %outdir%
}
uac() {
; close if aready open just for freshness
WinActivate, User Account Control Settings  
WinClose, User Account Control Settings 

IfWinNotExist, User Account Control Settings 
    Run, UserAccountControlSettings.exe

WinWait, User Account Control Settings  
WinActivate, User Account Control Settings  

sleep 600 

pToken := Gdip_Startup()
WinGet, hwnd, ID, User Account Control Settings 
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_SaveBitmapToFile(pBitmap, "uac.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
sleep 300 

WinClose, User Account Control Settings 

sleep 600
FileMove, uac.png, %outdir%   
}
internet() {
;need to fix blackscreen and no timeout 
Run, iexplore.exe https://www.exploit-db.com/, ,max

WinActivate
WinGet, hwnd,ID,A  ;get handle of active window 
send {down}
send {tab}
send {space}
send {enter}
Sleep 2400
Sleep 2400
pToken:=Gdip_Startup()
pBitmap:=Gdip_BitmapFromScreen()
Gdip_SaveBitmapToFile(pBitmap, "internet_exploit-db.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
Sleep 1200

Gdip_BitmapFromScreen()

WinClose A
Process, Close, iexplore.exe



sleep 600
FileMove, internet_exploit*.png, %outdir%    
}

systeminfo() {
Run, systeminfo ,max



}










; MAIN 

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

; includes 

#include Gdip_All.ahk

; Varibles

global outdir
outdir=%A_Desktop%\%A_ComputerName%_collect\screenshots
commanddir=%outdir%\commands\
IfNotExist, %outdir%
    FileCreateDir, %outdir%


WinMinimizeAll

secpol()
firewall()
windef()
software()
uac()
internet()
eventlogs()
;systeminfo()











