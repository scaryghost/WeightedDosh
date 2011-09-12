class WeightedDoshMut extends Mutator;

var() config bool bDispSpeed;
var() config int maxScore;

function PostBeginPlay() {
    local KFGameType KF;

    KF = KFGameType(Level.Game);
    if (Level.NetMode != NM_Standalone)
        AddToPackageMap("WeightedDosh");

    if (KF == none) {
        Destroy();
        return;
    }

    KF.PlayerControllerClass= class'WeightedDosh.WeightedDoshPlayerController';
    KF.PlayerControllerClassName= "WeightedDosh.WeightedDoshPlayerController";

}

static function FillPlayInfo(PlayInfo PlayInfo) {
    Super.FillPlayInfo(PlayInfo);
    PlayInfo.AddSetting("WeightedDosh", "bDispSpeed","Display player speed", 0, 0, "Check");
    PlayInfo.AddSetting("WeightedDosh", "maxScore","0 speed dosh amount", 0, 1, "Text");
}

static event string GetDescriptionText(string property) {
    switch(property) {
        case "bDispSpeed":
            return "Check to periodically display the player's speed";
        case "maxScore":
            return "The max amount of dosh a player can have before his speed is 0";
        default:
            return Super.GetDescriptionText(property);
    }
}


defaultproperties {
    GroupName="KFDoshMut"
    FriendlyName="Weighted Dosh"
    Description="The more money you have, the slower you move!  Version 1.0.0"
    
    bDispSpeed= false
    maxScore= 2500
}
