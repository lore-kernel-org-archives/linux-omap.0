From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: edma: Remove dynamic TPTC power management feature
Date: Wed, 27 Jan 2016 11:11:46 +0200
Message-ID: <1453885906-17652-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: tony@atomide.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The dynamic or on demand pm_runtime does not work correctly on am335x and
am437x due to interference with hwmod.
Fall back using the pm_runtime usage as it was in the old driver stack,
meaning that at probe time call pm_runtime_enable() and
pm_runtime_get_sync() for the TPTCs as well.

Fixes: 1be5336bc7ba ("dmaengine: edma: New device tree binding")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/dma/edma.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d92d65549406..c1b052f7b68c 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1560,32 +1560,6 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void edma_tc_set_pm_state(struct edma_tc *tc, bool enable)
-{
-	struct platform_device *tc_pdev;
-	int ret;
-
-	if (!IS_ENABLED(CONFIG_OF) || !tc)
-		return;
-
-	tc_pdev = of_find_device_by_node(tc->node);
-	if (!tc_pdev) {
-		pr_err("%s: TPTC device is not found\n", __func__);
-		return;
-	}
-	if (!pm_runtime_enabled(&tc_pdev->dev))
-		pm_runtime_enable(&tc_pdev->dev);
-
-	if (enable)
-		ret = pm_runtime_get_sync(&tc_pdev->dev);
-	else
-		ret = pm_runtime_put_sync(&tc_pdev->dev);
-
-	if (ret < 0)
-		pr_err("%s: pm_runtime_%s_sync() failed for %s\n", __func__,
-		       enable ? "get" : "put", dev_name(&tc_pdev->dev));
-}
-
 /* Alloc channel resources */
 static int edma_alloc_chan_resources(struct dma_chan *chan)
 {
@@ -1622,8 +1596,6 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 		EDMA_CHAN_SLOT(echan->ch_num), chan->chan_id,
 		echan->hw_triggered ? "HW" : "SW");
 
-	edma_tc_set_pm_state(echan->tc, true);
-
 	return 0;
 
 err_slot:
@@ -1660,7 +1632,6 @@ static void edma_free_chan_resources(struct dma_chan *chan)
 		echan->alloced = false;
 	}
 
-	edma_tc_set_pm_state(echan->tc, false);
 	echan->tc = NULL;
 	echan->hw_triggered = false;
 
@@ -2369,10 +2340,8 @@ static int edma_pm_suspend(struct device *dev)
 	int i;
 
 	for (i = 0; i < ecc->num_channels; i++) {
-		if (echan[i].alloced) {
+		if (echan[i].alloced)
 			edma_setup_interrupt(&echan[i], false);
-			edma_tc_set_pm_state(echan[i].tc, false);
-		}
 	}
 
 	return 0;
@@ -2402,8 +2371,6 @@ static int edma_pm_resume(struct device *dev)
 
 			/* Set up channel -> slot mapping for the entry slot */
 			edma_set_chmap(&echan[i], echan[i].slot[0]);
-
-			edma_tc_set_pm_state(echan[i].tc, true);
 		}
 	}
 
@@ -2427,7 +2394,8 @@ static struct platform_driver edma_driver = {
 
 static int edma_tptc_probe(struct platform_device *pdev)
 {
-	return 0;
+	pm_runtime_enable(&pdev->dev);
+	return pm_runtime_get_sync(&pdev->dev);
 }
 
 static struct platform_driver edma_tptc_driver = {
-- 
2.7.0
