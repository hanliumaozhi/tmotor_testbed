classdef InfoS < matlab.System
    % info
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties

    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)
        hs = 0;
        motor_torque = 0;
        load_speed = 0;
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function [hss, motor_torque, load_speed] = stepImpl(obj, t, ecat_status)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            if t > 1 && ecat_status > 7 
                obj.hs = obj.hs + 1;
                obj.motor_torque = -10*sin(2.0*3.1415926*(obj.hs/100.0));
                %obj.motor_torque = 6;
                obj.load_speed = 0;
            end
            load_speed = obj.load_speed;
            hss = obj.hs;
            motor_torque = obj.motor_torque;
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
        
        function [name_1,name_2,name_3] = getOutputNamesImpl(~)
            %GETOUTPUTNAMESIMPL Return output port names for System block
            name_1 = 'hss';
            name_2 = 'motor_torque';
            name_3 = 'load_speed';
        end % getOutputNamesImpl
        % PROPAGATES CLASS METHODS ============================================
        function [out_1,out_2,out_3] = getOutputSizeImpl(~)
            %GETOUTPUTSIZEIMPL Get sizes of output ports.          
            out_1 = [1, 1];
            out_2 = [1, 1];
            out_3 = [1, 1];
        end % getOutputSizeImpl
        
        function [out_1,out_2,out_3] = getOutputDataTypeImpl(~)
            %GETOUTPUTDATATYPEIMPL Get data types of output ports.         
            out_1 = 'double';
            out_2 = 'double';
            out_3 = 'double';
        end % getOutputDataTypeImpl
        
        function [out_1,out_2,out_3] = isOutputComplexImpl(~) 
            %ISOUTPUTCOMPLEXIMPL Complexity of output ports.         
            out_1 = false;
            out_2 = false;
            out_3 = false;
        end % isOutputComplexImpl
        
        function [out_1,out_2,out_3] = isOutputFixedSizeImpl(~)
            %ISOUTPUTFIXEDSIZEIMPL Fixed-size or variable-size output ports.
            out_1 = true;
            out_2 = true;
            out_3 = true;
        end % isOutputFixedSizeImpl
    end
end
