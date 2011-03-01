From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 02/19] usb: musb: Remove platform context save/restore API
Date: Tue,  1 Mar 2011 17:15:23 +0200
Message-ID: <1298992540-5984-3-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298992540-5984-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>

For OMAP3 and OMAP4 for offmode and retention support, musb
sysconfig is configured to force idle and standby with ENABLE_FORCE bit
of OTG_FORCESTNDBY set.
And on wakeup configure to no ilde/standby with resetting the ENABLE_FORCE
bit. There is not need to save and restore of this register anymore
so removed omap2430_save_context/omap2430_restore_context functions.
and also removed otg_forcestandby member of musb_context_registers
structure

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
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
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
