function aoc-Day4 {
    Param(
        [string]$PassportData
    )
    $requiredFields = @("byr","iyr","eyr","hgt","hcl","ecl","pid")
    $validPassports = 0

    $lines = $PassportData.Split([Environment]::NewLine)
    $currentPassport = @{}
    $lines | ForEach-Object {
        if ($_ -eq "") {
            # next passport, check if current passport is valid or not
            $currentPassportValid = $true
            $requiredFields | ForEach-Object {
                if ($currentPassport.Keys -notcontains $_) {
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

#$passports = Get-Content -Encoding UTF8 -Raw SamplePassports.txt
$passports = Get-Content -Encoding UTF8 -Raw MyPassports.txt
aoc-Day4 -PassportData $passports
