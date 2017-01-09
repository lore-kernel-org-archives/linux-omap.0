From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 05/11] dmaengine: cppi41: Add a way to test if the driver is running on am335x
Date: Mon,  9 Jan 2017 17:06:50 +0100
Message-ID: <20170109160656.3470-6-abailon@baylibre.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

As the cppi41 is present in different platform, the driver needs
to determine on which platform it is running to execute instructions
specific to this platform (such as configure IRQ on am335x).
Add a way to test if we are running on am335x.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 8d7965d..58b27ef 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -89,6 +89,8 @@
 /* Packet Descriptor */
 #define PD2_ZERO_LENGTH		(1 << 19)
 
+#define AM335X_CPPI41		0
+
 struct cppi41_channel {
 	struct dma_chan chan;
 	struct dma_async_tx_descriptor txd;
@@ -237,6 +239,7 @@ struct cppi_glue_infos {
 	struct chan_queues td_queue;
 	u16 first_completion_queue;
 	u16 qmgr_num_pend;
+	u8 platform;
 };
 
 static struct cppi41_channel *to_cpp41_chan(struct dma_chan *c)
@@ -966,6 +969,7 @@ static const struct cppi_glue_infos am335x_usb_infos = {
 	.td_queue = { .submit = 31, .complete = 0 },
 	.first_completion_queue = 93,
 	.qmgr_num_pend = 5,
+	.platform = AM335X_CPPI41,
 };
 
 static const struct of_device_id cppi41_dma_ids[] = {
@@ -984,6 +988,13 @@ static const struct cppi_glue_infos *get_glue_info(struct device *dev)
 	return of_id->data;
 }
 
+static int is_am335x_cppi41(struct device *dev)
+{
+	struct cppi41_dd *cdd = dev_get_drvdata(dev);
+
+	return cdd->platform == AM335X_CPPI41;
+}
+
 #define CPPI41_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
@@ -1045,6 +1056,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	cdd->td_queue = glue_info->td_queue;
 	cdd->qmgr_num_pend = glue_info->qmgr_num_pend;
 	cdd->first_completion_queue = glue_info->first_completion_queue;
+	cdd->platform = glue_info->platform;
 
 	ret = of_property_read_u32(dev->of_node,
 				   "#dma-channels", &cdd->n_chans);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
