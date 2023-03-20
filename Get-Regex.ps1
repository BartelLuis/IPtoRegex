Function Get-Regex {
    param (
        [string]$ip,
        [int]$subnet,
        [string]$format,
        [switch]$or
    )

    if ($ip -match "(\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b)") {
        $x = $true
    } else {
        $x = $false
    }
    if ($x -eq $false) {
        Write-Host "FEHLER | Geben sie bitte eine IP-Adresse an." -BackgroundColor Red
        exit
    }
    if ($subnet -gt 29) {
        Write-Host "FEHLER | Subnetzmaske zu groß" -BackgroundColor Red
        exit
    } elseif ($subnet -lt 24) {
        Write-Host "FEHLER | Subnetzmaske zu klein" -BackgroundColor Red
        exit
    }
    $ipregex =$ip.Replace('.','\.')

    if ($subnet -eq '24') {
        if ($ipregex.EndsWith('0')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 1)
            $ipregex = $ipregex + "([0-9]|[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])"
        }
    } elseif ($subnet -eq '25') {
        if ($ipregex.EndsWith('0')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 1)
            $ipregex = $ipregex + "([0-9]|[0-9][0-9]|1[0-1][0-9]|12[0-7])"
        } elseif ($ipregex.EndsWith('128')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(128|1[3-9][0-9]|2[0-4][0-9]|25[0-5])"
        }
    } elseif ($subnet -eq 26) {
        if ($ipregex.EndsWith('0')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 1)
            $ipregex = $ipregex + "([0-9]|[0-5][0-9]|6[0-3])"
        } elseif ($ipregex.EndsWith('64')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 2)
            $ipregex = $ipregex + "(6[4-9]|[7-9][0-9]|1[0-1][0-9]|12[0-7])"
        } elseif ($ipregex.EndsWith('128')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(12[8-9]|1[3-8][0-9]|19[0-1])"
        } elseif ($ipregex.EndsWith('192')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(19[2-9]|2[0-4][0-9]|25[0-5])"
        }
    } elseif ($subnet -eq 27) {
        if ($ipregex.EndsWith('0')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 1)
            $ipregex = $ipregex + "([0-9]|[0-2][0-9]|3[0-1])"
        } elseif ($ipregex.EndsWith('32')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 2)
            $ipregex = $ipregex + "(3[2-9]|[4-5][0-9]|6[0-3])"
        } elseif ($ipregex.EndsWith('64')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 2)
            $ipregex = $ipregex + "(6[4-9]|[7-8][0-9]|9[0-5])"
        } elseif ($ipregex.EndsWith('96')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 2)
            $ipregex = $ipregex + "(9[6-9]|1[0-1][0-9]|12[0-7])"
        } elseif ($ipregex.EndsWith('128')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(12[8-9]|1[3-5][0-9])"
        } elseif ($ipregex.EndsWith('160')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(1[6-8][0-9]|19[0-1])"
        } elseif ($ipregex.EndsWith('192')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(19[2-9]|2[0-1][0-9]|22[0-3])"
        } elseif ($ipregex.EndsWith('224')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(22[4-9]|2[3-4][0-9]|25[0-5])"
        }
    } elseif ($subnet -eq 28) {
        if ($ipregex.EndsWith('0')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 1)
            $ipregex = $ipregex + "([0-9]|[0-2][0-9]|3[0-1])"
        } elseif ($ipregex.EndsWith('32')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 2)
            $ipregex = $ipregex + "(3[2-9]|[4-5][0-9]|6[0-3])"
        } elseif ($ipregex.EndsWith('64')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 2)
            $ipregex = $ipregex + "(6[4-9]|[7-8][0-9]|9[0-5])"
        } elseif ($ipregex.EndsWith('96')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 2)
            $ipregex = $ipregex + "(9[6-9]|1[0-1][0-9]|12[0-7])"
        } elseif ($ipregex.EndsWith('128')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(12[8-9]|1[3-5][0-9])"
        } elseif ($ipregex.EndsWith('160')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(1[6-8][0-9]|19[0-1])"
        } elseif ($ipregex.EndsWith('192')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(19[2-9]|2[0-1][0-9]|22[0-3])"
        } elseif ($ipregex.EndsWith('224')) {
            $ipregex = $ipregex.Substring(0,$ipregex.Length - 3)
            $ipregex = $ipregex + "(22[4-9]|2[3-4][0-9]|25[0-5])"
        }
    }

    if ($format -eq "raw") {
        Write-Host $ipregex
    } elseif ($format -eq "wpad") {
        $ipregex = "###APACHEREWRITE" + $ipregex + "$"
        if ($or) {
            $ipregex = $ipregex + " [OR]"
        }
    }

    Write-Host $ipregex
}
