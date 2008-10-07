From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] MUSB: BULK request on different available endpoints
Date: Tue,  7 Oct 2008 15:07:37 +0530
Message-ID: <1223372257-8100-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fixes co-working issue of usb serial device with usb/net devices while
oter endpoints are free and can be used.This patch implements the policy
that if endpoint resources are available then different BULK request goes
to different endpoint otherwise they are multiplexed to one reserved
endpoint as currently done.

Switch statement case is reordered in musb_giveback() to take care of 
bulk request both in multiplex scenario and otherwise.

NAK limit scheme has to be added for multiplexed BULK request scenario
to avoid endpoint starvation due to usb/net devices.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
This patch is reworked and previous version is at,
http://marc.info/?l=linux-usb&m=122335817727285&w=2

Now it doesn't have fix for endpoint allocation logic.

 drivers/usb/musb/musb_host.c |   79 +++++++++++++++++++++++-------------------
 drivers/usb/musb/musb_host.h |    1 +
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 8b4be01..eb09811 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -379,6 +379,18 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
 
 		switch (qh->type) {
 
+		case USB_ENDPOINT_XFER_CONTROL:
+		case USB_ENDPOINT_XFER_BULK:
+			/* fifo policy for these lists, except that NAKing
+			 * should rotate a qh to the end (for fairness).
+			 */
+			if (qh->mux == 1) {
+				head = qh->ring.prev;
+				list_del(&qh->ring);
+				kfree(qh);
+				qh = first_qh(head);
+				break;
+			}
 		case USB_ENDPOINT_XFER_ISOC:
 		case USB_ENDPOINT_XFER_INT:
 			/* this is where periodic bandwidth should be
@@ -390,16 +402,6 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
 			qh = NULL;
 			break;
 
-		case USB_ENDPOINT_XFER_CONTROL:
-		case USB_ENDPOINT_XFER_BULK:
-			/* fifo policy for these lists, except that NAKing
-			 * should rotate a qh to the end (for fairness).
-			 */
-			head = qh->ring.prev;
-			list_del(&qh->ring);
-			kfree(qh);
-			qh = first_qh(head);
-			break;
 		}
 	}
 	return qh;
@@ -1672,22 +1674,9 @@ static int musb_schedule(
 	struct list_head	*head = NULL;
 
 	/* use fixed hardware for control and bulk */
-	switch (qh->type) {
-	case USB_ENDPOINT_XFER_CONTROL:
+	if (qh->type == USB_ENDPOINT_XFER_CONTROL) {
 		head = &musb->control;
 		hw_ep = musb->control_ep;
-		break;
-	case USB_ENDPOINT_XFER_BULK:
-		hw_ep = musb->bulk_ep;
-		if (is_in)
-			head = &musb->in_bulk;
-		else
-			head = &musb->out_bulk;
-		break;
-	}
-	if (head) {
-		idle = list_empty(head);
-		list_add_tail(&qh->ring, head);
 		goto success;
 	}
 
@@ -1726,19 +1715,33 @@ static int musb_schedule(
 		else
 			diff = hw_ep->max_packet_sz_tx - qh->maxpacket;
 
-		if (diff > 0 && best_diff > diff) {
+		if (diff >= 0 && best_diff > diff) {
 			best_diff = diff;
 			best_end = epnum;
 		}
 	}
-	if (best_end < 0)
+	/* use bulk reserved ep1 if no other ep is free*/
+	if (best_end < 0 && qh->type == USB_ENDPOINT_XFER_BULK) {
+		hw_ep = musb->bulk_ep;
+		if (is_in)
+			head = &musb->in_bulk;
+		else
+			head = &musb->out_bulk;
+		goto success;
+	} else if (best_end < 0)
 		return -ENOSPC;
 
 	idle = 1;
+	qh->mux = 0;
 	hw_ep = musb->endpoints + best_end;
 	musb->periodic[best_end] = qh;
 	DBG(4, "qh %p periodic slot %d\n", qh, best_end);
 success:
+	if (head) {
+		idle = list_empty(head);
+		list_add_tail(&qh->ring, head);
+		qh->mux = 1;
+	}
 	qh->hw_ep = hw_ep;
 	qh->hep->hcpriv = qh;
 	if (idle)
@@ -2008,11 +2011,13 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 			sched = &musb->control;
 			break;
 		case USB_ENDPOINT_XFER_BULK:
-			if (usb_pipein(urb->pipe))
-				sched = &musb->in_bulk;
-			else
-				sched = &musb->out_bulk;
-			break;
+			if (qh->mux == 1) {
+				if (usb_pipein(urb->pipe))
+					sched = &musb->in_bulk;
+				else
+					sched = &musb->out_bulk;
+				break;
+			}
 		default:
 			/* REVISIT when we get a schedule tree, periodic
 			 * transfers won't always be at the head of a
@@ -2060,11 +2065,13 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 		sched = &musb->control;
 		break;
 	case USB_ENDPOINT_XFER_BULK:
-		if (is_in)
-			sched = &musb->in_bulk;
-		else
-			sched = &musb->out_bulk;
-		break;
+		if (qh->mux == 1) {
+			if (is_in)
+				sched = &musb->in_bulk;
+			else
+				sched = &musb->out_bulk;
+			break;
+		}
 	default:
 		/* REVISIT when we get a schedule tree, periodic transfers
 		 * won't always be at the head of a singleton queue...
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 77bcdb9..0b7fbcd 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -53,6 +53,7 @@ struct musb_qh {
 
 	struct list_head	ring;		/* of musb_qh */
 	/* struct musb_qh		*next; */	/* for periodic tree */
+	u8			mux;		/* qh multiplexed to hw_ep */
 
 	unsigned		offset;		/* in urb->transfer_buffer */
 	unsigned		segsize;	/* current xfer fragment */
-- 
1.5.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
