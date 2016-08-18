From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/4] usb: musb: Add PM runtime support for MUSB DSPS glue layer
Date: Thu, 18 Aug 2016 15:46:49 -0700
Message-ID: <1471560410-6428-4-git-send-email-tony@atomide.com>
References: <1471560410-6428-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471560410-6428-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We can now just use PM runtime autoidle support as musb core
keeps things enabled when the devctl session bit is set. And
there's no need for dsps_musb_try_idle() so let's just remove
it.

Note that as cppi41 dma is clocked by musb, this only makes
PM work for dsps glue layer if CONFIG_MUSB_PIO_ONLY=y and
cppi41.ko is unloaded. This will get fixed when cppi41.c has
PM runtime implemented.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 58 +++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index ec0369b..dc43521 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -145,43 +145,6 @@ static const struct debugfs_reg32 dsps_musb_regs[] = {
 	{ "mode",		0xe8 },
 };
 
-static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
-{
-	struct device *dev = musb->controller;
-	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
-
-	if (timeout == 0)
-		timeout = jiffies + msecs_to_jiffies(3);
-
-	/* Never idle if active, or when VBUS timeout is not set as host */
-	if (musb->is_active || (musb->a_wait_bcon == 0 &&
-			musb->xceiv->otg->state == OTG_STATE_A_WAIT_BCON)) {
-		dev_dbg(musb->controller, "%s active, deleting timer\n",
-				usb_otg_state_string(musb->xceiv->otg->state));
-		del_timer(&glue->timer);
-		glue->last_timer = jiffies;
-		return;
-	}
-	if (musb->port_mode != MUSB_PORT_MODE_DUAL_ROLE)
-		return;
-
-	if (!musb->g.dev.driver)
-		return;
-
-	if (time_after(glue->last_timer, timeout) &&
-				timer_pending(&glue->timer)) {
-		dev_dbg(musb->controller,
-			"Longer idle timer already pending, ignoring...\n");
-		return;
-	}
-	glue->last_timer = timeout;
-
-	dev_dbg(musb->controller, "%s inactive, starting idle timer for %u ms\n",
-		usb_otg_state_string(musb->xceiv->otg->state),
-			jiffies_to_msecs(timeout - jiffies));
-	mod_timer(&glue->timer, timeout);
-}
-
 /**
  * dsps_musb_enable - enable interrupts
  */
@@ -206,7 +169,6 @@ static void dsps_musb_enable(struct musb *musb)
 			musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
 		mod_timer(&glue->timer, jiffies +
 				msecs_to_jiffies(wrp->poll_timeout));
-	dsps_musb_try_idle(musb, 0);
 }
 
 /**
@@ -236,6 +198,11 @@ static void otg_timer(unsigned long _musb)
 	u8 devctl;
 	unsigned long flags;
 	int skip_session = 0;
+	int err;
+
+	err = pm_runtime_get_sync(dev);
+	if (err < 0)
+		dev_err(dev, "Poll could not pm_runtime_get: %i\n", err);
 
 	/*
 	 * We poll because DSPS IP's won't expose several OTG-critical
@@ -279,6 +246,9 @@ static void otg_timer(unsigned long _musb)
 		break;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static irqreturn_t dsps_interrupt(int irq, void *hci)
@@ -634,7 +604,6 @@ static struct musb_platform_ops dsps_ops = {
 	.enable		= dsps_musb_enable,
 	.disable	= dsps_musb_disable,
 
-	.try_idle	= dsps_musb_try_idle,
 	.set_mode	= dsps_musb_set_mode,
 	.recover	= dsps_musb_recover,
 };
@@ -798,6 +767,8 @@ static int dsps_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, glue);
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 200);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
@@ -809,11 +780,15 @@ static int dsps_probe(struct platform_device *pdev)
 	if (ret)
 		goto err3;
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 err3:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 err2:
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
@@ -825,7 +800,8 @@ static int dsps_remove(struct platform_device *pdev)
 	platform_device_unregister(glue->musb);
 
 	/* disable usbss clocks */
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
