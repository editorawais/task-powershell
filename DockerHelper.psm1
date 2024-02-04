function Build-DockerImage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Dockerfile,

        [Parameter(Mandatory=$true)]
        [string]$Tag,

        [Parameter(Mandatory=$true)]
        [string]$Context,

        [Parameter()]
        [string]$ComputerName
    )

    process {
        if ($ComputerName) {
            # Remote execution
            $remoteCommand = "docker build -t $Tag -f $Dockerfile $Context"
            Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                param($command)
                Invoke-Expression $command
            } -ArgumentList $remoteCommand
        }
        else {
            # Local execution
            docker build -t $Tag -f $Dockerfile $Context
        }
    }
}

function Copy-Prerequisites {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ComputerName,

        [Parameter(Mandatory=$true)]
        [string[]]$Path,

        [Parameter(Mandatory=$true)]
        [string]$Destination
    )

    process {
        # Copy files to remote host
        foreach ($sourcePath in $Path) {
            $destinationPath = "\\$ComputerName\$Destination"
            Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse
        }
    }
}

function Run-DockerContainer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ImageName,

        [Parameter()]
        [string]$ComputerName,

        [Parameter()]
        [string[]]$DockerParams
    )

    process {
        if ($ComputerName) {
            # Remote execution
            $remoteCommand = "docker run $ImageName $DockerParams"
            Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                param($command)
                Invoke-Expression $command
            } -ArgumentList $remoteCommand
        }
        else {
            # Local execution
            $containerName = docker run $ImageName $DockerParams
            Write-Output $containerName
        }
    }
}
