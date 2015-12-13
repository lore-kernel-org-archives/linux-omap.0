From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 4/5] ARM: dts: cm-t335: add support for DVI/LCD
Date: Sun, 13 Dec 2015 10:55:38 +0200
Message-ID: <1449996939-13901-5-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1449996939-13901-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449996939-13901-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add pinmux configuration for DVI/LCD.
Add DRM display driver node with timing configurations for DVI and LCD.
Add I2C GPIOs configurations for DVI and LCD enable.

Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 arch/arm/boot/dts/am335x-sbc-t335.dts | 192 ++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-sbc-t335.dts b/arch/arm/boot/dts/am335x-sbc-t335.dts
index 4a5177e..917d7cc 100644
--- a/arch/arm/boot/dts/am335x-sbc-t335.dts
+++ b/arch/arm/boot/dts/am335x-sbc-t335.dts
@@ -13,6 +13,181 @@
 / {
 	model = "CompuLab CM-T335 on SB-T335";
 	compatible = "compulab,sbc-t335", "compulab,cm-t335", "ti,am33xx";
+
+	/* DRM display driver */
+	panel {
+		compatible = "ti,tilcdc,panel";
+		status = "okay";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&lcd_pins_default>;
+		pinctrl-1 = <&lcd_pins_sleep>;
+
+		panel-info {
+			ac-bias           = <255>;
+			ac-bias-intrpt    = <0>;
+			dma-burst-sz      = <16>;
+			bpp               = <32>;
+			fdd               = <0x80>;
+			sync-edge         = <0>;
+			sync-ctrl         = <1>;
+			raster-order      = <0>;
+			fifo-th           = <0>;
+		};
+		display-timings {
+			/* Timing selection performed by U-Boot */
+			timing0: lcd {/* 800x480p62 */
+				clock-frequency = <30000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <39>;
+				hback-porch = <39>;
+				hsync-len = <47>;
+				vback-porch = <29>;
+				vfront-porch = <13>;
+				vsync-len = <2>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+			};
+			timing1: dvi { /* 1024x768p60 */
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				hfront-porch = <24>;
+				hback-porch = <160>;
+				hsync-len = <136>;
+				vactive = <768>;
+				vfront-porch = <3>;
+				vback-porch = <29>;
+				vsync-len = <6>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+			};
+		};
+	};
+};
+
+&am33xx_pinmux {
+	/* Display */
+	lcd_pins_default: lcd_pins_default {
+		pinctrl-single,pins = <
+			/* gpmc_ad8.lcd_data23 */
+			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)
+			/* gpmc_ad9.lcd_data22 */
+			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)
+			/* gpmc_ad10.lcd_data21 */
+			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)
+			/* gpmc_ad11.lcd_data20 */
+			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)
+			/* gpmc_ad12.lcd_data19 */
+			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)
+			/* gpmc_ad13.lcd_data18 */
+			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)
+			/* gpmc_ad14.lcd_data17 */
+			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)
+			/* gpmc_ad15.lcd_data16 */
+			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)
+			/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)
+			/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)
+		>;
+	};
+
+	lcd_pins_sleep: lcd_pins_sleep {
+		pinctrl-single,pins = <
+			/* gpmc_ad8.lcd_data23 */
+			AM33XX_IOPAD(0x820, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* gpmc_ad9.lcd_data22 */
+			AM33XX_IOPAD(0x824, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* gpmc_ad10.lcd_data21 */
+			AM33XX_IOPAD(0x828, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* gpmc_ad11.lcd_data20 */
+			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* gpmc_ad12.lcd_data19 */
+			AM33XX_IOPAD(0x830, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* gpmc_ad13.lcd_data18 */
+			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* gpmc_ad14.lcd_data17 */
+			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* gpmc_ad15.lcd_data16 */
+			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(0x8a0, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(0x8a4, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(0x8a8, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(0x8ac, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(0x8b0, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(0x8b4, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(0x8b8, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(0x8bc, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(0x8c0, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(0x8c4, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(0x8c8, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(0x8cc, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(0x8d0, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(0x8d4, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(0x8d8, PULL_DISABLE | MUX_MODE7)
+			/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(0x8dc, PULL_DISABLE | MUX_MODE7)
+			/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
 };
 
 &i2c0 {
@@ -23,5 +198,22 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		reg = <0x26>;
+		dvi_ena {
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "dvi-enable";
+		};
+		lcd_ena {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "lcd-enable";
+		};
 	};
 };
+
+/* Display */
+&lcdc {
+	status = "okay";
+};
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
