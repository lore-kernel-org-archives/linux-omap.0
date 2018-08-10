From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 1/2] net: ethernet: ti: cpsw: clear all entries when delete vid
Date: Fri, 10 Aug 2018 15:47:08 +0300
Message-ID: <20180810124709.25089-2-ivan.khoronzhuk@linaro.org>
References: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

In cases if some of the entries were not found in forwarding table
while killing vlan, the rest not needed entries still left in the
table. No need to stop, as entry was deleted anyway. So fix this by
returning error only after all was cleaned. To implement this, return
-ENOENT in cpsw_ale_del_mcast() as it's supposed to be.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c     | 14 ++++----------
 drivers/net/ethernet/ti/cpsw_ale.c |  2 +-
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 358edab9e72e..9edac671f276 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2125,16 +2125,10 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
 
 	dev_info(priv->dev, "removing vlanid %d from vlan filter\n", vid);
 	ret = cpsw_ale_del_vlan(cpsw->ale, vid, 0);
-	if (ret != 0)
-		return ret;
-
-	ret = cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
-				 HOST_PORT_NUM, ALE_VLAN, vid);
-	if (ret != 0)
-		return ret;
-
-	ret = cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
-				 0, ALE_VLAN, vid);
+	ret |= cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
+				  HOST_PORT_NUM, ALE_VLAN, vid);
+	ret |= cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
+				  0, ALE_VLAN, vid);
 	pm_runtime_put(cpsw->dev);
 	return ret;
 }
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 93dc05c194d3..5766225a4ce1 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -394,7 +394,7 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
 
 	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
 	if (idx < 0)
-		return -EINVAL;
+		return -ENOENT;
 
 	cpsw_ale_read(ale, idx, ale_entry);
 
-- 
2.17.1
