From: Jason Cooper <jason@lakedaemon.net>
Subject: [RFC PATCH 2/3] ARM: omap3: Seagate Wireless Plus DT entry
Date: Wed,  8 May 2013 19:23:33 +0000
Message-ID: <efaa16f8c19fecb6cca807654527490e98011fca.1368038129.git.jason@lakedaemon.net>
References: <cover.1368038129.git.jason@lakedaemon.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57528 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753081Ab3EHTX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 15:23:58 -0400
In-Reply-To: <cover.1368038129.git.jason@lakedaemon.net>
In-Reply-To: <cover.1368038129.git.jason@lakedaemon.net>
References: <cover.1368038129.git.jason@lakedaemon.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
NOTE: please see coverletter for details.

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/omap3-wireless_plus.dts | 314 ++++++++++++++++++++++++++++++
 2 files changed, 315 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-wireless_plus.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..a022a42 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -119,6 +119,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-beagle-xm.dtb \
 	omap3-evm.dtb \
 	omap3-tobi.dtb \
+	omap3-wireless_plus.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
diff --git a/arch/arm/boot/dts/omap3-wireless_plus.dts b/arch/arm/boot/dts/omap3-wireless_plus.dts
new file mode 100644
index 0000000..8a0acdf
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-wireless_plus.dts
@@ -0,0 +1,314 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "omap3.dtsi"
+
+/ {
+	model = "Seagate Wireless Plus (AM3703)";
+	compatible = "seagate,wireless-plus", "ti,omap3";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+};
+
+&omap3_pmx_core {
+
+	/*
+	 * map all board specific static pins enabled by the pinctrl driver
+	 * itself during the boot (or just set them up in the bootloader)
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdrc_pins &gpmc_pins &hsusb1_pins>;
+
+	/* AM3703CUS pins for this board */
+	sdrc_pins: pinmux_sdrc_pins {
+		pinctrl-single,pins = <
+			0x0000 0x100 /* SDRC_D0   (IEN  | PTD | DIS | M0) */
+			0x0002 0x100 /* SDRC_D1   (IEN  | PTD | DIS | M0) */
+			0x0004 0x100 /* SDRC_D2   (IEN  | PTD | DIS | M0) */
+			0x0006 0x100 /* SDRC_D3   (IEN  | PTD | DIS | M0) */
+			0x0008 0x100 /* SDRC_D4   (IEN  | PTD | DIS | M0) */
+			0x000A 0x100 /* SDRC_D5   (IEN  | PTD | DIS | M0) */
+			0x000C 0x100 /* SDRC_D6   (IEN  | PTD | DIS | M0) */
+			0x000E 0x100 /* SDRC_D7   (IEN  | PTD | DIS | M0) */
+			0x0010 0x100 /* SDRC_D8   (IEN  | PTD | DIS | M0) */
+			0x0012 0x100 /* SDRC_D9   (IEN  | PTD | DIS | M0) */
+			0x0014 0x100 /* SDRC_D10  (IEN  | PTD | DIS | M0) */
+			0x0016 0x100 /* SDRC_D11  (IEN  | PTD | DIS | M0) */
+			0x0018 0x100 /* SDRC_D12  (IEN  | PTD | DIS | M0) */
+			0x001A 0x100 /* SDRC_D13  (IEN  | PTD | DIS | M0) */
+			0x001C 0x100 /* SDRC_D14  (IEN  | PTD | DIS | M0) */
+			0x001E 0x100 /* SDRC_D15  (IEN  | PTD | DIS | M0) */
+			0x0020 0x100 /* SDRC_D16  (IEN  | PTD | DIS | M0) */
+			0x0022 0x100 /* SDRC_D17  (IEN  | PTD | DIS | M0) */
+			0x0024 0x100 /* SDRC_D18  (IEN  | PTD | DIS | M0) */
+			0x0026 0x100 /* SDRC_D19  (IEN  | PTD | DIS | M0) */
+			0x0028 0x100 /* SDRC_D20  (IEN  | PTD | DIS | M0) */
+			0x002A 0x100 /* SDRC_D21  (IEN  | PTD | DIS | M0) */
+			0x002C 0x100 /* SDRC_D22  (IEN  | PTD | DIS | M0) */
+			0x002E 0x100 /* SDRC_D23  (IEN  | PTD | DIS | M0) */
+			0x0030 0x100 /* SDRC_D24  (IEN  | PTD | DIS | M0) */
+			0x0032 0x100 /* SDRC_D25  (IEN  | PTD | DIS | M0) */
+			0x0034 0x100 /* SDRC_D26  (IEN  | PTD | DIS | M0) */
+			0x0036 0x100 /* SDRC_D27  (IEN  | PTD | DIS | M0) */
+			0x0038 0x100 /* SDRC_D28  (IEN  | PTD | DIS | M0) */
+			0x003A 0x100 /* SDRC_D29  (IEN  | PTD | DIS | M0) */
+			0x003C 0x100 /* SDRC_D30  (IEN  | PTD | DIS | M0) */
+			0x003E 0x100 /* SDRC_D31  (IEN  | PTD | DIS | M0) */
+			0x0040 0x100 /* SDRC_CLK  (IEN  | PTD | DIS | M0) */
+			0x0042 0x100 /* SDRC_DQS0 (IEN  | PTD | DIS | M0) */
+			0x0044 0x100 /* SDRC_DQS1 (IEN  | PTD | DIS | M0) */
+			0x0046 0x100 /* SDRC_DQS2 (IEN  | PTD | DIS | M0) */
+			0x0048 0x100 /* SDRC_DQS3 (IEN  | PTD | DIS | M0) */
+		>;
+	};
+
+	gpmc_pins: pinmux_gpmc_pins {
+		pinctrl-single,pins = <
+			0x004A 0x018 /* GPMC_A1	      (IDIS | PTU | EN  | M0) */
+			0x004C 0x018 /* GPMC_A2	      (IDIS | PTU | EN  | M0) */
+			0x004E 0x018 /* GPMC_A3	      (IDIS | PTU | EN  | M0) */
+			0x0050 0x018 /* GPMC_A4	      (IDIS | PTU | EN  | M0) */
+			0x0052 0x018 /* GPMC_A5	      (IDIS | PTU | EN  | M0) */
+			0x0054 0x018 /* GPMC_A6	      (IDIS | PTU | EN  | M0) */
+			0x0056 0x018 /* GPMC_A7	      (IDIS | PTU | EN  | M0) */
+			0x0058 0x018 /* GPMC_A8	      (IDIS | PTU | EN  | M0) */
+			0x005A 0x018 /* GPMC_A9	      (IDIS | PTU | EN  | M0) */
+			0x005C 0x018 /* GPMC_A10      (IDIS | PTU | EN  | M0) */
+			0x005E 0x118 /* GPMC_D0	      (IEN  | PTU | EN  | M0) */
+			0x0060 0x118 /* GPMC_D1	      (IEN  | PTU | EN  | M0) */
+			0x0062 0x118 /* GPMC_D2	      (IEN  | PTU | EN  | M0) */
+			0x0064 0x118 /* GPMC_D3	      (IEN  | PTU | EN  | M0) */
+			0x0066 0x118 /* GPMC_D4	      (IEN  | PTU | EN  | M0) */
+			0x0068 0x118 /* GPMC_D5	      (IEN  | PTU | EN  | M0) */
+			0x006A 0x118 /* GPMC_D6	      (IEN  | PTU | EN  | M0) */
+			0x006C 0x118 /* GPMC_D7	      (IEN  | PTU | EN  | M0) */
+			0x006E 0x118 /* GPMC_D8	      (IEN  | PTU | EN  | M0) */
+			0x0070 0x118 /* GPMC_D9	      (IEN  | PTU | EN  | M0) */
+			0x0072 0x118 /* GPMC_D1	      (IEN  | PTU | EN  | M0) */
+			0x0074 0x118 /* GPMC_D11      (IEN  | PTU | EN  | M0) */
+			0x0076 0x118 /* GPMC_D12      (IEN  | PTU | EN  | M0) */
+			0x0078 0x118 /* GPMC_D13      (IEN  | PTU | EN  | M0) */
+			0x007A 0x118 /* GPMC_D14      (IEN  | PTU | EN  | M0) */
+			0x007C 0x118 /* GPMC_D15      (IEN  | PTU | EN  | M0) */
+			0x007E 0x018 /* GPMC_NCS0     (IDIS | PTU | EN  | M0) */
+			0x0080 0x018 /* GPMC_NCS1     (IDIS | PTU | EN  | M0) */
+			0x0082 0x018 /* GPMC_NCS2     (IDIS | PTU | EN  | M0) */
+			0x0084 0x018 /* GPMC_NCS3     (IDIS | PTU | EN  | M0) */
+			0x0086 0x118 /* GPMC_NCS4     (IEN  | PTU | EN  | M0) */
+			0x0088 0x018 /* GPMC_NCS5     (IDIS | PTU | EN  | M0) */
+			0x008A 0x100 /* GPMC_NCS6     (IEN  | PTD | DIS | M0) */
+			0x008C 0x118 /* GPMC_NCS7     (IEN  | PTU | EN  | M0) */
+			0x008E 0x018 /* GPMC_CLK      (IDIS | PTU | EN  | M0) */
+			0x0090 0x000 /* GPMC_NADV_ALE (IDIS | PTD | DIS | M0) */
+			0x0092 0x000 /* GPMC_NOE      (IDIS | PTD | DIS | M0) */
+			0x0094 0x000 /* GPMC_NWE      (IDIS | PTD | DIS | M0) */
+			0x0096 0x018 /* GPMC_NBE0_CLE (IDIS | PTU | EN  | M0) */
+			0x0098 0x118 /* GPMC_NBE1     (IEN  | PTU | EN  | M0) */
+			0x009A 0x100 /* GPMC_NWP      (IEN  | PTD | DIS | M0) */
+			0x009C 0x118 /* GPMC_WAIT0    (IEN  | PTU | EN  | M0) */
+			0x009E 0x118 /* GPMC_WAIT1    (IEN  | PTU | EN  | M0) */
+			0x00A0 0x11C /* GPIO_64       (IEN  | PTU | EN  | M4) */
+			0x00A2 0x118 /* GPMC_WAIT3    (IEN  | PTU | EN  | M0) */
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pincntl-single,pins = <
+			0x0114 0x018 /* MMC1_CLK  (IDIS | PTU | EN  | M0) */
+			0x0116 0x118 /* MMC1_CMD  (IEN  | PTU | EN  | M0) */
+			0x0118 0x118 /* MMC1_DAT0 (IEN  | PTU | EN  | M0) */
+			0x011A 0x118 /* MMC1_DAT1 (IEN  | PTU | EN  | M0) */
+			0x011C 0x118 /* MMC1_DAT2 (IEN  | PTU | EN  | M0) */
+			0x011E 0x118 /* MMC1_DAT3 (IEN  | PTU | EN  | M0) */
+			0x0120 0x118 /* MMC1_DAT4 (IEN  | PTU | EN  | M0) */
+			0x0122 0x118 /* MMC1_DAT5 (IEN  | PTU | EN  | M0) */
+			0x0124 0x118 /* MMC1_DAT6 (IEN  | PTU | EN  | M0) */
+			0x0126 0x118 /* MMC1_DAT7 (IEN  | PTU | EN  | M0) */
+		>;
+	};
+
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			0x0128 0x100 /* MMC2_CLK  (IEN  | PTD | DIS | M0) */
+			0x012A 0x118 /* MMC2_CMD  (IEN  | PTU | EN  | M0) */
+			0x012C 0x118 /* MMC2_DAT0 (IEN  | PTU | EN  | M0) */
+			0x012E 0x118 /* MMC2_DAT1 (IEN  | PTU | EN  | M0) */
+			0x0130 0x118 /* MMC2_DAT2 (IEN  | PTU | EN  | M0) */
+			0x0132 0x118 /* MMC2_DAT3 (IEN  | PTU | EN  | M0) */
+			0x0134 0x000 /* MMC2_DAT4 (IDIS | PTD | DIS | M0) */
+			0x0136 0x000 /* MMC2_DAT5 (IDIS | PTD | DIS | M0) */
+			0x0138 0x000 /* MMC2_DAT6 (IDIS | PTD | DIS | M0) */
+			0x013A 0x118 /* MMC2_DAT7 (IEN  | PTU | EN  | M0) */
+		>;
+	};
+
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			0x014C 0x000 /* UART1_TX  (IDIS | PTD | DIS | M0) */
+			0x014E 0x000 /* UART1_RTS (IDIS | PTD | DIS | M0) */
+			0x0150 0x110 /* UART1_CTS (IEN  | PTU | DIS | M0) */
+			0x0152 0x100 /* UART1_RX  (IEN  | PTD | DIS | M0) */
+		>;
+	};
+
+	hsusb1_pins: pinmux_hsusb1_pins {
+		pinctrl-single,pins = <
+			0x0172 0x100 /* HSUSB0_CLK   (IEN  | PTD | DIS | M0) */
+			0x0174 0x018 /* HSUSB0_STP   (IDIS | PTU | EN  | M0) */
+			0x0176 0x100 /* HSUSB0_DIR   (IEN  | PTD | DIS | M0) */
+			0x0178 0x100 /* HSUSB0_NXT   (IEN  | PTD | DIS | M0) */
+			0x017A 0x100 /* HSUSB0_DATA0 (IEN  | PTD | DIS | M0) */
+			0x017C 0x100 /* HSUSB0_DATA1 (IEN  | PTD | DIS | M0) */
+			0x017E 0x100 /* HSUSB0_DATA2 (IEN  | PTD | DIS | M0) */
+			0x0180 0x100 /* HSUSB0_DATA3 (IEN  | PTD | DIS | M0) */
+			0x0182 0x100 /* HSUSB0_DATA4 (IEN  | PTD | DIS | M0) */
+			0x0184 0x100 /* HSUSB0_DATA5 (IEN  | PTD | DIS | M0) */
+			0x0186 0x100 /* HSUSB0_DATA6 (IEN  | PTD | DIS | M0) */
+			0x0188 0x100 /* HSUSB0_DATA7 (IEN  | PTD | DIS | M0) */
+		>;
+	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			0x018A 0x118 /* I2C1_SCL (IEN  | PTU | EN  | M0) */
+			0x018C 0x118 /* I2C1_SDA (IEN  | PTU | EN  | M0) */
+		>;
+	};
+
+	i2c4_pins: pinmux_i2c4_pins {
+		pinctrl-single,pins = <
+			0x09D0 0x007 /* I2C4_SCL (IDIS  | PTD | DIS | M7) */
+			0x09D2 0x007 /* I2C4_SDA (IDIS  | PTD | DIS | M7) */
+		>;
+	};
+
+	gpio170_pin: pinmux_gpio170_pin {
+		/* GPIO_170 Power_ON pin */
+		pinctrl-single,pins = <
+			0x0196 0x01C /* HDQ_SIO (IDIS | PTU | EN | M4) */
+		>;
+	};
+
+	gpio95_pin: pinmux_gpio95_pin {
+		/* GPIO_95 WLAN RESET keep low */
+		pinctrl-single,pins = <
+			0x00DE 0x00C /* CAM_VS  (IDIS | PTD | EN | M4) */
+		>;
+	};
+
+
+
+
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	pmu: tps6507x@48 {
+		compatible = "ti,tps6507x";
+		reg = <0x48>;
+
+		regulators {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			vdcdc1_reg: regulator@0 {
+				regulator-compatible = "VDCDC1";
+				reg = <0>;
+				regulator-min-microvolt = <725000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			vdcdc2_reg: regulator@1 {
+				regulator-compatible = "VDCDC2";
+				reg = <1>;
+				regulator-min-microvolt = <725000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+				defdcdc_default = <1>;
+			};
+			vdcdc3_reg: regulator@2 {
+				regulator-compatible = "VDCDC3";
+				reg = <2>;
+				regulator-min-microvolt = <725000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+				defdcdc_default = <1>;
+			};
+			ldo1_reg: regulator@3 {
+				regulator-compatible = "LDO1";
+				reg = <3>;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+			ldo2_reg: regulator@4 {
+				regulator-compatible = "LDO2";
+				reg = <4>;
+				regulator-min-microvolt = <725000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+/* optional on board WiFi */
+&mmc2 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+};
+
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c3 {
+	status = "disabled";
+};
+
+&uart2 {
+	status = "disabled";
+};
+
+&uart3 {
+	status = "disabled";
+};
+
+&mcspi1 {
+	status = "disabled";
+};
+
+&mcspi2 {
+	status = "disabled";
+};
+
+&mcspi3 {
+	status = "disabled";
+};
+
+&mcspi4 {
+	status = "disabled";
+};
-- 
1.8.2.1

