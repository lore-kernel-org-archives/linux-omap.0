From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/36] musb_hdrc: Search and replace dwLength with len
Date: Thu, 16 Aug 2007 02:40:33 -0700
Message-ID: <1187257282941-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872572803477-git-send-email-tony@atomide.com>
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

Search and replace dwLength with len

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c  |    6 +++---
 drivers/usb/musb/musb_host.c |   28 ++++++++++++++--------------
 drivers/usb/musb/musbhsdma.c |   20 ++++++++++----------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index 1441dc7..b455f8e 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -946,12 +946,12 @@ cppi_next_rx_segment(struct musb *musb, struct cppi_channel *rx, int onepacket)
  *	all short reads as errors and kick in high level fault recovery.
  *	For TX, ignored because of RNDIS mode races/glitches.
  * @dma_addr: dma address of buffer
- * @dwLength: length of buffer
+ * @len: length of buffer
  * Context: controller irqlocked
  */
 static int cppi_channel_program(struct dma_channel *pChannel,
 		u16 wPacketSz, u8 mode,
-		dma_addr_t dma_addr, u32 dwLength)
+		dma_addr_t dma_addr, u32 len)
 {
 	struct cppi_channel	*otgChannel = pChannel->private_data;
 	struct cppi		*pController = otgChannel->pController;
@@ -988,7 +988,7 @@ static int cppi_channel_program(struct dma_channel *pChannel,
 	otgChannel->currOffset = 0;
 	otgChannel->pktSize = wPacketSz;
 	otgChannel->actualLen = 0;
-	otgChannel->transferSize = dwLength;
+	otgChannel->transferSize = len;
 
 	/* TX channel? or RX? */
 	if (otgChannel->transmit)
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 4390e42..cc05f70 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -105,7 +105,7 @@
 
 static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, unsigned int nOut,
-			u8 * buf, u32 dwLength);
+			u8 * buf, u32 len);
 
 /*
  * Clear TX fifo. Needed to avoid BABBLE errors.
@@ -170,7 +170,7 @@ static void
 musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 {
 	u16			wFrame;
-	u32			dwLength;
+	u32			len;
 	void			*buf;
 	void __iomem		*mbase =  musb->mregs;
 	struct urb		*urb = next_urb(qh);
@@ -191,17 +191,17 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 		hw_ep->out_qh = qh;
 		musb->ep0_stage = MGC_END0_START;
 		buf = urb->setup_packet;
-		dwLength = 8;
+		len = 8;
 		break;
 	case USB_ENDPOINT_XFER_ISOC:
 		qh->iso_idx = 0;
 		qh->frame = 0;
 		buf = urb->transfer_buffer + urb->iso_frame_desc[0].offset;
-		dwLength = urb->iso_frame_desc[0].length;
+		len = urb->iso_frame_desc[0].length;
 		break;
 	default:		/* bulk, interrupt */
 		buf = urb->transfer_buffer;
-		dwLength = urb->transfer_buffer_length;
+		len = urb->transfer_buffer_length;
 	}
 
 	DBG(4, "qh %p urb %p dev%d ep%d%s%s, hw_ep %d, %p/%d\n",
@@ -213,14 +213,14 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 			case USB_ENDPOINT_XFER_ISOC:	s = "-iso"; break;
 			default:			s = "-intr"; break;
 			}; s;}),
-			epnum, buf, dwLength);
+			epnum, buf, len);
 
 	/* Configure endpoint */
 	if (is_in || hw_ep->is_shared_fifo)
 		hw_ep->in_qh = qh;
 	else
 		hw_ep->out_qh = qh;
-	musb_ep_program(musb, epnum, urb, !is_in, buf, dwLength);
+	musb_ep_program(musb, epnum, urb, !is_in, buf, len);
 
 	/* transmit may have more work: start it when it is time */
 	if (is_in)
@@ -625,7 +625,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
  */
 static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, unsigned int is_out,
-			u8 * buf, u32 dwLength)
+			u8 * buf, u32 len)
 {
 	struct dma_controller	*dma_controller;
 	struct dma_channel	*pDmaChannel;
@@ -649,7 +649,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			epnum, urb, urb->dev->speed,
 			qh->addr_reg, qh->epnum, is_out ? "out" : "in",
 			qh->h_addr_reg, qh->h_port_reg,
-			dwLength);
+			len);
 
 	musb_ep_select(mbase, epnum);
 
@@ -755,9 +755,9 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 		if (can_bulk_split(musb, qh->type))
 			wLoadCount = min((u32) hw_ep->max_packet_sz_tx,
-						dwLength);
+						len);
 		else
-			wLoadCount = min((u32) packet_sz, dwLength);
+			wLoadCount = min((u32) packet_sz, len);
 
 #ifdef CONFIG_USB_INVENTRA_DMA
 		if (pDmaChannel) {
@@ -771,7 +771,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_writew(epio, MUSB_TXCSR,
 				csr | MUSB_TXCSR_MODE);
 
-			qh->segsize = min(dwLength, pDmaChannel->max_len);
+			qh->segsize = min(len, pDmaChannel->max_len);
 
 			if (qh->segsize <= packet_sz)
 				pDmaChannel->desired_mode = 0;
@@ -825,7 +825,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 				csr | MUSB_TXCSR_MODE);
 
 			pDmaChannel->actual_len = 0L;
-			qh->segsize = dwLength;
+			qh->segsize = len;
 
 			/* TX uses "rndis" mode automatically, but needs help
 			 * to identify the zero-length-final-packet case.
@@ -905,7 +905,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			/* candidate for DMA */
 			if (pDmaChannel) {
 				pDmaChannel->actual_len = 0L;
-				qh->segsize = dwLength;
+				qh->segsize = len;
 
 				/* AUTOREQ is in a DMA register */
 				musb_writew(hw_ep->regs, MUSB_RXCSR, csr);
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 98b5b2e..b6d3ef0 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -172,7 +172,7 @@ static void dma_channel_release(struct dma_channel *pChannel)
 
 static void configure_channel(struct dma_channel *pChannel,
 				u16 packet_sz, u8 mode,
-				dma_addr_t dma_addr, u32 dwLength)
+				dma_addr_t dma_addr, u32 len)
 {
 	struct musb_dma_channel *pImplChannel =
 		(struct musb_dma_channel *) pChannel->private_data;
@@ -182,11 +182,11 @@ static void configure_channel(struct dma_channel *pChannel,
 	u16 csr = 0;
 
 	DBG(4, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
-	    pChannel, packet_sz, dma_addr, dwLength, mode);
+	    pChannel, packet_sz, dma_addr, len, mode);
 
 	if (mode) {
 		csr |= 1 << MUSB_HSDMA_MODE1_SHIFT;
-		if (dwLength < packet_sz) {
+		if (len < packet_sz) {
 			return FALSE;
 		}
 		if (packet_sz >= 64) {
@@ -212,7 +212,7 @@ static void configure_channel(struct dma_channel *pChannel,
 		    dma_addr);
 	musb_writel(mbase,
 		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_COUNT),
-		    dwLength);
+		    len);
 
 	/* control (this should start things) */
 	musb_writew(mbase,
@@ -222,7 +222,7 @@ static void configure_channel(struct dma_channel *pChannel,
 
 static int dma_channel_program(struct dma_channel * pChannel,
 				u16 packet_sz, u8 mode,
-				dma_addr_t dma_addr, u32 dwLength)
+				dma_addr_t dma_addr, u32 len)
 {
 	struct musb_dma_channel *pImplChannel =
 			(struct musb_dma_channel *) pChannel->private_data;
@@ -230,23 +230,23 @@ static int dma_channel_program(struct dma_channel * pChannel,
 	DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
 		pImplChannel->epnum,
 		pImplChannel->transmit ? "Tx" : "Rx",
-		packet_sz, dma_addr, dwLength, mode);
+		packet_sz, dma_addr, len, mode);
 
 	BUG_ON(pChannel->status == MGC_DMA_STATUS_UNKNOWN ||
 		pChannel->status == MGC_DMA_STATUS_BUSY);
 
 	pChannel->actual_len = 0;
 	pImplChannel->dwStartAddress = dma_addr;
-	pImplChannel->len = dwLength;
+	pImplChannel->len = len;
 	pImplChannel->wMaxPacketSize = packet_sz;
 	pChannel->status = MGC_DMA_STATUS_BUSY;
 
-	if ((mode == 1) && (dwLength >= packet_sz)) {
+	if ((mode == 1) && (len >= packet_sz)) {
 		configure_channel(pChannel, packet_sz, 1, dma_addr,
-				  dwLength);
+				  len);
 	} else
 		configure_channel(pChannel, packet_sz, 0, dma_addr,
-				  dwLength);
+				  len);
 
 	return TRUE;
 }
-- 
1.5.2.3
