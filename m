From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] net: ethernet: ti: cpsw: Add of_node_put() before return and break
Date: Tue, 16 Jul 2019 11:18:43 +0530
Message-ID: <20190716054843.2957-1-nishkadg.linux@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net, ivan.khoronzhuk@linaro.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org
Cc: Nishka Dasgupta <nishkadg.linux@gmail.com>
List-Id: linux-omap@vger.kernel.org

Each iteration of for_each_available_child_of_node puts the previous
node, but in the case of a return or break from the middle of the loop,
there is no put, thus causing a memory leak.
Hence, for function cpsw_probe_dt, create an extra label err_node_put
that puts the last used node and returns ret; modify the return
statements in the loop to save the return value in ret and goto this new
label.
For function cpsw_remove_dt, add an of_node_put before the break.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index f320f9a0de8b..32a89744972d 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2570,7 +2570,7 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 			ret = PTR_ERR(slave_data->ifphy);
 			dev_err(&pdev->dev,
 				"%d: Error retrieving port phy: %d\n", i, ret);
-			return ret;
+			goto err_node_put;
 		}
 
 		slave_data->slave_node = slave_node;
@@ -2589,7 +2589,7 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 			if (ret) {
 				if (ret != -EPROBE_DEFER)
 					dev_err(&pdev->dev, "failed to register fixed-link phy: %d\n", ret);
-				return ret;
+				goto err_node_put;
 			}
 			slave_data->phy_node = of_node_get(slave_node);
 		} else if (parp) {
@@ -2607,7 +2607,8 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 			of_node_put(mdio_node);
 			if (!mdio) {
 				dev_err(&pdev->dev, "Missing mdio platform device\n");
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_node_put;
 			}
 			snprintf(slave_data->phy_id, sizeof(slave_data->phy_id),
 				 PHY_ID_FMT, mdio->name, phyid);
@@ -2622,7 +2623,8 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 		if (slave_data->phy_if < 0) {
 			dev_err(&pdev->dev, "Missing or malformed slave[%d] phy-mode property\n",
 				i);
-			return slave_data->phy_if;
+			ret = slave_data->phy_if;
+			goto err_node_put;
 		}
 
 no_phy_slave:
@@ -2633,7 +2635,7 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 			ret = ti_cm_get_macid(&pdev->dev, i,
 					      slave_data->mac_addr);
 			if (ret)
-				return ret;
+				goto err_node_put;
 		}
 		if (data->dual_emac) {
 			if (of_property_read_u32(slave_node, "dual_emac_res_vlan",
@@ -2648,11 +2650,17 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 		}
 
 		i++;
-		if (i == data->slaves)
-			break;
+		if (i == data->slaves) {
+			ret = 0;
+			goto err_node_put;
+		}
 	}
 
 	return 0;
+
+err_node_put:
+	of_node_put(slave_node);
+	return ret;
 }
 
 static void cpsw_remove_dt(struct platform_device *pdev)
@@ -2675,8 +2683,10 @@ static void cpsw_remove_dt(struct platform_device *pdev)
 		of_node_put(slave_data->phy_node);
 
 		i++;
-		if (i == data->slaves)
+		if (i == data->slaves) {
+			of_node_put(slave_node);
 			break;
+		}
 	}
 
 	of_platform_depopulate(&pdev->dev);
-- 
2.19.1
