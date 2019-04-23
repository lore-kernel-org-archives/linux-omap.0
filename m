From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 08/19] net: ethernet: ti: cpsw: drop cpsw_tx_packet_submit()
Date: Tue, 23 Apr 2019 16:08:59 +0300
Message-ID: <1556024950-20752-9-git-send-email-grygorii.strashko@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Drop unnecessary wrapper function cpsw_tx_packet_submit() which is used
only in one place.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index e714b8f4739c..fe3d145846d2 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1500,17 +1500,6 @@ static void cpsw_get_ethtool_stats(struct net_device *ndev,
 	}
 }
 
-static inline int cpsw_tx_packet_submit(struct cpsw_priv *priv,
-					struct sk_buff *skb,
-					struct cpdma_chan *txch)
-{
-	struct cpsw_common *cpsw = priv->cpsw;
-
-	skb_tx_timestamp(skb);
-	return cpdma_chan_submit(txch, skb, skb->data, skb->len,
-				 priv->emac_port + cpsw->data.dual_emac);
-}
-
 static inline void cpsw_add_dual_emac_def_ale_entries(
 		struct cpsw_priv *priv, struct cpsw_slave *slave,
 		u32 slave_port)
@@ -2138,7 +2127,9 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
 
 	txch = cpsw->txv[q_idx].ch;
 	txq = netdev_get_tx_queue(ndev, q_idx);
-	ret = cpsw_tx_packet_submit(priv, skb, txch);
+	skb_tx_timestamp(skb);
+	ret = cpdma_chan_submit(txch, skb, skb->data, skb->len,
+				priv->emac_port + cpsw->data.dual_emac);
 	if (unlikely(ret != 0)) {
 		cpsw_err(priv, tx_err, "desc submit failed\n");
 		goto fail;
-- 
2.17.1
