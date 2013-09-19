From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 13/15] arm: dts: omap5: add sata node
Date: Thu, 19 Sep 2013 16:23:55 +0300
Message-ID: <1379597035-15331-1-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com
Cc: balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

Add support for sata.

[Roger Q] Clean up.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   51 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 8a88a94..a79ccb7 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -434,6 +434,53 @@
 			dma-names = "tx", "rx";
 		};
 
+		omap_control_sata: control-phy@4a002374 {
+			compatible = "ti,control-phy-pipe3";
+			reg = <0x4a002374 0x4>;
+			reg-names = "power";
+			clocks = <&sys_clkin>;
+			clock-names = "sysclk";
+		};
+
+		ocp2scp3: ocp2scp3@4a090000 {
+			compatible = "ti,omap-ocp2scp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			ti,hwmods = "ocp2scp3";
+			reg = <0x4a090000 0x1f>; /* ocp2scp3 */
+			reg-names = "ocp2scp3";
+			sata_phy: sataphy@4A096000 {
+				compatible = "ti,phy-pipe3-sata";
+				reg = <0x4A096000 0x80>, /* phy_rx */
+				      <0x4A096400 0x64>, /* phy_tx */
+				      <0x4A096800 0x40>; /* pll_ctrl */
+				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
+				ctrl-module = <&omap_control_sata>;
+				clocks = <&sys_clkin>;
+				clock-names = "sysclk";
+				#phy-cells = <0>;
+			};
+		};
+
+		sata: sata@4a141100 {
+			compatible = "ti,sata";
+			ti,hwmods = "sata";
+			reg = <0x4a141100 0x7>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			dwc-ahci@4a140000 {
+				  compatible = "snps,dwc-ahci";
+				  reg = <0x4a140000 0x1100>;
+				  interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+				  phys = <&sata_phy>;
+				  phy-names = "sata-phy";
+				  clocks = <&sata_ref_clk>;
+				  clock-names = "optclk";
+			};
+		};
+
 		keypad: keypad@4ae1c000 {
 			compatible = "ti,omap4-keypad";
 			reg = <0x4ae1c000 0x400>;
@@ -636,6 +683,8 @@
 			compatible = "ti,control-phy-pipe3";
 			reg = <0x4a002370 0x4>;
 			reg-names = "power";
+			clocks = <&sys_clkin>;
+			clock-names = "sysclk";
 		};
 
 		omap_dwc3@4a020000 {
@@ -657,7 +706,7 @@
 			};
 		};
 
-		ocp2scp {
+		ocp2scp1: ocp2scp1@4a080000 {
 			compatible = "ti,omap-ocp2scp";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.7.4.1
