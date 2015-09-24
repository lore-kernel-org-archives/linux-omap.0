From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 14/25] dmaengine: edma: Use devm_kcalloc when possible
Date: Thu, 24 Sep 2015 13:02:01 +0300
Message-ID: <1443088932-21731-15-git-send-email-peter.ujfalusi@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

When allocating a memory for number of items it is better (looks better)
to use devm_kcalloc.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 46c0cbf1fe20..f5010c8f6273 100644
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
2.5.2
