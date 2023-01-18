## -*- texinfo -*-
## @deftypefn  {} {@var{wnd} =} GNU_Octave_Logger ()
##
## Create and show the dialog, return a struct as representation of dialog.
##
## @end deftypefn
function wnd = GNU_Octave_Logger()
  GNU_Octave_Logger_def;
  wnd = show_GNU_Octave_Logger();
  GNU_Octave_Logger_thread(wnd);

end
