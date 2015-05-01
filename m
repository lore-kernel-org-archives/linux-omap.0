From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] usb: musb: Fix up DMA related macros
Date: Fri,  1 May 2015 12:29:27 -0700
Message-ID: <1430508578-5208-2-git-send-email-tony@atomide.com>
References: <1430508578-5208-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ftx-008-i770.relay.mailchannels.net ([50.61.143.70]:3022 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750923AbbEATaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2015 15:30:04 -0400
In-Reply-To: <1430508578-5208-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Bin Liu <b-liu@ti.com>, George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Pass struct musb to tusb_dma_omap() and is_cppi_enabled(),
and add macros for the other DMA controllers. Populate the
platform specific quirks with the DMA type and use it during
runtime.

Note that platform glue layers with no custom DMA code are
tagged with MUSB_DMA_INVENTRA which may have a chance of
working. Looks like the defconfigs for these use PIO_ONLY,
so this should not break existing configs.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/am35x.c       |  2 +-
 drivers/usb/musb/blackfin.c    |  1 +
 drivers/usb/musb/da8xx.c       |  2 +-
 drivers/usb/musb/davinci.c     |  3 ++-
 drivers/usb/musb/jz4740.c      |  2 +-
 drivers/usb/musb/musb_core.c   |  2 +-
 drivers/usb/musb/musb_dma.h    | 35 ++++++++++++++++++++++++++++++-----
 drivers/usb/musb/musb_dsps.c   |  2 +-
 drivers/usb/musb/musb_gadget.c |  8 ++++----
 drivers/usb/musb/musb_host.c   | 10 +++++-----
 drivers/usb/musb/omap2430.c    |  1 +
 drivers/usb/musb/tusb6010.c    |  4 ++--
 drivers/usb/musb/tusb6010.h    |  6 ------
 drivers/usb/musb/ux500.c       |  2 +-
 14 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 220fd4d..72ce2e8 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -438,7 +438,7 @@ static void am35x_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 }
 
 static const struct musb_platform_ops am35x_ops = {
-	.quirks		= MUSB_INDEXED_EP,
+	.quirks		= MUSB_DMA_INVENTRA | MUSB_INDEXED_EP,
 	.init		= am35x_musb_init,
 	.exit		= am35x_musb_exit,
 
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 6123b74..2a73a73 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -465,6 +465,7 @@ static int bfin_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops bfin_ops = {
+	.quirks		= MUSB_DMA_INVENTRA,
 	.init		= bfin_musb_init,
 	.exit		= bfin_musb_exit,
 
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 9a9c82a..06c442c 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -458,7 +458,7 @@ static int da8xx_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops da8xx_ops = {
-	.quirks		= MUSB_INDEXED_EP,
+	.quirks		= MUSB_DMA_CPPI | MUSB_INDEXED_EP,
 	.init		= da8xx_musb_init,
 	.exit		= da8xx_musb_exit,
 
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 3c1d9b2..26bfdb3 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -284,7 +284,7 @@ static irqreturn_t davinci_musb_interrupt(int irq, void *__hci)
 	 * mask, state, "vector", and EOI registers.
 	 */
 	cppi = container_of(musb->dma_controller, struct cppi, controller);
-	if (is_cppi_enabled() && musb->dma_controller && !cppi->irq)
+	if (is_cppi_enabled(musb) && musb->dma_controller && !cppi->irq)
 		retval = cppi_interrupt(irq, __hci);
 
 	/* ack and handle non-CPPI interrupts */
@@ -491,6 +491,7 @@ static int davinci_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops davinci_ops = {
+	.quirks		= MUSB_DMA_CPPI,
 	.init		= davinci_musb_init,
 	.exit		= davinci_musb_exit,
 
diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index bb7b263..b7b5fdc 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -106,7 +106,7 @@ static int jz4740_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops jz4740_musb_ops = {
-	.quirks		= MUSB_INDEXED_EP,
+	.quirks		= MUSB_DMA_INVENTRA | MUSB_INDEXED_EP,
 	.fifo_mode	= 2,
 	.init		= jz4740_musb_init,
 	.exit		= jz4740_musb_exit,
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 3789b08..4ac060a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1659,7 +1659,7 @@ void musb_dma_completion(struct musb *musb, u8 epnum, u8 transmit)
 
 	if (!epnum) {
 #ifndef CONFIG_USB_TUSB_OMAP_DMA
-		if (!is_cppi_enabled()) {
+		if (!is_cppi_enabled(musb)) {
 			/* endpoint 0 */
 			if (is_host_active(musb))
 				musb_h_ep0_irq(musb);
diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 1d44faa..555f2ae 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -68,16 +68,41 @@ struct musb_hw_ep;
 #define	is_dma_capable()	(1)
 #endif
 
-#if defined(CONFIG_USB_TI_CPPI_DMA) || defined(CONFIG_USB_TI_CPPI41_DMA)
-#define	is_cppi_enabled()	1
+#ifdef CONFIG_USB_UX500_DMA
+#define musb_dma_ux500(musb)		(musb->io.quirks & MUSB_DMA_UX500)
+#else
+#define musb_dma_ux500(musb)		0
+#endif
+
+#ifdef CONFIG_USB_TI_CPPI41_DMA
+#define musb_dma_cppi41(musb)		(musb->io.quirks & MUSB_DMA_CPPI41)
+#else
+#define musb_dma_cppi41(musb)		0
+#endif
+
+#ifdef CONFIG_USB_TI_CPPI_DMA
+#define musb_dma_cppi(musb)		(musb->io.quirks & MUSB_DMA_CPPI)
 #else
-#define	is_cppi_enabled()	0
+#define musb_dma_cppi(musb)		0
 #endif
 
 #ifdef CONFIG_USB_TUSB_OMAP_DMA
-#define tusb_dma_omap()			1
+#define tusb_dma_omap(musb)		(musb->io.quirks & MUSB_DMA_TUSB_OMAP)
+#else
+#define tusb_dma_omap(musb)		0
+#endif
+
+#ifdef CONFIG_USB_INVENTRA_DMA
+#define musb_dma_inventra(musb)		(musb->io.quirks & MUSB_DMA_INVENTRA)
+#else
+#define musb_dma_inventra(musb)		0
+#endif
+
+#if defined(CONFIG_USB_TI_CPPI_DMA) || defined(CONFIG_USB_TI_CPPI41_DMA)
+#define	is_cppi_enabled(musb)		\
+	(musb_dma_cppi(musb) || musb_dma_cppi41(musb))
 #else
-#define tusb_dma_omap()			0
+#define	is_cppi_enabled(musb)	0
 #endif
 
 /* Anomaly 05000456 - USB Receive Interrupt Is Not Generated in DMA Mode 1
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 65d931a..63a8d5b 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -634,7 +634,7 @@ static void dsps_read_fifo32(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 }
 
 static struct musb_platform_ops dsps_ops = {
-	.quirks		= MUSB_INDEXED_EP,
+	.quirks		= MUSB_DMA_CPPI41 | MUSB_INDEXED_EP,
 	.init		= dsps_musb_init,
 	.exit		= dsps_musb_exit,
 
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 4c481cd..a94db12 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -366,7 +366,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 		}
 
 #endif
-		if (is_cppi_enabled()) {
+		if (is_cppi_enabled(musb)) {
 			/* program endpoint CSR first, then setup DMA */
 			csr &= ~(MUSB_TXCSR_P_UNDERRUN | MUSB_TXCSR_TXPKTRDY);
 			csr |= MUSB_TXCSR_DMAENAB | MUSB_TXCSR_DMAMODE |
@@ -402,7 +402,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 				musb_writew(epio, MUSB_TXCSR, csr);
 				/* invariant: prequest->buf is non-null */
 			}
-		} else if (tusb_dma_omap())
+		} else if (tusb_dma_omap(musb))
 			use_dma = use_dma && c->channel_program(
 					musb_ep->dma, musb_ep->packet_sz,
 					request->zero,
@@ -595,7 +595,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 		return;
 	}
 
-	if (is_cppi_enabled() && is_buffer_mapped(req)) {
+	if (is_cppi_enabled(musb) && is_buffer_mapped(req)) {
 		struct dma_controller	*c = musb->dma_controller;
 		struct dma_channel	*channel = musb_ep->dma;
 
@@ -772,7 +772,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			fifo_count = min_t(unsigned, len, fifo_count);
 
 #ifdef	CONFIG_USB_TUSB_OMAP_DMA
-			if (tusb_dma_omap() && is_buffer_mapped(req)) {
+			if (tusb_dma_omap(musb) && is_buffer_mapped(req)) {
 				struct dma_controller *c = musb->dma_controller;
 				struct dma_channel *channel = musb_ep->dma;
 				u32 dma_addr = request->dma + request->actual;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index c3d5fc9..df982b9 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -181,7 +181,7 @@ static inline void musb_h_tx_dma_start(struct musb_hw_ep *ep)
 	/* NOTE: no locks here; caller should lock and select EP */
 	txcsr = musb_readw(ep->regs, MUSB_TXCSR);
 	txcsr |= MUSB_TXCSR_DMAENAB | MUSB_TXCSR_H_WZC_BITS;
-	if (is_cppi_enabled())
+	if (is_cppi_enabled(ep->musb))
 		txcsr |= MUSB_TXCSR_DMAMODE;
 	musb_writew(ep->regs, MUSB_TXCSR, txcsr);
 }
@@ -294,7 +294,7 @@ start:
 
 		if (!hw_ep->tx_channel)
 			musb_h_tx_start(hw_ep);
-		else if (is_cppi_enabled() || tusb_dma_omap())
+		else if (is_cppi_enabled(musb) || tusb_dma_omap(musb))
 			musb_h_tx_dma_start(hw_ep);
 	}
 }
@@ -656,7 +656,7 @@ static bool musb_tx_dma_program(struct dma_controller *dma,
 	channel->desired_mode = mode;
 	musb_writew(epio, MUSB_TXCSR, csr);
 #else
-	if (!is_cppi_enabled() && !tusb_dma_omap())
+	if (!is_cppi_enabled(hw_ep->musb) && !tusb_dma_omap(hw_ep->musb))
 		return false;
 
 	channel->actual_len = 0;
@@ -901,7 +901,7 @@ finish:
 
 		/* kick things off */
 
-		if ((is_cppi_enabled() || tusb_dma_omap()) && dma_channel) {
+		if ((is_cppi_enabled(musb) || tusb_dma_omap(musb)) && dma_channel) {
 			/* Candidate for DMA */
 			dma_channel->actual_len = 0L;
 			qh->segsize = len;
@@ -1441,7 +1441,7 @@ done:
 	} else if ((usb_pipeisoc(pipe) || transfer_pending) && dma) {
 		if (musb_tx_dma_program(musb->dma_controller, hw_ep, qh, urb,
 				offset, length)) {
-			if (is_cppi_enabled() || tusb_dma_omap())
+			if (is_cppi_enabled(musb) || tusb_dma_omap(musb))
 				musb_h_tx_dma_start(hw_ep);
 			return;
 		}
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index cc752d8..5546a22 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -493,6 +493,7 @@ static int omap2430_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops omap2430_ops = {
+	.quirks		= MUSB_DMA_INVENTRA,
 	.init		= omap2430_musb_init,
 	.exit		= omap2430_musb_exit,
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 3a5ffd5..af923de 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -890,7 +890,7 @@ static irqreturn_t tusb_musb_interrupt(int irq, void *__hci)
 
 		dev_dbg(musb->controller, "DMA IRQ %08x\n", dma_src);
 		real_dma_src = ~real_dma_src & dma_src;
-		if (tusb_dma_omap() && real_dma_src) {
+		if (tusb_dma_omap(musb) && real_dma_src) {
 			int	tx_source = (real_dma_src & 0xffff);
 			int	i;
 
@@ -1181,7 +1181,7 @@ static int tusb_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops tusb_ops = {
-	.quirks		= MUSB_IN_TUSB,
+	.quirks		= MUSB_DMA_TUSB_OMAP | MUSB_IN_TUSB,
 	.init		= tusb_musb_init,
 	.exit		= tusb_musb_exit,
 
diff --git a/drivers/usb/musb/tusb6010.h b/drivers/usb/musb/tusb6010.h
index aec86c8..72cdad2 100644
--- a/drivers/usb/musb/tusb6010.h
+++ b/drivers/usb/musb/tusb6010.h
@@ -12,12 +12,6 @@
 #ifndef __TUSB6010_H__
 #define __TUSB6010_H__
 
-#ifdef CONFIG_USB_TUSB_OMAP_DMA
-#define tusb_dma_omap()			1
-#else
-#define tusb_dma_omap()			0
-#endif
-
 /* VLYNQ control register. 32-bit at offset 0x000 */
 #define TUSB_VLYNQ_CTRL			0x004
 
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index abf7272..c6582f1 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -188,7 +188,7 @@ static int ux500_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops ux500_ops = {
-	.quirks		= MUSB_INDEXED_EP,
+	.quirks		= MUSB_DMA_UX500 | MUSB_INDEXED_EP,
 	.init		= ux500_musb_init,
 	.exit		= ux500_musb_exit,
 	.fifo_mode	= 5,
-- 
2.1.4

