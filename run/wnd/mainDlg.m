## -*- texinfo -*-
## @deftypefn  {} {@var{wnd} =} mainDlg ()
##
## Create and show the dialog, return a struct as representation of dialog.
##
## @end deftypefn
function wnd = mainDlg()
  mainDlg_def;
  wnd = show_mainDlg();
end
