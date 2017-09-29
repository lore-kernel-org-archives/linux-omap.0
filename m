From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 08/11] ARM: dts: am43xx-epos-evm: Add default and sleep pinmux for matrix_keypad0
Date: Fri, 29 Sep 2017 11:44:26 -0500
Message-ID: <20170929164429.780-9-afd@ti.com>
References: <20170929164429.780-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929164429.780-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Kabir Sahane <x0153567-l0cyMroinI0@public.gmane.org>

Signed-off-by: Kabir Sahane <x0153567-l0cyMroinI0@public.gmane.org>
Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 4d5487b853c3..569c9ac200c8 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -75,6 +75,9 @@
 		compatible = "gpio-matrix-keypad";
 		debounce-delay-ms = <5>;
 		col-scan-delay-us = <2>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&matrix_keypad_default>;
+		pinctrl-1 = <&matrix_keypad_sleep>;
 
 		row-gpios = <&gpio0 12 GPIO_ACTIVE_HIGH		/* Bank0, pin12 */
 			     &gpio0 13 GPIO_ACTIVE_HIGH		/* Bank0, pin13 */
@@ -307,6 +310,32 @@
 			>;
 		};
 
+		matrix_keypad_default: matrix_keypad_default {
+			pinctrl-single,pins = <
+				 AM4372_IOPAD(0x92c, PIN_OUTPUT | MUX_MODE7)          /* mii1_tx_clk.gpio3_9 */
+				 AM4372_IOPAD(0x930, PIN_OUTPUT | MUX_MODE7)          /* mii1_rx_clk.gpio3_10 */
+				 AM4372_IOPAD(0x934, PIN_OUTPUT | MUX_MODE7)          /* mii1_rxd3.gpio2_18 */
+				 AM4372_IOPAD(0x938, PIN_OUTPUT | MUX_MODE7)          /* mii1_rxd2.gpio2_19 */
+				 AM4372_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE7)  /* uart1_ctsn.gpio0_12 */
+				 AM4372_IOPAD(0x97C, PIN_INPUT_PULLDOWN | MUX_MODE7)  /* uart1_rtsn.gpio0_13 */
+				 AM4372_IOPAD(0x980, PIN_INPUT_PULLDOWN | MUX_MODE7)  /* uart1_rxd.gpio0_14 */
+				 AM4372_IOPAD(0x984, PIN_INPUT_PULLDOWN | MUX_MODE7)  /* uart1_txd.gpio0_15 */
+			>;
+		};
+
+		matrix_keypad_sleep: matrix_keypad_sleep {
+			pinctrl-single,pins = <
+				AM4372_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x930, PIN_INPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x938, PIN_INPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x97C, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x980, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x984, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			>;
+		};
+
 		qspi1_pins_default: qspi1_pins_default {
 			pinctrl-single,pins = <
 				AM4372_IOPAD(0x87c, PIN_INPUT_PULLUP | MUX_MODE3)
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
