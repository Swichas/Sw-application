
QBCore = exports['qb-core']:GetCoreObject()

function DoApplication(AreaIndex)
    local area = Config.Areas[AreaIndex]
    local Questions = area.Questions
    local input = lib.inputDialog(area.label,{ 
    {
        type = "input",
        label = Lang:t('char.name'),
        placeholder = Lang:t('char.name_placeholder'),
        required = true
    },
    {   
        type = "input",
        label = Lang:t('char.lastname'),
        placeholder = Lang:t('char.lastname_placeholder'),
        required = false
    },
    {   
        type = "input",
        label = Lang:t('char.phone'),
        placeholder = Lang:t('char.phone_placeholder'),
        required = true
    },
    {   
        type = "checkbox",
        label = Lang:t('char.areready'),
        required = false
    },
    {   
        type = "slider",
        label = Lang:t('char.year'),
        default = 5,
        min = 18,
        max = 70,
        step = 1,
        required = true
    },
    {   
        type = "textarea",
        label = Lang:t('char.letter'),
        max = 200,
        required = true
    }})
    if not input then return end

    local vardas = input[1]
    local pavarde = input[2] 
    local telefonas = input[3]
    local arpasiruoses = input[4]
    local patirtis = input[6]
    local metai = input[5]


    lib.notify({
        title = Lang:t('notify.anket'),
        description = Lang:t('notify.succefulapli'),
        type = 'success'
    })

    TriggerServerEvent("jobforms:apply", AreaIndex,vardas,pavarde,telefonas,arpasiruoses,patirtis,metai)

end

CreateThread(function()
    for i=1, #(Config.Areas) do
        if Config.UseTarget then 
            local area = Config.Areas[i]
            exports.ox_target:addSphereZone({
                coords = area.Coords,
                radius = area.TargetSettings.radius,
                debug = area.TargetSettings.debug,
                options = {
                    {
                        name = area.label,
                        icon = area.TargetSettings.icon,
                        label = area.TargetSettings.label,
                        onSelect = function()
                            DoApplication(i)
                        end,
                        canInteract = function()
                            if not Config.ApplicationSettings.Cooldown.enabled then 
                                return true
                            end
                            if not LocalPlayer.state.ApplicationCooldown then 
                                return true
                            end
                            return false
                        end
                    }
                }
            })
        else 
            local point = lib.points.new(Config.Areas[i].Coords, Config.Areas[i].MarkerSettings.Distance, {
                area = Config.Areas[i], DrawingTextUI = false, areaIndex = i
            })
            function point:nearby()
                if self.area.MarkerSettings.DrawMarker then
                    local m_set = self.area.MarkerSettings
                    DrawMarker(m_set.type, self.coords.x, self.coords.y, self.coords.z, 0, 0, 0, m_set.rotation.x, m_set.rotation.y, m_set.rotation.z, m_set.size.x, m_set.size.y, m_set.size.z, m_set.colour.r, m_set.colour.g, m_set.colour.b, m_set.colour.a, false, true, 2, nil, nil, false)
                end

                if self.currentDistance < 1 then
                    if not self.DrawingTextUI then
                        self.DrawingTextUI = true
                        lib.showTextUI(self.area.MarkerSettings.TextUI)
                    end
                    if IsControlJustPressed(0, 38) then
                        if Config.ApplicationSettings.Cooldown.enabled then 
                            if LocalPlayer.state.ApplicationCooldown then 
                                return lib.notify({
                                    title = Lang:t('notify.anket'),
                                    description = Lang:t('notify.cooldown'),
                                    icon = 'ban',
                                    iconColor = '#C53030'
                                })
                            end
                        end
                        DoApplication(self.areaIndex)
                    end
                else
                    if  self.DrawingTextUI then
                        self.DrawingTextUI = false
                        lib.hideTextUI()
                   end
                end
            end
        end
        if Config.Areas[i].Blip.enabled then
            local blip_set = Config.Areas[i].Blip
            local blip = AddBlipForCoord(Config.Areas[i].Coords)
            SetBlipSprite (blip, blip_set.sprite)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, blip_set.colour)
            SetBlipScale (blip, blip_set.size)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Areas[i].label)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

RegisterNetEvent('np-anketos:Client:anketa', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local jobName = PlayerData.job.name
    local jobGrade = PlayerData.job.grade.level

    if jobGrade == Config.BossRanks[jobName] then

        QBCore.Functions.TriggerCallback('aplikacijosgavimas', function(data)
            if not data or #data == 0 then
                TriggerEvent('QBCore:Notify', Lang:t('bossmenu.noaplication'), 'error', 5)
                return
            end

            pagrindomnenu = {}

            for _, application in ipairs(data) do
                local arpasiruoses = application.arpasiruoses == 1 and Lang:t('bossmenu.yes') or Lang:t('bossmenu.no')
                
                table.insert(pagrindomnenu, {
                    title = application.vardas .. " " .. application.pavarde,
                    description = Lang:t('bossmenu.context'):format(application.vardas, application.pavarde, application.metai, application.telefonas, arpasiruoses, application.patirtis),
                    onSelect = function()
                        lib.registerContext({
                            id = 'deleteConfirm',
                            title = Lang:t('bossmenu.aresure'),
                            description = Lang:t('bossmenu.aresure2'),
                            options = {
                                {
                                    title = Lang:t('bossmenu.areusureyes'),
                                    onSelect = function()
                                        TriggerServerEvent('istrintiAplikacija', application.vardas, application.pavarde)
                                        bosas()
                                    end,
                                },
                                {
                                    title = Lang:t('bossmenu.areusureno'),
                                    onSelect = function()
                                        bosas()
                                    end,
                                },
                            }
                        })
                        lib.showContext('deleteConfirm')
                    end,
                })
            end

            lib.registerContext({
                id = 'Bossmenuaplikacijs',
                title = Lang:t('bossmenu.conexttable'),
                options = pagrindomnenu
            })
            
            lib.showContext('Bossmenuaplikacijs')
        end, jobName)
    else
    end
end)




RegisterCommand("bossmenu", function()

    TriggerEvent('np-anketos:Client:anketa')
end)
