From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 04/10] usb: musb: Remove unnecessary shutdown function
Date: Thu, 28 Apr 2016 10:33:14 -0700
Message-ID: <1461864800-29979-5-git-send-email-tony@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461864800-29979-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We have remove() already calling shutdown(), so let's drop it
and move the code to remove().

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5fa6187..d7af8ed 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1090,29 +1090,6 @@ void musb_stop(struct musb *musb)
 	musb_platform_try_idle(musb, 0);
 }
 
-static void musb_shutdown(struct platform_device *pdev)
-{
-	struct musb	*musb = dev_to_musb(&pdev->dev);
-	unsigned long	flags;
-
-	pm_runtime_get_sync(musb->controller);
-
-	musb_host_cleanup(musb);
-	musb_gadget_cleanup(musb);
-
-	spin_lock_irqsave(&musb->lock, flags);
-	musb_platform_disable(musb);
-	musb_generic_disable(musb);
-	spin_unlock_irqrestore(&musb->lock, flags);
-
-	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
-	musb_platform_exit(musb);
-
-	pm_runtime_put(musb->controller);
-	/* FIXME power down */
-}
-
-
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -2312,6 +2289,7 @@ static int musb_remove(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
 	struct musb	*musb = dev_to_musb(dev);
+	unsigned long	flags;
 
 	/* this gets called on rmmod.
 	 *  - Host mode: host may still be active
@@ -2319,7 +2297,19 @@ static int musb_remove(struct platform_device *pdev)
 	 *  - OTG mode: both roles are deactivated (or never-activated)
 	 */
 	musb_exit_debugfs(musb);
-	musb_shutdown(pdev);
+
+	pm_runtime_get_sync(musb->controller);
+	musb_host_cleanup(musb);
+	musb_gadget_cleanup(musb);
+	spin_lock_irqsave(&musb->lock, flags);
+	musb_platform_disable(musb);
+	musb_generic_disable(musb);
+	spin_unlock_irqrestore(&musb->lock, flags);
+	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
+	musb_platform_exit(musb);
+	pm_runtime_put(musb->controller);
+	/* FIXME power down */
+
 	musb_phy_callback = NULL;
 
 	if (musb->dma_controller)
@@ -2612,7 +2602,6 @@ static struct platform_driver musb_driver = {
 	},
 	.probe		= musb_probe,
 	.remove		= musb_remove,
-	.shutdown	= musb_shutdown,
 };
 
 module_platform_driver(musb_driver);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
