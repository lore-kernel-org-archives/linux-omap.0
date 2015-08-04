From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 06/10] ARM: dts: am4372: Use "syscon-phy-power" instead of
 "ctrl-module" in USB PHY node
Date: Tue, 4 Aug 2015 21:00:29 +0530
Message-ID: <1438702233-8027-7-git-send-email-kishon@ti.com>
References: <1438702233-8027-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438702233-8027-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, bcousson@baylibre.com, balbi@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
property from USB PHY device tree node.

Since "am43xx_control_usb2phy1" and "am43xx_control_usb2phy2"
devicetree nodes are no longer used, remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ade28c79..24fa073 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -802,18 +802,6 @@
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
@@ -824,7 +812,7 @@
 			usb2_phy1: phy@483a8000 {
 				compatible = "ti,am437x-usb2";
 				reg = <0x483a8000 0x8000>;
-				ctrl-module = <&am43xx_control_usb2phy1>;
+				syscon-phy-power = <&scm_conf 0x620>;
 				clocks = <&usb_phy0_always_on_clk32k>,
 					 <&usb_otg_ss0_refclk960m>;
 				clock-names = "wkupclk", "refclk";
@@ -843,7 +831,7 @@
 			usb2_phy2: phy@483e8000 {
 				compatible = "ti,am437x-usb2";
 				reg = <0x483e8000 0x8000>;
-				ctrl-module = <&am43xx_control_usb2phy2>;
+				syscon-phy-power = <&scm_conf 0x628>;
 				clocks = <&usb_phy1_always_on_clk32k>,
 					 <&usb_otg_ss1_refclk960m>;
 				clock-names = "wkupclk", "refclk";
-- 
1.7.9.5
