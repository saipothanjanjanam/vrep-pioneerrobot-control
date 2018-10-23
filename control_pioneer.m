vrep=remApi('remoteApi');
vrep.simxFinish(-1);
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID>-1)
    % Function handles which handles the actuators and sensors i.e., like assigning
    disp('Connection successful');
    [returnCode, Left_Motor] = vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_leftMotor', vrep.simx_opmode_blocking); 
    [returnCode, f_sensor] = vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_ultrasonicSensor5', vrep.simx_opmode_blocking);
    [returnCode, camera] = vrep.simxGetObjectHandle(clientID, 'Vision_sensor', vrep.simx_opmode_blocking);
      
   
    % Below codes to run the bot in VREP
    [returnCode] = vrep.simxSetJointTargetVelocity(clientID, Left_Motor, 0.5, vrep.simx_opmode_blocking);
     
    [returnCode, detectionState, detectedPoint,~,~] = vrep.simxReadProximitySensor(clientID,f_sensor,vrep.simx_opmode_streaming);
    
    [returnCode,resolution,image] = vrep.simxGetVisionSensorImage2(clientID,camera,1,vrep.simx_opmode_streaming);
   
    while 1 
       pause(0.1);
       
       disp(norm(detectedPoint));
       
       [returnCode, detectionState, detectedPoint,~,~] = vrep.simxReadProximitySensor(clientID,f_sensor,vrep.simx_opmode_buffer);
       
       [returnCode,resolution,image]=vrep.simxGetVisionSensorImage2(clientID,camera,1,vrep.simx_opmode_buffer);
       
       imshow(image)
    end
    
    vrep.simxFinish(-1);
end

vrep.delete();
    
    