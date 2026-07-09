// Script by: spicybung

#define FILTERSCRIPT

#include <a_samp>

#if !defined KEY_AIM
    #define KEY_AIM (128)
#endif

#define LASER_STATE_OFF       0
#define LASER_STATE_SMALL     1
#define LASER_STATE_LONG      2

#define LASER_OBJECT_SLOT     1
#define LASER_DOT_SLOT        2

#define LASER_SMALL_OBJECT    18658
#define LASER_SMALL_DOT       19080

#define LASER_LONG_OBJECT     18651
#define LASER_LONG_DOT        19081

new PlayerLaserState[MAX_PLAYERS];

public OnFilterScriptInit()
{
    print("Laser pointer filterscript loaded.");
    return 1;
}

public OnFilterScriptExit()
{
    for (new playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
        if (IsPlayerConnected(playerid))
        {
            RemovePlayerLaser(playerid);
        }
    }

    print("Laser pointer filterscript unloaded.");
    return 1;
}

public OnPlayerConnect(playerid)
{
    PlayerLaserState[playerid] = LASER_STATE_OFF;
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    RemovePlayerLaser(playerid);
    return 1;
}

public OnPlayerSpawn(playerid)
{
    RemovePlayerLaser(playerid);
    SetPVarInt(playerid, "iCurrentWeapon", GetPlayerWeapon(playerid));
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    RemovePlayerLaser(playerid);
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    RemovePlayerLaser(playerid);
    return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
    if (IsPlayerInAnyVehicle(playerid))
    {
        return 1;
    }

    if ((newkeys & KEY_NO) && !(oldkeys & KEY_NO))
    {
        TogglePlayerLaser(playerid);
        return 1;
    }

    if (PlayerLaserState[playerid] != LASER_STATE_OFF)
    {
        if ((newkeys & KEY_AIM) && !(oldkeys & KEY_AIM))
        {
            ApplyPlayerLaser(playerid, true);
            return 1;
        }

        if (!(newkeys & KEY_AIM) && (oldkeys & KEY_AIM))
        {
            ApplyPlayerLaser(playerid, false);
            return 1;
        }
    }

    return 1;
}

public OnPlayerUpdate(playerid)
{
    new currentWeapon = GetPlayerWeapon(playerid);
    new previousWeapon = GetPVarInt(playerid, "iCurrentWeapon");

    if (currentWeapon != previousWeapon)
    {
        OnPlayerChangeWeapon(playerid, previousWeapon, currentWeapon);
        SetPVarInt(playerid, "iCurrentWeapon", currentWeapon);
    }

    return 1;
}

stock OnPlayerChangeWeapon(playerid, oldweapon, newweapon)
{
    if (PlayerLaserState[playerid] == LASER_STATE_OFF)
    {
        return 1;
    }

    ApplyPlayerLaser(playerid, IsPlayerAiming(playerid));
    return 1;
}

stock TogglePlayerLaser(playerid)
{
    switch (PlayerLaserState[playerid])
    {
        case LASER_STATE_OFF:
        {
            PlayerLaserState[playerid] = LASER_STATE_SMALL;
            ApplyPlayerLaser(playerid, IsPlayerAiming(playerid));
        }

        case LASER_STATE_SMALL:
        {
            PlayerLaserState[playerid] = LASER_STATE_LONG;
            ApplyPlayerLaser(playerid, IsPlayerAiming(playerid));
        }

        case LASER_STATE_LONG:
        {
            RemovePlayerLaser(playerid);
        }
    }

    return 1;
}

stock RemovePlayerLaser(playerid)
{
    if (IsPlayerAttachedObjectSlotUsed(playerid, LASER_OBJECT_SLOT))
    {
        RemovePlayerAttachedObject(playerid, LASER_OBJECT_SLOT);
    }

    if (IsPlayerAttachedObjectSlotUsed(playerid, LASER_DOT_SLOT))
    {
        RemovePlayerAttachedObject(playerid, LASER_DOT_SLOT);
    }

    PlayerLaserState[playerid] = LASER_STATE_OFF;
    return 1;
}

stock ApplyPlayerLaser(playerid, bool:isAiming)
{
    if (PlayerLaserState[playerid] == LASER_STATE_OFF)
    {
        RemoveAttachedLaserObjectsOnly(playerid);
        return 1;
    }

    RemoveAttachedLaserObjectsOnly(playerid);

    if (isAiming && IsLaserWeapon(GetPlayerWeapon(playerid)))
    {
        ApplyAimingLaser(playerid);
    }
    else
    {
        ApplyIdleLaser(playerid);
    }

    return 1;
}

stock RemoveAttachedLaserObjectsOnly(playerid)
{
    if (IsPlayerAttachedObjectSlotUsed(playerid, LASER_OBJECT_SLOT))
    {
        RemovePlayerAttachedObject(playerid, LASER_OBJECT_SLOT);
    }

    if (IsPlayerAttachedObjectSlotUsed(playerid, LASER_DOT_SLOT))
    {
        RemovePlayerAttachedObject(playerid, LASER_DOT_SLOT);
    }

    return 1;
}

stock ApplyIdleLaser(playerid)
{
    switch (PlayerLaserState[playerid])
    {
        case LASER_STATE_SMALL:
        {
            SetPlayerAttachedObject(
                playerid,
                LASER_OBJECT_SLOT,
                LASER_SMALL_OBJECT,
                5,
                0.100000,
                0.038000,
                -0.100000,
                0.000000,
                0.000000,
                0.000000,
                0.030000,
                0.030000,
                0.030000
            );

            SetPlayerAttachedObject(
                playerid,
                LASER_DOT_SLOT,
                LASER_SMALL_DOT,
                5,
                0.100000,
                0.020000,
                -0.050000,
                0.000000,
                0.000000,
                0.000000,
                1.000000,
                1.000000,
                1.000000
            );
        }

        case LASER_STATE_LONG:
        {
            SetPlayerAttachedObject(
                playerid,
                LASER_OBJECT_SLOT,
                LASER_LONG_OBJECT,
                5,
                0.100000,
                0.038000,
                -0.010000,
                0.000000,
                0.000000,
                0.000000,
                0.030000,
                0.100000,
                0.030000
            );

            SetPlayerAttachedObject(
                playerid,
                LASER_DOT_SLOT,
                LASER_LONG_DOT,
                5,
                0.100000,
                0.020000,
                -0.050000,
                0.000000,
                0.000000,
                0.000000,
                1.000000,
                1.000000,
                1.000000
            );
        }
    }

    return 1;
}

stock ApplyAimingLaser(playerid)
{
    switch (PlayerLaserState[playerid])
    {
        case LASER_STATE_SMALL:
        {
            SetPlayerAttachedObject(
                playerid,
                LASER_OBJECT_SLOT,
                LASER_SMALL_OBJECT,
                6,
                0.250000,
                -0.015500,
                0.160000,
                0.000000,
                0.000000,
                0.000000,
                0.030000,
                0.030000,
                0.030000
            );

            SetPlayerAttachedObject(
                playerid,
                LASER_DOT_SLOT,
                LASER_SMALL_DOT,
                6,
                0.200000,
                0.010000,
                0.160000,
                0.000000,
                0.000000,
                0.000000,
                1.000000,
                1.000000,
                1.000000
            );
        }

        case LASER_STATE_LONG:
        {
            SetPlayerAttachedObject(
                playerid,
                LASER_OBJECT_SLOT,
                LASER_LONG_OBJECT,
                6,
                0.160000,
                -0.015500,
                0.160000,
                0.000000,
                0.000000,
                0.000000,
                0.030000,
                0.100000,
                0.030000
            );

            SetPlayerAttachedObject(
                playerid,
                LASER_DOT_SLOT,
                LASER_LONG_DOT,
                6,
                0.200000,
                0.010000,
                0.160000,
                0.000000,
                0.000000,
                0.000000,
                1.000000,
                1.000000,
                1.000000
            );
        }
    }

    return 1;
}

stock bool:IsPlayerAiming(playerid)
{
    new keys;
    new updown;
    new leftright;

    GetPlayerKeys(playerid, keys, updown, leftright);

    return bool:(keys & KEY_AIM);
}

stock bool:IsLaserWeapon(weaponid)
{
    switch (weaponid)
    {
        case WEAPON_DEAGLE,
             WEAPON_M4,
             WEAPON_SHOTGUN:
        {
            return true;
        }
    }

    return false;
}