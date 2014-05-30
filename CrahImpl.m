classdef CrahImpl < CoolingEquipmentImpl
        
    properties
        supplyTemperature = 0;
        airflow = 0
        isDucted = true;
        isDeactivated = false;
        airflowMinimum = 0;
        airflowMaximum = 0;
    end
    
    methods
        
        %constructor
        function crah = CrahImpl(name, width, height, depth, positionX, positionZ, orientation, supplyTemperature, airflow, isDucted)
            crah@CoolingEquipmentImpl(name, width, height, depth, positionX, positionZ, orientation);
            crah.supplyTemperature = str2double(supplyTemperature);
            crah.airflow = str2double(airflow);
            
            if (strcmpi(isDucted, 'NO')) 
                crah.isDucted = false;
            else
                crah.isDucted = true;
            end
        end
        
        function setSupplyTemperatureOfCrah(crah, supplyTemperature)
            crah.supplyTemperature = str2double(supplyTemperature);
        end
        
        function setAirflowOfCrah(crah, airflow)
            crah.airflow = str2double(airflow);
        end
        
        function setAirflowMinimumOfCrah(crah, airflowMinimum)
            crah.airflowMinimum = airflowMinimum;
        end
        
        function setAirflowMaximumOfCrah(crah, airflowMaximum)
            crah.airflowMaximum = airflowMaximum;
        end
        
        function setDuctPropertyOfCrah(crah, isDucted)
            if(isDucted == ture || isDucted == false)
                crah.isDucted = isDucted;
            else
                disp('value passed for ducted property is not boolean or not in lower case i.e. true/false')
            end
        end
        
        function deactivateCrah(crah, isDeactivated)
            crah.isDeactivated = isDeactivated;
        end 
    end
end

