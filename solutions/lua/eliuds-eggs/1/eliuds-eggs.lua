local EliudsEggs = {}

function EliudsEggs.egg_count(number)
    ctr = 0;
    while number ~= 0 do
      if number % 2 ~= 0 then
        ctr = ctr + 1;
      end;
      number = number >> 1;
    end;
    return ctr;
end

return EliudsEggs
