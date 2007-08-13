From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/52] musb_hdrc: Search and replace wCount with len
Date: Mon, 13 Aug 2007 06:48:46 -0700
Message-ID: <1187012995338-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
	<11870129834092-git-send-email-tony@atomide.com>
	<11870129861917-git-send-email-tony@atomide.com>
	<118701298833-git-send-email-tony@atomide.com>
	<11870129901657-git-send-email-tony@atomide.com>
	<11870129934099-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870129934099-git-send-email-tony@atomide.com>
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

Search and replace wCount with len

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |   10 ++++----
 drivers/usb/musb/musb_gadget.c |   12 +++++-----
 drivers/usb/musb/musb_host.c   |   16 +++++++-------
 drivers/usb/musb/musbdefs.h    |    4 +-
 drivers/usb/musb/plat_uds.c    |   44 ++++++++++++++++++++--------------------
 5 files changed, 43 insertions(+), 43 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -599,17 +599,17 @@ __acquires(musb->Lock)
 irqreturn_t musb_g_ep0_irq(struct musb *musb)
 {
 	u16		wCsrVal;
-	u16		wCount;
+	u16		len;
 	void __iomem	*mbase = musb->mregs;
 	void __iomem	*regs = musb->aLocalEnd[0].regs;
 	irqreturn_t	retval = IRQ_NONE;
 
 	MGC_SelectEnd(mbase, 0);	/* select ep0 */
 	wCsrVal = musb_readw(regs, MGC_O_HDRC_CSR0);
-	wCount = musb_readb(regs, MGC_O_HDRC_COUNT0);
+	len = musb_readb(regs, MGC_O_HDRC_COUNT0);
 
 	DBG(4, "csr %04x, count %d, myaddr %d, ep0stage %s\n",
-			wCsrVal, wCount,
+			wCsrVal, len,
 			musb_readb(mbase, MGC_O_HDRC_FADDR),
 			decode_ep0stage(musb->ep0_state));
 
@@ -696,8 +696,8 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 			struct usb_ctrlrequest	setup;
 			int			handled = 0;
 
-			if (wCount != 8) {
-				ERR("SETUP packet len %d != 8 ?\n", wCount);
+			if (len != 8) {
+				ERR("SETUP packet len %d != 8 ?\n", len);
 				break;
 			}
 			musb_read_setup(musb, &setup);
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -578,7 +578,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_out;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	u16			fifo_count = 0;
-	u16			wCount = musb_ep->wPacketSize;
+	u16			len = musb_ep->wPacketSize;
 
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 
@@ -610,7 +610,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	}
 
 	if (wCsrVal & MGC_M_RXCSR_RXPKTRDY) {
-		wCount = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
+		len = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 		if (pRequest->actual < pRequest->length) {
 #ifdef CONFIG_USB_INVENTRA_DMA
 			if (is_dma_capable() && musb_ep->dma) {
@@ -663,7 +663,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 					transfer_size = min(pRequest->length,
 							channel->dwMaxLength);
 #else
-					transfer_size = wCount;
+					transfer_size = len;
 #endif
 					if (transfer_size <= musb_ep->wPacketSize)
 						musb_ep->dma->bDesiredMode = 0;
@@ -687,10 +687,10 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			fifo_count = pRequest->length - pRequest->actual;
 			DBG(3, "%s OUT/RX pio fifo %d/%d, maxpacket %d\n",
 					musb_ep->end_point.name,
-					wCount, fifo_count,
+					len, fifo_count,
 					musb_ep->wPacketSize);
 
-			fifo_count = min(wCount, fifo_count);
+			fifo_count = min(len, fifo_count);
 
 #ifdef	CONFIG_USB_TUSB_OMAP_DMA
 			if (tusb_dma_omap() && musb_ep->dma) {
@@ -725,7 +725,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	}
 
 	/* reach the end or short packet detected */
-	if (pRequest->actual == pRequest->length || wCount < musb_ep->wPacketSize)
+	if (pRequest->actual == pRequest->length || len < musb_ep->wPacketSize)
 		musb_g_giveback(musb_ep, pRequest, 0);
 }
 
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -943,7 +943,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
  * Return TRUE until it's time to start the status stage.
  */
 static int musb_h_ep0_continue(struct musb *musb,
-				u16 wCount, struct urb *pUrb)
+				u16 len, struct urb *pUrb)
 {
 	int			 bMore = FALSE;
 	u8 *pFifoDest = NULL;
@@ -955,15 +955,15 @@ static int musb_h_ep0_continue(struct musb *musb,
 	switch (musb->bEnd0Stage) {
 	case MGC_END0_IN:
 		pFifoDest = pUrb->transfer_buffer + pUrb->actual_length;
-		fifo_count = min(wCount, ((u16) (pUrb->transfer_buffer_length
+		fifo_count = min(len, ((u16) (pUrb->transfer_buffer_length
 					- pUrb->actual_length)));
-		if (fifo_count < wCount)
+		if (fifo_count < len)
 			pUrb->status = -EOVERFLOW;
 
 		musb_read_fifo(hw_ep, fifo_count, pFifoDest);
 
 		pUrb->actual_length += fifo_count;
-		if (wCount < qh->maxpacket) {
+		if (len < qh->maxpacket) {
 			/* always terminate on short read; it's
 			 * rarely reported as an error.
 			 */
@@ -1021,7 +1021,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 irqreturn_t musb_h_ep0_irq(struct musb *musb)
 {
 	struct urb		*pUrb;
-	u16			wCsrVal, wCount;
+	u16			wCsrVal, len;
 	int			status = 0;
 	void __iomem		*mbase = musb->mregs;
 	struct musb_hw_ep	*hw_ep = musb->control_ep;
@@ -1035,12 +1035,12 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 
 	MGC_SelectEnd(mbase, 0);
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_CSR0);
-	wCount = (wCsrVal & MGC_M_CSR0_RXPKTRDY)
+	len = (wCsrVal & MGC_M_CSR0_RXPKTRDY)
 			? musb_readb(epio, MGC_O_HDRC_COUNT0)
 			: 0;
 
 	DBG(4, "<== csr0 %04x, qh %p, count %d, urb %p, stage %d\n",
-		wCsrVal, qh, wCount, pUrb, musb->bEnd0Stage);
+		wCsrVal, qh, len, pUrb, musb->bEnd0Stage);
 
 	/* if we just did status stage, we are done */
 	if (MGC_END0_STATUS == musb->bEnd0Stage) {
@@ -1112,7 +1112,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 
 	if (!bComplete) {
 		/* call common logic and prepare response */
-		if (musb_h_ep0_continue(musb, wCount, pUrb)) {
+		if (musb_h_ep0_continue(musb, len, pUrb)) {
 			/* more packets required */
 			wCsrVal = (MGC_END0_IN == musb->bEnd0Stage)
 				?  MGC_M_CSR0_H_REQPKT : MGC_M_CSR0_TXPKTRDY;
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -500,9 +500,9 @@ extern void musb_start(struct musb *musb);
 extern void musb_stop(struct musb *musb);
 
 extern void musb_write_fifo(struct musb_hw_ep *ep,
-			     u16 wCount, const u8 * src);
+			     u16 len, const u8 * src);
 extern void musb_read_fifo(struct musb_hw_ep *ep,
-			       u16 wCount, u8 * dst);
+			       u16 len, u8 * dst);
 
 extern void musb_load_testpacket(struct musb *);
 
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -169,14 +169,14 @@ static inline struct musb *dev_to_musb(struct device *dev)
 /*
  * Load an endpoint's FIFO
  */
-void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 wCount, const u8 *src)
+void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 {
 	void __iomem *fifo = hw_ep->fifo;
 
 	prefetch((u8 *)src);
 
 	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
-			'T', hw_ep->bLocalEnd, fifo, wCount, src);
+			'T', hw_ep->bLocalEnd, fifo, len, src);
 
 	/* we can't assume unaligned reads work */
 	if (likely((0x01 & (unsigned long) src) == 0)) {
@@ -184,37 +184,37 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 wCount, const u8 *src)
 
 		/* best case is 32bit-aligned source address */
 		if ((0x02 & (unsigned long) src) == 0) {
-			if (wCount >= 4) {
-				writesl(fifo, src + index, wCount >> 2);
-				index += wCount & ~0x03;
+			if (len >= 4) {
+				writesl(fifo, src + index, len >> 2);
+				index += len & ~0x03;
 			}
-			if (wCount & 0x02) {
+			if (len & 0x02) {
 				musb_writew(fifo, 0, *(u16*)&src[index]);
 				index += 2;
 			}
 		} else {
-			if (wCount >= 2) {
-				writesw(fifo, src + index, wCount >> 1);
-				index += wCount & ~0x01;
+			if (len >= 2) {
+				writesw(fifo, src + index, len >> 1);
+				index += len & ~0x01;
 			}
 		}
-		if (wCount & 0x01)
+		if (len & 0x01)
 			musb_writeb(fifo, 0, src[index]);
 	} else  {
 		/* byte aligned */
-		writesb(fifo, src, wCount);
+		writesb(fifo, src, len);
 	}
 }
 
 /*
  * Unload an endpoint's FIFO
  */
-void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 wCount, u8 *dst)
+void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 {
 	void __iomem *fifo = hw_ep->fifo;
 
 	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
-			'R', hw_ep->bLocalEnd, fifo, wCount, dst);
+			'R', hw_ep->bLocalEnd, fifo, len, dst);
 
 	/* we can't assume unaligned writes work */
 	if (likely((0x01 & (unsigned long) dst) == 0)) {
@@ -222,25 +222,25 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 wCount, u8 *dst)
 
 		/* best case is 32bit-aligned destination address */
 		if ((0x02 & (unsigned long) dst) == 0) {
-			if (wCount >= 4) {
-				readsl(fifo, dst, wCount >> 2);
-				index = wCount & ~0x03;
+			if (len >= 4) {
+				readsl(fifo, dst, len >> 2);
+				index = len & ~0x03;
 			}
-			if (wCount & 0x02) {
+			if (len & 0x02) {
 				*(u16*)&dst[index] = musb_readw(fifo, 0);
 				index += 2;
 			}
 		} else {
-			if (wCount >= 2) {
-				readsw(fifo, dst, wCount >> 1);
-				index = wCount & ~0x01;
+			if (len >= 2) {
+				readsw(fifo, dst, len >> 1);
+				index = len & ~0x01;
 			}
 		}
-		if (wCount & 0x01)
+		if (len & 0x01)
 			dst[index] = musb_readb(fifo, 0);
 	} else  {
 		/* byte aligned */
-		readsb(fifo, dst, wCount);
+		readsb(fifo, dst, len);
 	}
 }
 
-- 
1.5.2.3
