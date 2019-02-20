From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 4/6] ARM: dts: am335x: switch to use phy-gmii-sel
Date: Wed, 20 Feb 2019 17:25:17 +0200
Message-ID: <1550676319-6440-5-git-send-email-grygorii.strashko@ti.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am335x-baltos-ir2110.dts        |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir3220.dts        |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir5221.dts        |  4 ----
 arch/arm/boot/dts/am335x-chiliboard.dts           |  4 ----
 arch/arm/boot/dts/am335x-icev2.dts                |  4 ----
 arch/arm/boot/dts/am335x-igep0033.dtsi            |  4 ----
 arch/arm/boot/dts/am335x-lxm.dts                  |  4 ----
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi |  5 -----
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts    |  5 -----
 arch/arm/boot/dts/am335x-phycore-som.dtsi         |  4 ----
 arch/arm/boot/dts/am33xx-l4.dtsi                  | 15 ++++++++-------
 11 files changed, 8 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
index 75de1e723303..50dcf1290ac6 100644
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
index 1b215c425c57..f3f1abd26470 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -114,7 +114,3 @@
 	dual_emac_res_vlan = <2>;
 	phy-handle = <&phy1>;
 };
-
-&phy_sel {
-	rmii-clock-ext = <1>;
-};
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 832ead864dc5..42f473f0ed77 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -133,10 +133,6 @@
 	phy-handle = <&phy1>;
 };
 
-&phy_sel {
-	rmii-clock-ext = <1>;
-};
-
 &dcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dcan1_pins>;
diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/am335x-chiliboard.dts
index 9c2a947aacf5..4a869534db50 100644
--- a/arch/arm/boot/dts/am335x-chiliboard.dts
+++ b/arch/arm/boot/dts/am335x-chiliboard.dts
@@ -151,10 +151,6 @@
 	phy-mode = "rmii";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
-
 /* USB */
 &usb {
 	status = "okay";
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index f2005ecca74f..9ac775c71072 100644
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
index 55b4c94cfafb..cbd22f25de95 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -123,10 +123,6 @@
 	phy-mode = "rmii";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
-
 &elm {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index 481edcfaf121..d0e8e720a4d6 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -328,10 +328,6 @@
 	dual_emac_res_vlan = <3>;
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
-
 &mac {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&cpsw_default>;
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
index 14f781953475..cb5913a69837 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -159,11 +159,6 @@
 	status = "okay";
 };
 
-&phy_sel {
-	reg= <0x44e10650 0xf5>;
-	rmii-clock-ext;
-};
-
 &sham {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
index 5a58efc0c874..e562ce40f290 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -446,11 +446,6 @@
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
index 428a25e952b0..015adb626b03 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -100,10 +100,6 @@
 	status = "okay";
 };
 
-&phy_sel {
-	rmii-clock-ext;
-};
-
 /* I2C Busses */
 &am33xx_pinmux {
 	i2c0_pins: pinmux_i2c0 {
diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 7b818d9d2eab..f813131f8461 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -279,12 +279,6 @@
 				#pinctrl-cells = <1>;
 				ranges = <0 0 0x2000>;
 
-				phy_sel: cpsw-phy-sel@650 {
-					compatible = "ti,am3352-cpsw-phy-sel";
-					reg= <0x650 0x4>;
-					reg-names = "gmii-sel";
-				};
-
 				am33xx_pinmux: pinmux@800 {
 					compatible = "pinctrl-single";
 					reg = <0x800 0x238>;
@@ -302,6 +296,12 @@
 					#size-cells = <1>;
 					ranges = <0 0 0x800>;
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,am3352-phy-gmii-sel";
+						reg = <0x650 0x4>;
+						#phy-cells = <2>;
+					};
+
 					scm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -717,7 +717,6 @@
 				interrupts = <40 41 42 43>;
 				ranges = <0 0 0x8000>;
 				syscon = <&scm_conf>;
-				cpsw-phy-sel = <&phy_sel>;
 				status = "disabled";
 
 				davinci_mdio: mdio@1000 {
@@ -733,11 +732,13 @@
 				cpsw_emac0: slave@200 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 1 1>;
 				};
 
 				cpsw_emac1: slave@300 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 2 1>;
 				};
 			};
 		};
-- 
2.17.1
