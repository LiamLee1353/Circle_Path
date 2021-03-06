# Circle_Path
This is a MATLAB function that essentially traces a path using what amounts to a double pendulum (just without gravity). This was created under instruction from JobertoLee.com. The idea is that one arm travels around the origin while another arm spins on the end of the first arm. The length and angular velocity are inputs to the function, which returns a live figure that renders according to the sample rate. 


## Theory
In the words of Joberto Lee, "This is your introduction to dynamics". While this problem seems complex at the surface, it's really just a time-discrete version of vector addition. Imagine the path of each arm as the edge of a circle, where the arms themselves are just vectors pointing to where the edge is at that specific point in time. This is simplified further by the fact that each one arm to stuck to the end of the other, so the end position of the "double pendulum" is simply the two position vectors added together. 

![c2PATH Theory](https://github.com/LiamLee1353/Circle_Path/blob/master/c2PATH%20Theory.jpg)


## Documentation 
The line to call the function is as follows: 
> c2PATH_gitver(r1,r2,w1,w2)

Which is input directly into the matlab command line. *r1* and *r2* respectively are the lengths of the arms and *w1* and *w2* are the respective angular velocities. 
The function can also be called without any inputs, which displays further details and includes an example that you can run. 

> c2PATH_gitver() 

Optional input parameters are input as paramater/value pairs: 

> c2PATH_gitver(2,1,.33,1,'(PARAMETER)','(VALUE)'

The default values are as below: 

- Sample Rate
  - 30 Hz
- Time Maximum 
  - 30 seconds
- Angle Measurement System 
  - Radians


## Code

The actual code runs using MATLAB's easy-to-use array operations. 

```
r = [r1 r2];
omega = [w1 w2]';


t_vec = linspace(0,t_max-(1/samplerate),t_max*samplerate);

for i = 1:length(t_vec)
    theta(:,i) = t_vec(i) * omega;
end

x = r*cos(theta);
y = r*sin(theta);
pos = [sum(x,1);sum(y,1)];

```

The above code is the core of this particular script. It's rather simple, so it's consequently easy to follow. First, a vector of timepoints is created using the sample rate and the maximum specified time. Next, an array of angles at different time points is created using the angular velocities. Then, the *x* and *y* components for each vector is computed, and added together to create the final array storing the position vectors. 

```
figure()
fig = animatedline;
for i = 1:size(pos,2)
    addpoints(fig,pos(1,i),pos(2,i))
    pause(1/samplerate)
end
```

Next, an "animated line" figure is created, where each point and it's connecting line is added at time intervals of 1/(samplerate). 


As for the optional inputs, a switch/case structure was used in a for loop to examine each paramater/value pair and set the new values for sample rate, etc., accordingly. Each case has it's own error checks to better improve user experience. 

```
for i = 1:2:length(varargin)
    Param = varargin{i};
    Value = varargin{i+1};
    
    
     Param = lower(Param);

    switch Param

        case 't_max'
            if size(Value,1) ~= 1 || size(Value,2) ~=1
                error('Please define ONE max time!')
            elseif ~isnumeric(Value)
                error('Please input t_max as a numeric')
            end
            t_max = Value;
            
            (etc...)
            
      end
      
 end

```


## Results

The results of this quick snippet of code are well worth the effort. The different geometric patterns that arise from playing around with the radii, angular velocities, and sampling rate are gorgeous, at times reminiscent of flowers. 

![c2PATH Result](https://github.com/LiamLee1353/Circle_Path/blob/master/PATH.jpg)

Very pretty! 
