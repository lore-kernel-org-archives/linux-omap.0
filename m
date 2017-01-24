From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Mon, 23 Jan 2017 17:27:02 -0800
Message-ID: <20170124012702.GA7403@atomide.com>
References: <20170120220440.1971-1-tony@atomide.com>
 <20170120220440.1971-3-tony@atomide.com>
 <CAKvHMgQKPZcdBPMUH-3_e-M4sHPijEH59019bygmi+o2y4B+Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgQKPZcdBPMUH-3_e-M4sHPijEH59019bygmi+o2y4B+Rw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Liam Breck <liam@networkimprov.net> [170120 16:48]:
> On Fri, Jan 20, 2017 at 2:04 PM, Tony Lindgren <tony@atomide.com> wrote:
> > We can get quite a few interrupts when the battery is trickle charging.
> > Let's enable PM runtime autosuspend to avoid constantly toggling device
> > state.
> 
> Which device state would constantly toggle?

The device driver PM runtime state. I've updated the description for that.

> > Cc: Matt Ranostay <matt@ranostay.consulting>
> 
> We can probably drop Matt from this thread; he's been busy with the
> fuel gauge, etc.

Fair enough :)

> > @@ -427,11 +428,20 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
> >         if (!info)
> >                 return -EINVAL;
> >
> > +       ret = pm_runtime_get_sync(bdi->dev);
> > +       if (ret < 0)
> > +               return ret;
> > +
> >         ret = bq24190_read_mask(bdi, info->reg, info->mask, info->shift, &v);
> >         if (ret)
> > -               return ret;
> > +               count = ret;
> > +       else
> > +               count = scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
> 
> Unless it violates a style guide, I prefer
>   count = ret ? ret : scnprintf(buf, PAGE_SIZE, "%hhx\n", v);

I don't like that, I find it hard to read.

> > @@ -1249,7 +1286,9 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
> >         u8 v;
> >         int ret;
> >
> > -       pm_runtime_get_sync(bdi->dev);
> > +       ret = pm_runtime_get_sync(bdi->dev);
> > +       if (ret < 0)
> > +               return ret;
> 
> Why is pm_runtime_*() necessary in this function?
> probe() already calls pm_runtime_*() around hw_init(); nothing else calls it.

Good point, it's not needed. I've removed the pm_runtime_calls.

> > @@ -1364,12 +1405,16 @@ static int bq24190_probe(struct i2c_client *client,
> >         }
> 
> v1 patchset called enable_irq_wake() here.
> v2 change list does not mention its removal.

Oops sorry about that, that's a mismerge on the rebase. I've added that
now to after request_threaded_irq().

> > -out4:
> > +out5:
> >         bq24190_sysfs_remove_group(bdi);
> >
> > -out3:
> > +out4:
> >         power_supply_unregister(bdi->battery);
> >
> > -out2:
> > +out3:
> >         power_supply_unregister(bdi->charger);
> >
> > +out2:
> > +       pm_runtime_put_sync(dev);
> > +
> 
> v2 change list does not mention this addition

Well I mentioned the changes for "mostly for the probe error handling"
in the cover letter and that's needed as we now have the multiple out
labels.

> > @@ -1430,9 +1482,13 @@ static int bq24190_probe(struct i2c_client *client,
> >  static int bq24190_remove(struct i2c_client *client)
> >  {
> >         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
> > +       int ret;
> >
> > -       pm_runtime_get_sync(bdi->dev);
> > +       ret = pm_runtime_get_sync(bdi->dev);
> > +       if (ret < 0)
> > +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
> >         bq24190_register_reset(bdi);
> > +       pm_runtime_dont_use_autosuspend(bdi->dev);
> >         pm_runtime_put_sync(bdi->dev);
> 
> Should skip these if get_sync() failed?

Yes, I've fixed it.

> Is pm_runtime_disable() needed here?

Yes it's best to keep the pm_runtime calls always paired.

> > @@ -1480,10 +1536,14 @@ static int bq24190_pm_suspend(struct device *dev)
> >  {
> >         struct i2c_client *client = to_i2c_client(dev);
> >         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
> > +       int error;
> >
> > -       pm_runtime_get_sync(bdi->dev);
> > +       error = pm_runtime_get_sync(bdi->dev);
> > +       if (error < 0)
> > +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> >         bq24190_register_reset(bdi);
> > -       pm_runtime_put_sync(bdi->dev);
> > +       pm_runtime_mark_last_busy(bdi->dev);
> > +       pm_runtime_put_autosuspend(bdi->dev);
> 
> Should skip these if get_sync() failed?

Yes fixed.

> > @@ -1492,15 +1552,19 @@ static int bq24190_pm_resume(struct device *dev)
> >  {
> >         struct i2c_client *client = to_i2c_client(dev);
> >         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
> > +       int error;
> >
> >         bdi->f_reg = 0;
> >         bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
> >
> > -       pm_runtime_get_sync(bdi->dev);
> > +       error = pm_runtime_get_sync(bdi->dev);
> > +       if (error < 0)
> > +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> >         bq24190_register_reset(bdi);
> >         bq24190_set_mode_host(bdi);
> >         bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
> > -       pm_runtime_put_sync(bdi->dev);
> > +       pm_runtime_mark_last_busy(bdi->dev);
> > +       pm_runtime_put_autosuspend(bdi->dev);
> 
> Should skip these if get_sync() failed?

Here too.

Updated patch below with fixes for the comments above. I've dropped Mark's
ack as there are several changes so please re-review.

Regards,

Tony

8< ---------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 20 Jan 2017 09:58:51 -0800
Subject: [PATCH] power: bq24190_charger: Use PM runtime autosuspend

We can get quite a few interrupts when the battery is trickle charging.
Let's enable PM runtime autosuspend to avoid constantly toggling device
driver PM runtime state.

Let's use a 600 ms timeout as that's how long the USB chager detection
might take.

Cc: Liam Breck <kernel@networkimprov.net>
Cc: Mark Greer <mgreer@animalcreek.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 147 ++++++++++++++++++++++-----------
 1 file changed, 101 insertions(+), 46 deletions(-)

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
 
-	return scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
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
 
@@ -1106,7 +1135,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0)
+		return ret;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1119,7 +1150,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 		ret = -EINVAL;
 	}
 
-	pm_runtime_put_sync(bdi->dev);
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
 	return ret;
 }
 
@@ -1234,11 +1267,15 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
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
@@ -1249,33 +1286,26 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 	u8 v;
 	int ret;
 
-	pm_runtime_get_sync(bdi->dev);
-
 	/* First check that the device really is what its supposed to be */
 	ret = bq24190_read_mask(bdi, BQ24190_REG_VPRS,
 			BQ24190_REG_VPRS_PN_MASK,
 			BQ24190_REG_VPRS_PN_SHIFT,
 			&v);
 	if (ret < 0)
-		goto out;
+		return ret;
 
-	if (v != bdi->model) {
-		ret = -ENODEV;
-		goto out;
-	}
+	if (v != bdi->model)
+		return -ENODEV;
 
 	ret = bq24190_register_reset(bdi);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = bq24190_set_mode_host(bdi);
 	if (ret < 0)
-		goto out;
+		return ret;
 
-	ret = bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
-out:
-	pm_runtime_put_sync(bdi->dev);
-	return ret;
+	return bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 }
 
 #ifdef CONFIG_OF
@@ -1364,12 +1394,16 @@ static int bq24190_probe(struct i2c_client *client,
 	}
 
 	pm_runtime_enable(dev);
-	pm_runtime_resume(dev);
+	pm_runtime_set_autosuspend_delay(dev, 600);
+	pm_runtime_use_autosuspend(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto out1;
 
 	ret = bq24190_hw_init(bdi);
 	if (ret < 0) {
 		dev_err(dev, "Hardware init failed\n");
-		goto out1;
+		goto out2;
 	}
 
 	charger_cfg.drv_data = bdi;
@@ -1380,7 +1414,7 @@ static int bq24190_probe(struct i2c_client *client,
 	if (IS_ERR(bdi->charger)) {
 		dev_err(dev, "Can't register charger\n");
 		ret = PTR_ERR(bdi->charger);
-		goto out1;
+		goto out2;
 	}
 
 	battery_cfg.drv_data = bdi;
@@ -1389,13 +1423,13 @@ static int bq24190_probe(struct i2c_client *client,
 	if (IS_ERR(bdi->battery)) {
 		dev_err(dev, "Can't register battery\n");
 		ret = PTR_ERR(bdi->battery);
-		goto out2;
+		goto out3;
 	}
 
 	ret = bq24190_sysfs_create_group(bdi);
 	if (ret) {
 		dev_err(dev, "Can't create sysfs entries\n");
-		goto out3;
+		goto out4;
 	}
 
 	bdi->initialized = true;
@@ -1406,21 +1440,30 @@ static int bq24190_probe(struct i2c_client *client,
 			"bq24190-charger", bdi);
 	if (ret < 0) {
 		dev_err(dev, "Can't set up irq handler\n");
-		goto out4;
+		goto out5;
 	}
 
+	enable_irq_wake(bdi->irq);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
-out4:
+out5:
 	bq24190_sysfs_remove_group(bdi);
 
-out3:
+out4:
 	power_supply_unregister(bdi->battery);
 
-out2:
+out3:
 	power_supply_unregister(bdi->charger);
 
+out2:
+	pm_runtime_put_sync(dev);
+
 out1:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 	if (bdi->gpio_int)
 		gpio_free(bdi->gpio_int);
@@ -1431,13 +1474,17 @@ static int bq24190_remove(struct i2c_client *client)
 {
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 
-	pm_runtime_get_sync(bdi->dev);
-	bq24190_register_reset(bdi);
-	pm_runtime_put_sync(bdi->dev);
+	if (!pm_runtime_get_sync(bdi->dev)) {
+		bq24190_register_reset(bdi);
+		pm_runtime_put_sync(bdi->dev);
+	} else {
+		dev_warn(bdi->dev, "pm_runtime_get failed\n");
+	}
 
 	bq24190_sysfs_remove_group(bdi);
 	power_supply_unregister(bdi->battery);
 	power_supply_unregister(bdi->charger);
+	pm_runtime_dont_use_autosuspend(bdi->dev);
 	pm_runtime_disable(bdi->dev);
 
 	if (bdi->gpio_int)
@@ -1481,9 +1528,13 @@ static int bq24190_pm_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 
-	pm_runtime_get_sync(bdi->dev);
-	bq24190_register_reset(bdi);
-	pm_runtime_put_sync(bdi->dev);
+	if (!pm_runtime_get_sync(bdi->dev)) {
+		bq24190_register_reset(bdi);
+		pm_runtime_mark_last_busy(bdi->dev);
+		pm_runtime_put_autosuspend(bdi->dev);
+	} else {
+		dev_warn(bdi->dev, "pm_runtime_get failed\n");
+	}
 
 	return 0;
 }
@@ -1496,11 +1547,15 @@ static int bq24190_pm_resume(struct device *dev)
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
 
-	pm_runtime_get_sync(bdi->dev);
-	bq24190_register_reset(bdi);
-	bq24190_set_mode_host(bdi);
-	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
-	pm_runtime_put_sync(bdi->dev);
+	if (!pm_runtime_get_sync(bdi->dev)) {
+		bq24190_register_reset(bdi);
+		bq24190_set_mode_host(bdi);
+		bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
+		pm_runtime_mark_last_busy(bdi->dev);
+		pm_runtime_put_autosuspend(bdi->dev);
+	} else {
+		dev_warn(bdi->dev, "pm_runtime_get failed\n");
+	}
 
 	/* Things may have changed while suspended so alert upper layer */
 	power_supply_changed(bdi->charger);
-- 
2.11.0
