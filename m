From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCHv2] OMAP3: PM: Ensure MUSB is accessible before we attempt to reset it
Date: Thu, 13 Aug 2009 15:46:41 -0500
Message-ID: <1250196401-24433-1-git-send-email-jon-hunter@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41372 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814AbZHMUrr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Aug 2009 16:47:47 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7DKlhKR024234
	for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 15:47:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

This is version 2 of this patch. I have incorporated the changes 
recommended by Kevin Hilman.

Depending on the OMAP3 boot mode the MUSB peripheral may or may not be
accessible when the kernel starts.

The OMAP3 can boot from several devices including USB. The sequence of the
devices the OMAP will attempt to boot from is configured via the sys_boot
pins on the device. If USB is one of the devices the OMAP boot ROM attempts
to boot from on power-on, then the interface clock to the MUSB peripheral
will be enabled by the boot ROM and the MUSB peripheral will be accessible
when the kernel boots. However, if USB is not one of the devices OMAP
attempts to boot from, then the interface clock is not enabled and the MUSB
peripheral will not be accessible on start-up.

If the MUSB peripheral is not accessible when the kernel boots, then the
kernel will crash when attempting to access the OTG_SYSCONFIG in the
function musb_platform_init(). The actual cause of the crash is the write
to the OTG_SYSCONFIG register in the function usb_musb_pm_init() to reset
the MUSB peripheral which occurs prior to calling musb_platform_init().
The function usb_musb_pm_init() does not check to see if the interface
clock for the MUSB peripheral is enabled before writing to MUSB register.
This write access does not generate a data-abort at this point, but because
this write does not complete all future accesses to the MUSB controller will
generate data-aborts regardless of whether the interface clock has been
enabled at a later stage. The only way I have found to recover from this is
resetting the device. My understanding is that the interconnect works in
this way to prevent a bad access locking up the system.

This patch ensures the interface clock for the MUSB in the function
usb_musb_pm_init() is enabled. This patch also ensures that the interface
clock is disabled after the reset is complete. My reasoning for always
disabling the clock rather than maintaing its state is:

1). If the MUSB peripheral is not being used then the interface clock should
be disabled.
2). The musb_set_clock() function uses a static variable called "clk_on" to
determine if the MUSB interface clock is on or off. On boot-up clk_on will
be 0 and so this function assumes that the clock is off by default which
may not be the case in the current code.

I have also added a while-loop to wait for the reset of the MUSB module to
complete before this function exits and the interface clock it disabled.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 3efa19c..247f653 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -35,10 +35,20 @@
 
 #define OTG_SYSCONFIG	   0x404
 #define OTG_SYSC_SOFTRESET BIT(1)
+#define OTG_SYSSTATUS     0x408
+#define OTG_SYSS_RESETDONE BIT(0)
+
+static struct platform_device dummy_pdev = {
+	.dev = {
+		.bus = &platform_bus_type,
+	},
+};
 
 static void __init usb_musb_pm_init(void)
 {
 	void __iomem *otg_base;
+	struct clk *otg_clk;
+	struct device *dev = &dummy_pdev.dev;
 
 	if (!cpu_is_omap34xx())
 		return;
@@ -47,9 +57,27 @@ static void __init usb_musb_pm_init(void)
 	if (WARN_ON(!otg_base))
 		return;
 
-	/* Reset OTG controller.  After reset, it will be in
-	 * force-idle, force-standby mode. */
-	__raw_writel(OTG_SYSC_SOFTRESET, otg_base + OTG_SYSCONFIG);
+	dev_set_name(dev, "musb_hdrc");
+	otg_clk = clk_get(dev, "ick");
+
+	if (otg_clk && clk_enable(otg_clk)) {
+		printk(KERN_WARNING
+			"%s: Unable to enable clocks for MUSB, "
+			"cannot reset.\n",  __func__);
+	} else {
+		/* Reset OTG controller. After reset, it will be in
+		 * force-idle, force-standby mode. */
+		__raw_writel(OTG_SYSC_SOFTRESET, otg_base + OTG_SYSCONFIG);
+
+		while (!(OTG_SYSS_RESETDONE &
+					__raw_readl(otg_base + OTG_SYSSTATUS)))
+			cpu_relax();
+	}
+
+	if (otg_clk) {
+		clk_disable(otg_clk);
+		clk_put(otg_clk);
+	}
 
 	iounmap(otg_base);
 }
-- 
1.6.0.4

