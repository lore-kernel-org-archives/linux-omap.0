From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] musb_hdrc: Avoid host babble by checking tx fifo
Date: Thu,  3 May 2007 16:41:58 +0000
Message-ID: <11782105232838-git-send-email-tony@atomide.com>
References: musb-2007-05-03-164131
	<11782105181141-git-send-email-tony@atomide.com>
	<11782105222073-git-send-email-tony@atomide.com>
	<11782105223370-git-send-email-tony@atomide.com>
	<11782105221042-git-send-email-tony@atomide.com>
	<11782105222902-git-send-email-tony@atomide.com>
	<11782105231172-git-send-email-tony@atomide.com>
	<117821052378-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <117821052378-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Running a tusb6010 system in host mode would fail with
testusb -a -t12 -c1 most of the time with BABBLE errors.

Turns out this was caused by incorrect handling of TX
FIFONOTEMPTY, where the code did not wait for it to clear.

This patch introduces musb_h_tx_flush_fifo(), and makes
musb_host.c to use it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   58 +++++++++++++++++++++++++++--------------
 1 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 440df48..82ece3b 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -108,6 +108,29 @@ static void musb_ep_program(struct musb *pThis, u8 bEnd,
 			u8 * pBuffer, u32 dwLength);
 
 /*
+ * Clear TX fifo. Needed to avoid BABBLE errors.
+ */
+static inline void musb_h_tx_flush_fifo(struct musb_hw_ep *ep)
+{
+	void __iomem	*epio = ep->regs;
+	u16		csr;
+	int		retries = 1000;
+
+	csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+	while (csr & MGC_M_TXCSR_FIFONOTEMPTY) {
+		DBG(5, "Host TX FIFONOTEMPTY csr: %02x\n", csr);
+		csr |= MGC_M_TXCSR_FLUSHFIFO;
+		musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
+		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		if (retries-- < 1) {
+			ERR("Could not flush host TX fifo: csr: %04x\n", csr);
+			return;
+		}
+		mdelay(1);
+	}
+}
+
+/*
  * Start transmit. Caller is responsible for locking shared resources.
  * pThis must be locked.
  */
@@ -570,14 +593,9 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 	if (ep->bIsSharedFifo) {
 		csr = musb_readw(ep->regs, MGC_O_HDRC_TXCSR);
 		if (csr & MGC_M_TXCSR_MODE) {
-			if (csr & MGC_M_TXCSR_FIFONOTEMPTY) {
-				/* this shouldn't happen; irq?? */
-				ERR("shared fifo not empty?\n");
-				musb_writew(ep->regs, MGC_O_HDRC_TXCSR,
-						MGC_M_TXCSR_FLUSHFIFO);
-				musb_writew(ep->regs, MGC_O_HDRC_TXCSR,
-						MGC_M_TXCSR_FRCDATATOG);
-			}
+			musb_h_tx_flush_fifo(ep);
+			musb_writew(ep->regs, MGC_O_HDRC_TXCSR,
+					MGC_M_TXCSR_FRCDATATOG);
 		}
 		/* clear mode (and everything else) to enable Rx */
 		musb_writew(ep->regs, MGC_O_HDRC_TXCSR, 0);
@@ -683,14 +701,12 @@ static void musb_ep_program(struct musb *pThis, u8 bEnd,
 			/* ASSERT:  TXCSR_DMAENAB was already cleared */
 
 			/* flush all old state, set default */
-			if (csr & MGC_M_TXCSR_FIFONOTEMPTY)
-				csr |= MGC_M_TXCSR_FLUSHFIFO;
+			musb_h_tx_flush_fifo(pEnd);
 			csr &= ~(MGC_M_TXCSR_H_NAKTIMEOUT
 					| MGC_M_TXCSR_DMAMODE
 					| MGC_M_TXCSR_FRCDATATOG
 					| MGC_M_TXCSR_H_RXSTALL
 					| MGC_M_TXCSR_H_ERROR
-					| MGC_M_TXCSR_FIFONOTEMPTY
 					| MGC_M_TXCSR_TXPKTRDY
 					);
 			csr |= MGC_M_TXCSR_MODE;
@@ -1229,11 +1245,8 @@ void musb_host_tx(struct musb *pThis, u8 bEnd)
 		/* do the proper sequence to abort the transfer in the
 		 * usb core; the dma engine should already be stopped.
 		 */
-// SCRUB (TX)
-		if (wTxCsrVal & MGC_M_TXCSR_FIFONOTEMPTY)
-			wTxCsrVal |= MGC_M_TXCSR_FLUSHFIFO;
-		wTxCsrVal &= ~(MGC_M_TXCSR_FIFONOTEMPTY
-				| MGC_M_TXCSR_AUTOSET
+		musb_h_tx_flush_fifo(pEnd);
+		wTxCsrVal &= ~(MGC_M_TXCSR_AUTOSET
 				| MGC_M_TXCSR_DMAENAB
 				| MGC_M_TXCSR_H_ERROR
 				| MGC_M_TXCSR_H_RXSTALL
@@ -1949,16 +1962,13 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 		 * clearing that status is platform-specific...
 		 */
 	} else {
-// SCRUB (TX)
+		musb_h_tx_flush_fifo(ep);
 		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
-		if (csr & MGC_M_TXCSR_FIFONOTEMPTY)
-			csr |= MGC_M_TXCSR_FLUSHFIFO;
 		csr &= ~( MGC_M_TXCSR_AUTOSET
 			| MGC_M_TXCSR_DMAENAB
 			| MGC_M_TXCSR_H_RXSTALL
 			| MGC_M_TXCSR_H_NAKTIMEOUT
 			| MGC_M_TXCSR_H_ERROR
-			| MGC_M_TXCSR_FIFONOTEMPTY
 			);
 		musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 		/* REVISIT may need to clear FLUSHFIFO ... */
@@ -2002,6 +2012,14 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb)
 		}
 	}
 	spin_unlock(&urb->lock);
+
+	/* already completed */
+	if (!qh) {
+		status = 0;
+		goto done;
+	}
+
+	/* still queued but not found on the list */
 	if (status)
 		goto done;
 
-- 
1.4.4.2
