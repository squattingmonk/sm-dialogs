// -----------------------------------------------------------------------------
//    File: dlg_l_conditions.nss
//  System: Dynamic Dialogs (library script)
//     URL: https://github.com/squattingmonk/sm-dialogs
// Authors: Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>
// -----------------------------------------------------------------------------
// This library holds commonly used conditions supplied by the Dynamic Dialogs
// system. You can use these scripts as conditions in your dialog by passing
// their names to the AddDialogPage(), AddDialogNode(), or SetDialogConditions()
// functions in your dialog's library script. You can use this script as a
// template to make your own dialog conditions.
// -----------------------------------------------------------------------------

#include "util_i_library"
#include "dlg_i_main"


void dlg_Condition_PCHasGP()
{
    object oPC   = GetPCSpeaker();
    string sPage = GetDialogPage();
    int    nNode = GetDialogNode();
    int    nGP   = GetDialogInt(DLG_CONDITION_PC_HAS_GP, sPage, nNode);
    int    bHas  = GetGold(oPC) >= nGP;
    SetLibraryReturnValue(bHas);
    Debug(GetName(oPC) + (bHas ? " has " : "does not have ") + IntToString(nGP) + " GP");
}

void OnLibraryLoad()
{
    RegisterLibraryScript(DLG_CONDITION_PC_HAS_GP);
}

void OnLibraryScript(string sScript, int nEntry)
{
    if (sScript == DLG_CONDITION_PC_HAS_GP) dlg_Condition_PCHasGP();
}

