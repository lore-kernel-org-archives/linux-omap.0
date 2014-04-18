From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH 1/4] ARM: dts: Add support for OMAP4 Variscite OM44 family
Date: Fri, 18 Apr 2014 17:10:46 +0200
Message-ID: <1397833849-22396-2-git-send-email-manabian@gmail.com>
References: <1397833849-22396-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:52475 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaDRPLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 11:11:05 -0400
Received: by mail-lb0-f180.google.com with SMTP id 10so1458615lbg.11
        for <linux-omap@vger.kernel.org>; Fri, 18 Apr 2014 08:11:04 -0700 (PDT)
In-Reply-To: <1397833849-22396-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

Add support for VAR-SOM-OM44[1] SODIMM system on module from Variscite. SoM
features a OMAP4460, 1GB RAM, Gigabit Ethernet (LAN7500) and optional WLAN/BT.

Also add support for VAR-STK-OM44 development board from Variscite. This kit
features a VAR-SOM-OM44 and the carrier board VAR-OM44CustomBoard[2]. The
VAR-STK-OM44 is the same as VAR-DVK-OM44 but without the LCD display.

omap4-var-stk-om44.dts replace the old and very limited omap4-var-som.dts.

[1] http://www.variscite.com/products/system-on-module-som/cortex-a9/var-som-om44-cpu-ti-omap-4-omap4460
[2] http://www.variscite.com/products/single-board-computers/var-om44customboard

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +-
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi   | 235 ++++++++++++++
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          | 343 +++++++++++++++++++++
 arch/arm/boot/dts/omap4-var-som.dts                |  96 ------
 arch/arm/boot/dts/omap4-var-stk-om44.dts           |  16 +
 7 files changed, 599 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-var-om44customboard.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-var-som-om44.dtsi
 delete mode 100644 arch/arm/boot/dts/omap4-var-som.dts
 create mode 100644 arch/arm/boot/dts/omap4-var-stk-om44.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 36ede19a1630..7db69ac46188 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -102,6 +102,9 @@ Boards:
 - OMAP4 DuoVero with Parlor : Commercial expansion board with daughter board
   compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
 
+- OMAP4 VAR-STK-OM44 : Commercial dev kit with VAR-OM44CustomBoard and VAR-SOM-OM44 w/WLAN
+  compatible = "variscite,var-stk-om44", "variscite,var-som-om44", "ti,omap4430", "ti,omap4";
+
 - OMAP3 EVM : Software Development Board for OMAP35x, AM/DM37x
   compatible = "ti,omap3-evm", "ti,omap3"
 
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0f01c9bf19c8..8a149a4b07de 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -112,6 +112,7 @@ tlm	Trusted Logic Mobility
 toshiba	Toshiba Corporation
 toumaz	Toumaz
 v3	V3 Semiconductor
+variscite	Variscite Ltd.
 via	VIA Technologies, Inc.
 voipac	Voipac Technologies s.r.o.
 winbond Winbond Electronics corp.
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 35c146f31e46..f443ade8ae3c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -273,7 +273,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
-	omap4-var-som.dtb \
+	omap4-var-stk-om44.dtb \
 	omap4-sdp.dtb \
 	omap4-sdp-es23plus.dtb \
 	omap5-uevm.dtb \
diff --git a/arch/arm/boot/dts/omap4-var-om44customboard.dtsi b/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
new file mode 100644
index 000000000000..7c8e383b2cd0
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
@@ -0,0 +1,235 @@
+/*
+ * Copyright (C) 2014 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	aliases {
+		display0 = &hdmi0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_led_pins>;
+
+		led0 {
+			label = "var:green:led0";
+			gpios = <&gpio6 13 GPIO_ACTIVE_HIGH>; /* gpio 173 */
+			linux,default-trigger = "heartbeat";
+		};
+
+		led1 {
+			label = "var:green:led1";
+			gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>; /* gpio 172 */
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_key_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-key@184 {
+			label = "user";
+			gpios = <&gpio6 24 GPIO_ACTIVE_HIGH>; /* gpio 184 */
+			linux,code = <BTN_EXTRA>;
+			gpio-key,wakeup;
+		};
+	};
+
+	hdmi0: connector@0 {
+		compatible = "hdmi-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd_pins>;
+		label = "hdmi";
+		type = "a";
+
+		hpd-gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>; /* gpio_63 */
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
+};
+
+&omap4_pmx_core {
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			0xfc (PIN_INPUT_PULLUP | MUX_MODE1)	/* mcspi1_cs2.uart1_cts */
+			0xfe (PIN_OUTPUT | MUX_MODE1)		/* mcspi1_cs3.uart1_rts */
+			0xe6 (PIN_INPUT_PULLUP | MUX_MODE1)	/* i2c2_scl.uart1_rx */
+			0xe8 (PIN_OUTPUT | MUX_MODE1)		/* i2c2_sda.uart1_tx */
+		>;
+	};
+
+	mcspi1_pins: pinmux_mcspi1_pins {
+		pinctrl-single,pins = <
+			0xf2 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_clk.mcspi1_clk */
+			0xf4 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_somi.mcspi1_somi */
+			0xf6 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_simo.mcspi1_simo */
+			0xf8 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_cs0.mcspi1_cs0 */
+		>;
+	};
+
+	mcasp_pins: pinmux_mcsasp_pins {
+		pinctrl-single,pins = <
+			0xb8 (PIN_OUTPUT | MUX_MODE2)		/*  mcbsp2_dr.abe_mcasp_axr */
+		>;
+	};
+
+	dss_dpi_pins: pinmux_dss_dpi_pins {
+		pinctrl-single,pins = <
+			0x122 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data23 */
+			0x124 (PIN_OUTPUT | MUX_MODE5) 		/* dispc2_data22 */
+			0x126 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data21 */
+			0x128 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data20 */
+			0x12a (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data19 */
+			0x12c (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data18 */
+			0x12e (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data15 */
+			0x130 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data14 */
+			0x132 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data13 */
+			0x134 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data12 */
+			0x136 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data11 */
+			0x174 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data10 */
+			0x176 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data9 */
+			0x178 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data16 */
+			0x17a (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data17 */
+			0x17c (PIN_OUTPUT | MUX_MODE5)		/* dispc2_hsync */
+			0x17e (PIN_OUTPUT | MUX_MODE5)		/* dispc2_pclk */
+			0x180 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_vsync */
+			0x182 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_de */
+			0x184 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data8 */
+			0x186 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data7 */
+			0x188 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data6 */
+			0x18a (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data5 */
+			0x18c (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data4 */
+			0x18e (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data3 */
+			0x190 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data2 */
+			0x192 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data1 */
+			0x194 (PIN_OUTPUT | MUX_MODE5)		/* dispc2_data0 */
+		>;
+	};
+
+	dss_hdmi_pins: pinmux_dss_hdmi_pins {
+		pinctrl-single,pins = <
+			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+			0x5c (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_scl.hdmi_scl */
+			0x5e (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_sda.hdmi_sda */
+		>;
+	};
+
+	i2c4_pins: pinmux_i2c4_pins {
+		pinctrl-single,pins = <
+			0xee (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
+			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
+		>;
+	};
+
+	mmc5_pins: pinmux_mmc5_pins {
+		pinctrl-single,pins = <
+			0x0b6 (PIN_INPUT | MUX_MODE3)		/* abe_mcbsp2_clkx.gpio_110 */
+			0x108 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_clk.sdmmc5_clk */
+			0x10a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_cmd.sdmmc5_cmd */
+			0x10c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat0.sdmmc5_dat0 */
+			0x10e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1.sdmmc5_dat1 */
+			0x110 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat2.sdmmc5_dat2 */
+			0x112 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3.sdmmc5_dat3 */
+		>;
+	};
+
+	gpio_led_pins: pinmux_gpio_led_pins {
+		pinctrl-single,pins = <
+			0x13e (PIN_OUTPUT | MUX_MODE3)		/* kpd_col4.gpio_172 */
+			0x140 (PIN_OUTPUT | MUX_MODE3)		/* kpd_col5.gpio_173 */
+		>;
+	};
+
+	gpio_key_pins: pinmux_gpio_key_pins {
+		pinctrl-single,pins = <
+			0x162 (PIN_INPUT | MUX_MODE3)		/* sys_boot0.gpio_184 */
+		>;
+	};
+
+	ks8851_irq_pins: pinmux_ks8851_irq_pins {
+		pinctrl-single,pins = <
+			0x13c (PIN_INPUT_PULLUP | MUX_MODE3)	/* kpd_col3.gpio_171 */
+		>;
+	};
+
+	hdmi_hpd_pins: pinmux_hdmi_hpd_pins {
+		pinctrl-single,pins = <
+			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* hdmi_hpd.gpio_63 */
+		>;
+	};
+
+	backlight_pins: pinmux_backlight_pins {
+		pinctrl-single,pins = <
+			0xd6 (PIN_OUTPUT | MUX_MODE3)		/* abe_dmic_din3.gpio_122 */
+		>;
+	};
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&mcspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi1_pins>;
+	status = "okay";
+
+	eth@0 {
+		compatible = "ks8851";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ks8851_irq_pins>;
+		spi-max-frequency = <24000000>;
+		reg = <0>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* gpio 171 */
+	};
+};
+
+&mmc5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc5_pins>;
+	vmmc-supply = <&vbat>;
+	bus-width = <4>;
+	cd-gpios = <&gpio4 14 GPIO_ACTIVE_HIGH>; /* gpio 110 */
+	status = "okay";
+};
+
+&dss {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_hdmi_pins>;
+	vdda-supply = <&vdac>;
+
+	port {
+		hdmi_out: endpoint {
+			remote-endpoint = <&hdmi_connector_in>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
new file mode 100644
index 000000000000..3ae70479ae26
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
@@ -0,0 +1,343 @@
+/*
+ * Copyright (C) 2014 Joachim Eastwood <manabian@gmail.com>
+ * Copyright (C) 2012 Variscite Ltd. - http://www.variscite.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "omap4460.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-OM44";
+	compatible = "variscite,var-som-om44", "ti,omap4430", "ti,omap4";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>; /* 1 GB */
+	};
+
+	sound: sound {
+		compatible = "ti,abe-twl6040";
+		ti,model = "VAR-SOM-OM44";
+
+		ti,mclk-freq = <38400000>;
+		ti,mcpdm = <&mcpdm>;
+		ti,twl6040 = <&twl6040>;
+
+		/* Audio routing */
+		ti,audio-routing =
+			"Headset Stereophone", "HSOL",
+			"Headset Stereophone", "HSOR",
+			"AFML", "Line In",
+			"AFMR", "Line In";
+	};
+
+	/* HS USB Host PHY on PORT 1 */
+	hsusb1_phy: hsusb1_phy {
+		compatible = "usb-nop-xceiv";
+		pinctrl-names = "default";
+		pinctrl-0 = <
+			&hsusbb1_phy_clk_pins
+			&hsusbb1_phy_rst_pins
+		>;
+
+		reset-gpios = <&gpio6 17 GPIO_ACTIVE_LOW>; /* gpio 177 */
+		vcc-supply = <&vbat>;
+
+		clocks = <&auxclk3_ck>;
+		clock-names = "main_clk";
+		clock-frequency = <19200000>;
+	};
+
+	vbat: fixedregulator-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "VBAT";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&omap4_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&hsusbb1_pins
+	>;
+
+	twl6040_pins: pinmux_twl6040_pins {
+		pinctrl-single,pins = <
+			0x15c (PIN_OUTPUT | MUX_MODE3)		/* fref_clk2_out.gpio_182 */
+			0x160 (PIN_INPUT | MUX_MODE0)		/* sys_nirq2.sys_nirq2 */
+		>;
+	};
+
+	mcpdm_pins: pinmux_mcpdm_pins {
+		pinctrl-single,pins = <
+			0xc6 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_ul_data.abe_pdm_ul_data */
+			0xc8 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_dl_data.abe_pdm_dl_data */
+			0xca (PIN_INPUT_PULLUP | MUX_MODE0)	/* abe_pdm_frame.abe_pdm_frame */
+			0xcc (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_lb_clk.abe_pdm_lb_clk */
+			0xce (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
+		>;
+	};
+
+	tsc2004_pins: pinmux_tsc2004_pins {
+		pinctrl-single,pins = <
+			0x50 (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs4.gpio_101 (irq) */
+			0x52 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_ncs5.gpio_102 (rst) */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
+			0x102 (PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
+			0x104 (PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
+			0x106 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+		>;
+	};
+
+	hsusbb1_pins: pinmux_hsusbb1_pins {
+		pinctrl-single,pins = <
+			0x82 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_clk.usbb1_ulpiphy_clk */
+			0x84 (PIN_OUTPUT | MUX_MODE4)		/* usbb1_ulpitll_stp.usbb1_ulpiphy_stp */
+			0x86 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dir.usbb1_ulpiphy_dir */
+			0x88 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_nxt.usbb1_ulpiphy_nxt */
+			0x8a (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat0.usbb1_ulpiphy_dat0 */
+			0x8c (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat1.usbb1_ulpiphy_dat1 */
+			0x8e (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat2.usbb1_ulpiphy_dat2 */
+			0x90 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat3.usbb1_ulpiphy_dat3 */
+			0x92 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat4.usbb1_ulpiphy_dat4 */
+			0x94 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat5.usbb1_ulpiphy_dat5 */
+			0x96 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat6.usbb1_ulpiphy_dat6 */
+			0x98 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat7.usbb1_ulpiphy_dat7 */
+		>;
+	};
+
+	hsusbb1_phy_rst_pins: pinmux_hsusbb1_phy_rst_pins {
+		pinctrl-single,pins = <
+			0x14c (PIN_OUTPUT | MUX_MODE3)		/* kpd_row2.gpio_177 */
+		>;
+	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			0xe2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			0xe4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			0xea (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
+			0xec (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0xa2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
+			0xa4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
+			0xa6 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat0.sdmmc1_dat0 */
+			0xa8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
+			0xaa (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
+			0xac (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
+		>;
+	};
+};
+
+&omap4_pmx_wkup {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&hsusbb1_hub_rst_pins
+		&lan7500_rst_pins
+	>;
+
+	hsusbb1_phy_clk_pins: pinmux_hsusbb1_phy_clk_pins {
+		pinctrl-single,pins = <
+			0x18 (PIN_OUTPUT | MUX_MODE0)	/* fref_clk3_out */
+		>;
+	};
+
+	hsusbb1_hub_rst_pins: pinmux_hsusbb1_hub_rst_pins {
+		pinctrl-single,pins = <
+			0x2 (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk1 */
+		>;
+	};
+
+	lan7500_rst_pins: pinmux_lan7500_rst_pins {
+		pinctrl-single,pins = <
+			0x0 (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk0 */
+		>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+
+	clock-frequency = <400000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
+		interrupt-parent = <&gic>;
+	};
+
+	twl6040: twl@4b {
+		compatible = "ti,twl6040";
+		reg = <0x4b>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&twl6040_pins>;
+
+		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
+		interrupt-parent = <&gic>;
+		ti,audpwron-gpio = <&gpio6 22 0>; /* gpio 182 */
+
+		vio-supply = <&v1v8>;
+		v2v1-supply = <&v2v1>;
+		enable-active-high;
+	};
+};
+
+#include "twl6030.dtsi"
+#include "twl6030_omap4.dtsi"
+
+&vusim {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-always-on;
+};
+
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	status = "okay";
+
+	clock-frequency = <400000>;
+
+	tsc2004@48 {
+		compatible = "ti,tsc2004";
+		pinctrl-names = "default";
+		pinctrl-0 = <&tsc2004_pins>;
+		reg = <0x48>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>; /* gpio 101 */
+		status = "disabled";
+	};
+
+	tmp105@49 {
+		compatible = "ti,tmp105";
+		reg = <0x49>;
+	};
+
+	eeprom@50 {
+		compatible = "microchip,24c32";
+		reg = <0x50>;
+	};
+};
+
+&i2c4 {
+	status = "disabled";
+};
+
+&mcpdm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcpdm_pins>;
+	status = "okay";
+};
+
+&gpmc {
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
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&vmmc>;
+	bus-width = <4>;
+	ti,non-removable;
+	status = "okay";
+};
+
+&mmc2 {
+	status = "disabled";
+};
+
+&mmc3 {
+	status = "disabled";
+};
+
+&mmc4 {
+	status = "disabled";
+};
+
+&mmc5 {
+	status = "disabled";
+};
+
+&uart1 {
+	status = "disabled";
+};
+
+&uart2 {
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "okay";
+};
+
+&uart4 {
+	status = "disabled";
+};
+
+&keypad {
+	status = "disabled";
+};
+
+&twl_usb_comparator {
+	usb-supply = <&vusb>;
+};
+
+&usb_otg_hs {
+	interface-type = <1>;
+	mode = <3>;
+	power = <50>;
+};
+
+&usbhshost {
+	port1-mode = "ehci-phy";
+};
+
+&usbhsehci {
+	phys = <&hsusb1_phy>;
+};
diff --git a/arch/arm/boot/dts/omap4-var-som.dts b/arch/arm/boot/dts/omap4-var-som.dts
deleted file mode 100644
index b41269e871dd..000000000000
--- a/arch/arm/boot/dts/omap4-var-som.dts
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * Copyright (C) 2012 Variscite Ltd. - http://www.variscite.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-/dts-v1/;
-
-#include "omap443x.dtsi"
-
-/ {
-	model = "Variscite OMAP4 SOM";
-	compatible = "var,omap4-var_som", "ti,omap4430", "ti,omap4";
-
-	memory {
-		device_type = "memory";
-		reg = <0x80000000 0x40000000>; /* 1 GB */
-	};
-
-	vdd_eth: fixedregulator@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "VDD_ETH";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		enable-active-high;
-		regulator-boot-on;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-
-	twl: twl@48 {
-		reg = <0x48>;
-		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
-		interrupt-parent = <&gic>;
-	};
-};
-
-#include "twl6030.dtsi"
-
-&i2c2 {
-	clock-frequency = <400000>;
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-
-	/*
-	 * Temperature Sensor
-	 * http://www.ti.com/lit/ds/symlink/tmp105.pdf
-	 */
-	tmp105@49 {
-		compatible = "ti,tmp105";
-		reg = <0x49>;
-	};
-};
-
-&i2c4 {
-	clock-frequency = <400000>;
-};
-
-&mcspi1 {
-	eth@0 {
-		compatible = "ks8851";
-		spi-max-frequency = <24000000>;
-		reg = <0>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* gpio line 171 */
-		vdd-supply = <&vdd_eth>;
-	};
-};
-
-&mmc1 {
-	vmmc-supply = <&vmmc>;
-	ti,bus-width = <8>;
-	ti,non-removable;
-};
-
-&mmc2 {
-	status = "disabled";
-};
-
-&mmc3 {
-	status = "disabled";
-};
-
-&mmc4 {
-	status = "disabled";
-};
-
-&mmc5 {
-	ti,bus-width = <4>;
-};
diff --git a/arch/arm/boot/dts/omap4-var-stk-om44.dts b/arch/arm/boot/dts/omap4-var-stk-om44.dts
new file mode 100644
index 000000000000..35e2364374f7
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-var-stk-om44.dts
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2014 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap4-var-som-om44.dtsi"
+#include "omap4-var-om44customboard.dtsi"
+
+/ {
+	model = "Variscite VAR-STK-OM44";
+	compatible = "variscite,var-stk-om44", "variscite,var-som-om44", "ti,omap4430", "ti,omap4";
+};
-- 
1.8.0

