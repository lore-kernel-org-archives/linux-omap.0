From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 7/7] dts: dra7-evm: add USB support
Date: Mon, 28 Apr 2014 17:01:27 +0300
Message-ID: <1398693687-13967-8-git-send-email-rogerq@ti.com>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54630 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042AbaD1OCG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 10:02:06 -0400
In-Reply-To: <1398693687-13967-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, kishon@ti.com, tony@atomide.com
Cc: george.cherian@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Add USB pinmux information and USB modes
for the USB controllers.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..1d77815 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -93,6 +93,18 @@
 			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
 		>;
 	};
+
+	usb1_pins: pinmux_usb1_pins {
+                pinctrl-single,pins = <
+			0x280	0xc0000	/* usb1_drvvbus, SLOW_SLEW | PULLUPEN | MODE0 */
+                >;
+        };
+
+	usb2_pins: pinmux_usb2_pins {
+                pinctrl-single,pins = <
+			0x284	0xc0000 /* usb2_drvvbus, SLOW_SLEW | PULLUPEN | MODE0 */
+                >;
+        };
 };
 
 &i2c1 {
@@ -273,3 +285,15 @@
 &cpu0 {
 	cpu0-supply = <&smps123_reg>;
 };
+
+&usb1 {
+	dr_mode = "peripheral";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins>;
+};
+
+&usb2 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_pins>;
+};
-- 
1.8.3.2

