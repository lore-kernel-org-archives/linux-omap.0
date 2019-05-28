From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: correct .ndo_open error path
Date: Tue, 28 May 2019 15:33:52 +0300
Message-ID: <20190528123352.21505-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

It's found while review and probably never happens, but real number
of queues is set per device, and error path should be per device.
Also correct label name for shared error path.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 634fc484a0b3..473d25ed59e3 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1399,7 +1399,7 @@ static int cpsw_ndo_open(struct net_device *ndev)
 
 		ret = cpsw_fill_rx_channels(priv);
 		if (ret < 0)
-			goto err_cleanup;
+			goto err_shared_cleanup;
 
 		if (cpts_register(cpsw->cpts))
 			dev_err(priv->dev, "error registering cpts device\n");
@@ -1422,9 +1422,10 @@ static int cpsw_ndo_open(struct net_device *ndev)
 
 	return 0;
 
-err_cleanup:
+err_shared_cleanup:
 	cpdma_ctlr_stop(cpsw->dma);
 	for_each_slave(priv, cpsw_slave_stop, cpsw);
+err_cleanup:
 	pm_runtime_put_sync(cpsw->dev);
 	netif_carrier_off(priv->ndev);
 	return ret;
-- 
2.17.1
