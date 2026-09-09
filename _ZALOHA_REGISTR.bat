@echo off
title _ZALOHA_REGISTR.bat

REM zalohuje celej systemovej registr expotrem do souboru *.reg a naslednym
REM zapakovani v "RAR" ( asi 10x mensi velikost, uspora mista )
REM pak po sobe uklidi, take maze ve se starsim datumem, vytvorene drive
REM soubor je potreba spustit z Admin prvavama tzn. kliknout na nej pravou mysi
REM a pak vybrat polozku nahore "Spustit jako spravce" ( malej stit u toho, ikona )
 
:check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    goto main
) else (
    echo CHYBA: Spuste skript jako administrator!
    echo kliknete na nej pravou mysi a pak vyberte polozku [Spustit jako spravce]
    pause
    goto end
)

:main
REM vytvori dnesni datum jako paramert 2
set dat=%DATE%
REM echo %dat%
set d=%dat:~0,2%
REM echo %d%
set m=%dat:~3,2%
REM echo %m%
set r=%dat:~6,4%
REM echo %r%
set dnes=%d%%m%%r%
REM echo %dnes%
set file_reg=%dnes%_registr.reg
REM echo %file_reg%
set file_rar=%dnes%_registr.rar
REM echo %file_rar%

REM byl problem v rezimu Admin z nastavenim promenni pomoci prikazu set
REM jako nahradu za retezec "C:\Users\DELL\Documents\zaloha\"
REM tady mapriklad -  set cesta=C:\Users\DELL\Documents\zaloha\
REM a nasledne pak - del %cesta%*_registr.reg
REM dokoce to vypisovalo ze hodnota %cesta% je C:\Windows\system32\ !!!
REM takze toto zde nepouzivat !

del "C:\Users\DELL\Documents\zaloha\*_registr.reg"
del "C:\Users\DELL\Documents\zaloha\*_registr.rar"
REM napred smaze vse stary ( kdyby bylo )

echo probiha export...
regedit /E "C:\Users\DELL\Documents\zaloha\%file_reg%"
REM parametr "/E" bude asi neco jako Export
sleep 1

rar a -m5 "C:\Users\DELL\Documents\zaloha\%file_rar%" "C:\Users\DELL\Documents\zaloha\%file_reg%"
REM parametr a=add ; -m5 = maximalni komprese ( viz. manual )
sleep 1

REM smazani pres navratovy kod, smaze soubor *.reg pouze paklize test souboru *.rar dopadl uspesne
REM otestovano, funguje jak ma
rar t C:\Users\DELL\Documents\zaloha\%file_rar% && del C:\Users\DELL\Documents\zaloha\%file_reg%
pause
:end
