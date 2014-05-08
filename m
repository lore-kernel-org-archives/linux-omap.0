From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v3 2/3] ARM: dts: oma3-gta04: Add display support
Date: Thu,  8 May 2014 22:16:51 +0200
Message-ID: <1399580212-5183-3-git-send-email-marek@goldelico.com>
References: <1399580212-5183-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399580212-5183-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, grant.likely@linaro.org
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This patch add support for lcd display on gta04 board. Display control
is connected to spi (used spi bitbang driver).

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 87 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index f8ad125..eb9ab1a 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -44,6 +44,36 @@
 		ti,mcbsp = <&mcbsp2>;
 		ti,codec = <&twl_audio>;
 	};
+
+	spi_lcd {
+		compatible = "spi-gpio";
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi_gpio_pins>;
+
+		gpio-sck = <&gpio1 12 0>;
+		gpio-miso = <&gpio1 18 0>;
+		gpio-mosi = <&gpio1 20 0>;
+		cs-gpios = <&gpio1 19 0>;
+		num-chipselects = <1>;
+
+		/* lcd panel */
+		lcd: td028ttec1@0 {
+			compatible = "toppoly,td028ttec1";
+			reg = <0>;
+			spi-max-frequency = <100000>;
+			spi-cpol;
+			spi-cpha;
+
+			label = "lcd";
+			port {
+				lcd_in: endpoint {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+		};
+	};
 };
 
 &omap3_pmx_core {
@@ -78,6 +108,47 @@
 			0x11e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
 		>;
 	};
+
+	dss_dpi_pins: pinmux_dss_dpi_pins {
+               pinctrl-single,pins = <
+                       0x0a4 (PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
+                       0x0a6 (PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
+                       0x0a8 (PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
+                       0x0aa (PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
+                       0x0ac (PIN_OUTPUT | MUX_MODE0)   /* dss_data0.dss_data0 */
+                       0x0ae (PIN_OUTPUT | MUX_MODE0)   /* dss_data1.dss_data1 */
+                       0x0b0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data2.dss_data2 */
+                       0x0b2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data3.dss_data3 */
+                       0x0b4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data4.dss_data4 */
+                       0x0b6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data5.dss_data5 */
+                       0x0b8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
+                       0x0ba (PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
+                       0x0bc (PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
+                       0x0be (PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
+                       0x0c0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
+                       0x0c2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
+                       0x0c4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
+                       0x0c6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
+                       0x0c8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
+                       0x0ca (PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
+                       0x0cc (PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
+                       0x0ce (PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
+                       0x0d0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data18.dss_data18 */
+                       0x0d2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data19.dss_data19 */
+                       0x0d4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data20.dss_data20 */
+                       0x0d6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data21.dss_data21 */
+                       0x0d8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
+                       0x0da (PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
+               >;
+       };
+
+	spi_gpio_pins: spi_gpio_pinmux {
+		pinctrl-single,pins = <0x5a8 (PIN_OUTPUT | MUX_MODE4) /* clk */
+			0x5b6 (PIN_OUTPUT | MUX_MODE4) /* cs */
+			0x5b8 (PIN_OUTPUT | MUX_MODE4) /* tx */
+			0x5b4 (PIN_INPUT | MUX_MODE4) /* rx */
+		>;
+	};
 };
 
 &i2c1 {
@@ -219,3 +290,19 @@
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <3150000>;
 };
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = < &dss_dpi_pins >;
+
+	status = "okay";
+
+	vdds_dsi-supply = <&vpll2>;
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <24>;
+		};
+	};
+};
-- 
1.9.1
