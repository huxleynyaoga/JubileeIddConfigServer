@echo off
REM ========================================================================
REM Jubilee Config Server Startup Script
REM ========================================================================

echo Initializing Jubilee Config Server setup...

REM ========================================================================
REM Security Variables
REM ========================================================================
REM These will be picked up by the ${CONFIG_USER} and ${CONFIG_PWD} placeholders
REM in your application.yml
set CONFIG_USER=jubilee_admin
set CONFIG_PWD=secret123
set ENCRYPTION_KEY=jubilee-key-2024

REM ========================================================================
REM Configuration Variables
REM ========================================================================
REM Ensure the path matches your D:/Jubilee structure
set CONFIG_REPO_PATH=file:///D:/Jubilee/config-server/config-repo/
set SERVER_PORT=8888
set ACTUATOR_ENDPOINTS=health,info,refresh

REM ========================================================================
REM Logging Variables
REM ========================================================================
set ROOT_LOG_LEVEL=INFO
set APP_LOG_LEVEL=DEBUG

REM ========================================================================
REM Print environment setup
REM ========================================================================
echo.
echo ==========================================
echo JUBILEE CONFIG SERVER ENVIRONMENT
echo ==========================================
echo USERNAME:         %CONFIG_USER%
echo REPO PATH:        %CONFIG_REPO_PATH%
echo SERVER PORT:      %SERVER_PORT%
echo LOG LEVEL:        %APP_LOG_LEVEL%
echo ==========================================
echo.

set ENV=%1

if "%ENV%"=="" (
  echo Usage: start-config-server.bat ^<sit^|uat^|prod^>
  exit /b 1
)

echo ==========================================
echo STARTING CONFIG SERVER FOR ENV: %ENV%
echo ==========================================

REM Using 'java' instead of a hardcoded path so it uses your system's default Java
java -jar target/config-server-0.0.1-SNAPSHOT.jar ^
  --spring.profiles.active=native,%ENV% ^
  --spring.security.user.name=%CONFIG_USER% ^
  --spring.security.user.password=%CONFIG_PWD% ^
  --encrypt.key=%ENCRYPTION_KEY% ^
  --spring.cloud.config.server.native.searchLocations=%CONFIG_REPO_PATH% ^
  --server.port=%SERVER_PORT% ^
  --logging.level.root=%ROOT_LOG_LEVEL% ^
  --logging.level.com.jubilee=%APP_LOG_LEVEL%

echo.
echo Config Server has been shut down.
pause