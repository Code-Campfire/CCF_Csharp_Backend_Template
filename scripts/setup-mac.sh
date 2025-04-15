#!/bin/bash

echo "Installing prerequisites for CodeFire API..."

# Check if .NET SDK is installed
if ! command -v dotnet &> /dev/null; then
    echo ".NET SDK is not installed. Please install .NET 8.0 SDK from https://dotnet.microsoft.com/download"
    echo "You can also use Homebrew: brew install --cask dotnet-sdk"
    exit 1
fi

echo ".NET SDK is installed."

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null; then
    echo "PostgreSQL is not installed. Please install PostgreSQL."
    echo "You can use Homebrew: brew install postgresql@14"
    echo "After installing, make sure to create a database named 'codefire'"
    exit 1
fi

echo "PostgreSQL is installed."

# Install EF Core tools if not already installed
if ! dotnet tool list --global | grep dotnet-ef &> /dev/null; then
    echo "Installing EF Core tools..."
    dotnet tool install --global dotnet-ef
else
    echo "Updating EF Core tools..."
    dotnet tool update --global dotnet-ef
fi

# Restore dependencies
echo "Restoring dependencies..."
dotnet restore

# Ask for PostgreSQL credentials and update appsettings.json
echo "Please provide your PostgreSQL credentials:"
echo "For local development, you can use the default username (postgres) without a password"
echo "by pressing Enter for both prompts."
read -p "Username (default: postgres): " PGUSER
read -s -p "Password (leave empty for no password): " PGPASS
echo ""

if [ -z "$PGUSER" ]; then
    PGUSER="postgres"
fi

# Create a backup of the original appsettings.json
cp CodeFire.API/appsettings.json CodeFire.API/appsettings.json.bak

# Update the connection string in appsettings.json
if [ -z "$PGPASS" ]; then
    sed -i.bak "s/Host=localhost;Database=codefire;Username=postgres;Password=yourpassword/Host=localhost;Database=codefire;Username=$PGUSER/g" CodeFire.API/appsettings.json
else
    sed -i.bak "s/Host=localhost;Database=codefire;Username=postgres;Password=yourpassword/Host=localhost;Database=codefire;Username=$PGUSER;Password=$PGPASS/g" CodeFire.API/appsettings.json
fi
rm CodeFire.API/appsettings.json.bak.bak 2>/dev/null

echo "Connection string updated in appsettings.json"

# Run database migrations
echo "Running database migrations..."
dotnet ef database update --project CodeFire.API

if [ $? -ne 0 ]; then
    echo "Failed to run migrations. Please check your PostgreSQL connection and try again."
    exit 1
fi

# Make the script executable
chmod +x "$(dirname "$0")/setup-mac.sh"

echo "Setup completed successfully!"
echo "You can now run the API using: dotnet run --project CodeFire.API" 