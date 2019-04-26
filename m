From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 07/20] net: ethernet: ti: cpsw: use devm_alloc_etherdev_mqs()
Date: Fri, 26 Apr 2019 20:12:29 +0300
Message-ID: <1556298762-8632-8-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Use devm_alloc_etherdev_mqs() and simplify code.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index e771e4269af8..ddc259c45481 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3399,7 +3399,8 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	struct cpsw_priv		*priv_sl2;
 	int ret = 0;
 
-	ndev = alloc_etherdev_mq(sizeof(struct cpsw_priv), CPSW_MAX_QUEUES);
+	ndev = devm_alloc_etherdev_mqs(cpsw->dev, sizeof(struct cpsw_priv),
+				       CPSW_MAX_QUEUES, CPSW_MAX_QUEUES);
 	if (!ndev) {
 		dev_err(cpsw->dev, "cpsw: error allocating net_device\n");
 		return -ENOMEM;
@@ -3433,11 +3434,8 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, cpsw->dev);
 	ret = register_netdev(ndev);
-	if (ret) {
+	if (ret)
 		dev_err(cpsw->dev, "cpsw: error registering net device\n");
-		free_netdev(ndev);
-		ret = -ENODEV;
-	}
 
 	return ret;
 }
@@ -3481,7 +3479,8 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	cpsw->dev = dev;
 
-	ndev = alloc_etherdev_mq(sizeof(struct cpsw_priv), CPSW_MAX_QUEUES);
+	ndev = devm_alloc_etherdev_mqs(dev, sizeof(struct cpsw_priv),
+				       CPSW_MAX_QUEUES, CPSW_MAX_QUEUES);
 	if (!ndev) {
 		dev_err(dev, "error allocating net_device\n");
 		return -ENOMEM;
@@ -3499,7 +3498,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (IS_ERR(mode)) {
 		ret = PTR_ERR(mode);
 		dev_err(dev, "gpio request failed, ret %d\n", ret);
-		goto clean_ndev_ret;
+		return ret;
 	}
 
 	/*
@@ -3768,8 +3767,6 @@ static int cpsw_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 clean_runtime_disable_ret:
 	pm_runtime_disable(&pdev->dev);
-clean_ndev_ret:
-	free_netdev(priv->ndev);
 	return ret;
 }
 
@@ -3794,9 +3791,6 @@ static int cpsw_remove(struct platform_device *pdev)
 	cpsw_remove_dt(pdev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (cpsw->data.dual_emac)
-		free_netdev(cpsw->slaves[1].ndev);
-	free_netdev(ndev);
 	return 0;
 }
 
-- 
2.17.1
