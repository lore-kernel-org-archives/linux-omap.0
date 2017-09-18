From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: power: supply: bq27xxx: enable writing capacity values for bq27500
Date: Mon, 18 Sep 2017 15:28:59 +0200
Message-ID: <34F7C917-B068-4D37-8E9F-492B49A06FD0@goldelico.com>
References: <CAKvHMgRhmRKsC-2DrxD0sx3rXBN9xyv3W9cbXAUO7oTHEawm8Q@mail.gmail.com> <CAKvHMgTTUuoaSMON6o=+chBv53aSZrDukz06DTdOYYGtTbovag@mail.gmail.com> <CAKvHMgSztFGS_KmeNoT7Fe-xTpgiH_-Y3=Us_QCtK9FzMM67kg@mail.gmail.com> <CAKvHMgTH7-e7TTKj--5HjDCV5kZCr_=aY73wRRePMDiLPdE55g@mail.gmail.com> <CAKvHMgR6jEjY08v95mYenHo=V+n59EfFVFb8R+P_Mx8kHJc+3A@mail.gmail.com> <CAKvHMgTDwhbXerhybL1=WemLmn_fpKWdhmZPVvGPQ_Xzu-m1Uw@mail.gmail.com> <CAKvHMgQVQYcyS-Ku7VeNLoZ6MtP331nbfooskiHM9wuF1pC9gQ@mail.gmail.com> <CAKvHMgQ+W-mX4TMo4ggiVJZ=8==Okr5ZeD_A84SfGYshA1Zn3Q@mail.gmail.com> <CAKvHMgQGhqG_5WcDO9Ovt9wp1oxy-08RbyMR5gcLNeiYdeXAeg@mail.gmail.com> <CAKvHMgTDaoLcw80Y7inM3sqc5r5fgVb3TYSfARg=3QBXOWhJ0w@mail.gmail.com> <CAKvHMgRBnktcaxF2GKGMUSbctQsUK-UFf8S1mBMR5dP4Tw8htA@mail.gmail.com> <CAKvHMgSpyAUsm-AH9eO7KAzuxxf
 KsOROtRqx=-KfuqprwWRMYw@mail.gmail.com> <CAKvHMgTtxYUXGmCOq3MEB5-r3xvuR7RoCdMPkq2CTHBXvw-+7g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAKvHMgTtxYUXGmCOq3MEB5-r3xvuR7RoCdMPkq2CTHBXvw-+7g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Linux PM mailing list <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Liam,

> Am 01.09.2017 um 22:09 schrieb Liam Breck <liam@networkimprov.net>:
>=20
> [resend in plaintext]
>=20
> Hi Sebastian,
>=20
> This chip definition, enabled by this patch from Nikolaus, is not
> fully tested yet. I just sent him a new fix to try, and his previous
> kernel logs for it aren't definitely correct.
>=20
> Could you drop this from -next? Hopefully he'll have a new patch for
> you shortly...
>=20
> power: supply: bq27xxx: enable writing capacity values for bq27500
> https://patchwork.kernel.org/patch/9931511/
>=20
> Cc Tony re OpenPandora dtsi patches

Sorry for the delayed response.

I finally have rebased my code to 4.14-rc1 so that we have a patch set
that is not cluttered by patches that are already upstream:

	=
http://git.goldelico.com/?p=3Dgta04-kernel.git;a=3Dshortlog;h=3Drefs/heads=
/work/hns/power/bq27xxx-v4

Planned for upstreaming are (the others are to set up my test and =
debugging scenario):

9d528aed7824 power: supply: bq27xxx: various fixes
34e45831b268 power: supply: bq27xxx: print not only new but also old =
value as dev_info on updates
c972651de71b power: supply: bq27xxx: fix for bq27500 to better ignore =
energy-full-design-microwatt-hours
3a238896289a power: supply: bq27xxx: enable writing capacity values for =
bq27500
c2589c44b9bd DT: OpenPandora: fix for configuration of bq27500 fuel =
gauge
30523bd80bf8 DT: OpenPandora: add battery node to describe OpenPandora =
battery

With that I have tested again on OpenPandora (and have disabled =
bq27000-hdq to avoid disturbances of the log):

root@letux:~# dmesg|fgrep bq27
[   23.561553] bq27xxx_battery_setup
[   23.561614] bq27xxx_battery_setup: dm_regs=3Dbf06508c
[   23.567687] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   23.581756] bq27xxx_battery_settings
[   23.582153] bq27xxx_battery_set_config
[   23.582214] bq27xxx_battery_unseal
[   23.637390] bq27xxx_battery_update_dm_block
[   23.637451] bq27xxx-battery 2-0055: design-capacity has 4000
[   23.637512] bq27xxx_battery_update_dm_block
[   23.637542] bq27xxx-battery 2-0055: design-energy dm spec =
incompatible with data on flash/NVM
[   23.660736] bq27xxx_battery_update_dm_block
[   23.660797] bq27xxx-battery 2-0055: terminate-voltage has 3200
[   23.660827] bq27xxx_battery_seal
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DDischarging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3963000
POWER_SUPPLY_CURRENT_NOW=3D-316000
POWER_SUPPLY_CAPACITY=3D81
POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
POWER_SUPPLY_TEMP=3D207
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D35040
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3766000
POWER_SUPPLY_CHARGE_NOW=3D3084000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4000000
POWER_SUPPLY_CYCLE_COUNT=3D65535
POWER_SUPPLY_ENERGY_NOW=3D11395000
POWER_SUPPLY_POWER_AVG=3D64284
POWER_SUPPLY_HEALTH=3DGood
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

This seems to be ok now!

Next boot after changing battery properties in DT:

root@letux:~# dmesg|fgrep bq27
[   23.819946] bq27xxx_battery_setup
[   23.820007] bq27xxx_battery_setup: dm_regs=3Dbf06508c
[   23.825988] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   23.860137] bq27xxx_battery_settings
[   23.860565] bq27xxx_battery_set_config
[   23.860595] bq27xxx_battery_unseal
[   23.892089] bq27xxx_battery_update_dm_block
[   23.892150] bq27xxx: di->opts=3D2
[   23.892181] bq27xxx: bq27xxx_dt_to_nvm=3D1
[   23.892211] bq27xxx: CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=3Dy
[   23.892272] bq27xxx-battery 2-0055: update design-capacity from 4000 =
to 4100
[   23.892333] bq27xxx_battery_update_dm_block
[   23.892364] bq27xxx-battery 2-0055: design-energy dm spec =
incompatible with data on flash/NVM
[   23.914672] bq27xxx_battery_update_dm_block
[   23.914733] bq27xxx: di->opts=3D2
[   23.914764] bq27xxx: bq27xxx_dt_to_nvm=3D1
[   23.914825] bq27xxx: CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=3Dy
[   23.914855] bq27xxx-battery 2-0055: update terminate-voltage from =
3200 to 3250
[   24.146972] bq27xxx_battery_seal
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DDischarging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3951000
POWER_SUPPLY_CURRENT_NOW=3D-313000
POWER_SUPPLY_CAPACITY=3D82
POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
POWER_SUPPLY_TEMP=3D211
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D34980
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3763000
POWER_SUPPLY_CHARGE_NOW=3D3119000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4000000

^^^ shouldn't this be updated?

POWER_SUPPLY_CYCLE_COUNT=3D65535
POWER_SUPPLY_ENERGY_NOW=3D11531000
POWER_SUPPLY_POWER_AVG=3D64365
POWER_SUPPLY_HEALTH=3DGood
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

Next boot with same setup (and battery removed in between):

root@letux:~# dmesg|fgrep bq27
[   23.847167] bq27xxx_battery_setup
[   23.891052] bq27xxx_battery_setup: dm_regs=3Dbf06508c
[   23.984893] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   25.112243] bq27xxx_battery_settings
[   25.116516] bq27xxx_battery_set_config
[   25.179290] bq27xxx_battery_unseal
[   25.231689] bq27xxx_battery_update_dm_block
[   25.236236] bq27xxx: di->opts=3D2
[   25.281311] bq27xxx: bq27xxx_dt_to_nvm=3D1
[   25.285583] bq27xxx: CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=3Dy
[   25.357971] bq27xxx-battery 2-0055: update design-capacity from 4000 =
to 4100

^^^ looks as if NVM wasn't reprogrammed

[   25.449127] bq27xxx_battery_update_dm_block
[   25.453674] bq27xxx-battery 2-0055: design-energy dm spec =
incompatible with data on flash/NVM
[   25.561737] bq27xxx_battery_update_dm_block
[   25.566284] bq27xxx: di->opts=3D2
[   25.629272] bq27xxx: bq27xxx_dt_to_nvm=3D1
[   25.633544] bq27xxx: CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=3Dy
[   25.719268] bq27xxx-battery 2-0055: update terminate-voltage from =
3200 to 3250
[   26.047363] bq27xxx_battery_seal
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DDischarging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3947000
POWER_SUPPLY_CURRENT_NOW=3D-335000
POWER_SUPPLY_CAPACITY=3D81
POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
POWER_SUPPLY_TEMP=3D219
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D29760
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3762000
POWER_SUPPLY_CHARGE_NOW=3D3064000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4000000
POWER_SUPPLY_CYCLE_COUNT=3D65535
POWER_SUPPLY_ENERGY_NOW=3D11317000
POWER_SUPPLY_POWER_AVG=3D64343
POWER_SUPPLY_HEALTH=3DGood
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

Next boot with terminate-voltage restored to 3200 so that only =
design-capacity is to be updated:

[   23.512603] bq27xxx_battery_setup
[   23.516265] bq27xxx_battery_setup: dm_regs=3Dbf05108c
[   23.710540] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   24.653045] bq27xxx_battery_settings
[   24.657348] bq27xxx_battery_set_config
[   24.739135] bq27xxx_battery_unseal
[   24.816772] bq27xxx_battery_update_dm_block
[   24.859008] bq27xxx: di->opts=3D2
[   24.862487] bq27xxx: bq27xxx_dt_to_nvm=3D1
[   24.866729] bq27xxx: CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=3Dy
[   24.932067] bq27xxx-battery 2-0055: update design-capacity from 4000 =
to 4100

^^^ wasn't programmed

[   25.015411] bq27xxx_battery_update_dm_block
[   25.033233] bq27xxx-battery 2-0055: design-energy dm spec =
incompatible with data on flash/NVM
[   25.160614] bq27xxx_battery_update_dm_block
[   25.165191] bq27xxx-battery 2-0055: terminate-voltage has 3200

^^^ ok, there is no need to update

[   25.342407] bq27xxx_battery_seal
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DDischarging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3945000
POWER_SUPPLY_CURRENT_NOW=3D-303000
POWER_SUPPLY_CAPACITY=3D80
POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
POWER_SUPPLY_TEMP=3D217
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D34500
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3766000
POWER_SUPPLY_CHARGE_NOW=3D3053000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4000000

^^^ DT value did not arrive...

POWER_SUPPLY_CYCLE_COUNT=3D65535
POWER_SUPPLY_ENERGY_NOW=3D11279000
POWER_SUPPLY_POWER_AVG=3D64352
POWER_SUPPLY_HEALTH=3DGood
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

Next boot after removing battery again:

root@letux:~# dmesg|fgrep bq27
[   23.675231] bq27xxx_battery_setup
[   23.707244] bq27xxx_battery_setup: dm_regs=3Dbf05108c
[   24.561981] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   24.794433] bq27xxx_battery_settings
[   24.969604] bq27xxx_battery_set_config
[   24.973724] bq27xxx_battery_unseal
[   25.044097] bq27xxx_battery_update_dm_block
[   25.070159] bq27xxx: di->opts=3D2
[   25.073608] bq27xxx: bq27xxx_dt_to_nvm=3D1
[   25.077850] bq27xxx: CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=3Dy
[   25.198852] bq27xxx-battery 2-0055: update design-capacity from 4000 =
to 4100
[   25.206390] bq27xxx_battery_update_dm_block
[   25.269683] bq27xxx-battery 2-0055: design-energy dm spec =
incompatible with data on flash/NVM
[   25.381317] bq27xxx_battery_update_dm_block
[   25.385894] bq27xxx-battery 2-0055: terminate-voltage has 3200
[   25.611450] bq27xxx_battery_seal
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DDischarging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3940000
POWER_SUPPLY_CURRENT_NOW=3D-304000
POWER_SUPPLY_CAPACITY=3D78
POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
POWER_SUPPLY_TEMP=3D220
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D33060
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3768000
POWER_SUPPLY_CHARGE_NOW=3D2954000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4000000
POWER_SUPPLY_CYCLE_COUNT=3D65535
POWER_SUPPLY_ENERGY_NOW=3D10904000
POWER_SUPPLY_POWER_AVG=3D64354
POWER_SUPPLY_HEALTH=3DGood
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

Now restored DT to the original setting:

root@letux:~# dmesg|fgrep bq27
[   24.253234] bq27xxx_battery_setup
[   24.253295] bq27xxx_battery_setup: dm_regs=3Dbf05108c
[   24.312469] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   24.315002] bq27xxx_battery_settings
[   24.315429] bq27xxx_battery_set_config
[   24.315460] bq27xxx_battery_unseal
[   24.441101] bq27xxx_battery_update_dm_block
[   24.441192] bq27xxx-battery 2-0055: design-capacity has 4000
[   24.441223] bq27xxx_battery_update_dm_block
[   24.441284] bq27xxx-battery 2-0055: design-energy dm spec =
incompatible with data on flash/NVM
[   24.469818] bq27xxx_battery_update_dm_block
[   24.469879] bq27xxx-battery 2-0055: terminate-voltage has 3200
[   24.469940] bq27xxx_battery_seal
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DDischarging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3921000
POWER_SUPPLY_CURRENT_NOW=3D-290000
POWER_SUPPLY_CAPACITY=3D78
POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
POWER_SUPPLY_TEMP=3D222
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D38700
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3767000
POWER_SUPPLY_CHARGE_NOW=3D2947000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4000000
POWER_SUPPLY_CYCLE_COUNT=3D65535
POWER_SUPPLY_ENERGY_NOW=3D10865000
POWER_SUPPLY_POWER_AVG=3D64551
POWER_SUPPLY_HEALTH=3DGood
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

It does not try to reprogram anything.

And now with CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM disabled (and =
settings like stored in the fuel gauge):

root@letux:~# dmesg|fgrep bq27
[   23.581451] bq27xxx_battery_setup
[   23.581542] bq27xxx_battery_setup: dm_regs=3Dbf05108c
[   23.587493] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   23.611297] bq27xxx_battery_settings
[   23.611724] bq27xxx_battery_set_config
[   23.611755] bq27xxx_battery_unseal
[   23.653350] bq27xxx_battery_update_dm_block
[   23.653411] bq27xxx-battery 2-0055: design-capacity has 4000
[   23.653442] bq27xxx_battery_update_dm_block
[   23.653503] bq27xxx-battery 2-0055: design-energy dm spec =
incompatible with data on flash/NVM
[   23.667633] bq27xxx_battery_update_dm_block
[   23.667694] bq27xxx-battery 2-0055: terminate-voltage has 3200
[   23.667724] bq27xxx_battery_seal
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DDischarging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3881000
POWER_SUPPLY_CURRENT_NOW=3D-281000
POWER_SUPPLY_CAPACITY=3D72
POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
POWER_SUPPLY_TEMP=3D227
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D35580
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3762000
POWER_SUPPLY_CHARGE_NOW=3D2727000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4000000
POWER_SUPPLY_CYCLE_COUNT=3D65535
POWER_SUPPLY_ENERGY_NOW=3D9990000
POWER_SUPPLY_POWER_AVG=3D64511
POWER_SUPPLY_HEALTH=3DGood
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

And finally with CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM disabled and =
trying to change design-capacity by DT:

root@letux:~# dmesg|fgrep bq27
[   23.865692] bq27xxx_battery_setup
[   23.888519] bq27xxx_battery_setup: dm_regs=3Dbf05108c
[   23.955749] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   25.171295] bq27xxx_battery_settings
[   25.175567] bq27xxx_battery_set_config
[   25.241607] bq27xxx_battery_unseal
[   25.316955] bq27xxx_battery_update_dm_block
[   25.378784] bq27xxx: di->opts=3D2
[   25.382232] bq27xxx: bq27xxx_dt_to_nvm=3D1
[   25.386474] bq27xxx: CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=3Dn
[   25.478515] bq27xxx-battery 2-0055: design-capacity has 4000; update =
to 4100 disallowed for flash/NVM data memory

^^^ is rejected as expected

[   25.538970] bq27xxx_battery_update_dm_block
[   25.543518] bq27xxx-battery 2-0055: design-energy dm spec =
incompatible with data on flash/NVM
[   25.620727] bq27xxx_battery_update_dm_block
[   25.625305] bq27xxx-battery 2-0055: terminate-voltage has 3200
[   25.709411] bq27xxx_battery_seal
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DDischarging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3871000
POWER_SUPPLY_CURRENT_NOW=3D-305000
POWER_SUPPLY_CAPACITY=3D70
POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
POWER_SUPPLY_TEMP=3D221
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D29580
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3762000
POWER_SUPPLY_CHARGE_NOW=3D2661000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4000000
POWER_SUPPLY_CYCLE_COUNT=3D65535
POWER_SUPPLY_ENERGY_NOW=3D9730000
POWER_SUPPLY_POWER_AVG=3D64355
POWER_SUPPLY_HEALTH=3DGood
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

So in summary I'd say NVM flashing (seal/unseal) doesn't work =
(reliably).
And a new value of design-capacity does not arrive at =
POWER_SUPPLY_CHARGE_FULL_DESIGN.

Or how would you interpret these results?

BR,
Nikolaus
