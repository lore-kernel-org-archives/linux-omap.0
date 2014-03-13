From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 08/18] dma: edma: Implement device_slave_caps callback
Date: Thu, 13 Mar 2014 11:18:30 +0200
Message-ID: <1394702320-21743-9-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, joelf@ti.com, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, mporter@linaro.org, vinod.koul@intel.com, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

With the callback implemented omap-dma can provide information to client
drivers regarding to supported address widths, directions, residue
granularity, etc.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 604c7c94c731..1877319379fc 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -851,6 +851,23 @@ static void __init edma_chan_init(struct edma_cc *ecc,
 	}
 }
 
+#define EDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
+
+static int edma_dma_device_slave_caps(struct dma_chan *dchan,
+				      struct dma_slave_caps *caps)
+{
+	caps->src_addr_widths = EDMA_DMA_BUSWIDTHS;
+	caps->dstn_addr_widths = EDMA_DMA_BUSWIDTHS;
+	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	caps->cmd_pause = true;
+	caps->cmd_terminate = true;
+	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+
+	return 0;
+}
+
 static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 			  struct device *dev)
 {
@@ -861,6 +878,7 @@ static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 	dma->device_issue_pending = edma_issue_pending;
 	dma->device_tx_status = edma_tx_status;
 	dma->device_control = edma_control;
+	dma->device_slave_caps = edma_dma_device_slave_caps;
 	dma->dev = dev;
 
 	INIT_LIST_HEAD(&dma->channels);
-- 
1.9.0
