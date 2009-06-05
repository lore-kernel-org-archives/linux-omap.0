From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/07] arm: rework omap suspend_late()/resume_early()
Date: Fri, 05 Jun 2009 16:54:45 +0900
Message-ID: <20090605075445.14756.83985.sendpatchset@rx1.opensource.se>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:33932 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbZFEH6D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 03:58:03 -0400
Received: by rv-out-0506.google.com with SMTP id f9so604462rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 00:58:06 -0700 (PDT)
In-Reply-To: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: ben-linux@fluff.org, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, gregkh@suse.de, rjw@sisk.pl, stern@rowland.harvard.edu, pavel@ucw.cz, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

This patch reworks platform driver power management code
for omap drivers using late/early legacy callbacks.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested but compiles just fine.

 arch/arm/plat-omap/debug-leds.c |   11 +++++++----
 arch/arm/plat-omap/gpio.c       |   14 ++++++++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

--- 0001/arch/arm/plat-omap/debug-leds.c
+++ work/arch/arm/plat-omap/debug-leds.c	2009-06-01 15:50:21.000000000 +0900
@@ -281,24 +281,27 @@ static int /* __init */ fpga_probe(struc
 	return 0;
 }
 
-static int fpga_suspend_late(struct platform_device *pdev, pm_message_t mesg)
+static int fpga_suspend_noirq(struct device *dev)
 {
 	__raw_writew(~0, &fpga->leds);
 	return 0;
 }
 
-static int fpga_resume_early(struct platform_device *pdev)
+static int fpga_resume_noirq(struct device *dev)
 {
 	__raw_writew(~hw_led_state, &fpga->leds);
 	return 0;
 }
 
+static struct dev_pm_ops fpga_dev_pm_ops = {
+	.suspend_noirq = fpga_suspend_noirq,
+	.resume_noirq = fpga_resume_noirq,
+};
 
 static struct platform_driver led_driver = {
 	.driver.name	= "omap_dbg_led",
+	.driver.pm	= &fpga_dev_pm_ops,
 	.probe		= fpga_probe,
-	.suspend_late	= fpga_suspend_late,
-	.resume_early	= fpga_resume_early,
 };
 
 static int __init fpga_init(void)
--- 0001/arch/arm/plat-omap/gpio.c
+++ work/arch/arm/plat-omap/gpio.c	2009-06-01 16:30:56.000000000 +0900
@@ -1264,8 +1264,9 @@ static struct irq_chip mpuio_irq_chip = 
 
 #include <linux/platform_device.h>
 
-static int omap_mpuio_suspend_late(struct platform_device *pdev, pm_message_t mesg)
+static int omap_mpuio_suspend_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank	*bank = platform_get_drvdata(pdev);
 	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
 	unsigned long		flags;
@@ -1278,8 +1279,9 @@ static int omap_mpuio_suspend_late(struc
 	return 0;
 }
 
-static int omap_mpuio_resume_early(struct platform_device *pdev)
+static int omap_mpuio_resume_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank	*bank = platform_get_drvdata(pdev);
 	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
 	unsigned long		flags;
@@ -1291,14 +1293,18 @@ static int omap_mpuio_resume_early(struc
 	return 0;
 }
 
+static struct dev_pm_ops omap_mpuio_dev_pm_ops = {
+	.suspend_noirq = omap_mpuio_suspend_noirq,
+	.resume_noirq = omap_mpuio_resume_noirq,
+};
+
 /* use platform_driver for this, now that there's no longer any
  * point to sys_device (other than not disturbing old code).
  */
 static struct platform_driver omap_mpuio_driver = {
-	.suspend_late	= omap_mpuio_suspend_late,
-	.resume_early	= omap_mpuio_resume_early,
 	.driver		= {
 		.name	= "mpuio",
+		.pm	= &omap_mpuio_dev_pm_ops,
 	},
 };
 
