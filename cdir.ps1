###
### Global variables
###
$global:pathname = [string] "";  # TODO
$global:attributes = [string] "";
$global:filter = [string] "";  # TODO
$global:sortBy = [string] "";  # TODO

###
### Functions
###
function GetAttributes
{
    param( [Parameter(Mandatory=$true)][string] $attributes )

    for ($i = 0; $i -lt $attributes.Length; $i++)
    {
        $attribute = $attributes.Substring($i, 1)

        switch ($attribute) {
            "a" { AddToAttributeList "Archive" }
            "d" { AddToAttributeList "Directory" }
            "h" { AddToAttributeList "Hidden" }
            "r" { AddToAttributeList "ReadOnly" }
            "s" { AddToAttributeList "System" }
        }
    }
    
    Write-Host $global:attributes  # TODO: Remove when finished debugging
    Get-ChildItem -Attributes $global:attributes  # TODO: Move to Main when ready
}

function AddToAttributeList
{
    param( [Parameter(Mandatory=$true)][string] $newAttribute )

    if ($global:attributes.Length -gt 1)
    {
        $global:attributes = $global:attributes + "+" + $newAttribute
    }
    else
    {
        $global:attributes = $newAttribute
    }
}

###
### Main
###
if ($args.Count -gt 0)
{
    for ($i = 0; $i -lt $args.Count; $i++)
    {
        # Get the switch specified by the user
        $cmdSwitch = ($args[$i] -split ":")[0]

        # If the switch is "a", get the specified attribute
        if ($cmdSwitch -eq "/a")
        {
            $fileAttributes = ($args[$i] -split ":")[1]
        }

        switch ($cmdSwitch)
        {
            "/a" { GetAttributes $fileAttributes }
            "/b" { Get-ChildItem | Format-Wide -Column 1 }
            "/w" { Get-ChildItem | Format-Wide -Column 2 }
            # The following line probably needs serious improvement
            Default { Get-ChildItem $cmdSwitch }
        }
    }
}
else
{
    Get-ChildItem
}