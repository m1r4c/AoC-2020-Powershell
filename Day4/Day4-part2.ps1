function aoc-Day4 {
    Param(
        [string]$PassportData
    )
    $requiredFields = @{
        "byr"="\b19[2-9][0-9]\b|\b200[0-2]\b"; #1920 to 2002
        "iyr"="\b201[0-9]\b|\b2020\b"; #2010 to 2020
        "eyr"="\b202[0-9]\b|\b2030\b"; #2020 to 2030
        "hgt"="\b1[5-8][0-9]cm\b|\b19[0-3]cm\b|\b59in\b|\b6[0-9]in\b|\b7[0-6]in\b";
        "hcl"="#\b[0-9a-f]{6}\b";
        "ecl"="\bamb\b|\bblu\b|\bbrn\b|\bgry\b|\bgrn\b|\bhzl\b|\both\b";
        "pid"="\b[0-9]{9}\b";
    } 

    $validPassports = 0

    $lines = $PassportData.Split([Environment]::NewLine)
    $currentPassport = @{}
    $lines | ForEach-Object {
        if ($_ -eq "") {
            # next passport, check if current passport is valid or not
            $currentPassportValid = $true
            $requiredFields.Keys | ForEach-Object {
                if ($currentPassport.Keys -notcontains $_) {
                    $currentPassportValid = $false
                } elseif ($currentPassport[$_] -notmatch $requiredFields[$_]) {
                    $currentPassportValid = $false
                }
            }

            if ($currentPassportValid) {
                $validPassports++
            }
            $currentPassport = @{}
        } else {
            $columns = $_.Split(" ")
            $columns | ForEach-Object {
                $fieldHeader = $_.Split(":") | Select-Object -First 1
                $fieldValue = $_.Split(":") | Select-Object -Last 1

                $currentPassport.Add($fieldHeader, $fieldValue)
            }
        }
    }

    return $validPassports
}

#$passports = Get-Content -Encoding UTF8 -Raw ValidPassports.txt
$passports = Get-Content -Encoding UTF8 -Raw MyPassports.txt
aoc-Day4 -PassportData $passports
