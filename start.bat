@echo off
echo ==========================================
echo   SupportGenie Voice AI - Startup Script
echo ==========================================
echo.

REM Start Backend
echo [1/2] Starting Backend (FastAPI on port 8000)...
start "SupportGenie Backend" cmd /k "cd /d "%~dp0backend" && python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload"

REM Wait a moment for backend to start
timeout /t 3 /nobreak > nul

REM Start Frontend
echo [2/2] Starting Frontend (Vite on port 5173)...
start "SupportGenie Frontend" cmd /k "cd /d "%~dp0frontend" && npm run dev"

echo.
echo ==========================================
echo   Both servers starting...
echo   Backend:  http://localhost:8000
echo   Frontend: http://localhost:5173
echo   API Docs: http://localhost:8000/docs
echo ==========================================
echo.
echo Press any key to open the app in your browser...
pause > nul
start http://localhost:5173
