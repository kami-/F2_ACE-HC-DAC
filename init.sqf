// ====================================================================================

// F2 - Process ParamsArray
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)
// WARNING: DO NOT DISABLE THIS COMPONENT

f_processParamsArray = [] execVM "f\common\f_processParamsArray.sqf";

// ====================================================================================

// F2_ACE - Run client-side settings, ACE settings
// Credits: Please see the F2_ACE online manual (http://www.ferstaberinde.com/f2/en/)

#include "f\common\face_clientSettings.sqf";

// ====================================================================================

// F2 - CO Briefing
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)

[] execVM "f\common\briefing\briefing.sqf";

// ====================================================================================

// F2 - Mission Conditions Selector
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)

[] execVM "f\common\f_setMissionConditions.sqf";

// ====================================================================================

// F2 - OA Folk Group IDs
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)

f_script_setGroupIDs = [] execVM "f\common\markers\folk_setGroupIDs.sqf";

// ====================================================================================

// F2 - ShackTactical Fireteam Member Markers
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)

[] execVM "f\common\markers\ShackTac_setlocalFTMemberMarkers.sqf";

// ====================================================================================

// F2 - OA Folk Group Markers
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)

[] execVM "f\common\markers\folk_setLocalGroupMarkers.sqf";

// ====================================================================================

// F2 - F2 Common Local Variables
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)
// WARNING: DO NOT DISABLE THIS COMPONENT

f_script_setLocalVars = [] execVM "f\common\f_setLocalVars.sqf";

// ====================================================================================

// F2 - Multiplayer Ending Controller 
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)

f_endSelected = -1;
[] execVM "f\common\f_mpEndSetUp.sqf";

// ====================================================================================

// F2 - ORBAT Notes
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)

[] execVM "f\common\briefing\f_orbatNotes.sqf";

// ====================================================================================

// F2_ACE - Friendly-Fire Logger (to .rpt)

face_script_ffLog = player addeventhandler ["HandleDamage",{_this execVM "f\common\face_handleDamage.sqf"}];

// ====================================================================================

// F2 - Buddy Team Colours
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)

f_script_setTeamColours = [] execVM "f\common\markers\f_setTeamColours.sqf";

// ====================================================================================

// F2_ACE - Mission Timer/Safe Start
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f2/en/)

[] execVM "f\common\safestart\f_safeStart.sqf";

// ====================================================================================

// F2_ACE - JIP ACRE
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)

[] execVM "f\common\face_jipacre.sqf";

// ====================================================================================

// F2_ACE - DAC Init with Headless Client
// Credits: Please see the F2 online manual (http://www.ferstaberinde.com/f2/en/)

// The default player names for the HeadlessClient. Add your Headless Client's player name if it is missing.
// Not neccessary to uncomment.
//f_HC_defaultNames = ["HeadlessClient", "HC"];

// Call it with the scripts to be executed by Headless Client or Server.
// Theese scripts contain the exported DAC zones and/or other mission objects.
// USE [] execVM "f\ai\f_ai_init.sqf" if no zones were exported!
// Neccessary to uncomment!
//["DAC_Zones.sqf"] call compile preProcessFileLineNumbers "f\ai\f_ai_init.sqf";

// ====================================================================================
