From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v4 1/6] power: twl4030-madc-battery: Convert to iio consumer.
Date: Tue, 10 Mar 2015 22:27:22 +0100
Message-ID: <1426022847-30912-2-git-send-email-marek@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426022847-30912-1-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Because of added iio error handling private data allocation was converted
to managed to simplify code.

Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Reviewed-By: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
---
 drivers/power/twl4030_madc_battery.c | 99 +++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 35 deletions(-)

diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl4030_madc_battery.c
index 7ef445a..6af28b5 100644
--- a/drivers/power/twl4030_madc_battery.c
+++ b/drivers/power/twl4030_madc_battery.c
@@ -19,10 +19,14 @@
 #include <linux/sort.h>
 #include <linux/i2c/twl4030-madc.h>
 #include <linux/power/twl4030_madc_battery.h>
+#include <linux/iio/consumer.h>
 
 struct twl4030_madc_battery {
 	struct power_supply psy;
 	struct twl4030_madc_bat_platform_data *pdata;
+	struct iio_channel *channel_temp;
+	struct iio_channel *channel_ichg;
+	struct iio_channel *channel_vbat;
 };
 
 static enum power_supply_property twl4030_madc_bat_props[] = {
@@ -38,43 +42,34 @@ static enum power_supply_property twl4030_madc_bat_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
 };
 
-static int madc_read(int index)
+static int madc_read(struct iio_channel *channel)
 {
-	struct twl4030_madc_request req;
-	int val;
+	int val, err;
+	err = iio_read_channel_processed(channel, &val);
+	if (err < 0)
+		return err;
 
-	req.channels = index;
-	req.method = TWL4030_MADC_SW2;
-	req.type = TWL4030_MADC_WAIT;
-	req.do_avg = 0;
-	req.raw = false;
-	req.func_cb = NULL;
-
-	val = twl4030_madc_conversion(&req);
-	if (val < 0)
-		return val;
-
-	return req.rbuf[ffs(index) - 1];
+	return val;
 }
 
-static int twl4030_madc_bat_get_charging_status(void)
+static int twl4030_madc_bat_get_charging_status(struct twl4030_madc_battery *bt)
 {
-	return (madc_read(TWL4030_MADC_ICHG) > 0) ? 1 : 0;
+	return (madc_read(bt->channel_ichg) > 0) ? 1 : 0;
 }
 
-static int twl4030_madc_bat_get_voltage(void)
+static int twl4030_madc_bat_get_voltage(struct twl4030_madc_battery *bt)
 {
-	return madc_read(TWL4030_MADC_VBAT);
+	return madc_read(bt->channel_vbat);
 }
 
-static int twl4030_madc_bat_get_current(void)
+static int twl4030_madc_bat_get_current(struct twl4030_madc_battery *bt)
 {
-	return madc_read(TWL4030_MADC_ICHG) * 1000;
+	return madc_read(bt->channel_ichg) * 1000;
 }
 
-static int twl4030_madc_bat_get_temp(void)
+static int twl4030_madc_bat_get_temp(struct twl4030_madc_battery *bt)
 {
-	return madc_read(TWL4030_MADC_BTEMP) * 10;
+	return madc_read(bt->channel_temp) * 10;
 }
 
 static int twl4030_madc_bat_voltscale(struct twl4030_madc_battery *bat,
@@ -84,7 +79,7 @@ static int twl4030_madc_bat_voltscale(struct twl4030_madc_battery *bat,
 	int i, res = 0;
 
 	/* choose charging curve */
-	if (twl4030_madc_bat_get_charging_status())
+	if (twl4030_madc_bat_get_charging_status(bat))
 		calibration = bat->pdata->charging;
 	else
 		calibration = bat->pdata->discharging;
@@ -119,23 +114,23 @@ static int twl4030_madc_bat_get_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		if (twl4030_madc_bat_voltscale(bat,
-				twl4030_madc_bat_get_voltage()) > 95)
+				twl4030_madc_bat_get_voltage(bat)) > 95)
 			val->intval = POWER_SUPPLY_STATUS_FULL;
 		else {
-			if (twl4030_madc_bat_get_charging_status())
+			if (twl4030_madc_bat_get_charging_status(bat))
 				val->intval = POWER_SUPPLY_STATUS_CHARGING;
 			else
 				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		}
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = twl4030_madc_bat_get_voltage() * 1000;
+		val->intval = twl4030_madc_bat_get_voltage(bat) * 1000;
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		val->intval = twl4030_madc_bat_get_current();
+		val->intval = twl4030_madc_bat_get_current(bat);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		/* assume battery is always present */
@@ -143,23 +138,23 @@ static int twl4030_madc_bat_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW: {
 			int percent = twl4030_madc_bat_voltscale(bat,
-					twl4030_madc_bat_get_voltage());
+					twl4030_madc_bat_get_voltage(bat));
 			val->intval = (percent * bat->pdata->capacity) / 100;
 			break;
 		}
 	case POWER_SUPPLY_PROP_CAPACITY:
 		val->intval = twl4030_madc_bat_voltscale(bat,
-					twl4030_madc_bat_get_voltage());
+					twl4030_madc_bat_get_voltage(bat));
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		val->intval = bat->pdata->capacity;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
-		val->intval = twl4030_madc_bat_get_temp();
+		val->intval = twl4030_madc_bat_get_temp(bat);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW: {
 			int percent = twl4030_madc_bat_voltscale(bat,
-					twl4030_madc_bat_get_voltage());
+					twl4030_madc_bat_get_voltage(bat));
 			/* in mAh */
 			int chg = (percent * (bat->pdata->capacity/1000))/100;
 
@@ -192,8 +187,10 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 {
 	struct twl4030_madc_battery *twl4030_madc_bat;
 	struct twl4030_madc_bat_platform_data *pdata = pdev->dev.platform_data;
+	int ret;
 
-	twl4030_madc_bat = kzalloc(sizeof(*twl4030_madc_bat), GFP_KERNEL);
+	twl4030_madc_bat = devm_kzalloc(&pdev->dev, sizeof(*twl4030_madc_bat),
+				GFP_KERNEL);
 	if (!twl4030_madc_bat)
 		return -ENOMEM;
 
@@ -206,6 +203,24 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 	twl4030_madc_bat->psy.external_power_changed =
 					twl4030_madc_bat_ext_changed;
 
+	twl4030_madc_bat->channel_temp = iio_channel_get(&pdev->dev, "temp");
+	if (IS_ERR(twl4030_madc_bat->channel_temp)) {
+		ret = PTR_ERR(twl4030_madc_bat->channel_temp);
+		goto err;
+	}
+
+	twl4030_madc_bat->channel_ichg  = iio_channel_get(&pdev->dev, "ichg");
+	if (IS_ERR(twl4030_madc_bat->channel_ichg)) {
+		ret = PTR_ERR(twl4030_madc_bat->channel_ichg);
+		goto err_temp;
+	}
+
+	twl4030_madc_bat->channel_vbat = iio_channel_get(&pdev->dev, "vbat");
+	if (IS_ERR(twl4030_madc_bat->channel_vbat)) {
+		ret = PTR_ERR(twl4030_madc_bat->channel_vbat);
+		goto err_ichg;
+	}
+
 	/* sort charging and discharging calibration data */
 	sort(pdata->charging, pdata->charging_size,
 		sizeof(struct twl4030_madc_bat_calibration),
@@ -216,9 +231,20 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 
 	twl4030_madc_bat->pdata = pdata;
 	platform_set_drvdata(pdev, twl4030_madc_bat);
-	power_supply_register(&pdev->dev, &twl4030_madc_bat->psy);
+	ret = power_supply_register(&pdev->dev, &twl4030_madc_bat->psy);
+	if (ret)
+		goto err_vbat;
 
 	return 0;
+
+err_vbat:
+	iio_channel_release(twl4030_madc_bat->channel_vbat);
+err_ichg:
+	iio_channel_release(twl4030_madc_bat->channel_ichg);
+err_temp:
+	iio_channel_release(twl4030_madc_bat->channel_temp);
+err:
+	return ret;
 }
 
 static int twl4030_madc_battery_remove(struct platform_device *pdev)
@@ -226,7 +252,10 @@ static int twl4030_madc_battery_remove(struct platform_device *pdev)
 	struct twl4030_madc_battery *bat = platform_get_drvdata(pdev);
 
 	power_supply_unregister(&bat->psy);
-	kfree(bat);
+
+	iio_channel_release(bat->channel_vbat);
+	iio_channel_release(bat->channel_ichg);
+	iio_channel_release(bat->channel_temp);
 
 	return 0;
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
