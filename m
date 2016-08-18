From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] usb: musb: Fix locking errors for host only mode
Date: Thu, 18 Aug 2016 15:40:38 -0700
Message-ID: <1471560038-6243-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

If we have USB gadgets disabled and USB_MUSB_HOST set, we get
errors "possible irq lock inverssion dependency detected"
errors during boot.

Let's fix the issue by adding start_musb flag and start
the controller after we're out of the spinlock protected
section.

Reported-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Tested-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_virthub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index 192248f..fe08e77 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -290,6 +290,7 @@ int musb_hub_control(
 	u32		temp;
 	int		retval = 0;
 	unsigned long	flags;
+	bool		start_musb = false;
 
 	spin_lock_irqsave(&musb->lock, flags);
 
@@ -390,7 +391,7 @@ int musb_hub_control(
 			 * logic relating to VBUS power-up.
 			 */
 			if (!hcd->self.is_b_host && musb_has_gadget(musb))
-				musb_start(musb);
+				start_musb = true;
 			break;
 		case USB_PORT_FEAT_RESET:
 			musb_port_reset(musb, true);
@@ -451,5 +452,9 @@ error:
 		retval = -EPIPE;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
+
+	if (start_musb)
+		musb_start(musb);
+
 	return retval;
 }
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
