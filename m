From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] power: bq24190_charger: Call power_supply_changed() only for relevant component
Date: Wed, 11 Jan 2017 16:41:51 -0800
Message-ID: <20170112004154.31568-4-tony@atomide.com>
References: <20170112004154.31568-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170112004154.31568-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

From: Liam Breck <kernel@networkimprov.net>

We wrongly get uevents for bq24190-charger and bq24190-battery on every
register change.

Fix the issue by checking the association with charger and/or battery before
emitting uevent(s).

Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190
Battery Charger")
Cc: Mark A. Greer <mgreer@animalcreek.com>
Cc: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
[tony@atomide.com: cleaned up a bit]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 54 +++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -159,7 +159,6 @@ struct bq24190_dev_info {
 	unsigned int			gpio_int;
 	unsigned int			irq;
 	struct mutex			f_reg_lock;
-	bool				first_time;
 	bool				charger_health_valid;
 	bool				battery_health_valid;
 	bool				battery_status_valid;
@@ -1197,7 +1196,10 @@ static const struct power_supply_desc bq24190_battery_desc = {
 static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 {
 	struct bq24190_dev_info *bdi = data;
-	bool alert_userspace = false;
+	const u8 battery_mask_ss = BQ24190_REG_SS_CHRG_STAT_MASK;
+	const u8 battery_mask_f = BQ24190_REG_F_BAT_FAULT_MASK |
+		BQ24190_REG_F_NTC_FAULT_MASK;
+	bool alert_charger = false, alert_battery = false;
 	u8 ss_reg = 0, f_reg = 0;
 	int ret;
 
@@ -1225,8 +1227,15 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 					ret);
 		}
 
+		if ((bdi->ss_reg & battery_mask_ss) !=
+		    (ss_reg & battery_mask_ss))
+			alert_battery = true;
+
+		if ((bdi->ss_reg & ~battery_mask_ss) !=
+		    (ss_reg & ~battery_mask_ss))
+			alert_charger = true;
+
 		bdi->ss_reg = ss_reg;
-		alert_userspace = true;
 	}
 
 	mutex_lock(&bdi->f_reg_lock);
@@ -1239,33 +1248,23 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 	}
 
 	if (f_reg != bdi->f_reg) {
+		if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
+			alert_battery = true;
+		if ((bdi->f_reg & ~battery_mask_f) != (f_reg & ~battery_mask_f))
+			alert_charger = true;
+
 		bdi->f_reg = f_reg;
 		bdi->charger_health_valid = true;
 		bdi->battery_health_valid = true;
 		bdi->battery_status_valid = true;
-
-		alert_userspace = true;
 	}
 
 	mutex_unlock(&bdi->f_reg_lock);
 
-	/*
-	 * Sometimes bq24190 gives a steady trickle of interrupts even
-	 * though the watchdog timer is turned off and neither the STATUS
-	 * nor FAULT registers have changed.  Weed out these sprurious
-	 * interrupts so userspace isn't alerted for no reason.
-	 * In addition, the chip always generates an interrupt after
-	 * register reset so we should ignore that one (the very first
-	 * interrupt received).
-	 */
-	if (alert_userspace) {
-		if (!bdi->first_time) {
-			power_supply_changed(bdi->charger);
-			power_supply_changed(bdi->battery);
-		} else {
-			bdi->first_time = false;
-		}
-	}
+	if (alert_charger)
+		power_supply_changed(bdi->charger);
+	if (alert_battery)
+		power_supply_changed(bdi->battery);
 
 out:
 	pm_runtime_put_sync(bdi->dev);
@@ -1300,6 +1299,10 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 		goto out;
 
 	ret = bq24190_set_mode_host(bdi);
+	if (ret < 0)
+		goto out;
+
+	ret = bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 out:
 	pm_runtime_put_sync(bdi->dev);
 	return ret;
@@ -1375,7 +1378,8 @@ static int bq24190_probe(struct i2c_client *client,
 	bdi->model = id->driver_data;
 	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
 	mutex_init(&bdi->f_reg_lock);
-	bdi->first_time = true;
+	bdi->f_reg = 0;
+	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK;
 	bdi->charger_health_valid = false;
 	bdi->battery_health_valid = false;
 	bdi->battery_status_valid = false;
@@ -1491,12 +1495,16 @@ static int bq24190_pm_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 
+	bdi->f_reg = 0;
+	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK;
 	bdi->charger_health_valid = false;
 	bdi->battery_health_valid = false;
 	bdi->battery_status_valid = false;
 
 	pm_runtime_get_sync(bdi->dev);
 	bq24190_register_reset(bdi);
+	bq24190_set_mode_host(bdi);
+	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 	pm_runtime_put_sync(bdi->dev);
 
 	/* Things may have changed while suspended so alert upper layer */
-- 
2.11.0
