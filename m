From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/15] usb: musb: Update to use PM runtime autosuspend
Date: Wed, 11 May 2016 17:53:04 -0700
Message-ID: <1463014396-4095-4-git-send-email-tony@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463014396-4095-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Let's make the PM runtime use the standard autosuspend calls.
Commit 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
error and driver unbind") means we must pair use_autosuspend with
dont_use_autosuspend and then use put_sync to properly idle the
device.

Note that we'll be removing the PM runtime calls from the glue
layer to the MUSB core in the next patch. And we can also remove
the pointless FIXME comment now.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c   | 9 ++++++---
 drivers/usb/musb/musb_gadget.c | 3 ++-
 drivers/usb/musb/omap2430.c    | 5 +++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index c370ed5..89c270a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2220,7 +2220,8 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (status)
 		goto fail5;
 
-	pm_runtime_put(musb->controller);
+	pm_runtime_mark_last_busy(musb->controller);
+	pm_runtime_put_autosuspend(musb->controller);
 
 	/*
 	 * For why this is currently needed, see commit 3e43a0725637
@@ -2248,6 +2249,7 @@ fail2_5:
 	usb_phy_shutdown(musb->xceiv);
 
 err_usb_phy_init:
+	pm_runtime_dont_use_autosuspend(musb->controller);
 	pm_runtime_put_sync(musb->controller);
 
 fail2:
@@ -2313,8 +2315,6 @@ static int musb_remove(struct platform_device *pdev)
 	spin_unlock_irqrestore(&musb->lock, flags);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	musb_platform_exit(musb);
-	pm_runtime_put(musb->controller);
-	/* FIXME power down */
 
 	musb_phy_callback = NULL;
 
@@ -2326,6 +2326,9 @@ static int musb_remove(struct platform_device *pdev)
 	cancel_work_sync(&musb->irq_work);
 	cancel_delayed_work_sync(&musb->finish_resume_work);
 	cancel_delayed_work_sync(&musb->deassert_reset_work);
+	pm_runtime_dont_use_autosuspend(musb->controller);
+	pm_runtime_put_sync(musb->controller);
+	pm_runtime_disable(musb->controller);
 	musb_free(musb);
 	device_init_wakeup(dev, 0);
 	return 0;
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 152865b..fff5a8a 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1963,7 +1963,8 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 * that currently misbehaves.
 	 */
 
-	pm_runtime_put(musb->controller);
+	pm_runtime_mark_last_busy(musb->controller);
+	pm_runtime_put_autosuspend(musb->controller);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index c84e0322..07363d2 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -435,8 +435,9 @@ static int omap2430_musb_init(struct musb *musb)
 	phy_init(musb->phy);
 	phy_power_on(musb->phy);
 
-	pm_runtime_put_noidle(musb->controller);
-	pm_runtime_put_noidle(glue->dev);
+	pm_runtime_mark_last_busy(musb->controller);
+	pm_runtime_put_autosuspend(musb->controller);
+	pm_runtime_put(glue->dev);
 	return 0;
 
 err1:
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
