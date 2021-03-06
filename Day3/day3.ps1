function aoc-Day3 {
    Param(
        [string] $map,
        [int]$SlopeRight,
        [int]$SlopeDown
    )

    $treesLocated = 0
    $lines = $map.Split([Environment]::NewLine)
    $columns = $lines[0].ToCharArray().Count

    $al = New-Object System.Collections.ArrayList
    
    $lines | ForEach-Object {
        $al.Add($_.ToCharArray()) | Out-Null
    }

    $decline = $SlopeDown
    $position = $SlopeRight

    Do {
        $currentPos = $al[$decline][$position]
        if ($currentPos -eq "#") {
            $treesLocated++
        }

        $decline += $SlopeDown
        $position += $SlopeRight

        $position = $position % $columns

        #Write-Host "p: $($position), l: $($decline)"
    } While ($decline -lt $al.Count)

    return $treesLocated
}

#$map = Get-Content -Encoding UTF8 -Raw "Day3-SampleInput.txt"
#aoc-Day3 -map $map -SlopeRight 3 -SlopeDown 1 # should produce 7
$map = Get-Content -Encoding UTF8 -Raw "Day3-input.txt"
aoc-Day3 -map $map -SlopeRight 3 -SlopeDown 1 # should produce 7
