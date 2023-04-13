//---------------------------------------------------------------------------------------
//  FILE:    UIArmory_Loadout_Cleaner
//  AUTHOR:  Kregano
//  PURPOSE: UI for viewing and modifying a Soldiers equipment, now with filter to match 
//---------------------------------------------------------------------------------------

class UIArmory_Loadout_Cleaner extends UIArmory_Loadout;

var config(ClassData) array<SoldierClassWeaponType>    AllowedWeapons;

function bool IsWeaponAllowedByClass(X2WeaponTemplate WeaponTemplate)
{
	local int i;

	switch(WeaponTemplate.InventorySlot)
	{
	case eInvSlot_PrimaryWeapon: break;
	case eInvSlot_SecondaryWeapon: break;
	default:
		return true;
	}

	for (i = 0; i < AllowedWeapons.Length; ++i)
	{
		if (WeaponTemplate.InventorySlot == AllowedWeapons[i].SlotType &&
			WeaponTemplate.WeaponCat == AllowedWeapons[i].WeaponType)
			return true;
	}
	return false;
}

simulated function bool ShowInLockerList(XComGameState_Item Item, EInventorySlot SelectedSlot)
{
	local X2ItemTemplate ItemTemplate;
	local X2GrenadeTemplate GrenadeTemplate;
	local X2EquipmentTemplate EquipmentTemplate;
	local X2WeaponTemplate WeaponTemplate;

	ItemTemplate = Item.GetMyTemplate();
	
	if(MeetsAllStrategyRequirements(ItemTemplate.ArmoryDisplayRequirements) && MeetsDisplayRequirement(ItemTemplate))
	{
		switch(SelectedSlot)
		{
		case eInvSlot_PrimaryWeapon:
			WeaponTemplate = X2WeaponTemplate(ItemTemplate);
			return (WeaponTemplate != none && IsWeaponAllowedByClass(WeaponTemplate));
			`log("Primary weapon slot filtered",,'Simple Tac UI Cleaner');
		case eInvSlot_SecondaryWeapon:
			WeaponTemplate = X2WeaponTemplate(ItemTemplate);
			return (IsWeaponAllowedByClass(WeaponTemplate) == true);
			`log("Secondary weapon slot filtered",,'Simple Tac UI Cleaner');
		case eInvSlot_GrenadePocket:
			GrenadeTemplate = X2GrenadeTemplate(ItemTemplate);
			return GrenadeTemplate != none;
		case eInvSlot_AmmoPocket:
			return ItemTemplate.ItemCat == 'ammo';
		default:
			EquipmentTemplate = X2EquipmentTemplate(ItemTemplate);
			// xpad is only item with size 0, that is always equipped
			return (EquipmentTemplate != none && EquipmentTemplate.iItemSize > 0 && EquipmentTemplate.InventorySlot == SelectedSlot);
		}
	}

	return false;
}