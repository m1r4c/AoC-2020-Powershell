function aoc-Day5 {
    Param(
        [string]$BoardingPassesText
    )

    $boardingPasses = $BoardingPassesText.Split([Environment]::NewLine)
    $highestSeatId = 0

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

        Write-Host "Row: $($rows)"
        Write-Host "Column: $($columns)"
        Write-Host "Seat ID: $(($rows * 8) + $columns)"
        Write-Host "Highest seat id: $($highestSeatId)"
    }
}
#$boardingPasses = Get-Content -Encoding UTF8 -Raw Sample.txt
$boardingPasses = Get-Content -Encoding UTF8 -Raw BoardingPasses.txt
aoc-Day5 -BoardingPassesText $boardingPasses
