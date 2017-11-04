Data dictionary for Result.txt

subject  
		subject identification number 
        values: 1 : 30 
 
activity  
		type of physical activity 
		values: LAYING 
		        STANDING 
				SITTING 
				WALKING 
				WALKING_DOWNSTAIRS 
				WALKING_UPSTAIRS 
 
domain  
		domain of registered signal, time or frequency 
		values: freq 
				time    

signal 
		type of registered signal, body or gravity 
		values: body 
				gravity 
 
device  
		device used to register signal, accelerometer or gyroscope 
		values: accelerometer 
				gyroscope 
 
jerk_signal 
		logical indicator for the signal being jerk signal   
		values: FALSE / TRUE 
  
signal_magnitude  
		logical indicator for the magnitude of 3-dimentional signal 
		values: FALSE / TRUE 
 
axis 
		3-dimentional axis, the direction of the signal 
		values: X 
				Y 
				Z 
  
average.of.mean 
		average of the mean of the signal, normalized from -1 to 1 
		values: -0.9976174 : 0.9745087 
 
average.of.std 
		average of the standard deviation of the signal, normalized from -1 to 1 
		values: -0.9976661  0.6871242   

		