param(
  [int]$Port = 8765
)

$previewRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://127.0.0.1:$Port/")
$listener.Start()

$mimeTypes = @{
  '.html' = 'text/html; charset=utf-8'
  '.css'  = 'text/css; charset=utf-8'
  '.js'   = 'text/javascript; charset=utf-8'
  '.jpg'  = 'image/jpeg'
  '.jpeg' = 'image/jpeg'
  '.png'  = 'image/png'
  '.svg'  = 'image/svg+xml'
  '.mp4'  = 'video/mp4'
  '.webm' = 'video/webm'
}

try {
  while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    if ($request.HttpMethod -notin @('GET', 'HEAD')) {
      $response.StatusCode = 405
      $response.Close()
      continue
    }

    $relativePath = [Uri]::UnescapeDataString($request.Url.AbsolutePath.TrimStart('/'))
    if ([string]::IsNullOrWhiteSpace($relativePath)) { $relativePath = 'experiment-preview/index.html' }
    elseif ($relativePath.EndsWith('/')) { $relativePath += 'index.html' }

    $filePath = [System.IO.Path]::GetFullPath((Join-Path $previewRoot $relativePath))
    if (-not $filePath.StartsWith($previewRoot, [System.StringComparison]::OrdinalIgnoreCase) -or -not (Test-Path -LiteralPath $filePath -PathType Leaf)) {
      $response.StatusCode = 404
      $response.Close()
      continue
    }

    $extension = [System.IO.Path]::GetExtension($filePath).ToLowerInvariant()
    $response.ContentType = if ($mimeTypes.ContainsKey($extension)) { $mimeTypes[$extension] } else { 'application/octet-stream' }
    $bytes = [System.IO.File]::ReadAllBytes($filePath)
    $response.ContentLength64 = $bytes.Length
    if ($request.HttpMethod -eq 'GET') { $response.OutputStream.Write($bytes, 0, $bytes.Length) }
    $response.Close()
  }
}
finally {
  $listener.Stop()
  $listener.Close()
}
