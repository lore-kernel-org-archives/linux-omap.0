From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 04/10] net: ethernet: ti: cpsw: add support for port interface mode selection phy
Date: Sun, 25 Nov 2018 18:15:25 -0600
Message-ID: <20181126001531.12974-5-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Add support for port interface mode selection phy (phy-gmii-sel):
- try to request interface mode selection phy from Port DT node and fail
silently if not defined and old CONFIG_TI_CPSW_PHY_SEL driver enabled.
- use new phy if requested successfully.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index e4aa030..ceaec56 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -26,6 +26,7 @@
 #include <linux/netdevice.h>
 #include <linux/net_tstamp.h>
 #include <linux/phy.h>
+#include <linux/phy/phy.h>
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
@@ -387,6 +388,7 @@ struct cpsw_slave_data {
 	int		phy_if;
 	u8		mac_addr[ETH_ALEN];
 	u16		dual_emac_res_vlan;	/* Reserved VLAN for DualEMAC */
+	struct phy	*ifphy;
 };
 
 struct cpsw_platform_data {
@@ -1624,7 +1626,12 @@ static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
 	phy_start(slave->phy);
 
 	/* Configure GMII_SEL register */
-	cpsw_phy_sel(cpsw->dev, slave->phy->interface, slave->slave_num);
+	if (!IS_ERR(slave->data->ifphy))
+		phy_set_mode_ext(slave->data->ifphy, PHY_MODE_ETHERNET,
+				 slave->data->phy_if);
+	else
+		cpsw_phy_sel(cpsw->dev, slave->phy->interface,
+			     slave->slave_num);
 }
 
 static inline void cpsw_add_default_vlan(struct cpsw_priv *priv)
@@ -3274,6 +3281,16 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 		if (strcmp(slave_node->name, "slave"))
 			continue;
 
+		slave_data->ifphy = devm_of_phy_get(&pdev->dev, slave_node,
+						    NULL);
+		if (!IS_ENABLED(CONFIG_TI_CPSW_PHY_SEL) &&
+		    IS_ERR(slave_data->ifphy)) {
+			ret = PTR_ERR(slave_data->ifphy);
+			dev_err(&pdev->dev,
+				"%d: Error retrieving port phy: %d\n", i, ret);
+			return ret;
+		}
+
 		slave_data->phy_node = of_parse_phandle(slave_node,
 							"phy-handle", 0);
 		parp = of_get_property(slave_node, "phy_id", &lenp);
-- 
2.10.5
