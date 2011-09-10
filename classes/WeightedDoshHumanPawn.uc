class WeightedDoshHumanPawn extends KFHumanPawn;

var float prevScore;

simulated event ModifyVelocity(float DeltaTime, vector OldVelocity) {
    local float WeightMod, HealthMod;
    local float EncumbrancePercentage;
    local int currScore;
    local string speedMsg;

    super(KFPawn).ModifyVelocity(DeltaTime, OldVelocity);

    if (Controller != none) {
        currScore= int(Controller.PlayerReplicationInfo.Score);

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

        GroundSpeed*= 1-fmin(1, float(currScore)/class'WeightedDoshMut'.default.maxScore);

        if (class'WeightedDoshMut'.default.bDispSpeed && 
                prevScore != currScore) {
            speedMsg= chr(27)$chr(1)$chr(200)$chr(26)$"Ground speed: "$GroundSpeed;
            KFPC.ClientMessage(speedMsg);
            prevScore= currScore;
        }
    }
}

defaultproperties {
    prevScore= 0;
}
