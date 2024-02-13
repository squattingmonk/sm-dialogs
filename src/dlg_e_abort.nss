/// -----------------------------------------------------------------------------
/// @file   dlg_dialogabort.nss
/// @author Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>
/// @brief  Dynamic Dialogs (event script)
/// -----------------------------------------------------------------------------
/// This script handles abnormal ends for dialogs. It should be placed in the
/// "Aborted" script slot in the Current File tab of the dynamic dialog template
/// conversation.
/// -----------------------------------------------------------------------------

#include "dlg_i_dialogs"

void main()
{
    SendDialogEvent(DLG_EVENT_ABORT);
    DialogCleanup();
}
