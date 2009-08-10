From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] OMAP3: PM: Ensure MUSB is accessible before we attempt to reset it
Date: Mon, 10 Aug 2009 16:15:43 -0500
Message-ID: <1249938943-22329-1-git-send-email-jon-hunter@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53072 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbZHJVPk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Aug 2009 17:15:40 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7ALFaUO015810
	for <linux-omap@vger.kernel.org>; Mon, 10 Aug 2009 16:15:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

Depending on the OMAP3 boot mode the MUSB peripheral may or may not be
accessible when the kernel starts.

The OMAP3 can boot from several devices including USB. The sequence of the
devices the OMAP will attempt to boot from is configured via the sys_boot
pins on the device. If USB is one of the devices the OMAP boot ROM attempts
to boot from on power-on, then the interface clock to the MUSB peripheral will
be enabled by the boot ROM and the MUSB peripheral will be accessible when the
kernel boots. However, if USB is not one of the devices OMAP will attempt to
boot from then the interface clock is not enabled and the MUSB peripheral will
not be accessible on start-up.

If the MUSB peripheral is not accessible when the kernel boots, then the
kernel will crash when attempting to access the OTG_SYSCONFIG in the function
musb_platform_init(). The actual cause of the crash is the write to the
OTG_SYSCONFIG register in the function usb_musb_pm_init() to reset the MUSB
peripheral which occurs prior to calling musb_platform_init(). The function
usb_musb_pm_init() does not check to see if the interface clock for the MUSB
peripheral is enabled before writing to MUSB register. This write access does
not generate a data-abort at this point, but because this write does not
complete all future accesses to the MUSB controller will generate data-aborts
regardless of whether the interface clock has been enabled at a later stage.
The only way I have found to recover from this is resetting the device.
My understanding is that the interconnect works in this way to prevent a bad
access locking up the system.

This patch crudely ensures the interface clock for the MUSB in the function
usb_musb_pm_init() is enabled. This patch also ensures that the interface
clock is disabled after the reset is complete. My reasoning for always
disabling the clock rather than maintaing its state is:

1). If the MUSB peripheral is not being used then the interface clock should
be disabled.
2). The musb_set_clock() function uses a static variable called "clk_on" to
determine if the MUSB interface clock is on or off. On boot-up clk_on will be
0 and so this function assumes that the clock is off by default which may not
be the case in the current code.

I have also added a while-loop to wait for the reset of the MUSB module to
complete before this function exits and the interface clock it disabled.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 3efa19c..7cfe9bb 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -32,25 +32,51 @@
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/usb.h>
+#include "cm.h"
 
 #define OTG_SYSCONFIG	   0x404
 #define OTG_SYSC_SOFTRESET BIT(1)
+#define OTG_SYSSTATUS	   0x408
+#define OTG_SYSS_RESETDONE BIT(0)
 
 static void __init usb_musb_pm_init(void)
 {
-	void __iomem *otg_base;
+	void __iomem *cm_base, *otg_base;
+	unsigned int cm_iclken_core;
 
 	if (!cpu_is_omap34xx())
 		return;
 
+	cm_base = ioremap(OMAP3430_CM_BASE, SZ_4K);
+	if (WARN_ON(!cm_base))
+		return;
+
 	otg_base = ioremap(OMAP34XX_HSUSB_OTG_BASE, SZ_4K);
-	if (WARN_ON(!otg_base))
+	if (WARN_ON(!otg_base)) {
+		iounmap(cm_base);
 		return;
+	}
+
+	/* Ensure the inferface clock for MUSB is enabled */
+	cm_iclken_core = __raw_readl(OMAP34XX_CM_REGADDR(CORE_MOD,
+					CM_ICLKEN1));
+	__raw_writel((cm_iclken_core |
+			(1 << OMAP3430_EN_HSOTGUSB_SHIFT)),
+			OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1));
 
 	/* Reset OTG controller.  After reset, it will be in
 	 * force-idle, force-standby mode. */
 	__raw_writel(OTG_SYSC_SOFTRESET, otg_base + OTG_SYSCONFIG);
 
+	while (!(OTG_SYSS_RESETDONE & __raw_readl(otg_base + OTG_SYSSTATUS)))
+		cpu_relax();
+
+	/* Ensure the interface clock for MUSB is disabled */
+	__raw_writel((cm_iclken_core &
+			~(1 << OMAP3430_EN_HSOTGUSB_SHIFT)),
+			OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1));
+
+	iounmap(cm_base);
 	iounmap(otg_base);
 }
 
-- 
1.6.0.4

