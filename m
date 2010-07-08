From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/4] usb: musb: fix compilation warning in host only mode
Date: Thu,  8 Jul 2010 14:03:00 +0530
Message-ID: <1278577982-30046-3-git-send-email-ajay.gupta@ti.com>
References: <1278577982-30046-1-git-send-email-ajay.gupta@ti.com>
 <1278577982-30046-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47011 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754208Ab0GHIdS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jul 2010 04:33:18 -0400
In-Reply-To: <1278577982-30046-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, gregkh@suse.de, Ajay Kumar Gupta <ajay.gupta@ti.com>

Fixes below compilation warning when host only configuration is
selected.
drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
drivers/usb/musb/musb_core.c:711: warning: unused variable 'mbase'

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 3b795c5..540c766 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -704,7 +704,6 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	if (int_usb & MUSB_INTR_CONNECT) {
 		struct usb_hcd *hcd = musb_to_hcd(musb);
-		void __iomem *mbase = musb->mregs;
 
 		handled = IRQ_HANDLED;
 		musb->is_active = 1;
@@ -717,9 +716,9 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 		if (is_peripheral_active(musb)) {
 			/* REVISIT HNP; just force disconnect */
 		}
-		musb_writew(mbase, MUSB_INTRTXE, musb->epmask);
-		musb_writew(mbase, MUSB_INTRRXE, musb->epmask & 0xfffe);
-		musb_writeb(mbase, MUSB_INTRUSBE, 0xf7);
+		musb_writew(musb->mregs, MUSB_INTRTXE, musb->epmask);
+		musb_writew(musb->mregs, MUSB_INTRRXE, musb->epmask & 0xfffe);
+		musb_writeb(musb->mregs, MUSB_INTRUSBE, 0xf7);
 #endif
 		musb->port1_status &= ~(USB_PORT_STAT_LOW_SPEED
 					|USB_PORT_STAT_HIGH_SPEED
-- 
1.6.2.4

