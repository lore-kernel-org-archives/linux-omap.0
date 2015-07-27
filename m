From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/2] ARM: dts: am57xx-beagle-x15: use palmas-usb for USB2
Date: Mon, 27 Jul 2015 16:10:17 +0300
Message-ID: <1438002617-15152-3-git-send-email-rogerq@ti.com>
References: <1438002617-15152-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438002617-15152-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, cw00.choi@samsung.com, tony@atomide.com
Cc: nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The VBUS line of USB2 is connected to VBUS detect logic on
the PMIC. Use the palmas-usb driver to report VBUS events
to the USB driver.

As the palmas-usb driver supports GPIO based ID reporting
provide the GPIO for ID pin as well.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index a63bf78..f32cf20 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -98,13 +98,6 @@
 		pinctrl-0 = <&extcon_usb1_pins>;
 	};
 
-	extcon_usb2: extcon_usb2 {
-		compatible = "linux,extcon-usb-gpio";
-		id-gpio = <&gpio7 24 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&extcon_usb2_pins>;
-	};
-
 	hdmi0: connector {
 		compatible = "hdmi-connector";
 		label = "hdmi";
@@ -326,12 +319,6 @@
 		>;
 	};
 
-	extcon_usb2_pins: extcon_usb2_pins {
-		pinctrl-single,pins = <
-			0x3e8 (PIN_INPUT_PULLUP | MUX_MODE14) /* uart1_ctsn.gpio7_24 */
-		>;
-	};
-
 	tpd12s015_pins: pinmux_tpd12s015_pins {
 		pinctrl-single,pins = <
 			0x3b0 (PIN_OUTPUT | MUX_MODE14)		/* gpio7_10 CT_CP_HPD */
@@ -495,6 +482,14 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		extcon_usb2: tps659038_usb {
+			compatible = "ti,palmas-usb-vid";
+			ti,enable-vbus-detection;
+			ti,enable-id-detection;
+			id-gpios = <&gpio7 24 GPIO_ACTIVE_HIGH>;
+		};
+
 	};
 
 	tmp102: tmp102@48 {
@@ -624,6 +619,14 @@
 };
 
 &usb2 {
+	/*
+	 * Stand alone usage is peripheral only.
+	 * However, with some resistor modifications
+	 * this port can be used via expansion connectors
+	 * as "host" or "dual-role". If so, provide
+	 * the necessary dr_mode override in the expansion
+	 * board's DT.
+	 */
 	dr_mode = "peripheral";
 };
 
-- 
2.1.4
