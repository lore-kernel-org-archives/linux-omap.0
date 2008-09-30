From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 22/25] twl4030: minor cleanups to twl4030_bci_battery.c
Date: Tue, 30 Sep 2008 21:43:06 +0300
Message-ID: <1222800189-29737-23-git-send-email-me@felipebalbi.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
 <1222800189-29737-2-git-send-email-me@felipebalbi.com>
 <1222800189-29737-3-git-send-email-me@felipebalbi.com>
 <1222800189-29737-4-git-send-email-me@felipebalbi.com>
 <1222800189-29737-5-git-send-email-me@felipebalbi.com>
 <1222800189-29737-6-git-send-email-me@felipebalbi.com>
 <1222800189-29737-7-git-send-email-me@felipebalbi.com>
 <1222800189-29737-8-git-send-email-me@felipebalbi.com>
 <1222800189-29737-9-git-send-email-me@felipebalbi.com>
 <1222800189-29737-10-git-send-email-me@felipebalbi.com>
 <1222800189-29737-11-git-send-email-me@felipebalbi.com>
 <1222800189-29737-12-git-send-email-me@felipebalbi.com>
 <1222800189-29737-13-git-send-email-me@felipebalbi.com>
 <1222800189-29737-14-git-send-email-me@felipebalbi.com>
 <1222800189-29737-15-git-send-email-me@felipebalbi.com>
 <1222800189-29737-16-git-send-email-me@felipebalbi.com>
 <1222800189-29737-17-git-send-email-me@felipebalbi.com>
 <1222800189-29737-18-git-send-email-me@felipebalbi.com>
 <1222800189-29737-19-git-send-email-me@felipebalbi.com>
 <1222800189-29737-20-git-send-email-me@felipebalbi.com>
 <1222800189-29737-21-git-send-email-me@felipebalbi.com>
 <1222800189-29737-22-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51718 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbYI3SqG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:46:06 -0400
In-Reply-To: <1222800189-29737-22-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Brainless fixes, checkpatch.pl fixes, variable naming,
etc.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/power/twl4030_bci_battery.c |  161 ++++++++++++++++-------------------
 1 files changed, 75 insertions(+), 86 deletions(-)

diff --git a/drivers/power/twl4030_bci_battery.c b/drivers/power/twl4030_bci_battery.c
index 6a55838..9ab6127 100644
--- a/drivers/power/twl4030_bci_battery.c
+++ b/drivers/power/twl4030_bci_battery.c
@@ -42,8 +42,8 @@
 #define REG_PHY_CLK_CTRL_STS	0x0FF
 #define PHY_DPLL_CLK		0x01
 
-#define REG_BCICTL1 		0x023
-#define REG_BCICTL2 		0x024
+#define REG_BCICTL1		0x023
+#define REG_BCICTL2		0x024
 #define CGAIN			0x020
 #define ITHEN			0x010
 #define ITHSENS			0x007
@@ -70,7 +70,7 @@
 #define REG_BCIMSTATEC		0x02
 #define REG_BCIMFSTS4		0x010
 #define REG_BCIMFSTS2		0x00E
-#define REG_BCIMFSTS3 		0x00F
+#define REG_BCIMFSTS3		0x00F
 #define REG_BCIMFSTS1		0x001
 #define USBFASTMCHG		0x004
 #define BATSTSPCHG		0x004
@@ -99,8 +99,8 @@
 #define COR			0x004
 
 /* interrupt status registers */
-#define REG_BCIISR1A 		0x0
-#define REG_BCIISR2A 		0x01
+#define REG_BCIISR1A		0x0
+#define REG_BCIISR2A		0x01
 
 /* Interrupt flags bits BCIISR1 */
 #define BATSTS_ISR1		0x080
@@ -146,14 +146,6 @@
 /* Ptr to thermistor table */
 int *therm_tbl;
 
-static int twl4030_bci_battery_probe(struct platform_device *dev);
-static int twl4030_bci_battery_remove(struct platform_device *dev);
-#ifdef CONFIG_PM
-static int twl4030_bci_battery_suspend(struct platform_device *dev,
-					pm_message_t state);
-static int twl4030_bci_battery_resume(struct platform_device *dev);
-#endif
-
 struct twl4030_bci_device_info {
 	struct device		*dev;
 
@@ -171,18 +163,6 @@ struct twl4030_bci_device_info {
 	struct delayed_work	twl4030_bk_bci_monitor_work;
 };
 
-static struct platform_driver twl4030_bci_battery_driver = {
-	.probe =	twl4030_bci_battery_probe,
-	.remove =	twl4030_bci_battery_remove,
-#ifdef CONFIG_PM
-	.suspend =	twl4030_bci_battery_suspend,
-	.resume =	twl4030_bci_battery_resume,
-#endif
-	.driver = {
-		.name = "twl4030-bci-battery",
-	},
-};
-
 static int usb_charger_flag;
 static int LVL_1, LVL_2, LVL_3, LVL_4;
 
@@ -204,14 +184,11 @@ static inline int twl4030charger_presence_evt(void)
 	if (ret)
 		return IRQ_NONE;
 
-	/* If the AC charger have been connected */
-	if (chg_sts & STS_CHG) {
+	if (chg_sts & STS_CHG) { /* If the AC charger have been connected */
 		/* configuring falling edge detection for CHG_PRES */
 		set = CHG_PRES_FALLING;
 		clear = CHG_PRES_RISING;
-	}
-	/* If the AC charger have been disconnected */
-	else {
+	} else { /* If the AC charger have been disconnected */
 		/* configuring rising edge detection for CHG_PRES */
 		set = CHG_PRES_RISING;
 		clear = CHG_PRES_FALLING;
@@ -230,9 +207,9 @@ static inline int twl4030charger_presence_evt(void)
  * USB_PRES (USB charger presence) CHG_PRES (AC charger presence) events
  *
  */
-static irqreturn_t twl4030charger_interrupt(int irq, void *dev_id)
+static irqreturn_t twl4030charger_interrupt(int irq, void *_di)
 {
-	struct twl4030_bci_device_info *di = dev_id;
+	struct twl4030_bci_device_info *di = _di;
 
 	twl4030charger_presence_evt();
 	power_supply_changed(&di->bat);
@@ -264,17 +241,14 @@ static int twl4030battery_presence_evt(void)
 	 * REVISIT: Physically inserting/removing the batt
 	 * does not seem to generate an int on 3430ES2 SDP.
 	 */
-
-	/* In case of the battery insertion event */
 	if ((batstspchg & BATSTSPCHG) || (batstsmchg & BATSTSMCHG)) {
+		/* In case of the battery insertion event */
 		ret = clear_n_set(TWL4030_MODULE_INTERRUPTS, BATSTS_EDRRISIN,
 			BATSTS_EDRFALLING, REG_BCIEDR2);
 		if (ret)
 			return ret;
-	}
-
-	/* In case of the battery removal event */
-	else {
+	} else {
+		/* In case of the battery removal event */
 		ret = clear_n_set(TWL4030_MODULE_INTERRUPTS, BATSTS_EDRFALLING,
 			BATSTS_EDRRISIN, REG_BCIEDR2);
 		if (ret)
@@ -298,18 +272,27 @@ static int twl4030battery_level_evt(void)
 	if (ret)
 		return ret;
 
+	/* REVISIT could use a bitmap */
 	if (mfst & VBATOV4) {
 		LVL_4 = 1;
-		LVL_3 = LVL_2 = LVL_1 = 0;
+		LVL_3 = 0;
+		LVL_2 = 0;
+		LVL_1 = 0;
 	} else if (mfst & VBATOV3) {
+		LVL_4 = 0;
 		LVL_3 = 1;
-		LVL_4 = LVL_2 = LVL_1 = 0;
+		LVL_2 = 0;
+		LVL_1 = 0;
 	} else if (mfst & VBATOV2) {
+		LVL_4 = 0;
+		LVL_3 = 0;
 		LVL_2 = 1;
-		LVL_4 = LVL_3 = LVL_1 = 0;
+		LVL_1 = 0;
 	} else {
+		LVL_4 = 0;
+		LVL_3 = 0;
+		LVL_2 = 0;
 		LVL_1 = 1;
-		LVL_4 = LVL_3 = LVL_2 = 0;
 	}
 
 	return 0;
@@ -323,10 +306,10 @@ static int twl4030battery_level_evt(void)
  * VBATOV (main battery voltage threshold) events
  *
  */
-static irqreturn_t twl4030battery_interrupt(int irq, void *dev_id)
+static irqreturn_t twl4030battery_interrupt(int irq, void *_di)
 {
-	int ret;
 	u8 isr1a_val, isr2a_val, clear_2a, clear_1a;
+	int ret;
 
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_INTERRUPTS, &isr1a_val,
 				REG_BCIISR1A);
@@ -338,8 +321,8 @@ static irqreturn_t twl4030battery_interrupt(int irq, void *dev_id)
 	if (ret)
 		return IRQ_NONE;
 
-	clear_2a = (isr2a_val & VBATLVL_ISR1)? (VBATLVL_ISR1): 0;
-	clear_1a = (isr1a_val & BATSTS_ISR1)? (BATSTS_ISR1): 0;
+	clear_2a = (isr2a_val & VBATLVL_ISR1) ? (VBATLVL_ISR1) : 0;
+	clear_1a = (isr1a_val & BATSTS_ISR1) ? (BATSTS_ISR1) : 0;
 
 	/* cleaning BCI interrupt status flags */
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS,
@@ -446,6 +429,7 @@ static int twl4030charger_ac_en(int enable)
 		if (ret)
 			return ret;
 	}
+
 	return 0;
 }
 
@@ -544,7 +528,7 @@ static int twl4030battery_temperature(void)
 
 	/*calculating temperature*/
 	for (temp = 58; temp >= 0; temp--) {
-		int actual = therm_tbl [temp];
+		int actual = therm_tbl[temp];
 		if ((actual - res) >= 0)
 			break;
 	}
@@ -631,12 +615,12 @@ static int twl4030charger_presence(void)
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &hwsts,
 		REG_STS_HW_CONDITIONS);
 	if (ret) {
-		pr_err("BATTERY DRIVER: error reading STS_HW_CONDITIONS \n");
+		pr_err("twl4030_bci: error reading STS_HW_CONDITIONS\n");
 		return ret;
 	}
 
-	ret = (hwsts & STS_CHG)? AC_PW_CONN: NO_PW_CONN;
-	ret += (hwsts & STS_VBUS)? USB_PW_CONN: NO_PW_CONN;
+	ret = (hwsts & STS_CHG) ? AC_PW_CONN : NO_PW_CONN;
+	ret += (hwsts & STS_VBUS) ? USB_PW_CONN : NO_PW_CONN;
 
 	if (ret & USB_PW_CONN)
 		usb_charger_flag = 1;
@@ -659,7 +643,7 @@ static int twl4030bci_status(void)
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
 		&status, REG_BCIMSTATEC);
 	if (ret) {
-		pr_err("BATTERY DRIVER: error reading BCIMSTATEC \n");
+		pr_err("twl4030_bci: error reading BCIMSTATEC\n");
 		return ret;
 	}
 
@@ -905,11 +889,11 @@ static char *twl4030_bci_supplied_to[] = {
 	"twl4030_bci_battery",
 };
 
-static int twl4030_bci_battery_probe(struct  platform_device *dev)
+static int __init twl4030_bci_battery_probe(struct platform_device *pdev)
 {
+	struct twl4030_bci_platform_data *pdata = pdev->dev.platform_data;
 	struct twl4030_bci_device_info *di;
 	int ret;
-	struct twl4030_bci_platform_data *pdata = dev->dev.platform_data;
 
 	therm_tbl = pdata->battery_tmp_tbl;
 
@@ -917,9 +901,7 @@ static int twl4030_bci_battery_probe(struct  platform_device *dev)
 	if (!di)
 		return -ENOMEM;
 
-	platform_set_drvdata(dev, di);
-
-	di->dev = &dev->dev;
+	di->dev = &pdev->dev;
 	di->bat.name = "twl4030_bci_battery";
 	di->bat.supplied_to = twl4030_bci_supplied_to;
 	di->bat.num_supplicants = ARRAY_SIZE(twl4030_bci_supplied_to);
@@ -944,6 +926,8 @@ static int twl4030_bci_battery_probe(struct  platform_device *dev)
 	twl4030battery_hw_level_en(ENABLE);
 	twl4030battery_hw_presence_en(ENABLE);
 
+	platform_set_drvdata(pdev, di);
+
 	/* settings for temperature sensing */
 	ret = twl4030battery_temp_setup();
 	if (ret)
@@ -956,26 +940,26 @@ static int twl4030_bci_battery_probe(struct  platform_device *dev)
 
 	/* request BCI interruption */
 	ret = request_irq(TWL4030_MODIRQ_BCI, twl4030battery_interrupt,
-		IRQF_DISABLED, dev->name, NULL);
+		IRQF_DISABLED, pdev->name, NULL);
 	if (ret) {
-		pr_err("BATTERY DRIVER: (BCI) IRQ%d is not free.\n",
-			TWL4030_MODIRQ_PWR);
+		dev_dbg(&pdev->dev, "could not request irq %d, status %d\n",
+			TWL4030_MODIRQ_BCI, ret);
 		goto batt_irq_fail;
 	}
 
 	/* request Power interruption */
 	ret = request_irq(TWL4030_PWRIRQ_CHG_PRES, twl4030charger_interrupt,
-		0, dev->name, di);
+		0, pdev->name, di);
 
 	if (ret) {
-		pr_err("BATTERY DRIVER: (POWER) IRQ%d is not free.\n",
-			TWL4030_MODIRQ_PWR);
+		dev_dbg(&pdev->dev, "could not request irq %d, status %d\n",
+			TWL4030_PWRIRQ_CHG_PRES, ret);
 		goto chg_irq_fail;
 	}
 
 	ret = power_supply_register(&dev->dev, &di->bat);
 	if (ret) {
-		pr_err("BATTERY DRIVER: failed to register main battery\n");
+		dev_dbg(&pdev->dev, "failed to register main battery\n");
 		goto batt_failed;
 	}
 
@@ -983,9 +967,9 @@ static int twl4030_bci_battery_probe(struct  platform_device *dev)
 				twl4030_bci_battery_work);
 	schedule_delayed_work(&di->twl4030_bci_monitor_work, 0);
 
-	ret = power_supply_register(&dev->dev, &di->bk_bat);
+	ret = power_supply_register(&pdev->dev, &di->bk_bat);
 	if (ret) {
-		pr_err("BATTERY DRIVER: failed to register backup battery\n");
+		dev_dbg(&pdev->dev, "failed to register backup battery\n");
 		goto bk_batt_failed;
 	}
 
@@ -1014,9 +998,9 @@ temp_setup_fail:
 	return ret;
 }
 
-static int twl4030_bci_battery_remove(struct  platform_device *dev)
+static int __exit twl4030_bci_battery_remove(struct platform_device *pdev)
 {
-	struct twl4030_bci_device_info *di = platform_get_drvdata(dev);
+	struct twl4030_bci_device_info *di = platform_get_drvdata(pdev);
 
 	twl4030charger_ac_en(DISABLE);
 	twl4030charger_usb_en(DISABLE);
@@ -1029,17 +1013,17 @@ static int twl4030_bci_battery_remove(struct  platform_device *dev)
 	flush_scheduled_work();
 	power_supply_unregister(&di->bat);
 	power_supply_unregister(&di->bk_bat);
-	platform_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 	kfree(di);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int twl4030_bci_battery_suspend(struct platform_device *dev,
+static int twl4030_bci_battery_suspend(struct platform_device *pdev,
 	pm_message_t state)
 {
-	struct twl4030_bci_device_info *di = platform_get_drvdata(dev);
+	struct twl4030_bci_device_info *di = platform_get_drvdata(pdev);
 
 	di->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
 	cancel_delayed_work(&di->twl4030_bci_monitor_work);
@@ -1047,37 +1031,42 @@ static int twl4030_bci_battery_suspend(struct platform_device *dev,
 	return 0;
 }
 
-static int twl4030_bci_battery_resume(struct platform_device *dev)
+static int twl4030_bci_battery_resume(struct platform_device *pdev)
 {
-	struct twl4030_bci_device_info *di = platform_get_drvdata(dev);
+	struct twl4030_bci_device_info *di = platform_get_drvdata(pdev);
 
 	schedule_delayed_work(&di->twl4030_bci_monitor_work, 0);
 	schedule_delayed_work(&di->twl4030_bk_bci_monitor_work, 50);
 	return 0;
 }
+#else
+#define twl4030_bci_battery_suspend	NULL
+#define twl4030_bci_battery_resume	NULL
 #endif /* CONFIG_PM */
 
-/*
- * Battery driver module initializer function
- * registers battery driver structure
- */
+static struct platform_driver twl4030_bci_battery_driver = {
+	.probe		= twl4030_bci_battery_probe,
+	.remove		= __exit_p(twl4030_bci_battery_remove),
+	.suspend	= twl4030_bci_battery_suspend,
+	.resume		= twl4030_bci_battery_resume,
+	.driver		= {
+		.name	= "twl4030_bci",
+	},
+};
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:twl4030_bci");
+MODULE_AUTHOR("Texas Instruments Inc");
+
 static int __init twl4030_battery_init(void)
 {
 	return platform_driver_register(&twl4030_bci_battery_driver);
-
 }
+module_init(twl4030_battery_init);
 
-/*
- * Battery driver module exit function
- * unregister battery driver structure
- */
 static void __exit twl4030_battery_exit(void)
 {
 	platform_driver_unregister(&twl4030_bci_battery_driver);
 }
-
-module_init(twl4030_battery_init);
 module_exit(twl4030_battery_exit);
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("twl4030_bci_battery");
-MODULE_AUTHOR("Texas Instruments Inc");
+
-- 
1.6.0.1.196.g01914

