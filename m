From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/4] usb: musb: Prepare dsps glue layer for PM runtime support
Date: Thu, 18 Aug 2016 15:46:48 -0700
Message-ID: <1471560410-6428-3-git-send-email-tony@atomide.com>
References: <1471560410-6428-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471560410-6428-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We want to be polling the state when nothing is connected.
Let's change the polling logic in preparation for PM runtime
support.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 2537179..ec0369b 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -247,6 +247,10 @@ static void otg_timer(unsigned long _musb)
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->otg->state) {
+	case OTG_STATE_A_WAIT_VRISE:
+		mod_timer(&glue->timer, jiffies +
+				msecs_to_jiffies(wrp->poll_timeout));
+		break;
 	case OTG_STATE_A_WAIT_BCON:
 		musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 		skip_session = 1;
@@ -338,7 +342,8 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 			MUSB_HST_MODE(musb);
 			musb->xceiv->otg->default_a = 1;
 			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
-			del_timer(&glue->timer);
+			mod_timer(&glue->timer, jiffies +
+				  msecs_to_jiffies(wrp->poll_timeout));
 		} else {
 			musb->is_active = 0;
 			MUSB_DEV_MODE(musb);
@@ -358,11 +363,17 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 	if (musb->int_tx || musb->int_rx || musb->int_usb)
 		ret |= musb_interrupt(musb);
 
-	/* Poll for ID change in OTG port mode */
-	if (musb->xceiv->otg->state == OTG_STATE_B_IDLE &&
-			musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
+	/* Poll for ID change and connect */
+	switch (musb->xceiv->otg->state) {
+	case OTG_STATE_B_IDLE:
+	case OTG_STATE_A_WAIT_BCON:
 		mod_timer(&glue->timer, jiffies +
-				msecs_to_jiffies(wrp->poll_timeout));
+			  msecs_to_jiffies(wrp->poll_timeout));
+		break;
+	default:
+		break;
+	}
+
 out:
 	spin_unlock_irqrestore(&musb->lock, flags);
 
@@ -461,6 +472,9 @@ static int dsps_musb_init(struct musb *musb)
 		musb_writeb(musb->mregs, MUSB_BABBLE_CTL, val);
 	}
 
+	mod_timer(&glue->timer, jiffies +
+		  msecs_to_jiffies(glue->wrp->poll_timeout));
+
 	return dsps_musb_dbg_init(musb, glue);
 }
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
