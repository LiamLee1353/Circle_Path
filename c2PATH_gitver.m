

function c2PATH_gitver(r1,r2,w1,w2,varargin)

% set default values
t_max = 30;
angle_measure = 'radians';
samplerate = 30; %Hz


% Input error catch + help
if nargin == 0
    disp('inputs are: (r1,r2,w1,w2)')
    disp('default reads rad/s at 30Hz for 30s')
    disp('OPTIONAL INPUTS:')
    disp('t_max --> number of seconds to run figure')
    disp('angle_measure --> omega expressed in degrees or radians')
    disp('samplerate --> refresh rate of animation figure')
    disp('EXAMPLE:')
    disp('c2PATH_gitver(2,1,.33,1,''t_max'',30,''angle_measure'',''radians'')')
    return
elseif mod(nargin,2) ~= 0
    error('Please input argument pairs')
end


% Handle optional arguments
for i = 1:2:length(varargin)
    Param = varargin{i};
    Value = varargin{i+1};

    % Throw error if arg is invalid
    if ~ischar(Param)
        disp(['ERROR using optional Argument ' num2str(i)])
        error('Argument flags must be strings')
    end




    % Handle Optional Arguments

    Param = lower(Param);

    switch Param

        case 't_max'
            if size(Value,1) ~= 1 || size(Value,2) ~=1
                error('Please define ONE max time!')
            elseif ~isnumeric(Value)
                error('Please input t_max as a numeric')
            end
            t_max = Value;

        case 'angle_measure'
            if strcmp(Value,'radians')
            elseif strcmp(Value,'degrees')
            elseif strcmp(Value,'radian')
            elseif strcmp(Value,'degree')
            else
                disp(Value)
                error('This isnt an angle measure!')
            end
            angle_measure = Value;

        case 'samplerate'
            if size(Value,1) ~= 1 || size(Value,2) ~= 1
                error('Please input ONE samplerate')
            elseif ~isnumeric(Value)
                error('Please input a numeric for samplerate')
            end
            samplerate = Value;
    end


end

% Initialize Calculation Components
t_vec = linspace(0,t_max-(1/samplerate),t_max*samplerate);


if strcmp(angle_measure,'radians') || strcmp(angle_measure,'radian')
    omega = 360*([w1 w2]/(2*pi))';
else
    omega = [w1 w2]';
end


theta = zeros(2,length(t_vec));

r = [r1 r2];


% Calculate
for i = 1:length(t_vec)
    theta(:,i) = t_vec(i) * omega;
end

x = r*cos(theta);
y = r*sin(theta);
pos = [sum(x,1);sum(y,1)];

% PLOT
figure()
fig = animatedline;
for i = 1:size(pos,2)
    addpoints(fig,pos(1,i),pos(2,i))
    pause(1/samplerate)
end
