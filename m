From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/3] dmaengine: cppi41: Implement the glue for DA8xx
Date: Tue, 17 Jan 2017 15:20:15 +0100
Message-ID: <20170117142016.11163-3-abailon@baylibre.com>
References: <20170117142016.11163-1-abailon@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117142016.11163-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The DA8xx has a CPPI 4.1 DMA controller.
This is add the glue layer required to make it work on DA8xx.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 0bc4f1a..aab1e5a 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -221,6 +221,20 @@ static const struct chan_queues am335x_usb_queues_rx[] = {
 	[29] = { .submit = 30, .complete = 155},
 };
 
+static const struct chan_queues da8xx_usb_queues_tx[] = {
+	[0] = { .submit =  16, .complete = 24},
+	[1] = { .submit =  18, .complete = 24},
+	[2] = { .submit =  20, .complete = 24},
+	[3] = { .submit =  22, .complete = 24},
+};
+
+static const struct chan_queues da8xx_usb_queues_rx[] = {
+	[0] = { .submit =  1, .complete = 26},
+	[1] = { .submit =  3, .complete = 26},
+	[2] = { .submit =  5, .complete = 26},
+	[3] = { .submit =  7, .complete = 26},
+};
+
 struct cppi_glue_infos {
 	irqreturn_t (*isr)(int irq, void *data);
 	const struct chan_queues *queues_rx;
@@ -962,8 +976,18 @@ static const struct cppi_glue_infos am335x_usb_infos = {
 	.qmgr_num_pend = 5,
 };
 
+static const struct cppi_glue_infos da8xx_usb_infos = {
+	.isr = cppi41_irq,
+	.queues_rx = da8xx_usb_queues_rx,
+	.queues_tx = da8xx_usb_queues_tx,
+	.td_queue = { .submit = 31, .complete = 0 },
+	.first_completion_queue = 24,
+	.qmgr_num_pend = 2,
+};
+
 static const struct of_device_id cppi41_dma_ids[] = {
 	{ .compatible = "ti,am3359-cppi41", .data = &am335x_usb_infos},
+	{ .compatible = "ti,da8xx-cppi41", .data = &da8xx_usb_infos},
 	{},
 };
 MODULE_DEVICE_TABLE(of, cppi41_dma_ids);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
