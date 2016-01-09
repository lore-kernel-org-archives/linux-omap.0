From: Pavel Machek <pavel@ucw.cz>
Subject: /sys/class/power_supply/bq27200-0/capacity changed meaning between
 4.1 and 4.4?
Date: Sun, 10 Jan 2016 00:07:09 +0100
Message-ID: <20160109230709.GA30551@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
Cc: a.hajda@samsung.com, afd@ti.com
List-Id: linux-omap@vger.kernel.org

Hi!

Did /sys/class/power_supply/bq27200-0/capacity change meaning between
4.1 and 4.4?

It used to report battery capacity remaining in percent.

Not sure what it reports now, but ain't in percent....

pavel@n900:/my/tui/ofone$ cat
/sys/class/power_supply/bq27200-0/capacity
7497
pavel@n900:/my/tui/ofone$ uname -a
Linux n900 4.4.0-rc8-omap3-149467-g69aafd8-dirty #114 PREEMPT Sat Jan
9 21:44:00 CET 2016 armv7l GNU/Linux
pavel@n900:/my/tui/ofone$

And power_supply_class.txt says:

~ ~ ~ ~ ~ ~ ~  Charge/Energy/Capacity - how to not confuse  ~ ~ ~ ~ ~
~ ~
~
~
~ Because both "charge" (=B5Ah) and "energy" (=B5Wh) represents "capaci=
ty"
~
~ of battery, this class distinguish these terms. Don't mix them!
~
~
~
~ CHARGE_* attributes represents capacity in =B5Ah only.
~
~ ENERGY_* attributes represents capacity in =B5Wh only.
~
~ CAPACITY attribute represents capacity in *percents*, from 0 to
100.  ~

--- hmm. So that seems to be a mistake.

pavel@n900:/my/tui/ofone$ cat /sys/class/power_supply/bq27200-0/capacit=
y
7497
pavel@n900:/my/tui/ofone$ cat /sys/class/power_supply/bq27200-0/capacit=
y
16713
pavel@n900:/my/tui/ofone$ cat /sys/class/power_supply/bq27200-0/capacit=
y
25162

Converting them to hex gives rather strange values.

Hmm. .... what is this? Git blames Andrew F. Davis. The first part of
code suggests whole cache needs to be initialized... but the second
part of the code only initializes cache.time_to_empty (for example)
conditionaly.

Are you sure?

                if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
                        dev_info(di->dev, "battery is not calibrated! i=
gnoring capacity values\n");
                        cache.capacity =3D -ENODATA;
                        cache.energy =3D -ENODATA;
                        cache.time_to_empty =3D -ENODATA;
                        cache.time_to_empty_avg =3D -ENODATA;
                        cache.time_to_full =3D -ENODATA;
                        cache.charge_full =3D -ENODATA;
                        cache.health =3D -ENODATA;
                } else {
                        if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_REG_=
ADDR)
                                cache.time_to_empty =3D bq27xxx_battery=
_read_time(di, BQ27XXX_REG_TTE);
                        if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID_RE=
G_ADDR)
                                cache.time_to_empty_avg =3D bq27xxx_bat=
tery_read_time(di, BQ27XXX_REG_TT\
ECP);
                        if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_=
ADDR)
                                cache.time_to_full =3D bq27xxx_battery_=
read_time(di, BQ27XXX_REG_TTF);
                        cache.charge_full =3D bq27xxx_battery_read_fcc(=
di);
                        cache.capacity =3D bq27xxx_battery_read_soc(di)=
;
                        if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_A=
DDR)
                                cache.energy =3D bq27xxx_battery_read_e=
nergy(di);
                        cache.health =3D bq27xxx_battery_read_health(di=
);
                }

But that does not explain the wrong capacity..

-static inline int bq27xxx_read(struct bq27xxx_device_info *di, u8  reg=
,
+static inline int bq27xxx_read(struct bq27xxx_device_info *di, int  re=
g_index,
                                bool single)
				 {


This is pretty anti-social function now has completely different
meaning, yet same name and compatible enough not to catch mistakes.

And sure enough:

static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di,u=
8 reg)
{
        int charge;

        charge =3D bq27xxx_read(di, reg, false);


The internal functions already check for non-existent registers. We
can kill the debug prints and reuse that... its better than not
initializing half the struct.

The types should in bq27xxx_battery_read_time should be certainly
fixed like the patch below suggests.

The patch does not compile, but I should be sleeping, not trying to
understand crazy code. Whoever wrote it, please fix it. Maybe you can
just do

                        cache.capacity =3D -ENODATA;
                        cache.energy =3D -ENODATA;
                        cache.time_to_empty =3D -ENODATA;
                        cache.time_to_empty_avg =3D -ENODATA;
                        cache.time_to_full =3D -ENODATA;
                        cache.charge_full =3D -ENODATA;
                        cache.health =3D -ENODATA;

undonditionaly so that half of file does not need updating.=20


									Pavel

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_ba=
ttery.c
index 880233c..e9f26f5 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -483,11 +483,11 @@ static int bq27xxx_battery_read_soc(struct bq27xx=
x_device_info *di)
  * Return a battery charge value in =B5Ah
  * Or < 0 if something fails.
  */
-static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di,=
 u8 reg)
+static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di,=
 int reg_index)
 {
 	int charge;
=20
-	charge =3D bq27xxx_read(di, reg, false);
+	charge =3D bq27xxx_read(di, reg_index, false);
 	if (charge < 0) {
 		dev_dbg(di->dev, "error reading charge register %02x: %d\n",
 			reg, charge);
@@ -561,7 +561,6 @@ static int bq27xxx_battery_read_energy(struct bq27x=
xx_device_info *di)
=20
 	ae =3D bq27xxx_read(di, BQ27XXX_REG_AE, false);
 	if (ae < 0) {
-		dev_dbg(di->dev, "error reading available energy\n");
 		return ae;
 	}
=20
@@ -602,8 +601,6 @@ static int bq27xxx_battery_read_cyct(struct bq27xxx=
_device_info *di)
 	int cyct;
=20
 	cyct =3D bq27xxx_read(di, BQ27XXX_REG_CYCT, false);
-	if (cyct < 0)
-		dev_err(di->dev, "error reading cycle count total\n");
=20
 	return cyct;
 }
@@ -612,14 +609,12 @@ static int bq27xxx_battery_read_cyct(struct bq27x=
xx_device_info *di)
  * Read a time register.
  * Return < 0 if something fails.
  */
-static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u=
8 reg)
+static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, i=
nt reg_index)
 {
 	int tval;
=20
-	tval =3D bq27xxx_read(di, reg, false);
+	tval =3D bq27xxx_read(di, reg_index, false);
 	if (tval < 0) {
-		dev_dbg(di->dev, "error reading time register %02x: %d\n",
-			reg, tval);
 		return tval;
 	}
=20
@@ -639,8 +634,6 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27=
xxx_device_info *di)
=20
 	tval =3D bq27xxx_read(di, BQ27XXX_REG_AP, false);
 	if (tval < 0) {
-		dev_err(di->dev, "error reading average power register  %02x: %d\n",
-			BQ27XXX_REG_AP, tval);
 		return tval;
 	}
=20
@@ -731,22 +724,16 @@ static void bq27xxx_battery_update(struct bq27xxx=
_device_info *di)
 			cache.charge_full =3D -ENODATA;
 			cache.health =3D -ENODATA;
 		} else {
-			if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_REG_ADDR)
-				cache.time_to_empty =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_=
TTE);
-			if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID_REG_ADDR)
-				cache.time_to_empty_avg =3D bq27xxx_battery_read_time(di, BQ27XXX_=
REG_TTECP);
-			if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_ADDR)
-				cache.time_to_full =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_T=
TF);
+			cache.time_to_empty =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_T=
TE);
+			cache.time_to_empty_avg =3D bq27xxx_battery_read_time(di, BQ27XXX_R=
EG_TTECP);
+			cache.time_to_full =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TT=
=46);
 			cache.charge_full =3D bq27xxx_battery_read_fcc(di);
 			cache.capacity =3D bq27xxx_battery_read_soc(di);
-			if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
-				cache.energy =3D bq27xxx_battery_read_energy(di);
+			cache.energy =3D bq27xxx_battery_read_energy(di);
 			cache.health =3D bq27xxx_battery_read_health(di);
 		}
-		if (di->regs[BQ27XXX_REG_CYCT] !=3D INVALID_REG_ADDR)
-			cache.cycle_count =3D bq27xxx_battery_read_cyct(di);
-		if (di->regs[BQ27XXX_REG_AP] !=3D INVALID_REG_ADDR)
-			cache.power_avg =3D bq27xxx_battery_read_pwr_avg(di);
+		cache.cycle_count =3D bq27xxx_battery_read_cyct(di);
+		cache.power_avg =3D bq27xxx_battery_read_pwr_avg(di);
=20
 		/* We only have to read charge design full once */
 		if (di->charge_design_full <=3D 0)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
