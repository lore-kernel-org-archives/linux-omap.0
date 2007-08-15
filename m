From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/8] musb_hdrc: Search and replace MGC_O_HDRC_ with MUSB_
Date: Wed, 15 Aug 2007 07:21:38 -0700
Message-ID: <11871877071348-git-send-email-tony@atomide.com>
References: <11871877051923-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11871877051923-git-send-email-tony@atomide.com>
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

Search and replace MGC_O_HDRC_ with MUSB_

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c      |   32 +++---
 drivers/usb/musb/davinci.c       |   12 +-
 drivers/usb/musb/g_ep0.c         |   60 ++++++------
 drivers/usb/musb/musb_gadget.c   |  168 ++++++++++++++++----------------
 drivers/usb/musb/musb_host.c     |  200 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_procfs.c   |   72 +++++++-------
 drivers/usb/musb/musbdefs.h      |    6 +-
 drivers/usb/musb/musbhdrc.h      |   92 +++++++++---------
 drivers/usb/musb/musbhsdma.c     |   12 +-
 drivers/usb/musb/omap2430.c      |    6 +-
 drivers/usb/musb/plat_uds.c      |  100 ++++++++++----------
 drivers/usb/musb/tusb6010.c      |   12 +-
 drivers/usb/musb/tusb6010_omap.c |   12 +-
 drivers/usb/musb/virthub.c       |   30 +++---
 14 files changed, 407 insertions(+), 407 deletions(-)

diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index 25941b5..db1fe8f 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -366,7 +366,7 @@ cppi_dump_rx(int level, struct cppi_channel *c, const char *tag)
 		c->chNo, tag,
 		musb_readl(base - DAVINCI_BASE_OFFSET,
 			DAVINCI_RXCPPI_BUFCNT0_REG + 4 *c->chNo),
-		musb_readw(c->hw_ep->regs, MGC_O_HDRC_RXCSR),
+		musb_readw(c->hw_ep->regs, MUSB_RXCSR),
 
 		musb_readl(c->stateRam, 0 * 4),	/* buf offset */
 		musb_readl(c->stateRam, 1 * 4),	/* head ptr */
@@ -393,7 +393,7 @@ cppi_dump_tx(int level, struct cppi_channel *c, const char *tag)
 			"F%08x L%08x .. %08x"
 			"\n",
 		c->chNo, tag,
-		musb_readw(c->hw_ep->regs, MGC_O_HDRC_TXCSR),
+		musb_readw(c->hw_ep->regs, MUSB_TXCSR),
 
 		musb_readl(c->stateRam, 0 * 4),	/* head ptr */
 		musb_readl(c->stateRam, 1 * 4),	/* sop bd */
@@ -500,12 +500,12 @@ static inline int cppi_autoreq_update(struct cppi_channel *rx,
 	if (n_bds && rx->actualLen) {
 		void		*__iomem regs = rx->hw_ep->regs;
 
-		val = musb_readw(regs, MGC_O_HDRC_RXCSR);
+		val = musb_readw(regs, MUSB_RXCSR);
 		if (!(val & MGC_M_RXCSR_H_REQPKT)) {
 			val |= MGC_M_RXCSR_H_REQPKT | MGC_M_RXCSR_H_WZC_BITS;
-			musb_writew(regs, MGC_O_HDRC_RXCSR, val);
+			musb_writew(regs, MUSB_RXCSR, val);
 			/* flush writebufer */
-			val = musb_readw(regs, MGC_O_HDRC_RXCSR);
+			val = musb_readw(regs, MUSB_RXCSR);
 		}
 	}
 	return n_bds;
@@ -1095,7 +1095,7 @@ static int cppi_rx_scan(struct cppi *cppi, unsigned ch)
 			WARN_ON(rx->activeQueueHead);
 		}
 		musb_ep_select(cppi->pCoreBase, rx->chNo + 1);
-		csr = musb_readw(regs, MGC_O_HDRC_RXCSR);
+		csr = musb_readw(regs, MUSB_RXCSR);
 		if (csr & MGC_M_RXCSR_DMAENAB) {
 			DBG(4, "list%d %p/%p, last %08x%s, csr %04x\n",
 				rx->chNo,
@@ -1116,14 +1116,14 @@ static int cppi_rx_scan(struct cppi *cppi, unsigned ch)
 		/* REVISIT seems like "autoreq all but EOP" doesn't...
 		 * setting it here "should" be racey, but seems to work
 		 */
-		csr = musb_readw(rx->hw_ep->regs, MGC_O_HDRC_RXCSR);
+		csr = musb_readw(rx->hw_ep->regs, MUSB_RXCSR);
 		if (is_host_active(cppi->musb)
 				&& bd
 				&& !(csr & MGC_M_RXCSR_H_REQPKT)) {
 			csr |= MGC_M_RXCSR_H_REQPKT;
-			musb_writew(regs, MGC_O_HDRC_RXCSR,
+			musb_writew(regs, MUSB_RXCSR,
 					MGC_M_RXCSR_H_WZC_BITS | csr);
-			csr = musb_readw(rx->hw_ep->regs, MGC_O_HDRC_RXCSR);
+			csr = musb_readw(rx->hw_ep->regs, MUSB_RXCSR);
 		}
 	} else {
 		rx->activeQueueHead = NULL;
@@ -1246,7 +1246,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 						int	csr;
 
 						csr = musb_readw(hw_ep->regs,
-							MGC_O_HDRC_TXCSR);
+							MUSB_TXCSR);
 						if (csr & MGC_M_TXCSR_TXPKTRDY)
 #endif
 							bReqComplete = 0;
@@ -1438,11 +1438,11 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		 * an appropriate status code.
 		 */
 
-		regVal = musb_readw(regs, MGC_O_HDRC_TXCSR);
+		regVal = musb_readw(regs, MUSB_TXCSR);
 		regVal &= ~MGC_M_TXCSR_DMAENAB;
 		regVal |= MGC_M_TXCSR_FLUSHFIFO;
-		musb_writew(regs, MGC_O_HDRC_TXCSR, regVal);
-		musb_writew(regs, MGC_O_HDRC_TXCSR, regVal);
+		musb_writew(regs, MUSB_TXCSR, regVal);
+		musb_writew(regs, MUSB_TXCSR, regVal);
 
 		/* re-enable interrupt */
 		if (enabled)
@@ -1496,7 +1496,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 			musb_writel(regBase, DAVINCI_AUTOREQ_REG, regVal);
 		}
 
-		csr = musb_readw(regs, MGC_O_HDRC_RXCSR);
+		csr = musb_readw(regs, MUSB_RXCSR);
 
 		/* for host, clear (just) ReqPkt at end of current packet(s) */
 		if (is_host_active(otgCh->pController->musb)) {
@@ -1507,8 +1507,8 @@ static int cppi_channel_abort(struct dma_channel *channel)
 
 		/* clear dma enable */
 		csr &= ~(MGC_M_RXCSR_DMAENAB);
-		musb_writew(regs, MGC_O_HDRC_RXCSR, csr);
-		csr = musb_readw(regs, MGC_O_HDRC_RXCSR);
+		musb_writew(regs, MUSB_RXCSR, csr);
+		csr = musb_readw(regs, MUSB_RXCSR);
 
 		/* quiesce: wait for current dma to finish (if not cleanup)
 		 * we can't use bit zero of stateram->sopDescPtr since that
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 3324543..8b87424 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -116,7 +116,7 @@ void musb_platform_disable(struct musb *musb)
 			  DAVINCI_USB_USBINT_MASK
 			| DAVINCI_USB_TXINT_MASK
 			| DAVINCI_USB_RXINT_MASK);
-	musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, 0);
+	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	musb_writel(musb->ctrl_base, DAVINCI_USB_EOI_REG, 0);
 
 	if (is_dma_capable() && !dma_off)
@@ -207,7 +207,7 @@ static void otg_timer(unsigned long _musb)
 	/* We poll because DaVinci's won't expose several OTG-critical
 	* status change events (from the transceiver) otherwise.
 	 */
-	devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
+	devctl = musb_readb(mregs, MUSB_DEVCTL);
 	DBG(7, "poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
 
 	spin_lock_irqsave(&musb->lock, flags);
@@ -241,9 +241,9 @@ static void otg_timer(unsigned long _musb)
 		 * NOTE setting the session flag is _supposed_ to trigger
 		 * SRP, but clearly it doesn't.
 		 */
-		musb_writeb(mregs, MGC_O_HDRC_DEVCTL,
+		musb_writeb(mregs, MUSB_DEVCTL,
 				devctl | MGC_M_DEVCTL_SESSION);
-		devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
+		devctl = musb_readb(mregs, MUSB_DEVCTL);
 		if (devctl & MGC_M_DEVCTL_BDEVICE)
 			mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
 		else
@@ -310,7 +310,7 @@ static irqreturn_t davinci_interrupt(int irq, void *__hci)
 	if (tmp & (DAVINCI_INTR_DRVVBUS << DAVINCI_USB_USBINT_SHIFT)) {
 		int	drvvbus = musb_readl(tibase, DAVINCI_USB_STAT_REG);
 		void	*__iomem mregs = musb->mregs;
-		u8	devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
+		u8	devctl = musb_readb(mregs, MUSB_DEVCTL);
 		int	err = musb->int_usb & MGC_M_INTR_VBUSERROR;
 
 		err = is_host_enabled(musb)
@@ -440,7 +440,7 @@ int musb_platform_exit(struct musb *musb)
 		 * long time to fall, especially on EVM with huge C133.
 		 */
 		do {
-			devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
+			devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 			if (!(devctl & MGC_M_DEVCTL_VBUS))
 				break;
 			if ((devctl & MGC_M_DEVCTL_VBUS) != warn) {
diff --git a/drivers/usb/musb/g_ep0.c b/drivers/usb/musb/g_ep0.c
index e1cbf18..fda3a54 100644
--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -129,10 +129,10 @@ static int service_tx_status_request(
 
 		musb_ep_select(mbase, epnum);
 		if (is_in)
-			tmp = musb_readw(regs, MGC_O_HDRC_TXCSR)
+			tmp = musb_readw(regs, MUSB_TXCSR)
 						& MGC_M_TXCSR_P_SENDSTALL;
 		else
-			tmp = musb_readw(regs, MGC_O_HDRC_RXCSR)
+			tmp = musb_readw(regs, MUSB_RXCSR)
 						& MGC_M_RXCSR_P_SENDSTALL;
 		musb_ep_select(mbase, 0);
 
@@ -209,8 +209,8 @@ static inline void musb_try_b_hnp_enable(struct musb *musb)
 	u8		devctl;
 
 	DBG(1, "HNP: Setting HR\n");
-	devctl = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
-	musb_writeb(mbase, MGC_O_HDRC_DEVCTL, devctl | MGC_M_DEVCTL_HR);
+	devctl = musb_readb(mbase, MUSB_DEVCTL);
+	musb_writeb(mbase, MUSB_DEVCTL, devctl | MGC_M_DEVCTL_HR);
 }
 
 /*
@@ -391,22 +391,22 @@ stall:
 				musb_ep_select(mbase, epnum);
 				if (is_in) {
 					csr = musb_readw(regs,
-							MGC_O_HDRC_TXCSR);
+							MUSB_TXCSR);
 					if (csr & MGC_M_TXCSR_FIFONOTEMPTY)
 						csr |= MGC_M_TXCSR_FLUSHFIFO;
 					csr |= MGC_M_TXCSR_P_SENDSTALL
 						| MGC_M_TXCSR_CLRDATATOG
 						| MGC_M_TXCSR_P_WZC_BITS;
-					musb_writew(regs, MGC_O_HDRC_TXCSR,
+					musb_writew(regs, MUSB_TXCSR,
 							csr);
 				} else {
 					csr = musb_readw(regs,
-							MGC_O_HDRC_RXCSR);
+							MUSB_RXCSR);
 					csr |= MGC_M_RXCSR_P_SENDSTALL
 						| MGC_M_RXCSR_FLUSHFIFO
 						| MGC_M_RXCSR_CLRDATATOG
 						| MGC_M_TXCSR_P_WZC_BITS;
-					musb_writew(regs, MGC_O_HDRC_RXCSR,
+					musb_writew(regs, MUSB_RXCSR,
 							csr);
 				}
 
@@ -449,7 +449,7 @@ static void ep0_rxstate(struct musb *this)
 		unsigned	len = req->length - req->actual;
 
 		/* read the buffer */
-		tmp = musb_readb(regs, MGC_O_HDRC_COUNT0);
+		tmp = musb_readb(regs, MUSB_COUNT0);
 		if (tmp > len) {
 			req->status = -EOVERFLOW;
 			tmp = len;
@@ -464,7 +464,7 @@ static void ep0_rxstate(struct musb *this)
 			req = NULL;
 	} else
 		tmp = MGC_M_CSR0_P_SVDRXPKTRDY | MGC_M_CSR0_P_SENDSTALL;
-	musb_writew(regs, MGC_O_HDRC_CSR0, tmp);
+	musb_writew(regs, MUSB_CSR0, tmp);
 
 
 	/* NOTE:  we "should" hold off reporting DATAEND and going to
@@ -491,7 +491,7 @@ static void ep0_txstate(struct musb *musb)
 
 	if (!request) {
 		// WARN_ON(1);
-		DBG(2, "odd; csr0 %04x\n", musb_readw(regs, MGC_O_HDRC_CSR0));
+		DBG(2, "odd; csr0 %04x\n", musb_readw(regs, MUSB_CSR0));
 		return;
 	}
 
@@ -511,7 +511,7 @@ static void ep0_txstate(struct musb *musb)
 		request = NULL;
 
 	/* send it out, triggering a "txpktrdy cleared" irq */
-	musb_writew(regs, MGC_O_HDRC_CSR0, csr);
+	musb_writew(regs, MUSB_CSR0, csr);
 
 	/* report completions as soon as the fifo's loaded; there's no
 	 * win in waiting till this last packet gets acked.  (other than
@@ -567,8 +567,8 @@ musb_read_setup(struct musb *musb, struct usb_ctrlrequest *req)
 		musb->ep0_state = MGC_END0_STAGE_ACKWAIT;
 	} else if (req->bRequestType & USB_DIR_IN) {
 		musb->ep0_state = MGC_END0_STAGE_TX;
-		musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_P_SVDRXPKTRDY);
-		while ((musb_readw(regs, MGC_O_HDRC_CSR0)
+		musb_writew(regs, MUSB_CSR0, MGC_M_CSR0_P_SVDRXPKTRDY);
+		while ((musb_readw(regs, MUSB_CSR0)
 				& MGC_M_CSR0_RXPKTRDY) != 0)
 			cpu_relax();
 		musb->ackpend = 0;
@@ -605,29 +605,29 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 	irqreturn_t	retval = IRQ_NONE;
 
 	musb_ep_select(mbase, 0);	/* select ep0 */
-	csr = musb_readw(regs, MGC_O_HDRC_CSR0);
-	len = musb_readb(regs, MGC_O_HDRC_COUNT0);
+	csr = musb_readw(regs, MUSB_CSR0);
+	len = musb_readb(regs, MUSB_COUNT0);
 
 	DBG(4, "csr %04x, count %d, myaddr %d, ep0stage %s\n",
 			csr, len,
-			musb_readb(mbase, MGC_O_HDRC_FADDR),
+			musb_readb(mbase, MUSB_FADDR),
 			decode_ep0stage(musb->ep0_state));
 
 	/* I sent a stall.. need to acknowledge it now.. */
 	if (csr & MGC_M_CSR0_P_SENTSTALL) {
-		musb_writew(regs, MGC_O_HDRC_CSR0,
+		musb_writew(regs, MUSB_CSR0,
 				csr & ~MGC_M_CSR0_P_SENTSTALL);
 		retval = IRQ_HANDLED;
 		musb->ep0_state = MGC_END0_STAGE_SETUP;
-		csr = musb_readw(regs, MGC_O_HDRC_CSR0);
+		csr = musb_readw(regs, MUSB_CSR0);
 	}
 
 	/* request ended "early" */
 	if (csr & MGC_M_CSR0_P_SETUPEND) {
-		musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_P_SVDSETUPEND);
+		musb_writew(regs, MUSB_CSR0, MGC_M_CSR0_P_SVDSETUPEND);
 		retval = IRQ_HANDLED;
 		musb->ep0_state = MGC_END0_STAGE_SETUP;
-		csr = musb_readw(regs, MGC_O_HDRC_CSR0);
+		csr = musb_readw(regs, MUSB_CSR0);
 		/* NOTE:  request may need completion */
 	}
 
@@ -663,7 +663,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		 */
 		if (musb->set_address) {
 			musb->set_address = FALSE;
-			musb_writeb(mbase, MGC_O_HDRC_FADDR, musb->address);
+			musb_writeb(mbase, MUSB_FADDR, musb->address);
 		}
 
 		/* enter test mode if needed (exit by reset) */
@@ -673,7 +673,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 			if (MGC_M_TEST_PACKET == musb->test_mode_nr)
 				musb_load_testpacket(musb);
 
-			musb_writeb(mbase, MGC_O_HDRC_TESTMODE,
+			musb_writeb(mbase, MUSB_TESTMODE,
 					musb->test_mode_nr);
 		}
 		/* FALLTHROUGH */
@@ -710,7 +710,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 				printk(KERN_NOTICE "%s: peripheral reset "
 						"irq lost!\n",
 						musb_driver_name);
-				power = musb_readb(mbase, MGC_O_HDRC_POWER);
+				power = musb_readb(mbase, MUSB_POWER);
 				musb->g.speed = (power & MGC_M_POWER_HSMODE)
 					? USB_SPEED_HIGH : USB_SPEED_FULL;
 
@@ -775,7 +775,7 @@ stall:
 				musb->ackpend |= MGC_M_CSR0_P_SENDSTALL;
 				musb->ep0_state = MGC_END0_STAGE_SETUP;
 finish:
-				musb_writew(regs, MGC_O_HDRC_CSR0,
+				musb_writew(regs, MUSB_CSR0,
 						musb->ackpend);
 				musb->ackpend = 0;
 			}
@@ -792,7 +792,7 @@ finish:
 	default:
 		/* "can't happen" */
 		WARN_ON(1);
-		musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_P_SENDSTALL);
+		musb_writew(regs, MUSB_CSR0, MGC_M_CSR0_P_SENDSTALL);
 		musb->ep0_state = MGC_END0_STAGE_SETUP;
 		break;
 	}
@@ -876,7 +876,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 			status = -EINVAL;
 		else {
 			musb->ep0_state = MGC_END0_STAGE_STATUSIN;
-			musb_writew(regs, MGC_O_HDRC_CSR0,
+			musb_writew(regs, MUSB_CSR0,
 					musb->ackpend | MGC_M_CSR0_P_DATAEND);
 			musb->ackpend = 0;
 			musb_g_ep0_giveback(ep->musb, r);
@@ -887,7 +887,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	 * (after SETUP is acked) are racey.
 	 */
 	} else if (musb->ackpend) {
-		musb_writew(regs, MGC_O_HDRC_CSR0, musb->ackpend);
+		musb_writew(regs, MUSB_CSR0, musb->ackpend);
 		musb->ackpend = 0;
 	}
 
@@ -934,9 +934,9 @@ static int musb_g_ep0_halt(struct usb_ep *e, int value)
 		status = 0;
 
 		musb_ep_select(base, 0);
-		csr = musb_readw(regs, MGC_O_HDRC_CSR0);
+		csr = musb_readw(regs, MUSB_CSR0);
 		csr |= MGC_M_CSR0_P_SENDSTALL;
-		musb_writew(regs, MGC_O_HDRC_CSR0, csr);
+		musb_writew(regs, MUSB_CSR0, csr);
 		musb->ep0_state = MGC_END0_STAGE_SETUP;
 		break;
 	default:
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 4aa82fe..7e05e15 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -167,14 +167,14 @@ static void nuke(struct musb_ep *ep, const int status)
 		struct dma_controller	*c = ep->musb->dma_controller;
 		int value;
 		if (ep->is_in) {
-			musb_writew(epio, MGC_O_HDRC_TXCSR,
+			musb_writew(epio, MUSB_TXCSR,
 					0 | MGC_M_TXCSR_FLUSHFIFO);
-			musb_writew(epio, MGC_O_HDRC_TXCSR,
+			musb_writew(epio, MUSB_TXCSR,
 					0 | MGC_M_TXCSR_FLUSHFIFO);
 		} else {
-			musb_writew(epio, MGC_O_HDRC_RXCSR,
+			musb_writew(epio, MUSB_RXCSR,
 					0 | MGC_M_RXCSR_FLUSHFIFO);
-			musb_writew(epio, MGC_O_HDRC_RXCSR,
+			musb_writew(epio, MUSB_RXCSR,
 					0 | MGC_M_RXCSR_FLUSHFIFO);
 		}
 
@@ -268,7 +268,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	}
 
 	/* read TXCSR before */
-	csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+	csr = musb_readw(epio, MUSB_TXCSR);
 
 	request = &req->request;
 	fifo_count = min(max_ep_writesize(musb, musb_ep),
@@ -330,7 +330,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 							| MGC_M_TXCSR_MODE);
 
 				csr &= ~MGC_M_TXCSR_P_UNDERRUN;
-				musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
+				musb_writew(epio, MUSB_TXCSR, csr);
 			}
 		}
 
@@ -341,12 +341,12 @@ static void txstate(struct musb *musb, struct musb_request *req)
 				| MGC_M_TXCSR_P_UNDERRUN
 				| MGC_M_TXCSR_TXPKTRDY);
 		csr |= MGC_M_TXCSR_MODE | MGC_M_TXCSR_DMAENAB;
-		musb_writew(epio, MGC_O_HDRC_TXCSR,
+		musb_writew(epio, MUSB_TXCSR,
 			(MGC_M_TXCSR_P_WZC_BITS & ~MGC_M_TXCSR_P_UNDERRUN)
 				| csr);
 
 		/* ensure writebuffer is empty */
-		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		csr = musb_readw(epio, MUSB_TXCSR);
 
 		/* NOTE host side sets DMAENAB later than this; both are
 		 * OK since the transfer dma glue (between CPPI and Mentor
@@ -386,16 +386,16 @@ static void txstate(struct musb *musb, struct musb_request *req)
 		request->actual += fifo_count;
 		csr |= MGC_M_TXCSR_TXPKTRDY;
 		csr &= ~MGC_M_TXCSR_P_UNDERRUN;
-		musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
+		musb_writew(epio, MUSB_TXCSR, csr);
 	}
 
 	/* host may already have the data when this message shows... */
 	DBG(3, "%s TX/IN %s len %d/%d, txcsr %04x, fifo %d/%d\n",
 			musb_ep->end_point.name, use_dma ? "dma" : "pio",
 			request->actual, request->length,
-			musb_readw(epio, MGC_O_HDRC_TXCSR),
+			musb_readw(epio, MUSB_TXCSR),
 			fifo_count,
-			musb_readw(epio, MGC_O_HDRC_TXMAXP));
+			musb_readw(epio, MUSB_TXMAXP));
 }
 
 /*
@@ -414,7 +414,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 	musb_ep_select(mbase, epnum);
 	request = next_request(musb_ep);
 
-	csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+	csr = musb_readw(epio, MUSB_TXCSR);
 	DBG(4, "<== %s, txcsr %04x\n", musb_ep->end_point.name, csr);
 
 	dma = is_dma_capable() ? musb_ep->dma : NULL;
@@ -425,7 +425,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 		if (csr & MGC_M_TXCSR_P_SENTSTALL) {
 			csr |= MGC_M_TXCSR_P_WZC_BITS;
 			csr &= ~MGC_M_TXCSR_P_SENTSTALL;
-			musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
+			musb_writew(epio, MUSB_TXCSR, csr);
 			if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 				dma->status = MGC_DMA_STATUS_CORE_ABORT;
 				musb->dma_controller->channel_abort(dma);
@@ -442,7 +442,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			csr |= MGC_M_TXCSR_P_WZC_BITS;
 			csr &= ~(MGC_M_TXCSR_P_UNDERRUN
 					| MGC_M_TXCSR_TXPKTRDY);
-			musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
+			musb_writew(epio, MUSB_TXCSR, csr);
 			DBG(20, "underrun on ep%d, req %p\n", epnum, request);
 		}
 
@@ -463,9 +463,9 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				csr &= ~(MGC_M_TXCSR_DMAENAB
 						| MGC_M_TXCSR_P_UNDERRUN
 						| MGC_M_TXCSR_TXPKTRDY);
-				musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
+				musb_writew(epio, MUSB_TXCSR, csr);
 				/* ensure writebuffer is empty */
-				csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+				csr = musb_readw(epio, MUSB_TXCSR);
 				request->actual += musb_ep->dma->actual_len;
 				DBG(4, "TXCSR%d %04x, dma off, "
 						"len %Zd, req %p\n",
@@ -499,7 +499,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 						break;
 
 					DBG(4, "sending zero pkt\n");
-					musb_writew(epio, MGC_O_HDRC_TXCSR,
+					musb_writew(epio, MUSB_TXCSR,
 							MGC_M_TXCSR_MODE
 							| MGC_M_TXCSR_TXPKTRDY);
 					request->zero = 0;
@@ -515,7 +515,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				 * FIXME revisit for stalls too...
 				 */
 				musb_ep_select(mbase, epnum);
-				csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+				csr = musb_readw(epio, MUSB_TXCSR);
 				if (csr & MGC_M_TXCSR_FIFONOTEMPTY)
 					break;
 				request = musb_ep->desc
@@ -580,7 +580,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	u16			fifo_count = 0;
 	u16			len = musb_ep->packet_sz;
 
-	csr = musb_readw(epio, MGC_O_HDRC_RXCSR);
+	csr = musb_readw(epio, MUSB_RXCSR);
 
 	if (is_cppi_enabled() && musb_ep->dma) {
 		struct dma_controller	*c = musb->dma_controller;
@@ -604,13 +604,13 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			csr &= ~(MGC_M_RXCSR_AUTOCLEAR
 					| MGC_M_RXCSR_DMAMODE);
 			csr |= MGC_M_RXCSR_DMAENAB | MGC_M_RXCSR_P_WZC_BITS;
-			musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
+			musb_writew(epio, MUSB_RXCSR, csr);
 			return;
 		}
 	}
 
 	if (csr & MGC_M_RXCSR_RXPKTRDY) {
-		len = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
+		len = musb_readw(epio, MUSB_RXCOUNT);
 		if (request->actual < request->length) {
 #ifdef CONFIG_USB_INVENTRA_DMA
 			if (is_dma_capable() && musb_ep->dma) {
@@ -651,10 +651,10 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 				   disabling MGC_M_RXCSR_DMAMODE) is required
 				   to get DMAReq to activate
 				 */
-				musb_writew(epio, MGC_O_HDRC_RXCSR,
+				musb_writew(epio, MUSB_RXCSR,
 					csr | MGC_M_RXCSR_DMAMODE);
 #endif
-				musb_writew(epio, MGC_O_HDRC_RXCSR,
+				musb_writew(epio, MUSB_RXCSR,
 						csr);
 
 				if (request->actual < request->length) {
@@ -720,7 +720,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			/* ack the read! */
 			csr |= MGC_M_RXCSR_P_WZC_BITS;
 			csr &= ~MGC_M_RXCSR_RXPKTRDY;
-			musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
+			musb_writew(epio, MUSB_RXCSR, csr);
 		}
 	}
 
@@ -745,7 +745,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 	request = next_request(musb_ep);
 
-	csr = musb_readw(epio, MGC_O_HDRC_RXCSR);
+	csr = musb_readw(epio, MUSB_RXCSR);
 	dma = is_dma_capable() ? musb_ep->dma : NULL;
 
 	DBG(4, "<== %s, rxcsr %04x%s %p\n", musb_ep->end_point.name,
@@ -760,7 +760,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 		csr |= MGC_M_RXCSR_P_WZC_BITS;
 		csr &= ~MGC_M_RXCSR_P_SENTSTALL;
-		musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
+		musb_writew(epio, MUSB_RXCSR, csr);
 
 		if (request)
 			musb_g_giveback(musb_ep, request, -EPIPE);
@@ -770,7 +770,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 	if (csr & MGC_M_RXCSR_P_OVERRUN) {
 		// csr |= MGC_M_RXCSR_P_WZC_BITS;
 		csr &= ~MGC_M_RXCSR_P_OVERRUN;
-		musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
+		musb_writew(epio, MUSB_RXCSR, csr);
 
 		DBG(3, "%s iso overrun on %p\n", musb_ep->name, request);
 		if (request && request->status == -EINPROGRESS)
@@ -793,14 +793,14 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		csr &= ~(MGC_M_RXCSR_AUTOCLEAR
 				| MGC_M_RXCSR_DMAENAB
 				| MGC_M_RXCSR_DMAMODE);
-		musb_writew(epio, MGC_O_HDRC_RXCSR,
+		musb_writew(epio, MUSB_RXCSR,
 			MGC_M_RXCSR_P_WZC_BITS | csr);
 
 		request->actual += musb_ep->dma->actual_len;
 
 		DBG(4, "RXCSR%d %04x, dma off, %04x, len %Zd, req %p\n",
 			epnum, csr,
-			musb_readw(epio, MGC_O_HDRC_RXCSR),
+			musb_readw(epio, MUSB_RXCSR),
 			musb_ep->dma->actual_len, request);
 
 #if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_TUSB_OMAP_DMA)
@@ -810,7 +810,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 					& (musb_ep->packet_sz - 1))) {
 			/* ack the read! */
 			csr &= ~MGC_M_RXCSR_RXPKTRDY;
-			musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
+			musb_writew(epio, MUSB_RXCSR, csr);
 		}
 
 		/* incomplete, and not short? wait for next IN packet */
@@ -827,7 +827,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 		/* don't start more i/o till the stall clears */
 		musb_ep_select(mbase, epnum);
-		csr = musb_readw(epio, MGC_O_HDRC_RXCSR);
+		csr = musb_readw(epio, MUSB_RXCSR);
 		if (csr & MGC_M_RXCSR_P_SENDSTALL)
 			goto done;
 	}
@@ -894,7 +894,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	 */
 	musb_ep_select(mbase, epnum);
 	if (desc->bEndpointAddress & USB_DIR_IN) {
-		u16 wIntrTxE = musb_readw(mbase, MGC_O_HDRC_INTRTXE);
+		u16 wIntrTxE = musb_readw(mbase, MUSB_INTRTXE);
 
 		if (hw_ep->is_shared_fifo)
 			musb_ep->is_in = 1;
@@ -904,27 +904,27 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			goto fail;
 
 		wIntrTxE |= (1 << epnum);
-		musb_writew(mbase, MGC_O_HDRC_INTRTXE, wIntrTxE);
+		musb_writew(mbase, MUSB_INTRTXE, wIntrTxE);
 
 		/* REVISIT if can_bulk_split(), use by updating "tmp";
 		 * likewise high bandwidth periodic tx
 		 */
-		musb_writew(regs, MGC_O_HDRC_TXMAXP, tmp);
+		musb_writew(regs, MUSB_TXMAXP, tmp);
 
 		csr = MGC_M_TXCSR_MODE | MGC_M_TXCSR_CLRDATATOG;
-		if (musb_readw(regs, MGC_O_HDRC_TXCSR)
+		if (musb_readw(regs, MUSB_TXCSR)
 				& MGC_M_TXCSR_FIFONOTEMPTY)
 			csr |= MGC_M_TXCSR_FLUSHFIFO;
 		if (musb_ep->type == USB_ENDPOINT_XFER_ISOC)
 			csr |= MGC_M_TXCSR_P_ISO;
 
 		/* set twice in case of double buffering */
-		musb_writew(regs, MGC_O_HDRC_TXCSR, csr);
+		musb_writew(regs, MUSB_TXCSR, csr);
 		/* REVISIT may be inappropriate w/o FIFONOTEMPTY ... */
-		musb_writew(regs, MGC_O_HDRC_TXCSR, csr);
+		musb_writew(regs, MUSB_TXCSR, csr);
 
 	} else {
-		u16 wIntrRxE = musb_readw(mbase, MGC_O_HDRC_INTRRXE);
+		u16 wIntrRxE = musb_readw(mbase, MUSB_INTRRXE);
 
 		if (hw_ep->is_shared_fifo)
 			musb_ep->is_in = 0;
@@ -934,18 +934,18 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			goto fail;
 
 		wIntrRxE |= (1 << epnum);
-		musb_writew(mbase, MGC_O_HDRC_INTRRXE, wIntrRxE);
+		musb_writew(mbase, MUSB_INTRRXE, wIntrRxE);
 
 		/* REVISIT if can_bulk_combine() use by updating "tmp"
 		 * likewise high bandwidth periodic rx
 		 */
-		musb_writew(regs, MGC_O_HDRC_RXMAXP, tmp);
+		musb_writew(regs, MUSB_RXMAXP, tmp);
 
 		/* force shared fifo to OUT-only mode */
 		if (hw_ep->is_shared_fifo) {
-			csr = musb_readw(regs, MGC_O_HDRC_TXCSR);
+			csr = musb_readw(regs, MUSB_TXCSR);
 			csr &= ~(MGC_M_TXCSR_MODE | MGC_M_TXCSR_TXPKTRDY);
-			musb_writew(regs, MGC_O_HDRC_TXCSR, csr);
+			musb_writew(regs, MUSB_TXCSR, csr);
 		}
 
 		csr = MGC_M_RXCSR_FLUSHFIFO | MGC_M_RXCSR_CLRDATATOG;
@@ -955,8 +955,8 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			csr |= MGC_M_RXCSR_DISNYET;
 
 		/* set twice in case of double buffering */
-		musb_writew(regs, MGC_O_HDRC_RXCSR, csr);
-		musb_writew(regs, MGC_O_HDRC_RXCSR, csr);
+		musb_writew(regs, MUSB_RXCSR, csr);
+		musb_writew(regs, MUSB_RXCSR, csr);
 	}
 
 	/* NOTE:  all the I/O code _should_ work fine without DMA, in case
@@ -1014,15 +1014,15 @@ static int musb_gadget_disable(struct usb_ep *ep)
 
 	/* zero the endpoint sizes */
 	if (musb_ep->is_in) {
-		u16 wIntrTxE = musb_readw(musb->mregs, MGC_O_HDRC_INTRTXE);
+		u16 wIntrTxE = musb_readw(musb->mregs, MUSB_INTRTXE);
 		wIntrTxE &= ~(1 << epnum);
-		musb_writew(musb->mregs, MGC_O_HDRC_INTRTXE, wIntrTxE);
-		musb_writew(epio, MGC_O_HDRC_TXMAXP, 0);
+		musb_writew(musb->mregs, MUSB_INTRTXE, wIntrTxE);
+		musb_writew(epio, MUSB_TXMAXP, 0);
 	} else {
-		u16 wIntrRxE = musb_readw(musb->mregs, MGC_O_HDRC_INTRRXE);
+		u16 wIntrRxE = musb_readw(musb->mregs, MUSB_INTRRXE);
 		wIntrRxE &= ~(1 << epnum);
-		musb_writew(musb->mregs, MGC_O_HDRC_INTRRXE, wIntrRxE);
-		musb_writew(epio, MGC_O_HDRC_RXMAXP, 0);
+		musb_writew(musb->mregs, MUSB_INTRRXE, wIntrRxE);
+		musb_writew(epio, MUSB_RXMAXP, 0);
 	}
 
 	musb_ep->desc = NULL;
@@ -1254,7 +1254,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	/* cannot portably stall with non-empty FIFO */
 	request = to_musb_request(next_request(musb_ep));
 	if (value && musb_ep->is_in) {
-		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		wCsr = musb_readw(epio, MUSB_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY) {
 			DBG(3, "%s fifo busy, cannot halt\n", ep->name);
 			spin_unlock_irqrestore(&musb->lock, flags);
@@ -1266,7 +1266,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	/* set/clear the stall and toggle bits */
 	DBG(2, "%s: %s stall\n", ep->name, value ? "set" : "clear");
 	if (musb_ep->is_in) {
-		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		wCsr = musb_readw(epio, MUSB_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY)
 			wCsr |= MGC_M_TXCSR_FLUSHFIFO;
 		wCsr |= MGC_M_TXCSR_P_WZC_BITS
@@ -1277,9 +1277,9 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 			wCsr &= ~(MGC_M_TXCSR_P_SENDSTALL
 				| MGC_M_TXCSR_P_SENTSTALL);
 		wCsr &= ~MGC_M_TXCSR_TXPKTRDY;
-		musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
+		musb_writew(epio, MUSB_TXCSR, wCsr);
 	} else {
-		wCsr = musb_readw(epio, MGC_O_HDRC_RXCSR);
+		wCsr = musb_readw(epio, MUSB_RXCSR);
 		wCsr |= MGC_M_RXCSR_P_WZC_BITS
 			| MGC_M_RXCSR_FLUSHFIFO
 			| MGC_M_RXCSR_CLRDATATOG;
@@ -1288,7 +1288,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 		else
 			wCsr &= ~(MGC_M_RXCSR_P_SENDSTALL
 				| MGC_M_RXCSR_P_SENTSTALL);
-		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsr);
+		musb_writew(epio, MUSB_RXCSR, wCsr);
 	}
 
 done:
@@ -1319,7 +1319,7 @@ static int musb_gadget_fifo_status(struct usb_ep *ep)
 
 		musb_ep_select(mbase, epnum);
 		/* FIXME return zero unless RXPKTRDY is set */
-		retval = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
+		retval = musb_readw(epio, MUSB_RXCOUNT);
 
 		spin_unlock_irqrestore(&musb->lock, flags);
 	}
@@ -1342,26 +1342,26 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 	musb_ep_select(mbase, (u8) nEnd);
 
 	/* disable interrupts */
-	wIntrTxE = musb_readw(mbase, MGC_O_HDRC_INTRTXE);
-	musb_writew(mbase, MGC_O_HDRC_INTRTXE, wIntrTxE & ~(1 << nEnd));
+	wIntrTxE = musb_readw(mbase, MUSB_INTRTXE);
+	musb_writew(mbase, MUSB_INTRTXE, wIntrTxE & ~(1 << nEnd));
 
 	if (musb_ep->is_in) {
-		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		wCsr = musb_readw(epio, MUSB_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY) {
 			wCsr |= MGC_M_TXCSR_FLUSHFIFO | MGC_M_TXCSR_P_WZC_BITS;
-			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
+			musb_writew(epio, MUSB_TXCSR, wCsr);
 			/* REVISIT may be inappropriate w/o FIFONOTEMPTY ... */
-			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
+			musb_writew(epio, MUSB_TXCSR, wCsr);
 		}
 	} else {
-		wCsr = musb_readw(epio, MGC_O_HDRC_RXCSR);
+		wCsr = musb_readw(epio, MUSB_RXCSR);
 		wCsr |= MGC_M_RXCSR_FLUSHFIFO | MGC_M_RXCSR_P_WZC_BITS;
-		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsr);
-		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsr);
+		musb_writew(epio, MUSB_RXCSR, wCsr);
+		musb_writew(epio, MUSB_RXCSR, wCsr);
 	}
 
 	/* re-enable interrupt */
-	musb_writew(mbase, MGC_O_HDRC_INTRTXE, wIntrTxE);
+	musb_writew(mbase, MUSB_INTRTXE, wIntrTxE);
 	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
@@ -1383,7 +1383,7 @@ static int musb_gadget_get_frame(struct usb_gadget *gadget)
 {
 	struct musb	*musb = gadget_to_musb(gadget);
 
-	return (int)musb_readw(musb->mregs, MGC_O_HDRC_FRAME);
+	return (int)musb_readw(musb->mregs, MUSB_FRAME);
 }
 
 static int musb_gadget_wakeup(struct usb_gadget *gadget)
@@ -1408,20 +1408,20 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 		goto done;
 	case OTG_STATE_B_IDLE:
 		/* Start SRP ... OTG not required. */
-		devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
+		devctl = musb_readb(mregs, MUSB_DEVCTL);
 		DBG(2, "Sending SRP: devctl: %02x\n", devctl);
 		devctl |= MGC_M_DEVCTL_SESSION;
-		musb_writeb(mregs, MGC_O_HDRC_DEVCTL, devctl);
-		devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
+		musb_writeb(mregs, MUSB_DEVCTL, devctl);
+		devctl = musb_readb(mregs, MUSB_DEVCTL);
 		retries = 100;
 		while (!(devctl & MGC_M_DEVCTL_SESSION)) {
-			devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
+			devctl = musb_readb(mregs, MUSB_DEVCTL);
 			if (retries-- < 1)
 				break;
 		}
 		retries = 10000;
 		while (devctl & MGC_M_DEVCTL_SESSION) {
-			devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
+			devctl = musb_readb(mregs, MUSB_DEVCTL);
 			if (retries-- < 1)
 				break;
 		}
@@ -1438,17 +1438,17 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 
 	status = 0;
 
-	power = musb_readb(mregs, MGC_O_HDRC_POWER);
+	power = musb_readb(mregs, MUSB_POWER);
 	power |= MGC_M_POWER_RESUME;
-	musb_writeb(mregs, MGC_O_HDRC_POWER, power);
+	musb_writeb(mregs, MUSB_POWER, power);
 	DBG(2, "issue wakeup\n");
 
 	/* FIXME do this next chunk in a timer callback, no udelay */
 	mdelay(2);
 
-	power = musb_readb(mregs, MGC_O_HDRC_POWER);
+	power = musb_readb(mregs, MUSB_POWER);
 	power &= ~MGC_M_POWER_RESUME;
-	musb_writeb(mregs, MGC_O_HDRC_POWER, power);
+	musb_writeb(mregs, MUSB_POWER, power);
 done:
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return status;
@@ -1467,7 +1467,7 @@ static void musb_pullup(struct musb *musb, int is_on)
 {
 	u8 power;
 
-	power = musb_readb(musb->mregs, MGC_O_HDRC_POWER);
+	power = musb_readb(musb->mregs, MUSB_POWER);
 	if (is_on)
 		power |= MGC_M_POWER_SOFTCONN;
 	else
@@ -1477,7 +1477,7 @@ static void musb_pullup(struct musb *musb, int is_on)
 
 	DBG(3, "gadget %s D+ pullup %s\n",
 		musb->gadget_driver->function, is_on ? "on" : "off");
-	musb_writeb(musb->mregs, MGC_O_HDRC_POWER, power);
+	musb_writeb(musb->mregs, MUSB_POWER, power);
 }
 
 #if 0
@@ -1905,7 +1905,7 @@ void musb_g_suspend(struct musb *musb)
 {
 	u8	devctl;
 
-	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
+	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 	DBG(3, "devctl %02x\n", devctl);
 
 	switch (musb->xceiv.state) {
@@ -1940,12 +1940,12 @@ void musb_g_wakeup(struct musb *musb)
 void musb_g_disconnect(struct musb *musb)
 {
 	void __iomem	*mregs = musb->mregs;
-	u8	devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
+	u8	devctl = musb_readb(mregs, MUSB_DEVCTL);
 
 	DBG(3, "devctl %02x\n", devctl);
 
 	/* clear HR */
-	musb_writeb(mregs, MGC_O_HDRC_DEVCTL, devctl & MGC_M_DEVCTL_SESSION);
+	musb_writeb(mregs, MUSB_DEVCTL, devctl & MGC_M_DEVCTL_SESSION);
 
 	/* don't draw vbus until new b-default session */
 	(void) musb_gadget_vbus_draw(&musb->g, 0);
@@ -1983,13 +1983,13 @@ __releases(musb->lock)
 __acquires(musb->lock)
 {
 	void __iomem	*mbase = musb->mregs;
-	u8		devctl = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
+	u8		devctl = musb_readb(mbase, MUSB_DEVCTL);
 	u8		power;
 
 	DBG(3, "<== %s addr=%x driver '%s'\n",
 			(devctl & MGC_M_DEVCTL_BDEVICE)
 				? "B-Device" : "A-Device",
-			musb_readb(mbase, MGC_O_HDRC_FADDR),
+			musb_readb(mbase, MUSB_FADDR),
 			musb->gadget_driver
 				? musb->gadget_driver->driver.name
 				: NULL
@@ -2001,11 +2001,11 @@ __acquires(musb->lock)
 
 	/* clear HR */
 	else if (devctl & MGC_M_DEVCTL_HR)
-		musb_writeb(mbase, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
+		musb_writeb(mbase, MUSB_DEVCTL, MGC_M_DEVCTL_SESSION);
 
 
 	/* what speed did we negotiate? */
-	power = musb_readb(mbase, MGC_O_HDRC_POWER);
+	power = musb_readb(mbase, MUSB_POWER);
 	musb->g.speed = (power & MGC_M_POWER_HSMODE)
 			? USB_SPEED_HIGH : USB_SPEED_FULL;
 
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index bcb6cdb..7840f59 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -116,12 +116,12 @@ static inline void musb_h_tx_flush_fifo(struct musb_hw_ep *ep)
 	u16		csr;
 	int		retries = 1000;
 
-	csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+	csr = musb_readw(epio, MUSB_TXCSR);
 	while (csr & MGC_M_TXCSR_FIFONOTEMPTY) {
 		DBG(5, "Host TX FIFONOTEMPTY csr: %02x\n", csr);
 		csr |= MGC_M_TXCSR_FLUSHFIFO;
-		musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
-		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		musb_writew(epio, MUSB_TXCSR, csr);
+		csr = musb_readw(epio, MUSB_TXCSR);
 		if (retries-- < 1) {
 			ERR("Could not flush host TX fifo: csr: %04x\n", csr);
 			return;
@@ -140,12 +140,12 @@ static inline void musb_h_tx_start(struct musb_hw_ep *ep)
 
 	/* NOTE: no locks here; caller should lock and select EP */
 	if (ep->epnum) {
-		txcsr = musb_readw(ep->regs, MGC_O_HDRC_TXCSR);
+		txcsr = musb_readw(ep->regs, MUSB_TXCSR);
 		txcsr |= MGC_M_TXCSR_TXPKTRDY | MGC_M_TXCSR_H_WZC_BITS;
-		musb_writew(ep->regs, MGC_O_HDRC_TXCSR, txcsr);
+		musb_writew(ep->regs, MUSB_TXCSR, txcsr);
 	} else {
 		txcsr = MGC_M_CSR0_H_SETUPPKT | MGC_M_CSR0_TXPKTRDY;
-		musb_writew(ep->regs, MGC_O_HDRC_CSR0, txcsr);
+		musb_writew(ep->regs, MUSB_CSR0, txcsr);
 	}
 
 }
@@ -155,9 +155,9 @@ static inline void cppi_host_txdma_start(struct musb_hw_ep *ep)
 	u16	txcsr;
 
 	/* NOTE: no locks here; caller should lock and select EP */
-	txcsr = musb_readw(ep->regs, MGC_O_HDRC_TXCSR);
+	txcsr = musb_readw(ep->regs, MUSB_TXCSR);
 	txcsr |= MGC_M_TXCSR_DMAENAB | MGC_M_TXCSR_H_WZC_BITS;
-	musb_writew(ep->regs, MGC_O_HDRC_TXCSR, txcsr);
+	musb_writew(ep->regs, MUSB_TXCSR, txcsr);
 }
 
 /*
@@ -232,7 +232,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	case USB_ENDPOINT_XFER_INT:
 		DBG(3, "check whether there's still time for periodic Tx\n");
 		qh->iso_idx = 0;
-		wFrame = musb_readw(mbase, MGC_O_HDRC_FRAME);
+		wFrame = musb_readw(mbase, MUSB_FRAME);
 		/* FIXME this doesn't implement that scheduling policy ...
 		 * or handle framecounter wrapping
 		 */
@@ -248,7 +248,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 			/* enable SOF interrupt so we can count down */
 DBG(1,"SOF for %d\n", epnum);
 #if 1 // ifndef	CONFIG_ARCH_DAVINCI
-			musb_writeb(mbase, MGC_O_HDRC_INTRUSBE, 0xff);
+			musb_writeb(mbase, MUSB_INTRUSBE, 0xff);
 #endif
 		}
 		break;
@@ -328,12 +328,12 @@ static inline void musb_save_toggle(struct musb_hw_ep *ep, int is_in, struct urb
 		qh = ep->out_qh;
 
 	if (!is_in) {
-		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		csr = musb_readw(epio, MUSB_TXCSR);
 		usb_settoggle(udev, qh->epnum, 1,
 			(csr & MGC_M_TXCSR_H_DATATOGGLE)
 				? 1 : 0);
 	} else {
-		csr = musb_readw(epio, MGC_O_HDRC_RXCSR);
+		csr = musb_readw(epio, MUSB_RXCSR);
 		usb_settoggle(udev, qh->epnum, 0,
 			(csr & MGC_M_RXCSR_H_DATATOGGLE)
 				? 1 : 0);
@@ -456,11 +456,11 @@ static inline u16 musb_h_flush_rxfifo(struct musb_hw_ep *hw_ep, u16 csr)
 		);
 
 	/* write 2x to allow double buffering */
-	musb_writew(hw_ep->regs, MGC_O_HDRC_RXCSR, csr);
-	musb_writew(hw_ep->regs, MGC_O_HDRC_RXCSR, csr);
+	musb_writew(hw_ep->regs, MUSB_RXCSR, csr);
+	musb_writew(hw_ep->regs, MUSB_RXCSR, csr);
 
 	/* flush writebuffer */
-	return musb_readw(hw_ep->regs, MGC_O_HDRC_RXCSR);
+	return musb_readw(hw_ep->regs, MUSB_RXCSR);
 }
 
 /*
@@ -482,7 +482,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
 	void			*buffer = pUrb->transfer_buffer;
 
 	// musb_ep_select(mbase, epnum);
-	wRxCount = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
+	wRxCount = musb_readw(epio, MUSB_RXCOUNT);
 	DBG(3, "RX%d count %d, buffer %p len %d/%d\n", epnum, wRxCount,
 			pUrb->transfer_buffer, qh->offset,
 			pUrb->transfer_buffer_length);
@@ -544,7 +544,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
 
 	musb_read_fifo(hw_ep, length, pBuffer);
 
-	wCsr = musb_readw(epio, MGC_O_HDRC_RXCSR);
+	wCsr = musb_readw(epio, MUSB_RXCSR);
 	wCsr |= MGC_M_RXCSR_H_WZC_BITS;
 	if (unlikely(do_flush))
 		musb_h_flush_rxfifo(hw_ep, wCsr);
@@ -553,7 +553,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
 		wCsr &= ~(MGC_M_RXCSR_RXPKTRDY | MGC_M_RXCSR_H_REQPKT);
 		if (!bDone)
 			wCsr |= MGC_M_RXCSR_H_REQPKT;
-		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsr);
+		musb_writew(epio, MUSB_RXCSR, wCsr);
 	}
 
 	return bDone;
@@ -579,41 +579,41 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 
 	/* if programmed for Tx, put it in RX mode */
 	if (ep->is_shared_fifo) {
-		csr = musb_readw(ep->regs, MGC_O_HDRC_TXCSR);
+		csr = musb_readw(ep->regs, MUSB_TXCSR);
 		if (csr & MGC_M_TXCSR_MODE) {
 			musb_h_tx_flush_fifo(ep);
-			musb_writew(ep->regs, MGC_O_HDRC_TXCSR,
+			musb_writew(ep->regs, MUSB_TXCSR,
 					MGC_M_TXCSR_FRCDATATOG);
 		}
 		/* clear mode (and everything else) to enable Rx */
-		musb_writew(ep->regs, MGC_O_HDRC_TXCSR, 0);
+		musb_writew(ep->regs, MUSB_TXCSR, 0);
 
 	/* scrub all previous state, clearing toggle */
 	} else {
-		csr = musb_readw(ep->regs, MGC_O_HDRC_RXCSR);
+		csr = musb_readw(ep->regs, MUSB_RXCSR);
 		if (csr & MGC_M_RXCSR_RXPKTRDY)
 			WARN("rx%d, packet/%d ready?\n", ep->epnum,
-				musb_readw(ep->regs, MGC_O_HDRC_RXCOUNT));
+				musb_readw(ep->regs, MUSB_RXCOUNT));
 
 		musb_h_flush_rxfifo(ep, MGC_M_RXCSR_CLRDATATOG);
 	}
 
 	/* target addr and (for multipoint) hub addr/port */
 	if (musb->is_multipoint) {
-		musb_writeb(ep->target_regs, MGC_O_HDRC_RXFUNCADDR,
+		musb_writeb(ep->target_regs, MUSB_RXFUNCADDR,
 			qh->addr_reg);
-		musb_writeb(ep->target_regs, MGC_O_HDRC_RXHUBADDR,
+		musb_writeb(ep->target_regs, MUSB_RXHUBADDR,
 			qh->h_addr_reg);
-		musb_writeb(ep->target_regs, MGC_O_HDRC_RXHUBPORT,
+		musb_writeb(ep->target_regs, MUSB_RXHUBPORT,
 			qh->h_port_reg);
 	} else
-		musb_writeb(musb->mregs, MGC_O_HDRC_FADDR, qh->addr_reg);
+		musb_writeb(musb->mregs, MUSB_FADDR, qh->addr_reg);
 
 	/* protocol/endpoint, interval/NAKlimit, i/o size */
-	musb_writeb(ep->regs, MGC_O_HDRC_RXTYPE, qh->type_reg);
-	musb_writeb(ep->regs, MGC_O_HDRC_RXINTERVAL, qh->intv_reg);
+	musb_writeb(ep->regs, MUSB_RXTYPE, qh->type_reg);
+	musb_writeb(ep->regs, MUSB_RXINTERVAL, qh->intv_reg);
 	/* NOTE: bulk combining rewrites high bits of maxpacket */
-	musb_writew(ep->regs, MGC_O_HDRC_RXMAXP, qh->maxpacket);
+	musb_writew(ep->regs, MUSB_RXMAXP, qh->maxpacket);
 
 	ep->rx_reinit = 0;
 }
@@ -676,11 +676,11 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		u16	wIntrTxE;
 		u16	wLoadCount;
 
-		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		wCsr = musb_readw(epio, MUSB_TXCSR);
 
 		/* disable interrupt in case we flush */
-		wIntrTxE = musb_readw(mbase, MGC_O_HDRC_INTRTXE);
-		musb_writew(mbase, MGC_O_HDRC_INTRTXE, wIntrTxE & ~(1 << epnum));
+		wIntrTxE = musb_readw(mbase, MUSB_INTRTXE);
+		musb_writew(mbase, MUSB_INTRTXE, wIntrTxE & ~(1 << epnum));
 
 		/* general endpoint setup */
 		if (epnum) {
@@ -707,49 +707,49 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 				csr |= MGC_M_TXCSR_CLRDATATOG;
 
 			/* twice in case of double packet buffering */
-			musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
+			musb_writew(epio, MUSB_TXCSR, csr);
 			/* REVISIT may need to clear FLUSHFIFO ... */
-			musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
-			wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+			musb_writew(epio, MUSB_TXCSR, csr);
+			wCsr = musb_readw(epio, MUSB_TXCSR);
 		} else {
 			/* endpoint 0: just flush */
-			musb_writew(epio, MGC_O_HDRC_CSR0,
+			musb_writew(epio, MUSB_CSR0,
 				wCsr | MGC_M_CSR0_FLUSHFIFO);
-			musb_writew(epio, MGC_O_HDRC_CSR0,
+			musb_writew(epio, MUSB_CSR0,
 				wCsr | MGC_M_CSR0_FLUSHFIFO);
 		}
 
 		/* target addr and (for multipoint) hub addr/port */
 		if (musb->is_multipoint) {
 			musb_writeb(mbase,
-				MGC_BUSCTL_OFFSET(epnum, MGC_O_HDRC_TXFUNCADDR),
+				MGC_BUSCTL_OFFSET(epnum, MUSB_TXFUNCADDR),
 				qh->addr_reg);
 			musb_writeb(mbase,
-				MGC_BUSCTL_OFFSET(epnum, MGC_O_HDRC_TXHUBADDR),
+				MGC_BUSCTL_OFFSET(epnum, MUSB_TXHUBADDR),
 				qh->h_addr_reg);
 			musb_writeb(mbase,
-				MGC_BUSCTL_OFFSET(epnum, MGC_O_HDRC_TXHUBPORT),
+				MGC_BUSCTL_OFFSET(epnum, MUSB_TXHUBPORT),
 				qh->h_port_reg);
 /* FIXME if !epnum, do the same for RX ... */
 		} else
-			musb_writeb(mbase, MGC_O_HDRC_FADDR, qh->addr_reg);
+			musb_writeb(mbase, MUSB_FADDR, qh->addr_reg);
 
 		/* protocol/endpoint/interval/NAKlimit */
 		if (epnum) {
-			musb_writeb(epio, MGC_O_HDRC_TXTYPE, qh->type_reg);
+			musb_writeb(epio, MUSB_TXTYPE, qh->type_reg);
 			if (can_bulk_split(musb, qh->type))
-				musb_writew(epio, MGC_O_HDRC_TXMAXP,
+				musb_writew(epio, MUSB_TXMAXP,
 					packet_sz
 					| ((hw_ep->max_packet_sz_tx /
 						packet_sz) - 1) << 11);
 			else
-				musb_writew(epio, MGC_O_HDRC_TXMAXP,
+				musb_writew(epio, MUSB_TXMAXP,
 					packet_sz);
-			musb_writeb(epio, MGC_O_HDRC_TXINTERVAL, qh->intv_reg);
+			musb_writeb(epio, MUSB_TXINTERVAL, qh->intv_reg);
 		} else {
-			musb_writeb(epio, MGC_O_HDRC_NAKLIMIT0, qh->intv_reg);
+			musb_writeb(epio, MUSB_NAKLIMIT0, qh->intv_reg);
 			if (musb->is_multipoint)
-				musb_writeb(epio, MGC_O_HDRC_TYPE0,
+				musb_writeb(epio, MUSB_TYPE0,
 						qh->type_reg);
 		}
 
@@ -763,12 +763,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		if (pDmaChannel) {
 
 			/* clear previous state */
-			wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+			wCsr = musb_readw(epio, MUSB_TXCSR);
 			wCsr &= ~(MGC_M_TXCSR_AUTOSET
 				| MGC_M_TXCSR_DMAMODE
 				| MGC_M_TXCSR_DMAENAB);
                         wCsr |= MGC_M_TXCSR_MODE;
-			musb_writew(epio, MGC_O_HDRC_TXCSR,
+			musb_writew(epio, MUSB_TXCSR,
 				wCsr | MGC_M_TXCSR_MODE);
 
 			qh->segsize = min(dwLength, pDmaChannel->max_len);
@@ -789,7 +789,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 					| MGC_M_TXCSR_DMAENAB
 					| MGC_M_TXCSR_DMAMODE);
 
-			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
+			musb_writew(epio, MUSB_TXCSR, wCsr);
 
 			bDmaOk = dma_controller->channel_program(
 					pDmaChannel, packet_sz,
@@ -816,12 +816,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			 * assume CPPI setup succeeds.
 			 * defer enabling dma.
 			 */
-			wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+			wCsr = musb_readw(epio, MUSB_TXCSR);
 			wCsr &= ~(MGC_M_TXCSR_AUTOSET
 					| MGC_M_TXCSR_DMAMODE
 					| MGC_M_TXCSR_DMAENAB);
 			wCsr |= MGC_M_TXCSR_MODE;
-			musb_writew(epio, MGC_O_HDRC_TXCSR,
+			musb_writew(epio, MUSB_TXCSR,
 				wCsr | MGC_M_TXCSR_MODE);
 
 			pDmaChannel->actual_len = 0L;
@@ -856,7 +856,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			/* PIO to load FIFO */
 			qh->segsize = wLoadCount;
 			musb_write_fifo(hw_ep, wLoadCount, pBuffer);
-			wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+			wCsr = musb_readw(epio, MUSB_TXCSR);
 			wCsr &= ~(MGC_M_TXCSR_DMAENAB
 				| MGC_M_TXCSR_DMAMODE
 				| MGC_M_TXCSR_AUTOSET);
@@ -864,11 +864,11 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			wCsr |= MGC_M_TXCSR_MODE;
 
 			if (epnum)
-				musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
+				musb_writew(epio, MUSB_TXCSR, wCsr);
 		}
 
 		/* re-enable interrupt */
-		musb_writew(mbase, MGC_O_HDRC_INTRTXE, wIntrTxE);
+		musb_writew(mbase, MUSB_INTRTXE, wIntrTxE);
 
 	/* IN/receive */
 	} else {
@@ -887,7 +887,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 				csr |= MGC_M_RXCSR_DISNYET;
 
 		} else {
-			csr = musb_readw(hw_ep->regs, MGC_O_HDRC_RXCSR);
+			csr = musb_readw(hw_ep->regs, MUSB_RXCSR);
 
 			if (csr & (MGC_M_RXCSR_RXPKTRDY
 					| MGC_M_RXCSR_DMAENAB
@@ -908,9 +908,9 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 				qh->segsize = dwLength;
 
 				/* AUTOREQ is in a DMA register */
-				musb_writew(hw_ep->regs, MGC_O_HDRC_RXCSR, csr);
+				musb_writew(hw_ep->regs, MUSB_RXCSR, csr);
 				csr = musb_readw(hw_ep->regs,
-						MGC_O_HDRC_RXCSR);
+						MUSB_RXCSR);
 
 				/* unless caller treats short rx transfers as
 				 * errors, we dare not queue multiple transfers.
@@ -932,8 +932,8 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 		csr |= MGC_M_RXCSR_H_REQPKT;
 		DBG(7, "RXCSR%d := %04x\n", epnum, csr);
-		musb_writew(hw_ep->regs, MGC_O_HDRC_RXCSR, csr);
-		csr = musb_readw(hw_ep->regs, MGC_O_HDRC_RXCSR);
+		musb_writew(hw_ep->regs, MUSB_RXCSR, csr);
+		csr = musb_readw(hw_ep->regs, MUSB_RXCSR);
 	}
 }
 
@@ -1034,9 +1034,9 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	pUrb = next_urb(qh);
 
 	musb_ep_select(mbase, 0);
-	csr = musb_readw(epio, MGC_O_HDRC_CSR0);
+	csr = musb_readw(epio, MUSB_CSR0);
 	len = (csr & MGC_M_CSR0_RXPKTRDY)
-			? musb_readb(epio, MGC_O_HDRC_COUNT0)
+			? musb_readb(epio, MUSB_COUNT0)
 			: 0;
 
 	DBG(4, "<== csr0 %04x, qh %p, count %d, urb %p, stage %d\n",
@@ -1067,7 +1067,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		 * if (qh->ring.next != &musb->control), then
 		 * we have a candidate... NAKing is *NOT* an error
 		 */
-		musb_writew(epio, MGC_O_HDRC_CSR0, 0);
+		musb_writew(epio, MUSB_CSR0, 0);
 		retval = IRQ_HANDLED;
 	}
 
@@ -1081,21 +1081,21 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		/* use the proper sequence to abort the transfer */
 		if (csr & MGC_M_CSR0_H_REQPKT) {
 			csr &= ~MGC_M_CSR0_H_REQPKT;
-			musb_writew(epio, MGC_O_HDRC_CSR0, csr);
+			musb_writew(epio, MUSB_CSR0, csr);
 			csr &= ~MGC_M_CSR0_H_NAKTIMEOUT;
-			musb_writew(epio, MGC_O_HDRC_CSR0, csr);
+			musb_writew(epio, MUSB_CSR0, csr);
 		} else {
 			csr |= MGC_M_CSR0_FLUSHFIFO;
-			musb_writew(epio, MGC_O_HDRC_CSR0, csr);
-			musb_writew(epio, MGC_O_HDRC_CSR0, csr);
+			musb_writew(epio, MUSB_CSR0, csr);
+			musb_writew(epio, MUSB_CSR0, csr);
 			csr &= ~MGC_M_CSR0_H_NAKTIMEOUT;
-			musb_writew(epio, MGC_O_HDRC_CSR0, csr);
+			musb_writew(epio, MUSB_CSR0, csr);
 		}
 
-		musb_writeb(epio, MGC_O_HDRC_NAKLIMIT0, 0);
+		musb_writeb(epio, MUSB_NAKLIMIT0, 0);
 
 		/* clear it */
-		musb_writew(epio, MGC_O_HDRC_CSR0, 0);
+		musb_writew(epio, MUSB_CSR0, 0);
 	}
 
 	if (unlikely(!pUrb)) {
@@ -1103,9 +1103,9 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		 * SHOULD NEVER HAPPEN! */
 		ERR("no URB for end 0\n");
 
-		musb_writew(epio, MGC_O_HDRC_CSR0, MGC_M_CSR0_FLUSHFIFO);
-		musb_writew(epio, MGC_O_HDRC_CSR0, MGC_M_CSR0_FLUSHFIFO);
-		musb_writew(epio, MGC_O_HDRC_CSR0, 0);
+		musb_writew(epio, MUSB_CSR0, MGC_M_CSR0_FLUSHFIFO);
+		musb_writew(epio, MUSB_CSR0, MGC_M_CSR0_FLUSHFIFO);
+		musb_writew(epio, MUSB_CSR0, 0);
 
 		goto done;
 	}
@@ -1132,7 +1132,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 			DBG(5, "ep0 STATUS, csr %04x\n", csr);
 
 		}
-		musb_writew(epio, MGC_O_HDRC_CSR0, csr);
+		musb_writew(epio, MUSB_CSR0, csr);
 		retval = IRQ_HANDLED;
 	} else
 		musb->ep0_stage = MGC_END0_IDLE;
@@ -1180,7 +1180,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	pUrb = next_urb(qh);
 
 	musb_ep_select(mbase, epnum);
-	wTxCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
+	wTxCsrVal = musb_readw(epio, MUSB_TXCSR);
 
 	/* with CPPI, DMA sometimes triggers "extra" irqs */
 	if (!pUrb) {
@@ -1218,7 +1218,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		 * we have a candidate... NAKing is *NOT* an error
 		 */
 		musb_ep_select(mbase, epnum);
-		musb_writew(epio, MGC_O_HDRC_CSR0,
+		musb_writew(epio, MUSB_CSR0,
 				MGC_M_TXCSR_H_WZC_BITS
 				| MGC_M_TXCSR_TXPKTRDY);
 		goto finish;
@@ -1242,10 +1242,10 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 				);
 
 		musb_ep_select(mbase, epnum);
-		musb_writew(epio, MGC_O_HDRC_TXCSR, wTxCsrVal);
+		musb_writew(epio, MUSB_TXCSR, wTxCsrVal);
 		/* REVISIT may need to clear FLUSHFIFO ... */
-		musb_writew(epio, MGC_O_HDRC_TXCSR, wTxCsrVal);
-		musb_writeb(epio, MGC_O_HDRC_TXINTERVAL, 0);
+		musb_writew(epio, MUSB_TXCSR, wTxCsrVal);
+		musb_writeb(epio, MUSB_TXINTERVAL, 0);
 
 		bDone = TRUE;
 	}
@@ -1324,7 +1324,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		qh->segsize = wLength;
 
 		musb_ep_select(mbase, epnum);
-		musb_writew(epio, MGC_O_HDRC_TXCSR,
+		musb_writew(epio, MUSB_TXCSR,
 				MGC_M_TXCSR_H_WZC_BITS | MGC_M_TXCSR_TXPKTRDY);
 	} else
 		DBG(1, "not complete, but dma enabled?\n");
@@ -1399,7 +1399,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	status = 0;
 	xfer_len = 0;
 
-	wVal = wRxCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
+	wVal = wRxCsrVal = musb_readw(epio, MUSB_RXCSR);
 
 	if (unlikely(!pUrb)) {
 		/* REVISIT -- THIS SHOULD NEVER HAPPEN ... but, at least
@@ -1407,7 +1407,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		 * with fifo full.  (Only with DMA??)
 		 */
 		DBG(3, "BOGUS RX%d ready, csr %04x, count %d\n", epnum, wVal,
-			musb_readw(epio, MGC_O_HDRC_RXCOUNT));
+			musb_readw(epio, MUSB_RXCOUNT));
 		musb_h_flush_rxfifo(hw_ep, MGC_M_RXCSR_CLRDATATOG);
 		return;
 	}
@@ -1430,7 +1430,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		DBG(3, "end %d RX proto error\n", epnum);
 
 		status = -EPROTO;
-		musb_writeb(epio, MGC_O_HDRC_RXINTERVAL, 0);
+		musb_writeb(epio, MUSB_RXINTERVAL, 0);
 
 	} else if (wRxCsrVal & MGC_M_RXCSR_DATAERROR) {
 
@@ -1444,7 +1444,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			 */
 			DBG(6, "RX end %d NAK timeout\n", epnum);
 			musb_ep_select(mbase, epnum);
-			musb_writew(epio, MGC_O_HDRC_RXCSR,
+			musb_writew(epio, MUSB_RXCSR,
 					MGC_M_RXCSR_H_WZC_BITS
 					| MGC_M_RXCSR_H_REQPKT);
 
@@ -1465,7 +1465,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			xfer_len = dma->actual_len;
 		}
 		musb_h_flush_rxfifo(hw_ep, 0);
-		musb_writeb(epio, MGC_O_HDRC_RXINTERVAL, 0);
+		musb_writeb(epio, MUSB_RXINTERVAL, 0);
 		bDone = TRUE;
 		goto finish;
 	}
@@ -1502,7 +1502,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		wRxCsrVal &= ~MGC_M_RXCSR_H_REQPKT;
 
 		musb_ep_select(mbase, epnum);
-		musb_writew(epio, MGC_O_HDRC_RXCSR,
+		musb_writew(epio, MUSB_RXCSR,
 				MGC_M_RXCSR_H_WZC_BITS | wRxCsrVal);
 	}
 #endif
@@ -1513,7 +1513,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			| MGC_M_RXCSR_H_AUTOREQ
 			| MGC_M_RXCSR_AUTOCLEAR
 			| MGC_M_RXCSR_RXPKTRDY);
-		musb_writew(hw_ep->regs, MGC_O_HDRC_RXCSR, wVal);
+		musb_writew(hw_ep->regs, MUSB_RXCSR, wVal);
 
 #ifdef CONFIG_USB_INVENTRA_DMA
 		/* bDone if pUrb buffer is full or short packet is recd */
@@ -1524,14 +1524,14 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		/* send IN token for next packet, without AUTOREQ */
 		if (!bDone) {
 			wVal |= MGC_M_RXCSR_H_REQPKT;
-			musb_writew(epio, MGC_O_HDRC_RXCSR,
+			musb_writew(epio, MUSB_RXCSR,
 				MGC_M_RXCSR_H_WZC_BITS | wVal);
 		}
 
 		DBG(4, "ep %d dma %s, rxcsr %04x, rxcount %d\n", epnum,
 			bDone ? "off" : "reset",
-			musb_readw(epio, MGC_O_HDRC_RXCSR),
-			musb_readw(epio, MGC_O_HDRC_RXCOUNT));
+			musb_readw(epio, MUSB_RXCSR),
+			musb_readw(epio, MUSB_RXCOUNT));
 #else
 		bDone = TRUE;
 #endif
@@ -1547,7 +1547,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			/* do the proper sequence to abort the transfer */
 			musb_ep_select(mbase, epnum);
 			wVal &= ~MGC_M_RXCSR_H_REQPKT;
-			musb_writew(epio, MGC_O_HDRC_RXCSR, wVal);
+			musb_writew(epio, MUSB_RXCSR, wVal);
 			goto finish;
 		}
 
@@ -1558,7 +1558,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			u16			wRxCount;
 			int			status;
 
-			wRxCount = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
+			wRxCount = musb_readw(epio, MUSB_RXCOUNT);
 
 			DBG(2, "RX%d count %d, buffer 0x%x len %d/%d\n",
 					epnum, wRxCount,
@@ -1599,7 +1599,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
  *	wait for an interrupt when the pkt is recd. Well, you won't get any!
  */
 
-			wVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
+			wVal = musb_readw(epio, MUSB_RXCSR);
 			wVal &= ~MGC_M_RXCSR_H_REQPKT;
 
 			if (dma->desired_mode == 0)
@@ -1608,7 +1608,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 				wVal |= MGC_M_RXCSR_H_AUTOREQ;
 			wVal |= MGC_M_RXCSR_AUTOCLEAR | MGC_M_RXCSR_DMAENAB;
 
-			musb_writew(epio, MGC_O_HDRC_RXCSR,
+			musb_writew(epio, MUSB_RXCSR,
 				MGC_M_RXCSR_H_WZC_BITS | wVal);
 
 			/* REVISIT if when actual_length != 0,
@@ -1935,7 +1935,7 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 		 */
 	} else {
 		musb_h_tx_flush_fifo(ep);
-		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		csr = musb_readw(epio, MUSB_TXCSR);
 		csr &= ~( MGC_M_TXCSR_AUTOSET
 			| MGC_M_TXCSR_DMAENAB
 			| MGC_M_TXCSR_H_RXSTALL
@@ -1943,11 +1943,11 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 			| MGC_M_TXCSR_H_ERROR
 			| MGC_M_TXCSR_TXPKTRDY
 			);
-		musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
+		musb_writew(epio, MUSB_TXCSR, csr);
 		/* REVISIT may need to clear FLUSHFIFO ... */
-		musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
+		musb_writew(epio, MUSB_TXCSR, csr);
 		/* flush cpu writebuffer */
-		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		csr = musb_readw(epio, MUSB_TXCSR);
 	}
 	if (status == 0)
 		musb_advance_schedule(ep->musb, urb, ep, is_in);
@@ -2107,7 +2107,7 @@ static int musb_h_get_frame_number(struct usb_hcd *hcd)
 {
 	struct musb	*musb = hcd_to_musb(hcd);
 
-	return musb_readw(musb->mregs, MGC_O_HDRC_FRAME);
+	return musb_readw(musb->mregs, MUSB_FRAME);
 }
 
 static int musb_h_start(struct usb_hcd *hcd)
diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index b141a73..ddb478f 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -157,11 +157,11 @@ static int dump_ep(struct musb_ep *ep, char *buffer, unsigned max)
 				mode, ep->dma ? " dma" : "",
 				musb_readw(regs,
 					(ep->is_in || !ep->current_epnum)
-						? MGC_O_HDRC_TXCSR
-						: MGC_O_HDRC_RXCSR),
+						? MUSB_TXCSR
+						: MUSB_RXCSR),
 				musb_readw(regs, ep->is_in
-						? MGC_O_HDRC_TXMAXP
-						: MGC_O_HDRC_RXMAXP)
+						? MUSB_TXMAXP
+						: MUSB_RXMAXP)
 				);
 		if (code <= 0)
 			break;
@@ -279,20 +279,20 @@ dump_end_info(struct musb *musb, u8 epnum, char *aBuffer, unsigned max)
 					epnum,
 					hw_ep->rx_double_buffered
 						? "2buf" : "1buf",
-					musb_readw(regs, MGC_O_HDRC_RXCSR),
-					musb_readb(regs, MGC_O_HDRC_RXINTERVAL),
-					musb_readw(regs, MGC_O_HDRC_RXMAXP),
-					musb_readb(regs, MGC_O_HDRC_RXTYPE),
+					musb_readw(regs, MUSB_RXCSR),
+					musb_readb(regs, MUSB_RXINTERVAL),
+					musb_readw(regs, MUSB_RXMAXP),
+					musb_readb(regs, MUSB_RXTYPE),
 					/* FIXME:  assumes multipoint */
 					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(epnum,
-						MGC_O_HDRC_RXFUNCADDR)),
+						MUSB_RXFUNCADDR)),
 					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(epnum,
-						MGC_O_HDRC_RXHUBADDR)),
+						MUSB_RXHUBADDR)),
 					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(epnum,
-						MGC_O_HDRC_RXHUBPORT))
+						MUSB_RXHUBPORT))
 					);
 				if (code <= 0)
 					break;
@@ -367,20 +367,20 @@ dump_end_info(struct musb *musb, u8 epnum, char *aBuffer, unsigned max)
 					epnum,
 					hw_ep->tx_double_buffered
 						? "2buf" : "1buf",
-					musb_readw(regs, MGC_O_HDRC_TXCSR),
-					musb_readb(regs, MGC_O_HDRC_TXINTERVAL),
-					musb_readw(regs, MGC_O_HDRC_TXMAXP),
-					musb_readb(regs, MGC_O_HDRC_TXTYPE),
+					musb_readw(regs, MUSB_TXCSR),
+					musb_readb(regs, MUSB_TXINTERVAL),
+					musb_readw(regs, MUSB_TXMAXP),
+					musb_readb(regs, MUSB_TXTYPE),
 					/* FIXME:  assumes multipoint */
 					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(epnum,
-						MGC_O_HDRC_TXFUNCADDR)),
+						MUSB_TXFUNCADDR)),
 					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(epnum,
-						MGC_O_HDRC_TXHUBADDR)),
+						MUSB_TXHUBADDR)),
 					musb_readb(musb->mregs,
 						MGC_BUSCTL_OFFSET(epnum,
-						MGC_O_HDRC_TXHUBPORT))
+						MUSB_TXHUBPORT))
 					);
 				if (code <= 0)
 					break;
@@ -491,8 +491,8 @@ static int dump_header_stats(struct musb *musb, char *buffer)
 	count = sprintf(buffer, "Status: %sHDRC, Mode=%s "
 				"(Power=%02x, DevCtl=%02x)\n",
 			(musb->is_multipoint ? "M" : ""), MUSB_MODE(musb),
-			musb_readb(mbase, MGC_O_HDRC_POWER),
-			musb_readb(mbase, MGC_O_HDRC_DEVCTL));
+			musb_readb(mbase, MUSB_POWER),
+			musb_readb(mbase, MUSB_DEVCTL));
 	if (count <= 0)
 		return 0;
 	buffer += count;
@@ -536,7 +536,7 @@ static int dump_header_stats(struct musb *musb, char *buffer)
 
 #ifdef	CONFIG_USB_GADGET_MUSB_HDRC
 	code = sprintf(buffer, "Peripheral address: %02x\n",
-			musb_readb(musb, MGC_O_HDRC_FADDR));
+			musb_readb(musb, MUSB_FADDR));
 	if (code <= 0)
 		goto done;
 	buffer += code;
@@ -663,47 +663,47 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 	switch (cmd) {
 	case 'C':
 		if (mbase) {
-			bReg = musb_readb(mbase, MGC_O_HDRC_POWER)
+			bReg = musb_readb(mbase, MUSB_POWER)
 					| MGC_M_POWER_SOFTCONN;
-			musb_writeb(mbase, MGC_O_HDRC_POWER, bReg);
+			musb_writeb(mbase, MUSB_POWER, bReg);
 		}
 		break;
 
 	case 'c':
 		if (mbase) {
-			bReg = musb_readb(mbase, MGC_O_HDRC_POWER)
+			bReg = musb_readb(mbase, MUSB_POWER)
 					& ~MGC_M_POWER_SOFTCONN;
-			musb_writeb(mbase, MGC_O_HDRC_POWER, bReg);
+			musb_writeb(mbase, MUSB_POWER, bReg);
 		}
 		break;
 
 	case 'I':
 		if (mbase) {
-			bReg = musb_readb(mbase, MGC_O_HDRC_POWER)
+			bReg = musb_readb(mbase, MUSB_POWER)
 					| MGC_M_POWER_HSENAB;
-			musb_writeb(mbase, MGC_O_HDRC_POWER, bReg);
+			musb_writeb(mbase, MUSB_POWER, bReg);
 		}
 		break;
 
 	case 'i':
 		if (mbase) {
-			bReg = musb_readb(mbase, MGC_O_HDRC_POWER)
+			bReg = musb_readb(mbase, MUSB_POWER)
 					& ~MGC_M_POWER_HSENAB;
-			musb_writeb(mbase, MGC_O_HDRC_POWER, bReg);
+			musb_writeb(mbase, MUSB_POWER, bReg);
 		}
 		break;
 
 	case 'F':
-		bReg = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
+		bReg = musb_readb(mbase, MUSB_DEVCTL);
 		bReg |= MGC_M_DEVCTL_SESSION;
-		musb_writeb(mbase, MGC_O_HDRC_DEVCTL, bReg);
+		musb_writeb(mbase, MUSB_DEVCTL, bReg);
 		break;
 
 	case 'H':
 		if (mbase) {
-			bReg = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
+			bReg = musb_readb(mbase, MUSB_DEVCTL);
 			bReg |= MGC_M_DEVCTL_HR;
-			musb_writeb(mbase, MGC_O_HDRC_DEVCTL, bReg);
+			musb_writeb(mbase, MUSB_DEVCTL, bReg);
 			//MUSB_HST_MODE( ((struct musb*)data) );
 			//WARN("Host Mode\n");
 		}
@@ -711,16 +711,16 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 
 	case 'h':
 		if (mbase) {
-			bReg = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
+			bReg = musb_readb(mbase, MUSB_DEVCTL);
 			bReg &= ~MGC_M_DEVCTL_HR;
-			musb_writeb(mbase, MGC_O_HDRC_DEVCTL, bReg);
+			musb_writeb(mbase, MUSB_DEVCTL, bReg);
 		}
 		break;
 
 	case 'T':
 		if (mbase) {
 			musb_load_testpacket(musb);
-			musb_writeb(mbase, MGC_O_HDRC_TESTMODE,
+			musb_writeb(mbase, MUSB_TESTMODE,
 					MGC_M_TEST_PACKET);
 		}
 		break;
diff --git a/drivers/usb/musb/musbdefs.h b/drivers/usb/musb/musbdefs.h
index 79e8da2..d4e8c3e 100644
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -219,7 +219,7 @@ enum musb_g_ep0_state {
 /* TUSB mapping: "flat" plus ep0 special cases */
 #if	defined(CONFIG_USB_TUSB6010)
 #define musb_ep_select(_mbase, _epnum) \
-	musb_writeb((_mbase), MGC_O_HDRC_INDEX, (_epnum))
+	musb_writeb((_mbase), MUSB_INDEX, (_epnum))
 #define	MGC_END_OFFSET			MGC_TUSB_OFFSET
 
 /* "flat" mapping: each endpoint has its own i/o address */
@@ -230,7 +230,7 @@ enum musb_g_ep0_state {
 /* "indexed" mapping: INDEX register controls register bank select */
 #else
 #define musb_ep_select(_mbase, _epnum) \
-	musb_writeb((_mbase), MGC_O_HDRC_INDEX, (_epnum))
+	musb_writeb((_mbase), MUSB_INDEX, (_epnum))
 #define	MGC_END_OFFSET			MGC_INDEXED_OFFSET
 #endif
 
@@ -242,7 +242,7 @@ enum musb_g_ep0_state {
 	{ (_musb)->is_host=FALSE; }
 
 #define test_devctl_hst_mode(_x) \
-	(musb_readb((_x)->mregs, MGC_O_HDRC_DEVCTL)&MGC_M_DEVCTL_HM)
+	(musb_readb((_x)->mregs, MUSB_DEVCTL)&MGC_M_DEVCTL_HM)
 
 #define MUSB_MODE(musb) ((musb)->is_host ? "Host" : "Peripheral")
 
diff --git a/drivers/usb/musb/musbhdrc.h b/drivers/usb/musb/musbhdrc.h
index 553769b..7762663 100644
--- a/drivers/usb/musb/musbhdrc.h
+++ b/drivers/usb/musb/musbhdrc.h
@@ -48,18 +48,18 @@
 
 /* Common USB registers */
 
-#define MGC_O_HDRC_FADDR	0x00	/* 8-bit */
-#define MGC_O_HDRC_POWER	0x01	/* 8-bit */
-
-#define MGC_O_HDRC_INTRTX	0x02	/* 16-bit */
-#define MGC_O_HDRC_INTRRX       0x04
-#define MGC_O_HDRC_INTRTXE      0x06
-#define MGC_O_HDRC_INTRRXE      0x08
-#define MGC_O_HDRC_INTRUSB      0x0A	/* 8 bit */
-#define MGC_O_HDRC_INTRUSBE     0x0B	/* 8 bit */
-#define MGC_O_HDRC_FRAME        0x0C
-#define MGC_O_HDRC_INDEX        0x0E	/* 8 bit */
-#define MGC_O_HDRC_TESTMODE     0x0F	/* 8 bit */
+#define MUSB_FADDR	0x00	/* 8-bit */
+#define MUSB_POWER	0x01	/* 8-bit */
+
+#define MUSB_INTRTX	0x02	/* 16-bit */
+#define MUSB_INTRRX       0x04
+#define MUSB_INTRTXE      0x06
+#define MUSB_INTRRXE      0x08
+#define MUSB_INTRUSB      0x0A	/* 8 bit */
+#define MUSB_INTRUSBE     0x0B	/* 8 bit */
+#define MUSB_FRAME        0x0C
+#define MUSB_INDEX        0x0E	/* 8 bit */
+#define MUSB_TESTMODE     0x0F	/* 8 bit */
 
 /* Get offset for a given FIFO from musb->mregs */
 #ifdef	CONFIG_USB_TUSB6010
@@ -70,41 +70,41 @@
 
 /* Additional Control Registers */
 
-#define MGC_O_HDRC_DEVCTL	0x60	/* 8 bit */
+#define MUSB_DEVCTL	0x60	/* 8 bit */
 
 /* These are always controlled through the INDEX register */
-#define MGC_O_HDRC_TXFIFOSZ	0x62	/* 8-bit (see masks) */
-#define MGC_O_HDRC_RXFIFOSZ	0x63	/* 8-bit (see masks) */
-#define MGC_O_HDRC_TXFIFOADD	0x64	/* 16-bit offset shifted right 3 */
-#define MGC_O_HDRC_RXFIFOADD	0x66	/* 16-bit offset shifted right 3 */
+#define MUSB_TXFIFOSZ	0x62	/* 8-bit (see masks) */
+#define MUSB_RXFIFOSZ	0x63	/* 8-bit (see masks) */
+#define MUSB_TXFIFOADD	0x64	/* 16-bit offset shifted right 3 */
+#define MUSB_RXFIFOADD	0x66	/* 16-bit offset shifted right 3 */
 
 // vctrl/vstatus:  optional vendor utmi+phy register at 0x68
-#define MGC_O_HDRC_HWVERS	0x6C	/* 8 bit */
+#define MUSB_HWVERS	0x6C	/* 8 bit */
 
-#define MGC_O_HDRC_EPINFO	0x78	/* 8 bit */
-#define MGC_O_HDRC_RAMINFO	0x79	/* 8 bit */
-#define MGC_O_HDRC_LINKINFO	0x7a	/* 8 bit */
-#define MGC_O_HDRC_VPLEN	0x7b	/* 8 bit */
-#define MGC_O_HDRC_HS_EOF1	0x7c	/* 8 bit */
-#define MGC_O_HDRC_FS_EOF1	0x7d	/* 8 bit */
-#define MGC_O_HDRC_LS_EOF1	0x7e	/* 8 bit */
+#define MUSB_EPINFO	0x78	/* 8 bit */
+#define MUSB_RAMINFO	0x79	/* 8 bit */
+#define MUSB_LINKINFO	0x7a	/* 8 bit */
+#define MUSB_VPLEN	0x7b	/* 8 bit */
+#define MUSB_HS_EOF1	0x7c	/* 8 bit */
+#define MUSB_FS_EOF1	0x7d	/* 8 bit */
+#define MUSB_LS_EOF1	0x7e	/* 8 bit */
 
 /* offsets to endpoint registers */
-#define MGC_O_HDRC_TXMAXP	0x00
-#define MGC_O_HDRC_TXCSR	0x02
-#define MGC_O_HDRC_CSR0		MGC_O_HDRC_TXCSR	/* re-used for EP0 */
-#define MGC_O_HDRC_RXMAXP	0x04
-#define MGC_O_HDRC_RXCSR	0x06
-#define MGC_O_HDRC_RXCOUNT	0x08
-#define MGC_O_HDRC_COUNT0	MGC_O_HDRC_RXCOUNT	/* re-used for EP0 */
-#define MGC_O_HDRC_TXTYPE	0x0A
-#define MGC_O_HDRC_TYPE0	MGC_O_HDRC_TXTYPE	/* re-used for EP0 */
-#define MGC_O_HDRC_TXINTERVAL	0x0B
-#define MGC_O_HDRC_NAKLIMIT0	MGC_O_HDRC_TXINTERVAL	/* re-used for EP0 */
-#define MGC_O_HDRC_RXTYPE	0x0C
-#define MGC_O_HDRC_RXINTERVAL	0x0D
-#define MGC_O_HDRC_FIFOSIZE	0x0F
-#define MGC_O_HDRC_CONFIGDATA	MGC_O_HDRC_FIFOSIZE	/* re-used for EP0 */
+#define MUSB_TXMAXP	0x00
+#define MUSB_TXCSR	0x02
+#define MUSB_CSR0		MUSB_TXCSR	/* re-used for EP0 */
+#define MUSB_RXMAXP	0x04
+#define MUSB_RXCSR	0x06
+#define MUSB_RXCOUNT	0x08
+#define MUSB_COUNT0	MUSB_RXCOUNT	/* re-used for EP0 */
+#define MUSB_TXTYPE	0x0A
+#define MUSB_TYPE0	MUSB_TXTYPE	/* re-used for EP0 */
+#define MUSB_TXINTERVAL	0x0B
+#define MUSB_NAKLIMIT0	MUSB_TXINTERVAL	/* re-used for EP0 */
+#define MUSB_RXTYPE	0x0C
+#define MUSB_RXINTERVAL	0x0D
+#define MUSB_FIFOSIZE	0x0F
+#define MUSB_CONFIGDATA	MUSB_FIFOSIZE	/* re-used for EP0 */
 
 /* offsets to endpoint registers in indexed model (using INDEX register) */
 #define MGC_INDEXED_OFFSET(_epnum, _bOffset)	\
@@ -122,13 +122,13 @@
 #endif
 
 /* "bus control"/target registers, for host side multipoint (external hubs) */
-#define MGC_O_HDRC_TXFUNCADDR	0x00
-#define MGC_O_HDRC_TXHUBADDR	0x02
-#define MGC_O_HDRC_TXHUBPORT	0x03
+#define MUSB_TXFUNCADDR	0x00
+#define MUSB_TXHUBADDR	0x02
+#define MUSB_TXHUBPORT	0x03
 
-#define MGC_O_HDRC_RXFUNCADDR	0x04
-#define MGC_O_HDRC_RXHUBADDR	0x06
-#define MGC_O_HDRC_RXHUBPORT	0x07
+#define MUSB_RXFUNCADDR	0x04
+#define MUSB_RXHUBADDR	0x06
+#define MUSB_RXHUBPORT	0x07
 
 #define MGC_BUSCTL_OFFSET(_epnum, _bOffset) \
 	(0x80 + (8*(_epnum)) + (_bOffset))
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 1691984..a1365c0 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -263,22 +263,22 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 		if (pImplChannel->bTransmit) {
 
 			csr = musb_readw(mbase,
-				MGC_END_OFFSET(pImplChannel->epnum,MGC_O_HDRC_TXCSR));
+				MGC_END_OFFSET(pImplChannel->epnum,MUSB_TXCSR));
 			csr &= ~(MGC_M_TXCSR_AUTOSET |
 				 MGC_M_TXCSR_DMAENAB |
 				 MGC_M_TXCSR_DMAMODE);
 			musb_writew(mbase,
-					MGC_END_OFFSET(pImplChannel->epnum,MGC_O_HDRC_TXCSR),
+					MGC_END_OFFSET(pImplChannel->epnum,MUSB_TXCSR),
 					csr);
 		}
 		else {
 			csr = musb_readw(mbase,
-				MGC_END_OFFSET(pImplChannel->epnum,MGC_O_HDRC_RXCSR));
+				MGC_END_OFFSET(pImplChannel->epnum,MUSB_RXCSR));
 			csr &= ~(MGC_M_RXCSR_AUTOCLEAR |
 				 MGC_M_RXCSR_DMAENAB |
 				 MGC_M_RXCSR_DMAMODE);
 			musb_writew(mbase,
-					MGC_END_OFFSET(pImplChannel->epnum,MGC_O_HDRC_RXCSR),
+					MGC_END_OFFSET(pImplChannel->epnum,MUSB_RXCSR),
 					csr);
 		}
 
@@ -341,7 +341,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 					"=> reconfig 0": "=> complete");
 
 				u8 devctl = musb_readb(mbase,
-						MGC_O_HDRC_DEVCTL);
+						MUSB_DEVCTL);
 
 				pChannel->status = MGC_DMA_STATUS_FREE;
 
@@ -356,7 +356,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 					musb_ep_select(mbase,
 						pImplChannel->epnum);
 					musb_writew(mbase,
-						MGC_END_OFFSET(pImplChannel->epnum,MGC_O_HDRC_TXCSR),
+						MGC_END_OFFSET(pImplChannel->epnum,MUSB_TXCSR),
 						MGC_M_TXCSR_TXPKTRDY);
 				} else
 					musb_dma_completion(
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 65f2c22..e62bb76 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -59,7 +59,7 @@ static void omap_set_vbus(struct musb *musb, int is_on)
 	 * that must be ignored.
 	 */
 
-	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
+	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 
 	if (is_on) {
 		musb->is_active = 1;
@@ -81,12 +81,12 @@ static void omap_set_vbus(struct musb *musb, int is_on)
 
 		MUSB_DEV_MODE(musb);
 	}
-	musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, devctl);
+	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
 
 	DBG(1, "VBUS %s, devctl %02x "
 		/* otg %3x conf %08x prcm %08x */ "\n",
 		otg_state_string(musb),
-		musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL));
+		musb_readb(musb->mregs, MUSB_DEVCTL));
 }
 static int omap_set_power(struct otg_transceiver *x, unsigned mA)
 {
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index b87c587..e2e1ab2 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -276,7 +276,7 @@ void musb_load_testpacket(struct musb *musb)
 	musb_ep_select(musb->mregs, 0);
 	musb_write_fifo(musb->control_ep,
 			sizeof(musb_test_packet), musb_test_packet);
-	musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_TXPKTRDY);
+	musb_writew(regs, MUSB_CSR0, MGC_M_CSR0_TXPKTRDY);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -331,9 +331,9 @@ void musb_hnp_stop(struct musb *musb)
 		DBG(1, "HNP: Disabling HR\n");
 		hcd->self.is_b_host = 0;
 		musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
-		reg = musb_readb(mbase, MGC_O_HDRC_POWER);
+		reg = musb_readb(mbase, MUSB_POWER);
 		reg |= MGC_M_POWER_SUSPENDM;
-		musb_writeb(mbase, MGC_O_HDRC_POWER, reg);
+		musb_writeb(mbase, MUSB_POWER, reg);
 		/* REVISIT: Start SESSION_REQUEST here? */
 		break;
 	default:
@@ -395,7 +395,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 				}
 
 				power &= ~MGC_M_POWER_SUSPENDM;
-				musb_writeb(mbase, MGC_O_HDRC_POWER,
+				musb_writeb(mbase, MUSB_POWER,
 						power | MGC_M_POWER_RESUME);
 
 				musb->port1_status |=
@@ -466,7 +466,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 		 *  - ... to A_WAIT_BCON.
 		 * a_wait_vrise_tmout triggers VBUS_ERROR transitions
 		 */
-		musb_writeb(mbase, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
+		musb_writeb(mbase, MUSB_DEVCTL, MGC_M_DEVCTL_SESSION);
 		musb->ep0_stage = MGC_END0_START;
 		musb->xceiv.state = OTG_STATE_A_IDLE;
 		MUSB_HST_MODE(musb);
@@ -508,7 +508,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 				musb->vbuserr_retry--;
 				ignore = 1;
 				devctl |= MGC_M_DEVCTL_SESSION;
-				musb_writeb(mbase, MGC_O_HDRC_DEVCTL, devctl);
+				musb_writeb(mbase, MUSB_DEVCTL, devctl);
 			} else {
 				musb->port1_status |=
 					  (1 << USB_PORT_FEAT_OVER_CURRENT)
@@ -558,9 +558,9 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 			// REVISIT HNP; just force disconnect
 		}
 		musb->delay_port_power_off = FALSE;
-		musb_writew(mbase, MGC_O_HDRC_INTRTXE, musb->wEndMask);
-		musb_writew(mbase, MGC_O_HDRC_INTRRXE, musb->wEndMask & 0xfffe);
-		musb_writeb(mbase, MGC_O_HDRC_INTRUSBE, 0xf7);
+		musb_writew(mbase, MUSB_INTRTXE, musb->wEndMask);
+		musb_writew(mbase, MUSB_INTRRXE, musb->wEndMask & 0xfffe);
+		musb_writeb(mbase, MUSB_INTRUSBE, 0xf7);
 #endif
 		musb->port1_status &= ~(USB_PORT_STAT_LOW_SPEED
 					|USB_PORT_STAT_HIGH_SPEED
@@ -616,7 +616,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 				DBG(1, "BABBLE devctl: %02x\n", devctl);
 			else {
 				ERR("Stopping host session because of babble\n");
-				musb_writeb(mbase, MGC_O_HDRC_DEVCTL, 0);
+				musb_writeb(mbase, MUSB_DEVCTL, 0);
 			}
 		} else {
 			DBG(1, "BUS RESET\n");
@@ -669,7 +669,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
 		handled = IRQ_HANDLED;
 
 		/* start any periodic Tx transfers waiting for current frame */
-		wFrame = musb_readw(mbase, MGC_O_HDRC_FRAME);
+		wFrame = musb_readw(mbase, MUSB_FRAME);
 		ep = musb->endpoints;
 		for (epnum = 1; (epnum < musb->nr_endpoints)
 					&& (musb->wEndMask >= (1 << epnum));
@@ -787,19 +787,19 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
 void musb_start(struct musb *musb)
 {
 	void __iomem	*regs = musb->mregs;
-	u8		devctl = musb_readb(regs, MGC_O_HDRC_DEVCTL);
+	u8		devctl = musb_readb(regs, MUSB_DEVCTL);
 
 	DBG(2, "<== devctl %02x\n", devctl);
 
 	/*  Set INT enable registers, enable interrupts */
-	musb_writew(regs, MGC_O_HDRC_INTRTXE, musb->wEndMask);
-	musb_writew(regs, MGC_O_HDRC_INTRRXE, musb->wEndMask & 0xfffe);
-	musb_writeb(regs, MGC_O_HDRC_INTRUSBE, 0xf7);
+	musb_writew(regs, MUSB_INTRTXE, musb->wEndMask);
+	musb_writew(regs, MUSB_INTRRXE, musb->wEndMask & 0xfffe);
+	musb_writeb(regs, MUSB_INTRUSBE, 0xf7);
 
-	musb_writeb(regs, MGC_O_HDRC_TESTMODE, 0);
+	musb_writeb(regs, MUSB_TESTMODE, 0);
 
 	/* put into basic highspeed mode and start session */
-	musb_writeb(regs, MGC_O_HDRC_POWER, MGC_M_POWER_ISOUPDATE
+	musb_writeb(regs, MUSB_POWER, MGC_M_POWER_ISOUPDATE
 						| MGC_M_POWER_SOFTCONN
 						| MGC_M_POWER_HSENAB
 						/* ENSUSPEND wedges tusb */
@@ -807,7 +807,7 @@ void musb_start(struct musb *musb)
 						);
 
 	musb->is_active = 0;
-	devctl = musb_readb(regs, MGC_O_HDRC_DEVCTL);
+	devctl = musb_readb(regs, MUSB_DEVCTL);
 	devctl &= ~MGC_M_DEVCTL_SESSION;
 
 	if (is_otg_enabled(musb)) {
@@ -830,7 +830,7 @@ void musb_start(struct musb *musb)
 			musb->is_active = 1;
 	}
 	musb_platform_enable(musb);
-	musb_writeb(regs, MGC_O_HDRC_DEVCTL, devctl);
+	musb_writeb(regs, MUSB_DEVCTL, devctl);
 }
 
 
@@ -840,17 +840,17 @@ static void musb_generic_disable(struct musb *musb)
 	u16	temp;
 
 	/* disable interrupts */
-	musb_writeb(mbase, MGC_O_HDRC_INTRUSBE, 0);
-	musb_writew(mbase, MGC_O_HDRC_INTRTXE, 0);
-	musb_writew(mbase, MGC_O_HDRC_INTRRXE, 0);
+	musb_writeb(mbase, MUSB_INTRUSBE, 0);
+	musb_writew(mbase, MUSB_INTRTXE, 0);
+	musb_writew(mbase, MUSB_INTRRXE, 0);
 
 	/* off */
-	musb_writeb(mbase, MGC_O_HDRC_DEVCTL, 0);
+	musb_writeb(mbase, MUSB_DEVCTL, 0);
 
 	/*  flush pending interrupts */
-	temp = musb_readb(mbase, MGC_O_HDRC_INTRUSB);
-	temp = musb_readw(mbase, MGC_O_HDRC_INTRTX);
-	temp = musb_readw(mbase, MGC_O_HDRC_INTRRX);
+	temp = musb_readb(mbase, MUSB_INTRUSB);
+	temp = musb_readw(mbase, MUSB_INTRTX);
+	temp = musb_readw(mbase, MUSB_INTRRX);
 
 }
 
@@ -1045,7 +1045,7 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 	}
 
 	/* configure the FIFO */
-	musb_writeb(mbase, MGC_O_HDRC_INDEX, hw_ep->epnum);
+	musb_writeb(mbase, MUSB_INDEX, hw_ep->epnum);
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	/* EP0 reserved endpoint for control, bidirectional;
@@ -1057,25 +1057,25 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 #endif
 	switch (cfg->style) {
 	case FIFO_TX:
-		musb_writeb(mbase, MGC_O_HDRC_TXFIFOSZ, c_size);
-		musb_writew(mbase, MGC_O_HDRC_TXFIFOADD, c_off);
+		musb_writeb(mbase, MUSB_TXFIFOSZ, c_size);
+		musb_writew(mbase, MUSB_TXFIFOADD, c_off);
 		hw_ep->tx_double_buffered = !!(c_size & MGC_M_FIFOSZ_DPB);
 		hw_ep->max_packet_sz_tx = maxpacket;
 		break;
 	case FIFO_RX:
-		musb_writeb(mbase, MGC_O_HDRC_RXFIFOSZ, c_size);
-		musb_writew(mbase, MGC_O_HDRC_RXFIFOADD, c_off);
+		musb_writeb(mbase, MUSB_RXFIFOSZ, c_size);
+		musb_writew(mbase, MUSB_RXFIFOADD, c_off);
 		hw_ep->rx_double_buffered = !!(c_size & MGC_M_FIFOSZ_DPB);
 		hw_ep->max_packet_sz_rx = maxpacket;
 		break;
 	case FIFO_RXTX:
-		musb_writeb(mbase, MGC_O_HDRC_TXFIFOSZ, c_size);
-		musb_writew(mbase, MGC_O_HDRC_TXFIFOADD, c_off);
+		musb_writeb(mbase, MUSB_TXFIFOSZ, c_size);
+		musb_writew(mbase, MUSB_TXFIFOADD, c_off);
 		hw_ep->rx_double_buffered = !!(c_size & MGC_M_FIFOSZ_DPB);
 		hw_ep->max_packet_sz_rx = maxpacket;
 
-		musb_writeb(mbase, MGC_O_HDRC_RXFIFOSZ, c_size);
-		musb_writew(mbase, MGC_O_HDRC_RXFIFOADD, c_off);
+		musb_writeb(mbase, MUSB_RXFIFOSZ, c_size);
+		musb_writew(mbase, MUSB_RXFIFOADD, c_off);
 		hw_ep->tx_double_buffered = hw_ep->rx_double_buffered;
 		hw_ep->max_packet_sz_tx = maxpacket;
 
@@ -1192,7 +1192,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 		hw_ep = musb->endpoints + epnum;
 
 		/* read from core using indexed model */
-		reg = musb_readb(hw_ep->regs, 0x10 + MGC_O_HDRC_FIFOSIZE);
+		reg = musb_readb(hw_ep->regs, 0x10 + MUSB_FIFOSIZE);
 		if (!reg) {
 			/* 0's returned when no more endpoints */
 			break;
@@ -1259,7 +1259,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 
 	/* log core options (read using indexed model) */
 	musb_ep_select(mbase, 0);
-	reg = musb_readb(mbase, 0x10 + MGC_O_HDRC_CONFIGDATA);
+	reg = musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
 
 	strcpy(aInfo, (reg & MGC_M_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
 	if (reg & MGC_M_CONFIGDATA_DYNFIFO) {
@@ -1326,7 +1326,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	}
 
 	/* log release info */
-	wRelease = musb_readw(mbase, MGC_O_HDRC_HWVERS);
+	wRelease = musb_readw(mbase, MUSB_HWVERS);
 	wRelMajor = (wRelease >> 10) & 0x1f;
 	wRelMinor = wRelease & 0x3ff;
 	snprintf(aRevision, 32, "%d.%d%s", wRelMajor,
@@ -1422,9 +1422,9 @@ static irqreturn_t generic_interrupt(int irq, void *__hci)
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	musb->int_usb = musb_readb(musb->mregs, MGC_O_HDRC_INTRUSB);
-	musb->int_tx = musb_readw(musb->mregs, MGC_O_HDRC_INTRTX);
-	musb->int_rx = musb_readw(musb->mregs, MGC_O_HDRC_INTRRX);
+	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
+	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
+	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
 
 	if (musb->int_usb || musb->int_tx || musb->int_rx)
 		retval = musb_interrupt(musb);
@@ -1458,8 +1458,8 @@ irqreturn_t musb_interrupt(struct musb *musb)
 	int		ep_num;
 	u32		reg;
 
-	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
-	power = musb_readb(musb->mregs, MGC_O_HDRC_POWER);
+	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
+	power = musb_readb(musb->mregs, MUSB_POWER);
 
 	DBG(4, "** IRQ %s usb%04x tx%04x rx%04x\n",
 		(devctl & MGC_M_DEVCTL_HM) ? "host" : "peripheral",
@@ -1541,7 +1541,7 @@ MODULE_PARM_DESC(use_dma, "enable/disable use of DMA");
 
 void musb_dma_completion(struct musb *musb, u8 epnum, u8 bTransmit)
 {
-	u8	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
+	u8	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 
 	/* called with controller lock already held */
 
@@ -1641,7 +1641,7 @@ musb_cable_show(struct device *dev, struct device_attribute *attr, char *buf)
 	 * VBUS high for a long time after power has been removed, can
 	 * cause temporary false indications of a connection.
 	 */
-	vbus = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
+	vbus = musb_readb(musb->mregs, MUSB_DEVCTL);
 	if (vbus & 0x10) {
 		/* REVISIT retest on real OTG hardware */
 		switch (musb->board_mode) {
@@ -1815,9 +1815,9 @@ static void musb_free(struct musb *musb)
 		dma_controller_destroy(c);
 	}
 
-	musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, 0);
+	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	musb_platform_exit(musb);
-	musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, 0);
+	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 
 	if (musb->clock) {
 		clk_disable(musb->clock);
@@ -1991,8 +1991,8 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 		DBG(1, "%s mode, status %d, devctl %02x %c\n",
 			"HOST", status,
-			musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL),
-			(musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL)
+			musb_readb(musb->mregs, MUSB_DEVCTL),
+			(musb_readb(musb->mregs, MUSB_DEVCTL)
 					& MGC_M_DEVCTL_BDEVICE
 				? 'B' : 'A'));
 
@@ -2006,7 +2006,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		DBG(1, "%s mode, status %d, dev%02x\n",
 			is_otg_enabled(musb) ? "OTG" : "PERIPHERAL",
 			status,
-			musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL));
+			musb_readb(musb->mregs, MUSB_DEVCTL));
 
 	}
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index d43b5cc..fff2553 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -527,7 +527,7 @@ static void tusb_source_power(struct musb *musb, int is_on)
 
 	prcm = musb_readl(base, TUSB_PRCM_MNGMT);
 	conf = musb_readl(base, TUSB_DEV_CONF);
-	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
+	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 
 	if (is_on) {
 		if (musb->set_clock)
@@ -562,11 +562,11 @@ static void tusb_source_power(struct musb *musb, int is_on)
 	musb_writel(base, TUSB_PRCM_MNGMT, prcm);
 	musb_writel(base, TUSB_DEV_OTG_TIMER, timer);
 	musb_writel(base, TUSB_DEV_CONF, conf);
-	musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, devctl);
+	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
 
 	DBG(1, "VBUS %s, devctl %02x otg %3x conf %08x prcm %08x\n",
 		otg_state_string(musb),
-		musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL),
+		musb_readb(musb->mregs, MUSB_DEVCTL),
 		musb_readl(base, TUSB_DEV_OTG_STAT),
 		conf, prcm);
 }
@@ -707,9 +707,9 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *base)
 			case OTG_STATE_A_IDLE:
 				DBG(2, "Got SRP, turning on VBUS\n");
 				devctl = musb_readb(musb->mregs,
-							MGC_O_HDRC_DEVCTL);
+							MUSB_DEVCTL);
 				devctl |= MGC_M_DEVCTL_SESSION;
-				musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL,
+				musb_writeb(musb->mregs, MUSB_DEVCTL,
 							devctl);
 				musb->xceiv.state = OTG_STATE_A_WAIT_VRISE;
 
@@ -753,7 +753,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *base)
 			/* VBUS has probably been valid for a while now,
 			 * but may well have bounced out of range a bit
 			 */
-			devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
+			devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 			if (otg_stat & TUSB_DEV_OTG_STAT_VBUS_VALID) {
 				if ((devctl & MGC_M_DEVCTL_VBUS)
 						!= MGC_M_DEVCTL_VBUS) {
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 9359028..4141c12 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -223,10 +223,10 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 		if (chdat->tx) {
 			DBG(2, "terminating short tx packet\n");
 			musb_ep_select(musb_base, chdat->epnum);
-			csr = musb_readw(hw_ep->regs, MGC_O_HDRC_TXCSR);
+			csr = musb_readw(hw_ep->regs, MUSB_TXCSR);
 			csr |= MGC_M_TXCSR_MODE | MGC_M_TXCSR_TXPKTRDY
 				| MGC_M_TXCSR_P_WZC_BITS;
-			musb_writew(hw_ep->regs, MGC_O_HDRC_TXCSR, csr);
+			musb_writew(hw_ep->regs, MUSB_TXCSR, csr);
 		}
 	}
 
@@ -376,17 +376,17 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	 */
 	if (chdat->tx) {
 		musb_ep_select(musb_base, chdat->epnum);
-		csr = musb_readw(hw_ep->regs, MGC_O_HDRC_TXCSR);
+		csr = musb_readw(hw_ep->regs, MUSB_TXCSR);
 		csr |= (MGC_M_TXCSR_AUTOSET | MGC_M_TXCSR_DMAENAB
 			| MGC_M_TXCSR_DMAMODE | MGC_M_TXCSR_MODE);
 		csr &= ~MGC_M_TXCSR_P_UNDERRUN;
-		musb_writew(hw_ep->regs, MGC_O_HDRC_TXCSR, csr);
+		musb_writew(hw_ep->regs, MUSB_TXCSR, csr);
 	} else {
 		musb_ep_select(musb_base, chdat->epnum);
-		csr = musb_readw(hw_ep->regs, MGC_O_HDRC_RXCSR);
+		csr = musb_readw(hw_ep->regs, MUSB_RXCSR);
 		csr |= MGC_M_RXCSR_DMAENAB;
 		csr &= ~(MGC_M_RXCSR_AUTOCLEAR | MGC_M_RXCSR_DMAMODE);
-		musb_writew(hw_ep->regs, MGC_O_HDRC_RXCSR,
+		musb_writew(hw_ep->regs, MUSB_RXCSR,
 			csr | MGC_M_RXCSR_P_WZC_BITS);
 	}
 
diff --git a/drivers/usb/musb/virthub.c b/drivers/usb/musb/virthub.c
index 5ad1614..41450c9 100644
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -59,18 +59,18 @@ static void musb_port_suspend(struct musb *musb, u8 bSuspend)
 	 * MGC_M_POWER_ENSUSPEND.  PHY may need a clock (sigh) to detect
 	 * SE0 changing to connect (J) or wakeup (K) states.
 	 */
-	power = musb_readb(mbase, MGC_O_HDRC_POWER);
+	power = musb_readb(mbase, MUSB_POWER);
 	if (bSuspend) {
 		int retries = 10000;
 
 		power &= ~MGC_M_POWER_RESUME;
 		power |= MGC_M_POWER_SUSPENDM;
-		musb_writeb(mbase, MGC_O_HDRC_POWER, power);
+		musb_writeb(mbase, MUSB_POWER, power);
 
 		/* Needed for OPT A tests */
-		power = musb_readb(mbase, MGC_O_HDRC_POWER);
+		power = musb_readb(mbase, MUSB_POWER);
 		while (power & MGC_M_POWER_SUSPENDM) {
-			power = musb_readb(mbase, MGC_O_HDRC_POWER);
+			power = musb_readb(mbase, MUSB_POWER);
 			if (retries-- < 1)
 				break;
 		}
@@ -97,7 +97,7 @@ static void musb_port_suspend(struct musb *musb, u8 bSuspend)
 	} else if (power & MGC_M_POWER_SUSPENDM) {
 		power &= ~MGC_M_POWER_SUSPENDM;
 		power |= MGC_M_POWER_RESUME;
-		musb_writeb(mbase, MGC_O_HDRC_POWER, power);
+		musb_writeb(mbase, MUSB_POWER, power);
 
 		DBG(3, "Root port resuming, power %02x\n", power);
 
@@ -114,7 +114,7 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 
 #ifdef CONFIG_USB_MUSB_OTG
 	/* REVISIT this looks wrong for HNP */
-	u8 devctl = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
+	u8 devctl = musb_readb(mbase, MUSB_DEVCTL);
 
 	if (musb->delay_port_power_off || !(devctl & MGC_M_DEVCTL_HM)) {
 		return;
@@ -127,7 +127,7 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 	/* NOTE:  caller guarantees it will turn off the reset when
 	 * the appropriate amount of time has passed
 	 */
-	power = musb_readb(mbase, MGC_O_HDRC_POWER);
+	power = musb_readb(mbase, MUSB_POWER);
 	if (bReset) {
 
 		/*
@@ -140,14 +140,14 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 		if (power &  MGC_M_POWER_RESUME) {
 			while (time_before(jiffies, musb->rh_timer))
 				msleep(1);
-			musb_writeb(mbase, MGC_O_HDRC_POWER,
+			musb_writeb(mbase, MUSB_POWER,
 				power & ~MGC_M_POWER_RESUME);
 			msleep(1);
 		}
 
 		musb->ignore_disconnect = TRUE;
 		power &= 0xf0;
-		musb_writeb(mbase, MGC_O_HDRC_POWER,
+		musb_writeb(mbase, MUSB_POWER,
 				power | MGC_M_POWER_RESET);
 
 		musb->port1_status |= USB_PORT_STAT_RESET;
@@ -155,12 +155,12 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 		musb->rh_timer = jiffies + msecs_to_jiffies(50);
 	} else {
 		DBG(4, "root port reset stopped\n");
-		musb_writeb(mbase, MGC_O_HDRC_POWER,
+		musb_writeb(mbase, MUSB_POWER,
 				power & ~MGC_M_POWER_RESET);
 
 		musb->ignore_disconnect = FALSE;
 
-		power = musb_readb(mbase, MGC_O_HDRC_POWER);
+		power = musb_readb(mbase, MUSB_POWER);
 		if (power & MGC_M_POWER_HSMODE) {
 			DBG(4, "high-speed device connected\n");
 			musb->port1_status |= USB_PORT_STAT_HIGH_SPEED;
@@ -308,11 +308,11 @@ int musb_hub_control(
 				&& time_after(jiffies, musb->rh_timer)) {
 			u8		power;
 
-			power = musb_readb(musb->mregs, MGC_O_HDRC_POWER);
+			power = musb_readb(musb->mregs, MUSB_POWER);
 			power &= ~MGC_M_POWER_RESUME;
 			DBG(4, "root port resume stopped, power %02x\n",
 					power);
-			musb_writeb(musb->mregs, MGC_O_HDRC_POWER, power);
+			musb_writeb(musb->mregs, MUSB_POWER, power);
 
 			/* ISSUE:  DaVinci (RTL 1.300) disconnects after
 			 * resume of high speed peripherals (but not full
@@ -388,7 +388,7 @@ int musb_hub_control(
 				temp = MGC_M_TEST_FORCE_HOST
 					| MGC_M_TEST_FORCE_HS;
 
-				musb_writeb(musb->mregs, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
+				musb_writeb(musb->mregs, MUSB_DEVCTL, MGC_M_DEVCTL_SESSION);
 				break;
 			case 6:
 				pr_debug("TEST_FIFO_ACCESS\n");
@@ -397,7 +397,7 @@ int musb_hub_control(
 			default:
 				goto error;
 			}
-			musb_writeb(musb->mregs, MGC_O_HDRC_TESTMODE, temp);
+			musb_writeb(musb->mregs, MUSB_TESTMODE, temp);
 			break;
 		default:
 			goto error;
-- 
1.5.2.3
