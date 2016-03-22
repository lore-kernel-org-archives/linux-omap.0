From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] ARM: dts: am335x: Add initial support for ICEv2 board
Date: Tue, 22 Mar 2016 12:07:36 +0530
Message-ID: <1458628657-30468-2-git-send-email-lokeshvutla@ti.com>
References: <1458628657-30468-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458628657-30468-1-git-send-email-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

TI's Industrial Communication Engine EVM is a low cost hardware mainly
developed for industrial communication type applications using serial
or Ethernet based interfaces. This platform features TI's AM3359 with
800MHz single core Cortex-A8 processor, 256MB DDR3, 64MB SPI flash,
8MB NOR Flash, mmc, usb, can, dual Ethernet ports.

For more information, look at HW user guide[1], Data manual[2].

Just add basic support for the moment.

[1] http://processors.wiki.ti.com/index.php/AM335x_Industrial_Communication_Engine_EVM_Rev2_1_HW_User_Guide
[2] http://www.ti.com/lit/ds/symlink/am3359.pdf

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-icev2.dts                 | 303 +++++++++++++++++++++
 3 files changed, 307 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-icev2.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 21e71a5..20f6d71 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -133,6 +133,9 @@ Boards:
 - AM335X Bone : Low cost community board
   compatible = "ti,am335x-bone", "ti,am33xx", "ti,omap3"
 
+- AM3359 ICEv2 : Low cost Industrial Communication Engine EVM.
+  compatible = "ti,am3359-icev2", "ti,am33xx", "ti,omap3"
+
 - AM335X OrionLXm : Substation Automation Platform
   compatible = "novatech,am335x-lxm", "ti,am33xx"
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 52b34a0..7dcf55e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -486,6 +486,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-cm-t335.dtb \
 	am335x-evm.dtb \
 	am335x-evmsk.dtb \
+	am335x-icev2.dtb \
 	am335x-lxm.dtb \
 	am335x-nano.dtb \
 	am335x-pepper.dtb \
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
new file mode 100644
index 0000000..59c91e8
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -0,0 +1,303 @@
+/*
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * AM335x ICE V2 board
+ * http://www.ti.com/tool/tmdsice3359
+ */
+
+/dts-v1/;
+
+#include "am33xx.dtsi"
+
+/ {
+	model = "TI AM3359 ICE-V2";
+	compatible = "ti,am3359-icev2", "ti,am33xx";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+
+	vbat: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbat";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
+
+	vtt_fixed: fixedregulator@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vtt";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		gpio = <&gpio0 18 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds>;
+
+		led@0 {
+			label = "out0";
+			gpios = <&tpic2810 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@1 {
+			label = "out1";
+			gpios = <&tpic2810 1 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@2 {
+			label = "out2";
+			gpios = <&tpic2810 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@3 {
+			label = "out3";
+			gpios = <&tpic2810 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@4 {
+			label = "out4";
+			gpios = <&tpic2810 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@5 {
+			label = "out5";
+			gpios = <&tpic2810 5 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@6 {
+			label = "out6";
+			gpios = <&tpic2810 6 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@7 {
+			label = "out7";
+			gpios = <&tpic2810 7 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		/* Tricolor status LEDs */
+		led@8 {
+			label = "status0:red:cpu0";
+			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "cpu0";
+		};
+
+		led@9 {
+			label = "status0:green:usr";
+			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@10 {
+			label = "status0:yellow:heartbeat";
+			gpios = <&gpio3 9 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led@11 {
+			label = "status1:red:mmc0";
+			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "mmc0";
+		};
+
+		led@12 {
+			label = "status1:green:usr";
+			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@13 {
+			label = "status1:yellow:usr";
+			gpios = <&gpio0 19 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+};
+
+&am33xx_pinmux {
+	user_leds: user_leds {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x91c, PIN_OUTPUT | MUX_MODE7) /* (J18) gmii1_txd3.gpio0[16] */
+			AM33XX_IOPAD(0x920, PIN_OUTPUT | MUX_MODE7) /* (K15) gmii1_txd2.gpio0[17] */
+			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] */
+			AM33XX_IOPAD(0x9b4, PIN_OUTPUT | MUX_MODE7) /* (D14) xdma_event_intr1.gpio0[20] */
+			AM33XX_IOPAD(0x880, PIN_OUTPUT | MUX_MODE7) /* (U9) gpmc_csn1.gpio1[30] */
+			AM33XX_IOPAD(0x92c, PIN_OUTPUT | MUX_MODE7) /* (K18) gmii1_txclk.gpio3[9] */
+		>;
+	};
+
+	mmc0_pins_default: mmc0_pins_default {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0) /* (F17) mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0) /* (F18) mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0) /* (G15) mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0) /* (G16) mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0) /* (G17) mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0) /* (G18) mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE5) /* (C15) spi0_cs1.mmc0_sdcd */
+		>;
+	};
+
+	i2c0_pins_default: i2c0_pins_default {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0) /* (C17) I2C0_SDA.I2C0_SDA */
+			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0) /* (C16) I2C0_SCL.I2C0_SCL */
+		>;
+	};
+
+	spi0_pins_default: spi0_pins_default {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* (A17) spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* (B17) spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* (B16) spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0) /* (A16) spi0_cs0.spi0_cs0 */
+		>;
+	};
+
+	uart3_pins_default: uart3_pins_default {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1) /* (L17) gmii1_rxd3.uart3_rxd */
+			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLUP | MUX_MODE1) /* (L16) gmii1_rxd2.uart3_txd */
+		>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_default>;
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tps: power-controller@2d {
+		reg = <0x2d>;
+	};
+
+	tpic2810: gpio@60 {
+		compatible = "ti,tpic2810";
+		reg = <0x60>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+#include "tps65910.dtsi"
+
+&tps {
+	vcc1-supply = <&vbat>;
+	vcc2-supply = <&vbat>;
+	vcc3-supply = <&vbat>;
+	vcc4-supply = <&vbat>;
+	vcc5-supply = <&vbat>;
+	vcc6-supply = <&vbat>;
+	vcc7-supply = <&vbat>;
+	vccio-supply = <&vbat>;
+
+	regulators {
+		vrtc_reg: regulator@0 {
+			regulator-always-on;
+		};
+
+		vio_reg: regulator@1 {
+			regulator-always-on;
+		};
+
+		vdd1_reg: regulator@2 {
+			regulator-name = "vdd_mpu";
+			regulator-min-microvolt = <912500>;
+			regulator-max-microvolt = <1326000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd2_reg: regulator@3 {
+			regulator-name = "vdd_core";
+			regulator-min-microvolt = <912500>;
+			regulator-max-microvolt = <1144000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd3_reg: regulator@4 {
+			regulator-always-on;
+		};
+
+		vdig1_reg: regulator@5 {
+			regulator-always-on;
+		};
+
+		vdig2_reg: regulator@6 {
+			regulator-always-on;
+		};
+
+		vpll_reg: regulator@7 {
+			regulator-always-on;
+		};
+
+		vdac_reg: regulator@8 {
+			regulator-always-on;
+		};
+
+		vaux1_reg: regulator@9 {
+			regulator-always-on;
+		};
+
+		vaux2_reg: regulator@10 {
+			regulator-always-on;
+		};
+
+		vaux33_reg: regulator@11 {
+			regulator-always-on;
+		};
+
+		vmmc_reg: regulator@12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+};
+
+&mmc1 {
+	status = "okay";
+	vmmc-supply = <&vmmc_reg>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_default>;
+};
+
+&gpio0 {
+	/* Do not idle the GPIO used for holding the VTT regulator */
+	ti,no-reset-on-init;
+	ti,no-idle-on-init;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins_default>;
+	status = "okay";
+};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
