class WeightedDoshPlayerController extends KFPCServ;

function SetPawnClass(string inClass, string inCharacter) {
    PawnClass = Class'WeightedDosh.WeightedDoshHumanPawn';
    inCharacter = Class'KFGameType'.Static.GetValidCharacter(inCharacter);
    PawnSetupRecord = class'xUtil'.static.FindPlayerRecord(inCharacter);
    PlayerReplicationInfo.SetCharacterName(inCharacter);
}

