From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 09/11] ARM: dts: am335x: switch to use phy-gmii-sel
Date: Mon, 8 Oct 2018 18:49:47 -0500
Message-ID: <20181008234949.15416-10-grygorii.strashko@ti.com>
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
 arch/arm/boot/dts/am335x-baltos-ir2110.dts     |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir3220.dts     |  3 ---
 arch/arm/boot/dts/am335x-baltos-ir5221.dts     |  3 ---
 arch/arm/boot/dts/am335x-chiliboard.dts        |  3 ---
 arch/arm/boot/dts/am335x-icev2.dts             |  4 ----
 arch/arm/boot/dts/am335x-igep0033.dtsi         |  3 ---
 arch/arm/boot/dts/am335x-lxm.dts               |  3 ---
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts |  5 -----
 arch/arm/boot/dts/am335x-phycore-som.dtsi      |  3 ---
 arch/arm/boot/dts/am33xx.dtsi                  | 14 ++++++++------
 10 files changed, 8 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
index 75de1e7..50dcf12 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir2110.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
@@ -72,7 +72,3 @@
 	dual_emac_res_vlan = <2>;
 	phy-handle = <&phy1>;
 };
-
-&phy_sel {
-	rmii-clock-ext = <1>;
-};
diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index 1b215c4..44f7858 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -115,6 +115,3 @@
 	phy-handle = <&phy1>;
 };
 
-&phy_sel {
-	rmii-clock-ext = <1>;
-};
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 832ead8..1e10813 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -133,9 +133,6 @@
 	phy-handle = <&phy1>;
 };
 
-&phy_sel {
-	rmii-clock-ext = <1>;
-};
 
 &dcan1 {
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/am335x-chiliboard.dts
index 59431b2..7b77315 100644
--- a/arch/arm/boot/dts/am335x-chiliboard.dts
+++ b/arch/arm/boot/dts/am335x-chiliboard.dts
@@ -147,9 +147,6 @@
 	phy-mode = "rmii";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
 
 /* USB */
 &usb {
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index f2005ec..9ac775c 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -484,10 +484,6 @@
 	dual_emac;
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
-
 &davinci_mdio {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&davinci_mdio_default>;
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index a5769a8..2bc8456 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -114,9 +114,6 @@
 	phy-mode = "rmii";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
 
 &elm {
 	status = "okay";
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index 1d6c6fa..56b354b1 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -328,9 +328,6 @@
 	dual_emac_res_vlan = <3>;
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
 
 &mac {
 	pinctrl-names = "default", "sleep";
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
index f82233c..5563e92 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -438,11 +438,6 @@
 	dual_emac_res_vlan = <2>;
 };
 
-&phy_sel {
-	reg= <0x44e10650 0xf5>;
-	rmii-clock-ext;
-};
-
 &sham {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 428a25e..cf40a2b 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -100,9 +100,6 @@
 	status = "okay";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
 
 /* I2C Busses */
 &am33xx_pinmux {
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index d3dd6a1..3179b24 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -222,6 +222,12 @@
 					#size-cells = <1>;
 					ranges = <0 0 0x800>;
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,am3352-phy-gmii-sel";
+						syscon-scm = <&scm_conf>;
+						#phy-cells = <2>;
+					};
+
 					scm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -890,17 +896,13 @@
 			cpsw_emac0: slave@4a100200 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
+				phys = <&phy_gmii_sel 1 1>;
 			};
 
 			cpsw_emac1: slave@4a100300 {
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
-			};
-
-			phy_sel: cpsw-phy-sel@44e10650 {
-				compatible = "ti,am3352-cpsw-phy-sel";
-				reg= <0x44e10650 0x4>;
-				reg-names = "gmii-sel";
+				phys = <&phy_gmii_sel 2 1>;
 			};
 		};
 
-- 
2.10.5
