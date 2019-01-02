// -----------------------------------------------------------------------------
//    File: dlg_e_init.nss
//  System: Dynamic Dialogs (event script)
//     URL: https://github.com/squattingmonk/sm-dialogs
// Authors: Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>
// -----------------------------------------------------------------------------
// This script should be placed in the "Text Appears When" slot of the Dynamic
// Dialogs system's NPC node. It initializes the dialog on first run and chooses
// an appropriate prompt to show the PC.
// -----------------------------------------------------------------------------

#include "dlg_i_main"

int StartingConditional()
{
    int nState = GetDialogState();

    // If the conversation has ended, abort.
    if (nState == DLG_STATE_ENDED)
        return FALSE;

    // Initialize the dialog on first run
    if (nState == DLG_STATE_INIT)
        InitializeDialog();

    // See if we have an appropriate dialog page
    if (InitializeDialogPage())
    {
        string sText = GetDialogText(GetDialogPage());
        SetCustomToken(DLG_TOKEN, sText);
        return TRUE;
    }

    // No dialog page was found
    return FALSE;
}
