From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpdma: correct error handling for chan create
Date: Wed,  6 Dec 2017 16:54:09 +0200
Message-ID: <1512572050-13442-1-git-send-email-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

It's not correct to return NULL when that is actually an error and
function returns errors in any other wrong case. In the same time,
the cpsw driver and davinci emac doesn't check error case while
creating channel and it can miss actual error. Correct this mess.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c          | 12 +++++++++---
 drivers/net/ethernet/ti/davinci_cpdma.c |  2 +-
 drivers/net/ethernet/ti/davinci_emac.c  |  9 +++++++--
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index a60a378..ee58f48 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3065,10 +3065,16 @@ static int cpsw_probe(struct platform_device *pdev)
 	}
 
 	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_tx_handler, 0);
+	if (WARN_ON(IS_ERR(cpsw->txv[0].ch))) {
+		dev_err(priv->dev, "error initializing tx dma channel\n");
+		ret = PTR_ERR(cpsw->txv[0].ch);
+		goto clean_dma_ret;
+	}
+
 	cpsw->rxv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_rx_handler, 1);
-	if (WARN_ON(!cpsw->rxv[0].ch || !cpsw->txv[0].ch)) {
-		dev_err(priv->dev, "error initializing dma channels\n");
-		ret = -ENOMEM;
+	if (WARN_ON(IS_ERR(cpsw->rxv[0].ch))) {
+		dev_err(priv->dev, "error initializing rx dma channel\n");
+		ret = PTR_ERR(cpsw->rxv[0].ch);
 		goto clean_dma_ret;
 	}
 
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index dbe9167..a9fab42 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -893,7 +893,7 @@ struct cpdma_chan *cpdma_chan_create(struct cpdma_ctlr *ctlr, int chan_num,
 	chan_num = rx_type ? rx_chan_num(chan_num) : tx_chan_num(chan_num);
 
 	if (__chan_linear(chan_num) >= ctlr->num_chan)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	chan = devm_kzalloc(ctlr->dev, sizeof(*chan), GFP_KERNEL);
 	if (!chan)
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index f58c0c6..3d4af64 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1870,10 +1870,15 @@ static int davinci_emac_probe(struct platform_device *pdev)
 
 	priv->txchan = cpdma_chan_create(priv->dma, EMAC_DEF_TX_CH,
 					 emac_tx_handler, 0);
+	if (WARN_ON(IS_ERR(priv->txchan))) {
+		rc = PTR_ERR(priv->txchan);
+		goto no_cpdma_chan;
+	}
+
 	priv->rxchan = cpdma_chan_create(priv->dma, EMAC_DEF_RX_CH,
 					 emac_rx_handler, 1);
-	if (WARN_ON(!priv->txchan || !priv->rxchan)) {
-		rc = -ENOMEM;
+	if (WARN_ON(IS_ERR(priv->rxchan))) {
+		rc = PTR_ERR(priv->rxchan);
 		goto no_cpdma_chan;
 	}
 
-- 
2.7.4
