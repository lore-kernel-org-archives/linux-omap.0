From: ajay.gupta@ti.com
Subject: [PATCH v2] OMAP:MUSB: Corrects urb unlink function path
Date: Fri, 22 Aug 2008 22:43:10 +0530
Message-ID: <1219425190-13540-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52376 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbYHVRN1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Aug 2008 13:13:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Fixes kernel panic while ISO IN transfer is aborted.Replaced
usb_hcd_unlink_urb_from_ep() from musb_giveback() to __musb_giveback()
to make sure urb is unlinked before giveback when __musb_giveback() is
called from musb_urb_dequeue().

Moved usb_hcd_unlink_urb_from_ep() within musb->lock() in enqueue path.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_host.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 08e421f..2bdedf2 100644
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
@@ -1785,9 +1784,11 @@ static int musb_urb_enqueue(
 	 * REVISIT consider a dedicated qh kmem_cache, so it's harder
 	 * for bugs in other kernel code to break this driver...
 	 */
+	spin_lock_irqsave(&musb->lock, flags);
 	qh = kzalloc(sizeof *qh, mem_flags);
 	if (!qh) {
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
+		spin_unlock_irqrestore(&musb->lock, flags);
 		return -ENOMEM;
 	}
 
@@ -1878,7 +1879,6 @@ static int musb_urb_enqueue(
 	 * until we get real dma queues (with an entry for each urb/buffer),
 	 * we only have work to do in the former case.
 	 */
-	spin_lock_irqsave(&musb->lock, flags);
 	if (hep->hcpriv) {
 		/* some concurrent activity submitted another urb to hep...
 		 * odd, rare, error prone, but legal.
@@ -1895,13 +1895,13 @@ static int musb_urb_enqueue(
 		 * musb_start_urb(), but otherwise only konicawc cares ...
 		 */
 	}
-	spin_unlock_irqrestore(&musb->lock, flags);
 
 done:
 	if (ret != 0) {
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
 		kfree(qh);
 	}
+	spin_unlock_irqrestore(&musb->lock, flags);
 	return ret;
 }
 
-- 
1.5.6

