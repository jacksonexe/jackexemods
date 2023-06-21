import unrealsdk
from Mods import ModMenu

class SoulLink(ModMenu.SDKMod):
    Name: str = "Borderlands Soul Link"
    Author: str = "Jackexe"
    Description: str = "Links each player together"
    Version: str = "1.0.0"
    SupportedGames: ModMenu.Game = ModMenu.Game.BL2 | ModMenu.Game.TPS  # Either BL2 or TPS; bitwise OR'd together
    Types: ModMenu.ModTypes = ModMenu.ModTypes.Utility  # One of Utility, Content, Gameplay, Library; bitwise OR'd together

    def Enable(self) -> None:
        super().Enable()
        unrealsdk.Log("I ARISE!")
        player = unrealsdk.GetEngine().GamePlayers[0].Actor.Pawn
    
    @ModMenu.Hook("WillowGame.WillowPlayerPawn.TakeDamage")
    def TakeDamage(caller: unrealsdk.UObject, function: unrealsdk.UFunction, params: unrealsdk.FStruct) -> bool:
        if caller == unrealsdk.GetEngine().GamePlayers[0].Actor.Pawn:
            return False
    
    @ModMenu.Hook("WillowGame.WillowWeapon.ConsumeAmmo")
    def ConsumeAmmo(caller: unrealsdk.UObject, function: unrealsdk.UFunction, params: unrealsdk.FStruct) -> bool:
        pc = unrealsdk.GetEngine().GamePlayers[0].Actor
        if pc is None or pc.Pawn is None:
            return True
        if caller not in (pc.Pawn.Weapon, pc.Pawn.OffHandWeapon):
            return True
        caller.RefillClip()

instance = SoulLink()

if __name__ == "__main__":
    unrealsdk.Log(f"[{instance.Name}] Manually loaded")
    for mod in ModMenu.Mods:
        if mod.Name == instance.Name:
            if mod.IsEnabled:
                mod.Disable()
            ModMenu.Mods.remove(mod)
            unrealsdk.Log(f"[{instance.Name}] Removed last instance")

            # Fixes inspect.getfile()
            instance.__class__.__module__ = mod.__class__.__module__
            break

ModMenu.RegisterMod(instance)