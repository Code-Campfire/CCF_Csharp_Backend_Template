# CodeFire API

A C# ASP.NET Core Web API project with PostgreSQL and Swagger integration.

## Prerequisites

- .NET 7.0 SDK or later
- PostgreSQL installed and running
- Your favorite IDE (Visual Studio, VS Code, or Rider)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/codefire_csharp_backend.git
cd codefire_csharp_backend

Update the database connection string in CodeFire.API/appsettings.json: "ConnectionStrings": { "DefaultConnection": "Host=localhost;Database=codefire;Username=postgres;Password=yourpassword" }

Install dependencies: dotnet restore

Run database migrations: dotnet ef database update

Running the Application
Using Visual Studio:
Open the solution file CodeFire.API.sln
Press F5 or click the "Play" button
Your default browser will open automatically
Using Command Line:
Navigate to the project root: cd codefire_csharp_backend

Start the application: dotnet run --project CodeFire.API

Important URLs
Swagger UI Documentation: https://localhost:7000/swagger
API Base URL: https://localhost:7000/api
Health Check: https://localhost:7000/api/greeting
Available Endpoints
GET /api/greeting - Returns a simple greeting
GET /api/greeting/formal - Returns a formal greeting with timestamp
Tech Stack
ASP.NET Core 7.0
Entity Framework Core
PostgreSQL
Swagger/OpenAPI
Troubleshooting
If the ports are in use, check the launchSettings.json file to modify them
Ensure PostgreSQL is running before starting the application
Check that your database connection string matches your PostgreSQL setup