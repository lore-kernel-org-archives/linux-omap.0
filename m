From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] dmaengine: ti-dma-crossbar: dra7: Support for eDMA with new bindings
Date: Thu, 29 Oct 2015 10:28:51 +0200
Message-ID: <1446107331-30041-4-git-send-email-peter.ujfalusi@ti.com>
References: <1446107331-30041-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446107331-30041-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Allow the crossbar driver to be used with the eDMA node with non legacy
binding.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti-dma-crossbar.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 1a41f75a4d1f..b7b21a243e37 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -289,6 +289,10 @@ static const struct of_device_id ti_dra7_master_match[] = {
 		.compatible = "ti,edma3",
 		.data = (void *)TI_XBAR_EDMA_OFFSET,
 	},
+	{
+		.compatible = "ti,edma3-tpcc",
+		.data = (void *)TI_XBAR_EDMA_OFFSET,
+	},
 	{},
 };
 
-- 
2.6.1
