From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/3] musb: adding qh in_list and out_list in struct hw_ep
Date: Thu, 30 Oct 2008 14:42:51 +0530
Message-ID: <1225357971-10955-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44972 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbYJ3JNI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2008 05:13:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, me@felipebalbi.com, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>, Ravi Babu <ravibabu@ti.com>, Swaminathan S <swami.iyer@ti.com>, Thomas Abraham <t-abraham@ti.com>

Currently qh list for control, bulkin and bulkout are
part of musb structure as musb->control, musb->in_bulk
and musb->out_bulk.This patch makes it generic across
hw_ep by removing them from musb and mapping them to
in_list and out_list of hw_ep structure.

Signed-off-by: Ravi Babu <ravibabu@ti.com>
Signed-off-by: Swaminathan S <swami.iyer@ti.com>
Signed-off-by: Thomas Abraham <t-abraham@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |    6 +++---
 drivers/usb/musb/musb_core.h |    7 ++++---
 drivers/usb/musb/musb_host.c |   36 ++++++++++++++++++------------------
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index ebe0828..dbf8861 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1445,6 +1445,9 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 
 		hw_ep->regs = MUSB_EP_OFFSET(i, 0) + mbase;
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
+		/* init list of in and out qhs */
+		INIT_LIST_HEAD(&hw_ep->in_list);
+		INIT_LIST_HEAD(&hw_ep->out_list);
 		hw_ep->target_regs = MUSB_BUSCTL_OFFSET(i, 0) + mbase;
 		hw_ep->rx_reinit = 1;
 		hw_ep->tx_reinit = 1;
@@ -1790,9 +1793,6 @@ allocate_instance(struct device *dev,
 	/* usbcore sets dev->driver_data to hcd, and sometimes uses that... */
 
 	musb = hcd_to_musb(hcd);
-	INIT_LIST_HEAD(&musb->control);
-	INIT_LIST_HEAD(&musb->in_bulk);
-	INIT_LIST_HEAD(&musb->out_bulk);
 
 	hcd->uses_new_polling = 1;
 
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 4972a3b..27cd1e3 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -271,6 +271,10 @@ struct musb_hw_ep {
 	struct musb_qh		*in_qh;
 	struct musb_qh		*out_qh;
 
+	/* list of rx and tx qhs */
+	struct list_head        in_list;
+	struct list_head        out_list;
+
 	u8			rx_reinit;
 	u8			tx_reinit;
 #endif
@@ -328,9 +332,6 @@ struct musb {
 	 */
 	struct musb_hw_ep	*bulk_ep;
 
-	struct list_head	control;	/* of musb_qh */
-	struct list_head	in_bulk;	/* of musb_qh */
-	struct list_head	out_bulk;	/* of musb_qh */
 	struct musb_qh	*in[16];
 	struct musb_qh	*out[16];
 #endif
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index b77ca0b..014401c 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1223,7 +1223,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		 * transfer, if there's some other (nonperiodic) tx urb
 		 * that could use this fifo.  (dma complicates it...)
 		 *
-		 * if (bulk && qh->ring.next != &musb->out_bulk), then
+		 * if (bulk && qh->ring.next != &hw_ep->out_list), then
 		 * we have a candidate... NAKing is *NOT* an error
 		 */
 		musb_ep_select(mbase, epnum);
@@ -1449,13 +1449,13 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			 * transfer, if there's some other (nonperiodic) rx urb
 			 * that could use this fifo.  (dma complicates it...)
 			 *
-			 * if (bulk && qh->ring.next != &musb->in_bulk), then
+			 * if (bulk && qh->ring.next != &hw_wp->in_list), then
 			 * we have a candidate... NAKing is *NOT* an error
 			 */
 			DBG(6, "RX end %d NAK timeout\n", epnum);
 			if (usb_pipebulk(urb->pipe) && qh->mux == 1 &&
-				(musb->in_bulk.next->next != &musb->in_bulk) &&
-					bulk_nak_timeout) {
+				(hw_ep->in_list.next->next != &hw_ep->in_list)
+					 && bulk_nak_timeout) {
 				musb_bulk_nak_timeout(musb, hw_ep);
 				return;
 			}
@@ -1744,8 +1744,8 @@ static int musb_schedule(
 
 	/* use fixed hardware for control and bulk */
 	if (qh->type == USB_ENDPOINT_XFER_CONTROL) {
-		head = &musb->control;
 		hw_ep = musb->control_ep;
+		head = &hw_ep->in_list;
 		goto success;
 	}
 
@@ -1801,9 +1801,9 @@ static int musb_schedule(
 	if (best_end > 0 && qh->type == USB_ENDPOINT_XFER_BULK) {
 		hw_ep = musb->bulk_ep;
 		if (is_in)
-			head = &musb->in_bulk;
+			head = &hw_ep->in_list;
 		else
-			head = &musb->out_bulk;
+			head = &hw_ep->out_list;
 		goto success;
 	} else if (best_end < 0) {
 		return -ENOSPC;
@@ -2101,14 +2101,14 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	else {
 		switch (qh->type) {
 		case USB_ENDPOINT_XFER_CONTROL:
-			sched = &musb->control;
+			sched = &musb->control_ep->in_list;
 			break;
 		case USB_ENDPOINT_XFER_BULK:
 			if (qh->mux == 1) {
 				if (usb_pipein(urb->pipe))
-					sched = &musb->in_bulk;
+					sched = &musb->bulk_ep->in_list;
 				else
-					sched = &musb->out_bulk;
+					sched = &musb->bulk_ep->out_list;
 				break;
 			}
 		default:
@@ -2172,14 +2172,14 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 
 	switch (qh->type) {
 	case USB_ENDPOINT_XFER_CONTROL:
-		sched = &musb->control;
+		sched = &musb->control_ep->in_list;
 		break;
 	case USB_ENDPOINT_XFER_BULK:
 		if (qh->mux == 1) {
 			if (is_in)
-				sched = &musb->in_bulk;
+				sched = &musb->bulk_ep->in_list;
 			else
-				sched = &musb->out_bulk;
+				sched = &musb->bulk_ep->out_list;
 			break;
 		}
 	case USB_ENDPOINT_XFER_ISOC:
@@ -2305,7 +2305,7 @@ static void musb_bulk_nak_timeout(struct musb *musb, struct musb_hw_ep *ep)
 	rx_csr &= ~MUSB_RXCSR_DATAERROR;
 	musb_writew(epio, MUSB_RXCSR, rx_csr);
 
-	cur_qh = first_qh(&musb->in_bulk);
+	cur_qh = first_qh(&ep->in_list);
 	if (cur_qh) {
 		urb = next_urb(cur_qh);
 		if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
@@ -2316,12 +2316,12 @@ static void musb_bulk_nak_timeout(struct musb *musb, struct musb_hw_ep *ep)
 		}
 		musb_save_toggle(ep, 1, urb);
 
-		/* delete cur_qh and add to tail to musb->in_bulk */
+		/* delete cur_qh and add to tail of ep->in_list */
 		list_del(&cur_qh->ring);
-		list_add_tail(&cur_qh->ring, &musb->in_bulk);
+		list_add_tail(&cur_qh->ring, &ep->in_list);
 
-		/* get the next qh from musb->in_bulk */
-		next_qh = first_qh(&musb->in_bulk);
+		/* get the next qh from ep->in_list */
+		next_qh = first_qh(&ep->in_list);
 
 		/* set rx_reinit and schedule the next qh */
 		ep->rx_reinit = 1;
-- 
1.5.6

