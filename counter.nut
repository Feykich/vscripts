// Testing purposes
function EntCounter(iEntCount)
{
	for(local i = 1; i <= iEntCount; i++)
	{
		local ent = null;
		
		ent = Entities.FindByName(null, "entity_maker_spikes_" + i); // targetname
		
		local SaveOrigin = ent.GetOrigin();
		
		printl("Counted: entity_maker_spikes_" + i);
		printl(SaveOrigin);
	}

}
