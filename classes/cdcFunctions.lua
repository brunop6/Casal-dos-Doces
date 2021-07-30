local cdc = {}

function cdc.cbc(cbcLenght)
    local line = "-\n"
	local txt = "CASAL DOS DOCES"

	while(string.len(line) < cbcLenght) do
		line = "-"..line
	end
	while(string.find(txt, "O") < (math.floor(cbcLenght/2)))do
		txt = " "..txt
	end

    os.execute("cls")
    print(txt)
	print(line)
	local str = txt.."\n"..line
	return str
end

function cdc.formatStrLenDot(str, strMax)
	repeat
		str = str.."."
	until(string.len(str) == strMax)
	
	return str
end

function cdc.formatStrLen(str, strMax)
	repeat
		str = str.." "
	until(string.len(str) == strMax)
	
	return str
end

function cdc.pm(m) -- Print Money
	return string.format("R$%.2f", m)
end

function cdc.sleep(sec)
	local start = os.time()
	repeat 
	
	until(os.time() >= start + sec)	
end

function cdc.readFile(fileName)
	file = io.open(fileName, "r")
	
	for line in file:lines() do
		print(line)
	end
	
	file:close()
end

return cdc
