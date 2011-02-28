From: Hema HK <hemahk@ti.com>
Subject: [PATCH 2/5 v3] usb: musb: Remove platform context save/restore API
Date: Mon, 28 Feb 2011 14:19:33 +0530
Message-ID: <1298882976-4997-3-git-send-email-hemahk@ti.com>
References: <1298882976-4997-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57471 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab1B1Itx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:49:53 -0500
In-Reply-To: <1298882976-4997-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>

For OMAP3 and OMAP4 for offmode and retention support, musb
sysconfig is configured to force idle and standby with ENABLE_FORCE bit
of OTG_FORCESTNDBY set.
And on wakeup configure to no ilde/standby with resetting the ENABLE_FORCE
bit. There is not need to save and restore of this register anymore
so removed omap2430_save_context/omap2430_restore_context functions.
and also removed otg_forcestandby member of musb_context_registers
structure

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_core.h |    4 ----
 drivers/usb/musb/omap2430.c  |   11 -----------
 2 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 5216729..5cb50f8 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -358,10 +358,6 @@ struct musb_csr_regs {
 
 struct musb_context_registers {
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
-    defined(CONFIG_ARCH_OMAP4)
-	u32 otg_forcestandby;
-#endif
 	u8 power;
 	u16 intrtxe, intrrxe;
 	u8 intrusbe;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 64cf243..b6dcc7e 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -488,15 +488,6 @@ static int __exit omap2430_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static void omap2430_save_context(struct musb *musb)
-{
-	musb->context.otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
-}
-
-static void omap2430_restore_context(struct musb *musb)
-{
-	musb_writel(musb->mregs, OTG_FORCESTDBY, musb->context.otg_forcestandby);
-}
 
 static int omap2430_suspend(struct device *dev)
 {
@@ -505,7 +496,6 @@ static int omap2430_suspend(struct device *dev)
 
 	omap2430_low_level_exit(musb);
 	otg_set_suspend(musb->xceiv, 1);
-	omap2430_save_context(musb);
 
 	if (!pm_runtime_suspended(dev) && dev->bus && dev->bus->pm &&
 			dev->bus->pm->runtime_suspend)
@@ -524,7 +514,6 @@ static int omap2430_resume(struct device *dev)
 		dev->bus->pm->runtime_resume(dev);
 
 	omap2430_low_level_init(musb);
-	omap2430_restore_context(musb);
 	otg_set_suspend(musb->xceiv, 0);
 
 	return 0;
-- 
1.7.0.4

