From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 02/11] ARM: dts: am43xx-epos-evm: Add sleep pinmux for spi0 and spi1
Date: Fri, 29 Sep 2017 11:44:20 -0500
Message-ID: <20170929164429.780-3-afd@ti.com>
References: <20170929164429.780-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929164429.780-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 9d276af7c539..f73c22ce4003 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -232,7 +232,7 @@
 			>;
 		};
 
-		spi0_pins: pinmux_spi0_pins {
+		spi0_pins_default: pinmux_spi0_pins_default {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x950, PIN_INPUT | MUX_MODE0)           /* spi0_clk.spi0_clk */
 				AM4372_IOPAD(0x954, PIN_OUTPUT | MUX_MODE0)           /* spi0_d0.spi0_d0 */
@@ -241,7 +241,16 @@
 			>;
 		};
 
-		spi1_pins: pinmux_spi1_pins {
+		spi0_pins_sleep: pinmux_spi0_pins_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x950, DS0_PIN_OUTPUT_PULLUP | PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x954, DS0_PIN_OUTPUT_PULLUP | PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x958, DS0_PIN_OUTPUT_PULLUP | PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x95c, DS0_PIN_OUTPUT_PULLUP | PIN_OUTPUT_PULLUP | MUX_MODE7)
+			>;
+		};
+
+		spi1_pins_default: pinmux_spi1_pins_default {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x990, PIN_INPUT | MUX_MODE3)           /* mcasp0_aclkx.spi1_clk */
 				AM4372_IOPAD(0x994, PIN_OUTPUT | MUX_MODE3)           /* mcasp0_fsx.spi1_d0 */
@@ -250,6 +259,15 @@
 			>;
 		};
 
+		spi1_pins_sleep: pinmux_spi1_pins_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x990, DS0_PIN_OUTPUT_PULLDOWN | PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x994, DS0_PIN_OUTPUT_PULLDOWN | PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x998, DS0_PIN_OUTPUT_PULLDOWN | PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x99c, DS0_PIN_OUTPUT_PULLDOWN | PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+			>;
+		};
+
 		mmc1_pins: pinmux_mmc1_pins {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
@@ -656,15 +674,17 @@
 };
 
 &spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins>;
 	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&spi0_pins_default>;
+	pinctrl-1 = <&spi0_pins_sleep>;
 };
 
 &spi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi1_pins>;
 	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&spi1_pins_default>;
+	pinctrl-1 = <&spi1_pins_sleep>;
 };
 
 &usb2_phy1 {
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
