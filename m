From: Hema HK <hemahk@ti.com>
Subject: [PATCH V2 6/8] usb: musb: Offmode fix for idle path
Date: Fri,  6 Aug 2010 22:57:04 +0530
Message-ID: <1281115624-1174-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54100 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983Ab0HFR1Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 13:27:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Maulik Mankad <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Hema HK  <hemahk@ti.com>

With OMAP core-off support musb was not functional as context was getting
lost after wakeup from core-off. And also musb was blocking the core-off 
after loading the gadget driver even with no cable connected sometimes.

Added the conext save/restore api in the platform layer which will
be called in the idle and wakeup path.

Changed the usb sysconfig settings as per the usbotg functional spec.
When the device is not active, configure to force idle and force standby mode.
When it is being used, configure in smart standby and smart idle mode.
So while attempting to coreoff the usb is configured to force standby and 
force idle mode, after wakeup configured in smart idle and smart standby.

Signed-off-by: Hema HK <hemahk@ti.com>
Signed-off-by: Maulik Mankad <x0082077@ti.com>

Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---

 arch/arm/mach-omap2/pm34xx.c          |    4 ++
 arch/arm/mach-omap2/usb-musb.c        |   21 ++++++++++++++
 arch/arm/plat-omap/include/plat/usb.h |    2 +
 drivers/usb/musb/musb_core.c          |   11 -------
 drivers/usb/musb/omap2430.c           |   48 +++++++++++++++++++++++++++++++---
 5 files changed, 71 insertions(+), 15 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c	2010-08-06 09:23:01.153862710 -0400
+++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c	2010-08-06 10:44:06.393863125 -0400
@@ -39,6 +39,7 @@
 #include <plat/gpmc.h>
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
+#include <plat/usb.h>
 
 #include <asm/tlbflush.h>
 
@@ -416,6 +417,8 @@
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_prcm_save_context();
+			/* Save MUSB context */
+			musb_context_save_restore(1);
 		}
 	}
 
@@ -458,6 +461,8 @@
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
+			/* restore MUSB context */
+			musb_context_save_restore(0);
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c	2010-08-06 09:24:23.690112596 -0400
+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c	2010-08-06 10:44:06.385862697 -0400
@@ -120,6 +120,27 @@
 	}
 }
 
+void musb_context_save_restore(int save)
+{
+	struct omap_hwmod *oh = omap_hwmod_lookup("usb_otg_hs");
+	struct omap_device *od = oh->od;
+	struct platform_device *pdev = &od->pdev;
+	struct device *dev = &pdev->dev;
+	struct device_driver *drv = dev->driver;
+
+	if (drv) {
+		struct musb_hdrc_platform_data *pdata = dev->platform_data;
+		const struct dev_pm_ops *pm = drv->pm;
+		if (!pdata->is_usb_active(dev)) {
+
+			if (save)
+				pm->suspend(dev);
+			else
+				pm->resume_noirq(dev);
+		}
+	}
+}
+
 #else
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
Index: linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/usb.h	2010-08-06 09:23:01.137862514 -0400
+++ linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h	2010-08-06 10:44:06.381864367 -0400
@@ -79,6 +79,8 @@
 
 extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata);
 
+/* For saving and restoring the musb context during off/wakeup*/
+extern void musb_context_save_restore(int save);
 #endif
 
 
Index: linux-omap-pm/drivers/usb/musb/musb_core.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c	2010-08-06 09:24:21.069863329 -0400
+++ linux-omap-pm/drivers/usb/musb/musb_core.c	2010-08-06 10:44:06.369863527 -0400
@@ -2427,11 +2427,6 @@
 	}
 
 	musb_save_context(musb);
-
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 0);
-	else
-		clk_disable(musb->clock);
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }
@@ -2443,12 +2438,6 @@
 
 	if (!musb->clock)
 		return 0;
-
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 1);
-	else
-		clk_enable(musb->clock);
-
 	musb_restore_context(musb);
 
 	/* for static cmos like DaVinci, register values were preserved
Index: linux-omap-pm/drivers/usb/musb/omap2430.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/omap2430.c	2010-08-06 09:24:21.069863329 -0400
+++ linux-omap-pm/drivers/usb/musb/omap2430.c	2010-08-06 10:44:30.093914217 -0400
@@ -189,6 +189,19 @@
 	return 0;
 }
 
+int is_musb_active(struct device *dev)
+{
+	struct musb *musb;
+
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+	/* usbcore insists dev->driver_data is a "struct hcd *" */
+	musb = hcd_to_musb(dev_get_drvdata(dev));
+#else
+	musb = dev_get_drvdata(dev);
+#endif
+	return musb->is_active;
+}
+
 int __init musb_platform_init(struct musb *musb)
 {
 	u32 l;
@@ -250,6 +263,7 @@
 	if (is_host_enabled(musb))
 		musb->board_set_vbus = omap_set_vbus;
 
+	plat->is_usb_active = is_musb_active;
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
 	return 0;
@@ -259,15 +273,42 @@
 void musb_platform_save_context(struct musb *musb,
 		struct musb_context_registers *musb_context)
 {
-	musb_context->otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	musb_context->otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
+	/*
+	 * As per the omap-usbotg specification, configure it to forced standby
+	 * and  force idle mode when no activity on usb.
+	 */
+	void __iomem *musb_base = musb->mregs;
+
+	musb_writel(musb_base, OTG_FORCESTDBY, 0);
+
+	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
+				OTG_SYSCONFIG) & ~(NOSTDBY | SMARTSTDBY));
+
+	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
+					OTG_SYSCONFIG) & ~(AUTOIDLE));
+
+	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
+				OTG_SYSCONFIG) & ~(NOIDLE | SMARTIDLE));
+
+	musb_writel(musb_base, OTG_FORCESTDBY, 1);
 }
 
 void musb_platform_restore_context(struct musb *musb,
 		struct musb_context_registers *musb_context)
 {
-	musb_writel(musb->mregs, OTG_SYSCONFIG, musb_context->otg_sysconfig);
-	musb_writel(musb->mregs, OTG_FORCESTDBY, musb_context->otg_forcestandby);
+	/*
+	 * As per the omap-usbotg specification, configure it smart standby
+	 * and smart idle during operation.
+	 */
+	void __iomem *musb_base = musb->mregs;
+
+	musb_writel(musb_base, OTG_FORCESTDBY, 0);
+
+	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
+				OTG_SYSCONFIG) | (SMARTSTDBY));
+
+	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
+				OTG_SYSCONFIG) | (SMARTIDLE));
 }
 #endif
 
Index: linux-omap-pm/include/linux/usb/musb.h
===================================================================
--- linux-omap-pm.orig/include/linux/usb/musb.h	2010-08-06 09:23:01.161864151 -0400
+++ linux-omap-pm/include/linux/usb/musb.h	2010-08-06 10:44:06.401862567 -0400
@@ -126,6 +126,9 @@
 
 	/* Architecture specific board data	*/
 	void		*board_data;
+
+	/* check usb device active state*/
+	int		(*is_usb_active)(struct device *dev);
 };
 
 
