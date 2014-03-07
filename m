From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 8/8] dts: dra7-evm: add USB support
Date: Fri, 7 Mar 2014 15:09:11 +0200
Message-ID: <1394197751-28984-9-git-send-email-rogerq@ti.com>
References: <1394197751-28984-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394197751-28984-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, tony@atomide.com
Cc: kishon@ti.com, george.cherian@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Add USB pinmux information and USB modes
for the first 2 USB controllers.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..41c600b 100644
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
+	dr_mode = "otg";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins>;
+};
+
+&usb2 {
+	dr_mode = "otg";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2_pins>;
+};
-- 
1.8.3.2
