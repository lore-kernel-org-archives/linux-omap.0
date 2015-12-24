From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH v2 3/3] wlcore/wl12xx: spi: add wifi support to cm-t335
Date: Thu, 24 Dec 2015 17:35:35 +0200
Message-ID: <1450971335-15961-4-git-send-email-uri.mashiach@compulab.co.il>
References: <1450971335-15961-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450971335-15961-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Device tree modifications:
- Pinmux for SPI0 and WiFi GPIOs.
- SPI0 node with wlcore as a child node.

Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-lB3UumIvzKrRNpEZXGUFxA@public.gmane.org>
---
v1 -> v2: replace interrupts and interrupt-parent with interrupts-extended.

 arch/arm/boot/dts/am335x-cm-t335.dts | 57 +++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 42e9b66..31f8371 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 
 #include "am33xx.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "CompuLab CM-T335";
@@ -40,6 +41,15 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	/* Regulator for WiFi */
+	vwlan_fixed: fixedregulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vwlan_fixed";
+		gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>; /* gpio0_20 */
+		enable-active-high;
+		regulator-boot-off;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 0>;
@@ -50,7 +60,10 @@
 
 &am33xx_pinmux {
 	pinctrl-names = "default";
-	pinctrl-0 = <&bluetooth_pins>;
+	pinctrl-0 = <
+		  &bluetooth_pins
+		  &wifi_pins
+	>;
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
@@ -223,6 +236,21 @@
 		>;
 	};
 
+	spi0_pins: pinmux_spi0_pins {
+		pinctrl-single,pins = <
+			/* spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE0)
+			/* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x954, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			/* spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(0x958, PIN_INPUT | MUX_MODE0)
+			/* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x95C, PIN_OUTPUT | MUX_MODE0)
+			/* spi0_cs1.spi0_cs1 */
+			AM33XX_IOPAD(0x960, PIN_OUTPUT | MUX_MODE0)
+		>;
+	};
+
 	/* wl1271 bluetooth */
 	bluetooth_pins: pinmux_bluetooth_pins {
 		pinctrl-single,pins = <
@@ -230,6 +258,16 @@
 			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLUP | MUX_MODE7)
 		>;
 	};
+
+	/* wl1271 WiFi */
+	wifi_pins: pinmux_wifi_pins {
+		pinctrl-single,pins = <
+			/* EMU1.gpio3_8 - WiFi IRQ */
+			AM33XX_IOPAD(0x9e8, PIN_INPUT_PULLUP | MUX_MODE7)
+			/* XDMA_EVENT_INTR1.gpio0_20 - WiFi enable */
+			AM33XX_IOPAD(0x9b4, PIN_OUTPUT | MUX_MODE7)
+		>;
+	};
 };
 
 &uart0 {
@@ -394,3 +432,20 @@ status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 };
+
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	ti,pindir-d0-out-d1-in = <1>;
+	/* WLS1271 WiFi */
+	wlcore: wlcore@1 {
+		compatible = "ti,wl1271";
+		reg = <1>;
+		spi-max-frequency = <48000000>;
+		clock-xtal;
+		ref-clock-frequency = <38400000>;
+		interrupts-extended = <&gpio3 8 IRQ_TYPE_LEVEL_HIGH>;
+		vwlan-supply = <&vwlan_fixed>;
+	};
+};
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
