function ret = runApp()
  [dir, name, ext] = fileparts( mfilename('fullpathext') );
  global _octavelogerBasePath = dir;
  global _octavelogerImgPath = [dir filesep() 'img'];
  addpath([dir filesep() "libs" ]);
  addpath([dir filesep() "fcn" ]);
  addpath([dir filesep() "wnd" ]);
  waitfor(MainDialog().figure);
end
