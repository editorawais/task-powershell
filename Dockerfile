# Use the official PowerShell image as base
FROM mcr.microsoft.com/powershell

# Copy the PowerShell script to the container
COPY Fibonacci.ps1 /Fibonacci.ps1

# Set the entry point to execute the script
ENTRYPOINT ["pwsh", "/Fibonacci.ps1"]
