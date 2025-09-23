local is_leap_year = function(number)
  if number == nil then
    return false;
  end;
  
  if number % 100 ~= 0 and number % 4 == 0 then
    return true;
  elseif number % 100 == 0 and number % 400 == 0 then
    return  true;
  else
    return false;
  end;
end

return is_leap_year
