From: Marek Vasut <marex@denx.de>
Subject: [PATCH] net: ethernet: ti: cpsw: Assign OF node to slave devices
Date: Fri,  7 Dec 2018 18:42:06 +0100
Message-ID: <20181207174206.10765-1-marex@denx.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, ivan.khoronzhuk@linaro.org, grygorii.strashko@ti.com, Marek Vasut <marex@denx.de>, "David S . Miller" <davem@davemloft.net>
List-Id: linux-omap@vger.kernel.org

Assign OF node to CPSW slave devices, otherwise it is not possible to
bind eg. DSA switch to them. Without this patch, the DSA code tries
to find the ethernet device by OF match, but fails to do so because
the slave device has NULL OF node.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index a591583d120e1..702101b0aebd1 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -383,6 +383,7 @@ struct cpsw_hw_stats {
 };
 
 struct cpsw_slave_data {
+	struct device_node *slave_node;
 	struct device_node *phy_node;
 	char		phy_id[MII_BUS_ID_SIZE];
 	int		phy_if;
@@ -3291,6 +3292,7 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 			return ret;
 		}
 
+		slave_data->slave_node = slave_node;
 		slave_data->phy_node = of_parse_phandle(slave_node,
 							"phy-handle", 0);
 		parp = of_get_property(slave_node, "phy_id", &lenp);
@@ -3441,6 +3443,7 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, cpsw->dev);
+	ndev->dev.of_node = cpsw->slaves[1].data->slave_node;
 	ret = register_netdev(ndev);
 	if (ret) {
 		dev_err(cpsw->dev, "cpsw: error registering net device\n");
@@ -3709,6 +3712,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, &pdev->dev);
+	ndev->dev.of_node = cpsw->slaves[0].data->slave_node;
 	ret = register_netdev(ndev);
 	if (ret) {
 		dev_err(priv->dev, "error registering net device\n");
-- 
2.18.0
