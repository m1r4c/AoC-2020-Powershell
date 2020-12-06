function aoc-Day6 {
    Param(
        [string]$RawInput
    )

    $lines = $RawInput.Split([Environment]::NewLine)

    $allGroupStats = New-Object System.Collections.ArrayList
    $currentGroupStats = @{}
    $lines | ForEach-Object {
        if ($_ -eq "") {
            # empty line, moving to a new group
            $allGroupStats.Add($currentGroupStats) | Out-Null
            $currentGroupStats = @{}
        } else {
            $tokens = $_.ToCharArray()
            $tokens | ForEach-Object {
                if ($currentGroupStats.ContainsKey($_)) {
                    $currentGroupStats[$_] = $currentGroupStats[$_] + 1 # $currentGroupStats[$_]++?
                } else {
                    $currentGroupStats.Add($_, 1) | Out-Null
                }
            }
        }
    }

    # get total number of questions answer across all groups
    $totalQuestionsAnswered = 0
    $allGroupStats | ForEach-Object {
        $totalQuestionsAnswered += $_.Count
    }

    Write-Host "Total answered $($totalQuestionsAnswered)"
}
#$raw = Get-Content -Encoding UTF8 -Raw $PSScriptRoot\Sample.txt
$raw = Get-Content -Encoding UTF8 -Raw $PSScriptRoot\MyInput.txt
aoc-Day6 -RawInput $raw