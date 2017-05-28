#include "\achilles\modules_f_ares\module_header.hpp"

private _dialogResult =
[
	"USS Freedom",
	[
		[localize "STR_DIRECTION", ["N","NE","E","SE","S","SW","W","NW"]]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
private _dir = 180 + (_dialogResult select 0) * 45;

[[getPosATL _logic, _dir],  
{
	params ["_posATL", "_dir"];
	
	_carrier = createVehicle ["Land_Carrier_01_base_F",_posATL,[],0,"CAN_COLLIDE"];
	_carrier setVectorDirAndUp [[sin _dir, cos _dir, 0], [0,0,1]];
	[_carrier] call BIS_fnc_Carrier01PosUpdate;
	_carrier_parts = _carrier getVariable "bis_carrierParts";
	{deleteVehicle (_x select 0)} forEach _carrier_parts;
	[_carrier] remoteExecCall ["BIS_fnc_Carrier01Init", 0, _carrier];
}] remoteExecCall ["call", 2];

#include "\achilles\modules_f_ares\module_footer.hpp"
