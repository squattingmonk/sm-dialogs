// -----------------------------------------------------------------------------
//    File: dlg_e_check.nss
//  System: Dynamic Dialogs (starting conditional script)
//     URL: https://github.com/squattingmonk/sm-dialogs
// Authors: Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>
// -----------------------------------------------------------------------------
// This script handles the display of PC dialog nodes. It should be placed on
// the Text Appears When slot of each PC dialog node.
// -----------------------------------------------------------------------------

#include "dlg_i_main"

int StartingConditional()
{
    string sPage  = GetDialogPage();
    int    nResponse = FetchDialogResponse();
    int    nNode  = ChooseDialogNode(nResponse);
    string sText;

    // Handle auto nodes
    switch (nNode)
    {
        case DLG_NODE_NONE:
            return FALSE;
            break;

        case DLG_NODE_CONTINUE:
            sText = GetDialogLabel(DLG_LABEL_CONTINUE, sPage);
            break;

        default:
            sText = GetDialogText(sPage, nNode);
    }

    Debug("  Setting response " + IntToString(nResponse) + " to " + DialogNodeToString(sPage, nNode));
    SetCustomToken(DLG_TOKEN + nResponse + 1, sText);
    return TRUE;
}
