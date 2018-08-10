From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 2/2] net: ethernet: ti: cpsw: fix runtime_pm while add/kill vlan
Date: Fri, 10 Aug 2018 15:47:09 +0300
Message-ID: <20180810124709.25089-3-ivan.khoronzhuk@linaro.org>
References: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

It's exclusive with normal behaviour but if try to set vlan to one of
the reserved values is made, the cpsw runtime pm is broken.

Fixes: commit a6c5d14f5136
("drivers: net: cpsw: ndev: fix accessing to suspended device")

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 9edac671f276..3e34cb8ac1d3 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2086,14 +2086,16 @@ static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
 		int i;
 
 		for (i = 0; i < cpsw->data.slaves; i++) {
-			if (vid == cpsw->slaves[i].port_vlan)
-				return -EINVAL;
+			if (vid == cpsw->slaves[i].port_vlan) {
+				ret = -EINVAL;
+				goto err;
+			}
 		}
 	}
 
 	dev_info(priv->dev, "Adding vlanid %d to vlan filter\n", vid);
 	ret = cpsw_add_vlan_ale_entry(priv, vid);
-
+err:
 	pm_runtime_put(cpsw->dev);
 	return ret;
 }
@@ -2119,7 +2121,7 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
 
 		for (i = 0; i < cpsw->data.slaves; i++) {
 			if (vid == cpsw->slaves[i].port_vlan)
-				return -EINVAL;
+				goto err;
 		}
 	}
 
@@ -2129,6 +2131,7 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
 				  HOST_PORT_NUM, ALE_VLAN, vid);
 	ret |= cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
 				  0, ALE_VLAN, vid);
+err:
 	pm_runtime_put(cpsw->dev);
 	return ret;
 }
-- 
2.17.1
