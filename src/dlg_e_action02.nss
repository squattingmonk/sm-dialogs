// -----------------------------------------------------------------------------
//    File: dlg_e_action02.nss
//  System: Dynamic Dialogs (dialog node action script)
//     URL: https://github.com/squattingmonk/sm-dialogs
// Authors: Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>
// -----------------------------------------------------------------------------

#include "dlg_i_main"

void main()
{
    string sPage = GetDialogPage();
    int nNode = GetListInt(DLG_SELF, 1, DLG_RESPONSE);

    if (nNode >= 0)
    {
        SetDialogNode(nNode);
        RunDialogActions(sPage, nNode);
    }
}
