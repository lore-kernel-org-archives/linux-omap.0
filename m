From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] usb: musb: fix bug in musb_start_urb
Date: Fri,  6 Feb 2009 17:22:26 +0530
Message-ID: <1233921146-4046-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

urb->transfer_buffer_length and urb->transfer_buffer should be
updated based on urb->actual_length.For a fresh and first time urb,
actual_length will be zero but for urbs which has been stopped and
restarted (as bulk nak scheme does) actual_length may not be zero.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_host.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index a776951..1a78f00 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -201,8 +201,8 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 		len = urb->iso_frame_desc[0].length;
 		break;
 	default:		/* bulk, interrupt */
-		buf = urb->transfer_buffer;
-		len = urb->transfer_buffer_length;
+		buf = urb->transfer_buffer + urb->actual_length;
+		len = urb->transfer_buffer_length - urb->actual_length;
 	}
 
 	DBG(4, "qh %p urb %p dev%d ep%d%s%s, hw_ep %d, %p/%d\n",
-- 
1.5.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
