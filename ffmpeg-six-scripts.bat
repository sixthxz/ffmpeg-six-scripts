@echo off
cls

:menu
echo ============================
echo      FFMPEG SIX's MENU
echo ============================
echo  [1] Convertir Video
echo  [2] Cortar Video
echo  [3] Salir
echo ============================
set /p choice="Selecciona una opcion: "

if "%choice%"=="1" goto convertir
if "%choice%"=="2" goto cortar
if "%choice%"=="3" exit


:convertir
cls
echo Convertir Video.
call :nombre_archivo
call :seleccionar_extension
call :ruta_archivo
set n=1
D:
cd /D D:\%username%\Documents\TouchDesign\converter\bin
echo Ingresa la resolucion, default es 2160:-2, el aspect ratio es width:height (ancho:alto), usa -2 para mantener el aspect ratio actual. 
set /p cScale="Ingresa la resolucion, default es 2160:-2: "

if "%cScale%"=="" set cScale=2160:-2

if not exist "D:\%username%\Documents\TouchDesign\Video Output\%cFolder%\%cFile%-convert-%n%.mp4" (
    ffmpeg -i "D:\%username%\Documents\TouchDesign\Video Output\%cFolder%\%cFile%%ext%" -vf scale=%cScale% -vcodec libx264 -crf 20 "D:\%username%\Documents\TouchDesign\Video Output\%cFolder%\%cFile%-convert-%n%.mp4"
    echo Video convertido exitosamente.
    timeout /t 5 >nul
    goto menu
) else (
    set /a n+=1
    goto convertir
)

:cortar

call :nombre_archivo
call :seleccionar_extension
call :ruta_archivo

echo Inicio del corte (formato hh:mm:ss): 
set /p startTime="Ingresa el tiempo de inicio: "
echo Fin del corte (formato hh:mm:ss): 
set /p endTime="Ingresa el tiempo de finalizacion: "
set n=1

D:
cd /D D:\%username%\Documents\TouchDesign\converter\bin

if not exist "D:\%username%\Documents\TouchDesign\Video Output\%cFolder%\%cFile%-Trim-%n%%ext%" (
    ffmpeg -ss %startTime% -to %endTime% -i "D:\%username%\Documents\TouchDesign\Video Output\%cFolder%\%cFile%%ext%" -c copy "D:\%username%\Documents\TouchDesign\Video Output\%cFolder%\%cFile%-Trim-%n%%ext%"
    echo Video cortado exitosamente.
    timeout /t 5 >nul
    goto menu
) else (
    set /a n+=1
    goto cortar
)

:nombre_archivo
echo Nombre del archivo:
set /p cFile="Ingresa el nombre de tu archivo: "
goto :eof

:ruta_archivo
echo Ruta del archivo %cFile%%ext%:
set /p cFolder="Ingresa el numero de carpeta donde esta tu archivo: "
goto :eof

:seleccionar_extension
cls
echo ============================
echo   SELECCIONA LA EXTENSION
echo ============================
echo  [1] .mov
echo  [2] .mp4
echo ============================
set /p extChoice="Selecciona una extension: "

if "%extChoice%"=="1" (
    set ext=.mov
) else if "%extChoice%"=="2" (
    set ext=.mp4
) else (
    echo Opcion invalida. Selecciona 1 para .mov o 2 para .mp4.
    timeout /t 2 >nul
    goto seleccionar_extension
)
cls
echo Has seleccionado la extension %ext%.
goto :eof
