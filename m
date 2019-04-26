From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 04/20] net: ethernet: ti: cpsw: update cpsw_split_res() to accept cpsw_common
Date: Fri, 26 Apr 2019 20:12:26 +0300
Message-ID: <1556298762-8632-5-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Update cpsw_split_res() to accept struct cpsw_common instead of
struct net_device to simplify code.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 1c04c16e279b..13a339c64892 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -963,11 +963,9 @@ static void cpsw_rx_handler(void *token, int len, int status)
 		dev_kfree_skb_any(new_skb);
 }
 
-static void cpsw_split_res(struct net_device *ndev)
+static void cpsw_split_res(struct cpsw_common *cpsw)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
 	u32 consumed_rate = 0, bigest_rate = 0;
-	struct cpsw_common *cpsw = priv->cpsw;
 	struct cpsw_vector *txv = cpsw->txv;
 	int i, ch_weight, rlim_ch_num = 0;
 	int budget, bigest_rate_ch = 0;
@@ -1341,7 +1339,7 @@ static void cpsw_adjust_link(struct net_device *ndev)
 
 	if (link) {
 		if (cpsw_need_resplit(cpsw))
-			cpsw_split_res(ndev);
+			cpsw_split_res(cpsw);
 
 		netif_carrier_on(ndev);
 		if (netif_running(ndev))
@@ -2107,7 +2105,7 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	for_each_slave(priv, cpsw_slave_stop, cpsw);
 
 	if (cpsw_need_resplit(cpsw))
-		cpsw_split_res(ndev);
+		cpsw_split_res(cpsw);
 
 	cpsw->usage_count--;
 	pm_runtime_put_sync(cpsw->dev);
@@ -2594,7 +2592,7 @@ static int cpsw_ndo_set_tx_maxrate(struct net_device *ndev, int queue, u32 rate)
 		netdev_get_tx_queue(slave->ndev, queue)->tx_maxrate = rate;
 	}
 
-	cpsw_split_res(ndev);
+	cpsw_split_res(cpsw);
 	return ret;
 }
 
@@ -3063,7 +3061,7 @@ static int cpsw_set_channels(struct net_device *ndev,
 	}
 
 	if (cpsw->usage_count)
-		cpsw_split_res(ndev);
+		cpsw_split_res(cpsw);
 
 	ret = cpsw_resume_data_pass(ndev);
 	if (!ret)
@@ -3698,7 +3696,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	netif_tx_napi_add(ndev, &cpsw->napi_tx,
 			  cpsw->quirk_irq ? cpsw_tx_poll : cpsw_tx_mq_poll,
 			  CPSW_POLL_WEIGHT);
-	cpsw_split_res(ndev);
+	cpsw_split_res(cpsw);
 
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, &pdev->dev);
-- 
2.17.1
