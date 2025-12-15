// This script is not finished, but it works as an auto-navigation system tracking players.
// func_tank entity, exists in games like HL1, HL2 and CSGO. But why they removed from CS:S?
//
// how to use it? 2 entities.
// 1. Main entity: func_brush, func_physbox, or similar
// 2. logic_timer Entity: Set refire every 0.1 seconds. !self -> RunScriptCode -> funcTank_LockToPlayer()

iRandomPlayer    <- null;
pEntityOrigin    <- null;
iEntity            <- null;

SearchDistance     	<- 1000;

AddDirectionX		<- 0;
AddDirectionY		<- 0;
AddDirectionZ		<- 0;

function funcTank_LockToPlayer()
{
    if(iRandomPlayer == null || iRandomPlayer.GetHealth() <= 0)
    {
        PickRandomPlayer();
        
        if(iRandomPlayer == null) 
        {
            return;
        }
    }
    local pPlayerOrigin = iRandomPlayer.GetOrigin();
    local direction = pPlayerOrigin - pEntityOrigin;
    
    local yaw = atan2(direction.y + AddDirectionY, direction.x + AddDirectionX) * (180 / 3.14159);
    local pitch = -atan2(direction.z + AddDirectionZ, sqrt(direction.x * direction.x + direction.y * direction.y)) * (180 / 3.14159);
    
    iEntity.SetAngles(pitch, yaw, 0);
}

function PickRandomPlayer()
{
    local players = [];
    local check = null;
    
    while(check = Entities.FindByClassnameWithin(check, "player", pEntityOrigin, SearchDistance))
    {
        if(check.GetHealth() > 0 && check.GetTeam() == 3)
        {
            players.append(check);
        }
    }
    
    if(players.len() == 0) 
    {
        iRandomPlayer = null;
        return;
    }
    
    local iRandom = RandomInt(0, players.len() - 1);
    iRandomPlayer = players[iRandom];
    
    players.clear();
}

function OnPostSpawn()
{
    pEntityOrigin = self.GetOrigin();
    iEntity = self;
}