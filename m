From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
Date: Thu, 19 Oct 2017 19:33:24 +0200
Message-ID: <20171019173324.nvkg5ykrryobtipv@lenoch>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth>
 <20170908113231.GJ18365@amd>
 <20171018122804.GA14376@amd>
 <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com>
 <20171018132204.GD4394@atomide.com>
 <0C0901E1-23E8-4D04-B3A9-8314809A7A6B@goldelico.com>
 <20171019162416.GE4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171019162416.GE4394@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Marek Belisko <marek.belisko@open-nandra.com>, robh+dt@kernel.org, linux-pm@vger.kernel.org, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 19, 2017 at 09:24:16AM -0700, Tony Lindgren wrote:
> * H. Nikolaus Schaller <hns@goldelico.com> [171018 08:49]:
> > 
> > > Am 18.10.2017 um 15:22 schrieb Tony Lindgren <tony@atomide.com>:
> > > 
> > > * H. Nikolaus Schaller <hns@goldelico.com> [171018 05:49]:
> > >>> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
> > >>> 
> > >>> So I started something, it is at.
> > >>> 
> > >>> https://github.com/pavelmachek/libbattery
> > >>> 
> > >>> My battery on n900 is currently uncalibrated (and charging), still it
> > >>> gets some kind of estimation:
> > >>> 
> > >>> Battery -1 %
> > >>> Seconds -1
> > >>> State 1
> > >>> Voltage 3.88 V
> > >>> Battery 63 %
> > >>> 
> > >>> Of course, there's a lot more work to be done.
> > >> 
> > >> Nice start but not a solution to our problem.
> > >> 
> > >> Our problem is that people simply expect that for example https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
> > >> displays the battery percentage.
> > > 
> > > I think we could make things compatible with various battery apps by
> > > having libbattery write back the capacity percentage and time remaining
> > > to the kernel driver via sysfs or a dev entry. Then the kernel interface
> > > can just display the data to whatever apps.
> > 
> > Hm. That would be quite difficult to understand and maintain code.
> 
> How so? The libbattery can do it all, then the kernel drivers needing
> that will just display the most recent values to maintain compability
> with battery apps.
> 
> > Why not have the kernel driver do the simple calculations (they do
> > not need float) and provide the standard /sys/class/power attribute?
> 
> Because the current remaining capacity and battery empty state depend
> on maintaining a database of previous history for battery wear. This
> data needs to be preserved across reboots, so most likely on a file
> on a disk is the way to go.

Well, a lot of gas gauches have registers to store that kind of information.
Just noone uses them and that's another part of story.
This one I'm using for such purposes, but as I didn't figure out what is
standard way of dealing wich such kind of information, I'm lock with
this solution for now.

Subject: [PATCH] power: supply: ltc2941-battery-gauge: charge empty and full

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 59 +++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 08e4fd9ee607..523373ea9cbd 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -34,6 +34,10 @@ enum ltc294x_reg {
 	LTC294X_REG_CONTROL		= 0x01,
 	LTC294X_REG_ACC_CHARGE_MSB	= 0x02,
 	LTC294X_REG_ACC_CHARGE_LSB	= 0x03,
+	LTC294X_REG_CHARGE_THR_HIGH_MSB	= 0x04,
+	LTC294X_REG_CHARGE_THR_HIGH_LSB	= 0x05,
+	LTC294X_REG_CHARGE_THR_LOW_MSB	= 0x06,
+	LTC294X_REG_CHARGE_THR_LOW_LSB	= 0x07,
 	LTC294X_REG_VOLTAGE_MSB		= 0x08,
 	LTC294X_REG_VOLTAGE_LSB		= 0x09,
 	LTC2942_REG_TEMPERATURE_MSB	= 0x0C,
@@ -178,21 +182,22 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
 	return ret;
 }
 
-static int ltc294x_read_charge_register(const struct ltc294x_info *info)
-{
+static int ltc294x_read_charge_register(const struct ltc294x_info *info,
+					enum ltc294x_reg reg)
+ {
 	int ret;
 	u8 datar[2];
 
-	ret = ltc294x_read_regs(info->client,
-		LTC294X_REG_ACC_CHARGE_MSB, &datar[0], 2);
+	ret = ltc294x_read_regs(info->client, reg, &datar[0], 2);
 	if (ret < 0)
 		return ret;
 	return (datar[0] << 8) + datar[1];
 }
 
-static int ltc294x_get_charge_now(const struct ltc294x_info *info, int *val)
+static int ltc294x_get_charge(const struct ltc294x_info *info,
+				enum ltc294x_reg reg, int *val)
 {
-	int value = ltc294x_read_charge_register(info);
+	int value = ltc294x_read_charge_register(info, reg);
 
 	if (value < 0)
 		return value;
@@ -244,10 +249,29 @@ static int ltc294x_set_charge_now(const struct ltc294x_info *info, int val)
 	return ret < 0 ? ret : 0;
 }
 
+static int ltc294x_set_charge_thr(const struct ltc294x_info *info,
+					enum ltc294x_reg reg, int val)
+{
+	u8 dataw[2];
+	s32 value;
+
+	value = convert_uAh_to_bin(info, val);
+	/* Direction depends on how sense+/- were connected */
+	if (info->Qlsb < 0)
+		value += 0xFFFF;
+	if ((value < 0) || (value > 0xFFFF)) /* input validation */
+		return -EINVAL;
+
+	/* Set new charge value */
+	dataw[0] = I16_MSB(value);
+	dataw[1] = I16_LSB(value);
+	return ltc294x_write_regs(info->client, reg, &dataw[0], 2);
+}
+
 static int ltc294x_get_charge_counter(
 	const struct ltc294x_info *info, int *val)
 {
-	int value = ltc294x_read_charge_register(info);
+	int value = ltc294x_read_charge_register(info, LTC294X_REG_ACC_CHARGE_MSB);
 
 	if (value < 0)
 		return value;
@@ -335,8 +359,15 @@ static int ltc294x_get_property(struct power_supply *psy,
 	struct ltc294x_info *info = power_supply_get_drvdata(psy);
 
 	switch (prop) {
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		return ltc294x_get_charge(info, LTC294X_REG_CHARGE_THR_HIGH_MSB,
+						&val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
+		return ltc294x_get_charge(info, LTC294X_REG_CHARGE_THR_LOW_MSB,
+						&val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		return ltc294x_get_charge_now(info, &val->intval);
+		return ltc294x_get_charge(info, LTC294X_REG_ACC_CHARGE_MSB,
+						&val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		return ltc294x_get_charge_counter(info, &val->intval);
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -357,6 +388,12 @@ static int ltc294x_set_property(struct power_supply *psy,
 	struct ltc294x_info *info = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		return ltc294x_set_charge_thr(info,
+			LTC294X_REG_CHARGE_THR_HIGH_MSB, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
+		return ltc294x_set_charge_thr(info,
+			LTC294X_REG_CHARGE_THR_LOW_MSB, val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 		return ltc294x_set_charge_now(info, val->intval);
 	default:
@@ -368,6 +405,8 @@ static int ltc294x_property_is_writeable(
 	struct power_supply *psy, enum power_supply_property psp)
 {
 	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 		return 1;
 	default:
@@ -377,7 +416,7 @@ static int ltc294x_property_is_writeable(
 
 static void ltc294x_update(struct ltc294x_info *info)
 {
-	int charge = ltc294x_read_charge_register(info);
+	int charge = ltc294x_read_charge_register(info, LTC294X_REG_ACC_CHARGE_MSB);
 
 	if (charge != info->charge) {
 		info->charge = charge;
@@ -396,6 +435,8 @@ static void ltc294x_work(struct work_struct *work)
 
 static enum power_supply_property ltc294x_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_EMPTY,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_TEMP,
-- 
2.11.0

> There's a nice summary what all is involved here:
> 
> http://www.mpoweruk.com/soc.htm
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
