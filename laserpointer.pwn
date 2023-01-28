//Script by: spicybung

#define FILTERSCRIPT

#include <a_samp>
#define KEY_AIM (128)

new flashlight;

public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
		if(newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
		{
		    if(flashlight==0)
		    {
          		SetPlayerAttachedObject(playerid, 1,18658, 5, 0.1, 0.038, -0.1, -90, 180, 0, 0.03, 0.03, 0.03);
				SetPlayerAttachedObject(playerid, 2,19080, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
				flashlight=1;
				return 1;
			}
			else if(flashlight==1)
			{
				SetPlayerAttachedObject(playerid, 1,18658, 5, 0.1, 0.038, -0.01, -90, 180, 0, 0.03, 0.1, 0.03);
				SetPlayerAttachedObject(playerid, 2,19080, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
				flashlight=2;
				return 1;
			}
			else if(flashlight==2)
			{
				RemovePlayerAttachedObject(playerid,1);
				RemovePlayerAttachedObject(playerid,2);
				flashlight=0;
				return 1;
			}
        }
        if(newkeys & KEY_AIM && !IsPlayerInAnyVehicle(playerid))
 		{
		    if(flashlight==1)
		    {
		        RemovePlayerAttachedObject(playerid,1);
				RemovePlayerAttachedObject(playerid,2);
				SetPlayerAttachedObject(playerid, 1,18658, 6, 0.25, -0.0155, 0.16, 86.5, -185, 86.5, 0.03, 0.03, 0.03);
				SetPlayerAttachedObject(playerid, 2,19080, 6, 0.2, 0.01, 0.16, 90, -95, 90, 1, 1, 1);
				flashlight=1;
				return 1;
			}
			else if(flashlight==2)
			{
			    RemovePlayerAttachedObject(playerid,1);
				RemovePlayerAttachedObject(playerid,2);
				SetPlayerAttachedObject(playerid, 1,18651, 6, 0.16, -0.0155, 0.16, 86.5, -185, 86.5, 0.03, 0.1, 0.03);
				SetPlayerAttachedObject(playerid, 2,19081, 6, 0.2, 0.01, 0.16, 90, -95, 90, 1, 1, 1);
				flashlight=2;
				return 1;
			}
        }
        return 1;
}
public OnPlayerUpdate(playerid)
{
    new iCurWeap = GetPlayerWeapon(playerid);
    if(iCurWeap != GetPVarInt(playerid, "iCurrentWeapon"))
    {
        OnPlayerChangeWeapon(playerid, GetPVarInt(playerid, "iCurrentWeapon"), iCurWeap);
        SetPVarInt(playerid, "iCurrentWeapon", iCurWeap);
    }
    return 1;
}

stock OnPlayerChangeWeapon(playerid, oldweapon, newweapon)
{
	new oWeapon[24],
		nWeapon[24];

	GetWeaponName(oldweapon, oWeapon, sizeof(oWeapon));
	GetWeaponName(newweapon, nWeapon, sizeof(nWeapon));
 	if(newweapon==WEAPON_DEAGLE || newweapon==WEAPON_M4 || newweapon==WEAPON_SHOTGUN)
 	{
 			if(flashlight==1)
			{
				SetPlayerAttachedObject(playerid, 1,18658, 6, 0.25, -0.0155, 0.16, 86.5, -185, 86.5, 0.03, 0.03, 0.03);
				SetPlayerAttachedObject(playerid, 2,19080, 6, 0.2, 0.01, 0.16, 90, -95, 90, 1, 1, 1);
				flashlight=1;
				return 1;
			}
			else if(flashlight==2)
			{
				SetPlayerAttachedObject(playerid, 1,18651, 6, 0.16, -0.0155, 0.16, 86.5, -185, 86.5, 0.03, 0.1, 0.03);
				SetPlayerAttachedObject(playerid, 2,19081, 6, 0.2, 0.01, 0.16, 90, -95, 90, 1, 1, 1);
				flashlight=2;
				return 1;
			}
	}
	else
	{
	 		if(flashlight==1)
		    {
          		SetPlayerAttachedObject(playerid, 1,18658, 5, 0.1, 0.038, -0.1, -90, 180, 0, 0.03, 0.03, 0.03);
				SetPlayerAttachedObject(playerid, 2,19080, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
				flashlight=1;
				return 1;
			}
			else if(flashlight==2)
			{
				SetPlayerAttachedObject(playerid, 1,18651, 5, 0.1, 0.038, -0.01, -90, 180, 0, 0.03, 0.1, 0.03);
				SetPlayerAttachedObject(playerid, 2,19081, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
				flashlight=2;
				return 1;
			}
	}
    return 1;
}
