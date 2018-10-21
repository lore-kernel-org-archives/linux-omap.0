From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 7/9] net: ethernet: ti: davinci_emac: simplify getting .driver_data
Date: Sun, 21 Oct 2018 22:00:18 +0200
Message-ID: <20181021200021.1693-8-wsa+renesas@sang-engineering.com>
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

 drivers/net/ethernet/ti/davinci_emac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index f270beebb428..9153db120352 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -2002,8 +2002,7 @@ static int davinci_emac_remove(struct platform_device *pdev)
 
 static int davinci_emac_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 
 	if (netif_running(ndev))
 		emac_dev_stop(ndev);
@@ -2013,8 +2012,7 @@ static int davinci_emac_suspend(struct device *dev)
 
 static int davinci_emac_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 
 	if (netif_running(ndev))
 		emac_dev_open(ndev);
-- 
2.19.0
