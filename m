From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 6/9] net: ethernet: ti: cpsw: simplify getting .driver_data
Date: Sun, 21 Oct 2018 22:00:17 +0200
Message-ID: <20181021200021.1693-7-wsa+renesas@sang-engineering.com>
References: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/net/ethernet/ti/cpsw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 16dcbf36f8cc..4753ae7178fb 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3658,8 +3658,7 @@ static int cpsw_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int cpsw_suspend(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct net_device	*ndev = platform_get_drvdata(pdev);
+	struct net_device	*ndev = dev_get_drvdata(dev);
 	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
 
 	if (cpsw->data.dual_emac) {
@@ -3682,8 +3681,7 @@ static int cpsw_suspend(struct device *dev)
 
 static int cpsw_resume(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct net_device	*ndev = platform_get_drvdata(pdev);
+	struct net_device	*ndev = dev_get_drvdata(dev);
 	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
 
 	/* Select default pin state */
-- 
2.19.0
