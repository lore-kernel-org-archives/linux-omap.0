From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RESEND 1/2] dmaengine: edma: Remove dynamic TPTC power management feature
Date: Wed, 6 Apr 2016 13:01:46 +0300
Message-ID: <1459936907-23920-2-git-send-email-peter.ujfalusi@ti.com>
References: <1459936907-23920-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459936907-23920-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com, t-kristo@ti.com, john.ogness@linutronix.de
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
index ee3463e774f8..13b6a23dc06b 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1570,32 +1570,6 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
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
@@ -1632,8 +1606,6 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 		EDMA_CHAN_SLOT(echan->ch_num), chan->chan_id,
 		echan->hw_triggered ? "HW" : "SW");
 
-	edma_tc_set_pm_state(echan->tc, true);
-
 	return 0;
 
 err_slot:
@@ -1670,7 +1642,6 @@ static void edma_free_chan_resources(struct dma_chan *chan)
 		echan->alloced = false;
 	}
 
-	edma_tc_set_pm_state(echan->tc, false);
 	echan->tc = NULL;
 	echan->hw_triggered = false;
 
@@ -2417,10 +2388,8 @@ static int edma_pm_suspend(struct device *dev)
 	int i;
 
 	for (i = 0; i < ecc->num_channels; i++) {
-		if (echan[i].alloced) {
+		if (echan[i].alloced)
 			edma_setup_interrupt(&echan[i], false);
-			edma_tc_set_pm_state(echan[i].tc, false);
-		}
 	}
 
 	return 0;
@@ -2450,8 +2419,6 @@ static int edma_pm_resume(struct device *dev)
 
 			/* Set up channel -> slot mapping for the entry slot */
 			edma_set_chmap(&echan[i], echan[i].slot[0]);
-
-			edma_tc_set_pm_state(echan[i].tc, true);
 		}
 	}
 
@@ -2475,7 +2442,8 @@ static struct platform_driver edma_driver = {
 
 static int edma_tptc_probe(struct platform_device *pdev)
 {
-	return 0;
+	pm_runtime_enable(&pdev->dev);
+	return pm_runtime_get_sync(&pdev->dev);
 }
 
 static struct platform_driver edma_tptc_driver = {
-- 
2.8.0
