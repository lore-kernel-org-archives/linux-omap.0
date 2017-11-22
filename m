From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 10/11] net: ethernet: ti: ale: use devm_kzalloc in cpsw_ale_create()
Date: Wed, 22 Nov 2017 15:25:56 -0600
Message-ID: <20171122212557.9998-11-grygorii.strashko@ti.com>
References: <20171122212557.9998-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122212557.9998-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Use cpsw_ale_create in cpsw_ale_create(). This also makes
cpsw_ale_destroy() function nop, so remove it.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c        | 17 +++++++----------
 drivers/net/ethernet/ti/cpsw_ale.c    | 11 +----------
 drivers/net/ethernet/ti/cpsw_ale.h    |  1 -
 drivers/net/ethernet/ti/netcp_ethss.c |  1 -
 4 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index ca7c52a..f033096 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3089,14 +3089,14 @@ static int cpsw_probe(struct platform_device *pdev)
 	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpsw->dev->of_node);
 	if (IS_ERR(cpsw->cpts)) {
 		ret = PTR_ERR(cpsw->cpts);
-		goto clean_ale_ret;
+		goto clean_dma_ret;
 	}
 
 	ndev->irq = platform_get_irq(pdev, 1);
 	if (ndev->irq < 0) {
 		dev_err(priv->dev, "error getting irq resource\n");
 		ret = ndev->irq;
-		goto clean_ale_ret;
+		goto clean_dma_ret;
 	}
 
 	of_id = of_match_device(cpsw_of_mtable, &pdev->dev);
@@ -3120,7 +3120,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(priv->dev, "error registering net device\n");
 		ret = -ENODEV;
-		goto clean_ale_ret;
+		goto clean_dma_ret;
 	}
 
 	if (cpsw->data.dual_emac) {
@@ -3143,7 +3143,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 1);
 	if (irq < 0) {
 		ret = irq;
-		goto clean_ale_ret;
+		goto clean_dma_ret;
 	}
 
 	cpsw->irqs_table[0] = irq;
@@ -3151,14 +3151,14 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(&pdev->dev), cpsw);
 	if (ret < 0) {
 		dev_err(priv->dev, "error attaching irq (%d)\n", ret);
-		goto clean_ale_ret;
+		goto clean_dma_ret;
 	}
 
 	/* TX IRQ */
 	irq = platform_get_irq(pdev, 2);
 	if (irq < 0) {
 		ret = irq;
-		goto clean_ale_ret;
+		goto clean_dma_ret;
 	}
 
 	cpsw->irqs_table[1] = irq;
@@ -3166,7 +3166,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(&pdev->dev), cpsw);
 	if (ret < 0) {
 		dev_err(priv->dev, "error attaching irq (%d)\n", ret);
-		goto clean_ale_ret;
+		goto clean_dma_ret;
 	}
 
 	cpsw_notice(priv, probe,
@@ -3179,8 +3179,6 @@ static int cpsw_probe(struct platform_device *pdev)
 
 clean_unregister_netdev_ret:
 	unregister_netdev(ndev);
-clean_ale_ret:
-	cpsw_ale_destroy(cpsw->ale);
 clean_dma_ret:
 	cpdma_ctlr_destroy(cpsw->dma);
 clean_dt_ret:
@@ -3210,7 +3208,6 @@ static int cpsw_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 
 	cpts_release(cpsw->cpts);
-	cpsw_ale_destroy(cpsw->ale);
 	cpdma_ctlr_destroy(cpsw->dma);
 	cpsw_remove_dt(pdev);
 	pm_runtime_put_sync(&pdev->dev);
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index d542859..db5f28e 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -802,7 +802,7 @@ struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 	struct cpsw_ale *ale;
 	u32 rev, ale_entries;
 
-	ale = kzalloc(sizeof(*ale), GFP_KERNEL);
+	ale = devm_kzalloc(params->dev, sizeof(*ale), GFP_KERNEL);
 	if (!ale)
 		return NULL;
 
@@ -881,15 +881,6 @@ struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_create);
 
-int cpsw_ale_destroy(struct cpsw_ale *ale)
-{
-	if (!ale)
-		return -EINVAL;
-	kfree(ale);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cpsw_ale_destroy);
-
 void cpsw_ale_dump(struct cpsw_ale *ale, u32 *data)
 {
 	int i;
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 25d24e8..d4fe901 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -100,7 +100,6 @@ enum cpsw_ale_port_state {
 #define ALE_ENTRY_WORDS	DIV_ROUND_UP(ALE_ENTRY_BITS, 32)
 
 struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params);
-int cpsw_ale_destroy(struct cpsw_ale *ale);
 
 void cpsw_ale_start(struct cpsw_ale *ale);
 void cpsw_ale_stop(struct cpsw_ale *ale);
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 1ff0ade..ceb15a2 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3690,7 +3690,6 @@ static int gbe_remove(struct netcp_device *netcp_device, void *inst_priv)
 	del_timer_sync(&gbe_dev->timer);
 	cpts_release(gbe_dev->cpts);
 	cpsw_ale_stop(gbe_dev->ale);
-	cpsw_ale_destroy(gbe_dev->ale);
 	netcp_txpipe_close(&gbe_dev->tx_pipe);
 	free_secondary_ports(gbe_dev);
 
-- 
2.10.5
