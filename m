From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 4/4] ARM: dts: <am4372/dra7/omap5>: Use "syscon-phy-power" instead of "ctrl-module"
Date: Tue, 15 Sep 2015 19:03:05 +0530
Message-ID: <1442323985-29939-5-git-send-email-kishon@ti.com>
References: <1442323985-29939-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442323985-29939-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nsekhar@ti.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
property from SATA and USB PHY node. Also remove the unused control
module dt nodes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   16 ++--------------
 arch/arm/boot/dts/dra7.dtsi   |   34 ++++------------------------------
 arch/arm/boot/dts/omap5.dtsi  |   26 +++-----------------------
 3 files changed, 9 insertions(+), 67 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0447c04a..fd162d8 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -852,18 +852,6 @@
 			status = "disabled";
 		};
 
-		am43xx_control_usb2phy1: control-phy@44e10620 {
-			compatible = "ti,control-phy-usb2-am437";
-			reg = <0x44e10620 0x4>;
-			reg-names = "power";
-		};
-
-		am43xx_control_usb2phy2: control-phy@0x44e10628 {
-			compatible = "ti,control-phy-usb2-am437";
-			reg = <0x44e10628 0x4>;
-			reg-names = "power";
-		};
-
 		ocp2scp0: ocp2scp@483a8000 {
 			compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp";
 			#address-cells = <1>;
@@ -874,7 +862,7 @@
 			usb2_phy1: phy@483a8000 {
 				compatible = "ti,am437x-usb2";
 				reg = <0x483a8000 0x8000>;
-				ctrl-module = <&am43xx_control_usb2phy1>;
+				syscon-phy-power = <&scm_conf 0x620>;
 				clocks = <&usb_phy0_always_on_clk32k>,
 					 <&usb_otg_ss0_refclk960m>;
 				clock-names = "wkupclk", "refclk";
@@ -893,7 +881,7 @@
 			usb2_phy2: phy@483e8000 {
 				compatible = "ti,am437x-usb2";
 				reg = <0x483e8000 0x8000>;
-				ctrl-module = <&am43xx_control_usb2phy2>;
+				syscon-phy-power = <&scm_conf 0x628>;
 				clocks = <&usb_phy1_always_on_clk32k>,
 					 <&usb_otg_ss1_refclk960m>;
 				clock-names = "wkupclk", "refclk";
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 65eecb3..ad1bb2d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1124,14 +1124,6 @@
 			status = "disabled";
 		};
 
-		omap_control_sata: control-phy@4a002374 {
-			compatible = "ti,control-phy-pipe3";
-			reg = <0x4a002374 0x4>;
-			reg-names = "power";
-			clocks = <&sys_clkin1>;
-			clock-names = "sysclk";
-		};
-
 		/* OCP2SCP3 */
 		ocp2scp@4a090000 {
 			compatible = "ti,omap-ocp2scp";
@@ -1146,7 +1138,7 @@
 				      <0x4A096400 0x64>, /* phy_tx */
 				      <0x4A096800 0x40>; /* pll_ctrl */
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_sata>;
+				syscon-phy-power = <&scm_conf 0x374>;
 				clocks = <&sys_clkin1>, <&sata_ref_clk>;
 				clock-names = "sysclk", "refclk";
 				syscon-pllreset = <&scm_conf 0x3fc>;
@@ -1213,24 +1205,6 @@
 			clocks = <&sys_32k_ck>;
 		};
 
-		omap_control_usb2phy1: control-phy@4a002300 {
-			compatible = "ti,control-phy-usb2";
-			reg = <0x4a002300 0x4>;
-			reg-names = "power";
-		};
-
-		omap_control_usb3phy1: control-phy@4a002370 {
-			compatible = "ti,control-phy-pipe3";
-			reg = <0x4a002370 0x4>;
-			reg-names = "power";
-		};
-
-		omap_control_usb2phy2: control-phy@0x4a002e74 {
-			compatible = "ti,control-phy-usb2-dra7";
-			reg = <0x4a002e74 0x4>;
-			reg-names = "power";
-		};
-
 		/* OCP2SCP1 */
 		ocp2scp@4a080000 {
 			compatible = "ti,omap-ocp2scp";
@@ -1243,7 +1217,7 @@
 			usb2_phy1: phy@4a084000 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x400>;
-				ctrl-module = <&omap_control_usb2phy1>;
+				syscon-phy-power = <&scm_conf 0x300>;
 				clocks = <&usb_phy1_always_on_clk32k>,
 					 <&usb_otg_ss1_refclk960m>;
 				clock-names =	"wkupclk",
@@ -1254,7 +1228,7 @@
 			usb2_phy2: phy@4a085000 {
 				compatible = "ti,dra7x-usb2-phy2", "ti,omap-usb2";
 				reg = <0x4a085000 0x400>;
-				ctrl-module = <&omap_control_usb2phy2>;
+				syscon-phy-power = <&scm_conf 0xe74>;
 				clocks = <&usb_phy2_always_on_clk32k>,
 					 <&usb_otg_ss2_refclk960m>;
 				clock-names =	"wkupclk",
@@ -1268,7 +1242,7 @@
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_usb3phy1>;
+				syscon-phy-power = <&scm_conf 0x370>;
 				clocks = <&usb_phy3_always_on_clk32k>,
 					 <&sys_clkin1>,
 					 <&usb_otg_ss1_refclk960m>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 4205a8a..6335449 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -849,18 +849,6 @@
 			hw-caps-temp-alert;
 		};
 
-		omap_control_usb2phy: control-phy@4a002300 {
-			compatible = "ti,control-phy-usb2";
-			reg = <0x4a002300 0x4>;
-			reg-names = "power";
-		};
-
-		omap_control_usb3phy: control-phy@4a002370 {
-			compatible = "ti,control-phy-pipe3";
-			reg = <0x4a002370 0x4>;
-			reg-names = "power";
-		};
-
 		usb3: omap_dwc3@4a020000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss";
@@ -896,7 +884,7 @@
 			usb2_phy: usb2phy@4a084000 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
-				ctrl-module = <&omap_control_usb2phy>;
+				syscon-phy-power = <&scm_conf 0x300>;
 				clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
 				clock-names = "wkupclk", "refclk";
 				#phy-cells = <0>;
@@ -908,7 +896,7 @@
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_usb3phy>;
+				syscon-phy-power = <&scm_conf 0x370>;
 				clocks = <&usb_phy_cm_clk32k>,
 					 <&sys_clkin>,
 					 <&usb_otg_ss_refclk960m>;
@@ -964,14 +952,6 @@
 			#thermal-sensor-cells = <1>;
 		};
 
-		omap_control_sata: control-phy@4a002374 {
-			compatible = "ti,control-phy-pipe3";
-			reg = <0x4a002374 0x4>;
-			reg-names = "power";
-			clocks = <&sys_clkin>;
-			clock-names = "sysclk";
-		};
-
 		/* OCP2SCP3 */
 		ocp2scp@4a090000 {
 			compatible = "ti,omap-ocp2scp";
@@ -986,7 +966,7 @@
 				      <0x4A096400 0x64>, /* phy_tx */
 				      <0x4A096800 0x40>; /* pll_ctrl */
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_sata>;
+				syscon-phy-power = <&scm_conf 0x374>;
 				clocks = <&sys_clkin>, <&sata_ref_clk>;
 				clock-names = "sysclk", "refclk";
 				#phy-cells = <0>;
-- 
1.7.9.5
