From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/3] usb: musb: drop unneeded musb_debug trickery
Date: Wed, 11 May 2011 13:06:53 +0300
Message-ID: <1305108415-27206-2-git-send-email-balbi@ti.com>
References: <1305108415-27206-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44276 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752172Ab1EKPpb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 11:45:31 -0400
In-Reply-To: <1305108415-27206-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

We have a generic way of enabling/disabling
different debug messages on a driver called
DYNAMIC_PRINTK. Anyone interested in enabling
just part of the debug messages, please read
the documentation under:

Documentation/dynamic-debug-howto.txt

for information on how to use that great
infrastructure.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/Kconfig           |    8 ---
 drivers/usb/musb/Makefile          |    2 -
 drivers/usb/musb/am35x.c           |   10 ++--
 drivers/usb/musb/blackfin.c        |   10 ++--
 drivers/usb/musb/cppi_dma.c        |   34 ++++++------
 drivers/usb/musb/da8xx.c           |   14 ++--
 drivers/usb/musb/davinci.c         |   10 ++--
 drivers/usb/musb/musb_core.c       |   96 +++++++++++++++-----------------
 drivers/usb/musb/musb_debug.h      |   12 ----
 drivers/usb/musb/musb_gadget.c     |  110 ++++++++++++++++++-----------------
 drivers/usb/musb/musb_gadget_ep0.c |   22 ++++----
 drivers/usb/musb/musb_host.c       |  106 +++++++++++++++-------------------
 drivers/usb/musb/musb_virthub.c    |   22 ++++----
 drivers/usb/musb/musbhsdma.c       |   11 ++--
 drivers/usb/musb/omap2430.c        |   20 +++---
 drivers/usb/musb/tusb6010.c        |   48 ++++++++--------
 drivers/usb/musb/tusb6010_omap.c   |   32 +++++-----
 17 files changed, 266 insertions(+), 301 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 74073b3..f90123f 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -176,11 +176,3 @@ config USB_TUSB_OMAP_DMA
 	help
 	  Enable DMA transfers on TUSB 6010 when OMAP DMA is available.
 
-config	USB_MUSB_DEBUG
-	depends on USB_MUSB_HDRC
-	bool "Enable debugging messages"
-	default n
-	help
-	  This enables musb debugging. To set the logging level use the debug
-	  module parameter. Starting at level 3, per-transfer (urb, usb_request,
-	  packet, or dma transfer) tracing may kick in.
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index 74df528..4e15281 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -2,8 +2,6 @@
 # for USB OTG silicon based on Mentor Graphics INVENTRA designs
 #
 
-ccflags-$(CONFIG_USB_MUSB_DEBUG) := -DDEBUG
-
 obj-$(CONFIG_USB_MUSB_HDRC) += musb_hdrc.o
 
 musb_hdrc-y := musb_core.o
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index d5a3da3..59cb4d2 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -151,7 +151,7 @@ static void otg_timer(unsigned long _musb)
 	 * status change events (from the transceiver) otherwise.
 	 */
 	devctl = musb_readb(mregs, MUSB_DEVCTL);
-	DBG(7, "Poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
+	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
@@ -202,19 +202,19 @@ static void am35x_musb_try_idle(struct musb *musb, unsigned long timeout)
 	/* Never idle if active, or when VBUS timeout is not set as host */
 	if (musb->is_active || (musb->a_wait_bcon == 0 &&
 				musb->xceiv->state == OTG_STATE_A_WAIT_BCON)) {
-		DBG(4, "%s active, deleting timer\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "%s active, deleting timer\n", otg_state_string(musb));
 		del_timer(&otg_workaround);
 		last_timer = jiffies;
 		return;
 	}
 
 	if (time_after(last_timer, timeout) && timer_pending(&otg_workaround)) {
-		DBG(4, "Longer idle timer already pending, ignoring...\n");
+		dev_dbg(musb->controller, "Longer idle timer already pending, ignoring...\n");
 		return;
 	}
 	last_timer = timeout;
 
-	DBG(4, "%s inactive, starting idle timer for %u ms\n",
+	dev_dbg(musb->controller, "%s inactive, starting idle timer for %u ms\n",
 	    otg_state_string(musb), jiffies_to_msecs(timeout - jiffies));
 	mod_timer(&otg_workaround, timeout);
 }
@@ -302,7 +302,7 @@ static irqreturn_t am35x_musb_interrupt(int irq, void *hci)
 		}
 
 		/* NOTE: this must complete power-on within 100 ms. */
-		DBG(2, "VBUS %s (%s)%s, devctl %02x\n",
+		dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
 				drvvbus ? "on" : "off",
 				otg_state_string(musb),
 				err ? " ERROR" : "",
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 8e2a1ff..8d157ec 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -43,7 +43,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 
 	musb_writew(epio, MUSB_TXCOUNT, len);
 
-	DBG(4, "TX ep%d fifo %p count %d buf %p, epio %p\n",
+	dev_dbg(musb->controller, "TX ep%d fifo %p count %d buf %p, epio %p\n",
 			hw_ep->epnum, fifo, len, src, epio);
 
 	dump_fifo_data(src, len);
@@ -154,7 +154,7 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 				*(dst + len - 1) = (u8)inw((unsigned long)fifo + 4);
 		}
 	}
-	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
+	dev_dbg(musb->controller, "%cX ep%d fifo %p count %d buf %p\n",
 			'R', hw_ep->epnum, fifo, len, dst);
 
 	dump_fifo_data(dst, len);
@@ -279,12 +279,12 @@ static void musb_conn_timer_handler(unsigned long _musb)
 		}
 		break;
 	default:
-		DBG(1, "%s state not handled\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "%s state not handled\n", otg_state_string(musb));
 		break;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-	DBG(4, "state is %s\n", otg_state_string(musb));
+	dev_dbg(musb->controller, "state is %s\n", otg_state_string(musb));
 }
 
 static void bfin_musb_enable(struct musb *musb)
@@ -306,7 +306,7 @@ static void bfin_musb_set_vbus(struct musb *musb, int is_on)
 		value = !value;
 	gpio_set_value(musb->config->gpio_vrsel, value);
 
-	DBG(1, "VBUS %s, devctl %02x "
+	dev_dbg(musb->controller, "VBUS %s, devctl %02x "
 		/* otg %3x conf %08x prcm %08x */ "\n",
 		otg_state_string(musb),
 		musb_readb(musb->mregs, MUSB_DEVCTL));
diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index ab434fb..149f3f3 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -236,7 +236,7 @@ static int cppi_controller_stop(struct dma_controller *c)
 	musb_writel(tibase, DAVINCI_RXCPPI_INTCLR_REG,
 			DAVINCI_DMA_ALL_CHANNELS_ENABLE);
 
-	DBG(1, "Tearing down RX and TX Channels\n");
+	dev_dbg(musb->controller, "Tearing down RX and TX Channels\n");
 	for (i = 0; i < ARRAY_SIZE(controller->tx); i++) {
 		/* FIXME restructure of txdma to use bds like rxdma */
 		controller->tx[i].last_processed = NULL;
@@ -301,13 +301,13 @@ cppi_channel_allocate(struct dma_controller *c,
 	 */
 	if (transmit) {
 		if (index >= ARRAY_SIZE(controller->tx)) {
-			DBG(1, "no %cX%d CPPI channel\n", 'T', index);
+			dev_dbg(musb->controller, "no %cX%d CPPI channel\n", 'T', index);
 			return NULL;
 		}
 		cppi_ch = controller->tx + index;
 	} else {
 		if (index >= ARRAY_SIZE(controller->rx)) {
-			DBG(1, "no %cX%d CPPI channel\n", 'R', index);
+			dev_dbg(musb->controller, "no %cX%d CPPI channel\n", 'R', index);
 			return NULL;
 		}
 		cppi_ch = controller->rx + index;
@@ -318,13 +318,13 @@ cppi_channel_allocate(struct dma_controller *c,
 	 * with the other DMA engine too
 	 */
 	if (cppi_ch->hw_ep)
-		DBG(1, "re-allocating DMA%d %cX channel %p\n",
+		dev_dbg(musb->controller, "re-allocating DMA%d %cX channel %p\n",
 				index, transmit ? 'T' : 'R', cppi_ch);
 	cppi_ch->hw_ep = ep;
 	cppi_ch->channel.status = MUSB_DMA_STATUS_FREE;
 	cppi_ch->channel.max_len = 0x7fffffff;
 
-	DBG(4, "Allocate CPPI%d %cX\n", index, transmit ? 'T' : 'R');
+	dev_dbg(musb->controller, "Allocate CPPI%d %cX\n", index, transmit ? 'T' : 'R');
 	return &cppi_ch->channel;
 }
 
@@ -339,7 +339,7 @@ static void cppi_channel_release(struct dma_channel *channel)
 	c = container_of(channel, struct cppi_channel, channel);
 	tibase = c->controller->tibase;
 	if (!c->hw_ep)
-		DBG(1, "releasing idle DMA channel %p\n", c);
+		dev_dbg(musb->controller, "releasing idle DMA channel %p\n", c);
 	else if (!c->transmit)
 		core_rxirq_enable(tibase, c->index + 1);
 
@@ -597,7 +597,7 @@ cppi_next_tx_segment(struct musb *musb, struct cppi_channel *tx)
 		length = min(n_bds * maxpacket, length);
 	}
 
-	DBG(4, "TX DMA%d, pktSz %d %s bds %d dma 0x%llx len %u\n",
+	dev_dbg(musb->controller, "TX DMA%d, pktSz %d %s bds %d dma 0x%llx len %u\n",
 			tx->index,
 			maxpacket,
 			rndis ? "rndis" : "transparent",
@@ -654,7 +654,7 @@ cppi_next_tx_segment(struct musb *musb, struct cppi_channel *tx)
 				bd->hw_options |= CPPI_ZERO_SET;
 		}
 
-		DBG(5, "TXBD %p: nxt %08x buf %08x len %04x opt %08x\n",
+		dev_dbg(musb->controller, "TXBD %p: nxt %08x buf %08x len %04x opt %08x\n",
 				bd, bd->hw_next, bd->hw_bufp,
 				bd->hw_off_len, bd->hw_options);
 
@@ -819,7 +819,7 @@ cppi_next_rx_segment(struct musb *musb, struct cppi_channel *rx, int onepacket)
 
 	length = min(n_bds * maxpacket, length);
 
-	DBG(4, "RX DMA%d seg, maxp %d %s bds %d (cnt %d) "
+	dev_dbg(musb->controller, "RX DMA%d seg, maxp %d %s bds %d (cnt %d) "
 			"dma 0x%llx len %u %u/%u\n",
 			rx->index, maxpacket,
 			onepacket
@@ -936,7 +936,7 @@ cppi_next_rx_segment(struct musb *musb, struct cppi_channel *rx, int onepacket)
 			DAVINCI_RXCPPI_BUFCNT0_REG + (rx->index * 4))
 			& 0xffff;
 	if (i < (2 + n_bds)) {
-		DBG(2, "bufcnt%d underrun - %d (for %d)\n",
+		dev_dbg(musb->controller, "bufcnt%d underrun - %d (for %d)\n",
 					rx->index, i, n_bds);
 		musb_writel(tibase,
 			DAVINCI_RXCPPI_BUFCNT0_REG + (rx->index * 4),
@@ -985,7 +985,7 @@ static int cppi_channel_program(struct dma_channel *ch,
 		/* WARN_ON(1); */
 		break;
 	case MUSB_DMA_STATUS_UNKNOWN:
-		DBG(1, "%cX DMA%d not allocated!\n",
+		dev_dbg(musb->controller, "%cX DMA%d not allocated!\n",
 				cppi_ch->transmit ? 'T' : 'R',
 				cppi_ch->index);
 		/* FALLTHROUGH */
@@ -1040,7 +1040,7 @@ static bool cppi_rx_scan(struct cppi *cppi, unsigned ch)
 		if (!completed && (bd->hw_options & CPPI_OWN_SET))
 			break;
 
-		DBG(5, "C/RXBD %llx: nxt %08x buf %08x "
+		dev_dbg(musb->controller, "C/RXBD %llx: nxt %08x buf %08x "
 			"off.len %08x opt.len %08x (%d)\n",
 			(unsigned long long)bd->dma, bd->hw_next, bd->hw_bufp,
 			bd->hw_off_len, bd->hw_options,
@@ -1062,7 +1062,7 @@ static bool cppi_rx_scan(struct cppi *cppi, unsigned ch)
 			 * CPPI ignores those BDs even though OWN is still set.
 			 */
 			completed = true;
-			DBG(3, "rx short %d/%d (%d)\n",
+			dev_dbg(musb->controller, "rx short %d/%d (%d)\n",
 					len, bd->buflen,
 					rx->channel.actual_len);
 		}
@@ -1112,7 +1112,7 @@ static bool cppi_rx_scan(struct cppi *cppi, unsigned ch)
 		musb_ep_select(cppi->mregs, rx->index + 1);
 		csr = musb_readw(regs, MUSB_RXCSR);
 		if (csr & MUSB_RXCSR_DMAENAB) {
-			DBG(4, "list%d %p/%p, last %llx%s, csr %04x\n",
+			dev_dbg(musb->controller, "list%d %p/%p, last %llx%s, csr %04x\n",
 				rx->index,
 				rx->head, rx->tail,
 				rx->last_processed
@@ -1175,7 +1175,7 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	DBG(4, "CPPI IRQ Tx%x Rx%x\n", tx, rx);
+	dev_dbg(musb->controller, "CPPI IRQ Tx%x Rx%x\n", tx, rx);
 
 	/* process TX channels */
 	for (index = 0; tx; tx = tx >> 1, index++) {
@@ -1203,7 +1203,7 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
 		 * that needs to be acknowledged.
 		 */
 		if (NULL == bd) {
-			DBG(1, "null BD\n");
+			dev_dbg(musb->controller, "null BD\n");
 			musb_writel(&tx_ram->tx_complete, 0, 0);
 			continue;
 		}
@@ -1218,7 +1218,7 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
 			if (bd->hw_options & CPPI_OWN_SET)
 				break;
 
-			DBG(5, "C/TXBD %p n %x b %x off %x opt %x\n",
+			dev_dbg(musb->controller, "C/TXBD %p n %x b %x off %x opt %x\n",
 					bd, bd->hw_next, bd->hw_bufp,
 					bd->hw_off_len, bd->hw_options);
 
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 69a0da3..bee5519 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -199,7 +199,7 @@ static void otg_timer(unsigned long _musb)
 	 * status change events (from the transceiver) otherwise.
 	 */
 	devctl = musb_readb(mregs, MUSB_DEVCTL);
-	DBG(7, "Poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
+	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
@@ -273,19 +273,19 @@ static void da8xx_musb_try_idle(struct musb *musb, unsigned long timeout)
 	/* Never idle if active, or when VBUS timeout is not set as host */
 	if (musb->is_active || (musb->a_wait_bcon == 0 &&
 				musb->xceiv->state == OTG_STATE_A_WAIT_BCON)) {
-		DBG(4, "%s active, deleting timer\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "%s active, deleting timer\n", otg_state_string(musb));
 		del_timer(&otg_workaround);
 		last_timer = jiffies;
 		return;
 	}
 
 	if (time_after(last_timer, timeout) && timer_pending(&otg_workaround)) {
-		DBG(4, "Longer idle timer already pending, ignoring...\n");
+		dev_dbg(musb->controller, "Longer idle timer already pending, ignoring...\n");
 		return;
 	}
 	last_timer = timeout;
 
-	DBG(4, "%s inactive, starting idle timer for %u ms\n",
+	dev_dbg(musb->controller, "%s inactive, starting idle timer for %u ms\n",
 	    otg_state_string(musb), jiffies_to_msecs(timeout - jiffies));
 	mod_timer(&otg_workaround, timeout);
 }
@@ -311,7 +311,7 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
 		goto eoi;
 
 	musb_writel(reg_base, DA8XX_USB_INTR_SRC_CLEAR_REG, status);
-	DBG(4, "USB IRQ %08x\n", status);
+	dev_dbg(musb->controller, "USB IRQ %08x\n", status);
 
 	musb->int_rx = (status & DA8XX_INTR_RX_MASK) >> DA8XX_INTR_RX_SHIFT;
 	musb->int_tx = (status & DA8XX_INTR_TX_MASK) >> DA8XX_INTR_TX_SHIFT;
@@ -363,7 +363,7 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
 			portstate(musb->port1_status &= ~USB_PORT_STAT_POWER);
 		}
 
-		DBG(2, "VBUS %s (%s)%s, devctl %02x\n",
+		dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
 				drvvbus ? "on" : "off",
 				otg_state_string(musb),
 				err ? " ERROR" : "",
@@ -410,7 +410,7 @@ static int da8xx_musb_set_mode(struct musb *musb, u8 musb_mode)
 		break;
 #endif
 	default:
-		DBG(2, "Trying to set unsupported mode %u\n", musb_mode);
+		dev_dbg(musb->controller, "Trying to set unsupported mode %u\n", musb_mode);
 	}
 
 	__raw_writel(cfgchip2, CFGCHIP2);
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index e6de097..1292dbb 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -220,7 +220,7 @@ static void otg_timer(unsigned long _musb)
 	* status change events (from the transceiver) otherwise.
 	 */
 	devctl = musb_readb(mregs, MUSB_DEVCTL);
-	DBG(7, "poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
+	dev_dbg(musb->controller, "poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
@@ -297,7 +297,7 @@ static irqreturn_t davinci_musb_interrupt(int irq, void *__hci)
 	/* ack and handle non-CPPI interrupts */
 	tmp = musb_readl(tibase, DAVINCI_USB_INT_SRC_MASKED_REG);
 	musb_writel(tibase, DAVINCI_USB_INT_SRC_CLR_REG, tmp);
-	DBG(4, "IRQ %08x\n", tmp);
+	dev_dbg(musb->controller, "IRQ %08x\n", tmp);
 
 	musb->int_rx = (tmp & DAVINCI_USB_RXINT_MASK)
 			>> DAVINCI_USB_RXINT_SHIFT;
@@ -354,7 +354,7 @@ static irqreturn_t davinci_musb_interrupt(int irq, void *__hci)
 		 * (OTG_TIME_A_WAIT_VRISE) but we don't check for that.
 		 */
 		davinci_musb_source_power(musb, drvvbus, 0);
-		DBG(2, "VBUS %s (%s)%s, devctl %02x\n",
+		dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
 				drvvbus ? "on" : "off",
 				otg_state_string(musb),
 				err ? " ERROR" : "",
@@ -484,7 +484,7 @@ static int davinci_musb_exit(struct musb *musb)
 				break;
 			if ((devctl & MUSB_DEVCTL_VBUS) != warn) {
 				warn = devctl & MUSB_DEVCTL_VBUS;
-				DBG(1, "VBUS %d\n",
+				dev_dbg(musb->controller, "VBUS %d\n",
 					warn >> MUSB_DEVCTL_VBUS_SHIFT);
 			}
 			msleep(1000);
@@ -493,7 +493,7 @@ static int davinci_musb_exit(struct musb *musb)
 
 		/* in OTG mode, another host might be connected */
 		if (devctl & MUSB_DEVCTL_VBUS)
-			DBG(1, "VBUS off timeout (devctl %02x)\n", devctl);
+			dev_dbg(musb->controller, "VBUS off timeout (devctl %02x)\n", devctl);
 	}
 
 	phy_off();
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f10ff00..d8014a3 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -104,10 +104,6 @@
 #define TA_WAIT_BCON(m) max_t(int, (m)->a_wait_bcon, OTG_TIME_A_WAIT_BCON)
 
 
-unsigned musb_debug;
-module_param_named(debug, musb_debug, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(debug, "Debug message level. Default = 0");
-
 #define DRIVER_AUTHOR "Mentor Graphics, Texas Instruments, Nokia"
 #define DRIVER_DESC "Inventra Dual-Role USB Controller Driver"
 
@@ -157,10 +153,8 @@ static int musb_ulpi_read(struct otg_transceiver *otg, u32 offset)
 	while (!(musb_readb(addr, MUSB_ULPI_REG_CONTROL)
 				& MUSB_ULPI_REG_CMPLT)) {
 		i++;
-		if (i == 10000) {
-			DBG(3, "ULPI read timed out\n");
+		if (i == 10000)
 			return -ETIMEDOUT;
-		}
 
 	}
 	r = musb_readb(addr, MUSB_ULPI_REG_CONTROL);
@@ -190,10 +184,8 @@ static int musb_ulpi_write(struct otg_transceiver *otg,
 	while (!(musb_readb(addr, MUSB_ULPI_REG_CONTROL)
 				& MUSB_ULPI_REG_CMPLT)) {
 		i++;
-		if (i == 10000) {
-			DBG(3, "ULPI write timed out\n");
+		if (i == 10000)
 			return -ETIMEDOUT;
-		}
 	}
 
 	r = musb_readb(addr, MUSB_ULPI_REG_CONTROL);
@@ -221,11 +213,12 @@ static struct otg_io_access_ops musb_ulpi_access = {
  */
 void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 {
+	struct musb *musb = hw_ep->musb;
 	void __iomem *fifo = hw_ep->fifo;
 
 	prefetch((u8 *)src);
 
-	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
+	dev_dbg(musb->controller, "%cX ep%d fifo %p count %d buf %p\n",
 			'T', hw_ep->epnum, fifo, len, src);
 
 	/* we can't assume unaligned reads work */
@@ -262,9 +255,10 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
  */
 void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 {
+	struct musb *musb = hw_ep->musb;
 	void __iomem *fifo = hw_ep->fifo;
 
-	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
+	dev_dbg(musb->controller, "%cX ep%d fifo %p count %d buf %p\n",
 			'R', hw_ep->epnum, fifo, len, dst);
 
 	/* we can't assume unaligned writes work */
@@ -366,19 +360,19 @@ void musb_otg_timer_func(unsigned long data)
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
 	case OTG_STATE_B_WAIT_ACON:
-		DBG(1, "HNP: b_wait_acon timeout; back to b_peripheral\n");
+		dev_dbg(musb->controller, "HNP: b_wait_acon timeout; back to b_peripheral\n");
 		musb_g_disconnect(musb);
 		musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 		musb->is_active = 0;
 		break;
 	case OTG_STATE_A_SUSPEND:
 	case OTG_STATE_A_WAIT_BCON:
-		DBG(1, "HNP: %s timeout\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "HNP: %s timeout\n", otg_state_string(musb));
 		musb_platform_set_vbus(musb, 0);
 		musb->xceiv->state = OTG_STATE_A_WAIT_VFALL;
 		break;
 	default:
-		DBG(1, "HNP: Unhandled mode %s\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "HNP: Unhandled mode %s\n", otg_state_string(musb));
 	}
 	musb->ignore_disconnect = 0;
 	spin_unlock_irqrestore(&musb->lock, flags);
@@ -393,15 +387,15 @@ void musb_hnp_stop(struct musb *musb)
 	void __iomem	*mbase = musb->mregs;
 	u8	reg;
 
-	DBG(1, "HNP: stop from %s\n", otg_state_string(musb));
+	dev_dbg(musb->controller, "HNP: stop from %s\n", otg_state_string(musb));
 
 	switch (musb->xceiv->state) {
 	case OTG_STATE_A_PERIPHERAL:
 		musb_g_disconnect(musb);
-		DBG(1, "HNP: back to %s\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "HNP: back to %s\n", otg_state_string(musb));
 		break;
 	case OTG_STATE_B_HOST:
-		DBG(1, "HNP: Disabling HR\n");
+		dev_dbg(musb->controller, "HNP: Disabling HR\n");
 		hcd->self.is_b_host = 0;
 		musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 		MUSB_DEV_MODE(musb);
@@ -411,7 +405,7 @@ void musb_hnp_stop(struct musb *musb)
 		/* REVISIT: Start SESSION_REQUEST here? */
 		break;
 	default:
-		DBG(1, "HNP: Stopping in unknown state %s\n",
+		dev_dbg(musb->controller, "HNP: Stopping in unknown state %s\n",
 			otg_state_string(musb));
 	}
 
@@ -442,7 +436,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 {
 	irqreturn_t handled = IRQ_NONE;
 
-	DBG(3, "<== Power=%02x, DevCtl=%02x, int_usb=0x%x\n", power, devctl,
+	dev_dbg(musb->controller, "<== Power=%02x, DevCtl=%02x, int_usb=0x%x\n", power, devctl,
 		int_usb);
 
 	/* in host mode, the peripheral may issue remote wakeup.
@@ -451,7 +445,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 	 */
 	if (int_usb & MUSB_INTR_RESUME) {
 		handled = IRQ_HANDLED;
-		DBG(3, "RESUME (%s)\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "RESUME (%s)\n", otg_state_string(musb));
 
 		if (devctl & MUSB_DEVCTL_HM) {
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
@@ -466,7 +460,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 				if (power & MUSB_POWER_SUSPENDM) {
 					/* spurious */
 					musb->int_usb &= ~MUSB_INTR_SUSPEND;
-					DBG(2, "Spurious SUSPENDM\n");
+					dev_dbg(musb->controller, "Spurious SUSPENDM\n");
 					break;
 				}
 
@@ -538,11 +532,11 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 
 		if ((devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS
 				&& (devctl & MUSB_DEVCTL_BDEVICE)) {
-			DBG(3, "SessReq while on B state\n");
+			dev_dbg(musb->controller, "SessReq while on B state\n");
 			return IRQ_HANDLED;
 		}
 
-		DBG(1, "SESSION_REQUEST (%s)\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "SESSION_REQUEST (%s)\n", otg_state_string(musb));
 
 		/* IRQ arrives from ID pin sense or (later, if VBUS power
 		 * is removed) SRP.  responses are time critical:
@@ -606,7 +600,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 			break;
 		}
 
-		DBG(1, "VBUS_ERROR in %s (%02x, %s), retry #%d, port1 %08x\n",
+		dev_dbg(musb->controller, "VBUS_ERROR in %s (%02x, %s), retry #%d, port1 %08x\n",
 				otg_state_string(musb),
 				devctl,
 				({ char *s;
@@ -632,7 +626,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 
 #endif
 	if (int_usb & MUSB_INTR_SUSPEND) {
-		DBG(1, "SUSPEND (%s) devctl %02x power %02x\n",
+		dev_dbg(musb->controller, "SUSPEND (%s) devctl %02x power %02x\n",
 				otg_state_string(musb), devctl, power);
 		handled = IRQ_HANDLED;
 
@@ -665,7 +659,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 			if (musb->is_active) {
 #ifdef	CONFIG_USB_MUSB_OTG
 				musb->xceiv->state = OTG_STATE_B_WAIT_ACON;
-				DBG(1, "HNP: Setting timer for b_ase0_brst\n");
+				dev_dbg(musb->controller, "HNP: Setting timer for b_ase0_brst\n");
 				mod_timer(&musb->otg_timer, jiffies
 					+ msecs_to_jiffies(
 							OTG_TIME_B_ASE0_BRST));
@@ -684,7 +678,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 			break;
 		case OTG_STATE_B_HOST:
 			/* Transition to B_PERIPHERAL, see 6.8.2.6 p 44 */
-			DBG(1, "REVISIT: SUSPEND as B_HOST\n");
+			dev_dbg(musb->controller, "REVISIT: SUSPEND as B_HOST\n");
 			break;
 		default:
 			/* "should not happen" */
@@ -727,14 +721,14 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 		switch (musb->xceiv->state) {
 		case OTG_STATE_B_PERIPHERAL:
 			if (int_usb & MUSB_INTR_SUSPEND) {
-				DBG(1, "HNP: SUSPEND+CONNECT, now b_host\n");
+				dev_dbg(musb->controller, "HNP: SUSPEND+CONNECT, now b_host\n");
 				int_usb &= ~MUSB_INTR_SUSPEND;
 				goto b_host;
 			} else
-				DBG(1, "CONNECT as b_peripheral???\n");
+				dev_dbg(musb->controller, "CONNECT as b_peripheral???\n");
 			break;
 		case OTG_STATE_B_WAIT_ACON:
-			DBG(1, "HNP: CONNECT, now b_host\n");
+			dev_dbg(musb->controller, "HNP: CONNECT, now b_host\n");
 b_host:
 			musb->xceiv->state = OTG_STATE_B_HOST;
 			hcd->self.is_b_host = 1;
@@ -757,13 +751,13 @@ b_host:
 		else
 			usb_hcd_resume_root_hub(hcd);
 
-		DBG(1, "CONNECT (%s) devctl %02x\n",
+		dev_dbg(musb->controller, "CONNECT (%s) devctl %02x\n",
 				otg_state_string(musb), devctl);
 	}
 #endif	/* CONFIG_USB_MUSB_HDRC_HCD */
 
 	if ((int_usb & MUSB_INTR_DISCONNECT) && !musb->ignore_disconnect) {
-		DBG(1, "DISCONNECT (%s) as %s, devctl %02x\n",
+		dev_dbg(musb->controller, "DISCONNECT (%s) as %s, devctl %02x\n",
 				otg_state_string(musb),
 				MUSB_MODE(musb), devctl);
 		handled = IRQ_HANDLED;
@@ -826,13 +820,13 @@ b_host:
 			 * stop the session.
 			 */
 			if (devctl & (MUSB_DEVCTL_FSDEV | MUSB_DEVCTL_LSDEV))
-				DBG(1, "BABBLE devctl: %02x\n", devctl);
+				dev_dbg(musb->controller, "BABBLE devctl: %02x\n", devctl);
 			else {
 				ERR("Stopping host session -- babble\n");
 				musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 			}
 		} else if (is_peripheral_capable()) {
-			DBG(1, "BUS RESET as %s\n", otg_state_string(musb));
+			dev_dbg(musb->controller, "BUS RESET as %s\n", otg_state_string(musb));
 			switch (musb->xceiv->state) {
 #ifdef CONFIG_USB_OTG
 			case OTG_STATE_A_SUSPEND:
@@ -845,7 +839,7 @@ b_host:
 				/* FALLTHROUGH */
 			case OTG_STATE_A_WAIT_BCON:	/* OPT TD.4.7-900ms */
 				/* never use invalid T(a_wait_bcon) */
-				DBG(1, "HNP: in %s, %d msec timeout\n",
+				dev_dbg(musb->controller, "HNP: in %s, %d msec timeout\n",
 						otg_state_string(musb),
 						TA_WAIT_BCON(musb));
 				mod_timer(&musb->otg_timer, jiffies
@@ -857,7 +851,7 @@ b_host:
 				musb_g_reset(musb);
 				break;
 			case OTG_STATE_B_WAIT_ACON:
-				DBG(1, "HNP: RESET (%s), to b_peripheral\n",
+				dev_dbg(musb->controller, "HNP: RESET (%s), to b_peripheral\n",
 					otg_state_string(musb));
 				musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 				musb_g_reset(musb);
@@ -870,7 +864,7 @@ b_host:
 				musb_g_reset(musb);
 				break;
 			default:
-				DBG(1, "Unhandled BUS RESET as %s\n",
+				dev_dbg(musb->controller, "Unhandled BUS RESET as %s\n",
 					otg_state_string(musb));
 			}
 		}
@@ -894,7 +888,7 @@ b_host:
 		u8 epnum;
 		u16 frame;
 
-		DBG(6, "START_OF_FRAME\n");
+		dev_dbg(musb->controller, "START_OF_FRAME\n");
 		handled = IRQ_HANDLED;
 
 		/* start any periodic Tx transfers waiting for current frame */
@@ -936,7 +930,7 @@ void musb_start(struct musb *musb)
 	void __iomem	*regs = musb->mregs;
 	u8		devctl = musb_readb(regs, MUSB_DEVCTL);
 
-	DBG(2, "<== devctl %02x\n", devctl);
+	dev_dbg(musb->controller, "<== devctl %02x\n", devctl);
 
 	/*  Set INT enable registers, enable interrupts */
 	musb_writew(regs, MUSB_INTRTXE, musb->epmask);
@@ -1013,7 +1007,7 @@ void musb_stop(struct musb *musb)
 	/* stop IRQs, timers, ... */
 	musb_platform_disable(musb);
 	musb_generic_disable(musb);
-	DBG(3, "HDRC disabled\n");
+	dev_dbg(musb->controller, "HDRC disabled\n");
 
 	/* FIXME
 	 *  - mark host and/or peripheral drivers unusable/inactive
@@ -1359,7 +1353,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 	void *mbase = musb->mregs;
 	int ret = 0;
 
-	DBG(2, "<== static silicon ep config\n");
+	dev_dbg(musb->controller, "<== static silicon ep config\n");
 
 	/* FIXME pick up ep0 maxpacket size */
 
@@ -1506,7 +1500,7 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 #endif
 
 		if (hw_ep->max_packet_sz_tx) {
-			DBG(1,
+			dev_dbg(musb->controller,
 				"%s: hw_ep %d%s, %smax %d\n",
 				musb_driver_name, i,
 				hw_ep->is_shared_fifo ? "shared" : "tx",
@@ -1515,7 +1509,7 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 				hw_ep->max_packet_sz_tx);
 		}
 		if (hw_ep->max_packet_sz_rx && !hw_ep->is_shared_fifo) {
-			DBG(1,
+			dev_dbg(musb->controller,
 				"%s: hw_ep %d%s, %smax %d\n",
 				musb_driver_name, i,
 				"rx",
@@ -1524,7 +1518,7 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 				hw_ep->max_packet_sz_rx);
 		}
 		if (!(hw_ep->max_packet_sz_tx || hw_ep->max_packet_sz_rx))
-			DBG(1, "hw_ep %d not configured\n", i);
+			dev_dbg(musb->controller, "hw_ep %d not configured\n", i);
 	}
 
 	return 0;
@@ -1577,14 +1571,14 @@ irqreturn_t musb_interrupt(struct musb *musb)
 	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 	power = musb_readb(musb->mregs, MUSB_POWER);
 
-	DBG(4, "** IRQ %s usb%04x tx%04x rx%04x\n",
+	dev_dbg(musb->controller, "** IRQ %s usb%04x tx%04x rx%04x\n",
 		(devctl & MUSB_DEVCTL_HM) ? "host" : "peripheral",
 		musb->int_usb, musb->int_tx, musb->int_rx);
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	if (is_otg_enabled(musb) || is_peripheral_enabled(musb))
 		if (!musb->gadget_driver) {
-			DBG(5, "No gadget driver loaded\n");
+			dev_dbg(musb->controller, "No gadget driver loaded\n");
 			return IRQ_HANDLED;
 		}
 #endif
@@ -2075,7 +2069,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		status = usb_add_hcd(musb_to_hcd(musb), -1, 0);
 
 		hcd->self.uses_pio_for_control = 1;
-		DBG(1, "%s mode, status %d, devctl %02x %c\n",
+		dev_dbg(musb->controller, "%s mode, status %d, devctl %02x %c\n",
 			"HOST", status,
 			musb_readb(musb->mregs, MUSB_DEVCTL),
 			(musb_readb(musb->mregs, MUSB_DEVCTL)
@@ -2089,7 +2083,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 		status = musb_gadget_setup(musb);
 
-		DBG(1, "%s mode, status %d, dev%02x\n",
+		dev_dbg(musb->controller, "%s mode, status %d, dev%02x\n",
 			is_otg_enabled(musb) ? "OTG" : "PERIPHERAL",
 			status,
 			musb_readb(musb->mregs, MUSB_DEVCTL));
@@ -2471,8 +2465,8 @@ static int __init musb_init(void)
 #elif defined(CONFIG_USB_MUSB_HDRC_HCD)
 		"host"
 #endif
-		", debug=%d\n",
-		musb_driver_name, musb_debug);
+		,
+		musb_driver_name);
 	return platform_driver_probe(&musb_driver, musb_probe);
 }
 
diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
index 94f6973..e9cfaa0 100644
--- a/drivers/usb/musb/musb_debug.h
+++ b/drivers/usb/musb/musb_debug.h
@@ -42,18 +42,6 @@
 #define INFO(fmt, args...) yprintk(KERN_INFO, fmt, ## args)
 #define ERR(fmt, args...) yprintk(KERN_ERR, fmt, ## args)
 
-#define DBG(level, format, args...) do { \
-	if (_dbg_level(level)) \
-		pr_debug("%s %d: " format, __func__, __LINE__, ## args); \
-	} while (0)
-
-extern unsigned musb_debug;
-
-static inline int _dbg_level(unsigned l)
-{
-	return musb_debug >= l;
-}
-
 extern const char *otg_state_string(struct musb *);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index f47c201..e15a756 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -147,7 +147,8 @@ static inline void unmap_dma_buffer(struct musb_request *request,
 		return;
 
 	if (request->request.dma == DMA_ADDR_INVALID) {
-		DBG(20, "not unmapping a never mapped buffer\n");
+		dev_vdbg(musb->controller,
+				"not unmapping a never mapped buffer\n");
 		return;
 	}
 	if (request->map_state == MUSB_MAPPED) {
@@ -198,11 +199,11 @@ __acquires(ep->musb->lock)
 	spin_unlock(&musb->lock);
 	unmap_dma_buffer(req, musb);
 	if (request->status == 0)
-		DBG(5, "%s done request %p,  %d/%d\n",
+		dev_dbg(musb->controller, "%s done request %p,  %d/%d\n",
 				ep->end_point.name, request,
 				req->request.actual, req->request.length);
 	else
-		DBG(2, "%s request %p, %d/%d fault %d\n",
+		dev_dbg(musb->controller, "%s request %p, %d/%d fault %d\n",
 				ep->end_point.name, request,
 				req->request.actual, req->request.length,
 				request->status);
@@ -219,6 +220,7 @@ __acquires(ep->musb->lock)
  */
 static void nuke(struct musb_ep *ep, const int status)
 {
+	struct musb		*musb = ep->musb;
 	struct musb_request	*req = NULL;
 	void __iomem *epio = ep->musb->endpoints[ep->current_epnum].regs;
 
@@ -246,7 +248,8 @@ static void nuke(struct musb_ep *ep, const int status)
 		}
 
 		value = c->channel_abort(ep->dma);
-		DBG(value ? 1 : 6, "%s: abort DMA --> %d\n", ep->name, value);
+		dev_dbg(musb->controller, "%s: abort DMA --> %d\n",
+				ep->name, value);
 		c->channel_release(ep->dma);
 		ep->dma = NULL;
 	}
@@ -329,7 +332,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 
 	/* we shouldn't get here while DMA is active ... but we do ... */
 	if (dma_channel_status(musb_ep->dma) == MUSB_DMA_STATUS_BUSY) {
-		DBG(4, "dma pending...\n");
+		dev_dbg(musb->controller, "dma pending...\n");
 		return;
 	}
 
@@ -341,18 +344,18 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			(int)(request->length - request->actual));
 
 	if (csr & MUSB_TXCSR_TXPKTRDY) {
-		DBG(5, "%s old packet still ready , txcsr %03x\n",
+		dev_dbg(musb->controller, "%s old packet still ready , txcsr %03x\n",
 				musb_ep->end_point.name, csr);
 		return;
 	}
 
 	if (csr & MUSB_TXCSR_P_SENDSTALL) {
-		DBG(5, "%s stalling, txcsr %03x\n",
+		dev_dbg(musb->controller, "%s stalling, txcsr %03x\n",
 				musb_ep->end_point.name, csr);
 		return;
 	}
 
-	DBG(4, "hw_ep%d, maxpacket %d, fifo count %d, txcsr %03x\n",
+	dev_dbg(musb->controller, "hw_ep%d, maxpacket %d, fifo count %d, txcsr %03x\n",
 			epnum, musb_ep->packet_sz, fifo_count,
 			csr);
 
@@ -469,7 +472,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	}
 
 	/* host may already have the data when this message shows... */
-	DBG(3, "%s TX/IN %s len %d/%d, txcsr %04x, fifo %d/%d\n",
+	dev_dbg(musb->controller, "%s TX/IN %s len %d/%d, txcsr %04x, fifo %d/%d\n",
 			musb_ep->end_point.name, use_dma ? "dma" : "pio",
 			request->actual, request->length,
 			musb_readw(epio, MUSB_TXCSR),
@@ -496,7 +499,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 	request = &req->request;
 
 	csr = musb_readw(epio, MUSB_TXCSR);
-	DBG(4, "<== %s, txcsr %04x\n", musb_ep->end_point.name, csr);
+	dev_dbg(musb->controller, "<== %s, txcsr %04x\n", musb_ep->end_point.name, csr);
 
 	dma = is_dma_capable() ? musb_ep->dma : NULL;
 
@@ -516,7 +519,8 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 		csr |=	 MUSB_TXCSR_P_WZC_BITS;
 		csr &= ~(MUSB_TXCSR_P_UNDERRUN | MUSB_TXCSR_TXPKTRDY);
 		musb_writew(epio, MUSB_TXCSR, csr);
-		DBG(20, "underrun on ep%d, req %p\n", epnum, request);
+		dev_vdbg(musb->controller, "underrun on ep%d, req %p\n",
+				epnum, request);
 	}
 
 	if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
@@ -524,7 +528,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 		 * SHOULD NOT HAPPEN... has with CPPI though, after
 		 * changing SENDSTALL (and other cases); harmless?
 		 */
-		DBG(5, "%s dma still busy?\n", musb_ep->end_point.name);
+		dev_dbg(musb->controller, "%s dma still busy?\n", musb_ep->end_point.name);
 		return;
 	}
 
@@ -540,7 +544,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			/* Ensure writebuffer is empty. */
 			csr = musb_readw(epio, MUSB_TXCSR);
 			request->actual += musb_ep->dma->actual_len;
-			DBG(4, "TXCSR%d %04x, DMA off, len %zu, req %p\n",
+			dev_dbg(musb->controller, "TXCSR%d %04x, DMA off, len %zu, req %p\n",
 				epnum, csr, musb_ep->dma->actual_len, request);
 		}
 
@@ -564,7 +568,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			if (csr & MUSB_TXCSR_TXPKTRDY)
 				return;
 
-			DBG(4, "sending zero pkt\n");
+			dev_dbg(musb->controller, "sending zero pkt\n");
 			musb_writew(epio, MUSB_TXCSR, MUSB_TXCSR_MODE
 					| MUSB_TXCSR_TXPKTRDY);
 			request->zero = 0;
@@ -574,7 +578,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			musb_g_giveback(musb_ep, request, 0);
 			req = musb_ep->desc ? next_request(musb_ep) : NULL;
 			if (!req) {
-				DBG(4, "%s idle now\n",
+				dev_dbg(musb->controller, "%s idle now\n",
 					musb_ep->end_point.name);
 				return;
 			}
@@ -640,12 +644,12 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 
 	/* We shouldn't get here while DMA is active, but we do... */
 	if (dma_channel_status(musb_ep->dma) == MUSB_DMA_STATUS_BUSY) {
-		DBG(4, "DMA pending...\n");
+		dev_dbg(musb->controller, "DMA pending...\n");
 		return;
 	}
 
 	if (csr & MUSB_RXCSR_P_SENDSTALL) {
-		DBG(5, "%s stalling, RXCSR %04x\n",
+		dev_dbg(musb->controller, "%s stalling, RXCSR %04x\n",
 		    musb_ep->end_point.name, csr);
 		return;
 	}
@@ -757,7 +761,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 #endif	/* Mentor's DMA */
 
 			fifo_count = request->length - request->actual;
-			DBG(3, "%s OUT/RX pio fifo %d/%d, maxpacket %d\n",
+			dev_dbg(musb->controller, "%s OUT/RX pio fifo %d/%d, maxpacket %d\n",
 					musb_ep->end_point.name,
 					len, fifo_count,
 					musb_ep->packet_sz);
@@ -846,7 +850,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 	csr = musb_readw(epio, MUSB_RXCSR);
 	dma = is_dma_capable() ? musb_ep->dma : NULL;
 
-	DBG(4, "<== %s, rxcsr %04x%s %p\n", musb_ep->end_point.name,
+	dev_dbg(musb->controller, "<== %s, rxcsr %04x%s %p\n", musb_ep->end_point.name,
 			csr, dma ? " (dma)" : "", request);
 
 	if (csr & MUSB_RXCSR_P_SENTSTALL) {
@@ -861,19 +865,18 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		csr &= ~MUSB_RXCSR_P_OVERRUN;
 		musb_writew(epio, MUSB_RXCSR, csr);
 
-		DBG(3, "%s iso overrun on %p\n", musb_ep->name, request);
+		dev_dbg(musb->controller, "%s iso overrun on %p\n", musb_ep->name, request);
 		if (request->status == -EINPROGRESS)
 			request->status = -EOVERFLOW;
 	}
 	if (csr & MUSB_RXCSR_INCOMPRX) {
 		/* REVISIT not necessarily an error */
-		DBG(4, "%s, incomprx\n", musb_ep->end_point.name);
+		dev_dbg(musb->controller, "%s, incomprx\n", musb_ep->end_point.name);
 	}
 
 	if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
 		/* "should not happen"; likely RXPKTRDY pending for DMA */
-		DBG((csr & MUSB_RXCSR_DMAENAB) ? 4 : 1,
-			"%s busy, csr %04x\n",
+		dev_dbg(musb->controller, "%s busy, csr %04x\n",
 			musb_ep->end_point.name, csr);
 		return;
 	}
@@ -887,7 +890,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 		request->actual += musb_ep->dma->actual_len;
 
-		DBG(4, "RXCSR%d %04x, dma off, %04x, len %zu, req %p\n",
+		dev_dbg(musb->controller, "RXCSR%d %04x, dma off, %04x, len %zu, req %p\n",
 			epnum, csr,
 			musb_readw(epio, MUSB_RXCSR),
 			musb_ep->dma->actual_len, request);
@@ -978,7 +981,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			ok = musb->hb_iso_rx;
 
 		if (!ok) {
-			DBG(4, "no support for high bandwidth ISO\n");
+			dev_dbg(musb->controller, "no support for high bandwidth ISO\n");
 			goto fail;
 		}
 		musb_ep->hb_mult = (tmp >> 11) & 3;
@@ -1002,7 +1005,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			goto fail;
 
 		if (tmp > hw_ep->max_packet_sz_tx) {
-			DBG(4, "packet size beyond hardware FIFO size\n");
+			dev_dbg(musb->controller, "packet size beyond hardware FIFO size\n");
 			goto fail;
 		}
 
@@ -1042,7 +1045,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			goto fail;
 
 		if (tmp > hw_ep->max_packet_sz_rx) {
-			DBG(4, "packet size beyond hardware FIFO size\n");
+			dev_dbg(musb->controller, "packet size beyond hardware FIFO size\n");
 			goto fail;
 		}
 
@@ -1155,7 +1158,7 @@ static int musb_gadget_disable(struct usb_ep *ep)
 
 	spin_unlock_irqrestore(&(musb->lock), flags);
 
-	DBG(2, "%s\n", musb_ep->end_point.name);
+	dev_dbg(musb->controller, "%s\n", musb_ep->end_point.name);
 
 	return status;
 }
@@ -1167,11 +1170,12 @@ static int musb_gadget_disable(struct usb_ep *ep)
 struct usb_request *musb_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 {
 	struct musb_ep		*musb_ep = to_musb_ep(ep);
+	struct musb		*musb = musb_ep->musb;
 	struct musb_request	*request = NULL;
 
 	request = kzalloc(sizeof *request, gfp_flags);
 	if (!request) {
-		DBG(4, "not enough memory\n");
+		dev_dbg(musb->controller, "not enough memory\n");
 		return NULL;
 	}
 
@@ -1205,7 +1209,7 @@ struct free_record {
  */
 void musb_ep_restart(struct musb *musb, struct musb_request *req)
 {
-	DBG(3, "<== %s request %p len %u on hw_ep%d\n",
+	dev_dbg(musb->controller, "<== %s request %p len %u on hw_ep%d\n",
 		req->tx ? "TX/IN" : "RX/OUT",
 		&req->request, req->request.length, req->epnum);
 
@@ -1239,7 +1243,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	if (request->ep != musb_ep)
 		return -EINVAL;
 
-	DBG(4, "<== to %s request=%p\n", ep->name, req);
+	dev_dbg(musb->controller, "<== to %s request=%p\n", ep->name, req);
 
 	/* request is mine now... */
 	request->request.actual = 0;
@@ -1253,7 +1257,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 
 	/* don't queue if the ep is down */
 	if (!musb_ep->desc) {
-		DBG(4, "req %p queued to %s while ep %s\n",
+		dev_dbg(musb->controller, "req %p queued to %s while ep %s\n",
 				req, ep->name, "disabled");
 		status = -ESHUTDOWN;
 		goto cleanup;
@@ -1290,7 +1294,7 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *request)
 			break;
 	}
 	if (r != req) {
-		DBG(3, "request %p not queued to %s\n", request, ep->name);
+		dev_dbg(musb->controller, "request %p not queued to %s\n", request, ep->name);
 		status = -EINVAL;
 		goto done;
 	}
@@ -1356,7 +1360,7 @@ static int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	request = next_request(musb_ep);
 	if (value) {
 		if (request) {
-			DBG(3, "request in progress, cannot halt %s\n",
+			dev_dbg(musb->controller, "request in progress, cannot halt %s\n",
 			    ep->name);
 			status = -EAGAIN;
 			goto done;
@@ -1365,7 +1369,7 @@ static int musb_gadget_set_halt(struct usb_ep *ep, int value)
 		if (musb_ep->is_in) {
 			csr = musb_readw(epio, MUSB_TXCSR);
 			if (csr & MUSB_TXCSR_FIFONOTEMPTY) {
-				DBG(3, "FIFO busy, cannot halt %s\n", ep->name);
+				dev_dbg(musb->controller, "FIFO busy, cannot halt %s\n", ep->name);
 				status = -EAGAIN;
 				goto done;
 			}
@@ -1374,7 +1378,7 @@ static int musb_gadget_set_halt(struct usb_ep *ep, int value)
 		musb_ep->wedged = 0;
 
 	/* set/clear the stall and toggle bits */
-	DBG(2, "%s: %s stall\n", ep->name, value ? "set" : "clear");
+	dev_dbg(musb->controller, "%s: %s stall\n", ep->name, value ? "set" : "clear");
 	if (musb_ep->is_in) {
 		csr = musb_readw(epio, MUSB_TXCSR);
 		csr |= MUSB_TXCSR_P_WZC_BITS
@@ -1401,7 +1405,7 @@ static int musb_gadget_set_halt(struct usb_ep *ep, int value)
 
 	/* maybe start the first request in the queue */
 	if (!musb_ep->busy && !value && request) {
-		DBG(3, "restarting the request\n");
+		dev_dbg(musb->controller, "restarting the request\n");
 		musb_ep_restart(musb, request);
 	}
 
@@ -1532,7 +1536,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 	case OTG_STATE_B_IDLE:
 		/* Start SRP ... OTG not required. */
 		devctl = musb_readb(mregs, MUSB_DEVCTL);
-		DBG(2, "Sending SRP: devctl: %02x\n", devctl);
+		dev_dbg(musb->controller, "Sending SRP: devctl: %02x\n", devctl);
 		devctl |= MUSB_DEVCTL_SESSION;
 		musb_writeb(mregs, MUSB_DEVCTL, devctl);
 		devctl = musb_readb(mregs, MUSB_DEVCTL);
@@ -1556,7 +1560,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 		status = 0;
 		goto done;
 	default:
-		DBG(2, "Unhandled wake: %s\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "Unhandled wake: %s\n", otg_state_string(musb));
 		goto done;
 	}
 
@@ -1565,7 +1569,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 	power = musb_readb(mregs, MUSB_POWER);
 	power |= MUSB_POWER_RESUME;
 	musb_writeb(mregs, MUSB_POWER, power);
-	DBG(2, "issue wakeup\n");
+	dev_dbg(musb->controller, "issue wakeup\n");
 
 	/* FIXME do this next chunk in a timer callback, no udelay */
 	mdelay(2);
@@ -1599,7 +1603,7 @@ static void musb_pullup(struct musb *musb, int is_on)
 
 	/* FIXME if on, HdrcStart; if off, HdrcStop */
 
-	DBG(3, "gadget %s D+ pullup %s\n",
+	dev_dbg(musb->controller, "gadget %s D+ pullup %s\n",
 		musb->gadget_driver->function, is_on ? "on" : "off");
 	musb_writeb(musb->mregs, MUSB_POWER, power);
 }
@@ -1607,7 +1611,7 @@ static void musb_pullup(struct musb *musb, int is_on)
 #if 0
 static int musb_gadget_vbus_session(struct usb_gadget *gadget, int is_active)
 {
-	DBG(2, "<= %s =>\n", __func__);
+	dev_dbg(musb->controller, "<= %s =>\n", __func__);
 
 	/*
 	 * FIXME iff driver's softconnect flag is set (as it is during probe,
@@ -1816,17 +1820,17 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
 
 	/* driver must be initialized to support peripheral mode */
 	if (!musb) {
-		DBG(1, "no dev??\n");
+		dev_dbg(musb->controller, "no dev??\n");
 		retval = -ENODEV;
 		goto err0;
 	}
 
 	pm_runtime_get_sync(musb->controller);
 
-	DBG(3, "registering driver %s\n", driver->function);
+	dev_dbg(musb->controller, "registering driver %s\n", driver->function);
 
 	if (musb->gadget_driver) {
-		DBG(1, "%s is already bound to %s\n",
+		dev_dbg(musb->controller, "%s is already bound to %s\n",
 				musb_driver_name,
 				musb->gadget_driver->driver.name);
 		retval = -EBUSY;
@@ -1842,7 +1846,7 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
 
 	retval = bind(&musb->g);
 	if (retval) {
-		DBG(3, "bind to driver %s failed --> %d\n",
+		dev_dbg(musb->controller, "bind to driver %s failed --> %d\n",
 				driver->driver.name, retval);
 		goto err1;
 	}
@@ -1870,7 +1874,7 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
 	if (is_otg_enabled(musb)) {
 		struct usb_hcd	*hcd = musb_to_hcd(musb);
 
-		DBG(3, "OTG startup...\n");
+		dev_dbg(musb->controller, "OTG startup...\n");
 
 		/* REVISIT:  funcall to other code, which also
 		 * handles power budgeting ... this way also
@@ -1878,7 +1882,7 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
 		 */
 		retval = usb_add_hcd(musb_to_hcd(musb), -1, 0);
 		if (retval < 0) {
-			DBG(1, "add_hcd failed, %d\n", retval);
+			dev_dbg(musb->controller, "add_hcd failed, %d\n", retval);
 			goto err2;
 		}
 
@@ -1985,7 +1989,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	stop_activity(musb, driver);
 	otg_set_peripheral(musb->xceiv, NULL);
 
-	DBG(3, "unregistering driver %s\n", driver->function);
+	dev_dbg(musb->controller, "unregistering driver %s\n", driver->function);
 
 	spin_unlock_irqrestore(&musb->lock, flags);
 	driver->unbind(&musb->g);
@@ -2047,7 +2051,7 @@ void musb_g_suspend(struct musb *musb)
 	u8	devctl;
 
 	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
-	DBG(3, "devctl %02x\n", devctl);
+	dev_dbg(musb->controller, "devctl %02x\n", devctl);
 
 	switch (musb->xceiv->state) {
 	case OTG_STATE_B_IDLE:
@@ -2083,7 +2087,7 @@ void musb_g_disconnect(struct musb *musb)
 	void __iomem	*mregs = musb->mregs;
 	u8	devctl = musb_readb(mregs, MUSB_DEVCTL);
 
-	DBG(3, "devctl %02x\n", devctl);
+	dev_dbg(musb->controller, "devctl %02x\n", devctl);
 
 	/* clear HR */
 	musb_writeb(mregs, MUSB_DEVCTL, devctl & MUSB_DEVCTL_SESSION);
@@ -2101,7 +2105,7 @@ void musb_g_disconnect(struct musb *musb)
 	switch (musb->xceiv->state) {
 	default:
 #ifdef	CONFIG_USB_MUSB_OTG
-		DBG(2, "Unhandled disconnect %s, setting a_idle\n",
+		dev_dbg(musb->controller, "Unhandled disconnect %s, setting a_idle\n",
 			otg_state_string(musb));
 		musb->xceiv->state = OTG_STATE_A_IDLE;
 		MUSB_HST_MODE(musb);
@@ -2132,7 +2136,7 @@ __acquires(musb->lock)
 	u8		devctl = musb_readb(mbase, MUSB_DEVCTL);
 	u8		power;
 
-	DBG(3, "<== %s addr=%x driver '%s'\n",
+	dev_dbg(musb->controller, "<== %s addr=%x driver '%s'\n",
 			(devctl & MUSB_DEVCTL_BDEVICE)
 				? "B-Device" : "A-Device",
 			musb_readb(mbase, MUSB_FADDR),
diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 75a542e..b2faff2 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -209,7 +209,7 @@ static inline void musb_try_b_hnp_enable(struct musb *musb)
 	void __iomem	*mbase = musb->mregs;
 	u8		devctl;
 
-	DBG(1, "HNP: Setting HR\n");
+	dev_dbg(musb->controller, "HNP: Setting HR\n");
 	devctl = musb_readb(mbase, MUSB_DEVCTL);
 	musb_writeb(mbase, MUSB_DEVCTL, devctl | MUSB_DEVCTL_HR);
 }
@@ -306,7 +306,7 @@ __acquires(musb->lock)
 				/* Maybe start the first request in the queue */
 				request = next_request(musb_ep);
 				if (!musb_ep->busy && request) {
-					DBG(3, "restarting the request\n");
+					dev_dbg(musb->controller, "restarting the request\n");
 					musb_ep_restart(musb, request);
 				}
 
@@ -553,7 +553,7 @@ static void ep0_txstate(struct musb *musb)
 
 	if (!req) {
 		/* WARN_ON(1); */
-		DBG(2, "odd; csr0 %04x\n", musb_readw(regs, MUSB_CSR0));
+		dev_dbg(musb->controller, "odd; csr0 %04x\n", musb_readw(regs, MUSB_CSR0));
 		return;
 	}
 
@@ -610,7 +610,7 @@ musb_read_setup(struct musb *musb, struct usb_ctrlrequest *req)
 	/* NOTE:  earlier 2.6 versions changed setup packets to host
 	 * order, but now USB packets always stay in USB byte order.
 	 */
-	DBG(3, "SETUP req%02x.%02x v%04x i%04x l%d\n",
+	dev_dbg(musb->controller, "SETUP req%02x.%02x v%04x i%04x l%d\n",
 		req->bRequestType,
 		req->bRequest,
 		le16_to_cpu(req->wValue),
@@ -678,7 +678,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 	csr = musb_readw(regs, MUSB_CSR0);
 	len = musb_readb(regs, MUSB_COUNT0);
 
-	DBG(4, "csr %04x, count %d, myaddr %d, ep0stage %s\n",
+	dev_dbg(musb->controller, "csr %04x, count %d, myaddr %d, ep0stage %s\n",
 			csr, len,
 			musb_readb(mbase, MUSB_FADDR),
 			decode_ep0stage(musb->ep0_state));
@@ -749,7 +749,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 
 		/* enter test mode if needed (exit by reset) */
 		else if (musb->test_mode) {
-			DBG(1, "entering TESTMODE\n");
+			dev_dbg(musb->controller, "entering TESTMODE\n");
 
 			if (MUSB_TEST_PACKET == musb->test_mode_nr)
 				musb_load_testpacket(musb);
@@ -861,7 +861,7 @@ setup:
 				break;
 			}
 
-			DBG(3, "handled %d, csr %04x, ep0stage %s\n",
+			dev_dbg(musb->controller, "handled %d, csr %04x, ep0stage %s\n",
 				handled, csr,
 				decode_ep0stage(musb->ep0_state));
 
@@ -878,7 +878,7 @@ setup:
 			if (handled < 0) {
 				musb_ep_select(mbase, 0);
 stall:
-				DBG(3, "stall (%d)\n", handled);
+				dev_dbg(musb->controller, "stall (%d)\n", handled);
 				musb->ackpend |= MUSB_CSR0_P_SENDSTALL;
 				musb->ep0_state = MUSB_EP0_STAGE_IDLE;
 finish:
@@ -958,7 +958,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 		status = 0;
 		break;
 	default:
-		DBG(1, "ep0 request queued in state %d\n",
+		dev_dbg(musb->controller, "ep0 request queued in state %d\n",
 				musb->ep0_state);
 		status = -EINVAL;
 		goto cleanup;
@@ -967,7 +967,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	/* add request to the list */
 	list_add_tail(&req->list, &ep->req_list);
 
-	DBG(3, "queue to %s (%s), length=%d\n",
+	dev_dbg(musb->controller, "queue to %s (%s), length=%d\n",
 			ep->name, ep->is_in ? "IN/TX" : "OUT/RX",
 			req->request.length);
 
@@ -1060,7 +1060,7 @@ static int musb_g_ep0_halt(struct usb_ep *e, int value)
 		musb->ackpend = 0;
 		break;
 	default:
-		DBG(1, "ep0 can't halt in state %d\n", musb->ep0_state);
+		dev_dbg(musb->controller, "ep0 can't halt in state %d\n", musb->ep0_state);
 		status = -EINVAL;
 	}
 
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 5eef4a8..d39100a 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -106,6 +106,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
  */
 static void musb_h_tx_flush_fifo(struct musb_hw_ep *ep)
 {
+	struct musb	*musb = ep->musb;
 	void __iomem	*epio = ep->regs;
 	u16		csr;
 	u16		lastcsr = 0;
@@ -114,7 +115,7 @@ static void musb_h_tx_flush_fifo(struct musb_hw_ep *ep)
 	csr = musb_readw(epio, MUSB_TXCSR);
 	while (csr & MUSB_TXCSR_FIFONOTEMPTY) {
 		if (csr != lastcsr)
-			DBG(3, "Host TX FIFONOTEMPTY csr: %02x\n", csr);
+			dev_dbg(musb->controller, "Host TX FIFONOTEMPTY csr: %02x\n", csr);
 		lastcsr = csr;
 		csr |= MUSB_TXCSR_FLUSHFIFO;
 		musb_writew(epio, MUSB_TXCSR, csr);
@@ -240,7 +241,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 		len = urb->transfer_buffer_length - urb->actual_length;
 	}
 
-	DBG(4, "qh %p urb %p dev%d ep%d%s%s, hw_ep %d, %p/%d\n",
+	dev_dbg(musb->controller, "qh %p urb %p dev%d ep%d%s%s, hw_ep %d, %p/%d\n",
 			qh, urb, address, qh->epnum,
 			is_in ? "in" : "out",
 			({char *s; switch (qh->type) {
@@ -263,7 +264,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	switch (qh->type) {
 	case USB_ENDPOINT_XFER_ISOC:
 	case USB_ENDPOINT_XFER_INT:
-		DBG(3, "check whether there's still time for periodic Tx\n");
+		dev_dbg(musb->controller, "check whether there's still time for periodic Tx\n");
 		frame = musb_readw(mbase, MUSB_FRAME);
 		/* FIXME this doesn't implement that scheduling policy ...
 		 * or handle framecounter wrapping
@@ -278,7 +279,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 		} else {
 			qh->frame = urb->start_frame;
 			/* enable SOF interrupt so we can count down */
-			DBG(1, "SOF for %d\n", epnum);
+			dev_dbg(musb->controller, "SOF for %d\n", epnum);
 #if 1 /* ifndef	CONFIG_ARCH_DAVINCI */
 			musb_writeb(mbase, MUSB_INTRUSBE, 0xff);
 #endif
@@ -286,7 +287,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 		break;
 	default:
 start:
-		DBG(4, "Start TX%d %s\n", epnum,
+		dev_dbg(musb->controller, "Start TX%d %s\n", epnum,
 			hw_ep->tx_channel ? "dma" : "pio");
 
 		if (!hw_ep->tx_channel)
@@ -301,21 +302,7 @@ static void musb_giveback(struct musb *musb, struct urb *urb, int status)
 __releases(musb->lock)
 __acquires(musb->lock)
 {
-	DBG(({ int level; switch (status) {
-				case 0:
-					level = 4;
-					break;
-				/* common/boring faults */
-				case -EREMOTEIO:
-				case -ESHUTDOWN:
-				case -ECONNRESET:
-				case -EPIPE:
-					level = 3;
-					break;
-				default:
-					level = 2;
-					break;
-				}; level; }),
+	dev_dbg(musb->controller,
 			"complete %p %pF (%d), dev%d ep%d%s, %d/%d\n",
 			urb, urb->complete, status,
 			usb_pipedevice(urb->pipe),
@@ -426,7 +413,7 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	}
 
 	if (qh != NULL && qh->is_ready) {
-		DBG(4, "... next ep%d %cX urb %p\n",
+		dev_dbg(musb->controller, "... next ep%d %cX urb %p\n",
 		    hw_ep->epnum, is_in ? 'R' : 'T', next_urb(qh));
 		musb_start_urb(musb, is_in, qh);
 	}
@@ -471,7 +458,7 @@ musb_host_packet_rx(struct musb *musb, struct urb *urb, u8 epnum, u8 iso_err)
 
 	/* musb_ep_select(mbase, epnum); */
 	rx_count = musb_readw(epio, MUSB_RXCOUNT);
-	DBG(3, "RX%d count %d, buffer %p len %d/%d\n", epnum, rx_count,
+	dev_dbg(musb->controller, "RX%d count %d, buffer %p len %d/%d\n", epnum, rx_count,
 			urb->transfer_buffer, qh->offset,
 			urb->transfer_buffer_length);
 
@@ -493,7 +480,7 @@ musb_host_packet_rx(struct musb *musb, struct urb *urb, u8 epnum, u8 iso_err)
 				status = -EOVERFLOW;
 				urb->error_count++;
 			}
-			DBG(2, "** OVERFLOW %d into %d\n", rx_count, length);
+			dev_dbg(musb->controller, "** OVERFLOW %d into %d\n", rx_count, length);
 			do_flush = 1;
 		} else
 			length = rx_count;
@@ -511,7 +498,7 @@ musb_host_packet_rx(struct musb *musb, struct urb *urb, u8 epnum, u8 iso_err)
 		if (rx_count > length) {
 			if (urb->status == -EINPROGRESS)
 				urb->status = -EOVERFLOW;
-			DBG(2, "** OVERFLOW %d into %d\n", rx_count, length);
+			dev_dbg(musb->controller, "** OVERFLOW %d into %d\n", rx_count, length);
 			do_flush = 1;
 		} else
 			length = rx_count;
@@ -697,7 +684,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 	struct musb_qh		*qh = musb_ep_get_qh(hw_ep, !is_out);
 	u16			packet_sz = qh->maxpacket;
 
-	DBG(3, "%s hw%d urb %p spd%d dev%d ep%d%s "
+	dev_dbg(musb->controller, "%s hw%d urb %p spd%d dev%d ep%d%s "
 				"h_addr%02x h_port%02x bytes %d\n",
 			is_out ? "-->" : "<--",
 			epnum, urb, urb->dev->speed,
@@ -880,7 +867,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		}
 
 		csr |= MUSB_RXCSR_H_REQPKT;
-		DBG(7, "RXCSR%d := %04x\n", epnum, csr);
+		dev_dbg(musb->controller, "RXCSR%d := %04x\n", epnum, csr);
 		musb_writew(hw_ep->regs, MUSB_RXCSR, csr);
 		csr = musb_readw(hw_ep->regs, MUSB_RXCSR);
 	}
@@ -923,15 +910,15 @@ static bool musb_h_ep0_continue(struct musb *musb, u16 len, struct urb *urb)
 		request = (struct usb_ctrlrequest *) urb->setup_packet;
 
 		if (!request->wLength) {
-			DBG(4, "start no-DATA\n");
+			dev_dbg(musb->controller, "start no-DATA\n");
 			break;
 		} else if (request->bRequestType & USB_DIR_IN) {
-			DBG(4, "start IN-DATA\n");
+			dev_dbg(musb->controller, "start IN-DATA\n");
 			musb->ep0_stage = MUSB_EP0_IN;
 			more = true;
 			break;
 		} else {
-			DBG(4, "start OUT-DATA\n");
+			dev_dbg(musb->controller, "start OUT-DATA\n");
 			musb->ep0_stage = MUSB_EP0_OUT;
 			more = true;
 		}
@@ -943,7 +930,7 @@ static bool musb_h_ep0_continue(struct musb *musb, u16 len, struct urb *urb)
 		if (fifo_count) {
 			fifo_dest = (u8 *) (urb->transfer_buffer
 					+ urb->actual_length);
-			DBG(3, "Sending %d byte%s to ep0 fifo %p\n",
+			dev_dbg(musb->controller, "Sending %d byte%s to ep0 fifo %p\n",
 					fifo_count,
 					(fifo_count == 1) ? "" : "s",
 					fifo_dest);
@@ -988,7 +975,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 			? musb_readb(epio, MUSB_COUNT0)
 			: 0;
 
-	DBG(4, "<== csr0 %04x, qh %p, count %d, urb %p, stage %d\n",
+	dev_dbg(musb->controller, "<== csr0 %04x, qh %p, count %d, urb %p, stage %d\n",
 		csr, qh, len, urb, musb->ep0_stage);
 
 	/* if we just did status stage, we are done */
@@ -999,15 +986,15 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 
 	/* prepare status */
 	if (csr & MUSB_CSR0_H_RXSTALL) {
-		DBG(6, "STALLING ENDPOINT\n");
+		dev_dbg(musb->controller, "STALLING ENDPOINT\n");
 		status = -EPIPE;
 
 	} else if (csr & MUSB_CSR0_H_ERROR) {
-		DBG(2, "no response, csr0 %04x\n", csr);
+		dev_dbg(musb->controller, "no response, csr0 %04x\n", csr);
 		status = -EPROTO;
 
 	} else if (csr & MUSB_CSR0_H_NAKTIMEOUT) {
-		DBG(2, "control NAK timeout\n");
+		dev_dbg(musb->controller, "control NAK timeout\n");
 
 		/* NOTE:  this code path would be a good place to PAUSE a
 		 * control transfer, if another one is queued, so that
@@ -1022,7 +1009,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	}
 
 	if (status) {
-		DBG(6, "aborting\n");
+		dev_dbg(musb->controller, "aborting\n");
 		retval = IRQ_HANDLED;
 		if (urb)
 			urb->status = status;
@@ -1072,7 +1059,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 			/* flag status stage */
 			musb->ep0_stage = MUSB_EP0_STATUS;
 
-			DBG(5, "ep0 STATUS, csr %04x\n", csr);
+			dev_dbg(musb->controller, "ep0 STATUS, csr %04x\n", csr);
 
 		}
 		musb_writew(epio, MUSB_CSR0, csr);
@@ -1126,31 +1113,31 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 
 	/* with CPPI, DMA sometimes triggers "extra" irqs */
 	if (!urb) {
-		DBG(4, "extra TX%d ready, csr %04x\n", epnum, tx_csr);
+		dev_dbg(musb->controller, "extra TX%d ready, csr %04x\n", epnum, tx_csr);
 		return;
 	}
 
 	pipe = urb->pipe;
 	dma = is_dma_capable() ? hw_ep->tx_channel : NULL;
-	DBG(4, "OUT/TX%d end, csr %04x%s\n", epnum, tx_csr,
+	dev_dbg(musb->controller, "OUT/TX%d end, csr %04x%s\n", epnum, tx_csr,
 			dma ? ", dma" : "");
 
 	/* check for errors */
 	if (tx_csr & MUSB_TXCSR_H_RXSTALL) {
 		/* dma was disabled, fifo flushed */
-		DBG(3, "TX end %d stall\n", epnum);
+		dev_dbg(musb->controller, "TX end %d stall\n", epnum);
 
 		/* stall; record URB status */
 		status = -EPIPE;
 
 	} else if (tx_csr & MUSB_TXCSR_H_ERROR) {
 		/* (NON-ISO) dma was disabled, fifo flushed */
-		DBG(3, "TX 3strikes on ep=%d\n", epnum);
+		dev_dbg(musb->controller, "TX 3strikes on ep=%d\n", epnum);
 
 		status = -ETIMEDOUT;
 
 	} else if (tx_csr & MUSB_TXCSR_H_NAKTIMEOUT) {
-		DBG(6, "TX end=%d device not responding\n", epnum);
+		dev_dbg(musb->controller, "TX end=%d device not responding\n", epnum);
 
 		/* NOTE:  this code path would be a good place to PAUSE a
 		 * transfer, if there's some other (nonperiodic) tx urb
@@ -1195,7 +1182,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 
 	/* second cppi case */
 	if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
-		DBG(4, "extra TX%d ready, csr %04x\n", epnum, tx_csr);
+		dev_dbg(musb->controller, "extra TX%d ready, csr %04x\n", epnum, tx_csr);
 		return;
 	}
 
@@ -1254,7 +1241,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		 * FIFO mode too...
 		 */
 		if (tx_csr & (MUSB_TXCSR_FIFONOTEMPTY | MUSB_TXCSR_TXPKTRDY)) {
-			DBG(2, "DMA complete but packet still in FIFO, "
+			dev_dbg(musb->controller, "DMA complete but packet still in FIFO, "
 			    "CSR %04x\n", tx_csr);
 			return;
 		}
@@ -1321,7 +1308,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 			return;
 		}
 	} else	if (tx_csr & MUSB_TXCSR_DMAENAB) {
-		DBG(1, "not complete, but DMA enabled?\n");
+		dev_dbg(musb->controller, "not complete, but DMA enabled?\n");
 		return;
 	}
 
@@ -1462,7 +1449,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		 * usbtest #11 (unlinks) triggers it regularly, sometimes
 		 * with fifo full.  (Only with DMA??)
 		 */
-		DBG(3, "BOGUS RX%d ready, csr %04x, count %d\n", epnum, val,
+		dev_dbg(musb->controller, "BOGUS RX%d ready, csr %04x, count %d\n", epnum, val,
 			musb_readw(epio, MUSB_RXCOUNT));
 		musb_h_flush_rxfifo(hw_ep, MUSB_RXCSR_CLRDATATOG);
 		return;
@@ -1470,20 +1457,20 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 	pipe = urb->pipe;
 
-	DBG(5, "<== hw %d rxcsr %04x, urb actual %d (+dma %zu)\n",
+	dev_dbg(musb->controller, "<== hw %d rxcsr %04x, urb actual %d (+dma %zu)\n",
 		epnum, rx_csr, urb->actual_length,
 		dma ? dma->actual_len : 0);
 
 	/* check for errors, concurrent stall & unlink is not really
 	 * handled yet! */
 	if (rx_csr & MUSB_RXCSR_H_RXSTALL) {
-		DBG(3, "RX end %d STALL\n", epnum);
+		dev_dbg(musb->controller, "RX end %d STALL\n", epnum);
 
 		/* stall; record URB status */
 		status = -EPIPE;
 
 	} else if (rx_csr & MUSB_RXCSR_H_ERROR) {
-		DBG(3, "end %d RX proto error\n", epnum);
+		dev_dbg(musb->controller, "end %d RX proto error\n", epnum);
 
 		status = -EPROTO;
 		musb_writeb(epio, MUSB_RXINTERVAL, 0);
@@ -1491,7 +1478,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	} else if (rx_csr & MUSB_RXCSR_DATAERROR) {
 
 		if (USB_ENDPOINT_XFER_ISOC != qh->type) {
-			DBG(6, "RX end %d NAK timeout\n", epnum);
+			dev_dbg(musb->controller, "RX end %d NAK timeout\n", epnum);
 
 			/* NOTE: NAKing is *NOT* an error, so we want to
 			 * continue.  Except ... if there's a request for
@@ -1514,12 +1501,12 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 			goto finish;
 		} else {
-			DBG(4, "RX end %d ISO data error\n", epnum);
+			dev_dbg(musb->controller, "RX end %d ISO data error\n", epnum);
 			/* packet error reported later */
 			iso_err = true;
 		}
 	} else if (rx_csr & MUSB_RXCSR_INCOMPRX) {
-		DBG(3, "end %d high bandwidth incomplete ISO packet RX\n",
+		dev_dbg(musb->controller, "end %d high bandwidth incomplete ISO packet RX\n",
 				epnum);
 		status = -EPROTO;
 	}
@@ -1565,7 +1552,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			done = true;
 		}
 
-		DBG(2, "RXCSR%d %04x, reqpkt, len %zu%s\n", epnum, rx_csr,
+		dev_dbg(musb->controller, "RXCSR%d %04x, reqpkt, len %zu%s\n", epnum, rx_csr,
 				xfer_len, dma ? ", dma" : "");
 		rx_csr &= ~MUSB_RXCSR_H_REQPKT;
 
@@ -1615,7 +1602,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 				MUSB_RXCSR_H_WZC_BITS | val);
 		}
 
-		DBG(4, "ep %d dma %s, rxcsr %04x, rxcount %d\n", epnum,
+		dev_dbg(musb->controller, "ep %d dma %s, rxcsr %04x, rxcount %d\n", epnum,
 			done ? "off" : "reset",
 			musb_readw(epio, MUSB_RXCSR),
 			musb_readw(epio, MUSB_RXCOUNT));
@@ -1648,7 +1635,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 			rx_count = musb_readw(epio, MUSB_RXCOUNT);
 
-			DBG(2, "RX%d count %d, buffer 0x%x len %d/%d\n",
+			dev_dbg(musb->controller, "RX%d count %d, buffer 0x%x len %d/%d\n",
 					epnum, rx_count,
 					urb->transfer_dma
 						+ urb->actual_length,
@@ -1672,7 +1659,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 						d_status = -EOVERFLOW;
 						urb->error_count++;
 					}
-					DBG(2, "** OVERFLOW %d into %d\n",\
+					dev_dbg(musb->controller, "** OVERFLOW %d into %d\n",\
 					    rx_count, d->length);
 
 					length = d->length;
@@ -1760,7 +1747,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			usb_hcd_unmap_urb_for_dma(musb_to_hcd(musb), urb);
 			done = musb_host_packet_rx(musb, urb,
 					epnum, iso_err);
-			DBG(6, "read %spacket\n", done ? "last " : "");
+			dev_dbg(musb->controller, "read %spacket\n", done ? "last " : "");
 		}
 	}
 
@@ -1881,7 +1868,7 @@ static int musb_schedule(
 	idle = 1;
 	qh->mux = 0;
 	hw_ep = musb->endpoints + best_end;
-	DBG(4, "qh %p periodic slot %d\n", qh, best_end);
+	dev_dbg(musb->controller, "qh %p periodic slot %d\n", qh, best_end);
 success:
 	if (head) {
 		idle = list_empty(head);
@@ -2087,6 +2074,7 @@ done:
 static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh)
 {
 	struct musb_hw_ep	*ep = qh->hw_ep;
+	struct musb		*musb = ep->musb;
 	void __iomem		*epio = ep->regs;
 	unsigned		hw_end = ep->epnum;
 	void __iomem		*regs = ep->musb->mregs;
@@ -2102,7 +2090,7 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh)
 		dma = is_in ? ep->rx_channel : ep->tx_channel;
 		if (dma) {
 			status = ep->musb->dma_controller->channel_abort(dma);
-			DBG(status ? 1 : 3,
+			dev_dbg(musb->controller,
 				"abort %cX%d DMA for urb %p --> %d\n",
 				is_in ? 'R' : 'T', ep->epnum,
 				urb, status);
@@ -2149,7 +2137,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	int			is_in  = usb_pipein(urb->pipe);
 	int			ret;
 
-	DBG(4, "urb=%p, dev%d ep%d%s\n", urb,
+	dev_dbg(musb->controller, "urb=%p, dev%d ep%d%s\n", urb,
 			usb_pipedevice(urb->pipe),
 			usb_pipeendpoint(urb->pipe),
 			is_in ? "in" : "out");
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index 489104a..23e0cdc 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -74,7 +74,7 @@ static void musb_port_suspend(struct musb *musb, bool do_suspend)
 				break;
 		}
 
-		DBG(3, "Root port suspended, power %02x\n", power);
+		dev_dbg(musb->controller, "Root port suspended, power %02x\n", power);
 
 		musb->port1_status |= USB_PORT_STAT_SUSPEND;
 		switch (musb->xceiv->state) {
@@ -97,7 +97,7 @@ static void musb_port_suspend(struct musb *musb, bool do_suspend)
 			break;
 #endif
 		default:
-			DBG(1, "bogus rh suspend? %s\n",
+			dev_dbg(musb->controller, "bogus rh suspend? %s\n",
 				otg_state_string(musb));
 		}
 	} else if (power & MUSB_POWER_SUSPENDM) {
@@ -105,7 +105,7 @@ static void musb_port_suspend(struct musb *musb, bool do_suspend)
 		power |= MUSB_POWER_RESUME;
 		musb_writeb(mbase, MUSB_POWER, power);
 
-		DBG(3, "Root port resuming, power %02x\n", power);
+		dev_dbg(musb->controller, "Root port resuming, power %02x\n", power);
 
 		/* later, GetPortStatus will stop RESUME signaling */
 		musb->port1_status |= MUSB_PORT_STAT_RESUME;
@@ -120,7 +120,7 @@ static void musb_port_reset(struct musb *musb, bool do_reset)
 
 #ifdef CONFIG_USB_MUSB_OTG
 	if (musb->xceiv->state == OTG_STATE_B_IDLE) {
-		DBG(2, "HNP: Returning from HNP; no hub reset from b_idle\n");
+		dev_dbg(musb->controller, "HNP: Returning from HNP; no hub reset from b_idle\n");
 		musb->port1_status &= ~USB_PORT_STAT_RESET;
 		return;
 	}
@@ -159,7 +159,7 @@ static void musb_port_reset(struct musb *musb, bool do_reset)
 		musb->port1_status &= ~USB_PORT_STAT_ENABLE;
 		musb->rh_timer = jiffies + msecs_to_jiffies(50);
 	} else {
-		DBG(4, "root port reset stopped\n");
+		dev_dbg(musb->controller, "root port reset stopped\n");
 		musb_writeb(mbase, MUSB_POWER,
 				power & ~MUSB_POWER_RESET);
 
@@ -167,7 +167,7 @@ static void musb_port_reset(struct musb *musb, bool do_reset)
 
 		power = musb_readb(mbase, MUSB_POWER);
 		if (power & MUSB_POWER_HSMODE) {
-			DBG(4, "high-speed device connected\n");
+			dev_dbg(musb->controller, "high-speed device connected\n");
 			musb->port1_status |= USB_PORT_STAT_HIGH_SPEED;
 		}
 
@@ -208,7 +208,7 @@ void musb_root_disconnect(struct musb *musb)
 		musb->xceiv->state = OTG_STATE_B_IDLE;
 		break;
 	default:
-		DBG(1, "host disconnect (%s)\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "host disconnect (%s)\n", otg_state_string(musb));
 	}
 }
 
@@ -287,7 +287,7 @@ int musb_hub_control(
 		default:
 			goto error;
 		}
-		DBG(5, "clear feature %d\n", wValue);
+		dev_dbg(musb->controller, "clear feature %d\n", wValue);
 		musb->port1_status &= ~(1 << wValue);
 		break;
 	case GetHubDescriptor:
@@ -329,7 +329,7 @@ int musb_hub_control(
 
 			power = musb_readb(musb->mregs, MUSB_POWER);
 			power &= ~MUSB_POWER_RESUME;
-			DBG(4, "root port resume stopped, power %02x\n",
+			dev_dbg(musb->controller, "root port resume stopped, power %02x\n",
 					power);
 			musb_writeb(musb->mregs, MUSB_POWER, power);
 
@@ -352,7 +352,7 @@ int musb_hub_control(
 				(__le32 *) buf);
 
 		/* port change status is more interesting */
-		DBG(get_unaligned((u16 *)(buf+2)) ? 2 : 5, "port status %08x\n",
+		dev_dbg(musb->controller, "port status %08x\n",
 				musb->port1_status);
 		break;
 	case SetPortFeature:
@@ -423,7 +423,7 @@ int musb_hub_control(
 		default:
 			goto error;
 		}
-		DBG(5, "set feature %d\n", wValue);
+		dev_dbg(musb->controller, "set feature %d\n", wValue);
 		musb->port1_status |= 1 << wValue;
 		break;
 
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index d281792..f70c5a5 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -122,11 +122,12 @@ static void configure_channel(struct dma_channel *channel,
 {
 	struct musb_dma_channel *musb_channel = channel->private_data;
 	struct musb_dma_controller *controller = musb_channel->controller;
+	struct musb *musb = controller->private_data;
 	void __iomem *mbase = controller->base;
 	u8 bchannel = musb_channel->idx;
 	u16 csr = 0;
 
-	DBG(4, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
+	dev_dbg(musb->controller, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
 			channel, packet_sz, dma_addr, len, mode);
 
 	if (mode) {
@@ -161,7 +162,7 @@ static int dma_channel_program(struct dma_channel *channel,
 	struct musb_dma_controller *controller = musb_channel->controller;
 	struct musb *musb = controller->private_data;
 
-	DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
+	dev_dbg(musb->controller, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
 		musb_channel->epnum,
 		musb_channel->transmit ? "Tx" : "Rx",
 		packet_sz, dma_addr, len, mode);
@@ -274,7 +275,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 #endif
 
 	if (!int_hsdma) {
-		DBG(2, "spurious DMA irq\n");
+		dev_dbg(musb->controller, "spurious DMA irq\n");
 
 		for (bchannel = 0; bchannel < MUSB_HSDMA_CHANNELS; bchannel++) {
 			musb_channel = (struct musb_dma_channel *)
@@ -288,7 +289,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 			}
 		}
 
-		DBG(2, "int_hsdma = 0x%x\n", int_hsdma);
+		dev_dbg(musb->controller, "int_hsdma = 0x%x\n", int_hsdma);
 
 		if (!int_hsdma)
 			goto done;
@@ -315,7 +316,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 				channel->actual_len = addr
 					- musb_channel->start_addr;
 
-				DBG(2, "ch %p, 0x%x -> 0x%x (%zu / %d) %s\n",
+				dev_dbg(musb->controller, "ch %p, 0x%x -> 0x%x (%zu / %d) %s\n",
 					channel, musb_channel->start_addr,
 					addr, channel->actual_len,
 					musb_channel->len,
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index e9e60b6..3e11c59 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -76,7 +76,7 @@ static void musb_do_idle(unsigned long _musb)
 		if (musb->port1_status & MUSB_PORT_STAT_RESUME) {
 			power = musb_readb(musb->mregs, MUSB_POWER);
 			power &= ~MUSB_POWER_RESUME;
-			DBG(1, "root port resume stopped, power %02x\n", power);
+			dev_dbg(musb->controller, "root port resume stopped, power %02x\n", power);
 			musb_writeb(musb->mregs, MUSB_POWER, power);
 			musb->is_active = 1;
 			musb->port1_status &= ~(USB_PORT_STAT_SUSPEND
@@ -114,7 +114,7 @@ static void omap2430_musb_try_idle(struct musb *musb, unsigned long timeout)
 	/* Never idle if active, or when VBUS timeout is not set as host */
 	if (musb->is_active || ((musb->a_wait_bcon == 0)
 			&& (musb->xceiv->state == OTG_STATE_A_WAIT_BCON))) {
-		DBG(4, "%s active, deleting timer\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "%s active, deleting timer\n", otg_state_string(musb));
 		del_timer(&musb_idle_timer);
 		last_timer = jiffies;
 		return;
@@ -124,13 +124,13 @@ static void omap2430_musb_try_idle(struct musb *musb, unsigned long timeout)
 		if (!timer_pending(&musb_idle_timer))
 			last_timer = timeout;
 		else {
-			DBG(4, "Longer idle timer already pending, ignoring\n");
+			dev_dbg(musb->controller, "Longer idle timer already pending, ignoring\n");
 			return;
 		}
 	}
 	last_timer = timeout;
 
-	DBG(4, "%s inactive, for idle timer for %lu ms\n",
+	dev_dbg(musb->controller, "%s inactive, for idle timer for %lu ms\n",
 		otg_state_string(musb),
 		(unsigned long)jiffies_to_msecs(timeout - jiffies));
 	mod_timer(&musb_idle_timer, timeout);
@@ -193,7 +193,7 @@ static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
 	}
 	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
 
-	DBG(1, "VBUS %s, devctl %02x "
+	dev_dbg(musb->controller, "VBUS %s, devctl %02x "
 		/* otg %3x conf %08x prcm %08x */ "\n",
 		otg_state_string(musb),
 		musb_readb(musb->mregs, MUSB_DEVCTL));
@@ -239,7 +239,7 @@ static int musb_otg_notifications(struct notifier_block *nb,
 
 	switch (event) {
 	case USB_EVENT_ID:
-		DBG(4, "ID GND\n");
+		dev_dbg(musb->controller, "ID GND\n");
 
 		if (is_otg_enabled(musb)) {
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
@@ -257,7 +257,7 @@ static int musb_otg_notifications(struct notifier_block *nb,
 		break;
 
 	case USB_EVENT_VBUS:
-		DBG(4, "VBUS Connect\n");
+		dev_dbg(musb->controller, "VBUS Connect\n");
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 		if (musb->gadget_driver)
@@ -267,7 +267,7 @@ static int musb_otg_notifications(struct notifier_block *nb,
 		break;
 
 	case USB_EVENT_NONE:
-		DBG(4, "VBUS Disconnect\n");
+		dev_dbg(musb->controller, "VBUS Disconnect\n");
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 		if (is_otg_enabled(musb) || is_peripheral_enabled(musb))
@@ -285,7 +285,7 @@ static int musb_otg_notifications(struct notifier_block *nb,
 		otg_shutdown(musb->xceiv);
 		break;
 	default:
-		DBG(4, "ID float\n");
+		dev_dbg(musb->controller, "ID float\n");
 		return NOTIFY_DONE;
 	}
 
@@ -339,7 +339,7 @@ static int omap2430_musb_init(struct musb *musb)
 	status = otg_register_notifier(musb->xceiv, &musb->nb);
 
 	if (status)
-		DBG(1, "notification register failed\n");
+		dev_dbg(musb->controller, "notification register failed\n");
 
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index c47aac4..3f12f8d 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -106,7 +106,7 @@ static void tusb_wbus_quirk(struct musb *musb, int enabled)
 		tmp = phy_otg_ena & ~WBUS_QUIRK_MASK;
 		tmp |= TUSB_PHY_OTG_CTRL_WRPROTECT | TUSB_PHY_OTG_CTRL_TESTM2;
 		musb_writel(tbase, TUSB_PHY_OTG_CTRL_ENABLE, tmp);
-		DBG(2, "Enabled tusb wbus quirk ctrl %08x ena %08x\n",
+		dev_dbg(musb->controller, "Enabled tusb wbus quirk ctrl %08x ena %08x\n",
 			musb_readl(tbase, TUSB_PHY_OTG_CTRL),
 			musb_readl(tbase, TUSB_PHY_OTG_CTRL_ENABLE));
 	} else if (musb_readl(tbase, TUSB_PHY_OTG_CTRL_ENABLE)
@@ -115,7 +115,7 @@ static void tusb_wbus_quirk(struct musb *musb, int enabled)
 		musb_writel(tbase, TUSB_PHY_OTG_CTRL, tmp);
 		tmp = TUSB_PHY_OTG_CTRL_WRPROTECT | phy_otg_ena;
 		musb_writel(tbase, TUSB_PHY_OTG_CTRL_ENABLE, tmp);
-		DBG(2, "Disabled tusb wbus quirk ctrl %08x ena %08x\n",
+		dev_dbg(musb->controller, "Disabled tusb wbus quirk ctrl %08x ena %08x\n",
 			musb_readl(tbase, TUSB_PHY_OTG_CTRL),
 			musb_readl(tbase, TUSB_PHY_OTG_CTRL_ENABLE));
 		phy_otg_ctrl = 0;
@@ -178,7 +178,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf)
 
 	prefetch(buf);
 
-	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
+	dev_dbg(musb->controller, "%cX ep%d fifo %p count %d buf %p\n",
 			'T', epnum, fifo, len, buf);
 
 	if (epnum)
@@ -225,7 +225,7 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *buf)
 	void __iomem	*fifo = hw_ep->fifo;
 	u8		epnum = hw_ep->epnum;
 
-	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
+	dev_dbg(musb->controller, "%cX ep%d fifo %p count %d buf %p\n",
 			'R', epnum, fifo, len, buf);
 
 	if (epnum)
@@ -304,7 +304,7 @@ static int tusb_draw_power(struct otg_transceiver *x, unsigned mA)
 	}
 	musb_writel(tbase, TUSB_PRCM_MNGMT, reg);
 
-	DBG(2, "draw max %d mA VBUS\n", mA);
+	dev_dbg(musb->controller, "draw max %d mA VBUS\n", mA);
 	return 0;
 }
 
@@ -374,7 +374,7 @@ static void tusb_allow_idle(struct musb *musb, u32 wakeup_enables)
 	reg |= TUSB_PRCM_MNGMT_PM_IDLE | TUSB_PRCM_MNGMT_DEV_IDLE;
 	musb_writel(tbase, TUSB_PRCM_MNGMT, reg);
 
-	DBG(6, "idle, wake on %02x\n", wakeup_enables);
+	dev_dbg(musb->controller, "idle, wake on %02x\n", wakeup_enables);
 }
 
 /*
@@ -421,7 +421,7 @@ static void musb_do_idle(unsigned long _musb)
 		if ((musb->a_wait_bcon != 0)
 			&& (musb->idle_timeout == 0
 				|| time_after(jiffies, musb->idle_timeout))) {
-			DBG(4, "Nothing connected %s, turning off VBUS\n",
+			dev_dbg(musb->controller, "Nothing connected %s, turning off VBUS\n",
 					otg_state_string(musb));
 		}
 		/* FALLTHROUGH */
@@ -481,7 +481,7 @@ static void tusb_musb_try_idle(struct musb *musb, unsigned long timeout)
 	/* Never idle if active, or when VBUS timeout is not set as host */
 	if (musb->is_active || ((musb->a_wait_bcon == 0)
 			&& (musb->xceiv->state == OTG_STATE_A_WAIT_BCON))) {
-		DBG(4, "%s active, deleting timer\n", otg_state_string(musb));
+		dev_dbg(musb->controller, "%s active, deleting timer\n", otg_state_string(musb));
 		del_timer(&musb_idle_timer);
 		last_timer = jiffies;
 		return;
@@ -491,13 +491,13 @@ static void tusb_musb_try_idle(struct musb *musb, unsigned long timeout)
 		if (!timer_pending(&musb_idle_timer))
 			last_timer = timeout;
 		else {
-			DBG(4, "Longer idle timer already pending, ignoring\n");
+			dev_dbg(musb->controller, "Longer idle timer already pending, ignoring\n");
 			return;
 		}
 	}
 	last_timer = timeout;
 
-	DBG(4, "%s inactive, for idle timer for %lu ms\n",
+	dev_dbg(musb->controller, "%s inactive, for idle timer for %lu ms\n",
 		otg_state_string(musb),
 		(unsigned long)jiffies_to_msecs(timeout - jiffies));
 	mod_timer(&musb_idle_timer, timeout);
@@ -572,7 +572,7 @@ static void tusb_musb_set_vbus(struct musb *musb, int is_on)
 	musb_writel(tbase, TUSB_DEV_CONF, conf);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
 
-	DBG(1, "VBUS %s, devctl %02x otg %3x conf %08x prcm %08x\n",
+	dev_dbg(musb->controller, "VBUS %s, devctl %02x otg %3x conf %08x prcm %08x\n",
 		otg_state_string(musb),
 		musb_readb(musb->mregs, MUSB_DEVCTL),
 		musb_readl(tbase, TUSB_DEV_OTG_STAT),
@@ -633,7 +633,7 @@ static int tusb_musb_set_mode(struct musb *musb, u8 musb_mode)
 #endif
 
 	default:
-		DBG(2, "Trying to set mode %i\n", musb_mode);
+		dev_dbg(musb->controller, "Trying to set mode %i\n", musb_mode);
 		return -EINVAL;
 	}
 
@@ -666,7 +666,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 			default_a = !(otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS);
 		else
 			default_a = is_host_enabled(musb);
-		DBG(2, "Default-%c\n", default_a ? 'A' : 'B');
+		dev_dbg(musb->controller, "Default-%c\n", default_a ? 'A' : 'B');
 		musb->xceiv->default_a = default_a;
 		tusb_musb_set_vbus(musb, default_a);
 
@@ -693,7 +693,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 #endif
 
 			if (otg_stat & TUSB_DEV_OTG_STAT_SESS_END) {
-				DBG(1, "Forcing disconnect (no interrupt)\n");
+				dev_dbg(musb->controller, "Forcing disconnect (no interrupt)\n");
 				if (musb->xceiv->state != OTG_STATE_B_IDLE) {
 					/* INTR_DISCONNECT can hide... */
 					musb->xceiv->state = OTG_STATE_B_IDLE;
@@ -701,18 +701,18 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 				}
 				musb->is_active = 0;
 			}
-			DBG(2, "vbus change, %s, otg %03x\n",
+			dev_dbg(musb->controller, "vbus change, %s, otg %03x\n",
 				otg_state_string(musb), otg_stat);
 			idle_timeout = jiffies + (1 * HZ);
 			schedule_work(&musb->irq_work);
 
 		} else /* A-dev state machine */ {
-			DBG(2, "vbus change, %s, otg %03x\n",
+			dev_dbg(musb->controller, "vbus change, %s, otg %03x\n",
 				otg_state_string(musb), otg_stat);
 
 			switch (musb->xceiv->state) {
 			case OTG_STATE_A_IDLE:
-				DBG(2, "Got SRP, turning on VBUS\n");
+				dev_dbg(musb->controller, "Got SRP, turning on VBUS\n");
 				musb_platform_set_vbus(musb, 1);
 
 				/* CONNECT can wake if a_wait_bcon is set */
@@ -756,7 +756,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 	if (int_src & TUSB_INT_SRC_OTG_TIMEOUT) {
 		u8	devctl;
 
-		DBG(4, "%s timer, %03x\n", otg_state_string(musb), otg_stat);
+		dev_dbg(musb->controller, "%s timer, %03x\n", otg_state_string(musb), otg_stat);
 
 		switch (musb->xceiv->state) {
 		case OTG_STATE_A_WAIT_VRISE:
@@ -767,7 +767,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 			if (otg_stat & TUSB_DEV_OTG_STAT_VBUS_VALID) {
 				if ((devctl & MUSB_DEVCTL_VBUS)
 						!= MUSB_DEVCTL_VBUS) {
-					DBG(2, "devctl %02x\n", devctl);
+					dev_dbg(musb->controller, "devctl %02x\n", devctl);
 					break;
 				}
 				musb->xceiv->state = OTG_STATE_A_WAIT_BCON;
@@ -812,7 +812,7 @@ static irqreturn_t tusb_musb_interrupt(int irq, void *__hci)
 	musb_writel(tbase, TUSB_INT_MASK, ~TUSB_INT_MASK_RESERVED_BITS);
 
 	int_src = musb_readl(tbase, TUSB_INT_SRC) & ~TUSB_INT_SRC_RESERVED_BITS;
-	DBG(3, "TUSB IRQ %08x\n", int_src);
+	dev_dbg(musb->controller, "TUSB IRQ %08x\n", int_src);
 
 	musb->int_usb = (u8) int_src;
 
@@ -833,7 +833,7 @@ static irqreturn_t tusb_musb_interrupt(int irq, void *__hci)
 			reg = musb_readl(tbase, TUSB_SCRATCH_PAD);
 			if (reg == i)
 				break;
-			DBG(6, "TUSB NOR not ready\n");
+			dev_dbg(musb->controller, "TUSB NOR not ready\n");
 		}
 
 		/* work around issue 13 (2nd half) */
@@ -845,7 +845,7 @@ static irqreturn_t tusb_musb_interrupt(int irq, void *__hci)
 			musb->is_active = 1;
 			schedule_work(&musb->irq_work);
 		}
-		DBG(3, "wake %sactive %02x\n",
+		dev_dbg(musb->controller, "wake %sactive %02x\n",
 				musb->is_active ? "" : "in", reg);
 
 		/* REVISIT host side TUSB_PRCM_WHOSTDISCON, TUSB_PRCM_WBUS */
@@ -867,7 +867,7 @@ static irqreturn_t tusb_musb_interrupt(int irq, void *__hci)
 		u32	dma_src = musb_readl(tbase, TUSB_DMA_INT_SRC);
 		u32	real_dma_src = musb_readl(tbase, TUSB_DMA_INT_MASK);
 
-		DBG(3, "DMA IRQ %08x\n", dma_src);
+		dev_dbg(musb->controller, "DMA IRQ %08x\n", dma_src);
 		real_dma_src = ~real_dma_src & dma_src;
 		if (tusb_dma_omap() && real_dma_src) {
 			int	tx_source = (real_dma_src & 0xffff);
@@ -875,7 +875,7 @@ static irqreturn_t tusb_musb_interrupt(int irq, void *__hci)
 
 			for (i = 1; i <= 15; i++) {
 				if (tx_source & (1 << i)) {
-					DBG(3, "completing ep%i %s\n", i, "tx");
+					dev_dbg(musb->controller, "completing ep%i %s\n", i, "tx");
 					musb_dma_completion(musb, i, 1);
 				}
 			}
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 99cb541..c784e6c 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -65,7 +65,7 @@ static int tusb_omap_dma_start(struct dma_controller *c)
 
 	tusb_dma = container_of(c, struct tusb_omap_dma, controller);
 
-	/* DBG(3, "ep%i ch: %i\n", chdat->epnum, chdat->ch); */
+	/* dev_dbg(musb->controller, "ep%i ch: %i\n", chdat->epnum, chdat->ch); */
 
 	return 0;
 }
@@ -76,7 +76,7 @@ static int tusb_omap_dma_stop(struct dma_controller *c)
 
 	tusb_dma = container_of(c, struct tusb_omap_dma, controller);
 
-	/* DBG(3, "ep%i ch: %i\n", chdat->epnum, chdat->ch); */
+	/* dev_dbg(musb->controller, "ep%i ch: %i\n", chdat->epnum, chdat->ch); */
 
 	return 0;
 }
@@ -89,7 +89,7 @@ static inline int tusb_omap_use_shared_dmareq(struct tusb_omap_dma_ch *chdat)
 	u32		reg = musb_readl(chdat->tbase, TUSB_DMA_EP_MAP);
 
 	if (reg != 0) {
-		DBG(3, "ep%i dmareq0 is busy for ep%i\n",
+		dev_dbg(musb->controller, "ep%i dmareq0 is busy for ep%i\n",
 			chdat->epnum, reg & 0xf);
 		return -EAGAIN;
 	}
@@ -143,7 +143,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	if (ch_status != OMAP_DMA_BLOCK_IRQ)
 		printk(KERN_ERR "TUSB DMA error status: %i\n", ch_status);
 
-	DBG(3, "ep%i %s dma callback ch: %i status: %x\n",
+	dev_dbg(musb->controller, "ep%i %s dma callback ch: %i status: %x\n",
 		chdat->epnum, chdat->tx ? "tx" : "rx",
 		ch, ch_status);
 
@@ -156,7 +156,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 
 	/* HW issue #10: XFR_SIZE may get corrupt on DMA (both async & sync) */
 	if (unlikely(remaining > chdat->transfer_len)) {
-		DBG(2, "Corrupt %s dma ch%i XFR_SIZE: 0x%08lx\n",
+		dev_dbg(musb->controller, "Corrupt %s dma ch%i XFR_SIZE: 0x%08lx\n",
 			chdat->tx ? "tx" : "rx", chdat->ch,
 			remaining);
 		remaining = 0;
@@ -165,13 +165,13 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	channel->actual_len = chdat->transfer_len - remaining;
 	pio = chdat->len - channel->actual_len;
 
-	DBG(3, "DMA remaining %lu/%u\n", remaining, chdat->transfer_len);
+	dev_dbg(musb->controller, "DMA remaining %lu/%u\n", remaining, chdat->transfer_len);
 
 	/* Transfer remaining 1 - 31 bytes */
 	if (pio > 0 && pio < 32) {
 		u8	*buf;
 
-		DBG(3, "Using PIO for remaining %lu bytes\n", pio);
+		dev_dbg(musb->controller, "Using PIO for remaining %lu bytes\n", pio);
 		buf = phys_to_virt((u32)chdat->dma_addr) + chdat->transfer_len;
 		if (chdat->tx) {
 			dma_unmap_single(dev, chdat->dma_addr,
@@ -209,7 +209,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 		u16	csr;
 
 		if (chdat->tx) {
-			DBG(3, "terminating short tx packet\n");
+			dev_dbg(musb->controller, "terminating short tx packet\n");
 			musb_ep_select(mbase, chdat->epnum);
 			csr = musb_readw(hw_ep->regs, MUSB_TXCSR);
 			csr |= MUSB_TXCSR_MODE | MUSB_TXCSR_TXPKTRDY
@@ -264,7 +264,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 
 	dma_remaining = TUSB_EP_CONFIG_XFR_SIZE(dma_remaining);
 	if (dma_remaining) {
-		DBG(2, "Busy %s dma ch%i, not using: %08x\n",
+		dev_dbg(musb->controller, "Busy %s dma ch%i, not using: %08x\n",
 			chdat->tx ? "tx" : "rx", chdat->ch,
 			dma_remaining);
 		return false;
@@ -283,7 +283,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 		sync_dev = chdat->sync_dev;
 	} else {
 		if (tusb_omap_use_shared_dmareq(chdat) != 0) {
-			DBG(3, "could not get dma for ep%i\n", chdat->epnum);
+			dev_dbg(musb->controller, "could not get dma for ep%i\n", chdat->epnum);
 			return false;
 		}
 		if (tusb_dma->ch < 0) {
@@ -326,7 +326,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 
 	dma_params.frame_count	= chdat->transfer_len / 32; /* Burst sz frame */
 
-	DBG(3, "ep%i %s dma ch%i dma: %08x len: %u(%u) packet_sz: %i(%i)\n",
+	dev_dbg(musb->controller, "ep%i %s dma ch%i dma: %08x len: %u(%u) packet_sz: %i(%i)\n",
 		chdat->epnum, chdat->tx ? "tx" : "rx",
 		ch, dma_addr, chdat->transfer_len, len,
 		chdat->transfer_packet_sz, packet_sz);
@@ -370,7 +370,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 		dst_burst = OMAP_DMA_DATA_BURST_16;	/* 16x32 write */
 	}
 
-	DBG(3, "ep%i %s using %i-bit %s dma from 0x%08lx to 0x%08lx\n",
+	dev_dbg(musb->controller, "ep%i %s using %i-bit %s dma from 0x%08lx to 0x%08lx\n",
 		chdat->epnum, chdat->tx ? "tx" : "rx",
 		(dma_params.data_type == OMAP_DMA_DATA_TYPE_S32) ? 32 : 16,
 		((dma_addr & 0x3) == 0) ? "sync" : "async",
@@ -525,7 +525,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 
 	/* REVISIT: Why does dmareq5 not work? */
 	if (hw_ep->epnum == 0) {
-		DBG(3, "Not allowing DMA for ep0 %s\n", tx ? "tx" : "rx");
+		dev_dbg(musb->controller, "Not allowing DMA for ep0 %s\n", tx ? "tx" : "rx");
 		return NULL;
 	}
 
@@ -585,7 +585,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 		chdat->ch = -1;
 	}
 
-	DBG(3, "ep%i %s dma: %s dma%i dmareq%i sync%i\n",
+	dev_dbg(musb->controller, "ep%i %s dma: %s dma%i dmareq%i sync%i\n",
 		chdat->epnum,
 		chdat->tx ? "tx" : "rx",
 		chdat->ch >= 0 ? "dedicated" : "shared",
@@ -598,7 +598,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 free_dmareq:
 	tusb_omap_dma_free_dmareq(chdat);
 
-	DBG(3, "ep%i: Could not get a DMA channel\n", chdat->epnum);
+	dev_dbg(musb->controller, "ep%i: Could not get a DMA channel\n", chdat->epnum);
 	channel->status = MUSB_DMA_STATUS_UNKNOWN;
 
 	return NULL;
@@ -611,7 +611,7 @@ static void tusb_omap_dma_release(struct dma_channel *channel)
 	void __iomem		*tbase = musb->ctrl_base;
 	u32			reg;
 
-	DBG(3, "ep%i ch%i\n", chdat->epnum, chdat->ch);
+	dev_dbg(musb->controller, "ep%i ch%i\n", chdat->epnum, chdat->ch);
 
 	reg = musb_readl(tbase, TUSB_DMA_INT_MASK);
 	if (chdat->tx)
-- 
1.7.4.1.343.ga91df

