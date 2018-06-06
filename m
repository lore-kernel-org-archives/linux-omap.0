From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 3/8] ARM: dts: am335x-sl50: add a node for the LCD controller
Date: Wed,  6 Jun 2018 17:54:08 +0200
Message-ID: <20180606155413.23542-3-enric.balletbo@collabora.com>
References: <20180606155413.23542-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606155413.23542-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add the pins used by the LCD controller, the panel-info and display-timings
information for the MIDAS displays connected to the board. There are
two displays in the board, and these, are connected to the LCD controller
through a FPGA, so the timings and the resolution is what expects the FPGA,
not the MIDAS displays.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm/boot/dts/am335x-sl50.dts | 69 ++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 58fe84f2ec8b..ea047b85b726 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -111,6 +111,45 @@
 		};
 	};
 
+	panel: lcd_panel {
+		compatible = "ti,tilcdc,panel";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+
+		panel-info {
+			ac-bias = <255>;
+			ac-bias-intrpt = <0>;
+			dma-burst-sz = <16>;
+			bpp = <16>;
+			fdd = <0x80>;
+			tft-alt-mode = <0>;
+			mono-8bit-mode = <0>;
+			sync-edge = <0>;
+			sync-ctrl = <1>;
+			raster-order = <0>;
+			fifo-th = <0>;
+		};
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: 960x128 {
+				clock-frequency = <18000000>;
+				hactive = <960>;
+				vactive = <272>;
+
+				hback-porch = <40>;
+				hfront-porch = <16>;
+				hsync-len = <24>;
+				hsync-active = <0>;
+
+				vback-porch = <3>;
+				vfront-porch = <8>;
+				vsync-len = <4>;
+				vsync-active = <0>;
+			};
+		};
+	};
+
 	sound {
 		compatible = "ti,da830-evm-audio";
 		ti,model = "AM335x-SL50";
@@ -166,6 +205,31 @@
 		>;
 	};
 
+	lcd_pins: pinmux_lcd_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(0x8e4, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(0x8e8, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(0x8ec, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+		>;
+	};
+
 	led_pins: pinmux_led_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
@@ -323,7 +387,6 @@
 	lwb_pins: pinmux_lwb_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x9a4, PIN_OUTPUT | MUX_MODE7)	/* SoundPA_en - mcasp0_fsr.gpio3_19 */
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE7)	/* nKbdOnC - gpmc_ad10.gpio0_26 */
 			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE7)	/* nKbdInt - gpmc_ad12.gpio1_12 */
 			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE7)	/* nKbdReset - gpmc_ad13.gpio1_13 */
 			AM33XX_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE7)	/* USB1_enPower - gpmc_a1.gpio1_17 */
@@ -595,3 +658,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&ehrpwm1_pins>;
 };
+
+&lcdc {
+	status = "okay";
+};
-- 
2.17.1
