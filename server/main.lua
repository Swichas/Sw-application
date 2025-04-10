	QBCore = exports['qb-core']:GetCoreObject()

function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end

function TableToString(table)
    local string = ""
    for k,v in pairs(table) do
        local answer = Sanitize(tostring(v))
        if not answer or answer == "" then answer = "N/A" end
        if Config.ChangeBoolsToStrings and answer == "true" then answer = "Yes" end
        if Config.ChangeBoolsToStrings and answer == "false" then answer = "No" end
        string = string .. (Config.MakeAnswersBold and ("**%s**: **%s** \n"):format(k, answer) or ("%s: %s"):format(k, answer))
    end
    return string
end

function ConvertAnswers(Questions, Answers)
    for i=1, #(Answers) do
        if type(Answers[i]) == "table" then
            Questions[i].Answer = TableToString(Answers[i])
        else
            local answer = Sanitize(tostring(Answers[i]))
            if not answer or answer == "" then answer = "N/A" end
            if Config.ChangeBoolsToStrings and answer == "true" then answer = "Yes" end
            if Config.ChangeBoolsToStrings and answer == "false" then answer = "No" end
            Questions[i].Answer = Config.MakeAnswersBold and ("**%s**"):format(answer) or answer
        end
    end
    return Questions
end

RegisterNetEvent("jobforms:apply", function(AreaIndex,vardas,pavarde,telefonas,arpasiruoses,patirtis,metai)
    local source = source
   if Player(source).state.ApplicationCooldown then 
        return 
    end
    local Ped = GetPlayerPed(source)
    local ped_pos = GetEntityCoords(Ped)
    local dist = #(Config.Areas[AreaIndex].Coords - ped_pos)
    if dist > 10.0 then
        return
    end
    local area = Config.Areas[AreaIndex]
    local darbas = area and area.job
    
    MySQL.insert('INSERT INTO `aplikacijos` (vardas, pavarde, metai, patirtis, arpasiruoses,telefonas,job) VALUES (?, ?, ?, ?, ?,?,?)', { 
        vardas,pavarde,metai,patirtis,arpasiruoses,telefonas,darbas
    }, function(id)
        print(id)
    end)
    Player(source).state:set("ApplicationCooldown", true, true)
    SetTimeout(Config.ApplicationSettings.Cooldown.time, function()
        Player(source).state:set("ApplicationCooldown", false, true)
    end)
end)
QBCore.Functions.CreateCallback('aplikacijosgavimas', function(source, cb,jobas)    
    MySQL.query('SELECT `vardas`, `pavarde`, `metai`, `patirtis`, `arpasiruoses`, `telefonas`,`job` FROM `aplikacijos` WHERE `job` = ?', {
        jobas
    }, function(response)
        if response and #response > 0 then
            local applications = {}

            for i = 1, #response do
                local row = response[i]
                table.insert(applications, {
                    vardas = row.vardas,
                    pavarde = row.pavarde,
                    metai = row.metai,
                    patirtis = row.patirtis,
                    arpasiruoses = row.arpasiruoses,
                    telefonas = row.telefonas,
                    darbas = row.job
                })
            end

            cb(applications)
        else
            cb({})
        end
    end)
end)

RegisterNetEvent('istrintiAplikacija')
AddEventHandler('istrintiAplikacija', function(vardas, pavarde)
    local src = source
    MySQL.query('DELETE FROM `aplikacijos` WHERE `vardas` = ? AND `pavarde` = ?', { vardas, pavarde }, function(affectedRows)
        if affectedRows > 0 then
            TriggerClientEvent('QBCore:Notify', src, Lang:t('bossmenu.deltionyes'), 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('bossmenu.deltionno'), 'error')
        end
    end)
end)

