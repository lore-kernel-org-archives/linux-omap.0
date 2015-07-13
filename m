From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: use palmas-usb for USB2
Date: Mon, 13 Jul 2015 16:01:31 +0300
Message-ID: <1436792491-19431-3-git-send-email-rogerq@ti.com>
References: <1436792491-19431-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436792491-19431-1-git-send-email-rogerq@ti.com>
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
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index a63bf78..bd185e0 100644
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
@@ -495,6 +488,16 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		extcon_usb2: tps659038_usb {
+			compatible = "ti,palmas-usb-vid";
+			ti,enable-vbus-detection;
+			ti,enable-gpio-id-detection;
+			id-gpios = <&gpio7 24 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&extcon_usb2_pins>;
+		};
+
 	};
 
 	tmp102: tmp102@48 {
@@ -624,6 +627,14 @@
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
