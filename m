From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 05/10] ARM: dts: dra7: switch to use phy-gmii-sel
Date: Sun, 25 Nov 2018 18:15:26 -0600
Message-ID: <20181126001531.12974-6-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 7e5c0d4f..7070095 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -77,18 +77,18 @@
 						};
 					};
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,dra7xx-phy-gmii-sel";
+						reg = <0x554 0x4>;
+						#phy-cells = <1>;
+					};
+
 					scm_conf_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
 					};
 				};
 
-				phy_sel: cpsw-phy-sel@554 {
-					compatible = "ti,dra7xx-cpsw-phy-sel";
-					reg= <0x554 0x4>;
-					reg-names = "gmii-sel";
-				};
-
 				dra7_pmx_core: pinmux@1400 {
 					compatible = "ti,dra7-padconf",
 						     "pinctrl-single";
@@ -3060,7 +3060,6 @@
 					     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
 				ranges = <0 0 0x4000>;
 				syscon = <&scm_conf>;
-				cpsw-phy-sel = <&phy_sel>;
 				status = "disabled";
 
 				davinci_mdio: mdio@1000 {
@@ -3075,11 +3074,13 @@
 				cpsw_emac0: slave@200 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 1>;
 				};
 
 				cpsw_emac1: slave@300 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 2>;
 				};
 			};
 		};
-- 
2.10.5
