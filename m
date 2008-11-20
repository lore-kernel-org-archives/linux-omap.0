From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc5 2/5] twl4030 BCI irq and dependencies
Date: Wed, 19 Nov 2008 17:27:36 -0800
Message-ID: <200811191727.37105.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:25972 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752580AbYKTBek (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 20:34:40 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Disable the TWL4030_MODIRQ_BCI symbol and remove all its uses.
It's not needed any more now that platform_get_irq() works for
these BCI devices.

Also remove inappropriate board-specific Kconfig dependencies.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/power/Kconfig               |    3 +--
 drivers/power/twl4030_bci_battery.c |   18 +++++++++++-------
 include/linux/i2c/twl4030.h         |    2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -58,8 +58,7 @@ config BATTERY_TOSA
 
 config TWL4030_BCI_BATTERY
 	tristate "OMAP TWL4030 BCI Battery driver"
-	depends on (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP || MACH_OMAP_LDP) && TWL4030_MADC
-	default y
+	depends on TWL4030_CORE && TWL4030_MADC
 	help
 	  Support for OMAP TWL4030 BCI Battery driver.
 	  This driver can give support for TWL4030 Battery Charge Interface.
--- a/drivers/power/twl4030_bci_battery.c
+++ b/drivers/power/twl4030_bci_battery.c
@@ -958,17 +958,17 @@ static int __init twl4030_bci_battery_pr
 	/* REVISIT do we need to request both IRQs ?? */
 
 	/* request BCI interruption */
-	ret = request_irq(TWL4030_MODIRQ_BCI, twl4030battery_interrupt,
+	irq = platform_get_irq(pdev, 1);
+	ret = request_irq(irq, twl4030battery_interrupt,
 		0, pdev->name, NULL);
 	if (ret) {
 		dev_dbg(&pdev->dev, "could not request irq %d, status %d\n",
-			TWL4030_MODIRQ_BCI, ret);
+			irq, ret);
 		goto batt_irq_fail;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-
 	/* request Power interruption */
+	irq = platform_get_irq(pdev, 0);
 	ret = request_irq(irq, twl4030charger_interrupt,
 		0, pdev->name, di);
 
@@ -1005,7 +1005,8 @@ bk_batt_failed:
 batt_failed:
 	free_irq(irq, di);
 chg_irq_fail:
-	free_irq(TWL4030_MODIRQ_BCI, NULL);
+	irq = platform_get_irq(pdev, 1);
+	free_irq(irq, NULL);
 batt_irq_fail:
 voltage_setup_fail:
 temp_setup_fail:
@@ -1021,16 +1022,19 @@ temp_setup_fail:
 static int __exit twl4030_bci_battery_remove(struct platform_device *pdev)
 {
 	struct twl4030_bci_device_info *di = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
+	int irq;
 
 	twl4030charger_ac_en(DISABLE);
 	twl4030charger_usb_en(DISABLE);
 	twl4030battery_hw_level_en(DISABLE);
 	twl4030battery_hw_presence_en(DISABLE);
 
-	free_irq(TWL4030_MODIRQ_BCI, NULL);
+	irq = platform_get_irq(pdev, 0);
 	free_irq(irq, di);
 
+	irq = platform_get_irq(pdev, 1);
+	free_irq(irq, NULL);
+
 	flush_scheduled_work();
 	power_supply_unregister(&di->bat);
 	power_supply_unregister(&di->bk_bat);
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -374,7 +374,7 @@ int twl4030_sih_setup(int module);
 
 /* #define TWL4030_MODIRQ_GPIO		(TWL4030_IRQ_BASE + 0) */
 /* #define TWL4030_MODIRQ_KEYPAD		(TWL4030_IRQ_BASE + 1) */
-#define TWL4030_MODIRQ_BCI		(TWL4030_IRQ_BASE + 2)
+/* #define TWL4030_MODIRQ_BCI		(TWL4030_IRQ_BASE + 2) */
 #define TWL4030_MODIRQ_MADC		(TWL4030_IRQ_BASE + 3)
 /* #define TWL4030_MODIRQ_USB		(TWL4030_IRQ_BASE + 4) */
 /* #define TWL4030_MODIRQ_PWR		(TWL4030_IRQ_BASE + 5) */
