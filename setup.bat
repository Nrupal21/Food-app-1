@echo off
REM Food Ordering System - Windows Setup Script
REM This script automates the entire setup process for Windows users
REM Author: Food Ordering System Team
REM Version: 1.0
REM Date: December 2025

echo.
echo ========================================
echo   Food Ordering System Setup Wizard
echo ========================================
echo.
echo This script will set up the complete Food Ordering System
echo on your Windows machine.
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not in PATH!
    echo Please install Python 3.8 or higher from https://python.org
    echo Make sure to check "Add Python to PATH" during installation
    pause
    exit /b 1
)

REM Check Python version
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo [INFO] Found Python %PYTHON_VERSION%

REM Check if pip is working
pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] pip is not working!
    echo Please ensure pip is installed and in PATH
    pause
    exit /b 1
)

echo.
echo Step 1: Creating virtual environment...
echo.

REM Check if venv already exists
if exist "venv" (
    echo [WARN] Virtual environment 'venv' already exists.
    set /p DELETE_VENV="Do you want to delete it and create a new one? (y/n): "
    if /i "%DELETE_VENv%"=="y" (
        echo [INFO] Deleting existing virtual environment...
        rmdir /s /q venv
    ) else (
        echo [INFO] Using existing virtual environment.
        goto ACTIVATE_VENV
    )
)

REM Create virtual environment
python -m venv venv
if %errorlevel% neq 0 (
    echo [ERROR] Failed to create virtual environment!
    pause
    exit /b 1
)
echo [SUCCESS] Virtual environment created successfully.

:ACTIVATE_VENV
echo.
echo Step 2: Activating virtual environment...
echo.

REM Activate virtual environment
call venv\Scripts\activate.bat
if %errorlevel% neq 0 (
    echo [ERROR] Failed to activate virtual environment!
    pause
    exit /b 1
)
echo [SUCCESS] Virtual environment activated.

echo.
echo Step 3: Upgrading pip and installing wheel...
echo.

REM Upgrade pip
python -m pip install --upgrade pip
if %errorlevel% neq 0 (
    echo [WARN] Failed to upgrade pip, continuing anyway...
)

REM Install wheel for faster package installation
pip install wheel
if %errorlevel% neq 0 (
    echo [WARN] Failed to install wheel, continuing anyway...
)

echo.
echo Step 4: Installing project dependencies...
echo This may take several minutes depending on your internet connection.
echo.

REM Install requirements
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies!
    echo Please check your internet connection and try again.
    pause
    exit /b 1
)
echo [SUCCESS] All dependencies installed successfully.

echo.
echo Step 5: Setting up environment variables...
echo.

REM Check if .env file exists
if exist ".env" (
    echo [WARN] .env file already exists.
    set /p OVERWRITE_ENV="Do you want to overwrite it? (y/n): "
    if /i "%OVERWRITE_ENV%"=="y" (
        goto CREATE_ENV
    ) else (
        echo [INFO] Using existing .env file.
        goto DATABASE_SETUP
    )
)

:CREATE_ENV
REM Copy .env.example to .env
if exist ".env.example" (
    copy .env.example .env >nul
    echo [SUCCESS] .env file created from template.
    echo.
    echo [IMPORTANT] Please edit the .env file with your settings:
    echo   - Database credentials
    echo   - Email configuration
    echo   - Payment gateway keys
    echo   - Secret key
    echo.
    pause
) else (
    echo [WARN] .env.example not found. Creating basic .env file...
    echo DEBUG=True > .env
    echo SECRET_KEY=your-secret-key-here >> .env
    echo DB_NAME=food_ordering_db >> .env
    echo DB_USER=postgres >> .env
    echo DB_PASSWORD=your_password >> .env
    echo DB_HOST=localhost >> .env
    echo DB_PORT=5432 >> .env
    echo [INFO] Basic .env file created. Please update with your settings.
)

:DATABASE_SETUP
echo.
echo Step 6: Database setup...
echo.

REM Ask if PostgreSQL is installed
echo [QUESTION] Is PostgreSQL installed on this machine? (y/n)
set /p POSTGRES_INSTALLED=
if /i "%POSTGRES_INSTALLED%"=="n" (
    echo.
    echo Please install PostgreSQL from https://postgresql.org/download/windows/
    echo After installation, run this script again.
    echo.
    pause
    exit /b 0
)

REM Ask for database name
set /p DB_NAME="Enter database name (default: food_ordering_db): "
if "%DB_NAME%"=="" set DB_NAME=food_ordering_db

REM Ask to create database
echo.
echo [QUESTION] Do you want to create the database '%DB_NAME%'? (y/n)
set /p CREATE_DB=
if /i "%CREATE_DB%"=="y" (
    echo [INFO] Creating database...
    createdb %DB_NAME% 2>nul
    if %errorlevel% neq 0 (
        echo [WARN] Could not create database automatically.
        echo Please create it manually using: createdb %DB_NAME%
    ) else (
        echo [SUCCESS] Database created successfully.
    )
)

echo.
echo Step 7: Running Django migrations...
echo.

REM Run migrations
python manage.py makemigrations
if %errorlevel% neq 0 (
    echo [ERROR] Failed to create migrations!
    pause
    exit /b 1
)

python manage.py migrate
if %errorlevel% neq 0 (
    echo [ERROR] Failed to run migrations!
    echo Please check your database configuration in .env file.
    pause
    exit /b 1
)
echo [SUCCESS] Database migrations completed.

echo.
echo Step 8: Creating superuser account...
echo.
echo [INFO] You will be prompted to create an admin account.
echo This will be used to access the Django admin panel.
echo.

REM Create superuser
python manage.py createsuperuser
if %errorlevel% neq 0 (
    echo [WARN] Superuser creation failed or cancelled.
    echo You can create it later with: python manage.py createsuperuser
)

echo.
echo Step 9: Collecting static files...
echo.

REM Collect static files
python manage.py collectstatic --noinput
if %errorlevel% neq 0 (
    echo [WARN] Static files collection had issues.
    echo You can run it manually with: python manage.py collectstatic
) else (
    echo [SUCCESS] Static files collected.
)

echo.
echo Step 10: Loading initial data (optional)...
echo.

REM Check if initial data exists
if exist "initial_data.json" (
    set /p LOAD_DATA="Do you want to load initial data? (y/n): "
    if /i "%LOAD_DATA%"=="y" (
        python manage.py loaddata initial_data.json
        if %errorlevel% neq 0 (
            echo [WARN] Failed to load initial data.
        ) else (
            echo [SUCCESS] Initial data loaded.
        )
    )
) else (
    echo [INFO] No initial data file found.
)

echo.
echo ========================================
echo   Setup Complete!
echo ========================================
echo.
echo [SUCCESS] Food Ordering System has been set up successfully!
echo.
echo Next steps:
echo 1. Review and update .env file with your settings
echo 2. Start the development server:
echo    python manage.py runserver
echo 3. Open your browser and go to:
echo    http://127.0.0.1:8000/
echo 4. Access admin panel at:
echo    http://127.0.0.1:8000/admin/
echo.
echo For deployment instructions, see:
echo - INSTALLATION_DEPLOYMENT_GUIDE.md
echo - PROJECT_TRANSFER_GUIDE.md
echo.
echo Need help? Check the docs/ folder or create an issue on GitHub.
echo.

REM Ask if user wants to start server
echo.
set /p START_SERVER="Do you want to start the development server now? (y/n): "
if /i "%START_SERVER%"=="y" (
    echo.
    echo Starting Django development server...
    echo Press Ctrl+C to stop the server.
    echo.
    python manage.py runserver
) else (
    echo.
    echo To start the server later, run:
    echo   1. Activate virtual environment: venv\Scripts\activate
    echo   2. Start server: python manage.py runserver
    echo.
)

pause
