//---------------------------------------------------------------------------------------
//  FILE:    X2SoldierClassTemplate_Cleaner.uc
//  AUTHOR:  Kregano
//---------------------------------------------------------------------------------------
//  Copyright (c) 2014 Firaxis Games Inc. All rights reserved.
//--------------------------------------------------------------------------------------- 

class X2SoldierClassTemplate_Cleaner extends X2SoldierClassTemplate;

function bool IsWeaponAllowedByClass(X2WeaponTemplate WeaponTemplate)
{
    //local XComGameState_Unit UpdatedUnit;
    //local X2SoldierClassTemplate SoldierClassTemplate, AllowedSoldierClassTemplate;
	local int i;

    /*UpdatedUnit = GetUnit();
    SoldierClassTemplate = UpdatedUnit.GetSoldierClassTemplate();
    `log("X2SoldierClassTemplate_Cleaner detects soldier class" @ SoldierClassName.DisplayName,,'Simple Tac UI Cleaner',,'Simple Tac UI Cleaner');
    AllowedSoldierClassTemplate = class'UIUtilities_Strategy'.static.GetAllowedClassForWeapon(WeaponTemplate);
    `log("X2SoldierClassTemplate_Cleaner says allowed soldier class equals" @ AllowedSoldierClassTemplate.DisplayName,,'Simple Tac UI Cleaner',,'Simple Tac UI Cleaner');*/

	switch(WeaponTemplate.InventorySlot)
	{
	case eInvSlot_PrimaryWeapon: break;
    `log("X2SoldierClassTemplate_Cleaner primary slot checked",,'Simple Tac UI Cleaner',,'Simple Tac UI Cleaner');
	case eInvSlot_SecondaryWeapon: break;
    `log("X2SoldierClassTemplate_Cleaner secondary slot checked",,'Simple Tac UI Cleaner',,'Simple Tac UI Cleaner');
	default:
		return true;
	}

	for (i = 0; i < AllowedWeapons.Length; ++i)
	{
		if (/*AllowedSoldierClassTemplate == SoldierClassName.DisplayName && */WeaponTemplate.InventorySlot == AllowedWeapons[i].SlotType && WeaponTemplate.WeaponCat == AllowedWeapons[i].WeaponType)
			return true;
	}
	return false;
}