From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 2/2] ARM: dts: am33xx: add support for Ka-Ro electronics TX48-7020 module
Date: Wed, 20 Jan 2016 13:29:52 +0100
Message-ID: <1453292992-1788-3-git-send-email-LW@KARO-electronics.de>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-omap@vger.kernel.org

The TX48-7020 is a Computer On Module manufactured by
  Ka-Ro electronics GmbH with the following characteristics:
  Processor    TI Sitara AM3354 720 MHz ARM Cortex-A8
  RAM          256MB DDR3 SDRAM
  ROM          128MB NAND Flash
  RTC          DS1339 Real Time Clock
  Power supply Single 3.1V to 5.5V
  Size         26mm SO-DIMM
  Temp. Range  -40=C2=B0C..85=C2=B0C

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/am335x-tx48.dts | 917 ++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 918 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-tx48.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a4a6d70..13f7e9a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -483,6 +483,7 @@ dtb-$(CONFIG_SOC_AM33XX) +=3D \
 	am335x-shc.dtb \
 	am335x-sbc-t335.dtb \
 	am335x-sl50.dtb \
+	am335x-tx48.dtb \
 	am335x-wega-rdk.dtb
 dtb-$(CONFIG_ARCH_OMAP4) +=3D \
 	omap4-duovero-parlor.dtb \
diff --git a/arch/arm/boot/dts/am335x-tx48.dts b/arch/arm/boot/dts/am33=
5x-tx48.dts
new file mode 100644
index 0000000..7ad92c9
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-tx48.dts
@@ -0,0 +1,917 @@
+/*
+ * Copyright (C) 2013 Ka-Ro electronics GmbH - http://www.karo-electro=
nics.com
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "am33xx.dtsi"
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model =3D "Ka-Ro electronics TX48 module (TI AM335x)";
+	compatible =3D "karo,am335x-tx48", "ti,am33xx";
+
+	aliases {
+		can0 =3D &dcan0;
+		can1 =3D &dcan1;
+		display =3D &display;
+		lcdif_23bit_pins_a =3D &pinctrl_lcd_23bit;
+		lcdif_24bit_pins_a =3D &pinctrl_lcd_24bit;
+		reg_can_xcvr =3D &reg_can_xcvr;
+		usbhost =3D &usb1;
+		usbotg =3D &usb0;
+	};
+
+	cpus {
+		cpu@0 {
+			cpu0-supply =3D <&sw2_reg>;
+		};
+	};
+
+	clocks {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		mclk: clock@0 {
+			compatible =3D "fixed-clock";
+			reg =3D <0>;
+			#clock-cells =3D <0>;
+			clock-frequency =3D <26000000>;
+		};
+	};
+
+	memory {
+		device_type =3D "memory";
+		reg =3D <0 0>; /* will be set up by bootloader */
+	};
+
+	backlight: backlight@0 {
+		compatible =3D "pwm-backlight";
+		pwms =3D <&ehrpwm0 0 500000 PWM_POLARITY_INVERTED>;
+		power-supply =3D <&bb_out_reg>;
+		/*
+		 * a poor man's way to create a 1:1 relationship between
+		 * the PWM value and the actual duty cycle
+		 */
+		brightness-levels =3D <
+			 0  1  2  3  4  5  6  7  8  9
+			10 11 12 13 14 15 16 17 18 19
+			20 21 22 23 24 25 26 27 28 29
+			30 31 32 33 34 35 36 37 38 39
+			40 41 42 43 44 45 46 47 48 49
+			50 51 52 53 54 55 56 57 58 59
+			60 61 62 63 64 65 66 67 68 69
+			70 71 72 73 74 75 76 77 78 79
+			80 81 82 83 84 85 86 87 88 89
+			90 91 92 93 94 95 96 97 98 99
+			100
+		>;
+		default-brightness-level =3D <50>;
+	};
+
+	display: panel {
+		compatible =3D "ti,tilcdc,panel";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_lcd_24bit &pinctrl_lcd_pwr &pinctrl_lcd_rst>=
;
+		enable-gpios =3D <&gpio1 19 GPIO_ACTIVE_HIGH>;
+		status =3D "okay";
+
+		panel-info {
+			ac-bias		  =3D <255>;
+			ac-bias-intrpt	  =3D <0>;
+			dma-burst-sz	  =3D <16>;
+			bpp		  =3D <24>;
+			fdd		  =3D <0x80>;
+			sync-edge	  =3D <1>;
+			sync-ctrl	  =3D <1>;
+			raster-order	  =3D <0>;
+			fifo-th		  =3D <0>;
+			invert-pxl-clk;
+		};
+
+		display-timings {
+			VGA {
+				clock-frequency =3D <25200000>;
+				hactive =3D <640>;
+				vactive =3D <480>;
+				hback-porch =3D <48>;
+				hsync-len =3D <96>;
+				hfront-porch =3D <16>;
+				vback-porch =3D <31>;
+				vsync-len =3D <2>;
+				vfront-porch =3D <12>;
+				hsync-active =3D <0>;
+				vsync-active =3D <0>;
+				de-active =3D <1>;
+			};
+
+			ETV570 {
+				clock-frequency =3D <25200000>;
+				hactive =3D <640>;
+				vactive =3D <480>;
+				hback-porch =3D <114>;
+				hsync-len =3D <30>;
+				hfront-porch =3D <16>;
+				vback-porch =3D <32>;
+				vsync-len =3D <3>;
+				vfront-porch =3D <10>;
+				hsync-active =3D <0>;
+				vsync-active =3D <0>;
+				de-active =3D <1>;
+			};
+
+			ET0350 {
+				clock-frequency =3D <6413760>;
+				hactive =3D <320>;
+				vactive =3D <240>;
+				hback-porch =3D <34>;
+				hsync-len =3D <34>;
+				hfront-porch =3D <20>;
+				vback-porch =3D <15>;
+				vsync-len =3D <3>;
+				vfront-porch =3D <4>;
+				hsync-active =3D <0>;
+				vsync-active =3D <0>;
+				de-active =3D <1>;
+			};
+
+			ET0430 {
+				clock-frequency =3D <9009000>;
+				hactive =3D <480>;
+				vactive =3D <272>;
+				hback-porch =3D <2>;
+				hsync-len =3D <41>;
+				hfront-porch =3D <2>;
+				vback-porch =3D <2>;
+				vsync-len =3D <10>;
+				vfront-porch =3D <2>;
+				hsync-active =3D <0>;
+				vsync-active =3D <0>;
+				de-active =3D <1>;
+			};
+
+			ET0500 {
+				clock-frequency =3D <33264000>;
+				hactive =3D <800>;
+				vactive =3D <480>;
+				hback-porch =3D <88>;
+				hsync-len =3D <128>;
+				hfront-porch =3D <40>;
+				vback-porch =3D <33>;
+				vsync-len =3D <2>;
+				vfront-porch =3D <10>;
+				hsync-active =3D <0>;
+				vsync-active =3D <0>;
+				de-active =3D <1>;
+			};
+
+			ET0700 { /* same as ET0500 */
+				clock-frequency =3D <33264000>;
+				hactive =3D <800>;
+				vactive =3D <480>;
+				hback-porch =3D <88>;
+				hsync-len =3D <128>;
+				hfront-porch =3D <40>;
+				vback-porch =3D <33>;
+				vsync-len =3D <2>;
+				vfront-porch =3D <10>;
+				hsync-active =3D <0>;
+				vsync-active =3D <0>;
+				de-active =3D <1>;
+			};
+
+			ETQ570 {
+				clock-frequency =3D <6596040>;
+				hactive =3D <320>;
+				vactive =3D <240>;
+				hback-porch =3D <38>;
+				hsync-len =3D <30>;
+				hfront-porch =3D <30>;
+				vback-porch =3D <16>;
+				vsync-len =3D <3>;
+				vfront-porch =3D <4>;
+				hsync-active =3D <0>;
+				vsync-active =3D <0>;
+				de-active =3D <1>;
+			};
+		};
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_led>;
+
+		heartbeat {
+			label =3D "heartbeat";
+			gpios =3D <&gpio1 26 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger =3D "heartbeat";
+		};
+	};
+
+	matrix_keypad: matrix_keypad@0 {
+		compatible =3D "gpio-matrix-keypad";
+		debounce-delay-ms =3D <5>;
+		col-scan-delay-us =3D <2>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_matrix_keypad0>;
+		linux,wakeup;
+
+		row-gpios =3D <
+			&gpio0 19 GPIO_ACTIVE_HIGH
+			&gpio0 20 GPIO_ACTIVE_HIGH
+			&gpio2  1 GPIO_ACTIVE_HIGH
+			&gpio2  0 GPIO_ACTIVE_HIGH
+		>;
+
+		col-gpios =3D <
+			&gpio2 26 GPIO_ACTIVE_HIGH
+			&gpio3 17 GPIO_ACTIVE_HIGH
+			&gpio0 7 GPIO_ACTIVE_HIGH
+			&gpio1 28 GPIO_ACTIVE_HIGH
+		>;
+
+		linux,keymap =3D <
+			0x00000074	/* POWER */
+		>;
+	};
+
+	regulators {
+		compatible =3D "simple-bus";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		reg_lcd_pwr: regulator@0 {
+			compatible =3D "regulator-fixed";
+			reg =3D <0>;
+			regulator-name =3D "LCD power";
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&pinctrl_lcd_pwr>;
+			regulator-min-microvolt =3D <3300000>;
+			regulator-max-microvolt =3D <3300000>;
+			gpio =3D <&gpio1 22 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		reg_can_xcvr: regulator@2 {
+			compatible =3D "regulator-fixed";
+			reg =3D <2>;
+			regulator-name =3D "can-xcvr";
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&pinctrl_can_xcvr>;
+			regulator-min-microvolt =3D <3300000>;
+			regulator-max-microvolt =3D <3300000>;
+			gpio =3D <&gpio0 22 GPIO_ACTIVE_LOW>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		reg_usbotg: regulator@3 {
+			compatible =3D "regulator-fixed";
+			reg =3D <3>;
+			regulator-name =3D "usbotg-vbus";
+			regulator-min-microvolt =3D <3300000>;
+			regulator-max-microvolt =3D <3300000>;
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&pinctrl_reg_usbotg>;
+			gpio =3D <&gpio2 30 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+	};
+
+	sound {
+		compatible =3D "ti,am335x-tx48-audio";
+		ti,model =3D "TX48-SGTL5000";
+		ti,audio-codec =3D <&sgtl5000>;
+		ti,mcasp-controller =3D <&mcasp1>;
+	};
+};
+
+&am33xx_pinmux {
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins =3D <
+			/* Slave 1 */
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
+			0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			0x144 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)	/* rmii1_ref_clk.rmii=
1_refclk */
+			0x1e4 (PIN_INPUT_PULLUP | MUX_MODE7)	/* emu0.gpio3_7 */
+			0x1e8 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* emu1.gpio3_8 */
+		>;
+	};
+
+	cpsw_sleep: cpsw_sleep {
+		pinctrl-single,pins =3D <
+			/* Slave 1 reset value */
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x1e4 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x1e8 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	davinci_mdio_default: davinci_mdio_default {
+		pinctrl-single,pins =3D <
+			/* MDIO */
+			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.m=
dio_data */
+			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+		>;
+	};
+
+	davinci_mdio_sleep: davinci_mdio_sleep {
+		pinctrl-single,pins =3D <
+			/* MDIO reset value */
+			0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	pinctrl_can_xcvr: can-xcvr-grp {
+		pinctrl-single,pins =3D <
+			0x20 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad8.gpio0_22	CAN Tra=
nsceiver Enable */
+		>;
+	};
+
+	pinctrl_cspi0: cspi0grp-1 {
+		pinctrl-single,pins =3D <
+			0x15c (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* spi0_cs0.spi0_cs0	CSPI_SS =
*/
+			0x160 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* spi0_cs1.spi0_cs1	CSPI_SS*=
/
+			0x154 (PIN_OUTPUT | MUX_MODE0)		/* spi0_d0.spi0_d0	CSPI_MOSI*/
+			0x158 (PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_d1.spi0_d1	CSPI_MISO*/
+			0x150 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* spi0_sclk.spi0_sclk	CSPI_=
SCLK */
+		>;
+	};
+
+	pinctrl_dcan0: dcan0grp-1 {
+		pinctrl-single,pins =3D <
+			0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd3.dcan0_tx	TXCAN=
 */
+			0x120 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd2.dcan0_rx	RXCAN =
*/
+		>;
+	};
+
+	pinctrl_dcan1: dcan1grp-1 { // USB-OTG / 2nd CAN
+		pinctrl-single,pins =3D <
+			0x100 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mmc0_clk.dcan1_tx	USBOTG_=
VBUSEN */
+			0x104 (PIN_INPUT_PULLUP | MUX_MODE4)	/* mmc0_cmd.dcan1_rx	#USBOTG_O=
C */
+		>;
+	};
+
+	pinctrl_gpmc_1: gpmcgrp-1 {
+		pinctrl-single,pins =3D <
+			0x00 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			0x04 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			0x08 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			0x0c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			0x10 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			0x14 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			0x18 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			0x1c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			0x9c (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_ben0_cle.gpmc_ben0_cle=
 */
+			0x90 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_advn_ale.gpmc_advn_ale=
 */
+			0x7c (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_csn0.gpmc_csn0 */
+			0x94 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_oe_re.gpmc_oe_re */
+			0x98 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_wen.gpmc_wen */
+			0x74 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_wpn.gpmc_wpn */
+			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+		>;
+	};
+
+	pinctrl_i2c0_1: i2c0grp-1 {
+		pinctrl-single,pins =3D <
+			0x188 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0) /* i2c0_sda.i2=
c0_sda I2C_DATA */
+			0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0) /* i2c0_scl.i2=
c0_scl I2C_CLK */
+		>;
+	};
+
+	pinctrl_lcd_pwr: lcdpwrgrp {
+		pinctrl-single,pins =3D <
+			0x58 (PIN_OUTPUT | MUX_MODE7)		/* gpmc_a6.gpio1_22 */
+		>;
+	};
+
+	pinctrl_lcd_rst: lcdrstgrp {
+		pinctrl-single,pins =3D <
+			0x4c (PIN_OUTPUT | MUX_MODE7)		/* gpmc_a3.gpio1_19 */
+		>;
+	};
+
+	pinctrl_lcd_23bit: lcd0grp1 {
+		pinctrl-single,pins =3D <
+			0x2c (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad11.lcd_data20		LD1=
 */
+			0x38 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad14.lcd_data17		LD2=
 */
+			0xcc (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data11.lcd_data11	LD3=
 */
+			0xd0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data12.lcd_data12	LD4=
 */
+			0xd4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data13.lcd_data13	LD5=
 */
+			0xd8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data14.lcd_data14	LD6=
 */
+			0xdc (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data15.lcd_data15	LD7=
 */
+			0x24 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad9.lcd_data22		LD8 =
*/
+			0x30 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad12.lcd_data19		LD9=
 */
+			0xb4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data5.lcd_data5		LD10=
 */
+			0xb8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data6.lcd_data6		LD11=
 */
+			0xbc (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data7.lcd_data7		LD12=
 */
+			0xc0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data8.lcd_data8		LD13=
 */
+			0xc4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data9.lcd_data9		LD14=
 */
+			0xc8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data10.lcd_data10	LD1=
5 */
+			0x28 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad10.lcd_data21		LD1=
6 */
+			0x34 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad13.lcd_data18		LD1=
7 */
+			0x3c (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad15.lcd_data16		LD1=
8 */
+			0xa0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data0.lcd_data0		LD19=
 */
+			0xa4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data1.lcd_data1		LD20=
 */
+			0xa8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data2.lcd_data2		LD21=
 */
+			0xac (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data3.lcd_data3		LD22=
 */
+			0xb0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data4.lcd_data4		LD23=
 */
+			0xe4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_hsync.lcd_hsync		HSYN=
C */
+			0xe0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_vsync.lcd_vsync		VSYN=
C */
+			0xec (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bia=
s_en OE_ACD */
+			0xe8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_pclk.lcd_pclk		LSCLK =
*/
+		>;
+	};
+
+	pinctrl_lcd_24bit: lcd0grp2 {
+		pinctrl-single,pins =3D <
+			0x20 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad8.lcd_data23		LD0 =
*/
+			0x2c (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad11.lcd_data20		LD1=
 */
+			0x38 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad14.lcd_data17		LD2=
 */
+			0xcc (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data11.lcd_data11	LD3=
 */
+			0xd0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data12.lcd_data12	LD4=
 */
+			0xd4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data13.lcd_data13	LD5=
 */
+			0xd8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data14.lcd_data14	LD6=
 */
+			0xdc (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data15.lcd_data15	LD7=
 */
+			0x24 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad9.lcd_data22		LD8 =
*/
+			0x30 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad12.lcd_data19		LD9=
 */
+			0xb4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data5.lcd_data5		LD10=
 */
+			0xb8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data6.lcd_data6		LD11=
 */
+			0xbc (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data7.lcd_data7		LD12=
 */
+			0xc0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data8.lcd_data8		LD13=
 */
+			0xc4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data9.lcd_data9		LD14=
 */
+			0xc8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data10.lcd_data10	LD1=
5 */
+			0x28 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad10.lcd_data21		LD1=
6 */
+			0x34 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad13.lcd_data18		LD1=
7 */
+			0x3c (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ad15.lcd_data16		LD1=
8 */
+			0xa0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data0.lcd_data0		LD19=
 */
+			0xa4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data1.lcd_data1		LD20=
 */
+			0xa8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data2.lcd_data2		LD21=
 */
+			0xac (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data3.lcd_data3		LD22=
 */
+			0xb0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_data4.lcd_data4		LD23=
 */
+			0xe4 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_hsync.lcd_hsync		HSYN=
C */
+			0xe0 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_vsync.lcd_vsync		VSYN=
C */
+			0xec (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bia=
s_en OE_ACD */
+			0xe8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_pclk.lcd_pclk		LSCLK =
*/
+		>;
+	};
+
+	pinctrl_led: ledgrp {
+		pinctrl-single,pins =3D <
+			0x68 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
+		>;
+	};
+
+	pinctrl_matrix_keypad0: matrix-keypad0 {
+		pinctrl-single,pins =3D <
+			0xf0 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* mmc0_dat3.gpio2_26		KP_COL0=
 */
+			0x19c (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* mcasp0_ahclkr.gpio3_17	KP_=
COL1 */
+			0x164 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* ecap0_in_pwm0_out.gpio0_7	=
KP_COL2 */
+			0x78 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_ben1.gpio1_28		KP_COL3=
 */
+			0x1b0 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* xdma_event_intr0.gpio0_19=
	KP_ROW0 */
+			0x1b4 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* xdma_event_intr1.gpio0_20=
	KP_ROW1 */
+			0x8c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_clk.gpio2_1		KP_ROW2 =
*/
+			0x88 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn3.gpio2_0		KP_ROW3=
 */
+		>;
+	};
+
+	pinctrl_mmc1: mmc1grp-1 {
+		pinctrl-single,pins =3D <
+			0x194 (PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_fsx.gpio3_15		SD1_CD=
 */
+			0x12c (PIN_INPUT_PULLUP | MUX_MODE4)	/* mii1_tx_clk.mmc1_dat0	SD1_D=
AT0 */
+			0x130 (PIN_INPUT_PULLUP | MUX_MODE4)	/* mii1_rx_clk.mmc1_dat1	SD1_D=
AT1 */
+			0x134 (PIN_INPUT_PULLUP | MUX_MODE4)	/* mii1_rxd3.mmc1_dat2		SD1_DA=
T2 */
+			0x138 (PIN_INPUT_PULLUP | MUX_MODE4)	/* mii1_rxd2.mmc1_dat3		SD1_DA=
T3 */
+			0x84 (PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_cs2.mmc1_cmd		SD1_CMD *=
/
+			0x80 (PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_cs1.mmc1_clk		SD1_CLK *=
/
+		>;
+	};
+
+	pinctrl_ow0: ow0grp-1 {
+		pinctrl-single,pins =3D <
+			0xf4 (PIN_INPUT_PULLUP | MUX_MODE7)	/* mmc0_dat2.gpio2_27		OWDAT */
+		>;
+	};
+
+	pinctrl_pwm0: pwm0grp-11 {
+		pinctrl-single,pins =3D <
+			0x190 (PIN_OUTPUT_PULLUP | MUX_MODE1)	/* mcasp0_aclkx.ehrpwm0a	PWM =
*/
+		>;
+	};
+
+	pinctrl_reg_usbotg: reg-usbotggrp-1 {
+		pinctrl-single,pins =3D <
+			0x100 (PIN_OUTPUT | MUX_MODE7)		/* mmc0_clk.gpio2_30		USBOTG_VBUSEN=
 */
+			0x104 (PIN_INPUT_PULLUP | MUX_MODE7)	/* mmc0_cmd.gpio2_31		#USBOTG_=
OC */
+		>;
+	};
+
+	pinctrl_ssi_1: ssi1grp-1 {
+		pinctrl-single,pins =3D <
+			0x1a8 (PIN_INPUT_PULLUP | MUX_MODE3)	/* mcasp0_axr1.mcasp1_axr0	SSI=
1_RXD */
+			0x1ac (PIN_OUTPUT | MUX_MODE3)		/* mcasp0_ahclkx.mcasp1_axr1	SSI1_T=
XD */
+			0x1a0 (PIN_INPUT_PULLUP | MUX_MODE3)	/* mcasp0_aclkr.mcasp1_aclkx	S=
SI1_CLK */
+			0x1a4 (PIN_INPUT_PULLUP | MUX_MODE3)	/* mcasp0_fsr.mcasp1_fsx	SSI1_=
=46S */
+		>;
+	};
+
+	pinctrl_tsc2007: tsc2007grp-1 {
+		pinctrl-single,pins =3D <
+			0x198 (PIN_INPUT_PULLUP | MUX_MODE7) /* mcasp0_axr0.gpio3_16		SSI1_=
INT */
+		>;
+	};
+
+	pinctrl_uart0_1: uart0grp-1 {
+		pinctrl-single,pins =3D <
+			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd		TXD=
 */
+			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd		RXD */
+			0x168 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_ctsn.uart0_ctsn	RTS/C=
TS IN */
+			0x16c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_rtsn.uart0_rtsn	CT=
S/RTS OUT */
+		>;
+	};
+
+	pinctrl_uart1_1: uart1grp-1 {
+		pinctrl-single,pins =3D <
+			0x184 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd		TXD=
 */
+			0x180 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd		RXD */
+			0x178 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_ctsn.uart1_ctsn	RTS/C=
TS IN */
+			0x17c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn	CT=
S/RTS OUT */
+		>;
+	};
+
+	pinctrl_uart5_1: uart5grp-1 {
+		pinctrl-single,pins =3D <
+			0x118 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* mii1_rxdv.uart5_txd		TXD=
 */
+			0x108 (PIN_INPUT_PULLUP | MUX_MODE3)	/* mii1_col.uart5_rxd		RXD */
+			0xf8 (PIN_INPUT_PULLUP | MUX_MODE2)	/* mmc0_dat1.uart5_ctsn		RTS/CT=
S IN */
+			0xfc (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mmc0_dat0.uart5_rtsn		CTS=
/RTS OUT */
+		>;
+	};
+
+	pinctrl_usbhost: usbhostgrp-1 {
+		pinctrl-single,pins =3D <
+			0x234 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* usb1_drvvbus.usb1_drvvbu=
s	USBH_VBUSEN */
+			0x21c (PIN_INPUT_PULLUP | MUX_MODE7)	/* usb0_drvvbus.gpio0_18	#USBH=
_OC */
+		>;
+	};
+};
+
+&cppi41dma {
+	status =3D "okay";
+};
+
+&cpsw_emac0 {
+	phy_id =3D <&davinci_mdio>, <0>;
+	phy-mode =3D "rmii";
+};
+
+&cpsw_emac1 {
+	phy_id =3D <&davinci_mdio>, <1>;
+	phy-mode =3D "rmii";
+	status =3D "disabled";
+};
+
+&davinci_mdio {
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&davinci_mdio_default>;
+	pinctrl-1 =3D <&davinci_mdio_sleep>;
+	status =3D "okay";
+};
+
+&dcan0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_dcan0>;
+	status =3D "okay";
+};
+
+&dcan1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_dcan1>;
+	status =3D "okay";
+};
+
+&ehrpwm0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_pwm0>;
+	status =3D "okay";
+};
+
+&elm {
+	status =3D "okay";
+};
+
+&epwmss0 {
+	status =3D "okay";
+};
+
+&gpio0 {
+	ti,gpio-always-on;
+};
+
+&gpio1 {
+	ti,gpio-always-on;
+};
+
+&gpio2 {
+	ti,gpio-always-on;
+};
+
+&gpio3 {
+	ti,gpio-always-on;
+};
+
+&gpmc {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_gpmc_1>;
+	ranges =3D <0 0 0x08000000 0x2000>;	/* CS0: NAND */
+	status =3D "okay";
+
+	nand@0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		reg =3D <0 0 0>;
+		nand-bus-width =3D <8>;
+		nand-on-flash-bbt;
+		ti,elm-id =3D <&elm>;
+		ti,nand-ecc-opt =3D "bch8";
+		ti,nand-xfer-type =3D "polled";
+		gpmc,device-nand =3D "true";
+		gpmc,device-width =3D <1>;
+		gpmc,sync-clk-ps =3D <0>;
+		gpmc,cs-on-ns =3D <0>;
+		gpmc,cs-rd-off-ns =3D <20>;
+		gpmc,cs-wr-off-ns =3D <25>;
+		gpmc,adv-on-ns =3D <0>;
+		gpmc,adv-rd-off-ns =3D <0>;
+		gpmc,adv-wr-off-ns =3D <0>;
+		gpmc,we-off-ns =3D <10>;
+		gpmc,oe-off-ns =3D <25>;
+		gpmc,access-ns =3D <25>;
+		gpmc,rd-cycle-ns =3D <30>;
+		gpmc,wr-cycle-ns =3D <30>;
+		gpmc,wr-access-ns =3D <15>;
+		gpmc,wr-data-mux-bus-ns =3D <0>;
+		gpmc,bus-turnaround-ns =3D <100>;
+		gpmc,cycle2cycle-delay-ns =3D <100>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,clk-activation-ns =3D <0>;
+		gpmc,wait-monitoring-ns =3D <0>;
+		gpmc,wait-on-read =3D "true";
+		gpmc,wait-on-write =3D "true";
+
+		/* partitions will be filled in by U-Boot */
+	};
+};
+
+&i2c0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c0_1>;
+	status =3D "okay";
+
+	rtc1: ds1339@68 {
+		compatible =3D "dallas,ds1339";
+		reg =3D <0x68>;
+	};
+
+	pmic: lt3589@34 {
+		compatible =3D "lltc,ltc3589-2";
+		reg =3D <0x34>;
+
+		regulators {
+			sw1_reg: sw1 {
+				regulator-min-microvolt =3D <591930>;
+				regulator-max-microvolt =3D <1224671>;
+				lltc,fb-voltage-divider =3D <100000 158000>;
+				regulator-name =3D "vdd_core";
+				regulator-ramp-delay =3D <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt =3D <704544>;
+				regulator-max-microvolt =3D <1363627>;
+				lltc,fb-voltage-divider =3D <180000 220000>;
+				regulator-name =3D "vdd_mpu";
+				regulator-ramp-delay =3D <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3_reg: sw3 {
+				regulator-min-microvolt =3D <1364186>;
+				regulator-max-microvolt =3D <1670426>;
+				lltc,fb-voltage-divider =3D <270000 220000>;
+				regulator-name =3D "vdds_ddr";
+				regulator-ramp-delay =3D <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bb_out_reg: bb-out {
+				regulator-min-microvolt =3D <3387341>;
+				regulator-max-microvolt =3D <3387341>;
+				lltc,fb-voltage-divider =3D <511000 158000>;
+				regulator-name =3D "vddio";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: ldo1 {
+				regulator-min-microvolt =3D <1781818>;
+				regulator-max-microvolt =3D <1781818>;
+				lltc,fb-voltage-divider =3D <270000 220000>;
+				regulator-name =3D "vdds_rtc";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-min-microvolt =3D <1799991>;
+				regulator-max-microvolt =3D <1833324>;
+				lltc,fb-voltage-divider =3D <300000 180000>;
+				regulator-name =3D "vdd_etn";
+				regulator-ramp-delay =3D <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-min-microvolt =3D <2800000>;
+				regulator-max-microvolt =3D <2800000>;
+				regulator-name =3D "vdds";
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <3200000>;
+				regulator-name =3D "vpp";
+			};
+		};
+	};
+
+	sgtl5000: sgtl5000@0a {
+		compatible =3D "fsl,sgtl5000";
+		reg =3D <0x0a>;
+		VDDA-supply =3D <&bb_out_reg>;
+		VDDIO-supply =3D <&bb_out_reg>;
+		clocks =3D <&mclk>;
+	};
+
+	touchscreen: tsc2007@48 {
+		compatible =3D "ti,tsc2007";
+		reg =3D <0x48>;
+		interrupt-parent =3D <&gpio3>;
+		interrupts =3D <16 2>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_tsc2007>;
+		gpios =3D <&gpio3 16 GPIO_ACTIVE_LOW>;
+		ti,x-plate-ohms =3D <660>;
+	};
+
+	polytouch: edt-ft5x06@38 {
+		compatible =3D "edt,edt-ft5x06";
+		reg =3D <0x38>;
+		interrupt-parent =3D <&gpio1>;
+		interrupts =3D <17 2>;
+		reset-gpios =3D <&gpio1 18 GPIO_ACTIVE_LOW>;
+		wake-gpios =3D <&gpio1 27 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&lcdc {
+	status =3D "okay";
+};
+
+&mac {
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&cpsw_default>;
+	pinctrl-1 =3D <&cpsw_sleep>;
+	status =3D "okay";
+};
+
+&mcasp1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_ssi_1>;
+	op-mode =3D <0>;          /* MCASP_IIS_MODE */
+	tdm-slots =3D <2>;
+	serial-dir =3D <2 1 0 0>; /* 0: INACTIVE, 1: TX, 2: RX */
+	tx-num-evt =3D <32>;
+	rx-num-evt =3D <32>;
+	status =3D "okay";
+};
+
+&mmc1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_mmc1>;
+	cd-gpios =3D <&gpio3 15 GPIO_ACTIVE_LOW>;
+	vmmc-supply =3D <&bb_out_reg>;
+	status =3D "okay";
+};
+
+&phy_sel {
+	rmii-clock-ext;
+};
+
+&spi0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_cspi0>;
+	ti,spi-num-cs =3D <2>;
+	ti,pindir-d0-out-d1-in;
+	status =3D "okay";
+
+	spidev0: spi@0 {
+		compatible =3D "spidev";
+		reg =3D <0>;
+		spi-max-frequency =3D <375000>;
+	};
+
+	spidev1: spi@1 {
+		compatible =3D "spidev";
+		reg =3D <1>;
+		spi-max-frequency =3D <375000>;
+	};
+};
+
+&tscadc {
+	status =3D "okay";
+
+	tsc {
+		ti,wires =3D <4>;
+		ti,x-plate-resistance =3D <660>;
+		ti,coordinate-readouts =3D <5>;
+		ti,wire-config =3D <0x01 0x10 0x23 0x32>;
+	};
+
+	adc {
+		ti,adc-channels =3D <4 5 6 7>;
+	};
+};
+
+&uart0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart0_1>;
+	status =3D "okay";
+};
+
+&uart1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart1_1>;
+	status =3D "okay";
+};
+
+&uart5 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart5_1>;
+	status =3D "okay";
+};
+
+&usb {
+	status =3D "okay";
+};
+
+&usb_ctrl_mod {
+	status =3D "okay";
+};
+
+&usb0 {
+	dr_mode =3D "peripheral";
+	status =3D "okay";
+};
+
+&usb0_phy {
+	vcc-supply =3D <&reg_usbotg>;
+	status =3D "okay";
+};
+
+&usb1 {
+	dr_mode =3D "host";
+	status =3D "okay";
+};
+
+&usb1_phy {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_usbhost>;
+	status =3D "okay";
+};
--=20
2.1.4
