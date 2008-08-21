From: Swaminathan S <swami.iyer-l0cyMroinI0@public.gmane.org>
Subject: Patch [2/2] DaVinci CPPI TX DMA tasklet
Date: Thu, 21 Aug 2008 19:28:42 +0530
Message-ID: <1219327122-28334-1-git-send-email-swami.iyer@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

    Signed-off-by: Swaminathan S <swami.iyer-l0cyMroinI0@public.gmane.org>
    
    This patch implements a tasklet to poll for TX Endpoint FIFO
    empty status before completing a transfer.  This is required
    in the context of DaVinci CPPI DMA Tx transfers.  CPPI
    DMA engine generates completion interrupt before the data
    actually moves out of TX FIFO and the driver needs to save the
    Data toggle after ensuring that the FIFO is empty.

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index d443a61..9dd24c3 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -421,6 +421,12 @@ int __init musb_platform_init(struct musb *musb)
 		musb_readb(tibase, DAVINCI_USB_CTRL_REG));
 
 	musb->isr = davinci_interrupt;
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+#ifdef CONFIG_ARCH_DAVINCI
+	tasklet_init(&musb->fifo_check, musb_fifo_check_tasklet,
+			(unsigned long)musb);
+#endif
+#endif
 	return 0;
 }
 
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 08e421f..c17681b 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -154,7 +154,8 @@ static inline void cppi_host_txdma_start(struct musb_hw_ep *ep)
 
 	/* NOTE: no locks here; caller should lock and select EP */
 	txcsr = musb_readw(ep->regs, MUSB_TXCSR);
-	txcsr |= MUSB_TXCSR_DMAENAB | MUSB_TXCSR_H_WZC_BITS;
+	txcsr |= MUSB_TXCSR_DMAENAB | MUSB_TXCSR_DMAMODE |
+			MUSB_TXCSR_H_WZC_BITS;
 	musb_writew(ep->regs, MUSB_TXCSR, txcsr);
 }
 
@@ -356,6 +357,7 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
 	usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
 
 	qh->is_ready = 0;
+	qh->num_req--;
 	__musb_giveback(musb, urb, status);
 	qh->is_ready = ready;
 
@@ -688,14 +690,15 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 					| MUSB_TXCSR_TXPKTRDY
 					);
 			csr |= MUSB_TXCSR_MODE;
-
-			if (usb_gettoggle(urb->dev,
-					qh->epnum, 1))
-				csr |= MUSB_TXCSR_H_WR_DATATOGGLE
-					| MUSB_TXCSR_H_DATATOGGLE;
-			else
-				csr |= MUSB_TXCSR_CLRDATATOG;
-
+			if (hw_ep->tx_reinit) {
+				if (usb_gettoggle(urb->dev,
+						qh->epnum, 1))
+					csr |= MUSB_TXCSR_H_WR_DATATOGGLE
+						| MUSB_TXCSR_H_DATATOGGLE;
+				else
+					csr |= MUSB_TXCSR_CLRDATATOG;
+					hw_ep->tx_reinit = 0;
+			}
 			/* twice in case of double packet buffering */
 			musb_writew(epio, MUSB_TXCSR, csr);
 			/* REVISIT may need to clear FLUSHFIFO ... */
@@ -1235,6 +1238,9 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		/* REVISIT may need to clear FLUSHFIFO ... */
 		musb_writew(epio, MUSB_TXCSR, tx_csr);
 		musb_writeb(epio, MUSB_TXINTERVAL, 0);
+#ifdef CONFIG_ARCH_DAVINCI
+		hw_ep->fifo_flush_check = 0;
+#endif
 
 		done = true;
 	}
@@ -1298,8 +1304,20 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		/* set status */
 		urb->status = status;
 		urb->actual_length = qh->offset;
+#ifdef CONFIG_ARCH_DAVINCI
+		/* Check for FIFO empty status.  If not wait for the same
+		 * before completing the urb.  This ensures that the toggle
+		 * status is correctly preserved and data will not be lost.
+		 */
+		if (((tx_csr & MUSB_TXCSR_FIFONOTEMPTY) ||
+			(tx_csr & MUSB_TXCSR_TXPKTRDY)) &&
+			(qh->num_req == 1)) {
+			hw_ep->fifo_flush_check = 1;
+			tasklet_schedule(&musb->fifo_check);
+			goto finish;
+		}
+#endif
 		musb_advance_schedule(musb, urb, hw_ep, USB_DIR_OUT);
-
 	} else if (!(tx_csr & MUSB_TXCSR_DMAENAB)) {
 		/* WARN_ON(!buf); */
 
@@ -1776,6 +1794,7 @@ static int musb_urb_enqueue(
 	 */
 	if (qh) {
 		urb->hcpriv = qh;
+		qh->num_req++;
 		return 0;
 	}
 
@@ -1891,6 +1910,7 @@ static int musb_urb_enqueue(
 
 	if (ret == 0) {
 		urb->hcpriv = qh;
+		qh->num_req = 1;
 		/* FIXME set urb->start_frame for iso/intr, it's tested in
 		 * musb_start_urb(), but otherwise only konicawc cares ...
 		 */
@@ -1959,6 +1979,9 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 		musb_writew(epio, MUSB_TXCSR, csr);
 		/* flush cpu writebuffer */
 		csr = musb_readw(epio, MUSB_TXCSR);
+#ifdef CONFIG_ARCH_DAVINCI
+		ep->fifo_flush_check = 0;
+#endif
 	}
 	if (status == 0)
 		musb_advance_schedule(ep->musb, urb, ep, is_in);
@@ -2132,6 +2155,46 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
 		return 0;
 }
 
+#ifdef CONFIG_ARCH_DAVINCI
+/* Tasklet routine to handle the completion request. Check for Fifo status
+ * before completing the request. Avoids false completions when data is still
+ * in the fifo
+ */
+void musb_fifo_check_tasklet(unsigned long data)
+{
+	struct musb		 *musb = (struct musb *)data;
+	u8			 epnum = 1, sch_tsklt = 0;
+	struct musb_hw_ep	 *hw_ep = NULL;
+	unsigned long		 flags;
+	u16			 csr;
+	struct musb_qh		*qh;
+
+	do {
+		hw_ep = &(musb->endpoints[epnum++]);
+		spin_lock_irqsave(&musb->lock, flags);
+		if (hw_ep->fifo_flush_check) {
+			csr = musb_readw(hw_ep->regs, MUSB_TXCSR);
+			if (((csr & MUSB_TXCSR_FIFONOTEMPTY) ||
+				(csr & MUSB_TXCSR_TXPKTRDY)))
+				sch_tsklt = 1;
+			else {
+				hw_ep->fifo_flush_check = 0;
+				qh = hw_ep->out_qh;
+				musb_advance_schedule(musb, next_urb(qh),
+							hw_ep, USB_DIR_OUT);
+				DBG(6, "Completed Tasklet %d\n", hw_ep->epnum);
+			}
+		}
+
+		spin_unlock_irqrestore(&musb->lock, flags);
+	} while (epnum < MUSB_C_NUM_EPS);
+
+	if (sch_tsklt)
+		tasklet_schedule(&musb->fifo_check);
+}
+#endif
+
+
 static int musb_bus_resume(struct usb_hcd *hcd)
 {
 	/* resuming child port does the work */
@@ -2164,3 +2227,4 @@ const struct hc_driver musb_hc_driver = {
 	/* .start_port_reset	= NULL, */
 	/* .hub_irq_enable	= NULL, */
 };
+
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
