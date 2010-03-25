From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 (v2) 02/11] USB: musb: support host/gadget role switching on Blackfin parts
Date: Thu, 25 Mar 2010 13:25:19 +0200
Message-ID: <1269516328-28267-3-git-send-email-felipe.balbi@nokia.com>
References: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48886 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab0CYL0u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 07:26:50 -0400
In-Reply-To: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Cliff Cai <cliff.cai@analog.com>, Mike Frysinger <vapier@gentoo.org>, Felipe Balbi <felipe.balbi@nokia.com>

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
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
-
 	default:
 		DBG(1, "%s state not handled\n", otg_state_string(musb));
 		break;
@@ -223,7 +280,7 @@ static void musb_conn_timer_handler(unsigned long _musb)
 
 void musb_platform_enable(struct musb *musb)
 {
-	if (is_host_enabled(musb)) {
+	if (!is_otg_enabled(musb) && is_host_enabled(musb)) {
 		mod_timer(&musb_conn_timer, jiffies + TIMER_DELAY);
 		musb->a_wait_bcon = TIMER_DELAY;
 	}
@@ -257,7 +314,7 @@ static int bfin_set_power(struct otg_transceiver *x, unsigned mA)
 
 void musb_platform_try_idle(struct musb *musb, unsigned long timeout)
 {
-	if (is_host_enabled(musb))
+	if (!is_otg_enabled(musb) && is_host_enabled(musb))
 		mod_timer(&musb_conn_timer, jiffies + TIMER_DELAY);
 }
 
-- 
1.7.0.rc0.33.g7c3932

