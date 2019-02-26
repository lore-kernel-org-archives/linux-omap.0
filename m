From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 5/6] net: ethernet: ti: cpsw: update mc filtering to use IVDF
Date: Tue, 26 Feb 2019 20:45:55 +0200
Message-ID: <20190226184556.16082-6-ivan.khoronzhuk@linaro.org>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The cpsw can filter multicast addresses only per vlan. Thus if mcast
address is set for one of them or only for real device it must be
added for every created vlan consuming ALE table w/o reason. In order to
simplify dispatching vlan filters, the IVDF recently added is resused.

In case IVDF is disabled - mc is updated only for real device as before.
The previous method is harder to reuse and vlan filtering is limited
only for vlans directly connected to real netdev, so drop it in flavor
of IVDF decision.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/Kconfig |   1 +
 drivers/net/ethernet/ti/cpsw.c  | 113 ++++----------------------------
 2 files changed, 13 insertions(+), 101 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index bb126be1eb72..c99c08ece9a1 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -65,6 +65,7 @@ config TI_CPSW
 	select TI_DAVINCI_CPDMA
 	select TI_DAVINCI_MDIO
 	select TI_CPSW_PHY_SEL
+	select VLAN_8021Q_IVDF
 	select TI_CPSW_ALE
 	select MFD_SYSCON
 	select REGMAP
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index a591583d120e..fd76d1f12911 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -693,108 +693,21 @@ static int cpsw_set_mc(struct net_device *ndev, const u8 *addr,
 	return ret;
 }
 
-static int cpsw_update_vlan_mc(struct net_device *vdev, int vid, void *ctx)
+static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr)
 {
-	struct addr_sync_ctx *sync_ctx = ctx;
-	struct netdev_hw_addr *ha;
-	int found = 0, ret = 0;
-
-	if (!vdev || !(vdev->flags & IFF_UP))
-		return 0;
-
-	/* vlan address is relevant if its sync_cnt != 0 */
-	netdev_for_each_mc_addr(ha, vdev) {
-		if (ether_addr_equal(ha->addr, sync_ctx->addr)) {
-			found = ha->sync_cnt;
-			break;
-		}
-	}
-
-	if (found)
-		sync_ctx->consumed++;
-
-	if (sync_ctx->flush) {
-		if (!found)
-			cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 0);
-		return 0;
-	}
-
-	if (found)
-		ret = cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 1);
-
-	return ret;
-}
-
-static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr, int num)
-{
-	struct addr_sync_ctx sync_ctx;
-	int ret;
-
-	sync_ctx.consumed = 0;
-	sync_ctx.addr = addr;
-	sync_ctx.ndev = ndev;
-	sync_ctx.flush = 0;
-
-	ret = vlan_for_each(ndev, cpsw_update_vlan_mc, &sync_ctx);
-	if (sync_ctx.consumed < num && !ret)
-		ret = cpsw_set_mc(ndev, addr, -1, 1);
-
-	return ret;
-}
-
-static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr, int num)
-{
-	struct addr_sync_ctx sync_ctx;
-
-	sync_ctx.consumed = 0;
-	sync_ctx.addr = addr;
-	sync_ctx.ndev = ndev;
-	sync_ctx.flush = 1;
-
-	vlan_for_each(ndev, cpsw_update_vlan_mc, &sync_ctx);
-	if (sync_ctx.consumed == num)
-		cpsw_set_mc(ndev, addr, -1, 0);
+	u16 vid;
 
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_mc(ndev, addr, vid ? vid : -1, 1);
 	return 0;
 }
 
-static int cpsw_purge_vlan_mc(struct net_device *vdev, int vid, void *ctx)
+static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr)
 {
-	struct addr_sync_ctx *sync_ctx = ctx;
-	struct netdev_hw_addr *ha;
-	int found = 0;
-
-	if (!vdev || !(vdev->flags & IFF_UP))
-		return 0;
-
-	/* vlan address is relevant if its sync_cnt != 0 */
-	netdev_for_each_mc_addr(ha, vdev) {
-		if (ether_addr_equal(ha->addr, sync_ctx->addr)) {
-			found = ha->sync_cnt;
-			break;
-		}
-	}
-
-	if (!found)
-		return 0;
-
-	sync_ctx->consumed++;
-	cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 0);
-	return 0;
-}
-
-static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
-{
-	struct addr_sync_ctx sync_ctx;
-
-	sync_ctx.addr = addr;
-	sync_ctx.ndev = ndev;
-	sync_ctx.consumed = 0;
-
-	vlan_for_each(ndev, cpsw_purge_vlan_mc, &sync_ctx);
-	if (sync_ctx.consumed < num)
-		cpsw_set_mc(ndev, addr, -1, 0);
+	u16 vid;
 
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_mc(ndev, addr, vid ? vid : -1, 0);
 	return 0;
 }
 
@@ -816,8 +729,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
 
 	/* add/remove mcast address either for real netdev or for vlan */
-	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
-			       cpsw_del_mc_addr);
+	__dev_mc_sync(ndev, cpsw_add_mc_addr, cpsw_del_mc_addr);
 }
 
 static void cpsw_intr_enable(struct cpsw_common *cpsw)
@@ -1970,9 +1882,6 @@ static int cpsw_restore_vlans(struct net_device *vdev, int vid, void *arg)
 {
 	struct cpsw_priv *priv = arg;
 
-	if (!vdev)
-		return 0;
-
 	cpsw_ndo_vlan_rx_add_vid(priv->ndev, 0, vid);
 	return 0;
 }
@@ -2099,7 +2008,7 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
-	__hw_addr_ref_unsync_dev(&ndev->mc, ndev, cpsw_purge_all_mc);
+	__dev_mc_unsync(ndev, cpsw_del_mc_addr);
 	netif_tx_stop_all_queues(priv->ndev);
 	netif_carrier_off(priv->ndev);
 
@@ -3435,6 +3344,7 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	priv_sl2->emac_port = 1;
 	cpsw->slaves[1].ndev = ndev;
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	vlan_dev_ivdf_set(ndev, 1);
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
@@ -3696,6 +3606,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	}
 
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	vlan_dev_ivdf_set(ndev, 1);
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
-- 
2.17.1
