From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 13/17] ARM: dts: am4372: Use "syscon-phy-power" instead of "ctrl-module" in USB PHY node
Date: Tue, 23 Jun 2015 17:28:58 +0530
Message-ID: <1435060743-5511-14-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435060743-5511-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
property from USB PHY device tree node.

Since "am43xx_control_usb2phy1" and "am43xx_control_usb2phy2"
devicetree nodes are no longer used, remove it.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c80a3e2..0754e0da 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -796,18 +796,6 @@
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
@@ -818,7 +806,7 @@
 			usb2_phy1: phy@483a8000 {
 				compatible = "ti,am437x-usb2";
 				reg = <0x483a8000 0x8000>;
-				ctrl-module = <&am43xx_control_usb2phy1>;
+				syscon-phy-power = <&scm_conf 0x620>;
 				clocks = <&usb_phy0_always_on_clk32k>,
 					 <&usb_otg_ss0_refclk960m>;
 				clock-names = "wkupclk", "refclk";
@@ -837,7 +825,7 @@
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
