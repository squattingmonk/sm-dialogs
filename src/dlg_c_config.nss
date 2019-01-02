// -----------------------------------------------------------------------------
//    File: dlg_c_config.nss
//  System: Dynamic Dialogs (configuation script)
//     URL: https://github.com/squattingmonk/sm-dialogs
// Authors: Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>
// -----------------------------------------------------------------------------
// This is the main configuration script for the Dynamic Dialogs system. It
// contains user-definable toggles and settings. You may alter the values of any
// of the below constants, but do not change the names of the constants
// themselves. This file is consumed by dlg_i_main as an include directive.
// -----------------------------------------------------------------------------

// ----- Automated Response Labels ---------------------------------------------

// All of these labels can be adjusted on a per-dialog or per-page basis using
// SetDialogLabel().

// This is the default label for the automated "Continue" response. This
// response is shown when the current page has been assigned targets. The
// continue node will then redirect to the first target page to pass its
// conditional checks.
const string DLG_DEFAULT_LABEL_CONTINUE = "[Continue]";

// This is the default label for the automated "End Dialog" response. This
// response is shown when SetDialogEnd() is called on the dialog or page.
const string DLG_DEFAULT_LABEL_END = "[End Dialog]";
