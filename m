From: David Brownell <david-b@pacbell.net>
Subject: [patch 1/3] musb_hdrc, remove MGC_{Read,Write}Csr8()
Date: Thu, 18 Jan 2007 15:36:52 -0800
Message-ID: <200701181536.53415.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

More CaMeLcAsE cleanup:  remove remaining MGC_{Read,Write}Csr8().

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: o26/drivers/usb/musb/musbdefs.h
===================================================================
--- o26.orig/drivers/usb/musb/musbdefs.h	2007-01-18 03:26:20.000000000 -0800
+++ o26/drivers/usb/musb/musbdefs.h	2007-01-18 06:18:55.000000000 -0800
@@ -232,21 +232,13 @@ enum musb_g_ep0_state {
  * using hw_ep->regs, for all access except writing INDEX
  */
 #ifdef	MUSB_FLAT_REG
-#define MGC_ReadCsr8(_pBase, _bOffset, _bEnd) \
-	musb_readb((_pBase), MGC_END_OFFSET((_bEnd), (_bOffset)))
 #define MGC_ReadCsr16(_pBase, _bOffset, _bEnd) \
 	musb_readw((_pBase), MGC_END_OFFSET((_bEnd), (_bOffset)))
-#define MGC_WriteCsr8(_pBase, _bOffset, _bEnd, _bData) \
-	musb_writeb((_pBase), MGC_END_OFFSET((_bEnd), (_bOffset)), (_bData))
 #define MGC_WriteCsr16(_pBase, _bOffset, _bEnd, _bData) \
 	musb_writew((_pBase), MGC_END_OFFSET((_bEnd), (_bOffset)), (_bData))
 #else
-#define MGC_ReadCsr8(_pBase, _bOffset, _bEnd) \
-	    musb_readb(_pBase, (_bOffset + 0x10))
 #define MGC_ReadCsr16(_pBase, _bOffset, _bEnd) \
 	musb_readw(_pBase, (_bOffset + 0x10))
-#define MGC_WriteCsr8(_pBase, _bOffset, _bEnd, _bData) \
-	musb_writeb(_pBase, (_bOffset + 0x10), _bData)
 #define MGC_WriteCsr16(_pBase, _bOffset, _bEnd, _bData) \
 	musb_writew(_pBase, (_bOffset + 0x10), _bData)
 #endif
Index: o26/drivers/usb/musb/musb_host.c
===================================================================
--- o26.orig/drivers/usb/musb/musb_host.c	2007-01-18 04:12:49.000000000 -0800
+++ o26/drivers/usb/musb/musb_host.c	2007-01-18 06:21:48.000000000 -0800
@@ -628,6 +628,7 @@ static void musb_ep_program(struct musb 
 	u8			bDmaOk;
 	void __iomem		*pBase = pThis->pRegs;
 	struct musb_hw_ep	*pEnd = pThis->aLocalEnd + bEnd;
+	void __iomem		*epio = pEnd->regs;
 	struct musb_qh		*qh;
 	u16			wPacketSize;
 
@@ -736,8 +737,7 @@ static void musb_ep_program(struct musb 
 
 		/* protocol/endpoint/interval/NAKlimit */
 		if (bEnd) {
-			MGC_WriteCsr8(pBase, MGC_O_HDRC_TXTYPE, bEnd,
-						qh->type_reg);
+			musb_writeb(epio, MGC_O_HDRC_TXTYPE, qh->type_reg);
 			if (can_bulk_split(pThis, qh->type))
 				MGC_WriteCsr16(pBase, MGC_O_HDRC_TXMAXP, bEnd,
 					wPacketSize
@@ -746,13 +746,11 @@ static void musb_ep_program(struct musb 
 			else
 				MGC_WriteCsr16(pBase, MGC_O_HDRC_TXMAXP, bEnd,
 					wPacketSize);
-			MGC_WriteCsr8(pBase, MGC_O_HDRC_TXINTERVAL, bEnd,
-				qh->intv_reg);
+			musb_writeb(epio, MGC_O_HDRC_TXINTERVAL, qh->intv_reg);
 		} else {
-			MGC_WriteCsr8(pBase, MGC_O_HDRC_NAKLIMIT0, 0,
-				qh->intv_reg);
+			musb_writeb(epio, MGC_O_HDRC_NAKLIMIT0, qh->intv_reg);
 			if (pThis->bIsMultipoint)
-				MGC_WriteCsr8(pBase, MGC_O_HDRC_TYPE0, 0,
+				musb_writeb(epio, MGC_O_HDRC_TYPE0,
 						qh->type_reg);
 		}
 
@@ -1035,6 +1033,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *
 	int			status = 0;
 	void __iomem		*pBase = pThis->pRegs;
 	struct musb_hw_ep	*pEnd = pThis->control_ep;
+	void __iomem		*epio = pEnd->regs;
 	struct musb_qh		*qh = pEnd->in_qh;
 	u8			bComplete = FALSE;
 	irqreturn_t		retval = IRQ_NONE;
@@ -1044,7 +1043,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *
 
 	MGC_SelectEnd(pBase, 0);
 	wCsrVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_CSR0, 0);
-	wCount = MGC_ReadCsr8(pBase, MGC_O_HDRC_COUNT0, 0);
+	wCount = musb_readb(epio, MGC_O_HDRC_COUNT0);
 
 	DBG(4, "<== csr0 %04x, qh %p, count %d, urb %p, stage %d\n",
 		wCsrVal, qh, wCount, pUrb, pThis->bEnd0Stage);
@@ -1099,7 +1098,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *
 			MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, wCsrVal);
 		}
 
-		MGC_WriteCsr8(pBase, MGC_O_HDRC_NAKLIMIT0, 0, 0);
+		musb_writeb(epio, MGC_O_HDRC_NAKLIMIT0, 0);
 
 		/* clear it */
 		MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, 0);
@@ -1173,6 +1172,7 @@ void musb_host_tx(struct musb *pThis, u8
 	u8			*pBuffer = NULL;
 	struct urb		*pUrb;
 	struct musb_hw_ep	*pEnd = pThis->aLocalEnd + bEnd;
+	void __iomem		*epio = pEnd->regs;
 	struct musb_qh		*qh = pEnd->out_qh;
 	u32			status = 0;
 	void __iomem		*pBase = pThis->pRegs;
@@ -1249,7 +1249,7 @@ void musb_host_tx(struct musb *pThis, u8
 		MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, wTxCsrVal);
 		/* REVISIT may need to clear FLUSHFIFO ... */
 		MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, wTxCsrVal);
-		MGC_WriteCsr8(pBase, MGC_O_HDRC_TXINTERVAL, bEnd, 0);
+		musb_writeb(epio, MGC_O_HDRC_TXINTERVAL, 0);
 
 		bDone = TRUE;
 	}
@@ -1399,6 +1399,7 @@ void musb_host_rx(struct musb *pThis, u8
 {
 	struct urb		*pUrb;
 	struct musb_hw_ep	*pEnd = pThis->aLocalEnd + bEnd;
+	void __iomem		*epio = pEnd->regs;
 	struct musb_qh		*qh = pEnd->in_qh;
 	size_t			xfer_len;
 	void __iomem		*pBase = pThis->pRegs;
@@ -1447,7 +1448,7 @@ void musb_host_rx(struct musb *pThis, u8
 		DBG(3, "end %d RX proto error\n", bEnd);
 
 		status = -EPROTO;
-		MGC_WriteCsr8(pBase, MGC_O_HDRC_RXINTERVAL, bEnd, 0);
+		musb_writeb(epio, MGC_O_HDRC_RXINTERVAL, 0);
 
 	} else if (wRxCsrVal & MGC_M_RXCSR_DATAERROR) {
 
@@ -1482,7 +1483,7 @@ void musb_host_rx(struct musb *pThis, u8
 			xfer_len = dma->dwActualLength;
 		}
 		musb_h_flush_rxfifo(pEnd, 0);
-		MGC_WriteCsr8(pBase, MGC_O_HDRC_RXINTERVAL, bEnd, 0);
+		musb_writeb(epio, MGC_O_HDRC_RXINTERVAL, 0);
 		bDone = TRUE;
 		goto finish;
 	}
