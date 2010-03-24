From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.35 02/11] USB: musb: support host/gadget role switching on Blackfin parts
Date: Wed, 24 Mar 2010 14:55:09 +0200
Message-ID: <1269435318-29153-3-git-send-email-felipe.balbi@nokia.com>
References: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269435318-29153-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/blackfin.c |   69 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 3774815..78f33b9 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -171,6 +171,13 @@ static irqreturn_t blackfin_interrupt(int irq, void *__hci)
 		retval = musb_interrupt(musb);
 	}
 
+	/* Start sampling ID pin, when plug is removed from MUSB */
+	if (is_otg_enabled(musb) && (musb->xceiv->state == OTG_STATE_B_IDLE
+		|| musb->xceiv->state == OTG_STATE_A_WAIT_BCON)) {
+		mod_timer(&musb_conn_timer, jiffies + TIMER_DELAY);
+		musb->a_wait_bcon = TIMER_DELAY;
+	}
+
 	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return retval;
@@ -181,6 +188,7 @@ static void musb_conn_timer_handler(unsigned long _musb)
 	struct musb *musb = (void *)_musb;
 	unsigned long flags;
 	u16 val;
+	static u8 toggle;
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
@@ -188,10 +196,44 @@ static void musb_conn_timer_handler(unsigned long _musb)
 	case OTG_STATE_A_WAIT_BCON:
 		/* Start a new session */
 		val = musb_readw(musb->mregs, MUSB_DEVCTL);
+		val &= ~MUSB_DEVCTL_SESSION;
+		musb_writew(musb->mregs, MUSB_DEVCTL, val);
 		val |= MUSB_DEVCTL_SESSION;
 		musb_writew(musb->mregs, MUSB_DEVCTL, val);
+		/* Check if musb is host or peripheral. */
+		val = musb_readw(musb->mregs, MUSB_DEVCTL);
+
+		if (!(val & MUSB_DEVCTL_BDEVICE)) {
+			gpio_set_value(musb->config->gpio_vrsel, 1);
+			musb->xceiv->state = OTG_STATE_A_WAIT_BCON;
+		} else {
+			gpio_set_value(musb->config->gpio_vrsel, 0);
+			/* Ignore VBUSERROR and SUSPEND IRQ */
+			val = musb_readb(musb->mregs, MUSB_INTRUSBE);
+			val &= ~MUSB_INTR_VBUSERROR;
+			musb_writeb(musb->mregs, MUSB_INTRUSBE, val);
 
+			val = MUSB_INTR_SUSPEND | MUSB_INTR_VBUSERROR;
+			musb_writeb(musb->mregs, MUSB_INTRUSB, val);
+			if (is_otg_enabled(musb))
+				musb->xceiv->state = OTG_STATE_B_IDLE;
+			else
+				musb_writeb(musb->mregs, MUSB_POWER, MUSB_POWER_HSENAB);
+		}
+		mod_timer(&musb_conn_timer, jiffies + TIMER_DELAY);
+		break;
+	case OTG_STATE_B_IDLE:
+
+		if (!is_peripheral_enabled(musb))
+			break;
+		/* Start a new session.  It seems that MUSB needs taking
+		 * some time to recognize the type of the plug inserted?
+		 */
 		val = musb_readw(musb->mregs, MUSB_DEVCTL);
+		val |= MUSB_DEVCTL_SESSION;
+		musb_writew(musb->mregs, MUSB_DEVCTL, val);
+		val = musb_readw(musb->mregs, MUSB_DEVCTL);
+
 		if (!(val & MUSB_DEVCTL_BDEVICE)) {
 			gpio_set_value(musb->config->gpio_vrsel, 1);
 			musb->xceiv->state = OTG_STATE_A_WAIT_BCON;
@@ -206,12 +248,27 @@ static void musb_conn_timer_handler(unsigned long _musb)
 			val = MUSB_INTR_SUSPEND | MUSB_INTR_VBUSERROR;
 			musb_writeb(musb->mregs, MUSB_INTRUSB, val);
 
-			val = MUSB_POWER_HSENAB;
-			musb_writeb(musb->mregs, MUSB_POWER, val);
+			/* Toggle the Soft Conn bit, so that we can response to
+			 * the inserting of either A-plug or B-plug.
+			 */
+			if (toggle) {
+				val = musb_readb(musb->mregs, MUSB_POWER);
+				val &= ~MUSB_POWER_SOFTCONN;
+				musb_writeb(musb->mregs, MUSB_POWER, val);
+				toggle = 0;
+			} else {
+				val = musb_readb(musb->mregs, MUSB_POWER);
+				val |= MUSB_POWER_SOFTCONN;
+				musb_writeb(musb->mregs, MUSB_POWER, val);
+				toggle = 1;
+			}
+			/* The delay time is set to 1/4 second by default,
+			 * shortening it, if accelerating A-plug detection
+			 * is needed in OTG mode.
+			 */
+			mod_timer(&musb_conn_timer, jiffies + TIMER_DELAY / 4);
 		}
-		mod_timer(&musb_conn_timer, jiffies + TIMER_DELAY);
 		break;
