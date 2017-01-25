From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 4/6] usb: musb: cppi_dma: Clean up cppi41_dma_controller structure
Date: Wed, 25 Jan 2017 11:17:07 +0100
Message-ID: <20170125101709.15696-5-abailon@baylibre.com>
References: <20170125101709.15696-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170125101709.15696-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

A pointer to musb is now present in the dma_controller structure.
Remove the one present in cppi41_dma_controller structure.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/musb_cppi41.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 1fe7eae..00e272b 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -30,7 +30,6 @@ struct cppi41_dma_controller {
 	struct dma_controller controller;
 	struct cppi41_dma_channel rx_channel[MUSB_DMA_NUM_CHANNELS];
 	struct cppi41_dma_channel tx_channel[MUSB_DMA_NUM_CHANNELS];
-	struct musb *musb;
 	struct hrtimer early_tx;
 	struct list_head early_tx_list;
 	u32 rx_mode;
@@ -45,7 +44,7 @@ static void save_rx_toggle(struct cppi41_dma_channel *cppi41_channel)
 
 	if (cppi41_channel->is_tx)
 		return;
-	if (!is_host_active(cppi41_channel->controller->musb))
+	if (!is_host_active(cppi41_channel->controller->controller.musb))
 		return;
 
 	csr = musb_readw(cppi41_channel->hw_ep->regs, MUSB_RXCSR);
@@ -78,8 +77,7 @@ static void update_rx_toggle(struct cppi41_dma_channel *cppi41_channel)
 	if (!toggle && toggle == cppi41_channel->usb_toggle) {
 		csr |= MUSB_RXCSR_H_DATATOGGLE | MUSB_RXCSR_H_WR_DATATOGGLE;
 		musb_writew(cppi41_channel->hw_ep->regs, MUSB_RXCSR, csr);
-		musb_dbg(cppi41_channel->controller->musb,
-				"Restoring DATA1 toggle.");
+		musb_dbg(musb, "Restoring DATA1 toggle.");
 	}
 
 	cppi41_channel->usb_toggle = toggle;
@@ -180,7 +178,7 @@ static enum hrtimer_restart cppi41_recheck_tx_req(struct hrtimer *timer)
 
 	controller = container_of(timer, struct cppi41_dma_controller,
 			early_tx);
-	musb = controller->musb;
+	musb = controller->controller.musb;
 
 	spin_lock_irqsave(&musb->lock, flags);
 	list_for_each_entry_safe(cppi41_channel, n, &controller->early_tx_list,
@@ -309,6 +307,7 @@ static void cppi41_set_dma_mode(struct cppi41_dma_channel *cppi41_channel,
 		unsigned mode)
 {
 	struct cppi41_dma_controller *controller = cppi41_channel->controller;
+	struct musb *musb = controller->controller.musb;
 	u32 port;
 	u32 new_mode;
 	u32 old_mode;
@@ -324,12 +323,10 @@ static void cppi41_set_dma_mode(struct cppi41_dma_channel *cppi41_channel,
 		return;
 	if (cppi41_channel->is_tx) {
 		controller->tx_mode = new_mode;
-		musb_writel(controller->musb->ctrl_base, USB_CTRL_TX_MODE,
-				new_mode);
+		musb_writel(musb->ctrl_base, USB_CTRL_TX_MODE, new_mode);
 	} else {
 		controller->rx_mode = new_mode;
-		musb_writel(controller->musb->ctrl_base, USB_CTRL_RX_MODE,
-				new_mode);
+		musb_writel(musb->ctrl_base, USB_CTRL_RX_MODE, new_mode);
 	}
 }
 
@@ -348,7 +345,8 @@ static void cppi41_set_autoreq_mode(struct cppi41_dma_channel *cppi41_channel,
 	if (new_mode == old_mode)
 		return;
 	controller->auto_req = new_mode;
-	musb_writel(controller->musb->ctrl_base, USB_CTRL_AUTOREQ, new_mode);
+	musb_writel(controller->controller.musb->ctrl_base, USB_CTRL_AUTOREQ,
+		    new_mode);
 }
 
 static bool cppi41_configure_channel(struct dma_channel *channel,
@@ -359,7 +357,7 @@ static bool cppi41_configure_channel(struct dma_channel *channel,
 	struct dma_chan *dc = cppi41_channel->dc;
 	struct dma_async_tx_descriptor *dma_desc;
 	enum dma_transfer_direction direction;
-	struct musb *musb = cppi41_channel->controller->musb;
+	struct musb *musb = cppi41_channel->controller->controller.musb;
 	unsigned use_gen_rndis = 0;
 
 	cppi41_channel->buf_addr = dma_addr;
@@ -472,7 +470,7 @@ static int cppi41_dma_channel_program(struct dma_channel *channel,
 	BUG_ON(channel->status == MUSB_DMA_STATUS_UNKNOWN ||
 		channel->status == MUSB_DMA_STATUS_BUSY);
 
-	if (is_host_active(cppi41_channel->controller->musb)) {
+	if (is_host_active(cppi41_channel->controller->controller.musb)) {
 		if (cppi41_channel->is_tx)
 			hb_mult = cppi41_channel->hw_ep->out_qh->hb_mult;
 		else
@@ -497,7 +495,7 @@ static int cppi41_is_compatible(struct dma_channel *channel, u16 maxpacket,
 {
 	struct cppi41_dma_channel *cppi41_channel = channel->private_data;
 	struct cppi41_dma_controller *controller = cppi41_channel->controller;
-	struct musb *musb = controller->musb;
+	struct musb *musb = controller->controller.musb;
 
 	if (is_host_active(musb)) {
 		WARN_ON(1);
@@ -515,7 +513,7 @@ static int cppi41_dma_channel_abort(struct dma_channel *channel)
 {
 	struct cppi41_dma_channel *cppi41_channel = channel->private_data;
 	struct cppi41_dma_controller *controller = cppi41_channel->controller;
-	struct musb *musb = controller->musb;
+	struct musb *musb = controller->controller.musb;
 	void __iomem *epio = cppi41_channel->hw_ep->regs;
 	int tdbit;
 	int ret;
@@ -600,7 +598,7 @@ static void cppi41_dma_controller_stop(struct cppi41_dma_controller *controller)
 
 static int cppi41_dma_controller_start(struct cppi41_dma_controller *controller)
 {
-	struct musb *musb = controller->musb;
+	struct musb *musb = controller->controller.musb;
 	struct device *dev = musb->controller;
 	struct device_node *np = dev->parent->of_node;
 	struct cppi41_dma_channel *cppi41_channel;
@@ -695,7 +693,6 @@ cppi41_dma_controller_create(struct musb *musb, void __iomem *base)
 	hrtimer_init(&controller->early_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	controller->early_tx.function = cppi41_recheck_tx_req;
 	INIT_LIST_HEAD(&controller->early_tx_list);
-	controller->musb = musb;
 
 	controller->controller.channel_alloc = cppi41_dma_channel_allocate;
 	controller->controller.channel_release = cppi41_dma_channel_release;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
