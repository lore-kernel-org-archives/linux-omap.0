From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] net: ethernet: cpsw-phy-sel: prefer phandle for phy sel and update binding
Date: Wed,  8 Aug 2018 01:03:54 -0700
Message-ID: <20180808080354.100146-1-tony@atomide.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Murali Karicheri <m-karicheri2@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

The cpsw-phy-sel device is not a child of the cpsw interconnect target
module. It lives in the system control module.

Let's fix this issue by trying to use cpsw-phy-sel phandle first if it
exists and if not fall back to current usage of trying to find the
cpsw-phy-sel child. That way the phy sel driver can be a child of the
system control module where it belongs in the device tree.

Without this fix, we cannot have a proper interconnect target module
hierarchy in device tree for things like genpd.

For documenting it, looks like the cpsw-phy-sel is used for all cpsw device
tree nodes. It's missing the related binding documentation, so let's also
update the binding documentation accordingly.

Cc: devicetree@vger.kernel.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/net/cpsw.txt | 5 +++++
 drivers/net/ethernet/ti/cpsw-phy-sel.c         | 9 ++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
--- a/Documentation/devicetree/bindings/net/cpsw.txt
+++ b/Documentation/devicetree/bindings/net/cpsw.txt
@@ -19,6 +19,9 @@ Required properties:
 - slaves		: Specifies number for slaves
 - active_slave		: Specifies the slave to use for time stamping,
 			  ethtool and SIOCGMIIPHY
+- cpsw-phy-sel		: Specifies the phandle to the CPSW phy mode selection
+			  device. Note that in legacy cases cpsw-phy-sel may be
+			  a child device instead of a phandle.
 
 Optional properties:
 - ti,hwmods		: Must be "cpgmac0"
@@ -75,6 +78,7 @@ Examples:
 		cpts_clock_mult = <0x80000000>;
 		cpts_clock_shift = <29>;
 		syscon = <&cm>;
+		cpsw-phy-sel = <&phy_sel>;
 		cpsw_emac0: slave@0 {
 			phy_id = <&davinci_mdio>, <0>;
 			phy-mode = "rgmii-txid";
@@ -103,6 +107,7 @@ Examples:
 		cpts_clock_mult = <0x80000000>;
 		cpts_clock_shift = <29>;
 		syscon = <&cm>;
+		cpsw-phy-sel = <&phy_sel>;
 		cpsw_emac0: slave@0 {
 			phy_id = <&davinci_mdio>, <0>;
 			phy-mode = "rgmii-txid";
diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/ti/cpsw-phy-sel.c
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -170,10 +170,13 @@ void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave)
 	struct device_node *node;
 	struct cpsw_phy_sel_priv *priv;
 
-	node = of_get_child_by_name(dev->of_node, "cpsw-phy-sel");
+	node = of_parse_phandle(dev->of_node, "cpsw-phy-sel", 0);
 	if (!node) {
-		dev_err(dev, "Phy mode driver DT not found\n");
-		return;
+		node = of_get_child_by_name(dev->of_node, "cpsw-phy-sel");
+		if (!node) {
+			dev_err(dev, "Phy mode driver DT not found\n");
+			return;
+		}
 	}
 
 	dev = bus_find_device(&platform_bus_type, NULL, node, match);
-- 
2.17.1
