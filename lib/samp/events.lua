-- This file is part of the SAMP.Lua project.
-- Licensed under the MIT License.
-- Copyright (c) 2016, FYP @ BlastHack Team <blast.hk>
-- https://github.com/THE-FYP/SAMP.Lua

local raknet                                  = require 'samp.raknet'
local events                                  = require 'samp.events.core'
local utils                                   = require 'samp.events.utils'
local handler                                 = require 'samp.events.handlers'
                                                require 'samp.events.extra_types'
local RPC                                     = raknet.RPC
local PACKET                                  = raknet.PACKET
local OUTCOMING_RPCS                          = events.INTERFACE.OUTCOMING_RPCS
local OUTCOMING_PACKETS                       = events.INTERFACE.OUTCOMING_PACKETS
local INCOMING_RPCS                           = events.INTERFACE.INCOMING_RPCS
local INCOMING_PACKETS                        = events.INTERFACE.INCOMING_PACKETS

-- Outgoing rpcs
OUTCOMING_RPCS[RPC.ENTERVEHICLE]              = {'onSendEnterVehicle', {vehicleId = 'int16'}, {passenger = 'bool8'}}
OUTCOMING_RPCS[RPC.CLICKPLAYER]               = {'onSendClickPlayer', {playerId = 'int16'}, {source = 'int8'}}
OUTCOMING_RPCS[RPC.CLIENTJOIN]                = {'onSendClientJoin', {version = 'int32'}, {mod = 'int8'}, {nickname = 'string8'}, {challengeResponse = 'int32'}, {joinAuthKey = 'string8'}, {clientVer = 'string8'}, {challengeResponse2 = 'int32'}}
OUTCOMING_RPCS[RPC.SELECTOBJECT]              = {'onSendSelectObject', {type = 'int32'}, {objectId = 'int16'}, {model = 'int32'}, {position = 'vector3d'}}
OUTCOMING_RPCS[RPC.SELECTOBJECT]              = {'onSendEnterEditObject', {type = 'int32'}, {objectId = 'int16'}, {model = 'int32'}, {position = 'vector3d'}}
OUTCOMING_RPCS[RPC.SERVERCOMMAND]             = {'onSendCommand', {command = 'string32'}}
OUTCOMING_RPCS[RPC.SPAWN]                     = {'onSendSpawn'}
OUTCOMING_RPCS[RPC.DEATH]                     = {'onSendDeathNotification', {reason = 'int8'}, {killerId = 'int16'}}
OUTCOMING_RPCS[RPC.DIALOGRESPONSE]            = {'onSendDialogResponse', {dialogId = 'int16'}, {button = 'int8'}, {listboxId = 'int16'}, {input = 'string8'}}
OUTCOMING_RPCS[RPC.CLICKTEXTDRAW]             = {'onSendClickTextDraw', {textdrawId = 'int16'}}
OUTCOMING_RPCS[RPC.SCMEVENT]                  = {'onSendVehicleTuningNotification', {vehicleId = 'int32'}, {param1 = 'int32'}, {param2 = 'int32'}, {event = 'int32'}}
OUTCOMING_RPCS[RPC.CHAT]                      = {'onSendChat', {message = 'string8'}}
OUTCOMING_RPCS[RPC.CLIENTCHECK]               = {'onSendClientCheckResponse', {requestType = 'int8'}, {result1 = 'int32'}, {result2 = 'int8'}}
OUTCOMING_RPCS[RPC.DAMAGEVEHICLE]             = {'onSendVehicleDamaged', {vehicleId = 'int16'}, {panelDmg = 'int32'}, {doorDmg = 'int32'}, {lights = 'int8'}, {tires = 'int8'}}
OUTCOMING_RPCS[RPC.EDITATTACHEDOBJECT]        = {'onSendEditAttachedObject', {response = 'int32'}, {index = 'int32'}, {model = 'int32'}, {bone = 'int32'}, {position = 'vector3d'}, {rotation = 'vector3d'}, {scale = 'vector3d'}, {color1 = 'int32'}, {color2 = 'int32'}}
OUTCOMING_RPCS[RPC.EDITOBJECT]                = {'onSendEditObject', {playerObject = 'bool'}, {objectId = 'int16'}, {response = 'int32'}, {position = 'vector3d'}, {rotation = 'vector3d'}}
OUTCOMING_RPCS[RPC.SETINTERIORID]             = {'onSendInteriorChangeNotification', {interior = 'int8'}}
OUTCOMING_RPCS[RPC.MAPMARKER]                 = {'onSendMapMarker', {position = 'vector3d'}}
OUTCOMING_RPCS[RPC.REQUESTCLASS]              = {'onSendRequestClass', {classId = 'int32'}}
OUTCOMING_RPCS[RPC.REQUESTSPAWN]              = {'onSendRequestSpawn'}
OUTCOMING_RPCS[RPC.PICKEDUPPICKUP]            = {'onSendPickedUpPickup', {pickupId = 'int32'}}
OUTCOMING_RPCS[RPC.MENUSELECT]                = {'onSendMenuSelect', {row = 'int8'}}
OUTCOMING_RPCS[RPC.VEHICLEDESTROYED]          = {'onSendVehicleDestroyed', {vehicleId = 'int16'}}
OUTCOMING_RPCS[RPC.MENUQUIT]                  = {'onSendQuitMenu'}
OUTCOMING_RPCS[RPC.EXITVEHICLE]               = {'onSendExitVehicle', {vehicleId = 'int16'}}
OUTCOMING_RPCS[RPC.UPDATESCORESPINGSIPS]      = {'onSendUpdateScoresAndPings'}
-- playerId = 'int16', damage = 'float', weapon = 'int32', bodypart ='int32'
OUTCOMING_RPCS[RPC.GIVETAKEDAMAGE]            = {{'onSendGiveDamage', 'onSendTakeDamage'}, handler.rpc_send_give_take_damage_reader, handler.rpc_send_give_take_damage_writer}
OUTCOMING_RPCS[RPC.SCRIPTCASH] = {'onSendMoneyIncreaseNotification', {amount = 'int32'}, {increaseType = 'int32'}}
OUTCOMING_RPCS[RPC.NPCJOIN] = {'onSendNPCJoin', {version = 'int32'}, {mod = 'int8'}, {nickname = 'string8'}, {challengeResponse = 'int32'}}
OUTCOMING_RPCS[RPC.SRVNETSTATS] = {'onSendServerStatisticsRequest'}
OUTCOMING_RPCS[RPC.WEAPONPICKUPDESTROY] = {'onSendPickedUpWeapon', {id = 'int16'}}
OUTCOMING_RPCS[RPC.CAMTARGETUPDATE] = {'onSendCameraTargetUpdate', {objectId = 'int16'}, {vehicleId = 'int16'}, {playerId = 'int16'}, {actorId = 'int16'}}
OUTCOMING_RPCS[RPC.GIVEACTORDAMAGE] = {'onSendGiveActorDamage', {_unused = 'bool'}, {actorId = 'int16'}, {damage = 'float'}, {weapon = 'int32'}, {bodypart ='int32'}}

-- Incoming rpcs
-- int playerId, string hostName, table settings, table vehicleModels, bool vehicleFriendlyFire
INCOMING_RPCS[RPC.INITGAME]                   = {'onInitGame', handler.rpc_init_game_reader, handler.rpc_init_game_writer}
INCOMING_RPCS[RPC.SERVERJOIN]                 = {'onPlayerJoin', {playerId = 'int16'}, {color = 'int32'}, {isNpc = 'bool8'}, {nickname = 'string8'}}
INCOMING_RPCS[RPC.SERVERQUIT]                 = {'onPlayerQuit', {playerId = 'int16'}, {reason = 'int8'}}
INCOMING_RPCS[RPC.REQUESTCLASS]               = {'onRequestClassResponse', {canSpawn = 'bool8'}, {team = 'int8'}, {skin = 'int32'}, {_unused = 'int8'}, {positon = 'vector3d'}, {rotation = 'float'}, {weapons = 'Int32Array3'}, {ammo = 'Int32Array3'}}
INCOMING_RPCS[RPC.REQUESTSPAWN]               = {'onRequestSpawnResponse', {response = 'bool8'}}
INCOMING_RPCS[RPC.SETPLAYERNAME]              = {'onSetPlayerName', {playerId = 'int16'}, {name = 'string8'}, {success = 'bool8'}}
INCOMING_RPCS[RPC.SETPLAYERPOS]               = {'onSetPlayerPos', {position = 'vector3d'}}
INCOMING_RPCS[RPC.SETPLAYERPOSFINDZ]          = {'onSetPlayerPosFindZ', {position = 'vector3d'}}
INCOMING_RPCS[RPC.SETPLAYERHEALTH]            = {'onSetPlayerHealth', {health = 'float'}}
INCOMING_RPCS[RPC.TOGGLEPLAYERCONTROLLABLE]   = {'onTogglePlayerControllable', {controllable = 'bool8'}}
INCOMING_RPCS[RPC.PLAYSOUND]                  = {'onPlaySound', {soundId = 'int32'}, {position = 'vector3d'}}
INCOMING_RPCS[RPC.SETPLAYERWORLDBOUNDS]       = {'onSetWorldBounds', {maxX = 'float'}, {minX = 'float'}, {maxY = 'float'}, {minY = 'float'}}
INCOMING_RPCS[RPC.GIVEPLAYERMONEY]            = {'onGivePlayerMoney', {money = 'int32'}}
INCOMING_RPCS[RPC.SETPLAYERFACINGANGLE]       = {'onSetPlayerFacingAngle', {angle = 'float'}}
INCOMING_RPCS[RPC.RESETPLAYERMONEY]           = {'onResetPlayerMoney'}
INCOMING_RPCS[RPC.RESETPLAYERWEAPONS]         = {'onResetPlayerWeapons'}
INCOMING_RPCS[RPC.GIVEPLAYERWEAPON]           = {'onGivePlayerWeapon', {weaponId = 'int32'}, {ammo = 'int32'}}
INCOMING_RPCS[RPC.CANCELEDIT]                 = {'onCancelEdit'}
INCOMING_RPCS[RPC.SETPLAYERTIME]              = {'onSetPlayerTime', {hour = 'int8'}, {minute = 'int8'}}
INCOMING_RPCS[RPC.TOGGLECLOCK]                = {'onSetToggleClock', {state = 'bool8'}}
INCOMING_RPCS[RPC.WORLDPLAYERADD]             = {'onPlayerStreamIn', {playerId = 'int16'}, {team = 'int8'}, {model = 'int32'}, {position = 'vector3d'}, {rotation = 'float'}, {color = 'int32'}, {fightingStyle = 'int8'}}
INCOMING_RPCS[RPC.SETPLAYERSHOPNAME]          = {'onSetShopName', {name = 'fixedString32'}}
INCOMING_RPCS[RPC.SETPLAYERSKILLLEVEL]        = {'onSetPlayerSkillLevel', {playerId = 'int16'}, {skill = 'int32'}, {level = 'int16'}}
INCOMING_RPCS[RPC.SETPLAYERDRUNKLEVEL]        = {'onSetPlayerDrunk', {drunkLevel = 'int32'}}
INCOMING_RPCS[RPC.CREATE3DTEXTLABEL]          = {'onCreate3DText', {id = 'int16'}, {color = 'int32'}, {position = 'vector3d'}, {distance = 'float'}, {testLOS = 'bool8'}, {attachedPlayerId = 'int16'}, {attachedVehicleId = 'int16'}, {text = 'encodedString4096'}}
INCOMING_RPCS[RPC.DISABLECHECKPOINT]          = {'onDisableCheckpoint'}
INCOMING_RPCS[RPC.SETRACECHECKPOINT]          = {'onSetRaceCheckpoint', {type = 'int8'}, {position = 'vector3d'}, {nextPosition = 'vector3d'}, {size = 'float'}}
INCOMING_RPCS[RPC.DISABLERACECHECKPOINT]      = {'onDisableRaceCheckpoint'}
INCOMING_RPCS[RPC.GAMEMODERESTART]            = {'onGamemodeRestart'}
INCOMING_RPCS[RPC.PLAYAUDIOSTREAM]            = {'onPlayAudioStream', {url = 'string8'}, {position = 'vector3d'}, {radius = 'float'}, {usePosition = 'bool8'}}
INCOMING_RPCS[RPC.STOPAUDIOSTREAM]            = {'onStopAudioStream'}
INCOMING_RPCS[RPC.REMOVEBUILDINGFORPLAYER]    = {'onRemoveBuilding', {modelId = 'int32'}, {position = 'vector3d'}, {radius = 'float'}}
INCOMING_RPCS[RPC.CREATEOBJECT]               = {'onCreateObject', handler.rpc_create_object_reader, handler.rpc_create_object_writer}
INCOMING_RPCS[RPC.SETOBJECTPOS]               = {'onSetObjectPosition', {objectId = 'int16'}, {position = 'vector3d'}}
INCOMING_RPCS[RPC.SETOBJECTROT]               = {'onSetObjectRotation', {objectId = 'int16'}, {rotation = 'vector3d'}}
INCOMING_RPCS[RPC.DESTROYOBJECT]              = {'onDestroyObject', {objectId = 'int16'}}
INCOMING_RPCS[RPC.DEATHMESSAGE]               = {'onPlayerDeathNotification', {killerId = 'int16'}, {killedId = 'int16'}, {reason = 'int8'}}
INCOMING_RPCS[RPC.SETPLAYERMAPICON]           = {'onSetMapIcon', {iconId = 'int8'}, {position = 'vector3d'}, {type = 'int8'}, {color = 'int32'}, {style = 'int8'}}
INCOMING_RPCS[RPC.REMOVEVEHICLECOMPONENT]     = {'onRemoveVehicleComponent', {vehicleId = 'int16'}, {componentId = 'int16'}}
INCOMING_RPCS[RPC.DESTROY3DTEXTLABEL]         = {'onRemove3DTextLabel', {textLabelId = 'int16'}}
INCOMING_RPCS[RPC.CHATBUBBLE]                 = {'onPlayerChatBubble', {playerId = 'int16'}, {color = 'int32'}, {distance = 'float'}, {duration = 'int32'}, {message = 'string8'}}
INCOMING_RPCS[RPC.UPDATETIME]                 = {'onUpdateGlobalTimer', {time = 'int32'}}
INCOMING_RPCS[RPC.SHOWDIALOG]                 = {'onShowDialog', {dialogId = 'int16'}, {style = 'int8'}, {title = 'string8'}, {button1 = 'string8'}, {button2 = 'string8'}, {text = 'encodedString4096'}}
INCOMING_RPCS[RPC.DESTROYPICKUP]              = {'onDestroyPickup', {id = 'int32'}}
INCOMING_RPCS[RPC.LINKVEHICLETOINTERIOR]      = {'onLinkVehicleToInterior', {vehicleId = 'int16'}, {interiorId = 'int8'}}
INCOMING_RPCS[RPC.SETPLAYERARMOUR]            = {'onSetPlayerArmour', {armour = 'float'}}
INCOMING_RPCS[RPC.SETPLAYERARMEDWEAPON]       = {'onSetPlayerArmedWeapon', {weaponId = 'int32'}}
INCOMING_RPCS[RPC.SETSPAWNINFO]               = {'onSetSpawnInfo', {team = 'int8'}, {skin = 'int32'}, {_unused = 'int8'}, {position = 'vector3d'}, {rotation = 'float'}, {weapons = 'Int32Array3'}, {ammo = 'Int32Array3'}}
INCOMING_RPCS[RPC.SETPLAYERTEAM]              = {'onSetPlayerTeam', {playerId = 'int16'}, {teamId = 'int8'}}
INCOMING_RPCS[RPC.PUTPLAYERINVEHICLE]         = {'onPutPlayerInVehicle', {vehicleId = 'int16'}, {seatId = 'int8'}}
INCOMING_RPCS[RPC.REMOVEPLAYERFROMVEHICLE]    = {'onRemovePlayerFromVehicle'}
INCOMING_RPCS[RPC.SETPLAYERCOLOR]             = {'onSetPlayerColor', {playerId = 'int16'}, {color = 'int32'}}
INCOMING_RPCS[RPC.DISPLAYGAMETEXT]            = {'onDisplayGameText', {style = 'int32'}, {time = 'int32'}, {text = 'string32'}}
INCOMING_RPCS[RPC.FORCECLASSSELECTION]        = {'onForceClassSelection'}
INCOMING_RPCS[RPC.ATTACHOBJECTTOPLAYER]       = {'onAttachObjectToPlayer', {objectId = 'int16'}, {playerId = 'int16'}, {offsets = 'vector3d'}, {rotation = 'vector3d'}}
-- menuId = 'int8', menuTitle = 'fixedString32', x = 'float', y = 'float', twoColumns = 'bool32', columns = 'table', rows = 'table', menu = 'bool32'
INCOMING_RPCS[RPC.INITMENU]                   = {'onInitMenu', handler.rpc_init_menu_reader, handler.rpc_init_menu_writer}
INCOMING_RPCS[RPC.SHOWMENU]                   = {'onShowMenu', {menuId = 'int8'}}
INCOMING_RPCS[RPC.HIDEMENU]                   = {'onHideMenu', {menuId = 'int8'}}
INCOMING_RPCS[RPC.CREATEEXPLOSION]            = {'onCreateExplosion', {position = 'vector3d'}, {style = 'int32'}, {radius = 'float'}}
INCOMING_RPCS[RPC.SHOWPLAYERNAMETAGFORPLAYER] = {'onShowPlayerNameTag', {playerId = 'int16'}, {show = 'bool8'}}
INCOMING_RPCS[RPC.ATTACHCAMERATOOBJECT]       = {'onAttachCameraToObject', {objectId = 'int16'}}
INCOMING_RPCS[RPC.INTERPOLATECAMERA]          = {'onInterpolateCamera', {setPos = 'bool'}, {fromPos = 'vector3d'}, {destPos = 'vector3d'}, {time = 'int32'}, {mode = 'int8'}}
INCOMING_RPCS[RPC.GANGZONESTOPFLASH]          = {'onGangZoneStopFlash', {zoneId = 'int16'}}
INCOMING_RPCS[RPC.APPLYANIMATION]             = {'onApplyPlayerAnimation', {playerId = 'int16'}, {animLib = 'string8'}, {animName = 'string8'}, {frameDelta = 'float'}, {loop = 'bool'}, {lockX = 'bool'}, {lockY = 'bool'}, {freeze = 'bool'}, {time = 'int32'}}
INCOMING_RPCS[RPC.CLEARANIMATIONS]            = {'onClearPlayerAnimation', {playerId = 'int16'}}
INCOMING_RPCS[RPC.SETPLAYERSPECIALACTION]     = {'onSetPlayerSpecialAction', {actionId = 'int8'}}
INCOMING_RPCS[RPC.SETPLAYERFIGHTINGSTYLE]     = {'onSetPlayerFightingStyle', {playerId = 'int16'}, {styleId = 'int8'}}
INCOMING_RPCS[RPC.SETPLAYERVELOCITY]          = {'onSetPlayerVelocity', {velocity = 'vector3d'}}
INCOMING_RPCS[RPC.SETVEHICLEVELOCITY]         = {'onSetVehicleVelocity', {turn = 'bool8'}, {velocity = 'vector3d'}}
INCOMING_RPCS[RPC.CLIENTMESSAGE]              = {'onServerMessage', {color = 'int32'}, {text = 'string32'}}
INCOMING_RPCS[RPC.SETWORLDTIME]               = {'onSetWorldTime', {hour = 'int8'}}
INCOMING_RPCS[RPC.CREATEPICKUP]               = {'onCreatePickup', {id = 'int32'}, {model = 'int32'}, {pickupType = 'int32'}, {position = 'vector3d'}}
INCOMING_RPCS[RPC.MOVEOBJECT]                 = {'onMoveObject', {objectId = 'int16'}, {fromPos = 'vector3d'}, {destPos = 'vector3d'}, {speed = 'float'}, {rotation = 'vector3d'}}
INCOMING_RPCS[RPC.ENABLESTUNTBONUSFORPLAYER]  = {'onEnableStuntBonus', {state = 'bool'}}
INCOMING_RPCS[RPC.TEXTDRAWSETSTRING]          = {'onTextDrawSetString', {id = 'int16'}, {text = 'string16'}}
INCOMING_RPCS[RPC.SETCHECKPOINT]              = {'onSetCheckpoint', {position = 'vector3d'}, {radius = 'float'}}
INCOMING_RPCS[RPC.GANGZONECREATE]             = {'onCreateGangZone', {zoneId = 'int16'}, {squareStart = 'vector2d'}, {squareEnd = 'vector2d'}, {color = 'int32'}}
INCOMING_RPCS[RPC.PLAYCRIMEREPORT]            = {'onPlayCrimeReport', {suspectId = 'int16'}, {inVehicle = 'bool32'}, {vehicleModel = 'int32'}, {vehicleColor = 'int32'}, {crime = 'int32'}, {coordinates = 'vector3d'}}
INCOMING_RPCS[RPC.GANGZONEDESTROY]            = {'onGangZoneDestroy', {zoneId = 'int16'}}
INCOMING_RPCS[RPC.GANGZONEFLASH]              = {'onGangZoneFlash', {zoneId = 'int16'}, {color = 'int32'}}
INCOMING_RPCS[RPC.STOPOBJECT]                 = {'onStopObject', {objectId = 'int16'}}
INCOMING_RPCS[RPC.SETNUMBERPLATE]             = {'onSetVehicleNumberPlate', {vehicleId = 'int16'}, {text = 'string8'}}
INCOMING_RPCS[RPC.TOGGLEPLAYERSPECTATING]     = {'onTogglePlayerSpectating', {state = 'bool32'}}
INCOMING_RPCS[RPC.PLAYERSPECTATEPLAYER]       = {'onSpectatePlayer', {playerId = 'int16'}, {camType = 'int8'}}
INCOMING_RPCS[RPC.PLAYERSPECTATEVEHICLE]      = {'onSpectateVehicle', {vehicleId = 'int16'}, {camType = 'int8'}}
INCOMING_RPCS[RPC.SHOWTEXTDRAW]               = {'onShowTextDraw',
  {textdrawId = 'int16'},
  {textdraw = {
    {flags = 'int8'},
    {letterWidth = 'float'},
    {letterHeight = 'float'},
    {letterColor = 'int32'},
    {lineWidth = 'float'},
    {lineHeight = 'float'},
    {boxColor = 'int32'},
    {shadow = 'int8'},
    {outline = 'int8'},
    {backgroundColor = 'int32'},
    {style = 'int8'},
    {selectable = 'int8'},
    {position = 'vector2d'},
    {modelId = 'int16'},
    {rotation = 'vector3d'},
    {zoom = 'float'},
    {color = 'int32'},
    {text = 'string16'}
  }}
}
INCOMING_RPCS[RPC.SETPLAYERWANTEDLEVEL]       = {'onSetPlayerWantedLevel', {wantedLevel = 'int8'}}
INCOMING_RPCS[RPC.TEXTDRAWHIDEFORPLAYER]      = {'onTextDrawHide', {textDrawId = 'int16'}}
INCOMING_RPCS[RPC.REMOVEPLAYERMAPICON]        = {'onRemoveMapIcon', {iconId = 'int8'}}
INCOMING_RPCS[RPC.SETPLAYERAMMO]              = {'onSetWeaponAmmo', {weaponId = 'int8'}, {ammo = 'int16'}}
INCOMING_RPCS[RPC.SETGRAVITY]                 = {'onSetGravity', {gravity = 'float'}}
INCOMING_RPCS[RPC.SETVEHICLEHEALTH]           = {'onSetVehicleHealth', {vehicleId = 'int16'}, {health = 'float'}}
INCOMING_RPCS[RPC.ATTACHTRAILERTOVEHICLE]     = {'onAttachTrailerToVehicle', {trailerId = 'int16'}, {vehicleId = 'int16'}}
INCOMING_RPCS[RPC.DETACHTRAILERFROMVEHICLE]   = {'onDetachTrailerFromVehicle', {vehicleId = 'int16'}}
INCOMING_RPCS[RPC.SETWEATHER]                 = {'onSetWeather', {weatherId = 'int8'}}
INCOMING_RPCS[RPC.SETPLAYERSKIN]              = {'onSetPlayerSkin', {playerId = 'int32'}, {skinId = 'int32'}}
INCOMING_RPCS[RPC.SETPLAYERINTERIOR]          = {'onSetInterior', {interior = 'int8'}}
INCOMING_RPCS[RPC.SETPLAYERCAMERAPOS]         = {'onSetCameraPosition', {position = 'vector3d'}}
INCOMING_RPCS[RPC.SETPLAYERCAMERALOOKAT]      = {'onSetCameraLookAt', {lookAtPosition = 'vector3d'}, {cutType = 'int8'}}
INCOMING_RPCS[RPC.SETVEHICLEPOS]              = {'onSetVehiclePosition', {vehicleId = 'int16'}, {position = 'vector3d'}}
INCOMING_RPCS[RPC.SETVEHICLEZANGLE]           = {'onSetVehicleAngle', {vehicleId = 'int16'}, {angle = 'float'}}
INCOMING_RPCS[RPC.SETVEHICLEPARAMSFORPLAYER]  = {'onSetVehicleParams', {vehicleId = 'int16'}, {objective = 'bool8'}, {doorsLocked = 'bool8'}}
INCOMING_RPCS[RPC.SETCAMERABEHINDPLAYER]      = {'onSetCameraBehind'}
INCOMING_RPCS[RPC.CHAT]                       = {'onChatMessage', {playerId = 'int16'}, {text = 'string8'}}
INCOMING_RPCS[RPC.CONNECTIONREJECTED]         = {'onConnectionRejected', {reason = 'int8'}}
INCOMING_RPCS[RPC.WORLDPLAYERREMOVE]          = {'onPlayerStreamOut', {playerId = 'int16'}}
INCOMING_RPCS[RPC.WORLDVEHICLEADD]            = {'onVehicleStreamIn', handler.rpc_vehicle_stream_in_reader, handler.rpc_vehicle_stream_in_writer}
INCOMING_RPCS[RPC.WORLDVEHICLEREMOVE]         = {'onVehicleStreamOut', {vehicleId = 'int16'}}
INCOMING_RPCS[RPC.WORLDPLAYERDEATH]           = {'onPlayerDeath', {playerId = 'int16'}}
INCOMING_RPCS[RPC.ENTERVEHICLE]               = {'onPlayerEnterVehicle', {playerId = 'int16'}, {vehicleId = 'int16'}, {passenger = 'bool8'}}
INCOMING_RPCS[RPC.UPDATESCORESPINGSIPS]       = {'onUpdateScoresAndPings', handler.rpc_update_scores_and_pings_reader, handler.rpc_update_scores_and_pings_writer}
INCOMING_RPCS[RPC.SETOBJECTMATERIAL]          = {{'onSetObjectMaterial', 'onSetObjectMaterialText'}, handler.rpc_set_object_material_reader, handler.rpc_set_object_material_writer}
INCOMING_RPCS[RPC.CREATEACTOR]                = {'onCreateActor', {actorId = 'int16'}, {skinId = 'int32'}, {position = 'vector3d'}, {rotation = 'float'}, {health = 'float'}}
INCOMING_RPCS[RPC.CLICKTEXTDRAW]              = {'onToggleSelectTextDraw', {state = 'bool'}, {hovercolor = 'int32'}}
INCOMING_RPCS[RPC.SETVEHICLEPARAMSEX]         = {'onSetVehicleParamsEx',
  {vehicleId = 'int16'},
  {params = {
    {engine = 'int8'},
    {lights = 'int8'},
    {alarm = 'int8'},
    {doors = 'int8'},
    {bonnet = 'int8'},
    {boot = 'int8'},
    {objective = 'int8'},
    {unknown = 'int8'}
  }},
  {doors = {
    {driver = 'int8'},
    {passenger = 'int8'},
    {backleft = 'int8'},
    {backright = 'int8'}
  }},
  {windows = {
    {driver = 'int8'},
    {passenger = 'int8'},
    {backleft = 'int8'},
    {backright = 'int8'}
  }}
}
INCOMING_RPCS[RPC.SETPLAYERATTACHEDOBJECT]    = {'onSetPlayerAttachedObject',
  {playerId = 'int16'},
  {index = 'int32'},
  {create = 'bool'},
  {object = {
    {modelId = 'int32'},
    {bone = 'int32'},
    {offset = 'vector3d'},
    {rotation = 'vector3d'},
    {scale = 'vector3d'},
    {color1 = 'int32'},
    {color2 = 'int32'}}
  }
}
INCOMING_RPCS[RPC.CLIENTCHECK] = {'onClientCheck', {requestType = 'int8'}, {subject = 'int32'}, {offset = 'int16'}, {length = 'int16'}}
INCOMING_RPCS[RPC.DESTROYACTOR] = {'onDestroyActor', {actorId = 'int16'}}
INCOMING_RPCS[RPC.DESTROYWEAPONPICKUP] = {'onDestroyWeaponPickup', {id = 'int8'}}
INCOMING_RPCS[RPC.EDITATTACHEDOBJECT] = {'onEditAttachedObject', {index = 'int32'}}
INCOMING_RPCS[RPC.TOGGLECAMERATARGET] = {'onToggleCameraTargetNotifying', {enable = 'bool'}}
INCOMING_RPCS[RPC.SELECTOBJECT] = {'onEnterSelectObject'}
INCOMING_RPCS[RPC.EXITVEHICLE] = {'onPlayerExitVehicle', {playerId = 'int16'}, {vehicleId = 'int16'}}
INCOMING_RPCS[RPC.SCMEVENT] = {'onVehicleTuningNotification', {playerId = 'int16'}, {event = 'int32'}, {vehicleId = 'int32'}, {param1 = 'int32'}, {param2 = 'int32'}}
INCOMING_RPCS[RPC.SRVNETSTATS] = {'onServerStatisticsResponse'} --, {data = 'RakNetStatisticsStruct'}}
INCOMING_RPCS[RPC.EDITOBJECT] = {'onEnterEditObject', {playerObject = 'bool'}, {objectId = 'int16'}}
INCOMING_RPCS[RPC.DAMAGEVEHICLE] = {'onVehicleDamageStatusUpdate', {vehicleId = 'int16'}, {panelDmg = 'int32'}, {doorDmg = 'int32'}, {lights = 'int8'}, {tires = 'int8'}}
INCOMING_RPCS[RPC.DISABLEVEHICLECOLLISIONS] = {'onDisableVehicleCollisions', {disable = 'bool'}}
INCOMING_RPCS[RPC.TOGGLEWIDESCREEN] = {'onToggleWidescreen', {enable = 'bool8'}}
INCOMING_RPCS[RPC.SETVEHICLETIRES] = {'onSetVehicleTires', {vehicleId = 'int16'}, {tires = 'int8'}}
INCOMING_RPCS[RPC.SETPLAYERDRUNKVISUALS] = {'onSetPlayerDrunkVisuals', {level = 'int32'}}
INCOMING_RPCS[RPC.SETPLAYERDRUNKHANDLING] = {'onSetPlayerDrunkHandling', {level = 'int32'}}
INCOMING_RPCS[RPC.APPLYACTORANIMATION] = {'onApplyActorAnimation', {actorId = 'int16'}, {animLib = 'string8'}, {animName = 'string8'}, {frameDelta = 'float'}, {loop = 'bool'}, {lockX = 'bool'}, {lockY = 'bool'}, {freeze = 'bool'}, {time = 'int32'}}
INCOMING_RPCS[RPC.CLEARACTORANIMATION] = {'onClearActorAnimation', {actorId = 'int16'}}
INCOMING_RPCS[RPC.SETACTORROTATION] = {'onSetActorFacingAngle', {actorId = 'int16'}, {angle = 'float'}}
INCOMING_RPCS[RPC.SETACTORPOSITION] = {'onSetActorPos', {actorId = 'int16'}, {position = 'vector3d'}}
INCOMING_RPCS[RPC.SETACTORHEALTH] = {'onSetActorHealth', {actorId = 'int16'}, {health = 'float'}}
INCOMING_RPCS[RPC.SETPLAYEROBJECTNOCAMCOL] = {'onSetPlayerObjectNoCameraCol', {objectId = 'int16'}}
INCOMING_RPCS[125] = {'_dummy125'}
INCOMING_RPCS[64] = {'_dummy64', {'int16'}}
INCOMING_RPCS[48] = {'_unused48', {'int32'}}


-- Outgoing packets
OUTCOMING_PACKETS[PACKET.RCON_COMMAND]        = {'onSendRconCommand', {command = 'string32'}}
OUTCOMING_PACKETS[PACKET.STATS_UPDATE]        = {'onSendStatsUpdate', {money = 'int32'}, {drunkLevel = 'int32'}}
local function empty_writer() end
OUTCOMING_PACKETS[PACKET.PLAYER_SYNC]         = {'onSendPlayerSync', function(bs) return utils.process_outcoming_sync_data(bs, 'PlayerSyncData') end, empty_writer}
OUTCOMING_PACKETS[PACKET.VEHICLE_SYNC]        = {'onSendVehicleSync', function(bs) return utils.process_outcoming_sync_data(bs, 'VehicleSyncData') end, empty_writer}
OUTCOMING_PACKETS[PACKET.PASSENGER_SYNC]      = {'onSendPassengerSync', function(bs) return utils.process_outcoming_sync_data(bs, 'PassengerSyncData') end, empty_writer}
OUTCOMING_PACKETS[PACKET.AIM_SYNC]            = {'onSendAimSync', function(bs) return utils.process_outcoming_sync_data(bs, 'AimSyncData') end, empty_writer}
OUTCOMING_PACKETS[PACKET.UNOCCUPIED_SYNC]     = {'onSendUnoccupiedSync', function(bs) return utils.process_outcoming_sync_data(bs, 'UnoccupiedSyncData') end, empty_writer}
OUTCOMING_PACKETS[PACKET.TRAILER_SYNC]        = {'onSendTrailerSync', function(bs) return utils.process_outcoming_sync_data(bs, 'TrailerSyncData') end, empty_writer}
OUTCOMING_PACKETS[PACKET.BULLET_SYNC]         = {'onSendBulletSync', function(bs) return utils.process_outcoming_sync_data(bs, 'BulletSyncData') end, empty_writer}
OUTCOMING_PACKETS[PACKET.SPECTATOR_SYNC]      = {'onSendSpectatorSync', function(bs) return utils.process_outcoming_sync_data(bs, 'SpectatorSyncData') end, empty_writer}
OUTCOMING_PACKETS[PACKET.WEAPONS_UPDATE] = {'onSendWeaponsUpdate', handler.packet_weapons_update_reader, handler.packet_weapons_update_writer}
OUTCOMING_PACKETS[PACKET.AUTHENTICATION] = {'onSendAuthenticationResponse', {response = 'string8'}}

-- Incoming packets
INCOMING_PACKETS[PACKET.PLAYER_SYNC]          = {'onPlayerSync', handler.packet_player_sync_reader, handler.packet_player_sync_writer}
INCOMING_PACKETS[PACKET.VEHICLE_SYNC]         = {'onVehicleSync', handler.packet_vehicle_sync_reader, handler.packet_vehicle_sync_writer}
INCOMING_PACKETS[PACKET.MARKERS_SYNC]         = {'onMarkersSync', handler.packet_markers_sync_reader, handler.packet_markers_sync_writer}
INCOMING_PACKETS[PACKET.AIM_SYNC]             = {'onAimSync', {playerId = 'int16'}, {data = 'AimSyncData'}}
INCOMING_PACKETS[PACKET.BULLET_SYNC]          = {'onBulletSync', {playerId = 'int16'}, {data = 'BulletSyncData'}}
INCOMING_PACKETS[PACKET.UNOCCUPIED_SYNC]      = {'onUnoccupiedSync', {playerId = 'int16'}, {data = 'UnoccupiedSyncData'}}
INCOMING_PACKETS[PACKET.TRAILER_SYNC]         = {'onTrailerSync', {playerId = 'int16'}, {data = 'TrailerSyncData'}}
INCOMING_PACKETS[PACKET.PASSENGER_SYNC]       = {'onPassengerSync', {playerId = 'int16'}, {data = 'PassengerSyncData'}}
INCOMING_PACKETS[PACKET.AUTHENTICATION] = {'onAuthenticationRequest', {key = 'string8'}}
INCOMING_PACKETS[PACKET.CONNECTION_REQUEST_ACCEPTED] = {'onConnectionRequestAccepted', {ip = 'int32'}, {port = 'int16'}, {playerId = 'int16'}, {challenge = 'int32'}}
INCOMING_PACKETS[PACKET.CONNECTION_LOST] = {'onConnectionLost'}
INCOMING_PACKETS[PACKET.CONNECTION_BANNED] = {'onConnectionBanned'}
INCOMING_PACKETS[PACKET.CONNECTION_ATTEMPT_FAILED] = {'onConnectionAttemptFailed'}
INCOMING_PACKETS[PACKET.NO_FREE_INCOMING_CONNECTIONS] = {'onConnectionNoFreeSlot'}
INCOMING_PACKETS[PACKET.INVALID_PASSWORD] = {'onConnectionPasswordInvalid'}
INCOMING_PACKETS[PACKET.DISCONNECTION_NOTIFICATION] = {'onConnectionClosed'}

return events
 