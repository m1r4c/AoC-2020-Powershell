function aoc-Day5 {
    Param(
        [string]$BoardingPassesText
    )

    $boardingPasses = $BoardingPassesText.Split([Environment]::NewLine)
    $highestSeatId = 0
    $seats = New-Object System.Collections.ArrayList
    
    $boardingPasses | ForEach-Object {
        $currentBoardingPass = $_
        $rowTokens = $currentBoardingPass.ToCharArray() | Select-Object -First 7
        $columnTokens = $currentBoardingPass.ToCharArray() | Select-Object -Last 3

        $rows = 0..127
        $columns = 0..7
        $rowTokens | ForEach-Object {
            $rowToken = $_
            if ($rowToken -eq "F") {
                $rows = $rows | Select-Object -First ($rows.Count / 2)
            } else {
                $rows = $rows | Select-Object -Last ($rows.Count / 2)
            }
        }

        $columnTokens | ForEach-Object {
            $columnToken = $_
            if ($columnToken -eq "R") {
                $columns = $columns | Select-Object -Last ($columns.Count / 2)
            } else {
                $columns = $columns | Select-Object -First ($columns.Count / 2)
            }
        }

        $seatid = ($rows * 8) + $columns

        if ($seatid -gt $highestSeatId) {
            $highestSeatId = $seatid
        }

        $seats.Add($seatid) | Out-Null
    }

    $measure = $seats | Measure-Object -Minimum -Maximum
    $allSeats = $measure.Minimum..$measure.Maximum
    $allSeats | ForEach-Object {
        if (-not $seats.Contains($_)) {
            Write-Host "Seat ID $($_) is missing"
        }
    }
    return $seats
}
#$boardingPasses = Get-Content -Encoding UTF8 -Raw Sample.txt
$boardingPasses = Get-Content -Encoding UTF8 -Raw BoardingPasses.txt
$seats = aoc-Day5 -BoardingPassesText $boardingPasses
