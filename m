From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/6] ARM: dts: dra7: switch to use phy-gmii-sel
Date: Wed, 20 Feb 2019 17:25:14 +0200
Message-ID: <1550676319-6440-2-git-send-email-grygorii.strashko@ti.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index bb45cb7fc3b6..414f1cd68733 100644
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
@@ -3099,7 +3099,6 @@
 					     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
 				ranges = <0 0 0x4000>;
 				syscon = <&scm_conf>;
-				cpsw-phy-sel = <&phy_sel>;
 				status = "disabled";
 
 				davinci_mdio: mdio@1000 {
@@ -3114,11 +3113,13 @@
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
2.17.1
