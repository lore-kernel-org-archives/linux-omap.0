From: Hema HK <hemahk@ti.com>
Subject: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Wed, 22 Sep 2010 20:30:30 -0400
Message-ID: <1285201830-26561-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56141 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276Ab0IVPAD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 11:00:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Calling runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
for enabling/disabling the clocks,sysconfig settings.

Also need to put the USB in force standby and force idle mode when usb not used
and set it back to no idle and no stndby after wakeup.
For OMAP3 auto idle bit has to be disabled because of the errata.So using
HWMOD_NO_OCP_AUTOIDLE flag for OMAP3430.

Signed-off-by: Hema HK <hemahk@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---

 drivers/usb/musb/musb_core.c |   26 ++++++++++++++++++++++++
 drivers/usb/musb/omap2430.c  |   45 ++++++-------------------------------------
 2 files changed, 33 insertions(+), 38 deletions(-)

Index: linux-omap-pm/drivers/usb/musb/musb_core.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
+++ linux-omap-pm/drivers/usb/musb/musb_core.c
@@ -98,6 +98,7 @@
 #include <linux/kobject.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 
 #ifdef	CONFIG_ARM
 #include <mach/hardware.h>
@@ -2424,13 +2425,16 @@ static int musb_suspend(struct device *d
 		 * they will even be wakeup-enabled.
 		 */
 	}
+	pm_runtime_put_sync(dev);
 
+#ifndef CONFIG_PM_RUNTIME
 	musb_save_context(musb);
 
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 0);
 	else
 		clk_disable(musb->clock);
+#endif
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }
@@ -2443,12 +2447,16 @@ static int musb_resume_noirq(struct devi
 	if (!musb->clock)
 		return 0;
 
+	pm_runtime_get_sync(dev);
+
+#ifndef CONFIG_PM_RUNTIME
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 1);
 	else
 		clk_enable(musb->clock);
 
 	musb_restore_context(musb);
+#endif
 
 	/* for static cmos like DaVinci, register values were preserved
 	 * unless for some reason the whole soc powered down or the USB
@@ -2457,9 +2465,26 @@ static int musb_resume_noirq(struct devi
 	return 0;
 }
 
+static int musb_runtime_suspend(struct device *dev)
+{
+	struct musb	*musb = dev_to_musb(dev);
+
+	musb_save_context(musb);
+	return 0;
+}
+
+static int musb_runtime_resume(struct device *dev)
+{
+	struct musb	*musb = dev_to_musb(dev);
+
+	musb_restore_context(musb);
+	return 0;
+}
 static const struct dev_pm_ops musb_dev_pm_ops = {
 	.suspend	= musb_suspend,
 	.resume_noirq	= musb_resume_noirq,
+	.runtime_suspend = musb_runtime_suspend,
+	.runtime_resume	 = musb_runtime_resume,
 };
 
 #define MUSB_DEV_PM_OPS (&musb_dev_pm_ops)
Index: linux-omap-pm/drivers/usb/musb/omap2430.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/omap2430.c
+++ linux-omap-pm/drivers/usb/musb/omap2430.c
@@ -31,6 +31,8 @@
 #include <linux/list.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
@@ -206,21 +208,6 @@ int __init musb_platform_init(struct mus
 
 	musb_platform_resume(musb);
 
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
-	l &= ~NOSTDBY;		/* remove possible nostdby */
-	l |= SMARTSTDBY;	/* enable smart standby */
-	l &= ~AUTOIDLE;		/* disable auto idle */
-	l &= ~NOIDLE;		/* remove possible noidle */
-	l |= SMARTIDLE;		/* enable smart idle */
-	/*
-	 * MUSB AUTOIDLE don't work in 3430.
-	 * Workaround by Richard Woodruff/TI
-	 */
-	if (!cpu_is_omap3430())
-		l |= AUTOIDLE;		/* enable auto idle */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
-
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
 	if (data->interface_type == MUSB_INTERFACE_UTMI) {
@@ -253,15 +240,13 @@ int __init musb_platform_init(struct mus
 void musb_platform_save_context(struct musb *musb,
 		struct musb_context_registers *musb_context)
 {
-	musb_context->otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	musb_context->otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
+	musb_writel(musb->mregs, OTG_FORCESTDBY, ENABLEFORCE);
 }
 
 void musb_platform_restore_context(struct musb *musb,
 		struct musb_context_registers *musb_context)
 {
-	musb_writel(musb->mregs, OTG_SYSCONFIG, musb_context->otg_sysconfig);
-	musb_writel(musb->mregs, OTG_FORCESTDBY, musb_context->otg_forcestandby);
+	musb_writel(musb->mregs, OTG_FORCESTDBY, 0);
 }
 #endif
 
@@ -277,37 +262,23 @@ static int musb_platform_suspend(struct 
 	l |= ENABLEFORCE;	/* enable MSTANDBY */
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l |= ENABLEWAKEUP;	/* enable wakeup */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
-
 	otg_set_suspend(musb->xceiv, 1);
 
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 0);
-	else
-		clk_disable(musb->clock);
-
 	return 0;
 }
 
 static int musb_platform_resume(struct musb *musb)
 {
 	u32 l;
+	struct device *dev = musb->controller;
 
 	if (!musb->clock)
 		return 0;
 
 	otg_set_suspend(musb->xceiv, 0);
 
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 1);
-	else
-		clk_enable(musb->clock);
-
-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 
 	l = musb_readl(musb->mregs, OTG_FORCESTDBY);
 	l &= ~ENABLEFORCE;	/* disable MSTANDBY */
