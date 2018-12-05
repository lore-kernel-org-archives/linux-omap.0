From: Rob Herring <robh@kernel.org>
Subject: [PATCH] net: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:32 -0600
Message-ID: <20181205195050.4759-16-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Wingman Kwok <w-kwok2@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Wingman Kwok <w-kwok2@ti.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: netdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/ethernet/amd/sunlance.c      | 4 ++--
 drivers/net/ethernet/freescale/gianfar.c | 4 ++--
 drivers/net/ethernet/sun/sunhme.c        | 2 +-
 drivers/net/ethernet/ti/cpsw.c           | 4 ++--
 drivers/net/ethernet/ti/netcp_ethss.c    | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index b4fc0ed5bce8..91c9140d2a52 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -1486,9 +1486,9 @@ static int sunlance_sbus_probe(struct platform_device *op)
 	struct device_node *parent_dp = parent->dev.of_node;
 	int err;
 
-	if (!strcmp(parent_dp->name, "ledma")) {
+	if (of_node_name_eq(parent_dp, "ledma")) {
 		err = sparc_lance_probe_one(op, parent, NULL);
-	} else if (!strcmp(parent_dp->name, "lebuffer")) {
+	} else if (of_node_name_eq(parent_dp, "lebuffer")) {
 		err = sparc_lance_probe_one(op, NULL, parent);
 	} else
 		err = sparc_lance_probe_one(op, NULL, NULL);
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 3c8da1a18ba0..7b5f08725b5b 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -720,7 +720,7 @@ static int gfar_of_group_count(struct device_node *np)
 	int num = 0;
 
 	for_each_available_child_of_node(np, child)
-		if (!of_node_cmp(child->name, "queue-group"))
+		if (of_node_name_eq(child, "queue-group"))
 			num++;
 
 	return num;
@@ -838,7 +838,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	/* Parse and initialize group specific information */
 	if (priv->mode == MQ_MG_MODE) {
 		for_each_available_child_of_node(np, child) {
-			if (of_node_cmp(child->name, "queue-group"))
+			if (!of_node_name_eq(child, "queue-group"))
 				continue;
 
 			err = gfar_parse_group(child, priv, model);
diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index 863fd602fd33..ff641cf30a4e 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -2691,7 +2691,7 @@ static int happy_meal_sbus_probe_one(struct platform_device *op, int is_qfe)
 	sbus_dp = op->dev.parent->of_node;
 
 	/* We can match PCI devices too, do not accept those here. */
-	if (strcmp(sbus_dp->name, "sbus") && strcmp(sbus_dp->name, "sbi"))
+	if (!of_node_name_eq(sbus_dp, "sbus") && !of_node_name_eq(sbus_dp, "sbi"))
 		return err;
 
 	if (is_qfe) {
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 500f7ed8c58c..aeb599f230ab 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3144,7 +3144,7 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 		const __be32 *parp;
 
 		/* This is no slave child node, continue */
-		if (strcmp(slave_node->name, "slave"))
+		if (!of_node_name_eq(slave_node, "slave"))
 			continue;
 
 		slave_data->phy_node = of_parse_phandle(slave_node,
@@ -3240,7 +3240,7 @@ static void cpsw_remove_dt(struct platform_device *pdev)
 	for_each_available_child_of_node(node, slave_node) {
 		struct cpsw_slave_data *slave_data = &data->slave_data[i];
 
-		if (strcmp(slave_node->name, "slave"))
+		if (!of_node_name_eq(slave_node, "slave"))
 			continue;
 
 		if (of_phy_is_fixed_link(slave_node))
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 0397ccb6597e..bfde91ca5df7 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3621,7 +3621,7 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
 		return -EINVAL;
 	}
 
-	if (!strcmp(node->name, "gbe")) {
+	if (of_node_name_eq(node, "gbe")) {
 		ret = get_gbe_resource_version(gbe_dev, node);
 		if (ret)
 			return ret;
@@ -3635,7 +3635,7 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
 		else
 			ret = -ENODEV;
 
-	} else if (!strcmp(node->name, "xgbe")) {
+	} else if (of_node_name_eq(node, "xgbe")) {
 		ret = set_xgbe_ethss10_priv(gbe_dev, node);
 		if (ret)
 			return ret;
-- 
2.19.1
