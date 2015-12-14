From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH V03 4/5] dmaengine: edma: Add support for DMA filter mapping to slave devices
Date: Mon, 14 Dec 2015 22:47:41 +0200
Message-ID: <1450126062-8063-5-git-send-email-peter.ujfalusi@ti.com>
References: <1450126062-8063-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450126062-8063-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Add support for providing device to filter_fn mapping so client drivers
can switch to use the dma_request_chan() API.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/edma.c                 | 4 ++++
 include/linux/platform_data/edma.h | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 16fe773fb846..2e8acde6b134 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2314,6 +2314,10 @@ static int edma_probe(struct platform_device *pdev)
 		edma_set_chmap(&ecc->slave_chans[i], ecc->dummy_slot);
 	}
 
+	ecc->dma_slave.filter.map = info->slave_map;
+	ecc->dma_slave.filter.mapcnt = info->slavecnt;
+	ecc->dma_slave.filter.fn = edma_filter_fn;
+
 	ret = dma_async_device_register(&ecc->dma_slave);
 	if (ret) {
 		dev_err(dev, "slave ddev registration failed (%d)\n", ret);
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 4299f4ba03bd..0a533f94438f 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -53,12 +53,16 @@ enum dma_event_q {
 #define EDMA_CTLR(i)			((i) >> 16)
 #define EDMA_CHAN_SLOT(i)		((i) & 0xffff)
 
+#define EDMA_FILTER_PARAM(ctlr, chan)	((int[]) { EDMA_CTLR_CHAN(ctlr, chan) })
+
 struct edma_rsv_info {
 
 	const s16	(*rsv_chans)[2];
 	const s16	(*rsv_slots)[2];
 };
 
+struct dma_slave_map;
+
 /* platform_data for EDMA driver */
 struct edma_soc_info {
 	/*
@@ -76,6 +80,9 @@ struct edma_soc_info {
 
 	s8	(*queue_priority_mapping)[2];
 	const s16	(*xbar_chans)[2];
+
+	const struct dma_slave_map *slave_map;
+	int slavecnt;
 };
 
 #endif
-- 
2.6.4
