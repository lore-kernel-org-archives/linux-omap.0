From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH v2 2/6] ARM: OMAP2+: dts: cm-t335: add basic support for I2C
Date: Tue, 24 Nov 2015 16:02:09 +0200
Message-ID: <1448373733-5839-3-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448373733-5839-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>

Add pinmux configuration for I2C0 and I2C1 pins.
Add description for I2C0 bus, set clock frequency to 400kHz.
Add child nodes for 24c02 EEPROM and em3027 RTC on I2C0 bus.

Signed-off-by: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
v1 -> v2: integrate AM33XX_IOPAD macro in pinmux definitions

 arch/arm/boot/dts/am335x-cm-t335.dts | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 719658e..02b6679 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -37,6 +37,24 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <>;
 
+	i2c0_pins: pinmux_i2c0_pins {
+		pinctrl-single,pins = <
+			/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)
+		>;
+	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			/* uart0_ctsn.i2c1_sda */
+			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE2)
+			/* uart0_rtsn.i2c1_scl */
+			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE2)
+		>;
+	};
+
 	gpio_led_pins: pinmux_gpio_led_pins {
 		pinctrl-single,pins = <
 			/* gpmc_csn3.gpio2_0 */
@@ -61,3 +79,22 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+
+	status = "okay";
+	clock-frequency = <400000>;
+	/* CM-T335 board EEPROM */
+	eeprom: 24c02@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+	/* Real Time Clock */
+	ext_rtc: em3027@56 {
+		compatible = "emmicro,em3027";
+		reg = <0x56>;
+	};
+};
+
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
