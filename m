From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 05/10] ARM: dts: dra7: Use "syscon-phy-power" instead of "ctrl-module" in USB PHY node
Date: Tue, 4 Aug 2015 21:00:28 +0530
Message-ID: <1438702233-8027-6-git-send-email-kishon@ti.com>
References: <1438702233-8027-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438702233-8027-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: balbi@ti.com, bcousson@baylibre.com, linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
property from USB PHY devicetree nodes.

Since "omap_control_usb2phy1", "omap_control_usb3phy1" and
"omap_control_usb2phy2" devicetree nodes are no longer used, remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index dfefd17..191ffae 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1195,24 +1195,6 @@
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
@@ -1225,7 +1207,7 @@
 			usb2_phy1: phy@4a084000 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x400>;
-				ctrl-module = <&omap_control_usb2phy1>;
+				syscon-phy-power = <&scm_conf 0x300>;
 				clocks = <&usb_phy1_always_on_clk32k>,
 					 <&usb_otg_ss1_refclk960m>;
 				clock-names =	"wkupclk",
@@ -1236,7 +1218,7 @@
 			usb2_phy2: phy@4a085000 {
 				compatible = "ti,dra7x-usb2-phy2", "ti,omap-usb2";
 				reg = <0x4a085000 0x400>;
-				ctrl-module = <&omap_control_usb2phy2>;
+				syscon-phy-power = <&scm_conf 0xe74>;
 				clocks = <&usb_phy2_always_on_clk32k>,
 					 <&usb_otg_ss2_refclk960m>;
 				clock-names =	"wkupclk",
@@ -1250,7 +1232,7 @@
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
-				ctrl-module = <&omap_control_usb3phy1>;
+				syscon-phy-power = <&scm_conf 0x370>;
 				clocks = <&usb_phy3_always_on_clk32k>,
 					 <&sys_clkin1>,
 					 <&usb_otg_ss1_refclk960m>;
-- 
1.7.9.5
