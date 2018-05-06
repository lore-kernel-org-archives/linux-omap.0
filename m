From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] phy: mapphone-mdm6600: Add runtime PM support for n_gsm on USB suspend
Date: Sun,  6 May 2018 09:48:25 -0700
Message-ID: <20180506164825.82294-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

We can suspend the mdm6600 over USB via sysfs and then mdm6600 enters
a low-power idle mode. In the low-power mode, mdm6600 radio and n_gsm
uart are functional but we need to use USB mode0 GPIO pin to send a
wake-up pulse to the modem to talk with it over n_gsm.

As the GPIO mode0 line is dual purposed and and also needed by the
USB PHY driver to boot mdm6600 into the correct USB mode, let's also
manage the wake-up GPIO in the USB PHY driver. For the USB PHY idle,
there does not anything specific we need to do for runtime PM after
getting the PHY configured. The PHY framework already idles the USB
PHY when not in use separately from the mdm6600 state.

It seems that it takes about 100 - 200ms for mdm6600 to wake up from
the low-power idle mode. And then mdm6600 stays awake about 1.2s until
it needs to be kicked again. The mdm6600 status GPIO pins don't seem
to change state when mdm6600 changes between normal and idle mode.

Let's manage the mdm6600 mode with runtime PM. If phy-mapphone-mdm6600
sysfs entry for power/control is set to "on", we keep mdm6600 out of
idle by kicking the GPIO line. If the entry is set to "auto" we let
mdm6600 enter low-power state.

Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Scott <hashcode0f@gmail.com>
Cc: NeKit <nekit1000@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 85 +++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -19,6 +19,8 @@
 
 #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
 #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
+#define MDM6600_MODEM_IDLE_DELAY_MS	1000	/* modem after USB suspend */
+#define MDM6600_MODEM_WAKE_DELAY_MS	200	/* modem response after idle */
 
 enum phy_mdm6600_ctrl_lines {
 	PHY_MDM6600_ENABLE,			/* USB PHY enable */
@@ -93,9 +95,11 @@ struct phy_mdm6600 {
 	struct gpio_descs *cmd_gpios;
 	struct delayed_work bootup_work;
 	struct delayed_work status_work;
+	struct delayed_work modem_wake_work;
 	struct completion ack;
 	bool enabled;				/* mdm6600 phy enabled */
 	bool running;				/* mdm6600 boot done */
+	bool awake;				/* mdm6600 respnds on n_gsm */
 	int status;
 };
 
@@ -446,6 +450,62 @@ static void phy_mdm6600_deferred_power_on(struct work_struct *work)
 		dev_err(ddata->dev, "Device not functional\n");
 }
 
+/*
+ * USB suspend puts mdm6600 into low power mode. For any n_gsm using apps,
+ * we need to keep the modem awake by kicking it's mode0 GPIO. This will
+ * keep the modem awake for about 1.2 seconds. When no n_gsm apps are using
+ * the modem, runtime PM auto mode can be enabled so modem can enter low
+ * power mode.
+ */
+static void phy_mdm6600_wake_modem(struct phy_mdm6600 *ddata)
+{
+	struct gpio_desc *mode_gpio0;
+
+	mode_gpio0 = ddata->mode_gpios->desc[PHY_MDM6600_MODE0];
+	gpiod_set_value_cansleep(mode_gpio0, 1);
+	usleep_range(5, 15);
+	gpiod_set_value_cansleep(mode_gpio0, 0);
+	if (ddata->awake)
+		usleep_range(5, 15);
+	else
+		msleep(MDM6600_MODEM_WAKE_DELAY_MS);
+}
+
+static void phy_mdm6600_modem_wake(struct work_struct *work)
+{
+	struct phy_mdm6600 *ddata;
+
+	ddata = container_of(work, struct phy_mdm6600, modem_wake_work.work);
+	phy_mdm6600_wake_modem(ddata);
+	schedule_delayed_work(&ddata->modem_wake_work,
+			      msecs_to_jiffies(MDM6600_MODEM_IDLE_DELAY_MS));
+}
+
+static int __maybe_unused phy_mdm6600_runtime_suspend(struct device *dev)
+{
+	struct phy_mdm6600 *ddata = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&ddata->modem_wake_work);
+	ddata->awake = false;
+
+	return 0;
+}
+
+static int __maybe_unused phy_mdm6600_runtime_resume(struct device *dev)
+{
+	struct phy_mdm6600 *ddata = dev_get_drvdata(dev);
+
+	phy_mdm6600_modem_wake(&ddata->modem_wake_work.work);
+	ddata->awake = true;
+
+	return 0;
+}
+
+static const struct dev_pm_ops phy_mdm6600_pm_ops = {
+	SET_RUNTIME_PM_OPS(phy_mdm6600_runtime_suspend,
+			   phy_mdm6600_runtime_resume, NULL)
+};
+
 static const struct of_device_id phy_mdm6600_id_table[] = {
 	{ .compatible = "motorola,mapphone-mdm6600", },
 	{},
@@ -464,6 +524,7 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&ddata->bootup_work,
 			  phy_mdm6600_deferred_power_on);
 	INIT_DELAYED_WORK(&ddata->status_work, phy_mdm6600_status);
+	INIT_DELAYED_WORK(&ddata->modem_wake_work, phy_mdm6600_modem_wake);
 	init_completion(&ddata->ack);
 
 	ddata->dev = &pdev->dev;
@@ -500,6 +561,24 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 	 */
 	msleep(PHY_MDM6600_PHY_DELAY_MS + 500);
 
+	/*
+	 * Enable PM runtime only after PHY has been powered up properly.
+	 * It is currently only needed after USB suspends mdm6600 and n_gsm
+	 * needs to access the device. We don't want to do this earlier as
+	 * gpio mode0 pin doubles as mdm6600 wake-up gpio.
+	 */
+	pm_runtime_use_autosuspend(ddata->dev);
+	pm_runtime_set_autosuspend_delay(ddata->dev,
+					 MDM6600_MODEM_IDLE_DELAY_MS);
+	pm_runtime_enable(ddata->dev);
+	error = pm_runtime_get_sync(ddata->dev);
+	if (error < 0) {
+		dev_warn(ddata->dev, "failed to wake modem: %i\n", error);
+		pm_runtime_put_noidle(ddata->dev);
+	}
+	pm_runtime_mark_last_busy(ddata->dev);
+	pm_runtime_put_autosuspend(ddata->dev);
+
 	return 0;
 
 cleanup:
@@ -512,6 +591,10 @@ static int phy_mdm6600_remove(struct platform_device *pdev)
 	struct phy_mdm6600 *ddata = platform_get_drvdata(pdev);
 	struct gpio_desc *reset_gpio = ddata->ctrl_gpios[PHY_MDM6600_RESET];
 
+	pm_runtime_dont_use_autosuspend(ddata->dev);
+	pm_runtime_put_sync(ddata->dev);
+	pm_runtime_disable(ddata->dev);
+
 	if (!ddata->running)
 		wait_for_completion_timeout(&ddata->ack,
 			msecs_to_jiffies(PHY_MDM6600_ENABLED_DELAY_MS));
@@ -519,6 +602,7 @@ static int phy_mdm6600_remove(struct platform_device *pdev)
 	gpiod_set_value_cansleep(reset_gpio, 1);
 	phy_mdm6600_device_power_off(ddata);
 
+	cancel_delayed_work_sync(&ddata->modem_wake_work);
 	cancel_delayed_work_sync(&ddata->bootup_work);
 	cancel_delayed_work_sync(&ddata->status_work);
 
@@ -530,6 +614,7 @@ static struct platform_driver phy_mdm6600_driver = {
 	.remove = phy_mdm6600_remove,
 	.driver = {
 		.name = "phy-mapphone-mdm6600",
+		.pm = &phy_mdm6600_pm_ops,
 		.of_match_table = of_match_ptr(phy_mdm6600_id_table),
 	},
 };
-- 
2.17.0
