From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 8/8] usb: musb: Fix suspend interrupt issue in device mode
Date: Thu, 17 Jun 2010 16:10:41 +0530
Message-ID: <1276771242-5201-9-git-send-email-ajay.gupta@ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-5-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-6-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-7-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-8-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53707 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759815Ab0FQKk7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Jun 2010 06:40:59 -0400
In-Reply-To: <1276771242-5201-8-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, gregkh@suse.de, Maulik Mankad <x0082077@ti.com>, David Brownell <david-b@pacbell.net>, Ajay Kumar Gupta <ajay.gupta@ti.com>

From: Maulik Mankad <x0082077@ti.com>

As a part of aligning the ISR code for MUSB with the specs, the
ISR code was re-written.

See Commit 1c25fda4a09e8229800979986ef399401053b46e (usb: musb: handle
irqs in the order dictated by programming guide)

With this the suspend interrupt came accidently under CONFIG_USB_MUSB_HDRC_HCD.

The fix brings suspend interrupt handling outside
CONFIG_USB_MUSB_HDRC_HCD.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <david-b@pacbell.net>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 4f43db7..64b08f9 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -635,7 +635,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 		handled = IRQ_HANDLED;
 	}
 
-
+#endif
 	if (int_usb & MUSB_INTR_SUSPEND) {
 		DBG(1, "SUSPEND (%s) devctl %02x power %02x\n",
 				otg_state_string(musb), devctl, power);
@@ -698,6 +698,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 		}
 	}
 
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
 	if (int_usb & MUSB_INTR_CONNECT) {
 		struct usb_hcd *hcd = musb_to_hcd(musb);
 
-- 
1.6.2.4

