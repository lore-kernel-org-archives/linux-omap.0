From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] power: bq24190_charger: Use PM runtime autosuspend
Date: Wed, 11 Jan 2017 16:41:54 -0800
Message-ID: <20170112004154.31568-7-tony@atomide.com>
References: <20170112004154.31568-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170112004154.31568-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>
List-Id: linux-omap@vger.kernel.org

We can get quite a few interrupts when the battery is trickle charging.
Let's enable PM runtime autosuspend to avoid constantly toggling device
state.

Let's use a 600 ms timeout as that's how long the USB chager detection
might take.

Cc: Mark A. Greer <mgreer@animalcreek.com>
Cc: Matt Ranostay <matt@ranostay.consulting>
Cc: Liam Breck <kernel@networkimprov.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 101 ++++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -420,6 +420,7 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
 	struct bq24190_sysfs_field_info *info;
+	ssize_t count;
 	int ret;
 	u8 v;
 
@@ -427,11 +428,20 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 	if (!info)
 		return -EINVAL;
 
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0)
+		return ret;
+
 	ret = bq24190_read_mask(bdi, info->reg, info->mask, info->shift, &v);
 	if (ret)
-		return ret;
+		count = ret;
+	else
+		count = scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
+
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
+	return count;
 }
 
 static ssize_t bq24190_sysfs_store(struct device *dev,
@@ -451,9 +461,16 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0)
+		return ret;
+
 	ret = bq24190_write_mask(bdi, info->reg, info->mask, info->shift, v);
 	if (ret)
-		return ret;
+		count = ret;
+
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
 
 	return count;
 }
@@ -795,7 +812,9 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0)
+		return ret;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
@@ -835,7 +854,9 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 		ret = -ENODATA;
 	}
 
-	pm_runtime_put_sync(bdi->dev);
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
 	return ret;
 }
 
@@ -848,7 +869,9 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0)
+		return ret;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
@@ -864,7 +887,9 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 		ret = -EINVAL;
 	}
 
-	pm_runtime_put_sync(bdi->dev);
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
 	return ret;
 }
 
@@ -1065,7 +1090,9 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0)
+		return ret;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -1093,7 +1120,9 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 		ret = -ENODATA;
 	}
 
-	pm_runtime_put_sync(bdi->dev);
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
 	return ret;
 }
 
@@ -1119,7 +1148,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 		ret = -EINVAL;
 	}
 
-	pm_runtime_put_sync(bdi->dev);
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
 	return ret;
 }
 
@@ -1236,11 +1267,15 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 {
 	struct bq24190_dev_info *bdi = data;
+	int ret;
 
 	bdi->irq_event = true;
-	pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0)
+		return ret;
 	bq24190_check_status(bdi);
-	pm_runtime_put_sync(bdi->dev);
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
 	bdi->irq_event = false;
 	return IRQ_HANDLED;
 }
@@ -1250,7 +1285,9 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 	u8 v;
 	int ret;
 
-	pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0)
+		return ret;
 
 	/* First check that the device really is what its supposed to be */
 	ret = bq24190_read_mask(bdi, BQ24190_REG_VPRS,
@@ -1275,7 +1312,9 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 
 	ret = bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 out:
-	pm_runtime_put_sync(bdi->dev);
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
 	return ret;
 }
 
@@ -1373,9 +1412,14 @@ static int bq24190_probe(struct i2c_client *client,
 		dev_err(dev, "Can't set up irq handler\n");
 		goto out1;
 	}
+	enable_irq_wake(bdi->irq);
 
 	pm_runtime_enable(dev);
-	pm_runtime_resume(dev);
+	pm_runtime_set_autosuspend_delay(dev, 600);
+	pm_runtime_use_autosuspend(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto out2;
 
 	ret = bq24190_hw_init(bdi);
 	if (ret < 0) {
@@ -1412,6 +1456,9 @@ static int bq24190_probe(struct i2c_client *client,
 	enable_irq(bdi->irq);
 	bdi->initialized = 1;
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
 out4:
@@ -1419,6 +1466,7 @@ static int bq24190_probe(struct i2c_client *client,
 out3:
 	power_supply_unregister(bdi->charger);
 out2:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 out1:
 	if (bdi->gpio_int)
@@ -1430,9 +1478,14 @@ static int bq24190_probe(struct i2c_client *client,
 static int bq24190_remove(struct i2c_client *client)
 {
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
+	int ret;
+
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0)
+		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
 
-	pm_runtime_get_sync(bdi->dev);
 	bq24190_register_reset(bdi);
+	pm_runtime_dont_use_autosuspend(bdi->dev);
 	pm_runtime_put_sync(bdi->dev);
 
 	bq24190_sysfs_remove_group(bdi);
@@ -1480,10 +1533,14 @@ static int bq24190_pm_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
+	int error;
 
-	pm_runtime_get_sync(bdi->dev);
+	error = pm_runtime_get_sync(bdi->dev);
+	if (error < 0)
+		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
 	bq24190_register_reset(bdi);
-	pm_runtime_put_sync(bdi->dev);
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
 
 	return 0;
 }
@@ -1492,15 +1549,19 @@ static int bq24190_pm_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
+	int error;
 
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK;
 
-	pm_runtime_get_sync(bdi->dev);
+	error = pm_runtime_get_sync(bdi->dev);
+	if (error < 0)
+		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
 	bq24190_register_reset(bdi);
 	bq24190_set_mode_host(bdi);
 	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
-	pm_runtime_put_sync(bdi->dev);
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
 
 	/* Things may have changed while suspended so alert upper layer */
 	power_supply_changed(bdi->charger);
-- 
2.11.0
