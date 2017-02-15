From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 5/5] dmaengine: cppi41: Remove isr callback from glue layer
Date: Wed, 15 Feb 2017 14:56:36 +0100
Message-ID: <20170215135636.31427-6-abailon@baylibre.com>
References: <20170215135636.31427-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170215135636.31427-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

All the platform code to manage IRQ has been moved to MUSB,
and now the interrupt handler is completely generic.
Remove the isr callback that is not useful anymore.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 54337cd..4573080 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -224,7 +224,6 @@ static const struct chan_queues am335x_usb_queues_rx[] = {
 };
 
 struct cppi_glue_infos {
-	irqreturn_t (*isr)(int irq, void *data);
 	const struct chan_queues *queues_rx;
 	const struct chan_queues *queues_tx;
 	struct chan_queues td_queue;
@@ -965,7 +964,6 @@ static struct dma_chan *cppi41_dma_xlate(struct of_phandle_args *dma_spec,
 }
 
 static const struct cppi_glue_infos am335x_usb_infos = {
-	.isr = cppi41_irq,
 	.queues_rx = am335x_usb_queues_rx,
 	.queues_tx = am335x_usb_queues_tx,
 	.td_queue = { .submit = 31, .complete = 0 },
@@ -1075,7 +1073,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, glue_info->isr, IRQF_SHARED,
+	ret = devm_request_irq(&pdev->dev, irq, cppi41_irq, IRQF_SHARED,
 			dev_name(dev), cdd);
 	if (ret)
 		goto err_irq;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
