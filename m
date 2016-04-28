From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/10] usb: musb: Remove try_idle for 2430 glue layer
Date: Thu, 28 Apr 2016 10:33:18 -0700
Message-ID: <1461864800-29979-9-git-send-email-tony@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461864800-29979-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is no longer needed with PM runtime at least for 2430 glue.
We can now rely only on PM runtime and cable detection.

The other glue layers can probably remove try_idle too, but that
needs to be tested for each platform before doing it.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/omap2430.c | 91 ---------------------------------------------
 1 file changed, 91 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index b274923..c352511 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -54,92 +54,6 @@ struct omap2430_glue {
 
 static struct omap2430_glue	*_glue;
 
-static struct timer_list musb_idle_timer;
-
-static void musb_do_idle(unsigned long _musb)
-{
-	struct musb	*musb = (void *)_musb;
-	unsigned long	flags;
-	u8	power;
-	u8	devctl;
-
-	spin_lock_irqsave(&musb->lock, flags);
-
-	switch (musb->xceiv->otg->state) {
-	case OTG_STATE_A_WAIT_BCON:
-
-		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
-		if (devctl & MUSB_DEVCTL_BDEVICE) {
-			musb->xceiv->otg->state = OTG_STATE_B_IDLE;
-			MUSB_DEV_MODE(musb);
-		} else {
-			musb->xceiv->otg->state = OTG_STATE_A_IDLE;
-			MUSB_HST_MODE(musb);
-		}
-		break;
-	case OTG_STATE_A_SUSPEND:
-		/* finish RESUME signaling? */
-		if (musb->port1_status & MUSB_PORT_STAT_RESUME) {
-			power = musb_readb(musb->mregs, MUSB_POWER);
-			power &= ~MUSB_POWER_RESUME;
-			dev_dbg(musb->controller, "root port resume stopped, power %02x\n", power);
-			musb_writeb(musb->mregs, MUSB_POWER, power);
-			musb->is_active = 1;
-			musb->port1_status &= ~(USB_PORT_STAT_SUSPEND
-						| MUSB_PORT_STAT_RESUME);
-			musb->port1_status |= USB_PORT_STAT_C_SUSPEND << 16;
-			usb_hcd_poll_rh_status(musb->hcd);
-			/* NOTE: it might really be A_WAIT_BCON ... */
-			musb->xceiv->otg->state = OTG_STATE_A_HOST;
-		}
-		break;
-	case OTG_STATE_A_HOST:
-		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
-		if (devctl &  MUSB_DEVCTL_BDEVICE)
-			musb->xceiv->otg->state = OTG_STATE_B_IDLE;
-		else
-			musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
-	default:
-		break;
-	}
-	spin_unlock_irqrestore(&musb->lock, flags);
-}
-
-
-static void omap2430_musb_try_idle(struct musb *musb, unsigned long timeout)
-{
-	unsigned long		default_timeout = jiffies + msecs_to_jiffies(3);
-	static unsigned long	last_timer;
-
-	if (timeout == 0)
-		timeout = default_timeout;
-
-	/* Never idle if active, or when VBUS timeout is not set as host */
-	if (musb->is_active || ((musb->a_wait_bcon == 0)
-			&& (musb->xceiv->otg->state == OTG_STATE_A_WAIT_BCON))) {
-		dev_dbg(musb->controller, "%s active, deleting timer\n",
-			usb_otg_state_string(musb->xceiv->otg->state));
-		del_timer(&musb_idle_timer);
-		last_timer = jiffies;
-		return;
-	}
-
-	if (time_after(last_timer, timeout)) {
-		if (!timer_pending(&musb_idle_timer))
-			last_timer = timeout;
-		else {
-			dev_dbg(musb->controller, "Longer idle timer already pending, ignoring\n");
-			return;
-		}
-	}
-	last_timer = timeout;
-
-	dev_dbg(musb->controller, "%s inactive, for idle timer for %lu ms\n",
-		usb_otg_state_string(musb->xceiv->otg->state),
-		(unsigned long)jiffies_to_msecs(timeout - jiffies));
-	mod_timer(&musb_idle_timer, timeout);
-}
-
 static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
 {
 	struct usb_otg	*otg = musb->xceiv->otg;
@@ -427,8 +341,6 @@ static int omap2430_musb_init(struct musb *musb)
 			musb_readl(musb->mregs, OTG_INTERFSEL),
 			musb_readl(musb->mregs, OTG_SIMENABLE));
 
-	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
-
 	if (glue->status != MUSB_UNKNOWN)
 		omap_musb_set_mailbox(glue);
 
@@ -493,7 +405,6 @@ static int omap2430_musb_exit(struct musb *musb)
 	struct device *dev = musb->controller;
 	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
 
-	del_timer_sync(&musb_idle_timer);
 	pm_runtime_get_sync(glue->dev);
 	omap2430_low_level_exit(musb);
 	pm_runtime_put_sync_suspend(glue->dev);
@@ -515,8 +426,6 @@ static const struct musb_platform_ops omap2430_ops = {
 	.exit		= omap2430_musb_exit,
 
 	.set_mode	= omap2430_musb_set_mode,
-	.try_idle	= omap2430_musb_try_idle,
