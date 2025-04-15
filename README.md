# CodeFire API

A C# ASP.NET Core Web API project with PostgreSQL and Swagger integration.

## Prerequisites

- .NET 8.0 SDK or later
- PostgreSQL installed and running
- Your favorite IDE (Visual Studio, VS Code, or Rider)

## Quick Setup

### Windows
1. Run the setup script from the root directory:
```
.\scripts\setup-windows.bat
```

### macOS
1. Run the setup script from the root directory:
```
./scripts/setup-mac.sh
```

### PostgreSQL Configuration
When prompted during setup:
- Use the default username (`postgres`) by pressing Enter
- For local development, you can leave the password empty if your PostgreSQL is configured to allow password-less connections
- Otherwise, enter the password you set during PostgreSQL installation

## Starting the Server
Once the setup is complete, start the server using:
```
dotnet run --project CodeFire.API
```
You'll be able to access swagger via http://localhost:5175/swagger/index.html

## Manual Installation

If you prefer to set up manually, follow these steps:

1. Clone the repository:
```bash
git clone https://github.com/yourusername/codefire_csharp_backend.git
cd codefire_csharp_backend
```

2. Update the database connection string in CodeFire.API/appsettings.json:
```json
"ConnectionStrings": {
  "DefaultConnection": "Host=localhost;Database=codefire;Username=postgres;Password=yourpassword"
}
```

3. Install dependencies:
```
dotnet restore
```

4. Run database migrations:
```
dotnet ef database update
```

## Running the Application

### Using Visual Studio:
- Open the solution file CodeFire.API.sln
- Press F5 or click the "Play" button
- Your default browser will open automatically

### Using Command Line:
- Navigate to the project root:
```
cd codefire_csharp_backend
```

- Start the application:
```
dotnet run --project CodeFire.API
```

## Important URLs
- Swagger UI Documentation: https://localhost:7000/swagger
- API Base URL: https://localhost:7000/api
- Health Check: https://localhost:7000/api/greeting

## Available Endpoints
- GET /api/greeting - Returns a simple greeting
- GET /api/greeting/formal - Returns a formal greeting with timestamp

## Tech Stack
- ASP.NET Core 8.0
- Entity Framework Core
- PostgreSQL
- Swagger/OpenAPI

## Troubleshooting
- If the ports are in use, check the launchSettings.json file to modify them
- Ensure PostgreSQL is running before starting the application
- Check that your database connection string matches your PostgreSQL setup