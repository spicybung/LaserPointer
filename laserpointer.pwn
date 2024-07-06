// Script by: spicybung

#define FILTERSCRIPT

#include <a_samp>
#define KEY_AIM (128)

new laser[MAX_PLAYERS]; // Use an array to store the laser state for each player

public OnPlayerKeyStateChange(playerid,KEY:newkeys,KEY:oldkeys)
{
    if (newkeys & KEY_NO && !IsPlayerInAnyVehicle(playerid))
    {
        if (laser[playerid] == 0)
        {
            SetPlayerAttachedObject(playerid, 1, 18658, 5, 0.1, 0.038, -0.1, 0, 0, 0, 0.03, 0.03, 0.03); // Rotation adjusted
            SetPlayerAttachedObject(playerid, 2, 19080, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
            laser[playerid] = 1;
            return 1;
        }
        else if (laser[playerid] == 1)
        {
            SetPlayerAttachedObject(playerid, 1, 18658, 5, 0.1, 0.038, -0.01, 0, 0, 0, 0.03, 0.1, 0.03); // Rotation adjusted
            SetPlayerAttachedObject(playerid, 2, 19080, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
            laser[playerid] = 2;
            return 1;
        }
        else if (laser[playerid] == 2)
        {
            RemovePlayerAttachedObject(playerid, 1);
            RemovePlayerAttachedObject(playerid, 2);
            laser[playerid] = 0;
            return 1;
        }
    }
    if (newkeys & KEY_AIM && !IsPlayerInAnyVehicle(playerid))
    {
        if (laser[playerid] == 1)
        {
            RemovePlayerAttachedObject(playerid, 1);
            RemovePlayerAttachedObject(playerid, 2);
            SetPlayerAttachedObject(playerid, 1, 18658, 6, 0.25, -0.0155, 0.16, 0, 0, 0, 0.03, 0.03, 0.03); // Rotation adjusted
            SetPlayerAttachedObject(playerid, 2, 19080, 6, 0.2, 0.01, 0.16, 0, 0, 0, 1, 1, 1);
            laser[playerid] = 1;
            return 1;
        }
        else if (laser[playerid] == 2)
        {
            RemovePlayerAttachedObject(playerid, 1);
            RemovePlayerAttachedObject(playerid, 2);
            SetPlayerAttachedObject(playerid, 1, 18651, 6, 0.16, -0.0155, 0.16, 0, 0, 0, 0.03, 0.1, 0.03); // Rotation adjusted
            SetPlayerAttachedObject(playerid, 2, 19081, 6, 0.2, 0.01, 0.16, 0, 0, 0, 1, 1, 1);
            laser[playerid] = 2;
            return 1;
        }
    }
    return 1;
}

public OnPlayerUpdate(playerid)
{
    new iCurWeap = GetPlayerWeapon(playerid);
    if (iCurWeap != GetPVarInt(playerid, "iCurrentWeapon"))
    {
        OnPlayerChangeWeapon(playerid, GetPVarInt(playerid, "iCurrentWeapon"), iCurWeap);
        SetPVarInt(playerid, "iCurrentWeapon", iCurWeap);
    }
    return 1;
}

stock OnPlayerChangeWeapon(playerid, oldweapon, newweapon)
{
    new oWeapon[24], nWeapon[24];

    GetWeaponName(WEAPON:oldweapon, oWeapon, sizeof(oWeapon));
    GetWeaponName(WEAPON:newweapon, nWeapon, sizeof(nWeapon));
    if (WEAPON:newweapon == WEAPON_DEAGLE || WEAPON:newweapon == WEAPON_M4 || WEAPON:newweapon == WEAPON_SHOTGUN)
    {
        if (laser[playerid] == 1)
        {
            SetPlayerAttachedObject(playerid, 1, 18658, 6, 0.25, -0.0155, 0.16, 0, 0, 0, 0.03, 0.03, 0.03); // Rotation adjusted
            SetPlayerAttachedObject(playerid, 2, 19080, 6, 0.2, 0.01, 0.16, 0, 0, 0, 1, 1, 1);
            laser[playerid] = 1;
            return 1;
        }
        else if (laser[playerid] == 2)
        {
            SetPlayerAttachedObject(playerid, 1, 18651, 6, 0.16, -0.0155, 0.16, 0, 0, 0, 0.03, 0.1, 0.03); // Rotation adjusted
            SetPlayerAttachedObject(playerid, 2, 19081, 6, 0.2, 0.01, 0.16, 0, 0, 0, 1, 1, 1);
            laser[playerid] = 2;
            return 1;
        }
    }
    else
    {
        if (laser[playerid] == 1)
        {
            SetPlayerAttachedObject(playerid, 1, 18658, 5, 0.1, 0.038, -0.1, 0, 0, 0, 0.03, 0.03, 0.03); // Rotation adjusted
            SetPlayerAttachedObject(playerid, 2, 19080, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
            laser[playerid] = 1;
            return 1;
        }
        else if (laser[playerid] == 2)
        {
            SetPlayerAttachedObject(playerid, 1, 18651, 5, 0.1, 0.038, -0.01, 0, 0, 0, 0.03, 0.1, 0.03); // Rotation adjusted
            SetPlayerAttachedObject(playerid, 2, 19081, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
            laser[playerid] = 2;
            return 1;
        }
    }
    return 1;
}
