From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 15/17] ARM: dts: OMAP5: Use "syscon-phy-power" instead of "ctrl-module" in SATA PHY node
Date: Tue, 23 Jun 2015 17:29:00 +0530
Message-ID: <1435060743-5511-16-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, rogerq@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, kishon@ti.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
property from SATA PHY node.

Since "omap_control_sata" devicetree node is no longer used, remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 9b50314..ca0a77f 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -944,14 +944,6 @@
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
@@ -966,7 +958,7 @@
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
