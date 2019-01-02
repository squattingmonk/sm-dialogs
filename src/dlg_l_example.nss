// -----------------------------------------------------------------------------
//    File: dlg_l_example.nss
//  System: Dynamic Dialogs (library script)
//     URL: https://github.com/squattingmonk/sm-dialogs
// Authors: Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>
// -----------------------------------------------------------------------------
// A dialog has the following events:
// - INIT: the dialog's responses are mapped and cached for later retrieval
// - PAGE:

#include "dlg_i_main"
#include "util_i_library"

// ----- Poet Dialog -----------------------------------------------------------

const string POET_DIALOG       = "PoetDialog";

const string POET_PAGE_MAIN    = "POET_PAGE_MAIN";
const string POET_PAGE_BYE     = "POET_PAGE_BYE";
const string POET_PAGE_EXPLAIN = "POET_PAGE_EXPLAIN";
const string POET_PAGE_FINISH  = "POET_PAGE_FINISH";
const string POET_PAGE_KILL    = "POET_PAGE_KILL";
const string POET_PAGE_MARY    = "POET_PAGE_MARY";
const string POET_PAGE_POOR    = "POET_PAGE_POOR";
const string POET_PAGE_SICK    = "POET_PAGE_SICK";

const string POET_ACTION_KILL = "PoetDialog_Action_Kill";

void PoetDialog()
{
    // Show the landing page and wave to the player
    SetDialogTargets(POET_PAGE_MAIN);
    SetDialogActions(DLG_ACTION_ANIMATION);
    SetDialogInt    (DLG_ACTION_ANIMATION, ANIMATION_FIREFORGET_GREETING);

    // Main landing page
    AddDialogPage(POET_PAGE_MAIN, "Would you like to hear a poem? 1GP per recital!");
    AddDialogNode(POET_PAGE_MAIN, "Who are you?", POET_PAGE_EXPLAIN);
    AddDialogNode(POET_PAGE_MAIN, "Mary Had A Little Lamb", POET_PAGE_MARY);
    AddDialogNode(POET_PAGE_MAIN, "Sick", POET_PAGE_SICK);
    AddDialogNode(POET_PAGE_MAIN, "Goodbye", POET_PAGE_BYE);

    // PC asked "Who are you?"
    AddDialogPage(POET_PAGE_EXPLAIN, "I am demonstrating a dynamic dialog using " +
            "continued pages. Continued pages are used when you need to have " +
            "several pages of dialog in a row with a continue button in between.");
    ContinueDialogPage(POET_PAGE_EXPLAIN, "To continue a page, use the " +
            "ContinueDialogPage() function on the parent page. Do this as many " +
            "times as needed to add sufficient responses.");
    ContinueDialogPage(POET_PAGE_EXPLAIN, "You can, at your option, add additional " +
            "nodes to the pages or enable exit or reset responses. In this example, " +
            "I get mad and attack you if you interrupt my beautiful poetry, so I " +
            "suggest not doing that.");
    ContinueDialogPage(POET_PAGE_EXPLAIN, "If you want the final message to link " +
            "to a different page once the continued page is through, you can set " +
            "a target for the added page. That's what links the continue node " +
            "below to the main page.", POET_PAGE_MAIN);

    // PC chose poem "Mary had a little lamb"
    string sTarget;
    AddDialogPage(POET_PAGE_MARY,
            "Mary had a little lamb,\nLittle lamb,\nLittle lamb.\n" +
            "Mary had a little lamb.\nIts fleece was white as snow.");
    sTarget = ContinueDialogPage(POET_PAGE_MARY,
            "Everywhere that Mary went,\nMary went,\nMary went,\n" +
            "Everywhere that Mary went,\nThe lamb was sure to go.");
    EnableDialogEnd("I've had enough of this. Good day!", sTarget);
    sTarget = ContinueDialogPage(POET_PAGE_MARY,
            "It followed her to school one day,\nSchool one day,\nSchool one day,\n" +
            "It followed her to school one day,\nWhich was against the rules.");
    EnableDialogEnd("Boooooring! Learn to recite poetry!", sTarget);
    sTarget = ContinueDialogPage(POET_PAGE_MARY,
            "It made the children laugh and play,\nLaugh and play,\nLaugh and play,\n" +
            "It made the children laugh and play,\nTo see a lamb at school.", POET_PAGE_FINISH);
    EnableDialogEnd("Finally finished. Took you long enough!", sTarget);
    SetDialogAbortActions(POET_ACTION_KILL, POET_PAGE_MARY);
    SetDialogEndActions  (POET_ACTION_KILL, POET_PAGE_MARY);


    // PC chose poem "Sick"
    AddDialogPage(POET_PAGE_SICK,
            "I cannot go to school today,\nSaid little Peggy Ann McKay.\n" +
            "I have the measles and the mumps,\nA gash, a rash and purple bumps.");
    ContinueDialogPage(POET_PAGE_SICK,
            "My mouth is wet, my throat is dry,\n I'm going blind in my right eye.\n" +
            "My tonsils are as big as rocks,\nI've counted sixteen chicken pox\n" +
            "And there's one more--that's seventeen,\nAnd don't you think my face looks green?");
    ContinueDialogPage(POET_PAGE_SICK,
            "My leg is cut--my eyes are blue--\n It might be instamatic flu.\n" +
            "I cough and sneeze and gasp and choke,\n I'm sure that my left leg is broke--\n" +
            "My hip hurts when I move my chin,\n My belly button's caving in.");
    sTarget = ContinueDialogPage(POET_PAGE_SICK,
            "My back is wrenched, my ankle's sprained,\n My 'pendix pains each time it rains.\n" +
            "My nose is cold, my toes are numb.\n I have a sliver in my thumb.\n" +
            "My neck is stiff, my voice is weak,\n I hardly whisper when I speak.");
    AddDialogNode(sTarget, "I've had enough of this. Good day!", POET_PAGE_KILL);
    sTarget = ContinueDialogPage(POET_PAGE_SICK,
            "My tongue is filling up my mouth,\n I think my hair is falling out.\n" +
            "My elbow's bent, my spine ain't straight,\n My temperature is one-o-eight.\n" +
            "My brain is shrunk, I cannot hear,\n There is a hole inside my ear.");
    AddDialogNode(sTarget, "Boooooring! Learn to recite poetry!", POET_PAGE_KILL);
    sTarget = ContinueDialogPage(POET_PAGE_SICK,
            "I have a hangnail, and my heart is--what?\n What's that? What's that you say?\n" +
            "You say today is... Saturday?\nG'bye, I'm going out to play!", POET_PAGE_FINISH);
    AddDialogNode(sTarget, "Finally finished. Took you long enough!", POET_PAGE_KILL);

   // PC insulted the poetry
    AddDialogPage(POET_PAGE_KILL, "You'll pay for that!");
    SetDialogActions(DLG_ACTION_ATTACK,                 POET_PAGE_KILL);
    SetDialogObject (DLG_ACTION_ATTACK, GetPCSpeaker(), POET_PAGE_KILL);

    // PC said "Goodbye"
    AddDialogPage(POET_PAGE_BYE, "Perhaps another time, then? Good day!");
    SetDialogActions(DLG_ACTION_ANIMATION,                                POET_PAGE_BYE);
    SetDialogInt    (DLG_ACTION_ANIMATION, ANIMATION_FIREFORGET_GREETING, POET_PAGE_BYE);

    // Ensure all poem nodes have the proper targets. Ideally we would do this
    // by passing parameters to the page and node creation functions, but I want
    // to show this off.
    int i, nCount = CountDialogNodes(POET_PAGE_MAIN);
    for (i = 1; i < nCount; i++)
    {
        sTarget = GetDialogTargets(POET_PAGE_MAIN, i);

        // Add a condition to each poem: the PC must have 1GP
        SetDialogConditions(DLG_CONDITION_PC_HAS_GP,    sTarget);
        SetDialogInt       (DLG_CONDITION_PC_HAS_GP, 1, sTarget);

        // Add an action to each poem: take 1GP from the PC
        SetDialogActions(DLG_ACTION_TAKE_GP,    sTarget);
        SetDialogInt    (DLG_ACTION_TAKE_GP, 1, sTarget);

        // If the condition is not met, fall through to POET_PAGE_POOR
        sTarget = AddListItem(sTarget, POET_PAGE_POOR);
        SetDialogTargets(sTarget, POET_PAGE_MAIN, i);
    }

    // Poem is finished
    AddDialogPage(POET_PAGE_FINISH, "I hope you enjoyed it! Would you like to " +
            "hear another poem? Only 1GP per recital!");
    CopyDialogNodes(POET_PAGE_MAIN, POET_PAGE_FINISH);

    // PC does not have enough money to listen to the chosen poem.
    AddDialogPage(POET_PAGE_POOR, "Oh, I'm sorry. It seems you don't have enough " +
            "coin on you. Perhaps another time then?");
    AddDialogNode(POET_PAGE_POOR, "Can you tell me who you are instead?", POET_PAGE_EXPLAIN);
 }

void OnLibraryLoad()
{
    RegisterLibraryScript(POET_DIALOG);
}

void OnLibraryScript(string sScript, int nEntry)
{
    if (sScript == POET_DIALOG) PoetDialog();
}
