From: Hema HK <hemahk@ti.com>
Subject: [PATCH] usb: musb: Offmode fix for idle path
Date: Thu,  8 Jul 2010 15:58:36 +0530
Message-ID: <1278584916-21288-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50843 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832Ab0GHK2o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 06:28:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Maulik Mankad <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Hema HK  <hemahk@ti.com>

With OMAP coreoff support usb was not functional as context was getting
lost after wakeup from coreoff. And also usb was blocking the coreoff 
after loading the gadget driver even with no cable connected sometimes.

Added the conext save/restore api in the platform layer which will
be called in the idle and wakeup path.

Changed the usb sysconfig settings as per the usbotg functional spec.
When the device is not used, configure in force idle and force standby mode.
When it is being used, configure in smart standby and smart idle mode.
So while attempting to coreoff the usb is configured to force standby and 
force idle mode, after wakeup configured in smart idle and smart standby.

Since clock used for musb is auto gated, there is no need to specifically
enable/disable the clock. Removed enable/disable clock in suspend resume api.

Signed-off-by: Hema HK <hemahk@ti.com>
Signed-off-by: Maulik Mankad <x0082077@ti.com>

Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
Based off : Kevin pm branch.

 arch/arm/mach-omap2/pm34xx.c          |    4 ++++
 arch/arm/mach-omap2/usb-musb.c        |   15 +++++++++++++++
 arch/arm/plat-omap/include/plat/usb.h |    2 ++
 drivers/usb/musb/musb_core.c          |   11 -----------
 drivers/usb/musb/omap2430.c           |   32 ++++++++++++++++++++++++++++----
 5 files changed, 49 insertions(+), 15 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
+++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
@@ -431,6 +431,8 @@ void omap_sram_idle(void)
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_prcm_save_context();
+			/* Save MUSB context */
+			musb_context_save_restore(1);
 		}
 	}
 
@@ -479,6 +481,8 @@ void omap_sram_idle(void)
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
+			/* Restore MUSB context */
+			musb_context_save_restore(0);
 			/*
 			 * Errata 1.164 fix : OTG autoidle can prevent
 			 * sleep
Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
@@ -177,6 +177,21 @@ void __init usb_musb_init(struct omap_mu
 	usb_musb_pm_init();
 }
 
+void musb_context_save_restore(int save)
+{
+	struct device *dev = &musb_device.dev;
+	struct device_driver *drv = dev->driver;
+	if (dev->driver) {
+
+		const struct dev_pm_ops *pm = drv->pm;
+
+		if (save)
+			pm->suspend(dev);
+		else
+			pm->resume_noirq(dev);
+	}
+}
+
 #else
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
Index: linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/usb.h
+++ linux-omap-pm/arch/arm/plat-omap/include/plat/usb.h
@@ -82,6 +82,8 @@ extern void usb_ohci_init(const struct o
 /* This is needed for OMAP3 errata 1.164: enabled autoidle can prevent sleep */
 extern void usb_musb_disable_autoidle(void);
 
+/* For saving and restoring the musb context during off/wakeup*/
+extern void musb_context_save_restore(int save);
 #endif
 
 void omap_usb_init(struct omap_usb_config *pdata);
Index: linux-omap-pm/drivers/usb/musb/musb_core.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
+++ linux-omap-pm/drivers/usb/musb/musb_core.c
@@ -2430,11 +2430,6 @@ static int musb_suspend(struct device *d
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
@@ -2446,12 +2441,6 @@ static int musb_resume_noirq(struct devi
 
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
--- linux-omap-pm.orig/drivers/usb/musb/omap2430.c
+++ linux-omap-pm/drivers/usb/musb/omap2430.c
@@ -257,15 +257,39 @@ int __init musb_platform_init(struct mus
 void musb_platform_save_context(struct musb *musb,
 		struct musb_context_registers *musb_context)
 {
-	musb_context->otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	musb_context->otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
+	/*
+	 * As per the specification, configure it to forced standby
+	 * and  force idle mode when no activity on usb.
+	 */
+	void __iomem *musb_base = musb->mregs;
+	musb_writel(musb_base, OTG_FORCESTDBY, 0);
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
+	 * As per the specification, configure it smart standby
+	 * and smart idle during operation.
+	 */
+	void __iomem *musb_base = musb->mregs;
+	musb_writel(musb_base, OTG_FORCESTDBY, 0);
+
+	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
+				OTG_SYSCONFIG) | (SMARTSTDBY));
+
+	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
+					OTG_SYSCONFIG) | (SMARTIDLE));
 }
 #endif
 
