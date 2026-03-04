# Dayflow HRMS Setup Script for Windows PowerShell

Write-Host "Dayflow HRMS Setup Script" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan
Write-Host ""

# Check if Node.js is installed
Write-Host "Checking Node.js installation..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version
    Write-Host "Node.js version: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "Node.js is not installed. Please install Node.js first." -ForegroundColor Red
    exit 1
}

# Setup Backend
Write-Host ""
Write-Host "Setting up Backend..." -ForegroundColor Yellow
Set-Location backend

# Create .env file if it doesn't exist
if (-not (Test-Path .env)) {
    Write-Host "Creating .env file..." -ForegroundColor Yellow
    @"
PORT=5000
MONGODB_URI=mongodb://localhost:27017/dayflow
JWT_SECRET=your_jwt_secret_key_here_change_in_production
NODE_ENV=development
"@ | Out-File -FilePath .env -Encoding utf8
    Write-Host ".env file created. Please update JWT_SECRET for production!" -ForegroundColor Yellow
}

# Create uploads directory
if (-not (Test-Path uploads)) {
    New-Item -ItemType Directory -Path uploads | Out-Null
    Write-Host "Created uploads directory" -ForegroundColor Green
}

# Install backend dependencies
Write-Host "Installing backend dependencies..." -ForegroundColor Yellow
npm install
Write-Host "Backend setup complete!" -ForegroundColor Green

# Setup Frontend
Write-Host ""
Write-Host "Setting up Frontend..." -ForegroundColor Yellow
Set-Location ..\frontend

# Create .env file if it doesn't exist
if (-not (Test-Path .env)) {
    Write-Host "Creating .env file..." -ForegroundColor Yellow
    @"
REACT_APP_API_URL=http://localhost:5000/api
"@ | Out-File -FilePath .env -Encoding utf8
}

# Install frontend dependencies
Write-Host "Installing frontend dependencies..." -ForegroundColor Yellow
npm install
Write-Host "Frontend setup complete!" -ForegroundColor Green

Set-Location ..

Write-Host ""
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Make sure MongoDB is running" -ForegroundColor White
Write-Host "2. Start backend: cd backend && npm start" -ForegroundColor White
Write-Host "3. Start frontend: cd frontend && npm start" -ForegroundColor White
Write-Host "4. Open http://localhost:3000 in your browser" -ForegroundColor White
Write-Host ""

