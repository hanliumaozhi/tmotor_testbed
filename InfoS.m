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
        speed_state = 0;
        torque_state = 0;
        pre_time = 0;
        is_first = 1;
        speed_list = [0 1 2 3 4 5 6 7 8 9 10 11 10 9 8 7 6 5 4 3 2 1 0 ...
            -1 -2 -3 -4 -5 -6 -7 -8 -9 -10 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0];
        torque_list = [0 1 2 3 4 5 6];
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function [hss, motor_torque, load_speed, speed_state, torque_state] = stepImpl(obj, t, ecat_status)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            if t > 1 && ecat_status > 7
                if obj.is_first > 0.5
                    obj.is_first = 0;
                    obj.pre_time = t;
                    obj.speed_state = 1;
                    obj.torque_state = 1;
                end
                obj.hs = obj.hs + 1;
                if t > (obj.pre_time+4)
                    % switch
                    if obj.torque_state == 7
                        if obj.speed_state == 45
                            obj.speed_state = 45;
                            obj.torque_state = 1;
                        else
                            obj.speed_state = obj.speed_state + 1;
                            obj.torque_state = 1;
                        end
                        obj.pre_time = t;
                    else
                        obj.pre_time = t;
                        obj.torque_state = (obj.torque_state + 1);
                    end
                end
                obj.motor_torque = obj.torque_list(obj.torque_state);
                obj.load_speed = obj.speed_list(obj.speed_state);
            end
            load_speed = obj.load_speed;
            hss = obj.hs;
            motor_torque = obj.motor_torque;
            speed_state = obj.speed_state;
            torque_state = obj.torque_state;
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
        
        function [name_1,name_2,name_3,name_4,name_5] = getOutputNamesImpl(~)
            %GETOUTPUTNAMESIMPL Return output port names for System block
            name_1 = 'hss';
            name_2 = 'motor_torque';
            name_3 = 'load_speed';
            name_4 = 'speed_state';
            name_5 = 'torque_state';
        end % getOutputNamesImpl
        % PROPAGATES CLASS METHODS ============================================
        function [out_1,out_2,out_3,out_4,out_5] = getOutputSizeImpl(~)
            %GETOUTPUTSIZEIMPL Get sizes of output ports.          
            out_1 = [1, 1];
            out_2 = [1, 1];
            out_3 = [1, 1];
            out_4 = [1, 1];
            out_5 = [1, 1];
        end % getOutputSizeImpl
        
        function [out_1,out_2,out_3,out_4,out_5] = getOutputDataTypeImpl(~)
            %GETOUTPUTDATATYPEIMPL Get data types of output ports.         
            out_1 = 'double';
            out_2 = 'double';
            out_3 = 'double';
            out_4 = 'double';
            out_5 = 'double';
        end % getOutputDataTypeImpl
        
        function [out_1,out_2,out_3,out_4,out_5] = isOutputComplexImpl(~) 
            %ISOUTPUTCOMPLEXIMPL Complexity of output ports.         
            out_1 = false;
            out_2 = false;
            out_3 = false;
            out_4 = false;
            out_5 = false;
        end % isOutputComplexImpl
        
        function [out_1, out_2, out_3, out_4, out_5] = isOutputFixedSizeImpl(~)
            %ISOUTPUTFIXEDSIZEIMPL Fixed-size or variable-size output ports.
            out_1 = true;
            out_2 = true;
            out_3 = true;
            out_4 = true;
            out_5 = true;
        end % isOutputFixedSizeImpl
    end
end
