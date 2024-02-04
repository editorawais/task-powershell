param (
    [int]$n = -1
)

function Get-Fibonacci {
    param ([int]$n)

    if ($n -eq 0) {
        return 0
    }
    elseif ($n -eq 1) {
        return 1
    }
    else {
        return (Get-Fibonacci($n - 1)) + (Get-Fibonacci($n - 2))
    }
}

if ($n -eq -1) {
    # Output all Fibonacci numbers every 0.5 seconds
    $i = 0
    while ($true) {
        Write-Output (Get-Fibonacci $i)
        Start-Sleep -Seconds 0.5
        $i++
    }
}
else {
    # Output the specific Fibonacci number
    $result = Get-Fibonacci $n
    Write-Output "Fibonacci($n) = $result"
}
