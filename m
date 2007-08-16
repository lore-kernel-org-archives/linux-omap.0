From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/36] musb_hdrc: Search and replace pBuffer with buf
Date: Thu, 16 Aug 2007 02:40:32 -0700
Message-ID: <11872572803477-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
	<1187257278289-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187257278289-git-send-email-tony@atomide.com>
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

Search and replace pBuffer with buf

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 3b94630..4390e42 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -105,7 +105,7 @@
 
 static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, unsigned int nOut,
-			u8 * pBuffer, u32 dwLength);
+			u8 * buf, u32 dwLength);
 
 /*
  * Clear TX fifo. Needed to avoid BABBLE errors.
@@ -171,7 +171,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 {
 	u16			wFrame;
 	u32			dwLength;
-	void			*pBuffer;
+	void			*buf;
 	void __iomem		*mbase =  musb->mregs;
 	struct urb		*urb = next_urb(qh);
 	struct musb_hw_ep	*hw_ep = qh->hw_ep;
@@ -190,17 +190,17 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 		is_in = 0;
 		hw_ep->out_qh = qh;
 		musb->ep0_stage = MGC_END0_START;
-		pBuffer = urb->setup_packet;
+		buf = urb->setup_packet;
 		dwLength = 8;
 		break;
 	case USB_ENDPOINT_XFER_ISOC:
 		qh->iso_idx = 0;
 		qh->frame = 0;
-		pBuffer = urb->transfer_buffer + urb->iso_frame_desc[0].offset;
+		buf = urb->transfer_buffer + urb->iso_frame_desc[0].offset;
 		dwLength = urb->iso_frame_desc[0].length;
 		break;
 	default:		/* bulk, interrupt */
-		pBuffer = urb->transfer_buffer;
+		buf = urb->transfer_buffer;
 		dwLength = urb->transfer_buffer_length;
 	}
 
@@ -213,14 +213,14 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 			case USB_ENDPOINT_XFER_ISOC:	s = "-iso"; break;
 			default:			s = "-intr"; break;
 			}; s;}),
-			epnum, pBuffer, dwLength);
+			epnum, buf, dwLength);
 
 	/* Configure endpoint */
 	if (is_in || hw_ep->is_shared_fifo)
 		hw_ep->in_qh = qh;
 	else
 		hw_ep->out_qh = qh;
-	musb_ep_program(musb, epnum, urb, !is_in, pBuffer, dwLength);
+	musb_ep_program(musb, epnum, urb, !is_in, buf, dwLength);
 
 	/* transmit may have more work: start it when it is time */
 	if (is_in)
@@ -470,7 +470,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 		u8 epnum, u8 bIsochError)
 {
 	u16 wRxCount;
-	u8 *pBuffer;
+	u8 *buf;
 	u16 csr;
 	u8 bDone = FALSE;
 	u32			length;
@@ -498,7 +498,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 		}
 
 		d = urb->iso_frame_desc + qh->iso_idx;
-		pBuffer = buffer + d->offset;
+		buf = buffer + d->offset;
 		length = d->length;
 		if (wRxCount > length) {
 			if (status == 0) {
@@ -518,7 +518,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 		bDone = (++qh->iso_idx >= urb->number_of_packets);
 	} else {
 		/* non-isoch */
-		pBuffer = buffer + qh->offset;
+		buf = buffer + qh->offset;
 		length = urb->transfer_buffer_length - qh->offset;
 		if (wRxCount > length) {
 			if (urb->status == -EINPROGRESS)
@@ -542,7 +542,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 			urb->status = -EREMOTEIO;
 	}
 
-	musb_read_fifo(hw_ep, length, pBuffer);
+	musb_read_fifo(hw_ep, length, buf);
 
 	csr = musb_readw(epio, MUSB_RXCSR);
 	csr |= MUSB_RXCSR_H_WZC_BITS;
@@ -625,7 +625,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
  */
 static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, unsigned int is_out,
-			u8 * pBuffer, u32 dwLength)
+			u8 * buf, u32 dwLength)
 {
 	struct dma_controller	*dma_controller;
 	struct dma_channel	*pDmaChannel;
@@ -855,7 +855,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 			/* PIO to load FIFO */
 			qh->segsize = wLoadCount;
-			musb_write_fifo(hw_ep, wLoadCount, pBuffer);
+			musb_write_fifo(hw_ep, wLoadCount, buf);
 			csr = musb_readw(epio, MUSB_TXCSR);
 			csr &= ~(MUSB_TXCSR_DMAENAB
 				| MUSB_TXCSR_DMAMODE
@@ -1168,7 +1168,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	u8			bDone = FALSE;
 	u16			tx_csr;
 	size_t			wLength = 0;
-	u8			*pBuffer = NULL;
+	u8			*buf = NULL;
 	struct urb		*urb;
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
 	void __iomem		*epio = hw_ep->regs;
@@ -1274,7 +1274,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 				bDone = TRUE;
 			} else if (!dma) {
 				d++;
-				pBuffer = urb->transfer_buffer + d->offset;
+				buf = urb->transfer_buffer + d->offset;
 				wLength = d->length;
 			}
 		} else if (dma) {
@@ -1288,7 +1288,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 							& URB_ZERO_PACKET))
 				bDone = TRUE;
 			if (!bDone) {
-				pBuffer = urb->transfer_buffer
+				buf = urb->transfer_buffer
 						+ qh->offset;
 				wLength = urb->transfer_buffer_length
 						- qh->offset;
@@ -1312,7 +1312,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		musb_advance_schedule(musb, urb, hw_ep, USB_DIR_OUT);
 
 	} else if (!(tx_csr & MUSB_TXCSR_DMAENAB)) {
-		// WARN_ON(!pBuffer);
+		// WARN_ON(!buf);
 
 		/* REVISIT:  some docs say that when hw_ep->tx_double_buffered,
 		 * (and presumably, fifo is not half-full) we should write TWO
@@ -1320,7 +1320,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		 */
 		/* PIO:  start next packet in this URB */
 		wLength = min(qh->maxpacket, (u16) wLength);
-		musb_write_fifo(hw_ep, wLength, pBuffer);
+		musb_write_fifo(hw_ep, wLength, buf);
 		qh->segsize = wLength;
 
 		musb_ep_select(mbase, epnum);
-- 
1.5.2.3
