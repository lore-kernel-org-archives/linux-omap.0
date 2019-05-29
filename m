From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH] net: ethernet: ti: cpsw_ethtool: fix ethtool ring param set
Date: Thu, 30 May 2019 00:47:53 +0300
Message-ID: <20190529214753.21804-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

After adding ethtool ring param sanity check patch:

commit 37e2d99b59c4765112533a1d38174fea58d28a51 ("ethtool: Ensure new
ring parameters are within bounds during SRINGPARAM")

cpsw has no ability to change rx descriptor numbers.
But the reason - initially "tx_max_pending" was not correctly set
while adding a patch:

commit be034fc14015c7fcabe62317d156e98b508a759b ("net: ethernet: ti:
cpsw: add support for ringparam configuration")

The issue appears after adding sanity check, so fix is for "sanity"
patch.

Fixes: 37e2d99b59c4765112533a1d38174fea58d28a51 ("ethtool: Ensure new
ring parameters are within bounds during SRINGPARAM")

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net/master

 drivers/net/ethernet/ti/cpsw_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
index a4a7ec0d2531..6d1c9ebae7cc 100644
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -643,7 +643,7 @@ void cpsw_get_ringparam(struct net_device *ndev,
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	/* not supported */
-	ering->tx_max_pending = 0;
+	ering->tx_max_pending = cpsw->descs_pool_size - CPSW_MAX_QUEUES;
 	ering->tx_pending = cpdma_get_num_tx_descs(cpsw->dma);
 	ering->rx_max_pending = cpsw->descs_pool_size - CPSW_MAX_QUEUES;
 	ering->rx_pending = cpdma_get_num_rx_descs(cpsw->dma);
-- 
2.17.1
