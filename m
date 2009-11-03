From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] musb: Inform user when gadget cable is disconnected
Date: Tue,  3 Nov 2009 12:05:39 +0530
Message-ID: <1257230140-12958-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently we don't see any message to inform user that gadget cable is
successfully disconnected leading to suspicion if everything is fine at
driver therefore adding an informative print message in gadget
disconnect path.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 3a61ddb..ec67ec7 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -795,6 +795,10 @@ static irqreturn_t musb_stage2_irq(struct musb *musb, u8 int_usb,
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 		case OTG_STATE_B_PERIPHERAL:
 		case OTG_STATE_B_IDLE:
+			printk(KERN_INFO "musb %s gadget disconnected.\n",
+				musb->gadget_driver
+				? musb->gadget_driver->driver.name
+				: "");
 			musb_g_disconnect(musb);
 			break;
 #endif	/* GADGET */
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
