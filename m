From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 2/2] net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update
Date: Fri, 12 Oct 2018 18:28:15 +0300
Message-ID: <20181012152815.31320-3-ivan.khoronzhuk@linaro.org>
References: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Whenever kernel or user decides to call rx mode update, it clears
every multicast entry from forwarding table and in some time adds
it again. This time can be enough to drop incoming multicast packets.

That's why clear only staled multicast entries and update or add new
one afterwards.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 46 +++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 832bce07c385..b7a6a2a0f71d 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -570,7 +570,7 @@ static inline int cpsw_get_slave_port(u32 slave_num)
 	return slave_num + 1;
 }
 
-static void cpsw_add_mcast(struct cpsw_priv *priv, u8 *addr)
+static void cpsw_add_mcast(struct cpsw_priv *priv, const u8 *addr)
 {
 	struct cpsw_common *cpsw = priv->cpsw;
 
@@ -662,16 +662,35 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 	}
 }
 
-static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+
+	cpsw_add_mcast(priv, addr);
+	return 0;
+}
+
+static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
 	struct cpsw_common *cpsw = priv->cpsw;
-	int vid;
+	int vid, flags;
 
-	if (cpsw->data.dual_emac)
+	if (cpsw->data.dual_emac) {
 		vid = cpsw->slaves[priv->emac_port].port_vlan;
-	else
-		vid = cpsw->data.default_vlan;
+		flags = ALE_VLAN;
+	} else {
+		vid = 0;
+		flags = 0;
+	}
+
+	cpsw_ale_del_mcast(cpsw->ale, addr, 0, flags, vid);
+	return 0;
+}
+
+static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
 
 	if (ndev->flags & IFF_PROMISC) {
 		/* Enable promiscuous mode */
@@ -684,19 +703,9 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	}
 
 	/* Restore allmulti on vlans if necessary */
-	cpsw_ale_set_allmulti(cpsw->ale, priv->ndev->flags & IFF_ALLMULTI);
-
-	/* Clear all mcast from ALE */
-	cpsw_ale_flush_multicast(cpsw->ale, ALE_ALL_PORTS, vid);
+	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
 
-	if (!netdev_mc_empty(ndev)) {
-		struct netdev_hw_addr *ha;
-
-		/* program multicast address list into ALE register */
-		netdev_for_each_mc_addr(ha, ndev) {
-			cpsw_add_mcast(priv, ha->addr);
-		}
-	}
+	__dev_mc_sync(ndev, cpsw_add_mc_addr, cpsw_del_mc_addr);
 }
 
 static void cpsw_intr_enable(struct cpsw_common *cpsw)
@@ -1956,6 +1965,7 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
+	__dev_mc_unsync(priv->ndev, cpsw_del_mc_addr);
 	netif_tx_stop_all_queues(priv->ndev);
 	netif_carrier_off(priv->ndev);
 
-- 
2.17.1
