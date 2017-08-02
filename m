From: SZ Lin <sz.lin-D4fb9hXD9d4@public.gmane.org>
Subject: [PATCH v2] arm, am335x: add support for Moxa UC-8100-ME-T open platform
Date: Wed,  2 Aug 2017 14:57:57 +0800
Message-ID: <20170802065757.1074-1-sz.lin@moxa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SZ Lin <sz.lin-D4fb9hXD9d4@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add support for Moxa UC-8100-ME-T open platform

The UC-8100-ME-T computing platform is designed
for embedded data acquisition industrial applications

The features of UC-8100-ME-T series are:
* eMMC
* SPI flash
* SD slot
* 2x LAN
* 2 RS-232/422/485 ports, software-selectable
* Mini PCIe form factor with USB signal
* USB host
* EEPROM
* TPM
* Watchdog
* RTC
* User gpio-keys
* User LEDs
* User button

Signed-off-by: SZ Lin <sz.lin-D4fb9hXD9d4@public.gmane.org>
---
Changes from v1:
- Remove the un-needed @ in led@x's
- Use AM33XX_IOPAD pinmux macro
- Properly alphabetize Makefile

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts     | 525 +++++++++++++++++++++
 3 files changed, 529 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 8219b2c6bb29..72ad8700156a 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -154,6 +154,9 @@ Boards:
 - AM335X phyCORE-AM335x: Development kit
   compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx"
 
+- AM335X UC-8100-ME-T: Communication-centric industrial computing platform
+  compatible = "moxa,uc-8100-me-t", "ti,am33xx";
+
 - OMAP5 EVM : Evaluation Module
   compatible = "ti,omap5-evm", "ti,omap5"
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35dc9a7..c293e841eea3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -617,6 +617,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-evmsk.dtb \
 	am335x-icev2.dtb \
 	am335x-lxm.dtb \
+	am335x-moxa-uc-8100-me-t.dtb \
 	am335x-nano.dtb \
 	am335x-pepper.dtb \
 	am335x-phycore-rdk.dtb \
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
new file mode 100644
index 000000000000..0aa1d10a0bed
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -0,0 +1,525 @@
+/*
+ * Copyright (C) 2017 MOXA Inc. - https://www.moxa.com/
+ *
+ * Author: SZ Lin (林上智) <sz.lin-D4fb9hXD9d4@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "am33xx.dtsi"
+
+/ {
+	model = "Moxa UC-8100-ME-T";
+	compatible = "moxa,uc-8100-me-t", "ti,am33xx";
+
+	cpus {
+		cpu@0 {
+			cpu0-supply = <&vdd1_reg>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512 MB */
+	};
+
+	vbat: fixedregulator@0 {
+		compatible = "regulator-fixed";
+	};
+
+	/* Power supply provides a fixed 3.3V @3A */
+	vmmcsd_fixed: fixedregulator@1 {
+	      compatible = "regulator-fixed";
+	      regulator-name = "vmmcsd_fixed";
+	      regulator-min-microvolt = <3300000>;
+	      regulator-max-microvolt = <3300000>;
+	      regulator-boot-on;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			label = "uc8100me:CEL1";
+			gpios = <&gpio_xten 8 0>;
+			default-state = "off";
+		};
+
+		led2 {
+			label = "uc8100me:CEL2";
+			gpios = <&gpio_xten 9 0>;
+			default-state = "off";
+		};
+
+		led3 {
+			label = "uc8100me:CEL3";
+			gpios = <&gpio_xten 10 0>;
+			default-state = "off";
+		};
+
+		led4 {
+			label = "uc8100me:DIA1";
+			gpios = <&gpio_xten 11 0>;
+			default-state = "off";
+		};
+		led5 {
+			label = "uc8100me:DIA2";
+			gpios = <&gpio_xten 12 0>;
+			default-state = "off";
+		};
+		led6 {
+			label = "uc8100me:DIA3";
+			gpios = <&gpio_xten 13 0>;
+			default-state = "off";
+		};
+		led7 {
+			label = "uc8100me:SD";
+			gpios = <&gpio_xten 14 0>;
+			default-state = "off";
+		};
+		led8 {
+			label = "uc8100me:USB";
+			gpios = <&gpio_xten 15 0>;
+			default-state = "off";
+		};
+		led9 {
+			label = "uc8100me:USER";
+			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	buttons: push_button {
+		compatible = "gpio-keys";
+	};
+
+};
+
+&am33xx_pinmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&minipcie_pins>;
+
+	minipcie_pins: pinmux_minipcie {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.gpio2_24 */
+			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.gpio2_25 */
+			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.gpio2_22  Power off PIN*/
+		>;
+	};
+
+	push_button_pins: pinmux_push_button {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* mcasp0_ahcklx.gpio3_21 */
+		>;
+	};
+
+	i2c0_pins: pinmux_i2c0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c0_scl.i2c0_scl */
+		>;
+	};
+
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart0_ctsn.i2c1_sda */
+			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart0_rtsn.i2c1_scl */
+		>;
+	};
+
+	uart0_pins: pinmux_uart0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+		>;
+	};
+
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)    /* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(0x984, PIN_OUTPUT | MUX_MODE0)		/* uart1_txd.uart1_txd */
+		>;
+	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x8d8, PIN_INPUT | MUX_MODE6)		/* lcd_data14.uart5_ctsn */
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT_PULLDOWN | MUX_MODE6)  /* lcd_data15.uart5_rtsn */
+			AM33XX_IOPAD(0x8c4, PIN_INPUT_PULLUP | MUX_MODE4)     /* lcd_data9.uart5_rxd */
+			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE4)		/* lcd_data8.uart5_txd */
+		>;
+	};
+
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_rxerr.rmii1_rxerr */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txen.rmii1_txen */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mii1_refclk.rmii1_refclk */
+
+			/* Slave 2 */
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_crs_dv */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rxer */
+			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_txen */
+			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_td1 */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_td0 */
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rd1 */
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rd0 */
+			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE1)  /* rmii2_refclk */
+
+		>;
+	};
+
+	davinci_mdio_default: davinci_mdio_default {
+		pinctrl-single,pins = <
+			/* MDIO */
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+		>;
+	};
+
+	mmc0_pins_default: pinmux_mmc0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0 */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd */
+			AM33XX_IOPAD(0x990, PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkx.gpio3_14 */
+			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)    /* mcasp0_aclkx.gpio3_18 */
+		>;
+	};
+
+	mmc2_pins_default: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			/* eMMC */
+			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
+			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
+			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
+			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
+			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad8.mmc2_dat4 */
+			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad9.mmc2_dat5 */
+			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad10.mmc2_dat6 */
+			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad11.mmc2_dat7 */
+			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_csn3.mmc2_cmd */
+			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk */
+		>;
+	};
+
+	spi0_pins: pinmux_spi0 {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d1.spi0_d1 */
+		>;
+	};
+
+};
+
+&uart0 {
+	/* Console */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+};
+
+&uart1 {
+	/* UART 1 setting */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+};
+
+&uart5 {
+	/* UART 2 setting */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tpm: tpm@20 {
+		compatible = "infineon,slb9645tt";
+		reg = <0x20>;
+	};
+
+	tps: tps@2d {
+		compatible = "ti,tps65910";
+		reg = <0x2d>;
+	};
+
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c16";
+		pagesize = <16>;
+		reg = <0x50>;
+	};
+
+	rtc_wdt: rtc_wdt@68 {
+		compatible = "dallas,ds1374";
+		reg = <0x68>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	status = "okay";
+	clock-frequency = <400000>;
+	gpio_xten: gpio_xten@27 {
+		compatible = "nxp,pca9535";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x27>;
+	};
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb_ctrl_mod {
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&usb1_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&usb1 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&cppi41dma  {
+	status = "okay";
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
+			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
+			regulator-name = "vdd_mpu";
+			regulator-min-microvolt = <912500>;
+			regulator-max-microvolt = <1378000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd2_reg: regulator@3 {
+			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
+			regulator-name = "vdd_core";
+			regulator-min-microvolt = <912500>;
+			regulator-max-microvolt = <1150000>;
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
+			compatible = "regulator-fixed";
+			regulator-name = "vmmc_reg";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+};
+
+/* Power */
+&vbat {
+	regulator-name = "vbat";
+	regulator-min-microvolt = <5000000>;
+	regulator-max-microvolt = <5000000>;
+};
+
+&mac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpsw_default>;
+	dual_emac = <1>;
+	status = "okay";
+};
+
+&davinci_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&davinci_mdio_default>;
+	status = "okay";
+};
+
+&cpsw_emac0 {
+	status = "okay";
+	phy_id = <&davinci_mdio>, <4>;
+	phy-mode = "rmii";
+	dual_emac_res_vlan = <1>;
+};
+
+&cpsw_emac1 {
+	status = "okay";
+	phy_id = <&davinci_mdio>, <5>;
+	phy-mode = "rmii";
+	dual_emac_res_vlan = <2>;
+};
+
+&phy_sel {
+	reg= <0x44e10650 0xf5>;
+	rmii-clock-ext;
+};
+
+&sham {
+	status = "okay";
+};
+
+&aes {
+	status = "okay";
+};
+
+&gpio0 {
+	ti,no-reset-on-init;
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	vmmc-supply = <&vmmcsd_fixed>;
+	bus-width = <4>;
+	pinctrl-0 = <&mmc0_pins_default>;
+	cd-gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
+	wp-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&mmc3 {
+	dmas = <&edma_xbar 12 0 1
+			&edma_xbar 13 0 2>;
+	dma-names = "tx", "rx";
+	pinctrl-names = "default";
+	vmmc-supply = <&vmmcsd_fixed>;
+	bus-width = <8>;
+	pinctrl-0 = <&mmc2_pins_default>;
+	ti,non-removable;
+	status = "okay";
+};
+
+&buttons {
+	pinctrl-names = "default";
+	pinctrl-0 = <&push_button_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	button@0 {
+		label = "push_button";
+		linux,code = <0x100>;
+		gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
+	};
+};
+
+/* SPI Busses */
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+
+	m25p80@0 {
+		compatible = "mx25l6405d";
+		spi-max-frequency = <40000000>;
+
+		reg = <0>;
+		spi-cpol;
+		spi-cpha;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* reg : The partition's offset and size within the mtd bank. */
+		partitions@0 {
+			label = "MLO";
+			reg = <0x0 0x80000>;
+		};
+
+		partitions@1 {
+			label = "U-Boot";
+			reg = <0x80000 0x100000>;
+		};
+
+		partitions@2 {
+			label = "U-Boot Env";
+			reg = <0x180000 0x20000>;
+		};
+	};
+};
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
