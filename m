From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] dt-bindings: net: cpsw: Document cpsw-phy-sel usage but prefer phandle
Date: Wed, 29 Aug 2018 08:00:23 -0700
Message-ID: <20180829150024.43210-1-tony@atomide.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Murali Karicheri <m-karicheri2@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

The current cpsw usage for cpsw-phy-sel is undocumented but is used for
all the boards using cpsw. And cpsw-phy-sel is not really a child of
the cpsw device, it lives in the system control module instead.

Let's document the existing usage, and improve it a bit where we prefer
to use a phandle instead of a child device for it. That way we can
properly describe the hardware in dts files for things like genpd.

Cc: devicetree@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/net/cpsw.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
--- a/Documentation/devicetree/bindings/net/cpsw.txt
+++ b/Documentation/devicetree/bindings/net/cpsw.txt
@@ -19,6 +19,10 @@ Required properties:
 - slaves		: Specifies number for slaves
 - active_slave		: Specifies the slave to use for time stamping,
 			  ethtool and SIOCGMIIPHY
+- cpsw-phy-sel		: Specifies the phandle to the CPSW phy mode selection
+			  device. See also cpsw-phy-sel.txt for it's binding.
+			  Note that in legacy cases cpsw-phy-sel may be
+			  a child device instead of a phandle.
 
 Optional properties:
 - ti,hwmods		: Must be "cpgmac0"
@@ -75,6 +79,7 @@ Examples:
 		cpts_clock_mult = <0x80000000>;
 		cpts_clock_shift = <29>;
 		syscon = <&cm>;
+		cpsw-phy-sel = <&phy_sel>;
 		cpsw_emac0: slave@0 {
 			phy_id = <&davinci_mdio>, <0>;
 			phy-mode = "rgmii-txid";
@@ -103,6 +108,7 @@ Examples:
 		cpts_clock_mult = <0x80000000>;
 		cpts_clock_shift = <29>;
 		syscon = <&cm>;
+		cpsw-phy-sel = <&phy_sel>;
 		cpsw_emac0: slave@0 {
 			phy_id = <&davinci_mdio>, <0>;
 			phy-mode = "rgmii-txid";
-- 
2.18.0
