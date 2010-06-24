From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Thu, 24 Jun 2010 16:47:54 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E9E38CA@dbde02.ent.ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <20100624060338.GF8078@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46368 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab0FXLSG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 07:18:06 -0400
In-Reply-To: <20100624060338.GF8078@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>

> >+#ifdef CONFIG_USB_MUSB_HDRC_HCD
> >+	void __iomem	*mbase = musb->mregs;
> >+#endif
> 
> then you add another ifdef to this file, which is already insane. I'd
> rather see you either keep the local variables and just fix what needs
> to be fixed, 

> or use musb->mregs directly.
This one seems to be a much better one. Copying the v-3 with this fix below.

-------------- cut here --------------------
Fixes below compilation warning when host only configuration is
selected.
drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
drivers/usb/musb/musb_core.c:711: warning: unused variable 'mbase'

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index a8b0440..ed6e1a4 100644
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
--------------------------------------------

Thanks,
Ajay
> 
