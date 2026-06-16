   function fis = type2FLS()
    % Generate new Type-2 fuzzy inference system
    fis = mamfistype2('Name', "turning_angle_fl_type2", 'AndMethod', "prod", 'DefuzzificationMethod', "centroid");
fis.TypeReductionMethod  = "eiasc";   % یا "enhancedKarnikMendel"/iasc/eiasc/karnikmendel/ekm

    % Add inputs
    fis = addInput(fis, [-400 400], 'Name', "turning_angle");
    fis = addInput(fis, [0 40], 'Name', "goalDist");

    % Add outputs
    fis = addOutput(fis, [-15 15], 'Name', "left_voltage");
    fis = addOutput(fis, [-15 15], 'Name', "right_voltage");

    % Add membership functions for turning_angle (as Type-2)
    fis.Inputs(1).MembershipFunctions(1) = fismftype2('trapmf', [-400 -360 -180 0], 'Name', 'Negativeturn');
    fis.Inputs(1).MembershipFunctions(2) = fismftype2('trimf', [-10 0 10], 'Name', 'Threshold');
    fis.Inputs(1).MembershipFunctions(3) = fismftype2('trapmf', [0 180 360 400], 'Name', 'Positiveturn');

    % Add membership functions for goalDist (as Type-2)
    fis.Inputs(2).MembershipFunctions(1) = fismftype2('trapmf', [0 0 1 6],  'Name', 'Small');
    fis.Inputs(2).MembershipFunctions(2) = fismftype2('trimf',  [3 6 9],   'Name', 'Medium');
    fis.Inputs(2).MembershipFunctions(3) = fismftype2('trapmf', [6 9 12 30], 'Name', 'Large');

   
    % Add membership functions for left_voltage (as Type-2)
    fis.Outputs(1).MembershipFunctions(1) = fismftype2('trapmf', [-13.5 -11 -5 -2.5], 'Name', 'Strong_Reverse');
    fis.Outputs(1).MembershipFunctions(2) = fismftype2('trimf', [-5 -2.5 0], 'Name', 'Reverse');
    fis.Outputs(1).MembershipFunctions(3) = fismftype2('trimf', [-2.5 0 2.5], 'Name', 'Neutral');
    fis.Outputs(1).MembershipFunctions(4) = fismftype2('trimf', [0 2.5 5], 'Name', 'Forward');
    fis.Outputs(1).MembershipFunctions(5) = fismftype2('trapmf', [2.5 5 11 13.5], 'Name', 'Strong_Forward');

    % Add membership functions for right_voltage (as Type-2)
    fis.Outputs(2).MembershipFunctions(1) = fismftype2('trapmf', [-13.5 -11 -5 -2.5], 'Name', 'Strong_Reverse');
    fis.Outputs(2).MembershipFunctions(2) = fismftype2('trimf', [-5 -2.5 0], 'Name', 'Reverse');
    fis.Outputs(2).MembershipFunctions(3) = fismftype2('trimf', [-2.5 0 2.5], 'Name', 'Neutral');
    fis.Outputs(2).MembershipFunctions(4) = fismftype2('trimf', [0 2.5 5], 'Name', 'Forward');
    fis.Outputs(2).MembershipFunctions(5) = fismftype2('trapmf', [2.5 5 11 13.5], 'Name', 'Strong_Forward');

    % Define the rules
    rules = ["if goalDist is Large and turning_angle is Threshold     then left_voltage  is Strong_Forward"
"if goalDist is Large and turning_angle is Threshold     then right_voltage is Strong_Forward"
"if goalDist is Large and turning_angle is Negativeturn then left_voltage  is Reverse"
"if goalDist is Large and turning_angle is Negativeturn then right_voltage is Strong_Forward"
"if goalDist is Large and turning_angle is Positiveturn then left_voltage  is Strong_Forward"
"if goalDist is Large and turning_angle is Positiveturn then right_voltage is Reverse"

"if goalDist is Medium and turning_angle is Threshold     then left_voltage  is Forward"
"if goalDist is Medium and turning_angle is Threshold     then right_voltage is Forward"
"if goalDist is Medium and turning_angle is Negativeturn then left_voltage  is Reverse"
"if goalDist is Medium and turning_angle is Negativeturn then right_voltage is Forward"
"if goalDist is Medium and turning_angle is Positiveturn then left_voltage  is Forward"
"if goalDist is Medium and turning_angle is Positiveturn then right_voltage is Reverse"

"if goalDist is Small and turning_angle is Threshold     then left_voltage  is Forward"
"if goalDist is Small and turning_angle is Threshold     then right_voltage is Forward"
"if goalDist is Small and turning_angle is Negativeturn then left_voltage  is Reverse"
"if goalDist is Small and turning_angle is Negativeturn then right_voltage is Forward"
"if goalDist is Small and turning_angle is Positiveturn then left_voltage  is Forward"
"if goalDist is Small and turning_angle is Positiveturn then right_voltage is Reverse"
    ];

    fis = addRule(fis, rules);
   end
  %% ===== رسم تابع‌های عضویت ورودی‌ها برای fis (بنفسى) =====
% for inIdx = 1:2   % دو تا ورودی: turning_angle و goalDist
%     figure;
%     plotmf(fis,'input',inIdx);
%     ax = gca;
%     title(ax, '');   % یا: ax.Title.String = '';
% 
%     % خطوط ضخیم‌تر
%     set(findall(ax,'Type','line'),'LineWidth',2.8);
% 
%     % ناحیه عدم قطعیت (FOU) بنفش
%     hPatch = findall(ax,'Type','patch');
%     set(hPatch, 'FaceColor', [0.6 0 0.6], ...  % بنفش
%                  'FaceAlpha', 0.5, ...
%                  'EdgeColor', 'k');
% 
%     % بزرگ کردن نوشته‌های روی ممبرشیپ‌ها
%     txt = findall(ax,'Type','text');
%     set(txt, 'FontSize', 30, ...
%              'FontWeight','bold');
% 
% 
% if inIdx == 1
%         % ورودی اول: Negative / Threshold / Positive
%         for k = 1:numel(txt)
%             s   = string(txt(k).String);
%             pos = txt(k).Position;
% 
%             if contains(s,"Negativeturn","IgnoreCase",true)
%                 pos(1) = pos(1)+80 ;        % کمی به چپ
%             elseif contains(s,"Threshold","IgnoreCase",true)
%                 pos(2) = pos(2) + 0.08;      % کمی بالاتر
%             elseif contains(s,"Positiveturn","IgnoreCase",true)
%                 pos(1) = pos(1) -80;        % کمی به راست
% 
%             end
% 
%             txt(k).Position            = pos;
%             txt(k).HorizontalAlignment = 'center';
%             txt(k).VerticalAlignment   = 'bottom';
%         end
% 
%     else
%         % ورودی دوم: Small / Medium / Large → همگی کمی به راست
%         for k = 1:numel(txt)
%             s   = string(txt(k).String);
%             pos = txt(k).Position;
% 
%             if contains(s,"Small","IgnoreCase",true)
%                 pos(1) = pos(1) + 1.5;   % کمی به راست
%             elseif contains(s,"Medium","IgnoreCase",true)
%                 pos(1) = pos(1) + 1.5;   % کمی به راست
%             elseif contains(s,"Large","IgnoreCase",true)
%                 pos(1) = pos(1) + 1.5;   % کمی به راست
%             end
% 
%             txt(k).Position            = pos;
%             txt(k).HorizontalAlignment = 'center';
%             txt(k).VerticalAlignment   = 'bottom';
%         end
%     end
%     % تنظیم موقعیت لیبل محور x
%     ax.XLabel.Units = 'normalized';
%     posXL = ax.XLabel.Position;
%     posXL(2) = -0.14;
%     ax.XLabel.Position = posXL;
% 
% 
%  % فونت محور و عنوان
%     ax.FontSize   = 28;
%     ax.FontWeight = 'bold';
%     ax.Title.FontSize   = 45;
%     ax.Title.FontWeight = 'bold';
%     ax.XLabel.FontSize  = 40;
%     ax.YLabel.FontSize  = 40;
% end
% 
% %% ===== رسم تابع‌های عضویت خروجی‌ها برای fis (بنفسى) =====
% for outIdx = 1:2   % دو خروجی: left_voltage و right_voltage
%     figure;
%     plotmf(fis,'output',outIdx);
%     ax = gca;
%     title(ax, '');   % یا: ax.Title.String = '';
% 
%     % خطوط ضخیم‌تر
%     set(findall(ax,'Type','line'),'LineWidth',2.8);
% 
%     % ناحیه عدم قطعیت بنفش
%     hPatch = findall(ax,'Type','patch');
%     set(hPatch, 'FaceColor', [0.6 0 0.6], ...
%                  'FaceAlpha', 0.5, ...
%                  'EdgeColor', 'k');
% 
%     % بزرگ کردن لیبل ممبرشیپ‌ها
%     txt = findall(ax,'Type','text');
%     set(txt, 'FontSize', 30, ...
%              'FontWeight','bold');
% 
%     % جداسازی Strong_Reverse / Reverse / Neutral / Forward / Strong_Forward
%     for k = 1:numel(txt)
%         s   = string(txt(k).String);
%         pos = txt(k).Position;
% 
%         % Strong_Reverse کمی چپ
%         if contains(s,"Strong_Reverse","IgnoreCase",true)
%             pos(1) = pos(1)+ 4;
% 
%         % Reverse معمولی یکم چپ
%         elseif contains(s,"Reverse","IgnoreCase",true) && ...
%                ~contains(s,"Strong","IgnoreCase",true)
%             pos(1) = pos(1) - 1;
% 
%         % Neutral کمی راست
%         elseif contains(s,"Neutral","IgnoreCase",true)
%             pos(1) = pos(1) ;
% 
%         % Strong_Forward بیشتر به راست
%         elseif contains(s,"Strong_Forward","IgnoreCase",true)
%             pos(1) = pos(1) -4;
% 
%         % Forward معمولی یکم به راست
%         elseif contains(s,"Forward","IgnoreCase",true) && ...
%                ~contains(s,"Strong","IgnoreCase",true)
%             pos(1) = pos(1) + 1.5;
%         end
% 
%         txt(k).Position            = pos;
%         txt(k).HorizontalAlignment = 'center';
%         txt(k).VerticalAlignment   = 'bottom';
%     end
%     % جداسازی strong_Reverse / Reverse / Neutral / Forward / strong_Forward
%     for k = 1:numel(txt)
%         s   = string(txt(k).String);
%         pos = txt(k).Position;
% 
%         % strong_Reverse کمی چپ
%         if contains(s,"strong_Reverse","IgnoreCase",true)
%             pos(1) = pos(1) - 0;
% 
%         % Reverse معمولی یکم چپ
%         elseif contains(s,"Reverse","IgnoreCase",true) && ...
%                ~contains(s,"strong","IgnoreCase",true)
%             pos(1) = pos(1) - 1;
% 
%         % Neutral → ببَر بیشتر راست
%         elseif contains(s,"Neutral","IgnoreCase",true)
%             pos(1) = pos(1) - 0.5;   % قبلاً 0 بود، حالا 1.5 به راست
% 
% 
%         end
% 
%         txt(k).Position            = pos;
%         txt(k).HorizontalAlignment = 'center';
%         txt(k).VerticalAlignment   = 'bottom';
%     end
% 
%     % تنظیم موقعیت لیبل محور x
%     ax.XLabel.Units = 'normalized';
%     posXL = ax.XLabel.Position;
%     posXL(2) = -0.14;
%     ax.XLabel.Position = posXL;
% 
%  % فونت محور و عنوان
%     ax.FontSize   = 28;
%     ax.FontWeight = 'bold';
%     ax.Title.FontSize   = 45;
%     ax.Title.FontWeight = 'bold';
%     ax.XLabel.FontSize  = 40;
%     ax.YLabel.FontSize  = 40;
% end

% % % سطح خروجیِ ولتاژ چپ بر حسب (turning_angle, goalDist)
% % figure; 
% % gensurf(fis, [1 2], 1, 81);            % [ورودی‌ها]، خروجی=1، رزولوشن=81
% % xlabel('turning\_angle'); ylabel('goalDist'); zlabel('left\_voltage');
% % title('Fuzzy surface: left\_voltage'); grid on; 
% % 
% % % سطح خروجیِ ولتاژ راست
% % figure; 
% % gensurf(fis, [1 2], 2, 81);
% % xlabel('turning\_angle'); ylabel('goalDist'); zlabel('right\_voltage');
% % title('Fuzzy surface: right\_voltage'); grid on;