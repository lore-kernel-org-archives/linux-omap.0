From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 10/10] dmaengine: edma: Print the direction value as well when it is not supported
Date: Mon, 14 Apr 2014 14:42:05 +0300
Message-ID: <1397475725-5036-11-git-send-email-peter.ujfalusi@ti.com>
References: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dan.j.williams@intel.com, vinod.koul@intel.com, nsekhar@ti.com, joelf@ti.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: linux-omap@vger.kernel.org

In case of not supported direction it is better to print the direction also.
It is unlikely, but in such an event it helps with the debugging.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 4aa5eb005b5c..91849aa50de1 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -432,7 +432,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 		dev_width = echan->cfg.dst_addr_width;
 		burst = echan->cfg.dst_maxburst;
 	} else {
-		dev_err(dev, "%s: bad direction?\n", __func__);
+		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);
 		return NULL;
 	}
 
@@ -525,7 +525,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		dev_width = echan->cfg.dst_addr_width;
 		burst = echan->cfg.dst_maxburst;
 	} else {
-		dev_err(dev, "%s: bad direction?\n", __func__);
+		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);
 		return NULL;
 	}
 
-- 
1.9.2
