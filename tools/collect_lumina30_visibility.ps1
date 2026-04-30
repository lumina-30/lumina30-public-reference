# collect_lumina30_visibility.ps1
# Collects external visibility evidence for LUMINA-30.
# This script does not prove adoption.
# It only records observable traffic / usage / DOI / search-related evidence.

param(
    [string]$Owner = "lumina-30",
    [string]$OutputDir = ".\visibility-output",
    [string]$GitHubToken = $env:GITHUB_TOKEN
)

$Repos = @(
    "lumina-30-overview",
    "lumina30-incident-review",
    "lumina30-public-reference",
    "Lumi30-Index",
    "LUMINA-30"
)

$ZenodoDois = @(
    # PCR-C / repository publication records
    "10.5281/zenodo.18824181",
    "10.5281/zenodo.18850343",

    # Structural Instability paper records
    "10.5281/zenodo.19896405",
    "10.5281/zenodo.19887869",
    "10.5281/zenodo.19887870"
)

New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

$Date = Get-Date -Format "yyyy-MM-dd_HHmmss"
$ReportPath = Join-Path $OutputDir "LUMINA30_visibility_snapshot_$Date.md"

function Invoke-GitHubApi {
    param([string]$Url)

    if ([string]::IsNullOrWhiteSpace($GitHubToken)) {
        return $null
    }

    $Headers = @{
        "Accept" = "application/vnd.github+json"
        "Authorization" = "Bearer $GitHubToken"
        "X-GitHub-Api-Version" = "2022-11-28"
        "User-Agent" = "LUMINA30-visibility-check"
    }

    try {
        return Invoke-RestMethod -Uri $Url -Headers $Headers -Method Get
    }
    catch {
        return @{ error = $_.Exception.Message }
    }
}

function Invoke-JsonApi {
    param([string]$Url)

    try {
        return Invoke-RestMethod -Uri $Url -Method Get -Headers @{ "User-Agent" = "LUMINA30-visibility-check" }
    }
    catch {
        return @{ error = $_.Exception.Message }
    }
}

$Lines = @()
$Lines += "# LUMINA-30 Visibility Snapshot"
$Lines += ""
$Lines += "Observation date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss zzz')"
$Lines += ""
$Lines += "This snapshot records visibility signals only. It does not prove adoption."
$Lines += ""

$Lines += "## GitHub Traffic"
$Lines += ""
$Lines += "| Repository | Views | Unique visitors | Clones | Unique cloners | Notes |"
$Lines += "|---|---:|---:|---:|---:|---|"

foreach ($Repo in $Repos) {
    if ([string]::IsNullOrWhiteSpace($GitHubToken)) {
        $Lines += "| $Repo |  |  |  |  | GITHUB_TOKEN not set. Traffic API skipped. |"
        continue
    }

    $ViewsUrl = "https://api.github.com/repos/$Owner/$Repo/traffic/views"
    $ClonesUrl = "https://api.github.com/repos/$Owner/$Repo/traffic/clones"

    $Views = Invoke-GitHubApi -Url $ViewsUrl
    $Clones = Invoke-GitHubApi -Url $ClonesUrl

    $ViewCount = ""
    $UniqueViews = ""
    $CloneCount = ""
    $UniqueClones = ""
    $Notes = ""

    if ($Views -and $Views.count -ne $null) {
        $ViewCount = $Views.count
        $UniqueViews = $Views.uniques
    } elseif ($Views.error) {
        $Notes += "Views error: $($Views.error) "
    }

    if ($Clones -and $Clones.count -ne $null) {
        $CloneCount = $Clones.count
        $UniqueClones = $Clones.uniques
    } elseif ($Clones.error) {
        $Notes += "Clones error: $($Clones.error) "
    }

    $Lines += "| $Repo | $ViewCount | $UniqueViews | $CloneCount | $UniqueClones | $Notes |"
}

$Lines += ""
$Lines += "## DataCite DOI Usage / Events"
$Lines += ""
$Lines += "| DOI | Usage events endpoint | Event count observed | Notes |"
$Lines += "|---|---|---:|---|"

foreach ($Doi in $ZenodoDois) {
    $EncodedDoi = [uri]::EscapeDataString($Doi)
    $Url = "https://api.datacite.org/events?source-id=datacite-usage&doi=$EncodedDoi"
    $Response = Invoke-JsonApi -Url $Url

    $Count = ""
    $Notes = ""

    if ($Response.data -ne $null) {
        $Count = @($Response.data).Count
    } elseif ($Response.error) {
        $Notes = $Response.error
    }

    $Lines += "| $Doi | $Url | $Count | $Notes |"
}

$Lines += ""
$Lines += "## Manual Checks Required"
$Lines += ""
$Lines += "- Zenodo record page views / downloads should be checked on the Zenodo record page."
$Lines += "- arXiv paper-level downloads cannot be directly recorded from arXiv."
$Lines += "- arXiv visibility should be recorded through URL resolution, external mentions, DOI links, search results, and citation evidence."
$Lines += "- External search evidence should be recorded conservatively."
$Lines += ""

$Lines | Set-Content -Path $ReportPath -Encoding UTF8

Write-Output "Visibility snapshot written to: $ReportPath"
