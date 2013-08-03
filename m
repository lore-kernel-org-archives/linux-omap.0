From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net PATCH 1/1] net: ethernet: davinci_emac: drop IRQF_DISABLED
Date: Sat, 3 Aug 2013 16:39:45 +0530
Message-ID: <1375528185-24507-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

IRQF_DISABLED is a no-op by now and should be removed.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 07b176b..1a222bce 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1568,8 +1568,7 @@ static int emac_dev_open(struct net_device *ndev)
 	while ((res = platform_get_resource(priv->pdev, IORESOURCE_IRQ, k))) {
 		for (i = res->start; i <= res->end; i++) {
 			if (devm_request_irq(&priv->pdev->dev, i, emac_irq,
-					     IRQF_DISABLED,
-					     ndev->name, ndev))
+					     0, ndev->name, ndev))
 				goto rollback;
 		}
 		k++;
-- 
1.8.4.rc0.11.g35f5eaa
