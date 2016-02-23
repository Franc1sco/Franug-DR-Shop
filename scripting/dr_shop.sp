#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <multicolors>
#pragma semicolon 1

#define VERSION "1.0"


public Plugin:myinfo =
{
    name = "DR Shop",
    author = "Franc1sco franug",
    description = "",
    version = VERSION,
};

public OnPluginStart()
{

	RegConsoleCmd("sm_shop", SHOPMENU);
	RegConsoleCmd("sm_ctshop", SHOPMENU);
}


public Action:SHOPMENU(client,args)
{
	DID(client);
	return Plugin_Handled;
}

public Action:DID(clientId) 
{
	new Handle:menu = CreateMenu(DIDMenuHandler);
	SetMenuTitle(menu, "DeathRun Shop");
	
	AddMenuItem(menu, "option1", "+20hp 3000$");	
	AddMenuItem(menu, "option2", " Speed 5000$");
	
	AddMenuItem(menu, "option3", "Gravity 8000$");	
	AddMenuItem(menu, "option4", "Respawn 12000$");
		
	
	SetMenuExitButton(menu, true);
	DisplayMenu(menu, clientId, MENU_TIME_FOREVER);
}

public DIDMenuHandler(Handle:menu, MenuAction:action, client, itemNum) 
{
	if ( action == MenuAction_Select ) 
	{
		new String:info[32];

		GetMenuItem(menu, itemNum, info, sizeof(info));

		if ( strcmp(info,"option1") == 0 ) 
		{
			DID(client);		
			if (GetMoney(client) >= 3000)
			{
				if (IsPlayerAlive(client))
				{
					
					CPrintToChat(client, "{green}You bought +20 hp");
					SetEntityHealth(client, GetClientHealth(client) + 20);
					SetMoney(client, GetMoney(client) - 3000);
					return;
				}
				else
				{
					CPrintToChat(client, "{green}You need to be alive");
					return;
				}
			}
			else
			{
				CPrintToChat(client, "{green}You need more money");
				return;
			}
		
		}

		else if ( strcmp(info,"option2") == 0 ) 
		{
			DID(client);		
			if (GetMoney(client) >= 5000)
			{
				if (IsPlayerAlive(client))
				{
					
					CPrintToChat(client, "{green}You bought speed");
					SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 1.2);
					SetMoney(client, GetMoney(client) - 5000);
					return;
				}
				else
				{
					CPrintToChat(client, "{green}You need to be alive");
					return;
				}
			}
			else
			{
				CPrintToChat(client, "{green}You need more money");
				return;
			}
		
		}
		else if ( strcmp(info,"option3") == 0 ) 
		{
			DID(client);		
			if (GetMoney(client) >= 8000)
			{
				if (IsPlayerAlive(client))
				{
					
					CPrintToChat(client, "{green}You bought gravity");
					SetEntityGravity(client, 0.5);
					SetMoney(client, GetMoney(client) - 8000);
					return;
				}
				else
				{
					CPrintToChat(client, "{green}You need to be alive");
					return;
				}
			}
			else
			{
				CPrintToChat(client, "{green}You need more money");
				return;
			}
		
		}
		else if ( strcmp(info,"option4") == 0 ) 
		{
			DID(client);		
			if (GetMoney(client) >= 12000)
			{
				if (!IsPlayerAlive(client) && GetClientTeam(client) > 1)
				{
					
					CPrintToChat(client, "{green}You bought respawn");
					CS_RespawnPlayer(client);
					SetMoney(client, GetMoney(client) - 12000);
					return;
				}
				else
				{
					CPrintToChat(client, "{green}You need to be dead");
					return;
				}
			}
			else
			{
				CPrintToChat(client, "{green}You need more money");
				return;
			}
		
		}
	}
	else if (action == MenuAction_End)
	{
		CloseHandle(menu);
	}
}

public int GetMoney(int client)
{
    return GetEntProp(client, Prop_Send, "m_iAccount");
}

public void SetMoney(int client, int money)
{
    SetEntProp(client, Prop_Send, "m_iAccount", money);
}  