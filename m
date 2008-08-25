From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3] OMAP:MUSB: Corrects urb unlink function path
Date: Mon, 25 Aug 2008 10:52:16 +0530
Message-ID: <1219641736-3385-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fixes kernel panic while ISO IN transfer is aborted.Replaced
usb_hcd_unlink_urb_from_ep() from musb_giveback() to __musb_giveback()
to make sure urb is unlinked before giveback when __musb_giveback() is
called from musb_urb_dequeue().

Acquired musb->lock() before usb_hcd_unlink_urb_from_ep() within in 
enqueue path.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_host.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 08e421f..4279311 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -291,6 +291,7 @@ __acquires(musb->lock)
 			urb->actual_length, urb->transfer_buffer_length
 			);
 
+	usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
 	spin_unlock(&musb->lock);
 	usb_hcd_giveback_urb(musb_to_hcd(musb), urb, status);
 	spin_lock(&musb->lock);
@@ -353,8 +354,6 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
 		break;
 	}
 
-	usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
-
 	qh->is_ready = 0;
 	__musb_giveback(musb, urb, status);
 	qh->is_ready = ready;
@@ -1787,7 +1786,9 @@ static int musb_urb_enqueue(
 	 */
 	qh = kzalloc(sizeof *qh, mem_flags);
 	if (!qh) {
+		spin_lock_irqsave(&musb->lock, flags);
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
+		spin_unlock_irqrestore(&musb->lock, flags);
 		return -ENOMEM;
 	}
 
@@ -1899,7 +1900,9 @@ static int musb_urb_enqueue(
 
 done:
 	if (ret != 0) {
+		spin_lock_irqsave(&musb->lock, flags);
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
+		spin_unlock_irqrestore(&musb->lock, flags);
 		kfree(qh);
 	}
 	return ret;
-- 
1.5.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
