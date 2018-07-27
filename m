From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily macroses on functions
Date: Fri, 27 Jul 2018 22:13:18 +0300
Message-ID: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Replace ugly macroses on functions.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

 drivers/net/ethernet/ti/cpsw.c | 63 +++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 1b54c26c2bec..62326a98945b 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
 				(func)(slave++, ##arg);			\
 	} while (0)
 
-#define cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb)		\
-	do {								\
-		if (!cpsw->data.dual_emac)				\
-			break;						\
-		if (CPDMA_RX_SOURCE_PORT(status) == 1) {		\
-			ndev = cpsw->slaves[0].ndev;			\
-			skb->dev = ndev;				\
-		} else if (CPDMA_RX_SOURCE_PORT(status) == 2) {		\
-			ndev = cpsw->slaves[1].ndev;			\
-			skb->dev = ndev;				\
-		}							\
-	} while (0)
-#define cpsw_add_mcast(cpsw, priv, addr)				\
-	do {								\
-		if (cpsw->data.dual_emac) {				\
-			struct cpsw_slave *slave = cpsw->slaves +	\
-						priv->emac_port;	\
-			int slave_port = cpsw_get_slave_port(		\
-						slave->slave_num);	\
-			cpsw_ale_add_mcast(cpsw->ale, addr,		\
-				1 << slave_port | ALE_PORT_HOST,	\
-				ALE_VLAN, slave->port_vlan, 0);		\
-		} else {						\
-			cpsw_ale_add_mcast(cpsw->ale, addr,		\
-				ALE_ALL_PORTS,				\
-				0, 0, 0);				\
-		}							\
-	} while (0)
-
 static inline int cpsw_get_slave_port(u32 slave_num)
 {
 	return slave_num + 1;
 }
 
+static inline void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
+					struct sk_buff *skb)
+{
+	if (!cpsw->data.dual_emac)
+		return;
+
+	if (CPDMA_RX_SOURCE_PORT(status) == 1)
+		skb->dev = cpsw->slaves[0].ndev;
+	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
+		skb->dev = cpsw->slaves[1].ndev;
+}
+
+static void cpsw_add_mcast(struct cpsw_priv *priv, u8 *addr)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+
+	if (cpsw->data.dual_emac) {
+		struct cpsw_slave *slave = cpsw->slaves + priv->emac_port;
+		int slave_port = cpsw_get_slave_port(slave->slave_num);
+
+		cpsw_ale_add_mcast(cpsw->ale, addr,
+				   1 << slave_port | ALE_PORT_HOST,
+				   ALE_VLAN, slave->port_vlan, 0);
+		return;
+	}
+
+	cpsw_ale_add_mcast(cpsw->ale, addr, ALE_ALL_PORTS, 0, 0, 0);
+}
+
 static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
@@ -706,7 +706,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 
 		/* program multicast address list into ALE register */
 		netdev_for_each_mc_addr(ha, ndev) {
-			cpsw_add_mcast(cpsw, priv, (u8 *)ha->addr);
+			cpsw_add_mcast(priv, (u8 *)ha->addr);
 		}
 	}
 }
@@ -801,7 +801,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	int			ret = 0;
 	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
 
-	cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb);
+	cpsw_src_port_detect(cpsw, status, skb);
+	ndev = skb->dev;
 
 	if (unlikely(status < 0) || unlikely(!netif_running(ndev))) {
 		/* In dual emac mode check for all interfaces */
-- 
2.17.1
