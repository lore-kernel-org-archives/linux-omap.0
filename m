From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 206/249] net: ethernet: ti: cpsw: Assign OF node to slave devices
Date: Mon, 15 Jul 2019 09:46:11 -0400
Message-ID: <20190715134655.4076-206-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit 337d1727a3895775b5e5ef67d3ca0fea2e2ae768 ]

Assign OF node to CPSW slave devices, otherwise it is not possible to
bind e.g. DSA switch to them. Without this patch, the DSA code tries
to find the ethernet device by OF match, but fails to do so because
the slave device has NULL OF node.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw.c      | 3 +++
 drivers/net/ethernet/ti/cpsw_priv.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 634fc484a0b3..4e3026f9abed 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2179,6 +2179,7 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 			return ret;
 		}
 
+		slave_data->slave_node = slave_node;
 		slave_data->phy_node = of_parse_phandle(slave_node,
 							"phy-handle", 0);
 		parp = of_get_property(slave_node, "phy_id", &lenp);
@@ -2330,6 +2331,7 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, cpsw->dev);
+	ndev->dev.of_node = cpsw->slaves[1].data->slave_node;
 	ret = register_netdev(ndev);
 	if (ret)
 		dev_err(cpsw->dev, "cpsw: error registering net device\n");
@@ -2507,6 +2509,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, dev);
+	ndev->dev.of_node = cpsw->slaves[0].data->slave_node;
 	ret = register_netdev(ndev);
 	if (ret) {
 		dev_err(dev, "error registering net device\n");
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 04795b97ee71..e32f11da2dce 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -272,6 +272,7 @@ struct cpsw_host_regs {
 };
 
 struct cpsw_slave_data {
+	struct device_node *slave_node;
 	struct device_node *phy_node;
 	char		phy_id[MII_BUS_ID_SIZE];
 	int		phy_if;
-- 
2.20.1
