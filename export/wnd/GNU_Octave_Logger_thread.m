
function retval = GNU_Octave_Logger_thread(wnd)
  % Default global values
  global isLogging;
  global sampleTime;
  global analogOutputPin;
  global analogInputPin;
  global analogOutputValueSlider;
  global selectedArduino;
  global filePath;
  global viewSamples;
  global minValueCalibration;
  global maxValueCalibration;
  sampleTime = 100;
  analogOutputPin = 'D11';
  analogInputPin = 'A0';
  isLogging = 0;
  analogOutputValueSlider = 0;
  selectedArduino = 0;
  filePath = '';
  viewSamples = 10;
  minValueCalibration = 0;
  maxValueCalibration = 1023;

  % Counter
  counter = 0;

  % File ID
  fid = 0;

  % Plot
  plotIndex = 1;
  analogInPlot = [];
  analogOutPlot = [];
  k = 0;
  m = 0;
  h = 0;

  % Never ending loop
  while(true)
    % Flag
    isFirstLoop = 1;

    % Do logging
    while(isLogging == 1)
      % Create file
      if(isFirstLoop == 1)
        % Create file
        fid = fopen(filePath, 'w');
        header = sprintf("time stamp, sample time, analog in, analog out\n");
        fwrite(fid, header);

        % Focus on plot
        axis(wnd.plot);
        h = plot(rand(2));
        grid on
        plotIndex = 1;
        analogInPlot = [];
        analogOutPlot = [];

        % Calibrate
        k = (maxValueCalibration - minValueCalibration)/1023.0;
        m = maxValueCalibration - k*1023.0;

        % Lock
        isFirstLoop = 0;
      end

      % Sample
      if(counter >= sampleTime)
        % Write a sample

        % Get time stamp
        t = localtime(time());
        timeStamp = sprintf('%i-%i-%iT%i:%i:%i.%iZ', t.year+1900, t.mon+1, t.mday, t.hour, t.min, t.sec, t.usec');

        % Get measurement
        analogIn = k*double(readAnalogPin(selectedArduino, analogInputPin)) + m;

        % Get control signal
        writePWMDutyCycle(selectedArduino, analogOutputPin, analogOutputValueSlider/255.0);

        % Combine them all
        analogOut = floor(analogOutputValueSlider);
        row = sprintf("%s,%s,%s,%s\n", timeStamp, num2str(sampleTime), num2str(analogIn), num2str(analogOut));

        % Write
        fwrite(fid, row);

        % Write to plot
        analogInPlot = [analogInPlot analogIn];
        analogOutPlot = [analogOutPlot analogOut];
        L = 1:length(analogOutPlot);

        %axis(wnd.plot);
        %delete(h);
        %h = plot(L, analogInPlot, L, analogOutPlot);
        set(h, {'YData'}, {analogInPlot; analogOutPlot});
        set(h, {'XData'}, {L; L});
        legend(h, 'Analog in', 'Analog out');
        if(plotIndex >= viewSamples)
          % Remove
          analogInPlot(1) = [];
          analogOutPlot(1) = [];
        else
          plotIndex = plotIndex + 1;
        end

        % Reset counter
        counter = 0;
      else
        counter = counter + 1;
      end

      % Pause 1 ms every time
      pause(0.001);
    end
    % Close file
    if(fid != 0)
      fclose(fid);
      fid = 0;
    end

    % Without this, it's difficult to start the thread
    pause(0.001)
  end
endfunction
