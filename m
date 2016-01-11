From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
Date: Mon, 11 Jan 2016 08:25:57 -0600
Message-ID: <5693BB75.70409@ti.com>
References: <20160109230709.GA30551@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160109230709.GA30551@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
Cc: a.hajda@samsung.com
List-Id: linux-omap@vger.kernel.org

On 01/09/2016 05:07 PM, Pavel Machek wrote:
> Hi!
>
> Did /sys/class/power_supply/bq27200-0/capacity change meaning between
> 4.1 and 4.4?
>
> It used to report battery capacity remaining in percent.
>
> Not sure what it reports now, but ain't in percent....
>
> pavel@n900:/my/tui/ofone$ cat
> /sys/class/power_supply/bq27200-0/capacity
> 7497
> pavel@n900:/my/tui/ofone$ uname -a
> Linux n900 4.4.0-rc8-omap3-149467-g69aafd8-dirty #114 PREEMPT Sat Jan
> 9 21:44:00 CET 2016 armv7l GNU/Linux
> pavel@n900:/my/tui/ofone$
>
> And power_supply_class.txt says:
>
> ~ ~ ~ ~ ~ ~ ~  Charge/Energy/Capacity - how to not confuse  ~ ~ ~ ~ ~
> ~ ~
> ~
> ~
> ~ Because both "charge" (=B5Ah) and "energy" (=B5Wh) represents "capa=
city"
> ~
> ~ of battery, this class distinguish these terms. Don't mix them!
> ~
> ~
> ~
> ~ CHARGE_* attributes represents capacity in =B5Ah only.
> ~
> ~ ENERGY_* attributes represents capacity in =B5Wh only.
> ~
> ~ CAPACITY attribute represents capacity in *percents*, from 0 to
> 100.  ~
>
> --- hmm. So that seems to be a mistake.
>
> pavel@n900:/my/tui/ofone$ cat /sys/class/power_supply/bq27200-0/capac=
ity
> 7497
> pavel@n900:/my/tui/ofone$ cat /sys/class/power_supply/bq27200-0/capac=
ity
> 16713
> pavel@n900:/my/tui/ofone$ cat /sys/class/power_supply/bq27200-0/capac=
ity
> 25162
>
> Converting them to hex gives rather strange values.
>
> Hmm. .... what is this? Git blames Andrew F. Davis.The first part of
> code suggests whole cache needs to be initialized... but the second
> part of the code only initializes cache.time_to_empty (for example)
> conditionaly.
>
> Are you sure?
>
>                  if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) =
{
>                          dev_info(di->dev, "battery is not calibrated=
! ignoring capacity values\n");
>                          cache.capacity =3D -ENODATA;
>                          cache.energy =3D -ENODATA;
>                          cache.time_to_empty =3D -ENODATA;
>                          cache.time_to_empty_avg =3D -ENODATA;
>                          cache.time_to_full =3D -ENODATA;
>                          cache.charge_full =3D -ENODATA;
>                          cache.health =3D -ENODATA;
>                  } else {
>                          if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_R=
EG_ADDR)
>                                  cache.time_to_empty =3D bq27xxx_batt=
ery_read_time(di, BQ27XXX_REG_TTE);
>                          if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID=
_REG_ADDR)
>                                  cache.time_to_empty_avg =3D bq27xxx_=
battery_read_time(di, BQ27XXX_REG_TT\
> ECP);
>                          if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_R=
EG_ADDR)
>                                  cache.time_to_full =3D bq27xxx_batte=
ry_read_time(di, BQ27XXX_REG_TTF);
>                          cache.charge_full =3D bq27xxx_battery_read_f=
cc(di);
>                          cache.capacity =3D bq27xxx_battery_read_soc(=
di);
>                          if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_RE=
G_ADDR)
>                                  cache.energy =3D bq27xxx_battery_rea=
d_energy(di);
>                          cache.health =3D bq27xxx_battery_read_health=
(di);
>                  }
>
> But that does not explain the wrong capacity..
>
> -static inline int bq27xxx_read(struct bq27xxx_device_info *di, u8  r=
eg,
> +static inline int bq27xxx_read(struct bq27xxx_device_info *di, int  =
reg_index,
>                                  bool single)
> 				 {
>
>
> This is pretty anti-social function now has completely different
> meaning, yet same name and compatible enough not to catch mistakes.
>
> And sure enough:
>
> static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di=
,u8 reg)
> {
>          int charge;
>
>          charge =3D bq27xxx_read(di, reg, false);
>
>
> The internal functions already check for non-existent registers. We
> can kill the debug prints and reuse that... its better than not
> initializing half the struct.
>
> The types should in bq27xxx_battery_read_time should be certainly
> fixed like the patch below suggests.
>
> The patch does not compile, but I should be sleeping, not trying to
> understand crazy code. Whoever wrote it, please fix it. Maybe you can
> just do
>
>                          cache.capacity =3D -ENODATA;
>                          cache.energy =3D -ENODATA;
>                          cache.time_to_empty =3D -ENODATA;
>                          cache.time_to_empty_avg =3D -ENODATA;
>                          cache.time_to_full =3D -ENODATA;
>                          cache.charge_full =3D -ENODATA;
>                          cache.health =3D -ENODATA;
>
> undonditionaly so that half of file does not need updating.
>
>
> 									Pavel
>
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_=
battery.c
> index 880233c..e9f26f5 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -483,11 +483,11 @@ static int bq27xxx_battery_read_soc(struct bq27=
xxx_device_info *di)
>    * Return a battery charge value in =B5Ah
>    * Or < 0 if something fails.
>    */
> -static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *d=
i, u8 reg)
> +static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *d=
i, int reg_index)
>   {
>   	int charge;
>
> -	charge =3D bq27xxx_read(di, reg, false);
> +	charge =3D bq27xxx_read(di, reg_index, false);
>   	if (charge < 0) {
>   		dev_dbg(di->dev, "error reading charge register %02x: %d\n",
>   			reg, charge);
> @@ -561,7 +561,6 @@ static int bq27xxx_battery_read_energy(struct bq2=
7xxx_device_info *di)
>
>   	ae =3D bq27xxx_read(di, BQ27XXX_REG_AE, false);
>   	if (ae < 0) {
> -		dev_dbg(di->dev, "error reading available energy\n");
>   		return ae;
>   	}
>
> @@ -602,8 +601,6 @@ static int bq27xxx_battery_read_cyct(struct bq27x=
xx_device_info *di)
>   	int cyct;
>
>   	cyct =3D bq27xxx_read(di, BQ27XXX_REG_CYCT, false);
> -	if (cyct < 0)
> -		dev_err(di->dev, "error reading cycle count total\n");
>
>   	return cyct;
>   }
> @@ -612,14 +609,12 @@ static int bq27xxx_battery_read_cyct(struct bq2=
7xxx_device_info *di)
>    * Read a time register.
>    * Return < 0 if something fails.
>    */
> -static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di,=
 u8 reg)
> +static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di,=
 int reg_index)
>   {
>   	int tval;
>
> -	tval =3D bq27xxx_read(di, reg, false);
> +	tval =3D bq27xxx_read(di, reg_index, false);
>   	if (tval < 0) {
> -		dev_dbg(di->dev, "error reading time register %02x: %d\n",
> -			reg, tval);
>   		return tval;
>   	}
>
> @@ -639,8 +634,6 @@ static int bq27xxx_battery_read_pwr_avg(struct bq=
27xxx_device_info *di)
>
>   	tval =3D bq27xxx_read(di, BQ27XXX_REG_AP, false);
>   	if (tval < 0) {
> -		dev_err(di->dev, "error reading average power register  %02x: %d\n=
",
> -			BQ27XXX_REG_AP, tval);
>   		return tval;
>   	}
>
> @@ -731,22 +724,16 @@ static void bq27xxx_battery_update(struct bq27x=
xx_device_info *di)
>   			cache.charge_full =3D -ENODATA;
>   			cache.health =3D -ENODATA;
>   		} else {
> -			if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_REG_ADDR)
> -				cache.time_to_empty =3D bq27xxx_battery_read_time(di, BQ27XXX_RE=
G_TTE);
> -			if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID_REG_ADDR)
> -				cache.time_to_empty_avg =3D bq27xxx_battery_read_time(di, BQ27XX=
X_REG_TTECP);
> -			if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_ADDR)
> -				cache.time_to_full =3D bq27xxx_battery_read_time(di, BQ27XXX_REG=
_TTF);
> +			cache.time_to_empty =3D bq27xxx_battery_read_time(di, BQ27XXX_REG=
_TTE);
> +			cache.time_to_empty_avg =3D bq27xxx_battery_read_time(di, BQ27XXX=
_REG_TTECP);
> +			cache.time_to_full =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_=
TTF);
>   			cache.charge_full =3D bq27xxx_battery_read_fcc(di);
>   			cache.capacity =3D bq27xxx_battery_read_soc(di);
> -			if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
> -				cache.energy =3D bq27xxx_battery_read_energy(di);
> +			cache.energy =3D bq27xxx_battery_read_energy(di);
>   			cache.health =3D bq27xxx_battery_read_health(di);
>   		}
> -		if (di->regs[BQ27XXX_REG_CYCT] !=3D INVALID_REG_ADDR)
> -			cache.cycle_count =3D bq27xxx_battery_read_cyct(di);
> -		if (di->regs[BQ27XXX_REG_AP] !=3D INVALID_REG_ADDR)
> -			cache.power_avg =3D bq27xxx_battery_read_pwr_avg(di);
> +		cache.cycle_count =3D bq27xxx_battery_read_cyct(di);
> +		cache.power_avg =3D bq27xxx_battery_read_pwr_avg(di);
>
>   		/* We only have to read charge design full once */
>   		if (di->charge_design_full <=3D 0)
>

There was a resent overhaul of this driver and a lot of code is
vestigial as you have seen. I've been meaning to continue
cleaning it up, my next step would probably to bring up regmap
on the 1wire bus, so that we could cut out a whole bunch of this
stuff by using its built-in caching instead of this attempt at
rolling our own.

Beyond this, I see no immediate problems with these suggested
changes, although attempting to call a function to read a value
when that associated register is invalid doesn't make much
sense ether, maybe clearing the cache to start would work better?
Or maybe even just trashing the whole caching thing.
