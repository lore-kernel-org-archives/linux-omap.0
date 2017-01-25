From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 3/6] usb: musb: cppi_dma: Clean up cppi structure
Date: Wed, 25 Jan 2017 11:17:06 +0100
Message-ID: <20170125101709.15696-4-abailon@baylibre.com>
References: <20170125101709.15696-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170125101709.15696-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

A pointer to musb is now present in the dma_controller structure.
Remove the one present in cppi structure.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/cppi_dma.c | 26 +++++++++++++-------------
 drivers/usb/musb/cppi_dma.h |  1 -
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index 1ae48e6..c4fabe95 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -224,7 +224,7 @@ static void cppi_controller_stop(struct cppi *controller)
 	int			i;
 	struct musb		*musb;
 
-	musb = controller->musb;
+	musb = controller->controller.musb;
 
 	tibase = controller->tibase;
 	/* DISABLE INDIVIDUAL CHANNEL Interrupts */
@@ -288,7 +288,7 @@ cppi_channel_allocate(struct dma_controller *c,
 
 	controller = container_of(c, struct cppi, controller);
 	tibase = controller->tibase;
-	musb = controller->musb;
+	musb = c->musb;
 
 	/* ep0 doesn't use DMA; remember cppi indices are 0..N-1 */
 	index = ep->epnum - 1;
@@ -336,7 +336,7 @@ static void cppi_channel_release(struct dma_channel *channel)
 	c = container_of(channel, struct cppi_channel, channel);
 	tibase = c->controller->tibase;
 	if (!c->hw_ep)
-		musb_dbg(c->controller->musb,
+		musb_dbg(c->controller->controller.musb,
 			"releasing idle DMA channel %p", c);
 	else if (!c->transmit)
 		core_rxirq_enable(tibase, c->index + 1);
@@ -355,7 +355,7 @@ cppi_dump_rx(int level, struct cppi_channel *c, const char *tag)
 
 	musb_ep_select(base, c->index + 1);
 
-	musb_dbg(c->controller->musb,
+	musb_dbg(c->controller->controller.musb,
 		"RX DMA%d%s: %d left, csr %04x, "
 		"%08x H%08x S%08x C%08x, "
 		"B%08x L%08x %08x .. %08x",
@@ -385,7 +385,7 @@ cppi_dump_tx(int level, struct cppi_channel *c, const char *tag)
 
 	musb_ep_select(base, c->index + 1);
 
-	musb_dbg(c->controller->musb,
+	musb_dbg(c->controller->controller.musb,
 		"TX DMA%d%s: csr %04x, "
 		"H%08x S%08x C%08x %08x, "
 		"F%08x L%08x .. %08x",
@@ -954,7 +954,7 @@ static int cppi_channel_program(struct dma_channel *ch,
 
 	cppi_ch = container_of(ch, struct cppi_channel, channel);
 	controller = cppi_ch->controller;
-	musb = controller->musb;
+	musb = controller->controller.musb;
 
 	switch (ch->status) {
 	case MUSB_DMA_STATUS_BUS_ABORT:
@@ -1009,7 +1009,7 @@ static bool cppi_rx_scan(struct cppi *cppi, unsigned ch)
 	int				i;
 	dma_addr_t			safe2ack;
 	void __iomem			*regs = rx->hw_ep->regs;
-	struct musb			*musb = cppi->musb;
+	struct musb			*musb = cppi->controller.musb;
 
 	cppi_dump_rx(6, rx, "/K");
 
@@ -1121,7 +1121,7 @@ static bool cppi_rx_scan(struct cppi *cppi, unsigned ch)
 		 * setting it here "should" be racey, but seems to work
 		 */
 		csr = musb_readw(rx->hw_ep->regs, MUSB_RXCSR);
-		if (is_host_active(cppi->musb)
+		if (is_host_active(cppi->controller.musb)
 				&& bd
 				&& !(csr & MUSB_RXCSR_H_REQPKT)) {
 			csr |= MUSB_RXCSR_H_REQPKT;
@@ -1311,7 +1311,7 @@ cppi_dma_controller_create(struct musb *musb, void __iomem *mregs)
 	controller->mregs = mregs;
 	controller->tibase = mregs - DAVINCI_BASE_OFFSET;
 
-	controller->musb = musb;
+	controller->controller.musb = musb;
 	controller->controller.channel_alloc = cppi_channel_allocate;
 	controller->controller.channel_release = cppi_channel_release;
 	controller->controller.channel_program = cppi_channel_program;
@@ -1323,7 +1323,7 @@ cppi_dma_controller_create(struct musb *musb, void __iomem *mregs)
 
 	/* setup BufferPool */
 	controller->pool = dma_pool_create("cppi",
-			controller->musb->controller,
+			controller->controller.musb->controller,
 			sizeof(struct cppi_descriptor),
 			CPPI_DESCRIPTOR_ALIGN, 0);
 	if (!controller->pool) {
@@ -1357,7 +1357,7 @@ void cppi_dma_controller_destroy(struct dma_controller *c)
 	cppi_controller_stop(cppi);
 
 	if (cppi->irq)
-		free_irq(cppi->irq, cppi->musb);
+		free_irq(cppi->irq, cppi->controller.musb);
 
 	/* assert:  caller stopped the controller first */
 	dma_pool_destroy(cppi->pool);
@@ -1469,7 +1469,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		core_rxirq_disable(tibase, cppi_ch->index + 1);
 
 		/* for host, ensure ReqPkt is never set again */
-		if (is_host_active(cppi_ch->controller->musb)) {
+		if (is_host_active(cppi_ch->controller->controller.musb)) {
 			value = musb_readl(tibase, DAVINCI_AUTOREQ_REG);
 			value &= ~((0x3) << (cppi_ch->index * 2));
 			musb_writel(tibase, DAVINCI_AUTOREQ_REG, value);
@@ -1478,7 +1478,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		csr = musb_readw(regs, MUSB_RXCSR);
 
 		/* for host, clear (just) ReqPkt at end of current packet(s) */
-		if (is_host_active(cppi_ch->controller->musb)) {
+		if (is_host_active(cppi_ch->controller->controller.musb)) {
 			csr |= MUSB_RXCSR_H_WZC_BITS;
 			csr &= ~MUSB_RXCSR_H_REQPKT;
 		} else
diff --git a/drivers/usb/musb/cppi_dma.h b/drivers/usb/musb/cppi_dma.h
index 7fdfb71..9bb7c5e 100644
--- a/drivers/usb/musb/cppi_dma.h
+++ b/drivers/usb/musb/cppi_dma.h
@@ -107,7 +107,6 @@ struct cppi_channel {
 /* CPPI DMA controller object */
 struct cppi {
 	struct dma_controller		controller;
-	struct musb			*musb;
 	void __iomem			*mregs;		/* Mentor regs */
 	void __iomem			*tibase;	/* TI/CPPI regs */
 
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
