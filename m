From: David Brownell <david-b@pacbell.net>
Subject: [patch 3/3] musb_hdrc, remove MGC_WriteCsr16()
Date: Thu, 18 Jan 2007 15:39:16 -0800
Message-ID: <200701181539.16949.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

More camelcase fixes:  remove MGC_WriteCsr16.

This review also caught a latent bug in the GIT tree, where peripheral side
shared fifo OUT endpoints (not used by the standard set of gadget drivers)
would init wrong since they read from the wrong register.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: o26/drivers/usb/musb/musbdefs.h
===================================================================
--- o26.orig/drivers/usb/musb/musbdefs.h	2007-01-18 06:53:10.000000000 -0800
+++ o26/drivers/usb/musb/musbdefs.h	2007-01-18 07:34:10.000000000 -0800
@@ -203,8 +203,7 @@ enum musb_g_ep0_state {
  */
 
 #if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_ARCH_OMAP243X)
-/* REVISIT "flat" takes about 1% more object code space and can't be very
- * noticeable for speed differences.  But for now indexed access seems to
+/* REVISIT indexed access seemed to
  * misbehave (on DaVinci) for at least peripheral IN ...
  */
 #define	MUSB_FLAT_REG
@@ -228,17 +227,6 @@ enum musb_g_ep0_state {
 #define	MGC_END_OFFSET			MGC_INDEXED_OFFSET
 #endif
 
-/* FIXME: replace with musb_readcsr(hw_ep *, REGNAME), etc
- * using hw_ep->regs, for all access except writing INDEX
- */
-#ifdef	MUSB_FLAT_REG
-#define MGC_WriteCsr16(_pBase, _bOffset, _bEnd, _bData) \
-	musb_writew((_pBase), MGC_END_OFFSET((_bEnd), (_bOffset)), (_bData))
-#else
-#define MGC_WriteCsr16(_pBase, _bOffset, _bEnd, _bData) \
-	musb_writew(_pBase, (_bOffset + 0x10), _bData)
-#endif
-
 /****************************** FUNCTIONS ********************************/
 
 #define MUSB_HST_MODE(_pthis)\
Index: o26/drivers/usb/musb/musb_gadget.c
===================================================================
--- o26.orig/drivers/usb/musb/musb_gadget.c	2007-01-18 06:48:17.000000000 -0800
+++ o26/drivers/usb/musb/musb_gadget.c	2007-01-18 07:19:28.000000000 -0800
@@ -244,7 +244,6 @@ static void txstate(struct musb *pThis, 
 	struct musb_ep		*pEnd;
 	void __iomem		*epio = pThis->aLocalEnd[bEnd].regs;
 	struct usb_request	*pRequest;
-	void __iomem		*pBase = pThis->pRegs;
 	u16			wFifoCount = 0, wCsrVal;
 	int			use_dma = 0;
 
@@ -319,8 +318,7 @@ static void txstate(struct musb *pThis, 
 							| MGC_M_TXCSR_MODE);
 
 				wCsrVal &= ~MGC_M_TXCSR_P_UNDERRUN;
-				MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
-						wCsrVal);
+				musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
 			}
 		}
 
@@ -331,7 +329,7 @@ static void txstate(struct musb *pThis, 
 				| MGC_M_TXCSR_P_UNDERRUN
 				| MGC_M_TXCSR_TXPKTRDY);
 		wCsrVal |= MGC_M_TXCSR_MODE | MGC_M_TXCSR_DMAENAB;
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
+		musb_writew(epio, MGC_O_HDRC_TXCSR,
 			(MGC_M_TXCSR_P_WZC_BITS & ~MGC_M_TXCSR_P_UNDERRUN)
 				| wCsrVal);
 
@@ -376,7 +374,7 @@ static void txstate(struct musb *pThis, 
 		pRequest->actual += wFifoCount;
 		wCsrVal |= MGC_M_TXCSR_TXPKTRDY;
 		wCsrVal &= ~MGC_M_TXCSR_P_UNDERRUN;
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, wCsrVal);
+		musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
 	}
 
 	/* host may already have the data when this message shows... */
@@ -415,7 +413,7 @@ void musb_g_tx(struct musb *pThis, u8 bE
 		if (wCsrVal & MGC_M_TXCSR_P_SENTSTALL) {
 			wCsrVal |= MGC_M_TXCSR_P_WZC_BITS;
 			wCsrVal &= ~MGC_M_TXCSR_P_SENTSTALL;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
 			if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 				dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
 				pThis->pDmaController->channel_abort(dma);
@@ -432,7 +430,7 @@ void musb_g_tx(struct musb *pThis, u8 bE
 			wCsrVal |= MGC_M_TXCSR_P_WZC_BITS;
 			wCsrVal &= ~(MGC_M_TXCSR_P_UNDERRUN
 					| MGC_M_TXCSR_TXPKTRDY);
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
 			DBG(20, "underrun on ep%d, req %p\n", bEnd, pRequest);
 		}
 
@@ -453,8 +451,7 @@ void musb_g_tx(struct musb *pThis, u8 bE
 				wCsrVal &= ~(MGC_M_TXCSR_DMAENAB
 						| MGC_M_TXCSR_P_UNDERRUN
 						| MGC_M_TXCSR_TXPKTRDY);
-				MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
-					wCsrVal);
+				musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
 				/* ensure writebuffer is empty */
 				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 				DBG(4, "TXCSR%d %04x, dma off, "
@@ -489,8 +486,7 @@ void musb_g_tx(struct musb *pThis, u8 bE
 						break;
 
 					DBG(4, "sending zero pkt\n");
-					MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR,
-							bEnd,
+					musb_writew(epio, MGC_O_HDRC_TXCSR,
 							MGC_M_TXCSR_MODE
 							| MGC_M_TXCSR_TXPKTRDY);
 				}
@@ -565,7 +561,6 @@ static void rxstate(struct musb *pThis, 
 	u16			wCsrVal = 0;
 	const u8		bEnd = req->bEnd;
 	struct usb_request	*pRequest = &req->request;
-	void __iomem		*pBase = pThis->pRegs;
 	struct musb_ep		*pEnd = &pThis->aLocalEnd[bEnd].ep_out;
 	void __iomem		*epio = pThis->aLocalEnd[bEnd].regs;
 	u16			wFifoCount = 0;
@@ -595,7 +590,7 @@ static void rxstate(struct musb *pThis, 
 			wCsrVal &= ~(MGC_M_RXCSR_AUTOCLEAR
 					| MGC_M_RXCSR_DMAMODE);
 			wCsrVal |= MGC_M_RXCSR_DMAENAB | MGC_M_RXCSR_P_WZC_BITS;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
 			return;
 		}
 	}
@@ -642,10 +637,10 @@ static void rxstate(struct musb *pThis, 
 				   disabling MGC_M_RXCSR_DMAMODE) is required
 				   to get DMAReq to activate
 				 */
-				MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd,
+				musb_writew(epio, MGC_O_HDRC_RXCSR,
 					wCsrVal | MGC_M_RXCSR_DMAMODE);
 #endif
-				MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd,
+				musb_writew(epio, MGC_O_HDRC_RXCSR,
 						wCsrVal);
 
 				if (pRequest->actual < pRequest->length) {
@@ -711,7 +706,7 @@ static void rxstate(struct musb *pThis, 
 			/* ack the read! */
 			wCsrVal |= MGC_M_RXCSR_P_WZC_BITS;
 			wCsrVal &= ~MGC_M_RXCSR_RXPKTRDY;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
 		}
 	}
 
@@ -753,7 +748,7 @@ void musb_g_rx(struct musb *pThis, u8 bE
 
 		wCsrVal |= MGC_M_RXCSR_P_WZC_BITS;
 		wCsrVal &= ~MGC_M_RXCSR_P_SENTSTALL;
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd, wCsrVal);
+		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
 
 		if (pRequest)
 			musb_g_giveback(pEnd, pRequest, -EPIPE);
@@ -763,7 +758,7 @@ void musb_g_rx(struct musb *pThis, u8 bE
 	if (wCsrVal & MGC_M_RXCSR_P_OVERRUN) {
 		// wCsrVal |= MGC_M_RXCSR_P_WZC_BITS;
 		wCsrVal &= ~MGC_M_RXCSR_P_OVERRUN;
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd, wCsrVal);
+		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
 
 		DBG(3, "%s iso overrun on %p\n", pEnd->name, pRequest);
 		if (pRequest && pRequest->status == -EINPROGRESS)
@@ -786,7 +781,7 @@ void musb_g_rx(struct musb *pThis, u8 bE
 		wCsrVal &= ~(MGC_M_RXCSR_AUTOCLEAR
 				| MGC_M_RXCSR_DMAENAB
 				| MGC_M_RXCSR_DMAMODE);
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd,
+		musb_writew(epio, MGC_O_HDRC_RXCSR,
 			MGC_M_RXCSR_P_WZC_BITS | wCsrVal);
 
 		pRequest->actual += pEnd->dma->dwActualLength;
@@ -803,7 +798,7 @@ void musb_g_rx(struct musb *pThis, u8 bE
 					& (pEnd->wPacketSize - 1))) {
 			/* ack the read! */
 			wCsrVal &= ~MGC_M_RXCSR_RXPKTRDY;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
 		}
 
 		/* incomplete, and not short? wait for next IN packet */
@@ -932,13 +927,13 @@ static int musb_gadget_enable(struct usb
 		/* REVISIT if can_bulk_combine() use by updating "tmp"
 		 * likewise high bandwidth periodic rx
 		 */
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_RXMAXP, bEnd, tmp);
+		musb_writew(regs, MGC_O_HDRC_RXMAXP, tmp);
 
 		/* force shared fifo to OUT-only mode */
 		if (hw_ep->bIsSharedFifo) {
-			csr = musb_readw(pBase, MGC_O_HDRC_TXCSR);
+			csr = musb_readw(regs, MGC_O_HDRC_TXCSR);
 			csr &= ~(MGC_M_TXCSR_MODE | MGC_M_TXCSR_TXPKTRDY);
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, csr);
+			musb_writew(regs, MGC_O_HDRC_TXCSR, csr);
 		}
 
 		csr = MGC_M_RXCSR_FLUSHFIFO | MGC_M_RXCSR_CLRDATATOG;
@@ -948,8 +943,8 @@ static int musb_gadget_enable(struct usb
 			csr |= MGC_M_RXCSR_DISNYET;
 
 		/* set twice in case of double buffering */
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd, csr);
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd, csr);
+		musb_writew(regs, MGC_O_HDRC_RXCSR, csr);
+		musb_writew(regs, MGC_O_HDRC_RXCSR, csr);
 	}
 
 	/* NOTE:  all the I/O code _should_ work fine without DMA, in case
@@ -994,11 +989,13 @@ static int musb_gadget_disable(struct us
 	struct musb	*pThis;
 	u8		bEnd;
 	struct musb_ep	*pEnd;
+	void __iomem	*epio;
 	int		status = 0;
 
 	pEnd = to_musb_ep(ep);
 	pThis = pEnd->pThis;
 	bEnd = pEnd->bEndNumber;
+	epio = pThis->aLocalEnd[bEnd].regs;
 
 	spin_lock_irqsave(&pThis->Lock, flags);
 	MGC_SelectEnd(pThis->pRegs, bEnd);
@@ -1008,12 +1005,12 @@ static int musb_gadget_disable(struct us
 		u16 wIntrTxE = musb_readw(pThis->pRegs, MGC_O_HDRC_INTRTXE);
 		wIntrTxE &= ~(1 << bEnd);
 		musb_writew(pThis->pRegs, MGC_O_HDRC_INTRTXE, wIntrTxE);
-		MGC_WriteCsr16(pThis->pRegs, MGC_O_HDRC_TXMAXP, bEnd, 0);
+		musb_writew(epio, MGC_O_HDRC_TXMAXP, 0);
 	} else {
 		u16 wIntrRxE = musb_readw(pThis->pRegs, MGC_O_HDRC_INTRRXE);
 		wIntrRxE &= ~(1 << bEnd);
 		musb_writew(pThis->pRegs, MGC_O_HDRC_INTRRXE, wIntrRxE);
-		MGC_WriteCsr16(pThis->pRegs, MGC_O_HDRC_RXMAXP, bEnd, 0);
+		musb_writew(epio, MGC_O_HDRC_RXMAXP, 0);
 	}
 
 	pEnd->desc = NULL;
@@ -1316,7 +1313,7 @@ int musb_gadget_set_halt(struct usb_ep *
 			wCsr &= ~(MGC_M_TXCSR_P_SENDSTALL
 				| MGC_M_TXCSR_P_SENTSTALL);
 		wCsr &= ~MGC_M_TXCSR_TXPKTRDY;
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, wCsr);
+		musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
 	} else {
 		wCsr = musb_readw(epio, MGC_O_HDRC_RXCSR);
 		wCsr |= MGC_M_RXCSR_P_WZC_BITS
@@ -1327,7 +1324,7 @@ int musb_gadget_set_halt(struct usb_ep *
 		else
 			wCsr &= ~(MGC_M_RXCSR_P_SENDSTALL
 				| MGC_M_RXCSR_P_SENTSTALL);
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd, wCsr);
+		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsr);
 	}
 
 done:
@@ -1388,15 +1385,15 @@ static void musb_gadget_fifo_flush(struc
 		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY) {
 			wCsr |= MGC_M_TXCSR_FLUSHFIFO | MGC_M_TXCSR_P_WZC_BITS;
-			MGC_WriteCsr16(mbase, MGC_O_HDRC_TXCSR, nEnd, wCsr);
+			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
 			/* REVISIT may be inappropriate w/o FIFONOTEMPTY ... */
-			MGC_WriteCsr16(mbase, MGC_O_HDRC_TXCSR, nEnd, wCsr);
+			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
 		}
 	} else {
 		wCsr = musb_readw(epio, MGC_O_HDRC_RXCSR);
 		wCsr |= MGC_M_RXCSR_FLUSHFIFO | MGC_M_RXCSR_P_WZC_BITS;
-		MGC_WriteCsr16(mbase, MGC_O_HDRC_RXCSR, nEnd, wCsr);
-		MGC_WriteCsr16(mbase, MGC_O_HDRC_RXCSR, nEnd, wCsr);
+		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsr);
+		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsr);
 	}
 
 	/* re-enable interrupt */
Index: o26/drivers/usb/musb/musb_host.c
===================================================================
--- o26.orig/drivers/usb/musb/musb_host.c	2007-01-18 06:55:11.000000000 -0800
+++ o26/drivers/usb/musb/musb_host.c	2007-01-18 07:32:15.000000000 -0800
@@ -467,7 +467,6 @@ static u8 musb_host_packet_rx(struct mus
 	u8 bDone = FALSE;
 	u32			length;
 	int			do_flush = 0;
-	void __iomem		*pBase = pThis->pRegs;
 	struct musb_hw_ep	*pEnd = pThis->aLocalEnd + bEnd;
 	void __iomem		*epio = pEnd->regs;
 	struct musb_qh		*qh = pEnd->in_qh;
@@ -543,7 +542,7 @@ static u8 musb_host_packet_rx(struct mus
 		wCsr &= ~(MGC_M_RXCSR_RXPKTRDY | MGC_M_RXCSR_H_REQPKT);
 		if (!bDone)
 			wCsr |= MGC_M_RXCSR_H_REQPKT;
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd, wCsr);
+		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsr);
 	}
 
 	return bDone;
@@ -704,17 +703,15 @@ static void musb_ep_program(struct musb 
 				csr |= MGC_M_TXCSR_CLRDATATOG;
 
 			/* twice in case of double packet buffering */
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
-					csr);
+			musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 			/* REVISIT may need to clear FLUSHFIFO ... */
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
-					csr);
+			musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 			wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		} else {
 			/* endpoint 0: just flush */
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, bEnd,
+			musb_writew(epio, MGC_O_HDRC_CSR0,
 				wCsr | MGC_M_CSR0_FLUSHFIFO);
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, bEnd,
+			musb_writew(epio, MGC_O_HDRC_CSR0,
 				wCsr | MGC_M_CSR0_FLUSHFIFO);
 		}
 
@@ -737,12 +734,12 @@ static void musb_ep_program(struct musb 
 		if (bEnd) {
 			musb_writeb(epio, MGC_O_HDRC_TXTYPE, qh->type_reg);
 			if (can_bulk_split(pThis, qh->type))
-				MGC_WriteCsr16(pBase, MGC_O_HDRC_TXMAXP, bEnd,
+				musb_writew(epio, MGC_O_HDRC_TXMAXP,
 					wPacketSize
 					| ((pEnd->wMaxPacketSizeTx /
 						wPacketSize) - 1) << 11);
 			else
-				MGC_WriteCsr16(pBase, MGC_O_HDRC_TXMAXP, bEnd,
+				musb_writew(epio, MGC_O_HDRC_TXMAXP,
 					wPacketSize);
 			musb_writeb(epio, MGC_O_HDRC_TXINTERVAL, qh->intv_reg);
 		} else {
@@ -767,7 +764,7 @@ static void musb_ep_program(struct musb 
 				| MGC_M_TXCSR_DMAMODE
 				| MGC_M_TXCSR_DMAENAB);
                         wCsr |= MGC_M_TXCSR_MODE;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
+			musb_writew(epio, MGC_O_HDRC_TXCSR,
 				wCsr | MGC_M_TXCSR_MODE);
 
 			qh->segsize = min(dwLength, pDmaChannel->dwMaxLength);
@@ -788,7 +785,7 @@ static void musb_ep_program(struct musb 
 					| MGC_M_TXCSR_DMAENAB
 					| MGC_M_TXCSR_DMAMODE);
 
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, wCsr);
+			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
 
 			bDmaOk = pDmaController->channel_program(
 					pDmaChannel, wPacketSize,
@@ -820,7 +817,7 @@ static void musb_ep_program(struct musb 
 					| MGC_M_TXCSR_DMAMODE
 					| MGC_M_TXCSR_DMAENAB);
 			wCsr |= MGC_M_TXCSR_MODE;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
+			musb_writew(epio, MGC_O_HDRC_TXCSR,
 				wCsr | MGC_M_TXCSR_MODE);
 
 			pDmaChannel->dwActualLength = 0L;
@@ -863,9 +860,7 @@ static void musb_ep_program(struct musb 
 			wCsr |= MGC_M_TXCSR_MODE;
 
 			if (bEnd)
-				MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR,
-						bEnd, wCsr);
-
+				musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
 		}
 
 		/* re-enable interrupt */
@@ -1071,7 +1066,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *
 		 * if (qh->ring.next != &musb->control), then
 		 * we have a candidate... NAKing is *NOT* an error
 		 */
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, 0);
+		musb_writew(epio, MGC_O_HDRC_CSR0, 0);
 		retval = IRQ_HANDLED;
 	}
 
@@ -1085,21 +1080,21 @@ irqreturn_t musb_h_ep0_irq(struct musb *
 		/* use the proper sequence to abort the transfer */
 		if (wCsrVal & MGC_M_CSR0_H_REQPKT) {
 			wCsrVal &= ~MGC_M_CSR0_H_REQPKT;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
 			wCsrVal &= ~MGC_M_CSR0_H_NAKTIMEOUT;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
 		} else {
 			wCsrVal |= MGC_M_CSR0_FLUSHFIFO;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, wCsrVal);
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
 			wCsrVal &= ~MGC_M_CSR0_H_NAKTIMEOUT;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
 		}
 
 		musb_writeb(epio, MGC_O_HDRC_NAKLIMIT0, 0);
 
 		/* clear it */
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, 0);
+		musb_writew(epio, MGC_O_HDRC_CSR0, 0);
 	}
 
 	if (unlikely(!pUrb)) {
@@ -1107,9 +1102,9 @@ irqreturn_t musb_h_ep0_irq(struct musb *
 		 * SHOULD NEVER HAPPEN! */
 		ERR("no URB for end 0\n");
 
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, MGC_M_CSR0_FLUSHFIFO);
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, MGC_M_CSR0_FLUSHFIFO);
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, 0);
+		musb_writew(epio, MGC_O_HDRC_CSR0, MGC_M_CSR0_FLUSHFIFO);
+		musb_writew(epio, MGC_O_HDRC_CSR0, MGC_M_CSR0_FLUSHFIFO);
+		musb_writew(epio, MGC_O_HDRC_CSR0, 0);
 
 		goto done;
 	}
@@ -1132,7 +1127,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *
 			DBG(5, "ep0 STATUS, csr %04x\n", wCsrVal);
 
 		}
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0, wCsrVal);
+		musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
 		retval = IRQ_HANDLED;
 	}
 
@@ -1217,7 +1212,7 @@ void musb_host_tx(struct musb *pThis, u8
 		 * we have a candidate... NAKing is *NOT* an error
 		 */
 		MGC_SelectEnd(pBase, bEnd);
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, 0,
+		musb_writew(epio, MGC_O_HDRC_CSR0,
 				MGC_M_TXCSR_H_WZC_BITS
 				| MGC_M_TXCSR_TXPKTRDY);
 		goto finish;
@@ -1244,9 +1239,9 @@ void musb_host_tx(struct musb *pThis, u8
 				);
 
 		MGC_SelectEnd(pBase, bEnd);
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, wTxCsrVal);
+		musb_writew(epio, MGC_O_HDRC_TXCSR, wTxCsrVal);
 		/* REVISIT may need to clear FLUSHFIFO ... */
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, wTxCsrVal);
+		musb_writew(epio, MGC_O_HDRC_TXCSR, wTxCsrVal);
 		musb_writeb(epio, MGC_O_HDRC_TXINTERVAL, 0);
 
 		bDone = TRUE;
@@ -1271,7 +1266,7 @@ void musb_host_tx(struct musb *pThis, u8
 					& (qh->maxpacket - 1))) {
 			/* Send out the packet first ... */
 			MGC_SelectEnd(pBase, bEnd);
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
+			musb_writew(epio, MGC_O_HDRC_TXCSR,
 					MGC_M_TXCSR_TXPKTRDY);
 		}
 #endif
@@ -1340,7 +1335,7 @@ void musb_host_tx(struct musb *pThis, u8
 		qh->segsize = wLength;
 
 		MGC_SelectEnd(pBase, bEnd);
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
+		musb_writew(epio, MGC_O_HDRC_TXCSR,
 				MGC_M_TXCSR_H_WZC_BITS | MGC_M_TXCSR_TXPKTRDY);
 	} else
 		DBG(1, "not complete, but dma enabled?\n");
@@ -1460,7 +1455,7 @@ void musb_host_rx(struct musb *pThis, u8
 			 */
 			DBG(6, "RX end %d NAK timeout\n", bEnd);
 			MGC_SelectEnd(pBase, bEnd);
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd,
+			musb_writew(epio, MGC_O_HDRC_RXCSR,
 					MGC_M_RXCSR_H_WZC_BITS
 					| MGC_M_RXCSR_H_REQPKT);
 
@@ -1518,7 +1513,7 @@ void musb_host_rx(struct musb *pThis, u8
 		wRxCsrVal &= ~MGC_M_RXCSR_H_REQPKT;
 
 		MGC_SelectEnd(pBase, bEnd);
-		MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd,
+		musb_writew(epio, MGC_O_HDRC_RXCSR,
 				MGC_M_RXCSR_H_WZC_BITS | wRxCsrVal);
 	}
 #endif
@@ -1542,7 +1537,7 @@ void musb_host_rx(struct musb *pThis, u8
 		/* send IN token for next packet, without AUTOREQ */
 		if (!bDone) {
 			wVal |= MGC_M_RXCSR_H_REQPKT;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd,
+			musb_writew(epio, MGC_O_HDRC_RXCSR,
 				MGC_M_RXCSR_H_WZC_BITS | wVal);
 		}
 
@@ -1565,7 +1560,7 @@ void musb_host_rx(struct musb *pThis, u8
 			/* do the proper sequence to abort the transfer */
 			MGC_SelectEnd(pBase, bEnd);
 			wVal &= ~MGC_M_RXCSR_H_REQPKT;
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd, wVal);
+			musb_writew(epio, MGC_O_HDRC_RXCSR, wVal);
 			goto finish;
 		}
 
@@ -1626,7 +1621,7 @@ void musb_host_rx(struct musb *pThis, u8
 				wVal |= MGC_M_RXCSR_H_AUTOREQ;
 			wVal |= MGC_M_RXCSR_AUTOCLEAR | MGC_M_RXCSR_DMAENAB;
 
-			MGC_WriteCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd,
+			musb_writew(epio, MGC_O_HDRC_RXCSR,
 				MGC_M_RXCSR_H_WZC_BITS | wVal);
 
 			/* REVISIT if when actual_length != 0,
@@ -1963,9 +1958,9 @@ static int musb_cleanup_urb(struct urb *
 			| MGC_M_TXCSR_H_ERROR
 			| MGC_M_TXCSR_FIFONOTEMPTY
 			);
-		MGC_WriteCsr16(regs, MGC_O_HDRC_TXCSR, 0, csr);
+		musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 		/* REVISIT may need to clear FLUSHFIFO ... */
-		MGC_WriteCsr16(regs, MGC_O_HDRC_TXCSR, 0, csr);
+		musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 		/* flush cpu writebuffer */
 		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 	}
