From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/36] musb_hdrc: Search and replace bDone with done
Date: Thu, 16 Aug 2007 02:40:37 -0700
Message-ID: <1187257291525-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
	<1187257278289-git-send-email-tony@atomide.com>
	<11872572803477-git-send-email-tony@atomide.com>
	<1187257282941-git-send-email-tony@atomide.com>
	<11872572842479-git-send-email-tony@atomide.com>
	<11872572872790-git-send-email-tony@atomide.com>
	<11872572893163-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872572893163-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace bDone with done

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   52 +++++++++++++++++++++---------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 6e1987c..e821831 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -472,7 +472,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 	u16 rx_count;
 	u8 *buf;
 	u16 csr;
-	u8 bDone = FALSE;
+	u8 done = FALSE;
 	u32			length;
 	int			do_flush = 0;
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
@@ -515,7 +515,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 		d->status = status;
 
 		/* see if we are done */
-		bDone = (++qh->iso_idx >= urb->number_of_packets);
+		done = (++qh->iso_idx >= urb->number_of_packets);
 	} else {
 		/* non-isoch */
 		buf = buffer + qh->offset;
@@ -531,10 +531,10 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 		qh->offset += length;
 
 		/* see if we are done */
-		bDone = (urb->actual_length == urb->transfer_buffer_length)
+		done = (urb->actual_length == urb->transfer_buffer_length)
 			|| (rx_count < qh->maxpacket)
 			|| (urb->status != -EINPROGRESS);
-		if (bDone
+		if (done
 				&& (urb->status == -EINPROGRESS)
 				&& (urb->transfer_flags & URB_SHORT_NOT_OK)
 				&& (urb->actual_length
@@ -551,12 +551,12 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 	else {
 		/* REVISIT this assumes AUTOCLEAR is never set */
 		csr &= ~(MUSB_RXCSR_RXPKTRDY | MUSB_RXCSR_H_REQPKT);
-		if (!bDone)
+		if (!done)
 			csr |= MUSB_RXCSR_H_REQPKT;
 		musb_writew(epio, MUSB_RXCSR, csr);
 	}
 
-	return bDone;
+	return done;
 }
 
 /* we don't always need to reinit a given side of an endpoint...
@@ -1165,7 +1165,7 @@ done:
 void musb_host_tx(struct musb *musb, u8 epnum)
 {
 	int			nPipe;
-	u8			bDone = FALSE;
+	u8			done = FALSE;
 	u16			tx_csr;
 	size_t			wLength = 0;
 	u8			*buf = NULL;
@@ -1247,7 +1247,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		musb_writew(epio, MUSB_TXCSR, tx_csr);
 		musb_writeb(epio, MUSB_TXINTERVAL, 0);
 
-		bDone = TRUE;
+		done = TRUE;
 	}
 
 	/* second cppi case */
@@ -1271,23 +1271,23 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 			d = urb->iso_frame_desc + qh->iso_idx;
 			d->actual_length = qh->segsize;
 			if (++qh->iso_idx >= urb->number_of_packets) {
-				bDone = TRUE;
+				done = TRUE;
 			} else if (!dma) {
 				d++;
 				buf = urb->transfer_buffer + d->offset;
 				wLength = d->length;
 			}
 		} else if (dma) {
-			bDone = TRUE;
+			done = TRUE;
 		} else {
 			/* see if we need to send more data, or ZLP */
 			if (qh->segsize < qh->maxpacket)
-				bDone = TRUE;
+				done = TRUE;
 			else if (qh->offset == urb->transfer_buffer_length
 					&& !(urb-> transfer_flags
 							& URB_ZERO_PACKET))
-				bDone = TRUE;
-			if (!bDone) {
+				done = TRUE;
+			if (!done) {
 				buf = urb->transfer_buffer
 						+ qh->offset;
 				wLength = urb->transfer_buffer_length
@@ -1300,12 +1300,12 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	 * so we must abort this transfer after cleanup
 	 */
 	if (urb->status != -EINPROGRESS) {
-		bDone = TRUE;
+		done = TRUE;
 		if (status == 0)
 			status = urb->status;
 	}
 
-	if (bDone) {
+	if (done) {
 		/* set status */
 		urb->status = status;
 		urb->actual_length = qh->offset;
@@ -1388,7 +1388,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	int			nPipe;
 	u16			rx_csr, wVal;
 	u8			bIsochError = FALSE;
-	u8			bDone = FALSE;
+	u8			done = FALSE;
 	u32			status;
 	struct dma_channel	*dma;
 
@@ -1466,7 +1466,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		}
 		musb_h_flush_rxfifo(hw_ep, 0);
 		musb_writeb(epio, MUSB_RXINTERVAL, 0);
-		bDone = TRUE;
+		done = TRUE;
 		goto finish;
 	}
 
@@ -1494,7 +1494,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			dma->status = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
 			xfer_len = dma->actual_len;
-			bDone = TRUE;
+			done = TRUE;
 		}
 
 		DBG(2, "RXCSR%d %04x, reqpkt, len %zd%s\n", epnum, rx_csr,
@@ -1516,24 +1516,24 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		musb_writew(hw_ep->regs, MUSB_RXCSR, wVal);
 
 #ifdef CONFIG_USB_INVENTRA_DMA
-		/* bDone if urb buffer is full or short packet is recd */
-		bDone = ((urb->actual_length + xfer_len) >=
+		/* done if urb buffer is full or short packet is recd */
+		done = ((urb->actual_length + xfer_len) >=
 				urb->transfer_buffer_length)
 			|| (dma->actual_len & (qh->maxpacket - 1));
 
 		/* send IN token for next packet, without AUTOREQ */
-		if (!bDone) {
+		if (!done) {
 			wVal |= MUSB_RXCSR_H_REQPKT;
 			musb_writew(epio, MUSB_RXCSR,
 				MUSB_RXCSR_H_WZC_BITS | wVal);
 		}
 
 		DBG(4, "ep %d dma %s, rxcsr %04x, rxcount %d\n", epnum,
-			bDone ? "off" : "reset",
+			done ? "off" : "reset",
 			musb_readw(epio, MUSB_RXCSR),
 			musb_readw(epio, MUSB_RXCOUNT));
 #else
-		bDone = TRUE;
+		done = TRUE;
 #endif
 	} else if (urb->status == -EINPROGRESS) {
 		/* if no errors, be sure a packet is ready for unloading */
@@ -1633,16 +1633,16 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 #endif	/* Mentor DMA */
 
 		if (!dma) {
-			bDone = musb_host_packet_rx(musb, urb,
+			done = musb_host_packet_rx(musb, urb,
 					epnum, bIsochError);
-			DBG(6, "read %spacket\n", bDone ? "last " : "");
+			DBG(6, "read %spacket\n", done ? "last " : "");
 		}
 	}
 
 finish:
 	urb->actual_length += xfer_len;
 	qh->offset += xfer_len;
-	if (bDone) {
+	if (done) {
 		if (urb->status == -EINPROGRESS)
 			urb->status = status;
 		musb_advance_schedule(musb, urb, hw_ep, USB_DIR_IN);
-- 
1.5.2.3
