From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 02/11] dmaengine: cppi41: Split out the interrupt handler
Date: Mon,  9 Jan 2017 17:06:47 +0100
Message-ID: <20170109160656.3470-3-abailon@baylibre.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The current interrupt handler do some actions specifics to am335x.
These actions should be made by the platform interrupt handler.
Split out the interrupt handler in two:
one for the am335x platform and a generic one.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 25ee71d..42744ed 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -284,18 +284,11 @@ static u32 cppi41_pop_desc(struct cppi41_dd *cdd, unsigned queue_num)
 	return desc;
 }
 
-static irqreturn_t cppi41_irq(int irq, void *data)
+static irqreturn_t cppi41_irq(struct cppi41_dd *cdd)
 {
-	struct cppi41_dd *cdd = data;
 	struct cppi41_channel *c;
-	u32 status;
 	int i;
 
-	status = cppi_readl(cdd->usbss_mem + USBSS_IRQ_STATUS);
-	if (!(status & USBSS_IRQ_PD_COMP))
-		return IRQ_NONE;
-	cppi_writel(status, cdd->usbss_mem + USBSS_IRQ_STATUS);
-
 	for (i = QMGR_PENDING_SLOT_Q(FIST_COMPLETION_QUEUE); i < QMGR_NUM_PEND;
 			i++) {
 		u32 val;
@@ -351,6 +344,19 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t am335x_cppi41_irq(int irq, void *data)
+{
+	struct cppi41_dd *cdd = data;
+	u32 status;
+
+	status = cppi_readl(cdd->usbss_mem + USBSS_IRQ_STATUS);
+	if (!(status & USBSS_IRQ_PD_COMP))
+		return IRQ_NONE;
+	cppi_writel(status, cdd->usbss_mem + USBSS_IRQ_STATUS);
+
+	return cppi41_irq(cdd);
+}
+
 static dma_cookie_t cppi41_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	dma_cookie_t cookie;
@@ -949,7 +955,7 @@ static struct dma_chan *cppi41_dma_xlate(struct of_phandle_args *dma_spec,
 }
 
 static const struct cppi_glue_infos am335x_usb_infos = {
-	.isr = cppi41_irq,
+	.isr = am335x_cppi41_irq,
 	.queues_rx = am335x_usb_queues_rx,
 	.queues_tx = am335x_usb_queues_tx,
 	.td_queue = { .submit = 31, .complete = 0 },
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
