if ($args.Count -gt 0)
{
    for ($i = 0; $i -lt $args.Count; $i++)
    {
        Remove-Item -Recurse -Force $args[$i]
        if (Test-Path $args[$i])
        {
            Write-Host "There was a problem removing" $args[$i]
        }
        else
        {
            Write-Host "Removed" $args[$i]
        }
    }
}
else
{
    Write-Host "This script requires one or more arguments."
}

