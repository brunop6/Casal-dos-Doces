local fl = {}
--cdc = require("cdcFunctions")

function fl.readFile(fileName)
	l = {}
	file = io.open(fileName, "r")
	i = 1
	
	for line in file:lines() do
		print(line)
		l[i] = line
		i = i + 1
	end
	file:close()
	return l
end

function fl.editIngred(fileName, cbcLenght)
	repeat
		repeat
			os.execute("cls")
			print("\tINGREDIENTES")
			print("-----------------------------")
			l = fl.readFile(fileName)
			
			print("\n\tMENU\n")
			print("1 - Adicionar Ingrediente")
			print("2 - Editar Ingrediente")
			print("0 - Retornar")
			io.write("Opcao: ")
			optF = io.read()
			
			if(tonumber(optF) == nil) then
				optF = 999
			else
				optF = tonumber(optF)
			end
			
		until(optF >= 0 and optF <= 3)
		
		lastI = 0 	--ULTIMO ÍNDICE
		lastP = 0	--POSIÇÃO DOS DOIS PONTOS (:)
		lastS = 0	--POSIÇÃO DA SETA EM RELAÇÃO AO lastP(>)
		for i, v in pairs(l) do
			lastI = i
			if(i > 1)then
				p = string.find(v, ":")
				local quant = string.sub(v, p)
				s = string.find(quant, ">")
				
				if(p > lastP)then
					lastP = p
				end
				if(s > lastS)then
					lastS = s
				end
			end
		end
		if(optF == 1) then
			cdc.cbc(cbcLenght)
			io.write("Ingrediente........: ")
			ingre = tostring(io.read())
			io.write("Preco..............: R$")
			preco = tostring(io.read())
			preco = string.gsub(preco, ",", ".")
			preco = tonumber(preco)
			io.write("Quantidade comprada: ")
			quant = tostring(io.read()) 
			if(string.find(quant, "%a") == nil)then
				quant = quant.."un"
			end
			
			file = io.open(fileName, "a")
			file:write(lastI.." - "..ingre.."  Preco: "..quant.." ->".." R$"..preco.."\n")
			file:close()
			pt1 = lastI.." - "..ingre.."  Preco: "
			pt2 = ": "..quant.." ->".." R$"..preco
			if(string.find(pt1, ":") > lastP)then
				lastP = string.find(pt1, ":")
			end
			if(string.find(pt2, ">") > lastS)then
				lastS = string.find(pt2, ">")
			end
			
			fl.fileAlign(fileName, lastP, lastS)
			
			os.execute("cls")
			print("INGREDIENTE ADICIONADO COM SUCESSO!")
			io.read'*l'
			
		elseif(optF == 2) then
			repeat
				os.execute("cls")
				fl.readFile(fileName)
				
				io.write("\nIndice do Ingrediente: ")
				ii = io.read()
				if(tonumber(ii) == nil)then
					ii = 999
				else
					ii = tonumber(ii)
				end 
			
			until(ii >= 0 and ii <= lastI)
			
			for i, v in pairs(l) do
				if(string.find(v, tostring(ii)) == 1)then
					io.write("\nIngrediente........: ")
					ingre = tostring(io.read())
					io.write("Preco..............: R$")
					preco = tostring(io.read())
					preco = string.gsub(preco, ",", ".")
					preco = tonumber(preco)
					io.write("Quantidade comprada: ")
					quant = tostring(io.read()) 
					if(string.find(quant, "%a") == nil)then
						quant = quant.."un"
					end
					
					l[i] = (i-1).." - "..ingre.."  Preco: "..quant.." ->".." R$"..preco
					break
				end
			end
			
			file = io.open(fileName, "w+")
			for i, v in pairs(l) do
				file:write(v.."\n")
			end
			file:close()
			
			fl.fileAlign(fileName, lastP, lastS)
			
			os.execute("cls")
			print("INGREDIENTE EDITADO COM SUCESSO!")
			io.read'*l'
		end
	until(optF == 0)
end

function fl.editEmbal(fileName, cbcLenght)
	repeat
		repeat
			os.execute("cls")
			print("\tEMBALAGENS")
			print("-----------------------------")
			l = fl.readFile(fileName)
			
			print("\n\tMENU\n")
			print("1 - Adicionar Embalagem")
			print("2 - Editar Embalagem")
			print("0 - Retornar")
			io.write("Opcao: ")
			optF = io.read()
			
			if(tonumber(optF) == nil) then
				optF = 999
			else
				optF = tonumber(optF)
			end
			
		until(optF >= 0 and optF <= 3)
		
		lastI = 0 	--ULTIMO ÍNDICE
		lastP = 0	--POSIÇÃO DOS DOIS PONTOS (:)
		lastS = 0	--POSIÇÃO DA SETA EM RELAÇÃO AO lastP(>)
		for i, v in pairs(l) do
			lastI = i
			if(i > 1)then
				p = string.find(v, ":")
				local quant = string.sub(v, p)
				s = string.find(quant, ">")
				
				if(p > lastP)then
					lastP = p
				end
				if(s > lastS)then
					lastS = s
				end
			end
		end
		if(optF == 1) then
			cdc.cbc(cbcLenght)
			io.write("Embalagem..........: ")
			emb = tostring(io.read())
			io.write("Preco..............: R$")
			preco = tostring(io.read())
			preco = string.gsub(preco, ",", ".")
			preco = tonumber(preco)
			io.write("Quantidade comprada: ")
			quant = tostring(io.read()) 
			if(string.find(quant, "%a") == nil)then
				quant = quant.."un"
			end
			
			file = io.open(fileName, "a")
			file:write(lastI.." - "..emb.."  Preco: "..quant.." ->".." R$"..preco.."\n")
			file:close()
			pt1 = lastI.." - "..emb.."  Preco: "
			pt2 = ": "..quant.." ->".." R$"..preco
			if(string.find(pt1, ":") > lastP)then
				lastP = string.find(pt1, ":")
			end
			if(string.find(pt2, ">") > lastS)then
				lastS = string.find(pt2, ">")
			end
			
			fl.fileAlign(fileName, lastP, lastS)
			
			os.execute("cls")
			print("EMBALAGEM ADICIONADA COM SUCESSO!")
			io.read'*l'
			
		elseif(optF == 2) then
			repeat
				os.execute("cls")
				fl.readFile(fileName)
				
				io.write("\nIndice da Embalagem: ")
				ii = io.read()
				if(tonumber(ii) == nil)then
					ii = 999
				else
					ii = tonumber(ii)
				end	
			until(ii >= 0 and ii <= lastI)
			
			for i, v in pairs(l) do
				if(string.find(v, tostring(ii)) == 1)then
					io.write("\nIngrediente........: ")
					emb = tostring(io.read())
					io.write("Preco..............: R$")
					preco = tostring(io.read())
					preco = string.gsub(preco, ",", ".")
					preco = tonumber(preco)
					io.write("Quantidade comprada: ")
					quant = tostring(io.read()) 
					if(string.find(quant, "%a") == nil)then
						quant = quant.."un"
					end
					
					l[i] = (i-1).." - "..emb.."  Preco: "..quant.." ->".." R$"..preco
					break
				end
			end
			
			file = io.open(fileName, "w+")
			for i, v in pairs(l) do
				file:write(v.."\n")
			end
			file:close()
			
			fl.fileAlign(fileName, lastP, lastS)
			
			os.execute("cls")
			print("INGREDIENTE EDITADO COM SUCESSO!")
			io.read'*l'
		end
	until(optF == 0)
end

function fl.findOnFile(fileName, prod)
	prod = "- "..prod.."  "
	prod = string.upper(prod)
	file = io.open(fileName, "r")
	
	for line in file:lines() do
		
		if(string.find(string.upper(line), prod) ~= nil) then
			p0, p1 = string.find(line, ": ")
			p2 = string.find(line, " ->")
			
			p1 = p1+1
			p2 = p2-3
			
			quant = string.sub(line, p1, p2)
			
			p1 = string.find(line, ">")
		
			p1 = p1+4
		
			preco = string.sub(line, p1)
			return quant, preco
		end
	end
	return false
end

function fl.fileAlign(fileName, pPosition, sPosition)
	l = fl.readFile(fileName)
	
	for i in pairs(l) do
		if(i > 1)then
			local prod = string.sub(l[i], 0, (string.find(l[i], ":") - 6)) 
			local quant = string.sub(l[i], (string.find(l[i], ":") - 5), (string.find(l[i], ">") - 2))
			local preco = string.sub(l[i], (string.find(l[i], ">") - 1))
			
			while(string.find(l[i], ":") < pPosition)do
				prod = prod.." "
				l[i] = prod..quant..preco
			end
			
			while(string.find(string.sub(l[i], pPosition), ">") < sPosition)do
				quant = quant.." "
				l[i] = prod..quant..preco
			end
		end
	end
	
	file = io.open(fileName, "w+")
	
	for i, v in pairs(l) do
		file:write(v.."\n")
	end
	
	file:close()
end	

function fl.saveAlign(fileName, pPosition)
	l = fl.readFile(fileName)
	
	for i in pairs(l) do
		if(i > 1)then
			receita = string.sub(l[i], 0, (string.find(l[i], ":")-1))
			address = string.sub(l[i], string.find(l[i], ":"), -1)
			
			while(string.find(l[i], ":") < pPosition)do
				receita = receita.."."
				l[i] = receita..address
			end
		end
	end
	
	file = io.open(fileName, "w+")
	
	for i, v in pairs(l) do
		file:write(v.."\n")
	end
	
	file:close()
end

function fl.saveFiles(receita, savedFile, fileName)
	l = fl.readFile(fileName)
	
	lastI = 0 	--ULTIMO ÍNDICE
	lastP = 0	--POSIÇÃO DOS DOIS PONTOS (:)
	
	for i in pairs(l) do
		lastI = i
	end
	
	save = io.open(fileName, "a+")
	save:write(lastI.." - "..receita..":  "..savedFile.."\n")
	save:close()
	
	for i, v in pairs(l) do
		if(i > 1)then
			p = string.find(v, ":")
			if(p > lastP)then
				lastP = p
			end
		end
	end
	
	fl.saveAlign(fileName, lastP)
end

function fl.deleteLine(fileName, str)
	str = string.gsub(str, "\\\\", "\\")
	
	l = fl.readFile(fileName)
	
	for i, v in pairs(l) do
		if(string.find(v, str) ~= nil) then
			l[i] = nil
			if(l[i+1] ~= nil)then
				for j, value in pairs(l) do
					if((j > i) and (value ~= nil)) then
						txt = string.sub(value, (string.find(value, "-")-1), -1)
						l[j] = (j-2)..txt
					end
				end
			end
			break
		end
	end
	
	file = io.open(fileName, "w+")
	for i, v in pairs(l) do
		if(v ~= nil) then
			file:write(v.."\n")
		end
	end
	file:close()
end

return fl
