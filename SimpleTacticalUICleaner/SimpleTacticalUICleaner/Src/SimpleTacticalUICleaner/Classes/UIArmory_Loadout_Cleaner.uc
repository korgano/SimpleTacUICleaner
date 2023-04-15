//---------------------------------------------------------------------------------------
//  FILE:    UIArmory_Loadout_Cleaner
//  AUTHOR:  Kregano
//  PURPOSE: UI for viewing and modifying a Soldiers equipment, now with filter to match 
//---------------------------------------------------------------------------------------

class UIArmory_Loadout_Cleaner extends UIArmory_Loadout;

simulated function bool ShowInLockerList(XComGameState_Item Item, EInventorySlot SelectedSlot)
{
	local X2ItemTemplate ItemTemplate;
	local XComGameState_Unit UpdatedUnit;
	local X2SoldierClassTemplate SoldierClassName;
	local X2GrenadeTemplate GrenadeTemplate;
	local X2EquipmentTemplate EquipmentTemplate;
	local X2WeaponTemplate WeaponTemplate;

	ItemTemplate = Item.GetMyTemplate();
	UpdatedUnit =  GetUnit();
	SoldierClassName = UpdatedUnit.GetSoldierClassTemplate();
	`log("ShowInLockerList triggered for class" @ SoldierClassName.DisplayName,,'Simple Tac UI Cleaner');
	
		if(MeetsAllStrategyRequirements(ItemTemplate.ArmoryDisplayRequirements) && MeetsDisplayRequirement(ItemTemplate))
	{
		`log("ShowInLockerList running on" @ ItemTemplate.DataName,,'Simple Tac UI Cleaner');
		switch(SelectedSlot)
		{
		case eInvSlot_PrimaryWeapon:
			WeaponTemplate = X2WeaponTemplate(ItemTemplate);
			return (WeaponTemplate != none && SoldierClassName != none && SoldierClassName.IsWeaponAllowedByClass(WeaponTemplate) && WeaponTemplate.InventorySlot == SelectedSlot);
		case eInvSlot_SecondaryWeapon:
			WeaponTemplate = X2WeaponTemplate(ItemTemplate);
			return (WeaponTemplate != none && SoldierClassName != none && SoldierClassName.IsWeaponAllowedByClass(WeaponTemplate) && WeaponTemplate.InventorySlot == SelectedSlot);
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