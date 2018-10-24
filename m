From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 3/4] net: ethernet: ti: cpsw: fix vlan mcast
Date: Thu, 25 Oct 2018 01:10:58 +0300
Message-ID: <20181024221059.21834-4-ivan.khoronzhuk@linaro.org>
References: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com, bjorn@mork.no, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

At this moment, mcast addresses are added for real device only
(reserved vlans for dual-emac mode), even if a mcast address was added
for some vlan only, thus ALE doesn't have corresponding vlan mcast
entries after vlan socket joined multicast group. So ALE drops vlan
frames with mcast addresses intended for vlans and potentially can
receive mcast frames for base ndev. That's not correct. So, fix it by
creating only vlan/mcast entries as requested. Patch doesn't use any
additional lists and is based on device mc address list and cpsw ALE
table entries.

In legacy switch mode ALE table can have untracked vlan addresses, it
can conflict with method used to delete vlan mcast addresses, so for
switch mode, do syncing as it is, leaving ability for a user to modify
table in usual for him sequence.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 195 +++++++++++++++++++++++++++------
 1 file changed, 164 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 500f7ed8c58c..27e0a5d5ccf9 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -570,21 +570,6 @@ static inline int cpsw_get_slave_port(u32 slave_num)
 	return slave_num + 1;
 }
 
-static void cpsw_add_mcast(struct cpsw_priv *priv, const u8 *addr)
-{
-	struct cpsw_common *cpsw = priv->cpsw;
-
-	if (cpsw->data.dual_emac) {
-		struct cpsw_slave *slave = cpsw->slaves + priv->emac_port;
-
-		cpsw_ale_add_mcast(cpsw->ale, addr, ALE_PORT_HOST,
-				   ALE_VLAN, slave->port_vlan, 0);
-		return;
-	}
-
-	cpsw_ale_add_mcast(cpsw->ale, addr, ALE_ALL_PORTS, 0, 0, 0);
-}
-
 static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
@@ -640,7 +625,7 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 
 			/* Clear all mcast from ALE */
 			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
-			__dev_mc_unsync(ndev, NULL);
+			__hw_addr_ref_unsync_dev(&ndev->mc, ndev, NULL);
 
 			/* Flood All Unicast Packets to Host port */
 			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
@@ -661,29 +646,174 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 	}
 }
 
-static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr)
+static int cpsw_switch_mode(struct net_device *ndev)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
 
-	cpsw_add_mcast(priv, addr);
-	return 0;
+	return !(cpsw->data.dual_emac || cpsw->data.slaves == 1);
 }
 
-static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr)
+struct addr_sync_ctx {
+	struct net_device *ndev;
+	const u8 *addr;		/* address to be synched */
+	int consumed;		/* number of address instances */
+	int flush;		/* flush flag */
+};
+
+/**
+ * cpsw_set_mc - adds multicast entry to the table if it's not added or deletes
+ * if it's not deleted
+ * @ndev: device to sync
+ * @addr: address to be added or deleted
+ * @vid: vlan id, if vid < 0 set/unset address for real device
+ * @add: add address if the flag is set or remove otherwise
+ */
+static int cpsw_set_mc(struct net_device *ndev, const u8 *addr,
+		       int vid, int add)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
 	struct cpsw_common *cpsw = priv->cpsw;
-	int vid, flags;
+	int mask, flags, ret;
 
-	if (cpsw->data.dual_emac) {
-		vid = cpsw->slaves[priv->emac_port].port_vlan;
-		flags = ALE_VLAN;
-	} else {
-		vid = 0;
-		flags = 0;
+	if (vid < 0) {
+		if (cpsw->data.dual_emac)
+			vid = cpsw->slaves[priv->emac_port].port_vlan;
+		else
+			vid = 0;
+	}
+
+	mask = cpsw->data.dual_emac ? ALE_PORT_HOST : ALE_ALL_PORTS;
+	flags = vid ? ALE_VLAN : 0;
+
+	if (add)
+		ret = cpsw_ale_add_mcast(cpsw->ale, addr, mask, flags, vid, 0);
+	else
+		ret = cpsw_ale_del_mcast(cpsw->ale, addr, 0, flags, vid);
+
+	return ret;
+}
+
+static int cpsw_update_vlan_mc(struct net_device *vdev, int vid, void *ctx)
+{
+	struct addr_sync_ctx *sync_ctx = ctx;
+	struct netdev_hw_addr *ha;
+	int found = 0, ret = 0;
+
+	if (!vdev || !(vdev->flags & IFF_UP))
+		return 0;
+
+	/* vlan address is relevant if its sync_cnt != 0 */
+	netdev_for_each_mc_addr(ha, vdev) {
+		if (ether_addr_equal(ha->addr, sync_ctx->addr)) {
+			found = ha->sync_cnt;
+			break;
+		}
+	}
+
+	if (found)
+		sync_ctx->consumed++;
+
+	if (sync_ctx->flush) {
+		if (!found)
+			cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 0);
+		return 0;
+	}
+
+	if (found)
+		ret = cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 1);
+
+	return ret;
+}
+
+static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr, int num)
+{
+	struct addr_sync_ctx sync_ctx;
+	int ret;
+
+	/* leave for legacy switch mode untracked ALE entries */
+	if (cpsw_switch_mode(ndev)) {
+		ret = cpsw_set_mc(ndev, addr, -1, 1);
+		return ret;
+	}
+
+	sync_ctx.consumed = 0;
+	sync_ctx.addr = addr;
+	sync_ctx.ndev = ndev;
+	sync_ctx.flush = 0;
+
+	ret = vlan_for_each(ndev, cpsw_update_vlan_mc, &sync_ctx);
+	if (sync_ctx.consumed < num && !ret)
+		ret = cpsw_set_mc(ndev, addr, -1, 1);
+
+	return ret;
+}
+
+static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr, int num)
+{
+	struct addr_sync_ctx sync_ctx;
+
+	/* leave for legacy switch mode untracked ALE entries */
+	if (cpsw_switch_mode(ndev)) {
+		if (!num)
+			cpsw_set_mc(ndev, addr, -1, 0);
+		return 0;
+	}
+
+	sync_ctx.consumed = 0;
+	sync_ctx.addr = addr;
+	sync_ctx.ndev = ndev;
+	sync_ctx.flush = 1;
+
+	vlan_for_each(ndev, cpsw_update_vlan_mc, &sync_ctx);
+	if (sync_ctx.consumed == num)
+		cpsw_set_mc(ndev, addr, -1, 0);
+
+	return 0;
+}
+
+static int cpsw_purge_vlan_mc(struct net_device *vdev, int vid, void *ctx)
+{
+	struct addr_sync_ctx *sync_ctx = ctx;
+	struct netdev_hw_addr *ha;
+	int found = 0;
+
+	if (!vdev || !(vdev->flags & IFF_UP))
+		return 0;
+
+	/* vlan address is relevant if its sync_cnt != 0 */
+	netdev_for_each_mc_addr(ha, vdev) {
+		if (ether_addr_equal(ha->addr, sync_ctx->addr)) {
+			found = ha->sync_cnt;
+			break;
+		}
 	}
 
-	cpsw_ale_del_mcast(cpsw->ale, addr, 0, flags, vid);
+	if (!found)
+		return 0;
+
+	sync_ctx->consumed++;
+	cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 0);
+	return 0;
+}
+
+static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
+{
+	struct addr_sync_ctx sync_ctx;
+
+	/* leave for legacy switch mode untracked ALE entries */
+	if (cpsw_switch_mode(ndev)) {
+		cpsw_set_mc(ndev, addr, -1, 0);
+		return 0;
+	}
+
+	sync_ctx.addr = addr;
+	sync_ctx.ndev = ndev;
+	sync_ctx.consumed = 0;
+
+	vlan_for_each(ndev, cpsw_purge_vlan_mc, &sync_ctx);
+	if (sync_ctx.consumed < num)
+		cpsw_set_mc(ndev, addr, -1, 0);
+
 	return 0;
 }
 
@@ -704,7 +834,9 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	/* Restore allmulti on vlans if necessary */
 	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
 
-	__dev_mc_sync(ndev, cpsw_add_mc_addr, cpsw_del_mc_addr);
+	/* add/remove mcast address either for real netdev or for vlan */
+	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
+			       cpsw_del_mc_addr);
 }
 
 static void cpsw_intr_enable(struct cpsw_common *cpsw)
@@ -1964,7 +2096,7 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
-	__dev_mc_unsync(priv->ndev, cpsw_del_mc_addr);
+	__hw_addr_ref_unsync_dev(&ndev->mc, ndev, cpsw_purge_all_mc);
 	netif_tx_stop_all_queues(priv->ndev);
 	netif_carrier_off(priv->ndev);
 
@@ -2415,6 +2547,7 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
 				  HOST_PORT_NUM, ALE_VLAN, vid);
 	ret |= cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
 				  0, ALE_VLAN, vid);
+	ret |= cpsw_ale_flush_multicast(cpsw->ale, 0, vid);
 err:
 	pm_runtime_put(cpsw->dev);
 	return ret;
-- 
2.17.1
