//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 1.2 - 2007    //
//--------------------------//
//    DAC_Create_Objects    //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

private [
			"_DAC_WP_Typ","_wpConfig","_CheckRadius1","_CheckRadius2","_checkAreaH","_checkNear","_checkObjH1","_dist","_isLogic",
			"_checkMaxH","_checkMinH","_checkCount","_MTemp","_TempArray","_checkObjH2","_tnr","_wpc","_DumyA","_action","_debA",
			"_DumyB","_Null","_PosNull","_wpnr","_chnr","_DAC_Count_WP","_DAC_SelectZone","_KiZone","_mb","_mType","_check","_customWP",
			"_tempList","_checkwp","_DAC_ActivZoneY","_RandomX","_RandomY","_wn","_scr","_objSetHeight","_objSetVector","_objNearRoad","_mz",
			"_DAC_ZoneRadiusX","_DAC_ZoneRadiusY","_zPoly","_PosMin","_PosMax","_nr","_cv","_cr","_np","_cd","_allObjects","_relObjects","_wpi",
			"_m","_DAC_WP_Nr","_diff","_warray","_i","_go","_obj","_newo","_obj_Nr","_DAC_PolyCount","_segm","_objArray","_DPos","_ma","_run","_objRes","_markerVal",
			"_objConfig","_newObjArray","_inst","_arrayName","_pc","_px","_py","_xd","_yd","_rx","_ry","_rsin","_rcos","_logA","_vec1","_vec2","_vec3","_objNearWater"
		];
		
			_KiZone = objNull;_m = "";_ma = "";_cd = 0;_DPos = [];_checkCount = 0;_checkNear = 0;_mb = "";_action = true;_scr = "";_wpi = 0;
			_wpConfig = [];_objConfig = [];_RandomX = 0;_RandomY = 0;_DAC_Count_WP = _this select 1;_wpc = _this select 2;_dist = 0;_check = -1;_mz = 0;
			_MTemp = [];_TempArray = [];_newObjArray = [];_run = 3;_go = 0;_DAC_WP_Nr = 0;_obj = objNull;_logA = [];_wn = 1;_arrayName = "";_objRes = [];
			_newo = "";_DAC_WP_Typ = _this select 3;_DAC_PolyCount = [];_obj_Nr = _this select 4;_segm = 2;_mType = [1,"ColorBlack",20];_customWP = [];
			_inst = _this select 5;_pc = 0;_px = 0;_py = 0;_xd = 0;_yd = 0;_rx = 0;_ry = 0;_rsin = 0;_rcos = 0;_objArray = _this select 6;_debA = [];_objNearWater = 1;
			_objSetHeight = 0;_objSetVector = 0;_objNearRoad = 0;_DAC_ZoneRadiusX = 0;_DAC_ZoneRadiusY = 0;_vec1 = 0;_vec2 = 0;_vec3 = 0;_isLogic = false;_markerVal = [];

waituntil{format["%1",!isNil 'DAC_Basic_Value'] == "true"};
			
if(isServer || (name player == f_HC_name)) then
{		
	_scr = _this execVM "DAC\Scripts\DAC_Check_ObjScr.sqf";
	waituntil {scriptdone _scr};
	if(count _objArray > 1) then
	{
		if(format["%1",(_objArray select 0)] != "ANY") then
		{
			if((typeName (_objArray select 0)) != "ARRAY") then
			{
				if((count (triggerArea (_objArray select 0))) > 0) then
				{
					waituntil{(format["%1",(_objArray select 0) getVariable "objCreated"] != "<NULL>")};
					sleep 0.1;
					_objRes = call compile format["%1",((_objArray select 0) getVariable "objCreated")];
				};
			};
		};
	};	
	if(DAC_Basic_Value != 10) then
	{
		_KiZone = call compile (_this select 0);
		if((_wpc + _DAC_WP_Typ) == 0) then
		{
			if(count _objRes > 0) then {_objArray set [0,_objRes]};
			[(_this select 0),_DAC_Count_WP,_obj_Nr,_inst,_objArray,(_this select 7)] execVM "DAC\Scripts\DAC_SimplePos_Objects.sqf";
		}
		else
		{
			if(count _objArray > 1) then
			{
				if(count _this == 8) then
				{
					if((typeName (_objArray select 0)) == "ARRAY") then
					{
						if((format["%1",typeOf ((_objArray select 0) select 0)]) == "LOGIC") then
						{
							while{(((getwppos[((_objArray select 0) select 0),_wn]) select 0) != 0)} do
							{
								_logA = _logA + [getwppos[((_objArray select 0) select 0),_wn]];_wn = _wn + 1;
							};
						};
					}
					else
					{
						if((format["%1",typeOf (_objArray select 0)]) == "LOGIC") then
						{
							while{(((getwppos[(_objArray select 0),_wn]) select 0) != 0)} do
							{
								_logA = _logA + [getwppos[(_objArray select 0),_wn]];_wn = _wn + 1;
							};
						};
					};
				}
				else
				{
					_logA = _this select 10;
				};
				if(count _this == 8) then
				{
					_dist = (_objArray select ((count _objArray) - 1));
					_objArray = _objArray - [(_objArray select ((count _objArray) - 1))];
				}
				else
				{
					_dist = _this select 8;
				};
			}
			else
			{
				if(count _this > 8) then {_dist = _this select 8;_logA = _this select 10};
			};
			if(count _objRes > 0) then {_objArray set [0,_objRes]};
			_arrayName = _this select 7;
			if(!(format["%1",_arrayName] == "")) then
			{
				if(format["%1",call compile _arrayName] == "ANY") then {call compile format["%1 = []",_arrayName]} else {call compile _arrayName};
			};
			sleep 0.1;
			if(count _this == 8) then
			{
				if(_inst > 0) then
				{
					_DAC_Count_WP = _DAC_Count_WP / _segm;
					if(round(_DAC_Count_WP) != _DAC_Count_WP) then
					{
						[(_this select 0),(_DAC_Count_WP - 0.5),_wpc,_DAC_WP_Typ,_obj_Nr,_inst,_objArray,(_this select 7),_dist,objNull,_logA] execVM "DAC\Scripts\DAC_Create_Objects.sqf";
					}
					else
					{
						[(_this select 0),_DAC_Count_WP,_wpc,_DAC_WP_Typ,_obj_Nr,_inst,_objArray,(_this select 7),_dist,objNull,_logA] execVM "DAC\Scripts\DAC_Create_Objects.sqf";
					};
					_mType set[0,2];_mType set[1,"ColorBlue"];_mType set[2,20];
				}
				else
				{
					_mType set[0,1];_mType set[1,"ColorBlack"];_mType set[2,0];
				};
				if(count _logA > 0) then
				{
					if(DAC_Marker > 0) then
					{
						if((DAC_Marker_Val select 1) > 0) then
						{
							while{_mz < count _logA} do
							{
								_m = format["m%1%2%3",_mz,time,_KiZone];
								_ma = createmarkerlocal [_m, (_logA select _mz)];
								_ma setMarkerShapelocal "ELLIPSE";_ma setMarkerSizelocal [_dist, _dist];
								_ma setMarkerBrush "BORDER"; 
								_ma setMarkerColorlocal "ColorBlack";
								if((DAC_Marker_Val select 1) == 1) then {_MTemp set [count _MTemp,_ma]};
								_mz = _mz + 1;
							};
						};
					};
				};
			}
			else
			{
				_mType set[0,3];_mType set[1,"ColorBlue"];_mType set[2,-20];
			};
			DAC_Obj_Init set [count DAC_Obj_Init,format["%1%2",_KiZone,count _this]];
			sleep (random 0.5);
			while {_run > 0} do
			{
				switch (_run) do
				{
					case 3:	{
								_DumyA = "logic" createvehiclelocal [0,0,0];
								_DumyB = "logic" createvehiclelocal [0,0,0];
								_Null = "EmptyDetector" createvehiclelocal [0,0,0];
								_PosNull = 0;_wpnr = 0;_chnr = 0;
								while{_action} do
								{
									_wpConfig = [_DAC_WP_Typ,_wpc] call DAC_fConfigWP;
									_objConfig = [_obj_Nr] call DAC_fConfigObj;
									_customWP = [_KiZone] call DAC_fFindWpLog;
									sleep 0.1;
									if(({(format["%1",_x] == "ANY")} count [_wpConfig,_objConfig,_customWP]) == 0) then {_action = false};
								};
								if((count _wpConfig == 0) || (count _objConfig == 0)) then
								{
									if(count _wpConfig == 0) then {player sidechat "DAC_Create_Object: bad wp_config";_run = 0};
									if(count _objConfig == 0) then {player sidechat "DAC_Create_Object: bad obj_config";_run = 0};
								}
								else
								{
									_action = true;
									if((_mType select 0) == 3) then {_wpi = -1} else {_wpi = ((count _customWP) - 1)};
									while{_action} do
									{
										_newObjArray = [_objConfig] call DAC_fFillArray;
										sleep 0.1;
										if(format["%1",_newObjArray] != "ANY") then
										{
											if(DAC_Marker > 0) then
											{
												if((DAC_Marker_Val select 1) > 0) then
												{
													_m = format["m%1%2",_KiZone,(_mType select 0)];
													_mb = createmarkerlocal [_m, [(position _KiZone select 0)-20,(position _KiZone select 1) + (_mType select 2)]];
													_mb setMarkerTypelocal "dot";
													_mb setMarkerSizelocal [0.005,0.005];
													_mb setMarkerColorlocal "ColorBlue";
													_mb setMarkerTextLocal "0";
													if((DAC_Marker_Val select 1) == 1) then {_MTemp set [count _MTemp,_mb]};
												};
											};
											_action = false
										};
									};
									_CheckRadius1 = ((_wpConfig select 0) select 0);_CheckRadius2 = ((_wpConfig select 0) select 1);
									_checkAreaH = _wpConfig select 1;_checkNear = _wpConfig select 2;
									_checkObjH1 = ((_wpConfig select 3) select 0);_checkObjH2 = ((_wpConfig select 3) select 1);
									_checkMaxH = _wpConfig select 4;_checkMinH = _wpConfig select 5;_checkCount = _wpConfig select 6;
									_checkResol = ((_wpConfig select 0) select 2);_objNearRoad = ((_newObjArray select 0) select 0);_objNearWater = ((_newObjArray select 0) select 1);
									_DAC_ZoneRadiusX = ((triggerArea _KiZone) select 0);_DAC_ZoneRadiusY = ((triggerArea _KiZone) select 1);
									_DAC_PolyCount = [_KiZone] call DAC_fFindPolyLog;
									if(count _DAC_PolyCount == 0) then
									{
										[_KiZone,10,_DAC_ZoneRadiusX,_DAC_ZoneRadiusY,0] execVM "DAC\Marker\DAC_ZoneMarker.sqf";
									}
									else
									{
										[_KiZone,10,0,_DAC_PolyCount,0] execVM "DAC\Marker\DAC_ZoneMarker.sqf";
										while{_pc < count _DAC_PolyCount} do
										{
											if(_pc == 0) then
											{
												_px = ((_DAC_PolyCount select _pc) select 0);_xd = ((_DAC_PolyCount select _pc) select 0);
												_py = ((_DAC_PolyCount select _pc) select 1);_yd = ((_DAC_PolyCount select _pc) select 1);
											}
											else
											{
												if(((_DAC_PolyCount select _pc) select 0) < _px) then
												{
													_px = ((_DAC_PolyCount select _pc) select 0);
												}
												else
												{
													if(((_DAC_PolyCount select _pc) select 0) > _xd) then {_xd = ((_DAC_PolyCount select _pc) select 0)};
												};
												if(((_DAC_PolyCount select _pc) select 1) < _py) then
												{
													_py = ((_DAC_PolyCount select _pc) select 1);
												}
												else
												{
													if(((_DAC_PolyCount select _pc) select 1) > _yd) then {_yd = ((_DAC_PolyCount select _pc) select 1)};
												};
											};
											_pc = _pc + 1;
										};
									};
									_run = 7;
								};
							};
					case 7:	{
								_go = 1;
								while {_go > 0} do
								{
									if(_chnr > _checkCount) then
									{
										_run = 12;_go = 0;
									}
									else
									{
										if(_wpi >= 0) then
										{
											_RandomX = ((_customWP Select _wpi) select 0);_RandomY = ((_customWP Select _wpi) select 1);
											_run = 11;_go = 0;
										}
										else
										{
											if(count _DAC_PolyCount > 0) then
											{
												_polyResult = [[_px,_py],(_xd - _px),(_yd - _py),_DAC_PolyCount] call DAC_fFindPolyPos;
												_RandomX = (_polyResult Select 0);_RandomY = (_polyResult Select 1);
											}
											else
											{
												if((triggerarea _KiZone) select 3) then
												{
													_rx = random (_DAC_ZoneRadiusX * 2);_ry = random (_DAC_ZoneRadiusY * 2);
													_rsin = [(position _KiZone Select 0) + (Sin (((triggerarea _KiZone) select 2) + 90) * ((-_DAC_ZoneRadiusX) + _rx)),(position _KiZone Select 1) + (Cos (((triggerarea _KiZone) select 2) + 90) * ((-_DAC_ZoneRadiusX) + _rx))];
													_rcos = [(_rsin Select 0) + (Sin ((triggerarea _KiZone) select 2) * ((-_DAC_ZoneRadiusY) + _ry)),(_rsin Select 1) + (Cos ((triggerarea _KiZone) select 2) * ((-_DAC_ZoneRadiusY) + _ry))];
													_RandomX = (_rcos Select 0);_RandomY = (_rcos Select 1);
												}
												else
												{
													_ellipsResult = [_KiZone,_DAC_ZoneRadiusX,_DAC_ZoneRadiusY] call DAC_fFindEllipsPos;
													_RandomX = (_ellipsResult Select 0);_RandomY = (_ellipsResult Select 1);
												};
											};
											if((_checkMinH > 0) && (_checkMaxH > 0)) then
											{
												if(_objNearWater == 0) then
												{
													_Null setpos [_RandomX,_RandomY,0];_DumyA setpos [_RandomX,_RandomY,0];
													if((getPosASL _Null select 2 > _checkminh) && (getPosASL _Null select 2 < _checkmaxh)) then
													{
														_run = 8;_go = 0;
													}
													else
													{
														_chnr = _chnr + 1;
													};
												}
												else
												{
													if(surfaceIsWater [_RandomX, _RandomY]) then
													{
														_chnr = _chnr + 1;
													}
													else
													{
														_Null setpos [_RandomX,_RandomY,0];_DumyA setpos [_RandomX,_RandomY,0];
														if((getPosASL _Null select 2 > _checkminh) && (getPosASL _Null select 2 < _checkmaxh)) then
														{
															_run = 8;_go = 0;
														}
														else
														{
															_chnr = _chnr + 1;
														};
													};
												};
											}
											else
											{
												_run = 8;_go = 0;
											};
										};
									};
								};
							};
					case 8:	{
								_PosMin = (getPosASL _Null select 2);_PosMax = _PosMin;_nr = 0;_cv = 0;
								_DumyA setpos [_RandomX,_RandomY,0];_DumyA setdir 0;_cr = _CheckRadius2;_go = 1;
								if(_CheckRadius2 > 0) then
								{
									while {_go > 0} do
									{
										if(_nr > 360) then
										{
											_go = 0;_run = 9;
										}
										else
										{
											if(_cv == 0) then {_cv = 1;_cr = _CheckRadius2} else {_cv = 0;_cr = (_CheckRadius2 / 2)};
											_np = 	[
														((GetPos _DumyA Select 0) + (Sin ((getdir _DumyA) + _nr) * _cr)),
														((GetPos _DumyA Select 1) + (Cos ((getdir _DumyA) + _nr) * _cr)),0
													];
											_Null setpos _np;
											if(_checkMinH >= 0) then
											{
												if(getPosASL _Null select 2 > _PosMax) then {_PosMax = (getPosASL _Null select 2)} else {if(getPosASL _Null select 2 < _PosMin) then {_PosMin = (getPosASL _Null select 2)}};
											}
											else
											{
												if(!(surfaceIsWater (position _Null))) then {_PosMax = (_checkAreaH * 10);_nr = 360};
											};
											_nr = _nr + 36;
										};
									};
								}
								else
								{
									_run = 9;
								};
							};
					case 9:	{
								if((_PosMax - _PosMin) > _checkAreaH) then
								{
									_chnr = _chnr + 1;_run = 7;
								}
								else
								{
									if(_CheckRadius1 == 0) then
									{
										_run = 10;
									}
									else
									{
										_allObjects = nearestObjects [[_RandomX,_RandomY], [], _CheckRadius1];_relObjects = [];
										{
											if(((format["%1",typeOf _x]) != "LOGIC")
											&& ((format["%1",typeOf _x]) != "EmptyDetector")
											&& (!(_x in _TempArray))
											&& ((speed _x == 0) || (!(canmove _x)))) then
											{
												_relObjects set [count _relObjects,_x];
											};
										} 	foreach _allObjects;
										if(count _relObjects > 0) then
										{
											_chnr = _chnr + 1;_run = 7;
										}
										else
										{
											_run = 10;
										};
									};
								};
							};
					case 10:{
								if(_objNearRoad > 0) then
								{
									if((count ([_RandomX,_RandomY,0] nearRoads _objNearRoad)) > 0) then
									{
										_chnr = _chnr + 1;_run = 7;
									};
								};
								if(_run != 7) then
								{
									if(_CheckRadius2 > 0) then
									{
										_allObjects = nearestObjects [[_RandomX,_RandomY], [], _CheckRadius2];_relObjects = [];
										{
											if(((format["%1",typeOf _x]) != "LOGIC")
											&& ((format["%1",typeOf _x]) != "EmptyDetector")
											&& (!(_x in _TempArray))
											&& ((speed _x == 0) || (canmove _x))) then
											{
												_relObjects set [count _relObjects,_x];
											};
										} 	foreach _allObjects;
										if(({((((boundingBox _x select 1) select 2) > _checkObjH2)
										&& ((_x distance _DumyA) < _CheckRadius2))} count _relObjects) > 0) then
										{
											_chnr = _chnr + 1;_run = 7;
										}
										else
										{
											_run = 11;
										};
									}
									else
									{
										_run = 11;
									};
								};
							};
					case 11:{
								if(_wpi < 0) then
								{
									if(_checkNear > 0) then
									{
										_cd = 0;
										while {_cd < count _TempArray} do
										{
											_DPos = _TempArray select _cd;
											_DumyB setpos (position _DPos);
											if((_DumyB distance _DumyA) < (_checkNear + ((((boundingBox _DPos select 1) select 0) + ((boundingBox _DPos select 1) select 1)) / 2))) then
											{
												_cd = ((count _TempArray) + 1);
												_chnr = _chnr + 1;_run = 7;
											}
											else
											{
												_cd = _cd + 1;
											};
										};
									};
									if((typeName (_objArray select 0)) == "ARRAY") then
									{
										if(count _objArray > 0) then
										{
											if(count _logA == 0) then
											{
												if(({((_x distance [_RandomX,_RandomY,0]) < (_dist + ((((boundingBox _x select 1) select 0) + ((boundingBox _x select 1) select 1)) / 2)))} count (_objArray select 0)) > 0) then {_chnr = _chnr + 1;_run = 7};
											}
											else
											{
												if(({((_x distance [_RandomX,_RandomY,0]) < _dist)} count _logA) > 0) then {_chnr = _chnr + 1;_run = 7};
											};
										};
									}
									else
									{
										if(count _objArray > 0) then
										{
											if(count _logA == 0) then
											{
												if(({if((format["%1",typeOf _x]) == "LOGIC") then
												{
													((_x distance [_RandomX,_RandomY,0]) < _dist);
												}
												else
												{
													((_x distance [_RandomX,_RandomY,0]) < (_dist + ((((boundingBox _x select 1) select 0) + ((boundingBox _x select 1) select 1)) / 2)));
												};
													} count _objArray) > 0) then {_chnr = _chnr + 1;_run = 7};
											}
											else
											{
												if(({((_x distance [_RandomX,_RandomY,0]) < _dist)} count _logA) > 0) then {_chnr = _chnr + 1;_run = 7};
											};
										};
									};
								}
								else
								{
									_wpi = _wpi - 1;
								};
								if(_run != 7) then
								{
									_newo = _newObjArray select (1 + random ((count _newObjArray) - 2));
									_objSetHeight = (_newo select 4);_objSetVector = (_newo select 5);
									if(count _newo > 7) then {_markerVal = (_newo select 7)};
									if(format["%1",(_newo select 0)] != "LOGIC") then
									{
										_obj = (_newo select 0) createvehicle [_RandomX,_RandomY];
										if((_newo select 2) == 0) then {_obj setdir (random 360)} else {_obj setdir (_newo select 2)};
										if(_objSetHeight == 0) then
										{
											_obj setpos [_RandomX,_RandomY,0];
										}
										else
										{
											if(_objSetHeight < 0) then
											{
												_obj setpos [_RandomX,_RandomY,_objSetHeight];
											}
											else
											{
												_obj setpos [_RandomX,_RandomY,- (random _objSetHeight)];
											};
										};
										_vec1 = (-(1 * (((_newo select 3) / 0.0006) / 1000)) + random ((1 * (((_newo select 3) / 0.0006) / 1000)) * 2));
										_vec2 = (-(1 * (((_newo select 3) / 0.0006) / 1000)) + random ((1 * (((_newo select 3) / 0.0006) / 1000)) * 2));
										_vec3 = (1 - (random (1 * (((_newo select 3) / 0.0006) / 1000))));
										if((_newo select 3) == 0) then {if(_objSetVector == 1) then {_obj setVectorUp [0,0,0.1]}} else {if((_newo select 3) > 0) then {_obj setVectorUp [_vec2,_vec2,_vec3]}};
										if(!(format["%1",_arrayName] == "")) then {call compile format["%1 set [count %1,_obj]",_arrayName]};
										_TempArray set [count _TempArray,_obj];
										_wpnr = _wpnr + 1;_chnr = 0;
										if(DAC_Marker > 0) then
										{
											if(((DAC_Marker_Val select 1) > 0) && (_DAC_Count_WP > 0)) then
											{
												_m = format["m%1%2%3",_obj,_wpnr,time];
												_ma = createmarkerlocal [_m, position _obj];
												if(count _newo > 7) then {if(((_markerVal) select 0) == 0) then {_ma setMarkerShapelocal "ELLIPSE"} else {_ma setMarkerShapelocal "RECTANGLE"}} else {_ma setMarkerShapelocal "RECTANGLE"};
												_ma setMarkerSizelocal [(((boundingBox _obj select 1) select 0) * 1),(((boundingBox _obj select 1) select 1) * 1)];
												_ma setMarkerDirlocal direction _obj;
												if(count _newo > 7) then {_ma setMarkerColorlocal (_markerVal select 1)} else {_ma setMarkerColorlocal "ColorBlack"};
												if((DAC_Marker_Val select 1) == 1) then {_MTemp set [count _MTemp,_ma]};
												_mb setMarkerTextLocal format["%1",_wpnr];
											};
										};
										if(format["%1",_obj] == "<NULL-object>") then
										{
											if(!((_newo select 0) in _debA)) then {_debA set [count _debA,(_newo select 0)]};
										}
										else
										{
											if((_newo select 6) != "") then {call compile (_newo select 6)};
										};
									}
									else
									{
										_isLogic = true;
										if(!(format["%1",_arrayName] == "")) then
										{
											_obj = "LOGIC" createvehiclelocal [_RandomX,_RandomY];
											call compile format["%1 set [count %1,[_RandomX,_RandomY]]",_arrayName];
											_TempArray set [count _TempArray,_obj];
											_wpnr = _wpnr + 1;_chnr = 0;
											if(DAC_Marker > 0) then
											{
												if(((DAC_Marker_Val select 1) > 0) && (_DAC_Count_WP > 0)) then
												{
													_m = format["m%1%2%3",_obj,_wpnr,time];
													_ma = createmarkerlocal [_m, position _obj];
													_ma setMarkerShapelocal "ELLIPSE";
													_ma setMarkerSizelocal [5,5];
													_ma setMarkerDirlocal direction _obj;
													_ma setMarkerColorlocal "ColorBlack";
													if((DAC_Marker_Val select 1) == 1) then {_MTemp set [count _MTemp,_ma]};
													_mb setMarkerTextLocal format["%1",_wpnr];
												};
											};
										}
										else
										{
											_wpnr = _DAC_Count_WP;
											player sidechat format["Zone '%1' : To create positions only, you have to define an array",(_this select 0)];
										};
									};
									if(_wpnr >= _DAC_Count_WP) then
									{
										_run = 13;
									}
									else
									{
										_run = 7;
									};
								};
							};
					case 12:{
								if((DAC_Com_Values select 0) > 0) then {player sidechat format["Zone '%1' : Only %2 of %3 objects could be generated.",(_this select 0),_wpnr,_DAC_Count_WP]};
								if(!(format["%1",_arrayName] == "")) then {_KiZone setVariable ["objCreated", _arrayName]};
								sleep 1;
								{deletevehicle _x} foreach [_DumyA,_DumyB,_Null];
								if(count _MTemp > 0) then {[_MTemp]execVM "DAC\Marker\DAC_DeleteMarker.sqf"};
								if(_isLogic) then {{deletevehicle _x}foreach _TempArray};
								_run = 0;
							};
					case 13:{
								if((DAC_Com_Values select 0) > 0) then {player sidechat format["Zone '%1' : All %2 objects were generated.",(_this select 0),_wpnr,_DAC_Count_WP]};
								if(!(format["%1",_arrayName] == "")) then {_KiZone setVariable ["objCreated", _arrayName]};
								sleep 1;
								{deletevehicle _x} foreach [_DumyA,_DumyB,_Null];
								if(count _MTemp > 0) then {[_MTemp]execVM "DAC\Marker\DAC_DeleteMarker.sqf"};
								if(_isLogic) then {{deletevehicle _x}foreach _TempArray};
								_run = 0;
							};
					Default	{};
				};
			};
			DAC_Obj_Init = DAC_Obj_Init - [format["%1%2",_KiZone,count _this]];
			if(format["%1",(DAC_Obj_Init select 0)] == "1") then
			{
				if((count DAC_Obj_Init == 1) && ((DAC_Obj_Init select 0) == 1)) then {DAC_Obj_Init = []};
			};
			if(count _debA > 0) then {hintc format["Important Hint:\n\nBad object(s) in DAC_Config_Objects No. %1:\n\n%2\n\n\nIt's not possible to 'create' these objects.",_obj_Nr,_debA];player sidechat "bad objects"};
		};
	};
};