g_Scale 	 <- 0.0; // why do i need this?

function ScaleHP(AddScale) // entity output
{
	local Scale 	= GetPlayerCount();
	local newScale 	= g_Scale + (Scale * AddScale);
	
	EntFireByHandle(self, "Add", newScale.tostring(), 0.5, null, null); // math_counter
	
	printl("Scaled to: " + newScale);
}

function GetPlayerCount()
{
	local count = 0;
	local player = null;

	while(player = Entities.FindByClassname(player, "player"))
	{
		if(player.IsValid() && player.GetHealth() > 0)
		{
			count++;
		}
	}
	return count;

}
