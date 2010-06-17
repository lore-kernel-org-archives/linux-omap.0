From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Thu, 17 Jun 2010 16:10:36 +0530
Message-ID: <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55632 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759733Ab0FQKk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 06:40:56 -0400
In-Reply-To: <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, gregkh@suse.de, Ajay Kumar Gupta <ajay.gupta@ti.com>

Fixes below compilation warning when host only configuration is
selected.
drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
drivers/usb/musb/musb_core.c:711: warning: unused variable 'mbase'

Also removed definition of 'mbase' from multiple places to only
at function top.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f0ff893..7cc8398 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -455,6 +455,9 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 				u8 devctl, u8 power)
 {
 	irqreturn_t handled = IRQ_NONE;
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+	void __iomem	*mbase = musb->mregs;
+#endif
 
 	DBG(3, "<== Power=%02x, DevCtl=%02x, int_usb=0x%x\n", power, devctl,
 		int_usb);
@@ -469,8 +472,6 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 
 		if (devctl & MUSB_DEVCTL_HM) {
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
-			void __iomem *mbase = musb->mregs;
-
 			switch (musb->xceiv->state) {
 			case OTG_STATE_A_SUSPEND:
 				/* remote wakeup?  later, GetPortStatus
@@ -548,8 +549,6 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	/* see manual for the order of the tests */
 	if (int_usb & MUSB_INTR_SESSREQ) {
-		void __iomem *mbase = musb->mregs;
-
 		DBG(1, "SESSION_REQUEST (%s)\n", otg_state_string(musb));
 
 		/* IRQ arrives from ID pin sense or (later, if VBUS power
@@ -598,8 +597,6 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 		case OTG_STATE_A_WAIT_BCON:
 		case OTG_STATE_A_WAIT_VRISE:
 			if (musb->vbuserr_retry) {
-				void __iomem *mbase = musb->mregs;
-
 				musb->vbuserr_retry--;
 				ignore = 1;
 				devctl |= MUSB_DEVCTL_SESSION;
@@ -703,7 +700,6 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 
 	if (int_usb & MUSB_INTR_CONNECT) {
 		struct usb_hcd *hcd = musb_to_hcd(musb);
-		void __iomem *mbase = musb->mregs;
 
 		handled = IRQ_HANDLED;
 		musb->is_active = 1;
-- 
1.6.2.4

