@echo off
echo Installing prerequisites for CodeFire API...

REM Check if .NET SDK is installed
dotnet --version > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo .NET SDK is not installed. Please install .NET 8.0 SDK from https://dotnet.microsoft.com/download
    exit /b 1
)

echo .NET SDK is installed.

REM Check if PostgreSQL is installed (by checking if psql is in the path)
where psql > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo PostgreSQL is not installed. Please install PostgreSQL from https://www.postgresql.org/download/windows/
    echo After installing, make sure to create a database named 'codefire'
    exit /b 1
)

echo PostgreSQL is installed.

REM Install EF Core tools if not already installed
dotnet tool install --global dotnet-ef > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Updating EF Core tools...
    dotnet tool update --global dotnet-ef
) else (
    echo EF Core tools are installed.
)

REM Restore dependencies
echo Restoring dependencies...
dotnet restore

REM Ask for PostgreSQL credentials and update appsettings.json
echo Please provide your PostgreSQL credentials:
echo For local development, you can use the default username (postgres) without a password
echo by pressing Enter for both prompts.
set /p PGUSER="Username (default: postgres): "
set /p PGPASS="Password (leave empty for no password): "

if "%PGUSER%"=="" set PGUSER=postgres

REM Create a backup of the original appsettings.json
copy CodeFire.API\appsettings.json CodeFire.API\appsettings.json.bak

REM Update the connection string in appsettings.json
if "%PGPASS%"=="" (
    powershell -Command "(Get-Content CodeFire.API\appsettings.json) -replace 'Host=localhost;Database=codefire;Username=postgres;Password=yourpassword', 'Host=localhost;Database=codefire;Username=%PGUSER%' | Set-Content CodeFire.API\appsettings.json"
) else (
    powershell -Command "(Get-Content CodeFire.API\appsettings.json) -replace 'Host=localhost;Database=codefire;Username=postgres;Password=yourpassword', 'Host=localhost;Database=codefire;Username=%PGUSER%;Password=%PGPASS%' | Set-Content CodeFire.API\appsettings.json"
)

echo Connection string updated in appsettings.json

REM Run database migrations
echo Running database migrations...
dotnet ef database update --project CodeFire.API

if %ERRORLEVEL% NEQ 0 (
    echo Failed to run migrations. Please check your PostgreSQL connection and try again.
    exit /b 1
)

echo Setup completed successfully!
echo You can now run the API using: dotnet run --project CodeFire.API 