From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/36] musb_hdrc: Search and replace wRxCount with rx_count
Date: Thu, 16 Aug 2007 02:40:36 -0700
Message-ID: <11872572893163-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872572872790-git-send-email-tony@atomide.com>
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

Search and replace wRxCount with rx_count

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index ea30146..6e1987c 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -469,7 +469,7 @@ static inline u16 musb_h_flush_rxfifo(struct musb_hw_ep *hw_ep, u16 csr)
 static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 		u8 epnum, u8 bIsochError)
 {
-	u16 wRxCount;
+	u16 rx_count;
 	u8 *buf;
 	u16 csr;
 	u8 bDone = FALSE;
@@ -482,8 +482,8 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 	void			*buffer = urb->transfer_buffer;
 
 	// musb_ep_select(mbase, epnum);
-	wRxCount = musb_readw(epio, MUSB_RXCOUNT);
-	DBG(3, "RX%d count %d, buffer %p len %d/%d\n", epnum, wRxCount,
+	rx_count = musb_readw(epio, MUSB_RXCOUNT);
+	DBG(3, "RX%d count %d, buffer %p len %d/%d\n", epnum, rx_count,
 			urb->transfer_buffer, qh->offset,
 			urb->transfer_buffer_length);
 
@@ -500,15 +500,15 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 		d = urb->iso_frame_desc + qh->iso_idx;
 		buf = buffer + d->offset;
 		length = d->length;
-		if (wRxCount > length) {
+		if (rx_count > length) {
 			if (status == 0) {
 				status = -EOVERFLOW;
 				urb->error_count++;
 			}
-			DBG(2, "** OVERFLOW %d into %d\n", wRxCount, length);
+			DBG(2, "** OVERFLOW %d into %d\n", rx_count, length);
 			do_flush = 1;
 		} else
-			length = wRxCount;
+			length = rx_count;
 		urb->actual_length += length;
 		d->actual_length = length;
 
@@ -520,19 +520,19 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 		/* non-isoch */
 		buf = buffer + qh->offset;
 		length = urb->transfer_buffer_length - qh->offset;
-		if (wRxCount > length) {
+		if (rx_count > length) {
 			if (urb->status == -EINPROGRESS)
 				urb->status = -EOVERFLOW;
-			DBG(2, "** OVERFLOW %d into %d\n", wRxCount, length);
+			DBG(2, "** OVERFLOW %d into %d\n", rx_count, length);
 			do_flush = 1;
 		} else
-			length = wRxCount;
+			length = rx_count;
 		urb->actual_length += length;
 		qh->offset += length;
 
 		/* see if we are done */
 		bDone = (urb->actual_length == urb->transfer_buffer_length)
-			|| (wRxCount < qh->maxpacket)
+			|| (rx_count < qh->maxpacket)
 			|| (urb->status != -EINPROGRESS);
 		if (bDone
 				&& (urb->status == -EINPROGRESS)
@@ -1555,13 +1555,13 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 #ifdef CONFIG_USB_INVENTRA_DMA
 		if (dma) {
 			struct dma_controller	*c;
-			u16			wRxCount;
+			u16			rx_count;
 			int			status;
 
-			wRxCount = musb_readw(epio, MUSB_RXCOUNT);
+			rx_count = musb_readw(epio, MUSB_RXCOUNT);
 
 			DBG(2, "RX%d count %d, buffer 0x%x len %d/%d\n",
-					epnum, wRxCount,
+					epnum, rx_count,
 					urb->transfer_dma
 						+ urb->actual_length,
 					qh->offset,
@@ -1621,7 +1621,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 				urb->transfer_dma
 					+ urb->actual_length,
 				(dma->desired_mode == 0)
-					? wRxCount
+					? rx_count
 					: urb->transfer_buffer_length);
 
 			if (!status) {
-- 
1.5.2.3
