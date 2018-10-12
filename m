From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: use for mcast entries only host port
Date: Fri, 12 Oct 2018 19:06:29 +0300
Message-ID: <20181012160629.7245-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

In dual-emac mode the cpsw driver sends directed packets, that means
that packets go to the directed port, but an ALE lookup is performed
to determine untagged egress only. It means that on tx side no need
to add port bit for ALE mcast entry mask, and basically ALE entry
for port identification is needed only on rx side.

So, add only host port in dual_emac mode as used directed
transmission, and no need in one more port. For single port boards
and switch mode all ports used, as usual, so no changes for them.
Also it simplifies farther changes.

In other words, mcast entries for dual-emac should behave exactly
like unicast. It also can help avoid leaking packets between ports
with same vlan on h/w level if ports could became members of same vid.

So now, for instance, if mcast address 33:33:00:00:00:01 is added then
entries in ALE table:

vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x1
vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x1

Instead of:
vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x3
vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x5

With the same considerations, set only host port for unregistered
mcast for dual-emac mode in case of IFF_ALLMULTI is set, exactly like
it's done in cpsw_ale_set_allmulti().

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

 drivers/net/ethernet/ti/cpsw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 16dcbf36f8cc..7bfb7ee3a261 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -576,10 +576,8 @@ static void cpsw_add_mcast(struct cpsw_priv *priv, u8 *addr)
 
 	if (cpsw->data.dual_emac) {
 		struct cpsw_slave *slave = cpsw->slaves + priv->emac_port;
-		int slave_port = cpsw_get_slave_port(slave->slave_num);
 
-		cpsw_ale_add_mcast(cpsw->ale, addr,
-				   1 << slave_port | ALE_PORT_HOST,
+		cpsw_ale_add_mcast(cpsw->ale, addr, ALE_PORT_HOST,
 				   ALE_VLAN, slave->port_vlan, 0);
 		return;
 	}
@@ -1410,7 +1408,7 @@ static inline void cpsw_add_dual_emac_def_ale_entries(
 	cpsw_ale_add_vlan(cpsw->ale, slave->port_vlan, port_mask,
 			  port_mask, port_mask, 0);
 	cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
-			   port_mask, ALE_VLAN, slave->port_vlan, 0);
+			   ALE_PORT_HOST, ALE_VLAN, slave->port_vlan, 0);
 	cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
 			   HOST_PORT_NUM, ALE_VLAN |
 			   ALE_SECURE, slave->port_vlan);
@@ -2293,16 +2291,19 @@ static inline int cpsw_add_vlan_ale_entry(struct cpsw_priv *priv,
 {
 	int ret;
 	int unreg_mcast_mask = 0;
+	int mcast_mask;
 	u32 port_mask;
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	if (cpsw->data.dual_emac) {
 		port_mask = (1 << (priv->emac_port + 1)) | ALE_PORT_HOST;
 
+		mcast_mask = ALE_PORT_HOST;
 		if (priv->ndev->flags & IFF_ALLMULTI)
-			unreg_mcast_mask = port_mask;
+			unreg_mcast_mask = mcast_mask;
 	} else {
 		port_mask = ALE_ALL_PORTS;
+		mcast_mask = port_mask;
 
 		if (priv->ndev->flags & IFF_ALLMULTI)
 			unreg_mcast_mask = ALE_ALL_PORTS;
@@ -2321,7 +2322,7 @@ static inline int cpsw_add_vlan_ale_entry(struct cpsw_priv *priv,
 		goto clean_vid;
 
 	ret = cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
-				 port_mask, ALE_VLAN, vid, 0);
+				 mcast_mask, ALE_VLAN, vid, 0);
 	if (ret != 0)
 		goto clean_vlan_ucast;
 	return 0;
-- 
2.17.1
