cdc = require("classes\\cdcFunctions")
fl = require("classes\\fileFunctions")
local version = "Version: 0.8.0"

--[[
	ingred[x][1] = Ingrediente(string)
	ingred[x][2] = Qnt. Usada(string) 
	ingred[x][3] = Preço(number)
	ingred[x][4] = Qnt. Comprada(string)
	
	embal[x][1] = Embalagem(string)
	embal[x][2] = Qnt. Usada(string) 
	embal[x][3] = Preço(number)
	embal[x][4] = Qnt. Comprada(string)
--]]

ingred = {}
embal = {}
seta = " -> "

repeat
	maxI = 0 	--Ingrediente
	maxQ = 0	--Qnt. Usada ingrediente
	maxQc = 0	--Qnt. Comprada ingrediente
	maxE = 0	--Embalagem
	maxQe = 0	--Qnt. Usada embalagem
	maxQce = 0	--Qnt. Comprada embalagem
	optR = 999 
	if(cbcLen == nil) then
		cbcLen = 31 -- Tamanho da linha de divisória do cabeçalho
	end	
	--TELA INICIAL
	cdc.cbc(cbcLen)
    print("\tMENU\n")
    print("1 - Add. Receita")
    print("2 - Ingredientes")
    print("3 - Embalagens")
    print("4 - Receitas Cadastradas")
    if(receita ~= nil) then
       print("5 - Relatorio da Receita")
    end
    print("0 - Sair")
    io.write("Opcao: ")
    opt = string.upper(io.read())
    
    --TELA VERSION
    if(opt == "VERSION")then
		cdc.cbc(cbcLen)
		print(version)
		io.read'*l'
    elseif(string.find(opt, "%a") == nil) then
		opt = tonumber(opt)
    end
    
    --AREA P/ ADD. RECEITAS
	if(opt == 1) then
		cbcLen = 31
        i = 1
		e = 1

        cdc.cbc(cbcLen)    
        io.write"Receita: "
		receita = string.upper(io.read()) 
		
        
        --DELETANDO INGREDIENTES DA ANTIGA RECEITA
		j = 1
		while(ingred[j] ~= nil) do
			ingred[j] = nil
			j = j + 1
		end
		
		--DELETANDO EMBALAGENS DA ANTIGA RECEITA
		j = 1
        while(embal[j] ~= nil) do
			embal[j] = nil
			j = j + 1
		end
		j = 1
        while(optR ~= 0) do
            cdc.cbc(cbcLen)
            print("\t"..receita.."\n")
            
            --ESCREVENDO INGREDIENTES E EMBALAGENS JÁ ADICIONADOS DA RECEITA
			j = 1
			line = nil
			
            if(ingred[j] ~= nil) then
				total = 0
				print("Ingredientes: \n")
				while(ingred[j] ~= nil) do
					qntU = string.gsub(ingred[j][2], "%a", "")
					qntU = string.gsub(qntU, "%p", "")
					qntC = string.gsub(ingred[j][4], "%a", "")
					qntC = string.gsub(qntC, "%p", "")
					custo = (tonumber(qntU)*ingred[j][3])/tonumber(qntC)
					total = total + custo
					line = j.." - "..string.format("%s: %s -> ",ingred[j][1], ingred[j][2])..cdc.pm(custo).."\tPreco: "..ingred[j][4]..seta..cdc.pm(ingred[j][3])
					print(line)
					if(string.len(line) > cbcLen)then
						cbcLen = string.len( line )
					end
					j = j + 1
				end
				print()
            end
			j = 1
			line = nil
            if(embal[j] ~= nil) then
				total = 0
				print("\nEmbalagens: \n")
				while(embal[j] ~= nil) do
					qntU = string.gsub(embal[j][2], "%a", "")
					qntU = string.gsub(qntU, "%p", "")
					qntC = string.gsub(embal[j][4], "%a", "")
					qntC = string.gsub(qntC, "%p", "")
					custo = (tonumber(qntU)*embal[j][3])/tonumber(qntC)
					total = total + custo
					line = j.." - "..string.format("%s: %s -> ",embal[j][1], embal[j][2])..cdc.pm(custo).."\tPreco: "..embal[j][4]..seta..cdc.pm(embal[j][3])
					print(line)
					if(string.len(line) > cbcLen)then
						cbcLen = string.len( line )
					end
					j = j + 1
				end
				print()
            end
            
            --MENU P/ ADD. INGREDIENTES OU EMBALAGENS, EDITAR ETC
            print("MENU: \n")
            print("1 - Add. Ingrediente")
            print("2 - Add. Embalagem")
            print("3 - Editar Item")
            print("4 - Tabela de Conversoes")
            print("0 - Finalizar")
            io.write("Opcao: ")
            optR = tonumber(io.read())
            
            --AREA P/ ADD. INGREDIENTES
            if(optR == 1) then
                cdc.cbc(cbcLen)
                print("\t"..receita.."\n") 
				ingred[i] = {}
                io.write("Ingrediente........: ")
                ingred[i][1] = tostring(io.read())		
                io.write("Quantidade usada...: ")
                ingred[i][2] = tostring(io.read())
               
                ingred[i][4], ingred[i][3] = fl.findOnFile("ingredientes.txt", ingred[i][1])
                
                if(ingred[i][4] == false)then
					io.write("Preco..............: R$")
					ingred[i][3] = tostring(io.read())
					ingred[i][3] = string.gsub(ingred[i][3], ",", ".")
					ingred[i][3] = tonumber(ingred[i][3])
					io.write("Quantidade comprada: ")
					ingred[i][4] = tostring(io.read())
				else
					print("Preco..............: R$".. ingred[i][3])
					print("Quantidade comprada: "..ingred[i][4])
					io.read'*l'
                end
                if (string.len(ingred[i][1]) > maxI) then
					maxI = string.len(ingred[i][1])
                end
                if (string.len(ingred[i][2]) > maxQ) then
					maxQ = string.len(ingred[i][2])
                end
                if (string.len(ingred[i][4]) > maxQc) then
					maxQc = string.len(ingred[i][4])
				end  
                i = i + 1   
            
            --AREA P/ ADD. EMBALAGENS
            elseif(optR == 2)then
				cdc.cbc(cbcLen)
                print("\t"..receita.."\n") 
				embal[e] = {}
                io.write("Embalagem..........: ")
                embal[e][1] = tostring(io.read())
                io.write("Quantidade usada...: ")
                embal[e][2] = tostring(io.read())
                
                embal[e][4], embal[e][3] = fl.findOnFile("embalagens.txt", embal[e][1])
                
                if(embal[e][4] == false)then
					io.write("Preco..............: R$")
					embal[e][3] = tostring(io.read())
					embal[e][3] = string.gsub(embal[e][3], ",", ".")
					embal[e][3] = tonumber(embal[e][3])
					io.write("Quantidade comprada: ")
					embal[e][4] = tostring(io.read())
				else
					print("Preco..............: R$".. embal[e][3])
					print("Quantidade comprada: "..embal[e][4])
					io.read'*l'
                end
                
                if (string.len(embal[e][1]) > maxE) then
					maxE = string.len(embal[e][1])
                end
                if (string.len(embal[e][2]) > maxQe) then
					maxQe = string.len(embal[e][2])
                end
                if (string.len(embal[e][4]) > maxQce) then
					maxQce = string.len(embal[e][4])
                end
                e = e + 1 
            --AREA DE EDIÇÃO DE ITENS
            elseif(optR == 3) then
				optE = 999
				while(optE ~= 0) do
					cdc.cbc(cbcLen)
					print("Editar:\n")
					print("1 - Ingrediente")
					print("2 - Embalagem")
					print("0 - Retornar")
					io.write("Opcao: ")
					optE = tonumber(io.read())
					
					--EDIÇÃO DE INGREDIENTES
					if(optE == 1) then
						cdc.cbc(cbcLen)
						j = 1
						if(ingred[j] ~= nil) then
							total = 0
							print("Ingredientes: \n")
							while(ingred[j] ~= nil) do
								qntU = string.gsub(ingred[j][2], "%a", "")
								qntU = string.gsub(qntU, "%p", "")
								qntC = string.gsub(ingred[j][4], "%a", "")
								qntC = string.gsub(qntC, "%p", "")
								custo = (tonumber(qntU)*ingred[j][3])/tonumber(qntC)
								total = total + custo
								print(j.." - "..string.format("%s: %s -> ",ingred[j][1], ingred[j][2])..cdc.pm(custo).." \t Preco: "..ingred[j][4]..seta..cdc.pm(ingred[j][3]))
								j = j + 1
							end
							print()
							
							io.write("Indice do ingrediente a editar: ")
							x = tonumber(io.read())
							
							if(ingred[x] ~= nil) then
								cdc.cbc(cbcLen)
								qntU = string.gsub(ingred[x][2], "%a", "")
								qntU = string.gsub(qntU, "%p", "")
								qntC = string.gsub(ingred[x][4], "%a", "")
								qntC = string.gsub(qntC, "%p", "")
								custo = (tonumber(qntU)*ingred[x][3])/tonumber(qntC)
								total = total + custo
								print(x.." - "..string.format("%s: %s -> ",ingred[x][1], ingred[x][2])..cdc.pm(custo).." \t Preco: "..ingred[x][4]..seta..cdc.pm(ingred[x][3]))
								
								print()
							
								io.write("Ingrediente........: ")
								ingred[x][1] = tostring(io.read())
								if (string.len(ingred[x][1]) > maxI) then
									maxI = string.len(ingred[x][1])
								end
								io.write("Quantidade usada...: ")
								ingred[x][2] = tostring(io.read())
								if (string.len(ingred[x][2]) > maxQ) then
									maxQ = string.len(ingred[x][2])
								end
								io.write("Preco..............: R$")
								ingred[x][3] = tostring(io.read())
								ingred[x][3] = string.gsub(ingred[x][3], ",", ".")
								ingred[x][3] = tonumber(ingred[x][3])
								io.write("Quantidade comprada: ")
								ingred[x][4] = tostring(io.read())
								if (string.len(ingred[x][4]) > maxQc) then
									maxQc = string.len(ingred[x][4])
								end 
								
								cdc.cbc(cbcLen)
								print("INGREDIENTE EDITADO COM SUCESSO!")
								io.read'*l'	
							else
								print("ERRO: INDICE INVALIDO!")
								io.read'*l'
							end
						else
							print("ERRO: NAO HA INGREDIENTES ADICIONADOS AINDA!")
							io.read'*l'
						end
					
					--EDIÇÃO DE EMBALAGENS			
					elseif(optE == 2) then
						cdc.cbc(cbcLen)
						j = 1
						
						if(embal[j] ~= nil) then
							j = 1
							total = 0
							print("\nEmbalagens: \n")
							while(embal[j] ~= nil) do
								qntU = string.gsub(embal[j][2], "%a", "")
								qntU = string.gsub(qntU, "%p", "")
								qntC = string.gsub(embal[j][4], "%a", "")
								qntC = string.gsub(qntC, "%p", "")
								custo = (tonumber(qntU)*embal[j][3])/tonumber(qntC)
								total = total + custo
								print(j.." - "..string.format("%s: %s -> ",embal[j][1], embal[j][2])..cdc.pm(custo).." \t Preco: "..embal[j][4]..seta..cdc.pm(embal[j][3]))
								j = j + 1
							end
							print()
							
							io.write("Indice do ingrediente a editar: ")
							x = tonumber(io.read())
							
							if(embal[x] ~= nil) then
								cdc.cbc(cbcLen)
								qntU = string.gsub(embal[x][2], "%a", "")
								qntU = string.gsub(qntU, "%p", "")
								qntC = string.gsub(embal[x][4], "%a", "")
								qntC = string.gsub(qntC, "%p", "")
								custo = (tonumber(qntU)*embal[x][3])/tonumber(qntC)
								total = total + custo
								print(x.." - "..string.format("%s: %s -> ",embal[x][1], embal[x][2])..cdc.pm(custo).." \t Preco: "..embal[x][4]..seta..cdc.pm(embal[x][3]))
								
								print()
								
								io.write("Embalagem..........: ")
								embal[x][1] = tostring(io.read())
								if (string.len(embal[x][1]) > maxE) then
									maxE = string.len(embal[x][1])
								end
								io.write("Quantidade usada...: ")
								embal[x][2] = tostring(io.read())
								if (string.len(embal[x][2]) > maxQe) then
									maxQe = string.len(embal[x][2])
								end
								io.write("Preco..............: R$")
								embal[x][3] = tostring(io.read())
								embal[x][3] = string.gsub(embal[x][3], ",", ".")
								embal[x][3] = tonumber(embal[x][3])
								io.write("Quantidade comprada: ")
								embal[x][4] = tostring(io.read()) 
								if (string.len(embal[x][4]) > maxQce) then
									maxQce = string.len(embal[x][4])
								end
								
								cdc.cbc(cbcLen)
								print("EMBALAGEM EDITADA COM SUCESSO!")
								io.read'*l'
							else
								print("ERRO: INDICE INVALIDO")
								io.read'*l'
							end
							print()
						else
							print("ERRO: NAO HA EMBALAGENS ADICIONADAS AINDA!")
							io.read'*l'
						end	
					end
				end
			--APRESENTÇÃO DA TABELA DE CONVERSÕES
			elseif(optR == 4) then
				cdc.cbc(cbcLen)
				fl.readFile("tabConv.txt")
				io.read'*l'
            end 
            
            j = 1	
			--FORMATAÇÃO DOS INGREDIENTES ADICIONADOS
			while(ingred[j] ~= nil) do
				if(string.find(ingred[j][2], "%a") == nil)then
					ingred[j][2] = ingred[j][2].."un"
				end
				if(string.find(ingred[j][4], "%a") == nil)then
					ingred[j][4] = ingred[j][4].."un"
				end
				if(string.len(ingred[j][1]) < maxI) then
					ingred[j][1] = cdc.formatStrLenDot(ingred[j][1], maxI)
				end
				if(string.len(ingred[j][2]) < maxQ) then
					ingred[j][2] = cdc.formatStrLen(ingred[j][2], maxQ)
				end
				
				if(string.len(ingred[j][4]) < maxQc) then
					ingred[j][4] = cdc.formatStrLen(ingred[j][4], maxQc)
				end
				j = j + 1 
			end 
			j = 1	
			--FORMATAÇÃO DAS EMBALAGENS ADICIONADAS
			while(embal[j] ~= nil) do
				if(string.find(embal[j][2], "%a") == nil)then
					embal[j][2] = embal[j][2].."un"
				end
				if(string.find(embal[j][4], "%a") == nil)then
					embal[j][4] = embal[j][4].."un"
				end
				if(string.len(embal[j][1]) < maxE) then
					embal[j][1] = cdc.formatStrLenDot(embal[j][1], maxE)
				end
				if(string.len(embal[j][2]) < maxQe) then
					embal[j][2] = cdc.formatStrLen(embal[j][2], maxQe)
				end
				
				if(string.len(embal[j][1]) < maxE) then
					embal[j][4] = cdc.formatStrLen(embal[j][4], maxQce)
				end
				j = j + 1 
			end                   
        end
 
    --ÁREA DE VISUALIZAÇÃO E EDIÇÃO DE INGREDIENTES
    elseif(opt == 2) then
		fl.editIngred("ingredientes.txt", cbcLen)
		
	--ÁREA DE VISUALIZAÇÃO E EDIÇÃO DE EMBALAGENS
	elseif(opt == 3) then
		fl.editEmbal("embalagens.txt", cbcLen)
	
	--ÁREA DE VISUALIZAÇÃO DAS RECEITAS JÁ CADASTRADAS
	elseif(opt == 4) then
		repeat
			repeat
				os.execute("cls")
				print("\tRECEITAS")
				print("-------------------------------")
				l = fl.readFile("createdFiles.txt")
				
				print("\nRetornar: 0\n")
				io.write("Detalhar: ")
				index = io.read()
				
				if(tonumber(index) == nil)then
					index = -1
				else
					index = tonumber(index)
				end
			until(index >= 0)
			if(index > 0) then
				for i, v in pairs(l) do
					if((index + 1) == i) then
						v = string.gsub(v, "\\", "\\\\")
						address = string.sub(v, (string.find(v, ":")+3), -1)
						break
					end
				end
				if(address ~= nil) then
					file = io.open(address)
					if(file ~= nil) then
						file:close()
						os.execute("cls")
						fl.readFile(address)
					else
						fl.deleteLine("createdFiles.txt", address)
						cdc.cbc(cbcLen)
						print("\tDIRETORIO SALVO VAZIO")
						print("*O relatorio pode ter sido movido ou excluido.")
						cdc.sleep(1.5)
						print("*O relatorio foi excluido da opcao \"Relatorios Cadastrados\" a fim de evitar erros.")
					end
				else
					cdc.cbc(cbcLen)
					print("INDICE INVALIDO!")
				end
				io.read'*l'
			
			end
		until(index == 0)
		
	--ÁREA DA APRESENTAÇÃO DO RELATÓRIO FINAL DA RECEITA
	elseif(opt == 5 and receita ~= nil) then
		repeat
			text = nil
			cdc.cbc(cbcLen)
			
			text = cdc.cbc(cbcLen)
			
			text = text..os.date("%d/%m/%Y")
			
			print("\t"..receita.."\n")
			
			text = text.."\n\n\t"..receita.."\n\n"
			
			--APRESENTAÇÃO DOS INGREDIENTES
			print("Ingredientes: \n")
			
			text = text.."Ingredientes: \n\n"
			
			i = 1
			total = 0
			while(ingred[i] ~= nil) do
				qntU = string.gsub(ingred[i][2], "%a", "")
				qntU = string.gsub(qntU, "%p", "")
				qntC = string.gsub(ingred[i][4], "%a", "")
				qntC = string.gsub(qntC, "%p", "")
				custo = (tonumber(qntU)*ingred[i][3])/tonumber(qntC)
				total = total + custo
				print(string.format("%s: %s -> ",ingred[i][1], ingred[i][2])..cdc.pm(custo).." \t Preco: "..ingred[i][4]..seta..cdc.pm(ingred[i][3]))
				
				text = text..string.format("%s: %s -> ",ingred[i][1], ingred[i][2])..cdc.pm(custo).." \t Preco: "..ingred[i][4]..seta..cdc.pm(ingred[i][3]).."\n"
				
				i = i + 1
			end   
			
			--APRESENTAÇÃO DAS EMBALAGENS  
			i = 1
			totalEmb = 0
			
			if(embal[i] ~= nil) then
				print("\nEmbalagens: \n")
			
				text = text.."\nEmbalagens: \n\n"
			end
			while(embal[i] ~= nil) do
				qntU = string.gsub(embal[i][2], "%a", "")
				qntU = string.gsub(qntU, "%p", "")
				qntC = string.gsub(embal[i][4], "%a", "")
				qntC = string.gsub(qntC, "%p", "")
				custo = (tonumber(qntU)*embal[i][3])/tonumber(qntC)
				totalEmb = totalEmb + custo
				print(string.format("%s: %s -> ",embal[i][1], embal[i][2])..cdc.pm(custo).." \t Preco: "..embal[i][4]..seta..cdc.pm(embal[i][3]))
				
				text = text..string.format("%s: %s -> ",embal[i][1], embal[i][2])..cdc.pm(custo).." \t Preco: "..embal[i][4]..seta..cdc.pm(embal[i][3]).."\n"
				
				i = i + 1
			end
			
			--CÁLCULOS DOS LUCROS E AFINS
			print("\nTotal: "..cdc.pm(total+totalEmb))
			
			text = text.."\nTotal: "..cdc.pm(total+totalEmb)
			
			io.write("\nRendimento: ")
			rendBruto = tostring(io.read())
			rend = string.gsub(rendBruto, "%a", "")
			rend = tonumber(rend)
			
			text = text.."\n\nRendimento: "..rendBruto
			
			print("\nLucros totais: \n")
			
			text = text.."\n\nLucros totais: \n\n"
			
			print("150%: "..cdc.pm((total+total*1.5)+totalEmb))
			
			text = text.."150%: "..cdc.pm((total+total*1.5)+totalEmb)
			
			print("100%: "..cdc.pm((total*2)+totalEmb))
			
			text = text.."\n100%: "..cdc.pm((total*2)+totalEmb)     
			
			if((string.find(rendBruto, "g") == nil) and (rend > 1)) then --SE rendimento NÃO estiver em gramas E houver MAIS de UMA un. FAÇA      
				print("\nLucros unitarios: \n")
			
				text = text.."\n\nLucros unitarios: \n\n"
				
				print("150%: "..cdc.pm(((total+total*1.5)+totalEmb)/rend))
			
				text = text.."150%: "..cdc.pm(((total+total*1.5)+totalEmb)/rend)
			
				print("100%: "..cdc.pm(((total*2)+totalEmb)/rend))
			
				text = text.."\n100%: "..cdc.pm(((total*2)+totalEmb)/rend)   
				
				io.write("\nValor unitario: R$")
				valorUn = tostring(io.read())
				valorUn = string.gsub(valorUn, ",", ".")
				valorUn = tonumber(valorUn)
				valor = valorUn*rend
				print("Valor total...: "..cdc.pm(valor))
				
				text = text.."\n\nValor unitario: "..cdc.pm(valorUn)
				text = text.."\nValor total...: "..cdc.pm(valor)
			else --SE estiver em gramas OU rendimento = 1 FAÇA
				io.write("\nValor de venda: R$")
				valor = tostring(io.read())
				valor = string.gsub(valor, ",", ".")
				valor = tonumber(valor)
				text = text.."\n\nValor de venda: "..cdc.pm(valor)
			end
			
			lucro = (((valor-totalEmb)-total)*100)/total
			lucroR = valor-(totalEmb+total)
			
			print("\nLucro: "..cdc.pm(lucroR).." -> "..string.format("%.2f", lucro).."%")
			text = text.."\n\nLucro: "..cdc.pm(lucroR).." -> "..string.format("%.2f", lucro).."%"
			
			line = "-------------------------------\n"

			while(string.len(line) < cbcLen) do
				line = "-"..line
			end
			
			print(line)
			text = text.."\n"..line.."\n"..version 
			
			--ÁREA DE GERAÇÃO DO ARQUIVO DE TEXTO
			repeat
				print("Deseja salvar o relatorio?\n")
				print("1 - SIM")
				print("2 - NAO")
				io.write("Opcao: ")
				resp = io.read()
				if(tonumber(resp) == nil) then
					if(string.upper(resp) == "SIM") then
						resp = 1
					elseif(string.upper(resp) == "NAO") then
						resp = 2
					else
						resp = 999
						cdc.cbc(cbcLen)
						print("ERRO: OPCAO INVALIDA!")
						io.read('*l')
					end
				end
				resp = tonumber(resp)
			until(resp == 1 or resp == 2)
		until(resp == 1)
		if(resp == 1) then
			cdc.cbc(cbcLen)
			print("Extensoes recomendadas: \n")
			print("1 - doc")
			print("2 - txt")
			io.write("Nome do arquivo (c/ extensao): ")
			arqName = tostring(io.read())
			
			arq = io.open("Receitas\\"..arqName, "w")
			
			arq:write(text)
			arq:close()
			
			fl.saveFiles(receita, "Receitas\\"..arqName, "createdFiles.txt")
			
			cdc.cbc(cbcLen)		
			print("Arquivo criado com sucesso na pasta \"Receitas\"!")
		else
			print("Operacao finalizada!")
		end
		io.read('*l')
    
	--VALIDAÇÃO DA ENTRADA DO MENU INICIAL
    elseif(opt ~= "VERSION" and opt~= 1 and opt ~= 2 and opt ~= 0)then
		print("ERRO: OPCAO INVALIDA!")
		cdc.sleep(3)
    end
until(opt==0)

io.write"Tecle <ENTER> para encerrar..."
io.read'*l'
