function aoc-Day6 {
    Param(
        [string]$RawInput
    )

    $lines = $RawInput.Split([Environment]::NewLine)

    $currentGroupStats = @{}
    $totalAnswered = 0
    $lines | ForEach-Object {
        if ($_ -eq "") {
            # empty line, moving to a new group, get stats
            $allGroupAnswers = New-Object System.Collections.ArrayList
            $currentGroupStats.Values | ForEach-Object {
                $_ | ForEach-Object {
                    if ($allGroupAnswers -notcontains $_) {
                        $allGroupAnswers.Add($_) | Out-Null
                    }
                }
            }

            $allGroupAnswers | ForEach-Object {
                $currentKey = $_
                $entireGroupHasKey = $true
                $currentGroupStats.Values | ForEach-Object {
                    if ($_ -notcontains $currentKey) {
                        $entireGroupHasKey = $false
                    }
                }

                if ($entireGroupHasKey) {
                    $totalAnswered++
                }
            }

            $currentGroupStats = @{}
        } else {
            $currentGroupStats.Add(""+$i, $_.ToCharArray()) | Out-Null
        }

        $i++
    }

    Write-Host "Total answered yes $($totalAnswered)"
}
#$raw = Get-Content -Encoding UTF8 -Raw $PSScriptRoot\Sample.txt
$raw = Get-Content -Encoding UTF8 -Raw $PSScriptRoot\MyInput.txt
aoc-Day6 -RawInput $raw