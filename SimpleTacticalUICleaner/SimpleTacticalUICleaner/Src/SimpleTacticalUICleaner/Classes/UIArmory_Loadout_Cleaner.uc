//---------------------------------------------------------------------------------------
//  FILE:    UIArmory_Loadout_Cleaner
//  AUTHOR:  Kregano
//  PURPOSE: UI for viewing and modifying a Soldiers equipment, now with filter to match 
//---------------------------------------------------------------------------------------

class UIArmory_Loadout_Cleaner extends UIArmory_Loadout;

function bool IsWeaponAllowedByClass_Cleaner(X2SoldierClassTemplate ClassTemplate, X2WeaponTemplate WeaponTemplate)
{
	local int i;

	`log("IsWeaponAllowedByClass_Cleaner triggered for weapon" @ WeaponTemplate.DataName,,'Simple Tac UI Cleaner');
	switch(WeaponTemplate.InventorySlot)
	{
	case eInvSlot_PrimaryWeapon: break;
	case eInvSlot_SecondaryWeapon: break;
	default:
		return true;
	}

	for (i = 0; i < class'X2SoldierClassTemplate'.default.AllowedWeapons.Length; ++i)
	{
		if (ClassTemplate.DataName != class'X2SoldierClassTemplateManager'.default.DefaultSoldierClass && WeaponTemplate.InventorySlot == class'X2SoldierClassTemplate'.default.AllowedWeapons[i].SlotType && WeaponTemplate.WeaponCat == class'X2SoldierClassTemplate'.default.AllowedWeapons[i].WeaponType)
			return true;
			`log("IsWeaponAllowedByClass_Cleaner checked a weapon",,'Simple Tac UI Cleaner');
	}
	return false;
	`log("IsWeaponAllowedByClass_Cleaner has returned false",,'Simple Tac UI Cleaner');
}

simulated function bool ShowInLockerList(XComGameState_Item Item, EInventorySlot SelectedSlot)
{
	local X2ItemTemplate ItemTemplate;
	local XComGameState_Unit UnitState;
	local StateObjectReference UnitRef;
	local X2SoldierClassTemplateManager SoldierClassTemplateManager;
	local X2SoldierClassTemplate SoldierClassName;
	local X2GrenadeTemplate GrenadeTemplate;
	local X2EquipmentTemplate EquipmentTemplate;
	local X2WeaponTemplate WeaponTemplate;

	ItemTemplate = Item.GetMyTemplate();
	//SoldierClassTemplateManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	//SoldierClass = SoldierClassTemplateManager.FindSoldierClassTemplate('TemplateName');
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));
	SoldierClassName = UnitState.GetSoldierClassTemplate().DataName;
	`log("ShowInLockerList triggered for class" @ SoldierClassName.DataName,,'Simple Tac UI Cleaner');
	
		if(MeetsAllStrategyRequirements(ItemTemplate.ArmoryDisplayRequirements) && MeetsDisplayRequirement(ItemTemplate))
	{
		`log("ShowInLockerList running",,'Simple Tac UI Cleaner');
		switch(SelectedSlot)
		{
		case eInvSlot_PrimaryWeapon:
			WeaponTemplate = X2WeaponTemplate(ItemTemplate);
			return (WeaponTemplate != none && IsWeaponAllowedByClass_Cleaner(SoldierClassName, WeaponTemplate));
			`log("Primary weapon slot filtered",,'Simple Tac UI Cleaner');
		case eInvSlot_SecondaryWeapon:
			WeaponTemplate = X2WeaponTemplate(ItemTemplate);
			return (WeaponTemplate != none && IsWeaponAllowedByClass_Cleaner(SoldierClassName, WeaponTemplate) == true);
			`log("Secondary weapon slot filtered",,'Simple Tac UI Cleaner');
		case eInvSlot_GrenadePocket:
			GrenadeTemplate = X2GrenadeTemplate(ItemTemplate);
			return GrenadeTemplate != none;
			`log("Grenade slot",,'Simple Tac UI Cleaner');
		case eInvSlot_AmmoPocket:
			return ItemTemplate.ItemCat == 'ammo';
			`log("Ammo pocket",,'Simple Tac UI Cleaner');
		default:
			EquipmentTemplate = X2EquipmentTemplate(ItemTemplate);
			// xpad is only item with size 0, that is always equipped
			return (EquipmentTemplate != none && EquipmentTemplate.iItemSize > 0 && EquipmentTemplate.InventorySlot == SelectedSlot);
			`log("Equipment slot",,'Simple Tac UI Cleaner');
		}
	}

	return false;
	//}
}