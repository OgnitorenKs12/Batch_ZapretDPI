:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
::
::       ██████   ██████   ██    ██ ████ ████████  ██████  ████████  ████████ ██    ██ ██    ██  ██████
::      ██    ██ ██    ██  ███   ██  ██     ██    ██    ██ ██     ██ ██       ███   ██ ██   ██  ██    █
::      ██    ██ ██        ████  ██  ██     ██    ██    ██ ██     ██ ██       ████  ██ ██  ██   ██     
::      ██    ██ ██   ████ ██ ██ ██  ██     ██    ██    ██ ████████  ██████   ██ ██ ██ █████      ██████
::      ██    ██ ██    ██  ██  ████  ██     ██    ██    ██ ██   ██   ██       ██  ████ ██  ██         ██
::      ██    ██ ██    ██  ██   ███  ██     ██    ██    ██ ██    ██  ██       ██   ███ ██   ██  ██    ██
::       ██████   ██████   ██    ██ ████    ██     ██████  ██     ██ ████████ ██    ██ ██    ██  ██████ 
::
::  ► Hazırlayan: Hüseyin UZUNYAYLA / OgnitorenKs
::
::  ► İletişim - Contact;
::  --------------------------------------
::  •    Mail: ognitorenks@gmail.com
::  •    Site: https://ognitorenks.blogspot.com
::
:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
echo off
chcp 65001
setlocal enabledelayedexpansion
cls
title ZapretDPI_v5.4 │ OgnitorenKs
mode con cols=80 lines=22

REM -------------------------------------------------------------
REM Renklendirm için gerekli
FOR /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E#&for %%b in (1) do rem"') do (set R=%%b)

REM -------------------------------------------------------------
REM Konum
cd /d "%~dp0"
FOR /F "tokens=*" %%a in ('cd') do (set Konum=%%a)
set Program=%~f0

REM -------------------------------------------------------------
REM Yönetici yetkisi
reg query "HKU\S-1-5-19" > NUL 2>&1
    if !errorlevel! NEQ 0 (Call :Powershell "Start-Process '!Program!' -Verb Runas"&exit)

REM -------------------------------------------------------------
Call :Dil A 2 Language_Admin_1_&echo  %R%[93m► !LA2!%R%[0m
echo.
Call :Dil A 2 Language_Admin_2_&echo  %R%[93m► !LA2!%R%[0m
REM -------------------------------------------------------------
REM Sistem dil kontrolü
set Dil=EN
FOR /F "tokens=6" %%a in ('Dism /Online /Get-intl ^| Find /I "Default system UI language"') do (
    if "%%a" EQU "tr-TR" (set Dil=TR)
)

REM -------------------------------------------------------------
REM Mimari kontrolü
set Arch=x86
FOR /F "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "PROCESSOR_ARCHITECTURE" 2^>NUL') do (
    if "%%a" EQU "AMD64" (set Arch=x86_64)
    if "%%a" EQU "IA64" (set Arch=x86_64)
)

REM -------------------------------------------------------------
REM Klasör yolunda Türkçe karakter kontrolü yapar
FOR %%a in (Ö ö Ü ü Ğ ğ Ş ş Ç ç ı İ) do (
    echo !Program! | Find "%%a" > NUL 2>&1
        if !errorlevel! EQU 0 (cls&Call :Dil A 2 Language_Error_!Dil!_1_&echo.&echo %R%[31m !LA2! %R%[0m&Call :Bekle 7&exit)
)
REM Klasör yolunda boşluk olup olmadığını kontrol eder
if "!Program!" NEQ "!Program: =!" (cls&Call :Dil A 2 Language_Error_!Dil!_2_&echo.&echo %R%[31m !LA2! %R%[0m&Call :Bekle 7&exit)

REM -------------------------------------------------------------
:Menu_Rota
REM Hizmetin yüklü olup olmadığını kontrol eder
set Durum_2=
set Menu_Rota=NT
reg query "HKLM\SYSTEM\CurrentControlSet\Services\ZapretDPI" /v "Start" > NUL 2>&1
    if !errorlevel! EQU 0 (FOR /F "skip=2 delims=x tokens=2" %%b in ('reg query "HKLM\System\CurrentControlSet\Services\ZapretDPI" /v "Start" 2^>NUL') do (
                               if %%b NEQ 2 (Call :Dil A 2 Language_!Dil!_1_&set Durum_2=%R%[91m!LA2!)
                               if %%b EQU 2 (Call :Dil A 2 Language_!Dil!_2_&set Durum_2=%R%[92m!LA2!)
                          ))
    if !errorlevel! NEQ 0 (Call :Dil A 2 Language_!Dil!_3_&set Durum_2=%R%[91m!LA2!&set Menu_Rota=1)
REM Hizmetin çalışıp çalışmadığını kontrol eder
set Durum=
chcp 437 > NUL 2>&1
FOR /F "tokens=3" %%z in ('Powershell -C "Get-Service ZapretDPI | Select-Object Status | FL"') do (set Status=%%z)
chcp 65001 > NUL 2>&1
    if "!Status!" EQU "Stopped" (Call :Dil A 2 Language_!Dil!_4_&set Durum=%R%[91m!LA2!)
    if "!Status!" EQU "Running" (Call :Dil A 2 Language_!Dil!_5_&set Durum=%R%[92m!LA2!)
REM Menu üst bölüm
cls
Call :Dil A 2 Language_Menu_!Dil!_1_
Call :Dil B 2 Language_Menu_!Dil!_2_
Call :Dil C 2 Language_Menu_!Dil!_3_
echo  %R%[90m---------------------------------------------------------------------%R%[0m
echo  %R%[90m► !LA2! = !Durum! %R%[0m
echo  %R%[90m► !LB2! = !Durum_2! %R%[0m
echo  %R%[90m---------------------------------------------------------------------%R%[0m
echo  %R%[36m ▼ !LC2! ▼ %R%[0m
set LA2=
set LB2=
set LC2=
REM -------------------------------------------------------------
if "!Menu_Rota!" EQU "1" (goto Menu_1)
if "!Menu_Rota!" EQU "NT" (goto Menu_2)
REM -------------------------------------------------------------
:Menu_1
Call :Dil A 3 Language_Menu_!Dil!_4_&Call :Dil A 2 Language_Menu_!Dil!_4_&echo  %R%[32m 1%R%[90m-%R%[33m !LA2!%R%[90m [!LA3!]%R%[0m
Call :Dil A 2 Language_Sabit_!Dil!_1_&set /p Menu=%R%[32m  ► !LA2! %R%[90m= %R%[0m
echo.
if !Menu! EQU 1 (Call :DNS_Menu
                 net stop "ZapretDPI" > NUL 2>&1
                 sc delete "ZapretDPI" > NUL 2>&1
				 "%Konum%\Bin\!Arch!\ogni_hosts.exe" install
				 "%Konum%\Bin\!Arch!\nssm.exe" install ZapretDPI "%Konum%\Bin\!Arch!\winws.exe" > NUL 2>&1
				 "%Konum%\Bin\!Arch!\nssm.exe" set ZapretDPI AppDirectory "%Konum%\Bin\!Arch!" > NUL 2>&1
				 REM "%Konum%\Bin\!Arch!\nssm.exe" set ZapretDPI AppParameters --wf-tcp=80,443 --filter-tcp=80,443 --hostlist="%Konum%\Bin\!Arch!\cutoff.txt" --dpi-desync=split --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-cutoff=d3 --new --filter-tcp=80,443 --dpi-desync=split --dpi-desync-ttl=3 --dpi-desync-fooling=md5sig --dpi-desync-cutoff=d5 > NUL 2>&1
				 "%Konum%\Bin\!Arch!\nssm.exe" set ZapretDPI AppParameters --wf-tcp=80,443 --filter-tcp=80,443 --hostlist="%Konum%\Bin\!Arch!\cutoff.txt" --dpi-desync=split --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-cutoff=d3 --new --filter-tcp=80,443 --dpi-desync=fake --dpi-desync-ttl=3 --dpi-desync-fooling=md5sig --dpi-desync-cutoff=d5 > NUL 2>&1
				 "%Konum%\Bin\!Arch!\nssm.exe" set ZapretDPI DisplayName "Zapret DPI Bypass Service" > NUL 2>&1
				 "%Konum%\Bin\!Arch!\nssm.exe" set ZapretDPI Description "Advanced DPI bypass tool for OgnitorenKs" > NUL 2>&1
				 "%Konum%\Bin\!Arch!\nssm.exe" set Start SERVICE_AUTO_START > NUL 2>&1
				 "%Konum%\Bin\!Arch!\nssm.exe" start ZapretDPI > NUL 2>&1
				 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /f /v "DoHPolicy" /t REG_DWORD /d 2 > NUL 2>&1
                 Call :Dil A 2 Language_Sabit_!Dil!_2_&sc description "ZapretDPI" "!LA2!" > NUL 2>&1
                 Call :DNS_Cache_Clear
                 net start "ZapretDPI" > NUL 2>&1
                 Call :Dil A 2 Language_Sabit_!Dil!_3_&Call :For_Print %R%[92m  ▼ !LA2! ▼%R%[0m
                 Call :Bekle 2
                )
cls
goto Menu_Rota

REM -------------------------------------------------------------
:Menu_2
Call :Dil A 2 Language_Menu_!Dil!_5_&echo  %R%[32m 1%R%[90m-%R%[33m !LA2!%R%[0m
Call :Dil A 2 Language_Menu_!Dil!_6_&echo  %R%[32m 2%R%[90m-%R%[33m !LA2!%R%[0m
Call :Dil A 2 Language_Menu_!Dil!_7_&echo  %R%[32m 3%R%[90m-%R%[33m !LA2!%R%[0m
Call :Dil A 2 Language_Menu_!Dil!_8_&echo  %R%[32m 4%R%[90m-%R%[33m !LA2!%R%[0m
Call :Dil A 2 Language_Sabit_!Dil!_1_&set /p Menu=%R%[32m  ► !LA2! %R%[90m= %R%[0m
echo.
Call :Dil A 2 Language_Sabit_!Dil!_9_&echo  %R%[32m !LA2!%R%[0m
    if !Menu! EQU 1 (sc config ZapretDPI start= auto > NUL 2>&1
                     net start ZapretDPI > NUL 2>&1
                     Call :DNS_Cache_Clear
                     Call :Dil A 2 Language_Sabit_!Dil!_4_&Call :For_Print %R%[92m  ▼ !LA2! ▼%R%[0m
                     Call :Bekle 2
                    )
    if !Menu! EQU 2 (net stop ZapretDPI > NUL 2>&1
                     Call :Dil A 2 Language_Sabit_!Dil!_5_&Call :For_Print %R%[92m  ▼ !LA2! ▼%R%[0m
                     Call :Bekle 2
                    )
    if !Menu! EQU 3 (net stop ZapretDPI > NUL 2>&1
                     sc config ZapretDPI start= disabled > NUL 2>&1
                     Call :Dil A 2 Language_Sabit_!Dil!_6_&Call :For_Print %R%[92m  ▼ !LA2! ▼%R%[0m
                     Call :Bekle 2
                    )
    if !Menu! EQU 4 (net stop "ZapretDPI" > NUL 2>&1
                     sc delete "ZapretDPI" > NUL 2>&1
                     Call :Powershell "Set-DnsClientServerAddress -InterfaceAlias 'Ethernet' -ResetServerAddresses" > NUL 2>&1
                     Call :Powershell "Set-DnsClientServerAddress -InterfaceAlias 'Wi-fi' -ResetServerAddresses" > NUL 2>&1
					 "%Konum%\Bin\!Arch!\ogni_hosts.exe" uninstall
                     Call :DNS_Cache_Clear
                     Call :Dil A 2 Language_Sabit_!Dil!_7_&Call :For_Print %R%[92m  ▼ !LA2! ▼%R%[0m
                     Call :Bekle 2
                    )
cls
goto Menu_Rota

REM -------------------------------------------------------------
:Powershell
REM chcp 65001 kullanıldığında Powershell komutları ekranı kompakt görünüme sokuyor. Bunu önlemek için bu bölümde uygun geçişi sağlıyorum.
chcp 437 > NUL 2>&1
Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -C %*
chcp 65001 > NUL 2>&1
goto :eof

REM -------------------------------------------------------------
:For_Print
echo %*
goto :eof

REM -------------------------------------------------------------
:DNS_Menu
Call :Dil A 2 Language_Sabit_!Dil!_8_
echo  %R%[36m ▼ !LA2! ▼%R%[0m
echo  %R%[32m 1%R%[90m-%R%[33m Claudflare %R%[90m1.1.1.1%R%[0m
echo  %R%[32m 2%R%[90m-%R%[33m Google %R%[90m8.8.8.8%R%[0m
Call :Dil A 2 Language_Sabit_!Dil!_1_&set /p DNS_Value=%R%[32m  ► !LA2! %R%[90m= %R%[0m
REM Claudflare varsayılan olarak ayarlıyorum. Farklı seçimde ayarlama yapılır.
Call :Dil A 2 Language_Sabit_!Dil!_10_&echo  %R%[32m !LA2!%R%[0m
Call :DNS_1
    if "!DNS_Value!" EQU "2" (Call :DNS_2)
set DNS_Value=
goto :eof

REM -------------------------------------------------------------
:DNS_1
Call :Powershell "Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | Set-DnsClientServerAddress -ServerAddresses '1.1.1.1','1.0.0.1'"
Call :Powershell "Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | Set-DnsClientServerAddress -ServerAddresses '2606:4700:4700::1111','2606:4700:4700::1001'"
goto :eof

REM -------------------------------------------------------------
:DNS_2
Call :Powershell "Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | Set-DnsClientServerAddress -ServerAddresses '8.8.8.8','8.8.4.4'"
Call :Powershell "Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | Set-DnsClientServerAddress -ServerAddresses '2001:4860:4860::8888','2001:4860:4860::8844'"
goto :eof

REM -------------------------------------------------------------
:DNS_Cache_Clear
ipconfig /flushdns > NUL 2>&1
ipconfig /release > NUL 2>&1
ipconfig /renew > NUL 2>&1
goto :eof

REM -------------------------------------------------------------
:Bekle
REM Timeout beklemeleri için
timeout /t %~1 /nobreak > NUL
goto :eof

REM -------------------------------------------------------------
:Dil
REM Dil verilerini buradan alıyorum. Call komutu ile buraya uygun değerleri gönderiyorum.
REM %~1= Harf │ %~2= tokens değeri │ %~3= Find değeri
set L%~1%~2=
FOR /F "delims=> tokens=%~2" %%g in ('Findstr /i "%~3" !Program! 2^>NUL') do (set L%~1%~2=%%g)
goto :eof

REM -------------------------------------------------------------
Language_Admin_1_>OgnitorenKs>
Language_Admin_2_>ZapretDPI>
:Turkish
Language_Menu_TR_1_>ZapretDPI çalışıyor mu?>
Language_Menu_TR_2_>ZapretDPI hizmeti durumu>
Language_Menu_TR_3_>ZapretDPI İşlem Menüsü>
Language_Menu_TR_4_>Hizmet kurulumunu yap>Tüm ağ bağlantısına>Uygulama ve Domain bazlı>Tavsiye edilen>
Language_Menu_TR_5_>Çalıştır>
Language_Menu_TR_6_>Durdur>
Language_Menu_TR_7_>Devre dışı bırak>
Language_Menu_TR_8_>Kaldır>
Language_TR_1_>DEVRE DIŞI>
Language_TR_2_>AKTIF>
Language_TR_3_>HİZMET BULUNAMADI, KURULUM GEREKİYOR>
Language_TR_4_>PASIF/ÇALIŞMIYOR>
Language_TR_5_>AKTIF/ÇALIŞIYOR>
Language_Error_TR_1_>Klasör yolunda Türkçe karakter bulunuyor>
Language_Error_TR_2_>Klasör yolunda boşluk bulunuyor>
Language_Sabit_TR_1_>İşlem>
Language_Sabit_TR_2_>DNS zorlamasini kaldirir>
Language_Sabit_TR_3_>ZapretDPI hizmet kurulumu yapıldı>
Language_Sabit_TR_4_>ZapretDPI çalıştırıldı>
Language_Sabit_TR_5_>ZapretDPI durduruldu>
Language_Sabit_TR_6_>ZapretDPI devre dışı bırakıldı>
Language_Sabit_TR_7_>ZapretDPI hizmeti kaldırıldı>
Language_Sabit_TR_8_>DNS adresi seçin>
Language_Sabit_TR_9_>Lütfen bekleyin, seçtiğiniz işlem uygulanıyor...>
Language_Sabit_TR_10_>Lütfen bekleyin, kurulum işlemi yapılıyor...>

:English
Language_Menu_EN_1_>ZapretDPI, does it work?>
Language_Menu_EN_2_>ZapretDPI service status>
Language_Menu_EN_3_>ZapretDPI Operation Menu>
Language_Menu_EN_4_>Set up the service>For the entire network connection>Application and Domain based>Recommended>
Language_Menu_EN_5_>Run>
Language_Menu_EN_6_>Stop>
Language_Menu_EN_7_>Disable>
Language_Menu_EN_8_>Remove>
Language_EN_1_>DISABLED>
Language_EN_2_>ACTIVE>
Language_EN_3_>NO SERVICE FOUND, INSTALLATION REQUIRED>
Language_EN_4_>INACTIVE/NOT WORKING>
Language_EN_5_>ACTIVE/WORKING>
Language_Error_EN_1_>Turkish characters in folder path>
Language_Error_EN_2_>There is a gap in the folder path>
Language_Sabit_EN_1_>Process>
Language_Sabit_EN_2_>Removes DNS enforcement>
Language_Sabit_EN_3_>ZapretDPI service setup>
Language_Sabit_EN_4_>ZapretDPI executed>
Language_Sabit_EN_5_>ZapretDPI has been discontinued>
Language_Sabit_EN_6_>ZapretDPI is disabled>
Language_Sabit_EN_7_>ZapretDPI service removed>
Language_Sabit_EN_8_>Select DNS address>
Language_Sabit_EN_9_>Please wait, your selected action is being implemented...>
Language_Sabit_EN_10_>Please wait, the installation process is in progress...>
