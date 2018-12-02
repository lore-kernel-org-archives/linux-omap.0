From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2] phy: mapphone-mdm6600: Improve phy related runtime PM calls
Date: Sun,  2 Dec 2018 15:51:35 -0800
Message-ID: <20181202235135.29686-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Johan Hovold <jhovold@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

I noticed that phy_pm_runtime_get_sync() and phy_pm_runtime_put() are not
currently doing anything for phy-mapphone-mdm6600, only the sysfs interface
for works for "auto" and "on".

This is because of the shared GPIO pins between mdm6600 USB port and n_gsm
port. We have not enabled runtime PM for the phy driver until after we've
booted up mdm6600 properly to the USB mode. Otherwise phy_create() would
have called pm_runtime_enable() and pm_runtime_no_callbacks() automatically
on init.

Let's fix this by registering the phy a bit later after we've powered up
the mdm6600 USB port.

And as the PM runtime support is only needed for the n_gsm mode and not for
USB, we can allow the device to idle between phy_mdm6600_power_on() and
phy_mdm6600_power_off(). Note that for suspend, runtime_pm is already
disabled for the phy so we need to check for pm_runtime_enabled().

Cc: Johan Hovold <jhovold@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
Changes since v1:

- Drop a patch for phy_pm_runtime_enabled(), that's not needed for phy
  consumer drivers
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 71 +++++++++++++++------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
+#include <linux/pinctrl/consumer.h>
 
 #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
 #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
@@ -120,12 +121,22 @@ static int phy_mdm6600_power_on(struct phy *x)
 {
 	struct phy_mdm6600 *ddata = phy_get_drvdata(x);
 	struct gpio_desc *enable_gpio = ddata->ctrl_gpios[PHY_MDM6600_ENABLE];
+	int error;
 
 	if (!ddata->enabled)
 		return -ENODEV;
 
+	error = pinctrl_pm_select_default_state(ddata->dev);
+	if (error)
+		dev_warn(ddata->dev, "%s: error with default_state: %i\n",
+			 __func__, error);
+
 	gpiod_set_value_cansleep(enable_gpio, 1);
 
+	/* Allow aggressive PM for USB, it's only needed for n_gsm port */
+	if (pm_runtime_enabled(&x->dev))
+		phy_pm_runtime_put(x);
+
 	return 0;
 }
 
@@ -133,12 +144,26 @@ static int phy_mdm6600_power_off(struct phy *x)
 {
 	struct phy_mdm6600 *ddata = phy_get_drvdata(x);
 	struct gpio_desc *enable_gpio = ddata->ctrl_gpios[PHY_MDM6600_ENABLE];
+	int error;
 
 	if (!ddata->enabled)
 		return -ENODEV;
 
+	/* Paired with phy_pm_runtime_put() in phy_mdm6600_power_on() */
+	if (pm_runtime_enabled(&x->dev)) {
+		error = phy_pm_runtime_get(x);
+		if (error < 0 && error != -EINPROGRESS)
+			dev_warn(ddata->dev, "%s: phy_pm_runtime_get: %i\n",
+				 __func__, error);
+	}
+
 	gpiod_set_value_cansleep(enable_gpio, 0);
 
+	error = pinctrl_pm_select_sleep_state(ddata->dev);
+	if (error)
+		dev_warn(ddata->dev, "%s: error with sleep_state: %i\n",
+			 __func__, error);
+
 	return 0;
 }
 
@@ -529,28 +554,17 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	ddata->dev = &pdev->dev;
 	platform_set_drvdata(pdev, ddata);
 
+	/* Active state selected in phy_mdm6600_power_on() */
+	error = pinctrl_pm_select_sleep_state(ddata->dev);
+	if (error)
+		dev_warn(ddata->dev, "%s: error with sleep_state: %i\n",
+			 __func__, error);
+
 	error = phy_mdm6600_init_lines(ddata);
 	if (error)
 		return error;
 
 	phy_mdm6600_init_irq(ddata);
-
-	ddata->generic_phy = devm_phy_create(ddata->dev, NULL, &gpio_usb_ops);
-	if (IS_ERR(ddata->generic_phy)) {
-		error = PTR_ERR(ddata->generic_phy);
-		goto cleanup;
-	}
-
-	phy_set_drvdata(ddata->generic_phy, ddata);
-
-	ddata->phy_provider =
-		devm_of_phy_provider_register(ddata->dev,
-					      of_phy_simple_xlate);
-	if (IS_ERR(ddata->phy_provider)) {
-		error = PTR_ERR(ddata->phy_provider);
-		goto cleanup;
-	}
-
 	schedule_delayed_work(&ddata->bootup_work, 0);
 
 	/*
@@ -574,14 +588,31 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	if (error < 0) {
 		dev_warn(ddata->dev, "failed to wake modem: %i\n", error);
 		pm_runtime_put_noidle(ddata->dev);
+		goto cleanup;
 	}
+
+	ddata->generic_phy = devm_phy_create(ddata->dev, NULL, &gpio_usb_ops);
+	if (IS_ERR(ddata->generic_phy)) {
+		error = PTR_ERR(ddata->generic_phy);
+		goto idle;
+	}
+
+	phy_set_drvdata(ddata->generic_phy, ddata);
+
+	ddata->phy_provider =
+		devm_of_phy_provider_register(ddata->dev,
+					      of_phy_simple_xlate);
+	if (IS_ERR(ddata->phy_provider))
+		error = PTR_ERR(ddata->phy_provider);
+
+idle:
 	pm_runtime_mark_last_busy(ddata->dev);
 	pm_runtime_put_autosuspend(ddata->dev);
 
-	return 0;
-
 cleanup:
-	phy_mdm6600_device_power_off(ddata);
+	if (error < 0)
+		phy_mdm6600_device_power_off(ddata);
+
 	return error;
 }
 
-- 
2.19.2
