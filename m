From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/36]xe
Date: Thu, 16 Aug 2007 02:40:27 -0700
Message-ID: <11872572693807-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872572672740-git-send-email-tony@atomide.com>
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

Search and replace wIntr[RT]xE with int_[rt]xe

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |   32 ++++++++++++++++----------------
 drivers/usb/musb/musb_host.c   |    8 ++++----
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index b27096a..5d15234 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -895,7 +895,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	 */
 	musb_ep_select(mbase, epnum);
 	if (desc->bEndpointAddress & USB_DIR_IN) {
-		u16 wIntrTxE = musb_readw(mbase, MUSB_INTRTXE);
+		u16 int_txe = musb_readw(mbase, MUSB_INTRTXE);
 
 		if (hw_ep->is_shared_fifo)
 			musb_ep->is_in = 1;
@@ -904,8 +904,8 @@ static int musb_gadget_enable(struct usb_ep *ep,
 		if (tmp > hw_ep->max_packet_sz_tx)
 			goto fail;
 
-		wIntrTxE |= (1 << epnum);
-		musb_writew(mbase, MUSB_INTRTXE, wIntrTxE);
+		int_txe |= (1 << epnum);
+		musb_writew(mbase, MUSB_INTRTXE, int_txe);
 
 		/* REVISIT if can_bulk_split(), use by updating "tmp";
 		 * likewise high bandwidth periodic tx
@@ -925,7 +925,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 		musb_writew(regs, MUSB_TXCSR, csr);
 
 	} else {
-		u16 wIntrRxE = musb_readw(mbase, MUSB_INTRRXE);
+		u16 int_rxe = musb_readw(mbase, MUSB_INTRRXE);
 
 		if (hw_ep->is_shared_fifo)
 			musb_ep->is_in = 0;
@@ -934,8 +934,8 @@ static int musb_gadget_enable(struct usb_ep *ep,
 		if (tmp > hw_ep->max_packet_sz_rx)
 			goto fail;
 
-		wIntrRxE |= (1 << epnum);
-		musb_writew(mbase, MUSB_INTRRXE, wIntrRxE);
+		int_rxe |= (1 << epnum);
+		musb_writew(mbase, MUSB_INTRRXE, int_rxe);
 
 		/* REVISIT if can_bulk_combine() use by updating "tmp"
 		 * likewise high bandwidth periodic rx
@@ -1015,14 +1015,14 @@ static int musb_gadget_disable(struct usb_ep *ep)
 
 	/* zero the endpoint sizes */
 	if (musb_ep->is_in) {
-		u16 wIntrTxE = musb_readw(musb->mregs, MUSB_INTRTXE);
-		wIntrTxE &= ~(1 << epnum);
-		musb_writew(musb->mregs, MUSB_INTRTXE, wIntrTxE);
+		u16 int_txe = musb_readw(musb->mregs, MUSB_INTRTXE);
+		int_txe &= ~(1 << epnum);
+		musb_writew(musb->mregs, MUSB_INTRTXE, int_txe);
 		musb_writew(epio, MUSB_TXMAXP, 0);
 	} else {
-		u16 wIntrRxE = musb_readw(musb->mregs, MUSB_INTRRXE);
-		wIntrRxE &= ~(1 << epnum);
-		musb_writew(musb->mregs, MUSB_INTRRXE, wIntrRxE);
+		u16 int_rxe = musb_readw(musb->mregs, MUSB_INTRRXE);
+		int_rxe &= ~(1 << epnum);
+		musb_writew(musb->mregs, MUSB_INTRRXE, int_rxe);
 		musb_writew(epio, MUSB_RXMAXP, 0);
 	}
 
@@ -1335,7 +1335,7 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 	void __iomem	*epio = musb->endpoints[nEnd].regs;
 	void __iomem	*mbase;
 	unsigned long	flags;
-	u16		csr, wIntrTxE;
+	u16		csr, int_txe;
 
 	mbase = musb->mregs;
 
@@ -1343,8 +1343,8 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 	musb_ep_select(mbase, (u8) nEnd);
 
 	/* disable interrupts */
-	wIntrTxE = musb_readw(mbase, MUSB_INTRTXE);
-	musb_writew(mbase, MUSB_INTRTXE, wIntrTxE & ~(1 << nEnd));
+	int_txe = musb_readw(mbase, MUSB_INTRTXE);
+	musb_writew(mbase, MUSB_INTRTXE, int_txe & ~(1 << nEnd));
 
 	if (musb_ep->is_in) {
 		csr = musb_readw(epio, MUSB_TXCSR);
@@ -1362,7 +1362,7 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 	}
 
 	/* re-enable interrupt */
-	musb_writew(mbase, MUSB_INTRTXE, wIntrTxE);
+	musb_writew(mbase, MUSB_INTRTXE, int_txe);
 	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index f5b5445..32376f4 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -673,14 +673,14 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 	/* OUT/transmit/EP0 or IN/receive? */
 	if (is_out) {
 		u16	csr;
-		u16	wIntrTxE;
+		u16	int_txe;
 		u16	wLoadCount;
 
 		csr = musb_readw(epio, MUSB_TXCSR);
 
 		/* disable interrupt in case we flush */
-		wIntrTxE = musb_readw(mbase, MUSB_INTRTXE);
-		musb_writew(mbase, MUSB_INTRTXE, wIntrTxE & ~(1 << epnum));
+		int_txe = musb_readw(mbase, MUSB_INTRTXE);
+		musb_writew(mbase, MUSB_INTRTXE, int_txe & ~(1 << epnum));
 
 		/* general endpoint setup */
 		if (epnum) {
@@ -868,7 +868,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		}
 
 		/* re-enable interrupt */
-		musb_writew(mbase, MUSB_INTRTXE, wIntrTxE);
+		musb_writew(mbase, MUSB_INTRTXE, int_txe);
 
 	/* IN/receive */
 	} else {
-- 
1.5.2.3
