From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 07/10] usb: musb: Manage USB phy from PM runtime calls
Date: Thu, 28 Apr 2016 10:33:17 -0700
Message-ID: <1461864800-29979-8-git-send-email-tony@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461864800-29979-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This simplifies things and allows idling both MUSB and PHY
when nothing is configured.

Let's also warn if PHY is not configured.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/omap2430.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index a2a158f..b274923 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -395,6 +395,7 @@ static int omap2430_musb_init(struct musb *musb)
 		return PTR_ERR(musb->phy);
 	}
 	musb->isr = omap2430_musb_interrupt;
+	phy_init(musb->phy);
 
 	/*
 	 * Enable runtime PM for musb parent (this driver). We can't
@@ -431,8 +432,6 @@ static int omap2430_musb_init(struct musb *musb)
 	if (glue->status != MUSB_UNKNOWN)
 		omap_musb_set_mailbox(glue);
 
-	phy_init(musb->phy);
-	phy_power_on(musb->phy);
 	pm_runtime_put(glue->dev);
 	return 0;
 
@@ -491,11 +490,17 @@ static void omap2430_musb_disable(struct musb *musb)
 
 static int omap2430_musb_exit(struct musb *musb)
 {
-	del_timer_sync(&musb_idle_timer);
+	struct device *dev = musb->controller;
+	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
 
+	del_timer_sync(&musb_idle_timer);
+	pm_runtime_get_sync(glue->dev);
 	omap2430_low_level_exit(musb);
-	phy_power_off(musb->phy);
+	pm_runtime_put_sync_suspend(glue->dev);
+	pm_runtime_disable(glue->dev);
 	phy_exit(musb->phy);
+	musb->phy = NULL;
+	cancel_work_sync(&glue->omap_musb_mailbox_work);
 
 	return 0;
 }
@@ -661,11 +666,7 @@ static int omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue		*glue = platform_get_drvdata(pdev);
 
-	pm_runtime_get_sync(glue->dev);
-	cancel_work_sync(&glue->omap_musb_mailbox_work);
 	platform_device_unregister(glue->musb);
-	pm_runtime_put_sync(glue->dev);
-	pm_runtime_disable(glue->dev);
 
 	return 0;
 }
@@ -677,12 +678,15 @@ static int omap2430_runtime_suspend(struct device *dev)
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
 
-	if (musb) {
-		musb->context.otg_interfsel = musb_readl(musb->mregs,
-				OTG_INTERFSEL);
+	if (WARN_ON(!musb))
+		return 0;
 
-		omap2430_low_level_exit(musb);
-	}
+	musb->context.otg_interfsel = musb_readl(musb->mregs,
+						 OTG_INTERFSEL);
+
+	omap2430_low_level_exit(musb);
+	if (!WARN_ON(!musb->phy))
+		phy_power_off(musb->phy);
 
 	return 0;
 }
@@ -692,9 +696,12 @@ static int omap2430_runtime_resume(struct device *dev)
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
 
-	if (!musb)
+	if (WARN_ON(!musb))
 		return -EPROBE_DEFER;
 
+	if (!WARN_ON(!musb->phy))
+		phy_power_on(musb->phy);
+
 	omap2430_low_level_init(musb);
 	musb_writel(musb->mregs, OTG_INTERFSEL,
 		    musb->context.otg_interfsel);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
