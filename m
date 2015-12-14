From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH V02 5/5] dmaengine: omap-dma: Add support for DMA filter mapping to slave devices
Date: Mon, 14 Dec 2015 13:22:20 +0200
Message-ID: <1450092140-31602-6-git-send-email-peter.ujfalusi@ti.com>
References: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Add support for providing device to filter_fn mapping so client drivers
can switch to use the dma_request_chan() API.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c   | 4 ++++
 include/linux/omap-dma.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index f86827ac0c8a..9794b073d7d7 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1153,6 +1153,10 @@ static int omap_dma_probe(struct platform_device *pdev)
 			return rc;
 	}
 
+	od->ddev.filter.map = od->plat->slave_map;
+	od->ddev.filter.mapcnt = od->plat->slavecnt;
+	od->ddev.filter.fn = omap_dma_filter_fn;
+
 	rc = dma_async_device_register(&od->ddev);
 	if (rc) {
 		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 88fa8af2b937..1d99b61adc65 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -267,6 +267,9 @@ struct omap_dma_reg {
 	u8	type;
 };
 
+#define SDMA_FILTER_PARAM(hw_req)	((int[]) { (hw_req) })
+struct dma_slave_map;
+
 /* System DMA platform data structure */
 struct omap_system_dma_plat_info {
 	const struct omap_dma_reg *reg_map;
@@ -278,6 +281,9 @@ struct omap_system_dma_plat_info {
 	void (*clear_dma)(int lch);
 	void (*dma_write)(u32 val, int reg, int lch);
 	u32 (*dma_read)(int reg, int lch);
+
+	const struct dma_slave_map *slave_map;
+	int slavecnt;
 };
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
-- 
2.6.4
