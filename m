From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 35/61] net: ethernet: ti: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:05 +0200
Message-ID: <20180419140641.27926-36-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/net/ethernet/ti/cpsw.c         | 6 ++----
 drivers/net/ethernet/ti/davinci_emac.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 30371274409d..ef0c88e71a71 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3300,8 +3300,7 @@ static int cpsw_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int cpsw_suspend(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct net_device	*ndev = platform_get_drvdata(pdev);
+	struct net_device	*ndev = dev_get_drvdata(dev);
 	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
 
 	if (cpsw->data.dual_emac) {
@@ -3324,8 +3323,7 @@ static int cpsw_suspend(struct device *dev)
 
 static int cpsw_resume(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct net_device	*ndev = platform_get_drvdata(pdev);
+	struct net_device	*ndev = dev_get_drvdata(dev);
 	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
 
 	/* Select default pin state */
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index abceea802ea1..ef223613114d 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1985,8 +1985,7 @@ static int davinci_emac_remove(struct platform_device *pdev)
 
 static int davinci_emac_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 
 	if (netif_running(ndev))
 		emac_dev_stop(ndev);
@@ -1996,8 +1995,7 @@ static int davinci_emac_suspend(struct device *dev)
 
 static int davinci_emac_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 
 	if (netif_running(ndev))
 		emac_dev_open(ndev);
-- 
2.11.0
