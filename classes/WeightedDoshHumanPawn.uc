class WeightedDoshHumanPawn extends KFHumanPawn;

var float prevGroundSpeed;

simulated event ModifyVelocity(float DeltaTime, vector OldVelocity) {
    local float WeightMod, HealthMod;
    local float EncumbrancePercentage;
    local int myScore;
    local string speedMsg;

    super(KFPawn).ModifyVelocity(DeltaTime, OldVelocity);

    if (Controller != none) {
        myScore= int(Controller.PlayerReplicationInfo.Score);

        EncumbrancePercentage = (FMin(CurrentWeight, MaxCarryWeight)/default.MaxCarryWeight);

        WeightMod = (1.0 - (EncumbrancePercentage * WeightSpeedModifier));
        HealthMod = ((Health/HealthMax) * HealthSpeedModifier) + (1.0 - HealthSpeedModifier);

        // Apply all the modifiers
        GroundSpeed = default.GroundSpeed * HealthMod;
        GroundSpeed *= WeightMod;
        GroundSpeed += InventorySpeedModifier;

        if ( KFPlayerReplicationInfo(PlayerReplicationInfo) != none && KFPlayerReplicationInfo(PlayerReplicationInfo).ClientVeteranSkill != none ) {
            GroundSpeed *= KFPlayerReplicationInfo(PlayerReplicationInfo).ClientVeteranSkill.static.GetMovementSpeedModifier(KFPlayerReplicationInfo(PlayerReplicationInfo));
        }

        if (class'WeightedDoshMut'.default.bDispSpeed && 
                prevGroundSpeed != GroundSpeed) {
            speedMsg= chr(27)$chr(200)$chr(1)$chr(1)$"Ground speed: "$GroundSpeed;
            KFPC.ClientMessage(speedMsg);
            prevGroundSpeed= GroundSpeed;
        }
    }
}

defaultproperties {
    prevGroundSpeed= GroundSpeed;
}
