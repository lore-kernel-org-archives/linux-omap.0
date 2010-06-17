From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 8/8] usb: musb: Fix suspend interrupt issue in device mode
Date: Thu, 17 Jun 2010 16:10:42 +0530
Message-ID: <1276771242-5201-10-git-send-email-ajay.gupta@ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-5-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-6-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-7-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-8-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-9-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1276771242-5201-9-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>

As a part of aligning the ISR code for MUSB with the specs, the
ISR code was re-written.

See Commit 1c25fda4a09e8229800979986ef399401053b46e (usb: musb: handle
irqs in the order dictated by programming guide)

With this the suspend interrupt came accidently under CONFIG_USB_MUSB_HDRC_HCD.

The fix brings suspend interrupt handling outside
CONFIG_USB_MUSB_HDRC_HCD.

Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
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
 
