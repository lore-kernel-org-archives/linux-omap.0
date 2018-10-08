From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 08/11] ARM: dts: am4372: switch to use phy-gmii-sel
Date: Mon, 8 Oct 2018 18:49:46 -0500
Message-ID: <20181008234949.15416-9-grygorii.strashko@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008234949.15416-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        | 16 +++++++++-------
 arch/arm/boot/dts/am43x-epos-evm.dts |  5 +----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d4b7c59..3dd6d2e 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -212,11 +212,17 @@
 				};
 
 				scm_conf: scm_conf@0 {
-					compatible = "syscon";
+					compatible = "syscon", "simple-bus";
 					reg = <0x0 0x800>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,am43xx-phy-gmii-sel";
+						syscon-scm = <&scm_conf>;
+						#phy-cells = <2>;
+					};
+
 					scm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -714,17 +720,13 @@
 			cpsw_emac0: slave@4a100200 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
+				phys = <&phy_gmii_sel 1 0>;
 			};
 
 			cpsw_emac1: slave@4a100300 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
-			};
-
-			phy_sel: cpsw-phy-sel@44e10650 {
-				compatible = "ti,am43xx-cpsw-phy-sel";
-				reg= <0x44e10650 0x4>;
-				reg-names = "gmii-sel";
+				phys = <&phy_gmii_sel 2 0>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 6502d33..8677f4a 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -580,10 +580,7 @@
 &cpsw_emac0 {
 	phy_id = <&davinci_mdio>, <16>;
 	phy-mode = "rmii";
-};
-
-&phy_sel {
-	rmii-clock-ext;
+	phys = <&phy_gmii_sel 1 1>;
 };
 
 &i2c0 {
-- 
2.10.5
