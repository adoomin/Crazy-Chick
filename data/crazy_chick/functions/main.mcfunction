scoreboard objectives add CCExcOnce dummy
scoreboard objectives add CrazyChick dummy

#Initial Tag
execute as @e[type=minecraft:chicken,tag=!CCExcOnce] at @s if entity @e[type=minecraft:item,nbt={Item:{id:"minecraft:chicken"}},distance=0..0.5] run tag @s add CrazyChick
execute as @e[type=minecraft:chicken,tag=!CCExcOnce] at @s if entity @e[type=minecraft:item,nbt={Item:{id:"minecraft:cooked_chicken"}},distance=0..0.5] run tag @s add CrazyChick

#Execute Once
scoreboard players add @e[tag=CrazyChick,tag=!CCExcOnce] CCExcOnce 1
execute as @e[type=minecraft:item,nbt={Item:{id:"minecraft:chicken"}}] at @s run data merge entity @e[tag=CrazyChick,distance=0..0.5,limit=1] {Silent:1b,NoAI:1b}
execute as @e[type=minecraft:item,nbt={Item:{id:"minecraft:cooked_chicken"}}] at @s run data merge entity @e[tag=CrazyChick,distance=0..0.5,limit=1] {Silent:1b,NoAI:1b}
execute as @e[tag=CrazyChick,tag=!CCExcOnce] at @s run particle minecraft:angry_villager ~ ~ ~ 0 0 0 0.1 1 normal
execute as @e[tag=CrazyChick,tag=!CCExcOnce] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:chicken"}},distance=0..0.5]
execute as @e[tag=CrazyChick,tag=!CCExcOnce] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:cooked_chicken"}},distance=0..0.5]

tag @e[scores={CCExcOnce=1..},tag=!CCExcOnce] add CCExcOnce
scoreboard players reset @e[tag=CCExcOnce] CCExcOnce
tag @e[scores={CCExcOnce=0}] remove CCExcOnce

#Loop
scoreboard players add @e[tag=CrazyChick,tag=!CCExplosion] CrazyChick 1
execute as @e[tag=CrazyChick] at @s run effect give @s minecraft:resistance 1 255 true
execute as @e[tag=CrazyChick,tag=!CCExplosion,scores={CrazyChick=60..}] at @s run tp @s ~ ~ ~ ~60 ~
execute as @e[tag=CrazyChick,tag=!CCExplosion,scores={CrazyChick=60..}] at @s run particle minecraft:flame ~ ~1 ~ 0 0 0 0.15 5 normal
execute as @e[tag=CrazyChick,tag=!CCExplosion,scores={CrazyChick=60..}] at @s run playsound minecraft:entity.generic.extinguish_fire block @p
tag @e[tag=CrazyChick,tag=!CCExplosion,scores={CrazyChick=200..}] add CCExplosion
execute as @e[tag=CrazyChick,tag=CCExplosion] at @s run summon minecraft:tnt ~ ~ ~ {Fuse:0}
execute as @e[tag=CrazyChick,tag=CCExplosion] at @s run tp @s ~ ~-0.2 ~
execute as @e[tag=CrazyChick,tag=CCExplosion] at @s if block ~ ~ ~ minecraft:bedrock run kill @s