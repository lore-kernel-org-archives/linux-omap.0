From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 06/10] usb: musb: Split PM runtime between wrapper IP and musb core
Date: Thu, 28 Apr 2016 10:33:16 -0700
Message-ID: <1461864800-29979-7-git-send-email-tony@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461864800-29979-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Let's not tinker with the PM runtime of musb core from the omap2430
wrapper. This allows us to initialize PM runtime for musb core later
on instead of doing it in stages. And omap2430 wrapper has no need
to for accessing musb core at this point.

Note that this does not remove all the PM runtime calls from the
glue layer, those will get removed in a later patch.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c | 25 ++++++++++---------------
 drivers/usb/musb/omap2430.c  | 10 ----------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 90ccdb2..b492316 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2005,11 +2005,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	musb_readl = musb_default_readl;
 	musb_writel = musb_default_writel;
 
-	/* We need musb_read/write functions initialized for PM */
-	pm_runtime_use_autosuspend(musb->controller);
-	pm_runtime_set_autosuspend_delay(musb->controller, 500);
-	pm_runtime_enable(musb->controller);
-
 	/* The musb_platform_init() call:
 	 *   - adjusts musb->mregs
 	 *   - sets the musb->isr
@@ -2111,6 +2106,10 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (musb->ops->phy_callback)
 		musb_phy_callback = musb->ops->phy_callback;
 
+	/* We need musb_read/write functions initialized for PM */
+	pm_runtime_use_autosuspend(musb->controller);
+	pm_runtime_set_autosuspend_delay(musb->controller, 500);
+	pm_runtime_enable(musb->controller);
 	pm_runtime_get_sync(musb->controller);
 
 	status = usb_phy_init(musb->xceiv);
@@ -2300,6 +2299,9 @@ static int musb_remove(struct platform_device *pdev)
 	 */
 	musb_exit_debugfs(musb);
 
+	cancel_work_sync(&musb->irq_work);
+	cancel_delayed_work_sync(&musb->finish_resume_work);
+	cancel_delayed_work_sync(&musb->deassert_reset_work);
 	pm_runtime_get_sync(musb->controller);
 	musb_host_cleanup(musb);
 	musb_gadget_cleanup(musb);
@@ -2308,21 +2310,14 @@ static int musb_remove(struct platform_device *pdev)
 	musb_generic_disable(musb);
 	spin_unlock_irqrestore(&musb->lock, flags);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
+	pm_runtime_dont_use_autosuspend(musb->controller);
+	pm_runtime_put_sync(musb->controller);
+	pm_runtime_disable(musb->controller);
 	musb_platform_exit(musb);
-
 	musb_phy_callback = NULL;
-
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
-
 	usb_phy_shutdown(musb->xceiv);
-
-	cancel_work_sync(&musb->irq_work);
-	cancel_delayed_work_sync(&musb->finish_resume_work);
-	cancel_delayed_work_sync(&musb->deassert_reset_work);
-	pm_runtime_dont_use_autosuspend(musb->controller);
-	pm_runtime_put_sync(musb->controller);
-	pm_runtime_disable(musb->controller);
 	musb_free(musb);
 	device_init_wakeup(dev, 0);
 	return 0;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index c55d4f3..a2a158f 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -406,13 +406,6 @@ static int omap2430_musb_init(struct musb *musb)
 	if (status < 0)
 		goto err1;
 
-	status = pm_runtime_get_sync(dev);
-	if (status < 0) {
-		dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
-		pm_runtime_put_sync(glue->dev);
-		goto err1;
-	}
-
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
 
 	if (data->interface_type == MUSB_INTERFACE_UTMI) {
@@ -440,9 +433,6 @@ static int omap2430_musb_init(struct musb *musb)
 
 	phy_init(musb->phy);
 	phy_power_on(musb->phy);
