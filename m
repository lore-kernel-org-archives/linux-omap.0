From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 14/23] dmaengine: edma: Use devm_kcalloc when possible
Date: Fri, 11 Sep 2015 15:27:13 +0300
Message-ID: <1441974442-8233-15-git-send-email-peter.ujfalusi@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When allocating a memory for number of items it is better (looks better)
to use devm_kcalloc.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index cae8b23e3ac3..0c995f981936 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2034,7 +2034,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	 * priority. So Q0 is the highest priority queue and the last queue has
 	 * the lowest priority.
 	 */
-	queue_priority_map = devm_kzalloc(dev, (ecc->num_tc + 1) * sizeof(s8),
+	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
 					  GFP_KERNEL);
 	if (!queue_priority_map)
 		return -ENOMEM;
@@ -2065,7 +2065,7 @@ static int edma_xbar_event_map(struct device *dev, struct edma_soc_info *pdata,
 	u32 shift, offset, mux;
 	int ret, i;
 
-	xbar_chans = devm_kzalloc(dev, (nelm + 2) * sizeof(s16), GFP_KERNEL);
+	xbar_chans = devm_kcalloc(dev, nelm + 2, sizeof(s16), GFP_KERNEL);
 	if (!xbar_chans)
 		return -ENOMEM;
 
-- 
2.5.1
