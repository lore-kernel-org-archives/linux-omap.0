From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH V2] net: ethernet: ti: cpsw: Fix suspend/resume break
Date: Mon, 24 Jun 2019 10:46:19 +0530
Message-ID: <20190624051619.20146-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, ivan.khoronzhuk@linaro.org, andrew@lunn.ch, ilias.apalodimas@linaro.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com, grygorii.strashko@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Commit bfe59032bd6127ee190edb30be9381a01765b958 ("net: ethernet:
ti: cpsw: use cpsw as drv data")changes
the driver data to struct cpsw_common *cpsw. This is done
only in probe/remove but the suspend/resume functions are
still left with struct net_device *ndev. Hence fix both
suspend & resume also to fetch the updated driver data.

Fixes: bfe59032bd6127ee1 ("net: ethernet: ti: cpsw: use cpsw as drv data")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Change in v2:

  * Added NULL Checks for cpsw->slaves[i].ndev in suspend/resume functions.

 drivers/net/ethernet/ti/cpsw.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 7bdd287074fc..32b7b3b74a6b 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2590,20 +2590,13 @@ static int cpsw_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int cpsw_suspend(struct device *dev)
 {
-	struct net_device	*ndev = dev_get_drvdata(dev);
-	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
-
-	if (cpsw->data.dual_emac) {
-		int i;
+	struct cpsw_common *cpsw = dev_get_drvdata(dev);
+	int i;
 
-		for (i = 0; i < cpsw->data.slaves; i++) {
+	for (i = 0; i < cpsw->data.slaves; i++)
+		if (cpsw->slaves[i].ndev)
 			if (netif_running(cpsw->slaves[i].ndev))
 				cpsw_ndo_stop(cpsw->slaves[i].ndev);
-		}
-	} else {
-		if (netif_running(ndev))
-			cpsw_ndo_stop(ndev);
-	}
 
 	/* Select sleep pin state */
 	pinctrl_pm_select_sleep_state(dev);
@@ -2613,25 +2606,20 @@ static int cpsw_suspend(struct device *dev)
 
 static int cpsw_resume(struct device *dev)
 {
-	struct net_device	*ndev = dev_get_drvdata(dev);
-	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
+	struct cpsw_common *cpsw = dev_get_drvdata(dev);
+	int i;
 
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(dev);
 
 	/* shut up ASSERT_RTNL() warning in netif_set_real_num_tx/rx_queues */
 	rtnl_lock();
-	if (cpsw->data.dual_emac) {
-		int i;
 
-		for (i = 0; i < cpsw->data.slaves; i++) {
+	for (i = 0; i < cpsw->data.slaves; i++)
+		if (cpsw->slaves[i].ndev)
 			if (netif_running(cpsw->slaves[i].ndev))
 				cpsw_ndo_open(cpsw->slaves[i].ndev);
-		}
-	} else {
-		if (netif_running(ndev))
-			cpsw_ndo_open(ndev);
-	}
+
 	rtnl_unlock();
 
 	return 0;
-- 
2.17.1
