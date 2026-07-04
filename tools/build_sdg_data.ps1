$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$queryDir = Join-Path $root "sources\elsevier-sdg-2023\queries"
$dataDir = Join-Path $root "assets"
$keywordDir = Join-Path $dataDir "sdg-keywords"

New-Item -ItemType Directory -Force -Path $dataDir | Out-Null
New-Item -ItemType Directory -Force -Path $keywordDir | Out-Null

$goals = @(
  @{ id = 1; file = "SDG01.txt"; code = "SDG 1"; name = "No Poverty"; officialName = "End poverty in all its forms everywhere"; coreTerms = @("poverty", "poor households", "social protection", "income inequality", "financial inclusion", "living wage", "poverty alleviation", "economic vulnerability"); aliases = @("low income", "deprivation", "welfare", "social safety net") },
  @{ id = 2; file = "SDG2.txt"; code = "SDG 2"; name = "Zero Hunger"; officialName = "End hunger, achieve food security and improved nutrition and promote sustainable agriculture"; coreTerms = @("food security", "hunger", "malnutrition", "nutrition", "sustainable agriculture", "crop yield", "agricultural productivity", "food supply"); aliases = @("famine", "undernutrition", "smallholder", "agroecology") },
  @{ id = 3; file = "SDG03.txt"; code = "SDG 3"; name = "Good Health and Well-being"; officialName = "Ensure healthy lives and promote well-being for all at all ages"; coreTerms = @("public health", "healthcare", "disease prevention", "mortality", "mental health", "maternal health", "infectious disease", "well-being"); aliases = @("health equity", "epidemiology", "clinical", "patient outcomes") },
  @{ id = 4; file = "SDG04.txt"; code = "SDG 4"; name = "Quality Education"; officialName = "Ensure inclusive and equitable quality education and promote lifelong learning opportunities for all"; coreTerms = @("quality education", "learning outcomes", "inclusive education", "lifelong learning", "teacher training", "educational equity", "STEM education", "curriculum"); aliases = @("pedagogy", "student achievement", "digital learning", "education policy") },
  @{ id = 5; file = "SDG05.txt"; code = "SDG 5"; name = "Gender Equality"; officialName = "Achieve gender equality and empower all women and girls"; coreTerms = @("gender equality", "women empowerment", "gender equity", "gender-based violence", "female participation", "women's rights", "gender gap", "sexual harassment"); aliases = @("women in leadership", "female labor", "gender discrimination") },
  @{ id = 6; file = "SDG06.txt"; code = "SDG 6"; name = "Clean Water and Sanitation"; officialName = "Ensure availability and sustainable management of water and sanitation for all"; coreTerms = @("water quality", "clean water", "sanitation", "wastewater treatment", "drinking water", "water pollution", "water resources", "water management"); aliases = @("water scarcity", "sewage", "groundwater", "river basin") },
  @{ id = 7; file = "SDG07.txt"; code = "SDG 7"; name = "Affordable and Clean Energy"; officialName = "Ensure access to affordable, reliable, sustainable and modern energy for all"; coreTerms = @("renewable energy", "clean energy", "energy efficiency", "solar energy", "wind energy", "energy access", "smart grid", "bioenergy"); aliases = @("photovoltaic", "decarbonized energy", "electricity access", "energy transition") },
  @{ id = 8; file = "SDG08.txt"; code = "SDG 8"; name = "Decent Work and Economic Growth"; officialName = "Promote sustained, inclusive and sustainable economic growth, full and productive employment and decent work for all"; coreTerms = @("decent work", "economic growth", "employment", "labor productivity", "workplace safety", "sustainable tourism", "inclusive growth", "youth employment"); aliases = @("labour market", "job creation", "occupational health", "informal employment") },
  @{ id = 9; file = "SDG09.txt"; code = "SDG 9"; name = "Industry, Innovation and Infrastructure"; officialName = "Build resilient infrastructure, promote inclusive and sustainable industrialization and foster innovation"; coreTerms = @("sustainable infrastructure", "industrial innovation", "resilient infrastructure", "inclusive industrialization", "green manufacturing", "technology innovation", "transport infrastructure", "digital infrastructure"); aliases = @("industry 4.0", "manufacturing sustainability", "infrastructure resilience") },
  @{ id = 10; file = "SDG10.txt"; code = "SDG 10"; name = "Reduced Inequalities"; officialName = "Reduce inequality within and among countries"; coreTerms = @("inequality", "social inclusion", "income inequality", "discrimination", "migration", "equity", "vulnerable groups", "accessibility"); aliases = @("social mobility", "minority groups", "redistribution", "inclusive policy") },
  @{ id = 11; file = "SDG11.txt"; code = "SDG 11"; name = "Sustainable Cities and Communities"; officialName = "Make cities and human settlements inclusive, safe, resilient and sustainable"; coreTerms = @("sustainable cities", "urban resilience", "smart city", "air pollution", "public transport", "urban planning", "disaster risk", "affordable housing"); aliases = @("urban sustainability", "walkability", "city planning", "community resilience") },
  @{ id = 12; file = "SDG12.txt"; code = "SDG 12"; name = "Responsible Consumption and Production"; officialName = "Ensure sustainable consumption and production patterns"; coreTerms = @("circular economy", "sustainable consumption", "responsible production", "waste reduction", "recycling", "life cycle assessment", "material efficiency", "food waste"); aliases = @("LCA", "supply chain sustainability", "resource efficiency", "eco-design") },
  @{ id = 13; file = "SDG13.txt"; code = "SDG 13"; name = "Climate Action"; officialName = "Take urgent action to combat climate change and its impacts"; coreTerms = @("climate change", "global warming", "greenhouse gas", "carbon footprint", "climate mitigation", "climate adaptation", "carbon emissions", "climate risk"); aliases = @("GHG", "CO2", "net zero", "carbon neutrality") },
  @{ id = 14; file = "SDG14.txt"; code = "SDG 14"; name = "Life Below Water"; officialName = "Conserve and sustainably use the oceans, seas and marine resources for sustainable development"; coreTerms = @("marine biodiversity", "ocean pollution", "marine ecosystem", "fisheries", "aquaculture", "coastal management", "plastic pollution", "coral reef"); aliases = @("blue economy", "marine conservation", "ocean acidification", "fishery management") },
  @{ id = 15; file = "SDG15.txt"; code = "SDG 15"; name = "Life on Land"; officialName = "Protect, restore and promote sustainable use of terrestrial ecosystems"; coreTerms = @("biodiversity", "forest conservation", "land degradation", "ecosystem restoration", "deforestation", "terrestrial ecosystem", "soil conservation", "habitat loss"); aliases = @("wildlife conservation", "protected areas", "reforestation", "desertification") },
  @{ id = 16; file = "SDG16.txt"; code = "SDG 16"; name = "Peace, Justice and Strong Institutions"; officialName = "Promote peaceful and inclusive societies, provide access to justice for all and build effective institutions"; coreTerms = @("peace", "justice", "strong institutions", "governance", "corruption", "human rights", "rule of law", "violence prevention"); aliases = @("institutional quality", "public accountability", "conflict resolution", "legal empowerment") },
  @{ id = 17; file = "SDG17.txt"; code = "SDG 17"; name = "Partnerships for the Goals"; officialName = "Strengthen the means of implementation and revitalize the global partnership for sustainable development"; coreTerms = @("global partnership", "sustainable development cooperation", "capacity building", "technology transfer", "development finance", "multi-stakeholder partnership", "international cooperation", "SDG implementation"); aliases = @("policy coherence", "public private partnership", "development assistance", "cross-sector collaboration") }
)

function Convert-ToJsStringArray($items) {
  $items | ConvertTo-Json -Compress
}

function Get-QueryTerms($path) {
  $text = Get-Content $path -Raw
  $terms = New-Object System.Collections.Generic.List[string]
  $negative = New-Object System.Collections.Generic.List[string]
  $notIndex = $text.IndexOf(" NOT ")
  $positiveText = if ($notIndex -ge 0) { $text.Substring(0, $notIndex) } else { $text }
  $negativeText = if ($notIndex -ge 0) { $text.Substring($notIndex) } else { "" }

  foreach ($m in [regex]::Matches($positiveText, '(?:TITLE-ABS|AUTHKEY)\("([^"]+)"\)')) {
    $term = $m.Groups[1].Value.Trim()
    if ($term.Length -ge 4 -and $term -notmatch '^[0-9\s\W]+$') {
      $terms.Add($term)
    }
  }
  foreach ($m in [regex]::Matches($negativeText, '(?:TITLE-ABS|AUTHKEY)\("([^"]+)"\)')) {
    $term = $m.Groups[1].Value.Trim()
    if ($term.Length -ge 4 -and $term -notmatch '^[0-9\s\W]+$') {
      $negative.Add($term)
    }
  }

  $extracted = $terms |
    ForEach-Object { $_.Trim() } |
    Where-Object { $_ -and $_.Length -ge 4 } |
    Group-Object { $_.ToLowerInvariant() } |
    ForEach-Object { $_.Group[0] } |
    Sort-Object { if ($_ -match '\s') { 0 } else { 1 } }, Length -Descending |
    Select-Object -First 520 |
    ForEach-Object {
      $weight = if ($_ -match '\s' -and $_.Length -gt 22) { 5 } elseif ($_ -match '\s') { 4 } else { 2 }
      [ordered]@{ term = $_; weight = $weight; fields = @("title", "abstract", "keywords") }
    }

  return @($extracted)
}

$coreObjects = foreach ($g in $goals) {
  [ordered]@{
    id = $g.id
    code = $g.code
    name = $g.name
    officialName = $g.officialName
    coreTerms = $g.coreTerms
    aliases = $g.aliases
    source = "UN SDGs + Elsevier 2023 SDG Mapping descriptions"
  }
}

$coreJs = "window.SDG_CORE_INDEX = " + ($coreObjects | ConvertTo-Json -Depth 8) + ";`n"
Set-Content -Path (Join-Path $dataDir "sdg-core-index.js") -Value $coreJs -Encoding UTF8

foreach ($g in $goals) {
  $terms = @(Get-QueryTerms (Join-Path $queryDir $g.file))
  $negativeTerms = @()
  $queryText = Get-Content (Join-Path $queryDir $g.file) -Raw
  $notIndex = $queryText.IndexOf(" NOT ")
  if ($notIndex -ge 0) {
    $negativeTerms = [regex]::Matches($queryText.Substring($notIndex), '(?:TITLE-ABS|AUTHKEY)\("([^"]+)"\)') |
      ForEach-Object { $_.Groups[1].Value.Trim() } |
      Where-Object { $_.Length -ge 4 } |
      Group-Object { $_.ToLowerInvariant() } |
      ForEach-Object { $_.Group[0] } |
      Select-Object -First 80
  }
  $module = [ordered]@{
    id = $g.id
    code = $g.code
    name = $g.name
    source = "Elsevier 2023 Sustainable Development Goals (SDGs) Mapping, DOI: 10.17632/y2zyy9vwzy.1, CC BY 4.0"
    terms = $terms
    negativeTerms = $negativeTerms
    queryFile = "sources/elsevier-sdg-2023/queries/$($g.file)"
  }
  $json = $module | ConvertTo-Json -Depth 8
  $id = "{0:D2}" -f $g.id
  $js = "window.SDG_KEYWORDS = window.SDG_KEYWORDS || {};`nwindow.SDG_KEYWORDS[$($g.id)] = $json;`n"
  Set-Content -Path (Join-Path $keywordDir "sdg-$id.js") -Value $js -Encoding UTF8
}

Write-Host "Generated SDG data modules in $dataDir"
