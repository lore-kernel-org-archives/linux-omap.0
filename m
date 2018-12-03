From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 5/5] net: ethernet: ti: cpsw: update mc vlan and add uc vlan support based on addr vids
Date: Mon,  3 Dec 2018 20:40:23 +0200
Message-ID: <20181203184023.3430-6-ivan.khoronzhuk@linaro.org>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Update multicast support for vlans and add uc vlan support using newly
added net/core changes with vid tag.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 86 ++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index e4aa030f1726..49a223720335 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -796,6 +796,67 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
 	return 0;
 }
 
+static int cpsw_set_uc(struct net_device *ndev, const u8 *addr,
+		       int vid, int add)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int flags, port, ret;
+
+	if (vid < 0) {
+		if (cpsw->data.dual_emac)
+			vid = cpsw->slaves[priv->emac_port].port_vlan;
+		else
+			vid = 0;
+	}
+
+	port = HOST_PORT_NUM;
+	flags = vid ? ALE_VLAN : 0;
+
+	if (add)
+		ret = cpsw_ale_add_ucast(cpsw->ale, addr, port, flags, vid);
+	else
+		ret = cpsw_ale_del_ucast(cpsw->ale, addr, port, flags, vid);
+
+	return ret;
+}
+
+static int _cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr)
+{
+	u16 vid;
+
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_mc(ndev, addr, vid ? vid : -1, 1);
+	return 0;
+}
+
+static int _cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr)
+{
+	u16 vid;
+
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_mc(ndev, addr, vid ? vid : -1, 0);
+	return 0;
+}
+
+static int _cpsw_add_uc_addr(struct net_device *ndev, const u8 *addr)
+{
+	u16 vid;
+
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_uc(ndev, addr, vid ? vid : -1, 1);
+	return 0;
+}
+
+static int _cpsw_del_uc_addr(struct net_device *ndev, const u8 *addr)
+{
+	u16 vid;
+
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_uc(ndev, addr, vid ? vid : -1, 0);
+	return 0;
+}
+
 static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
@@ -814,8 +875,8 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
 
 	/* add/remove mcast address either for real netdev or for vlan */
-	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
-			       cpsw_del_mc_addr);
+	__dev_mc_sync(ndev, _cpsw_add_mc_addr, _cpsw_del_mc_addr);
+	__dev_uc_sync(ndev, _cpsw_add_uc_addr, _cpsw_del_uc_addr);
 }
 
 static void cpsw_intr_enable(struct cpsw_common *cpsw)
@@ -2092,7 +2153,8 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
-	__hw_addr_ref_unsync_dev(&ndev->mc, ndev, cpsw_purge_all_mc);
+	__dev_mc_unsync(ndev, _cpsw_del_mc_addr);
+	__dev_uc_unsync(ndev, _cpsw_del_uc_addr);
 	netif_tx_stop_all_queues(priv->ndev);
 	netif_carrier_off(priv->ndev);
 
@@ -2453,21 +2515,11 @@ static inline int cpsw_add_vlan_ale_entry(struct cpsw_priv *priv,
 	if (ret != 0)
 		return ret;
 
-	ret = cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
-				 HOST_PORT_NUM, ALE_VLAN, vid);
-	if (ret != 0)
-		goto clean_vid;
-
 	ret = cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
 				 mcast_mask, ALE_VLAN, vid, 0);
-	if (ret != 0)
-		goto clean_vlan_ucast;
-	return 0;
+	if (!ret)
+		return 0;
 
-clean_vlan_ucast:
-	cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
-			   HOST_PORT_NUM, ALE_VLAN, vid);
-clean_vid:
 	cpsw_ale_del_vlan(cpsw->ale, vid, 0);
 	return ret;
 }
@@ -3418,6 +3470,8 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	priv_sl2->emac_port = 1;
 	cpsw->slaves[1].ndev = ndev;
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->vid_len = NET_802Q_VID_TSIZE;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
@@ -3679,6 +3733,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	}
 
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->vid_len = NET_802Q_VID_TSIZE;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
-- 
2.17.1
