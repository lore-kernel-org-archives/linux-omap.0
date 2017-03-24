From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH] ARM: dts: am335x-baltos: add LED support
Date: Fri, 24 Mar 2017 16:15:03 +0100
Message-ID: <1490368503-4798-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

All three devices provide GPIO based LEDs named power,
wlan and app.

Place the same definition in all three DTS files, as
there are other devices (not currently upstreamed), that
use am335x-baltos.dtsi but use different GPIOs for these
LEDs.

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 arch/arm/boot/dts/am335x-baltos-ir2110.dts | 32 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-baltos-ir3220.dts | 32 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 34 ++++++++++++++++++++++++++++--
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
index 501c752..e9b5544 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir2110.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
@@ -17,9 +17,41 @@
 
 / {
 	model = "OnRISC Baltos iR 2110";
+
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds>;
+
+		compatible = "gpio-leds";
+
+		power {
+			label = "onrisc:red:power";
+			linux,default-trigger = "default-on";
+			gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+		wlan {
+			label = "onrisc:blue:wlan";
+			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		app {
+			label = "onrisc:green:app";
+			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
 };
 
 &am33xx_pinmux {
+	user_leds: pinmux_user_leds {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_col.gpio3_0 PWR LED */
+			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd3.gpio0_16 WLAN LED */
+			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd2.gpio0_17 APP LED */
+		>;
+	};
+
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)      /* uart1_rxd */
diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index 19f53b8..0878379 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -17,9 +17,41 @@
 
 / {
 	model = "OnRISC Baltos iR 3220";
+
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds>;
+
+		compatible = "gpio-leds";
+
+		power {
+			label = "onrisc:red:power";
+			linux,default-trigger = "default-on";
+			gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+		wlan {
+			label = "onrisc:blue:wlan";
+			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		app {
+			label = "onrisc:green:app";
+			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
 };
 
 &am33xx_pinmux {
+	user_leds: pinmux_user_leds {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_col.gpio3_0 PWR LED */
+			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd3.gpio0_16 WLAN LED */
+			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd2.gpio0_17 APP LED */
+		>;
+	};
+
 	tca6416_pins: pinmux_tca6416_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 2b9d7f4..e2da0aa 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -17,16 +17,47 @@
 
 / {
 	model = "OnRISC Baltos iR 5221";
+
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds>;
+
+		compatible = "gpio-leds";
+
+		power {
+			label = "onrisc:red:power";
+			linux,default-trigger = "default-on";
+			gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+		wlan {
+			label = "onrisc:blue:wlan";
+			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		app {
+			label = "onrisc:green:app";
+			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
 };
 
 &am33xx_pinmux {
+	user_leds: pinmux_user_leds {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_col.gpio3_0 PWR LED */
+			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd3.gpio0_16 WLAN LED */
+			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* mii1_txd2.gpio0_17 APP LED */
+		>;
+	};
+
 	tca6416_pins: pinmux_tca6416_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
 		>;
 	};
 
-
 	dcan1_pins: pinmux_dcan1_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2)      /* uart0_ctsn.dcan1_tx_mux0 */
@@ -61,7 +92,6 @@
 			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
 		>;
 	};
-
 };
 
 &uart1 {
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
