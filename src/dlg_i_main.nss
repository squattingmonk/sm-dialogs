// -----------------------------------------------------------------------------
//    File: dlg_i_main.nss
//  System: Dynamic Dialogs (include script)
//     URL: https://github.com/squattingmonk/sm-dialogs
// Authors: Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>
// -----------------------------------------------------------------------------
// This is the main include file for the Dynamic Dialogs system. It should not
// be edited by the builder. Place all customization in dlg_c_main instead.
// -----------------------------------------------------------------------------
// Acknowledgements:
// This system is inspired by Acaos's HG Dialog system and Greyhawk0's
// ZZ-Dialog, which is itself based on pspeed's Z-dialog.
// -----------------------------------------------------------------------------
// System Design:
//
// -----------------------------------------------------------------------------

#include "dlg_c_config"
#include "util_i_debug"
#include "util_i_csvlists"
#include "util_i_libraries"
#include "util_i_varlists"

// -----------------------------------------------------------------------------
//                                   Constants
// -----------------------------------------------------------------------------

// ----- VarNames --------------------------------------------------------------

const string DLG_SYSTEM    = "Dynamic Dialogs System";
const string DLG_SCRIPT    = "DLG_Script";
const string DLG_SELECTION = "DLG_Selection";
const string DLG_END       = "DLG_End";
const string DLG_ABORT     = "DLG_Abort";
const string DLG_RESET     = "DLG_Reset";
const string DLG_PAGE      = "DLG_Page";
const string DLG_RESPONSE  = "DLG_Response";

const string DLG_LABEL_CONTINUE = "DLG_ContinueLabel";

// ----- VarName Fragments -----------------------------------------------------

const string DLG_ACTIONS    = "Actions";
const string DLG_CONDITIONS = "Conditions";
const string DLG_CONTINUE   = "Continue";
const string DLG_NODE       = "Node";
const string DLG_FLOATS     = "Floats";
const string DLG_INTS       = "Ints";
const string DLG_LOCATIONS  = "Locations";
const string DLG_OBJECTS    = "Objects";
const string DLG_PAGES      = "Pages";
const string DLG_STRINGS    = "Strings";
const string DLG_TARGETS    = "Targets";
const string DLG_TEXT       = "Text";

// ----- Automated Node IDs ----------------------------------------------------

const int DLG_NODE_NONE     = -1;
const int DLG_NODE_CONTINUE = -2;
const int DLG_NODE_END      = -3;
const int DLG_NODE_PREV     = -4;
const int DLG_NODE_NEXT     = -5;
const int DLG_NODE_BACK     = -6;

// ----- Dialog States ---------------------------------------------------------

const string DLG_STATE = "DLG_State";
const int    DLG_STATE_INIT    = 0; // Dialog is new and initialized
const int    DLG_STATE_RUNNING = 1; // Dialog is running normally
const int    DLG_STATE_ENDED   = 2; // Dialog has ended

// ----- Custom Token Reservation ----------------------------------------------

const int DLG_TOKEN = 20000;

// ----- Library Scripts -------------------------------------------------------

const string DLG_ACTION_ANIMATION = "dlg_Action_Animation";
const string DLG_ACTION_ATTACK = "dlg_Action_Attack";
const string DLG_ACTION_TAKE_GP = "dlg_Action_TakeGP";

const string DLG_CONDITION_PC_HAS_GP = "dlg_Condition_PCHasGP";



// -----------------------------------------------------------------------------
//                               Global Variables
// -----------------------------------------------------------------------------

// Object used to cache all information about this dialog.
object DLG_SELF = GetDatapoint(DLG_SYSTEM, GetPCSpeaker(), FALSE);

// -----------------------------------------------------------------------------
//                              Function Prototypes
// -----------------------------------------------------------------------------

// ----- Dialog Mapping --------------------------------------------------------

// ---< GetDialogFloat >---
// ---< dlg_i_main >---
// Returns a local float named sVarName from sPage's node at index nNode. If
// nNode is less than 0, will return the local float from sPage itself.
float GetDialogFloat(string sVarName, string sPage = "", int nNode = -1);

// ---< SetDialogFloat >---
// ---< dlg_i_main >---
// Sets a local float named sVarName to fValue on sPage's node at index nNode.
// If nNode is less than 0, will set the local float on sPage itself.
void SetDialogFloat(string sVarName, float fValue, string sPage = "", int nNode = -1);

// ---< DeleteDialogFloat >---
// ---< dlg_i_main >---
// Deletes the local float named sVarName on sPage's node at index nNode. If
// nNode is less than 0, will delete the local float set on sPage itself.
void DeleteDialogFloat(string sVarName, string sPage = "", int nNode = -1);

// ---< DeleteDialogFloats >---
// ---< dlg_i_main >---
// Deletes all local floats on sPage's node at index nNode. If nNode is less
// than 0, will delete all local floats set on sPage itself.
void DeleteDialogFloats(string sPage = "", int nNode = -1);

// ---< CopyDialogFloats >---
// ---< dlg_i_main >---
// Copies all local floats from page sParent's node at index nParent to page
// sTarget's node at index nTarget. If nParent is negative, will copy the floats
// from the sParent itself. If nTarget is negative, will copy the floats to
// sTarget itself.
void CopyDialogFloats(string sParent, string sTarget, int nParent = -1, int nTarget = -1);

// ---< GetDialogInt >---
// ---< dlg_i_main >---
// Returns a local int named sVarName from sPage's node at index nNode. If nNode
// is less than 0, will return the local int from sPage itself.
int GetDialogInt(string sVarName, string sPage = "", int nNode = -1);

// ---< SetDialogInt >---
// ---< dlg_i_main >---
// Sets a local int named sVarName to nValue on sPage's node at index nNode. If
// nNode is less than 0, will set the local int on sPage itself.
void SetDialogInt(string sVarName, int nValue, string sPage = "", int nNode = -1);

// ---< DeleteDialogInt >---
// ---< dlg_i_main >---
// Deletes the local int named sVarName on sPage's node at index nNode. If nNode
// is less than 0, will delete the local int set on sPage itself.
void DeleteDialogInt(string sVarName, string sPage = "", int nNode = -1);

// ---< DeleteDialogInts >---
// ---< dlg_i_main >---
// Deletes all local ints on sPage's node at index nNode. If nNode is less than
// 0, will delete all local ints set on sPage itself.
void DeleteDialogInts(string sPage = "", int nNode = -1);

// ---< CopyDialogInts >---
// ---< dlg_i_main >---
// Copies all local ints from page sParent's node at index nParent to page
// sTarget's node at index nTarget. If nParent is negative, will copy the ints
// from the sParent itself. If nTarget is negative, will copy the ints to
// sTarget itself.
void CopyDialogInts(string sParent, string sTarget, int nParent = -1, int nTarget = -1);

// ---< GetDialogLocation >---
// ---< dlg_i_main >---
// Returns a local location named sVarName from sPage's node at index nNode. If
// nNode is less than 0, will return the local location from sPage itself.
location GetDialogLocation(string sVarName, string sPage = "", int nNode = -1);

// ---< SetDialogLocation >---
// ---< dlg_i_main >---
// Sets a local location named sVarName to lValue on sPage's node at index
// nNode. If nNode is less than 0, will set the local location on sPage itself.
void SetDialogLocation(string sVarName, location lValue, string sPage = "", int nNode = -1);

// ---< DeleteDialogLocation >---
// ---< dlg_i_main >---
// Deletes the local location named sVarName on sPage's node at index nNode. If
// nNode is less than 0, will delete the local location set on sPage itself.
void DeleteDialogLocation(string sVarName, string sPage = "", int nNode = -1);

// ---< DeleteDialogLocations >---
// ---< dlg_i_main >---
// Deletes all local locations on sPage's node at index nNode. If nNode is less
// than 0, will delete all local locations set on sPage itself.
void DeleteDialogLocations(string sPage = "", int nNode = -1);

// ---< CopyDialogLocations >---
// ---< dlg_i_main >---
// Copies all local locations from page sParent's node at index nParent to page
// sTarget's node at index nTarget. If nParent is negative, will copy the
// locations from the sParent itself. If nTarget is negative, will copy the
// locations to sTarget itself.
void CopyDialogLocations(string sParent, string sTarget, int nParent = -1, int nTarget = -1);

// ---< GetDialogObject >---
// ---< dlg_i_main >---
// Returns a local object named sVarName from sPage's node at index nNode. If
// nNode is less than 0, will return the local object from sPage itself.
object GetDialogObject(string sVarName, string sPage = "", int nNode = -1);

// ---< SetDialogObject >---
// ---< dlg_i_main >---
// Sets a local object named sVarName to oValue on sPage's node at index nNode.
// If nNode is less than 0, will set the local object on sPage itself.
void SetDialogObject(string sVarName, object oValue, string sPage = "", int nNode = -1);

// ---< DeleteDialogObject >---
// ---< dlg_i_main >---
// Deletes the local object named sVarName on sPage's node at index nNode. If
// nNode is less than 0, will delete the local object set on sPage itself.
void DeleteDialogObject(string sVarName, string sPage = "", int nNode = -1);

// ---< DeleteDialogObjects >---
// ---< dlg_i_main >---
// Deletes all local objects on sPage's node at index nNode. If nNode is less
// than 0, will delete all local objects set on sPage itself.
void DeleteDialogObjects(string sPage = "", int nNode = -1);

// ---< CopyDialogObjects >---
// ---< dlg_i_main >---
// Copies all local objects from page sParent's node at index nParent to page
// sTarget's node at index nTarget. If nParent is negative, will copy the
// objects from the sParent itself. If nTarget is negative, will copy the
// objects to sTarget itself.
void CopyDialogObjects(string sParent, string sTarget, int nParent = -1, int nTarget = -1);

// ---< GetDialogString >---
// ---< dlg_i_main >---
// Returns a local string named sVarName from sPage's node at index nNode. If
// nNode is less than 0, will return the local string from sPage itself.
string GetDialogString(string sVarName, string sPage = "", int nNode = -1);

// ---< SetDialogString >---
// ---< dlg_i_main >---
// Sets a local string named sVarName to sValue on sPage's node at index nNode.
// If nNode is less than 0, will return the local string from sPage itself.
void SetDialogString(string sVarName, string sValue, string sPage = "", int nNode = -1);

// ---< DeleteDialogString >---
// ---< dlg_i_main >---
// Deletes the local string named sVarName on sPage's node at index nNode. If
// nNode is less than 0, will delete the local string set on sPage itself.
void DeleteDialogString(string sVarName, string sPage = "", int nNode = -1);

// ---< DeleteDialogStrings >---
// ---< dlg_i_main >---
// Deletes all local strings on sPage's node at index nNode. If nNode is less
// than 0, will delete all local strings set on sPage itself.
void DeleteDialogStrings(string sPage = "", int nNode = -1);

// ---< CopyDialogStrings >---
// ---< dlg_i_main >---
// Copies all local strings from page sParent's node at index nParent to page
// sTarget's node at index nTarget. If nParent is negative, will copy the
// strings from the sParent itself. If nTarget is negative, will copy the
// strings to sTarget itself.
void CopyDialogStrings(string sParent, string sTarget, int nParent = -1, int nTarget = -1);

// ---< AddDialogPage >---
// ---< dlg_i_main >---
// Adds a page named sPage that displays sText. sConditions and sActions are CSV
// lists of library scripts that run on the Text Appears When and Actions Taken
// events, respectively.
void AddDialogPage(string sPage, string sText, string sConditions = "", string sActions = "");

// ---< ContinueDialogPage >---
// ---< dlg_i_main >---
// Adds a page target of sPage displaying sText that will be linked to via an
// automatic Continue node. sTargets is a CSV list of pages to which the added
// page will link (useful for ending a continue chain). Returns the name of the
// page.
string ContinueDialogPage(string sPage, string sText, string sTargets = "");

// ---< AddDialogNode >---
// ---< dlg_i_main >---
// Adds a dialog node to sPage that displays sText. sTargets is a CSV list of
// pages to which the node may lead when clicked: each page has its conditions
// evaluated in sequence until one passes. sConditions and sActions are CSV
// lists of library scripts that run on the Text Appears When and Actions Taken
// events, respectively. Returns the index to the added node.
int AddDialogNode(string sPage, string sText = "", string sTargets = "", string sConditions = "", string sActions = "");

// ---< CountDialogNodes >---
// ---< dlg_i_main >---
// Returns the number of dialog nodes registered to sPage.
int CountDialogNodes(string sPage);

// ---< DeleteDialogNode >---
// ---< dlg_i_main >---
// Deletes the node at index nNode from page sPage.
void DeleteDialogNode(string sPage, int nNode);

// ---< DeleteDialogNodes >---
// ---< dlg_i_main >---
// Deletes all nodes from the page sPage.
void DeleteDialogNodes(string sPage);

// ---< CopyDialogNode >---
// ---< dlg_i_main >---
// Copies page sParent's node at index nParent to page sTarget's node at index
// nTarget, and returns the index to the newly created node. If nTarget is
// negative, will add the node to the end of the list.
int CopyDialogNode(string sParent, string sTarget, int nParent, int nTarget = -1);

// ---< CopyDialogNodes >---
// ---< dlg_i_main >---
// Copies all nodes from page sParent to page sTarget.
void CopyDialogNodes(string sParent, string sTarget);

// ---< GetDialogText >---
// ---< dlg_i_main >---
// Returns the text that will be displayed for sPage's node at index nNode. If
// nNode is less than 0, will return the text for sPage.
string GetDialogText(string sPage, int nNode = -1);

// ---< SetDialogText >---
// ---< dlg_i_main >---
// Sets the text that will be displayed for sPage's node at index nNode. If
// nNode is less than 0, will set the text for sPage.
void SetDialogText(string sText, string sPage, int nNode = -1);

// ---< GetDialogConditions >---
// ---< dlg_i_main >---
// Returns a CSV list of library scripts that are evaluated during the Text
// Appears When event for sPage's node at index nNode. If nNode is less than 0,
// will return the conditions for sPage instead.
string GetDialogConditions(string sPage = "", int nNode = -1);

// ---< SetDialogConditions >---
// ---< dlg_i_main >---
// Sets a CSV list of library scripts that are evaluated during the Text Appears
// when script for sPage's node at index nNode. If nNode is less than 0, will
// set the conditions for sPage instead.
void SetDialogConditions(string sConditions, string sPage = "", int nNode = -1);

// ---< GetDialogActions >---
// ---< dlg_i_main >---
// Returns a CSV list of library scripts that are run on the Actions Taken event
// for sPage's node at index nNode. If nNode is less than 0, will return the
// actions for sPage instead.
string GetDialogActions(string sPage = "", int nNode = -1);

// ---< SetDialogActions >---
// ---< dlg_i_main >---
// Sets a CSV list of library scripts that are run on the Actions Taken event
// for sPage's node at index nNode. If nNode is less than 0, will set the
// actions for sPage instead.
void SetDialogActions(string sActions, string sPage = "", int nNode = -1);

// ---< GetDialogTargets >---
// ---< dlg_i_main >---
// Returns a CSV list of pages to which sPage's node at index nNode may lead
// when clicked: each page has its conditions evaluated in sequence until one
// passes. If nNode is less than 0, the target is added to sPage instead; this
// target will be led to by an automatic Continue node.
string GetDialogTargets(string sPage = "", int nNode = -1);

// ---< SetDialogTargets >---
// ---< dlg_i_main >---
// Sets a CSV list of pages to which sPage's node at index nNode may lead when
// clicked: each page has its conditions evaluated in sequence until one passes.
// If nNode is less than 0, the target is added to sPage instead; this target
// will be led to by an automatic Continue node.
void SetDialogTargets(string sTargets, string sPage = "", int nNode = -1);


// ----- System Functions ------------------------------------------------------
// These functions are used by the system and should not be used by builders.

// ---< InitializeDialog >---
// ---< dlg_i_main >---
// Caches the dialog and sets the state to DLG_STATE_RUNNING.
void InitializeDialog();

// ---< InitializeDialogPage >---
// ---< dlg_i_main >---
// Chooses a dialog page from the available targets, running the conditions and
// actions as appropriate. Returns TRUE if a dialog page was found.
int InitializeDialogPage();

// ---< RunDialogConditions >---
// ---< dlg_i_main >---
// Runs the conditions set on the node at index nNode on sPage and returns
// whether all conditions were met. If nNode is less than 0, will check the
// conditions on sPage instead.
int RunDialogConditions(string sPage = "", int nNode = -1);

// ---< RunDialogActions >---
// ---< dlg_i_main >---
// Runs all actions set on the node at index nNode on sPage. If nNode is less
// than 0, will run the actions on sPage instead.
void RunDialogActions(string sPage = "", int nNode = -1);

// ---< BuildDialogResponseList >---
// ---< dlg_i_main >---
// Runs the conditions for each node assigned to sPage and populates a list of
// indices to allowed PC responses. Returns the number of nodes in the list.
int BuildDialogResponseList(string sPage);

// ---< ChooseDialogNode >---
// ---< dlg_i_main >---
// Returns the index to of a dialog node found in the response list for the
// current page at nIndex. The response list is populated by
// BuildDialogResponseList().
int ChooseDialogNode(int nIndex);





// ----- Accessor Functions ----------------------------------------------------

// ---< GetDialogState >---
// ---< dlg_i_main >---
// Returns the state of the dialog.
int GetDialogState();

// ---< SetDialogState >---
// ---< dlg_i_main >---
// Sets the state of the dialog.
void SetDialogState(int nState);

// ---< GetDialogPage >---
// ---< dlg_i_main >---
// Returns the current dialog page.
string GetDialogPage();

// ---< SetDialogPage >---
// ---< dlg_i_main >---
// Sets the current dialog page to sPage.
void SetDialogPage(string sPage);


// ---< GetDialogNode >---
// ---< dlg_i_main >---
// Returns the index of the last selected node as set by SendDialogEvent().
int GetDialogNode();

// ---< SetDialogNode >---
// ---< dlg_i_main >---
// Sets the index of the last selected node.
void SetDialogNode(int nNode = -1);










// -----------------------------------------------------------------------------
//                             Function Definitions
// -----------------------------------------------------------------------------

// ----- Dialog Mapping --------------------------------------------------------

string DialogNodeToString(string sPage, int nNode)
{
    if (nNode < 0) return sPage;
    return sPage + "@" + IntToString(nNode);
}

float GetDialogFloat(string sVarName, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    return GetLocalFloat(DLG_SELF, sNode + "_" + sVarName);
}

void SetDialogFloat(string sVarName, float fValue, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    SetLocalFloat(DLG_SELF, sNode + "_" + sVarName, fValue);
    AddLocalListItem(DLG_SELF, sNode + "_" + DLG_FLOATS, sVarName, TRUE);
}

void DeleteDialogFloat(string sVarName, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    DeleteLocalFloat(DLG_SELF, sNode + "_" + sVarName);
    RemoveLocalListItem(DLG_SELF, sNode + "_" + DLG_FLOATS, sVarName);
}

void DeleteDialogFloats(string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    string sVarNames = GetLocalString(DLG_SELF, sNode + "_" + DLG_FLOATS);
    int i, nCount = CountList(sVarNames);
    for (i = 0; i < nCount; i++)
        DeleteLocalFloat(DLG_SELF, sNode + "_" + GetListItem(sVarNames, i));

    DeleteLocalString(DLG_SELF, sNode + "_" + DLG_FLOATS);
}

void CopyDialogFloats(string sParent, string sTarget, int nParent = -1, int nTarget = -1)
{
    // Sanity check
    if (nParent >= CountDialogNodes(sParent) ||
        nTarget >= CountDialogNodes(sTarget))
        return;

    string sVarName = DialogNodeToString(sParent, nParent);
    string sVarNames = GetLocalString(DLG_SELF, sVarName + "_" + DLG_FLOATS);
    int i, nCount = CountList(sVarNames);
    float fValue;

    for (i = 0; i < nCount; i++)
    {
        sVarName = GetListItem(sVarNames, i);
        fValue = GetDialogFloat(sVarName, sParent, nParent);
        SetDialogFloat(sVarName, fValue, sTarget, nTarget);
    }
}

int GetDialogInt(string sVarName, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    return GetLocalInt(DLG_SELF, sNode + "_" + sVarName);
}

void SetDialogInt(string sVarName, int nValue, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    SetLocalInt(DLG_SELF, sNode + "_" + sVarName, nValue);
    AddLocalListItem(DLG_SELF, sNode + "_" + DLG_INTS, sVarName, TRUE);
}

void DeleteDialogInt(string sVarName, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    DeleteLocalInt(DLG_SELF, sNode + "_" + sVarName);
    RemoveLocalListItem(DLG_SELF, sNode + "_" + DLG_INTS, sVarName);
}

void DeleteDialogInts(string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    string sVarNames = GetLocalString(DLG_SELF, sNode + "_" + DLG_INTS);
    int i, nCount = CountList(sVarNames);
    for (i = 0; i < nCount; i++)
        DeleteLocalInt(DLG_SELF, sNode + "_" + GetListItem(sVarNames, i));

    DeleteLocalString(DLG_SELF, sNode + "_" + DLG_INTS);
}

void CopyDialogInts(string sParent, string sTarget, int nParent = -1, int nTarget = -1)
{
    // Sanity check
    if (nParent >= CountDialogNodes(sParent) ||
        nTarget >= CountDialogNodes(sTarget))
        return;

    string sVarName = DialogNodeToString(sParent, nParent);
    string sVarNames = GetLocalString(DLG_SELF, sVarName + "_" + DLG_INTS);
    int i, nCount = CountList(sVarNames);
    int nValue;

    for (i = 0; i < nCount; i++)
    {
        sVarName = GetListItem(sVarNames, i);
        nValue = GetDialogInt(sVarName, sParent, nParent);
        SetDialogInt(sVarName, nValue, sTarget, nTarget);
    }
}

location GetDialogLocation(string sVarName, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    return GetLocalLocation(DLG_SELF, sNode + "_" + sVarName);
}

void SetDialogLocation(string sVarName, location lValue, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    SetLocalLocation(DLG_SELF, sNode + "_" + sVarName, lValue);
    AddLocalListItem(DLG_SELF, sNode + "_" + DLG_LOCATIONS, sVarName, TRUE);
}

void DeleteDialogLocation(string sVarName, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    DeleteLocalLocation(DLG_SELF, sNode + "_" + sVarName);
    RemoveLocalListItem(DLG_SELF, sNode + "_" + DLG_LOCATIONS, sVarName);
}

void DeleteDialogLocations(string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    string sVarNames = GetLocalString(DLG_SELF, sNode + "_" + DLG_LOCATIONS);
    int i, nCount = CountList(sVarNames);
    for (i = 0; i < nCount; i++)
        DeleteLocalLocation(DLG_SELF, sNode + "_" + GetListItem(sVarNames, i));

    DeleteLocalString(DLG_SELF, sNode + "_" + DLG_LOCATIONS);
}

void CopyDialogLocations(string sParent, string sTarget, int nParent = -1, int nTarget = -1)
{
    // Sanity check
    if (nParent >= CountDialogNodes(sParent) ||
        nTarget >= CountDialogNodes(sTarget))
        return;

    string sVarName = DialogNodeToString(sParent, nParent);
    string sVarNames = GetLocalString(DLG_SELF, sVarName + "_" + DLG_LOCATIONS);
    int i, nCount = CountList(sVarNames);
    location lValue;

    for (i = 0; i < nCount; i++)
    {
        sVarName = GetListItem(sVarNames, i);
        lValue = GetDialogLocation(sVarName, sParent, nParent);
        SetDialogLocation(sVarName, lValue, sTarget, nTarget);
    }
}

object GetDialogObject(string sVarName, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    return GetLocalObject(DLG_SELF, sNode + "_" + sVarName);
}

void SetDialogObject(string sVarName, object oValue, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    SetLocalObject(DLG_SELF, sNode + "_" + sVarName, oValue);
    AddLocalListItem(DLG_SELF, sNode + "_" + DLG_OBJECTS, sVarName, TRUE);
}

void DeleteDialogObject(string sVarName, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    DeleteLocalObject(DLG_SELF, sNode + "_" + sVarName);
    RemoveLocalListItem(DLG_SELF, sNode + "_" + DLG_OBJECTS, sVarName);
}

void DeleteDialogObjects(string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    string sVarNames = GetLocalString(DLG_SELF, sNode + "_" + DLG_OBJECTS);
    int i, nCount = CountList(sVarNames);
    for (i = 0; i < nCount; i++)
        DeleteLocalObject(DLG_SELF, sNode + "_" + GetListItem(sVarNames, i));

    DeleteLocalString(DLG_SELF, sNode + "_" + DLG_OBJECTS);
}

void CopyDialogObjects(string sParent, string sTarget, int nParent = -1, int nTarget = -1)
{
    // Sanity check
    if (nParent >= CountDialogNodes(sParent) ||
        nTarget >= CountDialogNodes(sTarget))
        return;

    string sVarName = DialogNodeToString(sParent, nParent);
    string sVarNames = GetLocalString(DLG_SELF, sVarName + "_" + DLG_OBJECTS);
    int i, nCount = CountList(sVarNames);
    object oValue;

    for (i = 0; i < nCount; i++)
    {
        sVarName = GetListItem(sVarNames, i);
        oValue = GetDialogObject(sVarName, sParent, nParent);
        SetDialogObject(sVarName, oValue, sTarget, nTarget);
    }
}

string GetDialogString(string sVarName, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    return GetLocalString(DLG_SELF, sNode + "_" + sVarName);
}

void SetDialogString(string sVarName, string sValue, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    SetLocalString(DLG_SELF, sNode + "_" + sVarName, sValue);
    AddLocalListItem(DLG_SELF, sNode + "_" + DLG_STRINGS, sVarName, TRUE);
}

void DeleteDialogString(string sVarName, string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    DeleteLocalString(DLG_SELF, sNode + "_" + sVarName);
    RemoveLocalListItem(DLG_SELF, sNode + "_" + DLG_STRINGS, sVarName);
}

void DeleteDialogStrings(string sPage = "", int nNode = -1)
{
    string sNode = DialogNodeToString(sPage, nNode);
    string sVarNames = GetLocalString(DLG_SELF, sNode + "_" + DLG_STRINGS);
    int i, nCount = CountList(sVarNames);
    for (i = 0; i < nCount; i++)
        DeleteLocalString(DLG_SELF, sNode + "_" + GetListItem(sVarNames, i));

    DeleteLocalString(DLG_SELF, sNode + "_" + DLG_STRINGS);
}

void CopyDialogStrings(string sParent, string sTarget, int nParent = -1, int nTarget = -1)
{
    // Sanity check
    if (nParent >= CountDialogNodes(sParent) ||
        nTarget >= CountDialogNodes(sTarget))
        return;

    string sVarName = DialogNodeToString(sParent, nParent);
    string sVarNames = GetLocalString(DLG_SELF, sVarName + "_" + DLG_STRINGS);
    int i, nCount = CountList(sVarNames);
    string sValue;

    for (i = 0; i < nCount; i++)
    {
        sVarName = GetListItem(sVarNames, i);
        sValue = GetDialogString(sVarName, sParent, nParent);
        SetDialogString(sVarName, sValue, sTarget, nTarget);
    }
}

void AddDialogPage(string sPage, string sText, string sConditions = "", string sActions = "")
{
    Debug("Adding dialog page " + sPage);
    SetDialogString(DLG_TEXT,       sText,       sPage);
    SetDialogString(DLG_CONDITIONS, sConditions, sPage);
    SetDialogString(DLG_ACTIONS,    sActions,    sPage);
}

string ContinueDialogPage(string sPage, string sText, string sTargets = "")
{
    int nIndex = GetDialogInt(DLG_PAGES, sPage);
                 SetDialogInt(DLG_PAGES, nIndex + 1, sPage);
    string sContinue = sPage + DLG_CONTINUE + IntToString(nIndex);
    AddDialogPage(sContinue, sText);
    SetDialogTargets(sTargets, sContinue);

    if (nIndex > 0)
        sPage = sPage + DLG_CONTINUE + IntToString(nIndex - 1);

    sTargets = AddListItem(GetDialogTargets(sPage), sContinue);
    SetDialogTargets(sTargets, sPage);
    return sContinue;
}

int AddDialogNode(string sPage, string sText = "", string sTargets = "", string sConditions = "", string sActions = "")
{
    int nNode = GetLocalInt(DLG_SELF, sPage);
                SetLocalInt(DLG_SELF, sPage, nNode + 1);

    Debug("Adding dialog node " + DialogNodeToString(sPage, nNode));

    SetDialogString(DLG_TEXT,       sText,       sPage, nNode);
    SetDialogString(DLG_TARGETS,    sTargets,    sPage, nNode);
    SetDialogString(DLG_CONDITIONS, sConditions, sPage, nNode);
    SetDialogString(DLG_ACTIONS,    sActions,    sPage, nNode);
    return nNode;
}

int CountDialogNodes(string sPage)
{
    return GetLocalInt(DLG_SELF, sPage);
}

void DeleteDialogNode(string sPage, int nNode)
{
    // Sanity check
    if (nNode >= CountDialogNodes(sPage))
        return;

    Debug("Deleting dialog node " + DialogNodeToString(sPage, nNode));

    // Delete all variables from this node
    DeleteDialogFloats   (sPage, nNode);
    DeleteDialogInts     (sPage, nNode);
    DeleteDialogLocations(sPage, nNode);
    DeleteDialogObjects  (sPage, nNode);
    DeleteDialogStrings  (sPage, nNode);

    // Shift the next entry up
    CopyDialogNode(sPage, sPage, nNode + 1, nNode);

    // Run recursively until we hit the end of the list
    DeleteDialogNode(sPage, nNode + 1);

    // Fix the node count
    SetLocalInt(DLG_SELF, sPage, CountDialogNodes(sPage) - 1);
}

void DeleteDialogNodes(string sPage)
{
    // Delete from the end to avoid unnecessarily copying nodes
    int i = CountDialogNodes(sPage);
    for (i; i > 0; i--)
        DeleteDialogNode(sPage, i - 1);
}

int CopyDialogNode(string sParent, string sTarget, int nParent, int nTarget= -1)
{
    int nParents = CountDialogNodes(sParent);
    int nTargets = CountDialogNodes(sTarget);

    // Sanity check
    if (nParent >= nParents || nTarget >= nTargets)
        return DLG_NODE_NONE;

    if (nTarget < 0)
    {
        // We're adding the node on; increment the count
        nTarget = nTargets;
        SetLocalInt(DLG_SELF, sTarget, nTarget + 1);
    }
    else
    {
        // We're replacing a node; clear all node data
        DeleteDialogFloats   (sTarget, nTarget);
        DeleteDialogInts     (sTarget, nTarget);
        DeleteDialogLocations(sTarget, nTarget);
        DeleteDialogObjects  (sTarget, nTarget);
        DeleteDialogStrings  (sTarget, nTarget);
    }

    Debug("Copying " + DialogNodeToString(sParent, nParent) + " to " +
                       DialogNodeToString(sTarget, nTarget));

    CopyDialogFloats   (sParent, sTarget, nParent, nTarget);
    CopyDialogInts     (sParent, sTarget, nParent, nTarget);
    CopyDialogLocations(sParent, sTarget, nParent, nTarget);
    CopyDialogObjects  (sParent, sTarget, nParent, nTarget);
    CopyDialogStrings  (sParent, sTarget, nParent, nTarget);

    return nTarget;
}

void CopyDialogNodes(string sParent, string sTarget)
{
    int i, nCount = CountDialogNodes(sParent);
    for (i = 0; i < nCount; i++)
        CopyDialogNode(sParent, sTarget, i);
}

string GetDialogText(string sPage, int nNode = -1)
{
    return GetDialogString(DLG_TEXT, sPage, nNode);
}

void SetDialogText(string sText, string sPage, int nNode = -1)
{
    SetDialogString(DLG_TEXT, sText, sPage, nNode);
}

string GetDialogConditions(string sPage = "", int nNode = -1)
{
    return GetDialogString(DLG_CONDITIONS, sPage, nNode);
}

void SetDialogConditions(string sConditions, string sPage = "", int nNode = -1)
{
    SetDialogString(DLG_CONDITIONS, sConditions, sPage, nNode);
}

string GetDialogActions(string sPage = "", int nNode = -1)
{
    return GetDialogString(DLG_ACTIONS, sPage, nNode);
}

void SetDialogActions(string sActions, string sPage = "", int nNode = -1)
{
    SetDialogString(DLG_ACTIONS, sActions, sPage, nNode);
}

string GetDialogTargets(string sPage = "", int nNode = -1)
{
    return GetDialogString(DLG_TARGETS, sPage, nNode);
}

void SetDialogTargets(string sTargets, string sPage = "", int nNode = -1)
{
    SetDialogString(DLG_TARGETS, sTargets, sPage, nNode);
}

void EnableDialogEnd(string sPage = "", string sText = DLG_DEFAULT_LABEL_END, string sActions = "")
{
    SetDialogInt   (DLG_END, TRUE, sPage);
    SetDialogString(DLG_END + DLG_TEXT,    sText,    sPage);
    SetDialogString(DLG_END + DLG_ACTIONS, sActions, sPage);
}

void DisableDialogEnd(string sPage)
{
    SetDialogInt      (DLG_END, FALSE, sPage);
    DeleteDialogString(DLG_END + DLG_TEXT,    sPage);
    DeleteDialogString(DLG_END + DLG_ACTIONS, sPage);
}

int GetDialogEndEnabled(string sPage = "")
{
    // This page has the end response enabled
    if (GetDialogInt(DLG_END, sPage))
        return TRUE;

    // This page has the end response disabled
    string sVars = GetLocalString(DLG_SELF, sPage);
    if (HasListItem(sVars, DLG_END))
        return FALSE;

    // Get whether the dialog has the end response enabled
    return GetDialogInt(DLG_END);
}

string GetDialogLabel(string sType, string sPage = "")
{
    string sText = GetDialogString(sType, sPage);
    if (sText == "" && sPage != "")
        sText = GetDialogString(sType);

    return sText;
}

void SetDialogLabel(string sType, string sLabel, string sPage = "")
{
    SetDialogString(sType, sLabel, sPage);
}

string GetDialogEndActions(string sPage = "", int bAll = FALSE)
{
    string sLocal  = GetDialogString(DLG_END + DLG_ACTIONS, sPage);
    if (!bAll || sPage == "")
        return sLocal;

    string sGlobal = GetDialogString(DLG_END + DLG_ACTIONS);
    return MergeLists(sGlobal, sLocal);
}

void SetDialogEndActions(string sActions, string sPage = "")
{
    SetDialogString(DLG_END + DLG_ACTIONS, sActions, sPage);
}

string GetDialogAbortActions(string sPage = "", int bAll = FALSE)
{
    string sLocal = GetDialogString(DLG_ABORT, sPage);
    if (!bAll || sPage == "")
        return sLocal;

    string sGlobal = GetDialogString(DLG_ABORT);
    return MergeLists(sGlobal, sLocal);
}

void SetDialogAbortActions(string sActions, string sPage = "")
{
    SetDialogString(DLG_ABORT, sActions, sPage);
}

// ----- System Functions ------------------------------------------------------


void InitializeDialog()
{
    object oPC = GetPCSpeaker();
    string sScript = GetLocalString(oPC, DLG_SCRIPT);

    if (sScript == "")
    {
        sScript = GetLocalString(OBJECT_SELF, DLG_SCRIPT);
        if (sScript == "")
            sScript = GetTag(OBJECT_SELF);
    }

    DLG_SELF = GetDatapoint(DLG_SYSTEM, oPC);
    SetLocalString(DLG_SELF, DLG_SCRIPT, sScript);
    SetDialogLabel(DLG_LABEL_CONTINUE, DLG_DEFAULT_LABEL_CONTINUE);

    Debug("Initializing dialog " + sScript);

    RunLibraryScript(sScript);
    SetDialogState(DLG_STATE_RUNNING);
    SetDialogNode(-1);
}

int InitializeDialogPage()
{
    int nNode = GetDialogNode();
    string sPage = GetDialogPage();

    int i;
    string sTargets = GetDialogTargets(sPage, nNode);
    string sTarget = GetListItem(sTargets, i);

    Debug("Searching for a target page for " + sPage + "@" + IntToString(nNode) +
          " from the list: " + sTargets);

    while (sTarget != "")
    {
        if (RunDialogConditions(sTarget))
            break;
        sTarget = GetListItem(sTargets, ++i);
    }

    if (sTarget != "")
    {
        Debug("  Success: initializing dialog page " + sTarget);
        SetDialogPage(sTarget);
        SetDialogNode(-1);
        BuildDialogResponseList(sTarget);
        return DLG_STATE_RUNNING;
    }

    SetDialogPage(sPage);
    SetDialogNode(nNode);
    Debug("  Failure: no targets's conditions were met");
    return DLG_STATE_ENDED;
}

int RunDialogConditions(string sPage = "", int nNode = -1)
{
    string sCondition, sConditions = GetDialogConditions(sPage, nNode);
    int i, nCount = CountList(sConditions);
    Debug("Running dialog conditions for " + DialogNodeToString(sPage, nNode) + ": " + sConditions);

    for (i = 0; i < nCount; i++)
    {
        sCondition = GetListItem(sConditions, i);
        SetDialogPage(sPage);
        SetDialogNode(nNode);
        if (!RunLibraryScript(sCondition))
        {
            Debug("  Failure: did not meet condition " + sCondition);
            return FALSE;
        }
    }

    Debug("  Success: all conditions passed");
    return TRUE;
}

void RunDialogActions(string sPage = "", int nNode = -1)
{
    string sActions = GetDialogActions(sPage, nNode);
    Debug("Running dialog actions for " + sPage +
         (nNode >= 0 ? "@" + IntToString(nNode) : "" ) + ": " + sActions);
    RunLibraryScripts(sActions);
}

int BuildDialogResponseList(string sPage)
{
    // Clean up any old response list
    DeleteIntList(DLG_SELF, DLG_RESPONSE);
    DeleteLocalInt(DLG_SELF, DLG_RESPONSE);
    Debug("Building response list for " + sPage);

    // Add automatic continue node
    string sTargets = GetDialogTargets(sPage);
    if (sTargets != "")
    {
        Debug("Adding Continue response with targets: " + sTargets);
        AddListInt(DLG_SELF, DLG_NODE_CONTINUE, DLG_RESPONSE);
    }

    // Add all explicit dialog nodes
    int i, nCount = CountDialogNodes(sPage);
    for (i = 0; i < nCount; i++)
    {
        if (RunDialogConditions(sPage, i))
        {
            Debug("Adding " + sPage + "@" + IntToString(i) + " to response list");
            AddListInt(DLG_SELF, i, DLG_RESPONSE);
        }
    }


    return CountIntList(DLG_SELF, DLG_RESPONSE);
}

int FetchDialogResponse()
{
    int nResponse = GetLocalInt(DLG_SELF, DLG_RESPONSE);
    SetLocalInt(DLG_SELF, DLG_RESPONSE, nResponse + 1);
    return nResponse;
}

int ChooseDialogNode(int nIndex)
{
    string sPage = GetDialogPage();
    int nCount = CountIntList(DLG_SELF, DLG_RESPONSE);
    if (nIndex >= nCount)
        return DLG_NODE_NONE;

    return GetListInt(DLG_SELF, nIndex, DLG_RESPONSE);
    /*
    int nMax = GetDialogInt(DLG_MAX_RESPONSES, sPage);

    if (nIndex >= nMax)
        return 0;

    int nCount = CountIntList(DLG_SELF, sPage);
    int nOffset = GetDialogInt(DLG_OFFSET, sPage);
    int bReset = GetDialogResetEnabled(sPage);
    int bEnd = GetDialogEndEnabled(sPage);

    // Determine how many non-automated responses we have space for
    nMax -= bReset;                    // Reserve space for Reset
    nMax -= bEnd;                      // Reserve space for End
    nMax -= (nOffset > 0);             // Reserve space for Previous
    nMax -= (nCount - nOffset > nMax); // Reserve space for Next

    */
}








// ----- Accessor Functions ----------------------------------------------------

int GetDialogState()
{
    return GetLocalInt(DLG_SELF, DLG_STATE);
}

void SetDialogState(int nState)
{
    SetLocalInt(DLG_SELF, DLG_STATE, nState);
}

string GetDialogPage()
{
    return GetLocalString(DLG_SELF, DLG_PAGE);
}

void SetDialogPage(string sPage)
{
    SetLocalString(DLG_SELF, DLG_PAGE, sPage);
}

int GetDialogNode()
{
    return GetLocalInt(DLG_SELF, DLG_SELECTION);
}

void SetDialogNode(int nNode)
{
    SetLocalInt(DLG_SELF, DLG_SELECTION, nNode);
}
