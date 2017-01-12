From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] power: bq24190_charger: Don't read fault register outside irq_handle_thread()
Date: Wed, 11 Jan 2017 16:41:52 -0800
Message-ID: <20170112004154.31568-5-tony@atomide.com>
References: <20170112004154.31568-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170112004154.31568-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

From: Liam Breck <kernel@networkimprov.net>

Caching the fault register after a single read may not keep an accurate
value.

Fix the issue by doing two reads of the fault register as specified in the
data sheet. And let's do this only irq_handle_thread() to avoid accidentally
clearing the fault status as specified in the data sheet:

"When a fault occurs, the charger device sends out INT
 and keeps the fault state in REG09 until the host reads the fault register.
 Before the host reads REG09 and all the faults are cleared, the charger
 device would not send any INT upon new faults. In order to read the
 current fault status, the host has to read REG09 two times consecutively.
 The 1st reads fault register status from the last read [1] and the 2nd reads
 the current fault register status."

[1] presumably a typo; should be "last fault"

Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery
Charger")
Cc: Mark A. Greer <mgreer@animalcreek.com>
Cc: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
[tony@atomide.com: cleaned up a bit]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 99 ++++++++++------------------------
 1 file changed, 29 insertions(+), 70 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -144,10 +144,7 @@
  * so the first read after a fault returns the latched value and subsequent
  * reads return the current value.  In order to return the fault status
  * to the user, have the interrupt handler save the reg's value and retrieve
- * it in the appropriate health/status routine.  Each routine has its own
- * flag indicating whether it should use the value stored by the last run
- * of the interrupt handler or do an actual reg read.  That way each routine
- * can report back whatever fault may have occured.
+ * it in the appropriate health/status routine.
  */
 struct bq24190_dev_info {
 	struct i2c_client		*client;
@@ -159,9 +156,6 @@ struct bq24190_dev_info {
 	unsigned int			gpio_int;
 	unsigned int			irq;
 	struct mutex			f_reg_lock;
-	bool				charger_health_valid;
-	bool				battery_health_valid;
-	bool				battery_status_valid;
 	u8				f_reg;
 	u8				ss_reg;
 	u8				watchdog;
@@ -635,21 +629,11 @@ static int bq24190_charger_get_health(struct bq24190_dev_info *bdi,
 		union power_supply_propval *val)
 {
 	u8 v;
-	int health, ret;
+	int health;
 
 	mutex_lock(&bdi->f_reg_lock);
-
-	if (bdi->charger_health_valid) {
-		v = bdi->f_reg;
-		bdi->charger_health_valid = false;
-		mutex_unlock(&bdi->f_reg_lock);
-	} else {
-		mutex_unlock(&bdi->f_reg_lock);
-
-		ret = bq24190_read(bdi, BQ24190_REG_F, &v);
-		if (ret < 0)
-			return ret;
-	}
+	v = bdi->f_reg;
+	mutex_unlock(&bdi->f_reg_lock);
 
 	if (v & BQ24190_REG_F_BOOST_FAULT_MASK) {
 		/*
@@ -936,18 +920,8 @@ static int bq24190_battery_get_status(struct bq24190_dev_info *bdi,
 	int status, ret;
 
 	mutex_lock(&bdi->f_reg_lock);
-
-	if (bdi->battery_status_valid) {
-		chrg_fault = bdi->f_reg;
-		bdi->battery_status_valid = false;
-		mutex_unlock(&bdi->f_reg_lock);
-	} else {
-		mutex_unlock(&bdi->f_reg_lock);
-
-		ret = bq24190_read(bdi, BQ24190_REG_F, &chrg_fault);
-		if (ret < 0)
-			return ret;
-	}
+	chrg_fault = bdi->f_reg;
+	mutex_unlock(&bdi->f_reg_lock);
 
 	chrg_fault &= BQ24190_REG_F_CHRG_FAULT_MASK;
 	chrg_fault >>= BQ24190_REG_F_CHRG_FAULT_SHIFT;
@@ -995,21 +969,11 @@ static int bq24190_battery_get_health(struct bq24190_dev_info *bdi,
 		union power_supply_propval *val)
 {
 	u8 v;
-	int health, ret;
+	int health;
 
 	mutex_lock(&bdi->f_reg_lock);
-
-	if (bdi->battery_health_valid) {
-		v = bdi->f_reg;
-		bdi->battery_health_valid = false;
-		mutex_unlock(&bdi->f_reg_lock);
-	} else {
-		mutex_unlock(&bdi->f_reg_lock);
-
-		ret = bq24190_read(bdi, BQ24190_REG_F, &v);
-		if (ret < 0)
-			return ret;
-	}
+	v = bdi->f_reg;
+	mutex_unlock(&bdi->f_reg_lock);
 
 	if (v & BQ24190_REG_F_BAT_FAULT_MASK) {
 		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
@@ -1201,15 +1165,19 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 		BQ24190_REG_F_NTC_FAULT_MASK;
 	bool alert_charger = false, alert_battery = false;
 	u8 ss_reg = 0, f_reg = 0;
-	int ret;
+	int i, ret;
 
 	pm_runtime_get_sync(bdi->dev);
 
-	ret = bq24190_read(bdi, BQ24190_REG_SS, &ss_reg);
-	if (ret < 0) {
-		dev_err(bdi->dev, "Can't read SS reg: %d\n", ret);
-		goto out;
-	}
+	/* We need to read f_reg twice if fault is set to get correct value */
+	i = 0;
+	do {
+		ret = bq24190_read(bdi, BQ24190_REG_F, &f_reg);
+		if (ret < 0) {
+			dev_err(bdi->dev, "Can't read F reg: %d\n", ret);
+			goto out;
+		}
+	} while (f_reg && ++i < 2);
 
 	if (ss_reg != bdi->ss_reg) {
 		/*
@@ -1235,32 +1203,29 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 		    (ss_reg & ~battery_mask_ss))
 			alert_charger = true;
 
+		mutex_lock(&bdi->f_reg_lock);
 		bdi->ss_reg = ss_reg;
-	}
-
-	mutex_lock(&bdi->f_reg_lock);
-
-	ret = bq24190_read(bdi, BQ24190_REG_F, &f_reg);
-	if (ret < 0) {
 		mutex_unlock(&bdi->f_reg_lock);
-		dev_err(bdi->dev, "Can't read F reg: %d\n", ret);
-		goto out;
 	}
 
 	if (f_reg != bdi->f_reg) {
+		dev_info(bdi->dev,
+			"Fault: boost %d, charge %d, battery %d, ntc %d\n",
+			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
+			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
+			!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
+			!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
+
 		if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
 			alert_battery = true;
 		if ((bdi->f_reg & ~battery_mask_f) != (f_reg & ~battery_mask_f))
 			alert_charger = true;
 
+		mutex_lock(&bdi->f_reg_lock);
 		bdi->f_reg = f_reg;
-		bdi->charger_health_valid = true;
-		bdi->battery_health_valid = true;
-		bdi->battery_status_valid = true;
+		mutex_unlock(&bdi->f_reg_lock);
 	}
 
-	mutex_unlock(&bdi->f_reg_lock);
-
 	if (alert_charger)
 		power_supply_changed(bdi->charger);
 	if (alert_battery)
@@ -1380,9 +1345,6 @@ static int bq24190_probe(struct i2c_client *client,
 	mutex_init(&bdi->f_reg_lock);
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK;
-	bdi->charger_health_valid = false;
-	bdi->battery_health_valid = false;
-	bdi->battery_status_valid = false;
 
 	i2c_set_clientdata(client, bdi);
 
@@ -1497,9 +1459,6 @@ static int bq24190_pm_resume(struct device *dev)
 
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK;
-	bdi->charger_health_valid = false;
-	bdi->battery_health_valid = false;
-	bdi->battery_status_valid = false;
 
 	pm_runtime_get_sync(bdi->dev);
 	bq24190_register_reset(bdi);
-- 
2.11.0
