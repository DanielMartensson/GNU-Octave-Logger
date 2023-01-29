function ret = runApp()
  [dir, name, ext] = fileparts( mfilename('fullpathext') );
  global _dplotBasePath = dir;
  global _dplotImgPath = [dir filesep() 'img'];
  addpath([dir filesep() "libs" ]);
  addpath([dir filesep() "fcn" ]);
  addpath([dir filesep() "wnd" ]);
  waitfor(mainDlg().figure);
end
