From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 04/14] dma: edma: Set DMA_CYCLIC capability flag
Date: Tue, 1 Apr 2014 16:06:05 +0300
Message-ID: <1396357575-30585-5-git-send-email-peter.ujfalusi@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dan.j.williams@intel.com, vinod.koul@intel.com, nsekhar@ti.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, joelf@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, mporter@linaro.org
List-Id: linux-omap@vger.kernel.org

Indicate that the edma dmaengine driver has support for cyclic mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c | 1 +
 drivers/dma/edma.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 41bca32409fc..86a8b263278f 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1574,6 +1574,7 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 		return ERR_PTR(ret);
 
 	dma_cap_set(DMA_SLAVE, edma_filter_info.dma_cap);
+	dma_cap_set(DMA_CYCLIC, edma_filter_info.dma_cap);
 	of_dma_controller_register(dev->of_node, of_dma_simple_xlate,
 				   &edma_filter_info);
 
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 7891378a03f0..1dd9e8806975 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -891,6 +891,7 @@ static int edma_probe(struct platform_device *pdev)
 
 	dma_cap_zero(ecc->dma_slave.cap_mask);
 	dma_cap_set(DMA_SLAVE, ecc->dma_slave.cap_mask);
+	dma_cap_set(DMA_CYCLIC, ecc->dma_slave.cap_mask);
 
 	edma_dma_init(ecc, &ecc->dma_slave, &pdev->dev);
 
-- 
1.9.1
