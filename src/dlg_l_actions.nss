// -----------------------------------------------------------------------------
//    File: dlg_l_actions.nss
//  System: Dynamic Dialogs (library script)
//     URL: https://github.com/squattingmonk/sm-dialogs
// Authors: Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>
// -----------------------------------------------------------------------------
// This library holds commonly used actions supplied by the Dynamic Dialogs
// system. You can use these scripts as actions in your dialog bu passing their
// names to the AddDialogPage(), AddDialogNode(), or SetDialogActions()
// functions in your dialog's library script. You can use this script as a
// template to make your own dialog actions.
// -----------------------------------------------------------------------------

#include "util_i_library"
#include "dlg_i_main"

void dlg_Action_Animation()
{
    string sPage = GetDialogPage();
    int nNode = GetDialogNode();
    int nAnimation = GetDialogInt(DLG_ACTION_ANIMATION, sPage, nNode);
    object oTarget = GetDialogObject(DLG_ACTION_ANIMATION, sPage, nNode);

    if (!GetIsObjectValid(oTarget))
        oTarget = OBJECT_SELF;

    AssignCommand(oTarget, ActionPlayAnimation(nAnimation));
    Debug(GetName(oTarget) + " is playing animation " + IntToString(nAnimation));
}

void OnLibraryLoad()
{
    RegisterLibraryScript(DLG_ACTION_ANIMATION);
}

void OnLibraryScript(string sScript, int nEntry)
{
    if (sScript == DLG_ACTION_ANIMATION) dlg_Action_Animation();
}
