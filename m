From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/9] dmaengine: edma: Add missing MODULE_DEVICE_TABLE() for of_device_id structs
Date: Wed, 21 Sep 2016 13:26:29 +0300
Message-ID: <20160921102637.24845-2-peter.ujfalusi@ti.com>
References: <20160921102637.24845-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160921102637.24845-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

The MODULE_DEVICE_TABLE() were missing from the driver for the of_device_id
structures.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 3d277fa76c1a..c2098a4b4dcf 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -274,11 +274,13 @@ static const struct of_device_id edma_of_ids[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, edma_of_ids);
 
 static const struct of_device_id edma_tptc_of_ids[] = {
 	{ .compatible = "ti,edma3-tptc", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, edma_tptc_of_ids);
 
 static inline unsigned int edma_read(struct edma_cc *ecc, int offset)
 {
-- 
2.10.0
