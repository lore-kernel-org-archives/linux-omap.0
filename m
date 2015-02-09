From: Rostislav Lisovy <lisovy@gmail.com>
Subject: [PATCH 2/3] ARM: dts: am335x: Add DTS for ChiliSOM module
Date: Mon,  9 Feb 2015 15:48:04 +0100
Message-ID: <1423493285-4231-2-git-send-email-lisovy@jablotron.cz>
References: <1423493285-4231-1-git-send-email-lisovy@jablotron.cz>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:61226 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760689AbbBIOs3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2015 09:48:29 -0500
In-Reply-To: <1423493285-4231-1-git-send-email-lisovy@jablotron.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rostislav Lisovy <lisovy@jablotron.cz>

Since this is a SOM (System on Module) that will be part
of another embedded board (and can't really exist on its own)
define it as a "dtsi" that will be included in the Device tree
describing the whole system later on.

Hardware specification:
* AM335x SoC
* up to 512 MB RAM
* NAND Flash (8x interface, cs0)
* UART0
* PMIC
* I2C0 (for PMIC)
* 1x Ethernet MAC

Signed-off-by: Rostislav Lisovy <lisovy@jablotron.cz>
---
 arch/arm/boot/dts/am335x-chilisom.dtsi | 239 +++++++++++++++++++++++++++++++++
 1 file changed, 239 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-chilisom.dtsi

diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
new file mode 100644
index 0000000..54c0c10
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -0,0 +1,239 @@
+/*
+ * Copyright (C) 2015 Jablotron s.r.o. -- http://www.jablotron.com/
+ * Author: Rostislav Lisovy <lisovy@jablotron.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "am33xx.dtsi"
+
+/ {
+	model = "Grinn AM335x ChiliSOM";
+	compatible = "grinn,am335x-chilisom", "ti,am33xx";
+
+	cpus {
+		cpu@0 {
+			cpu0-supply = <&dcdc2_reg>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512 MB */
+	};
+};
+
+&am33xx_pinmux {
+	pinctrl-names = "default";
+
+	i2c0_pins: pinmux_i2c0_pins {
+		pinctrl-single,pins = <
+			0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+		>;
+	};
+
+	uart0_pins: pinmux_uart0_pins {
+		pinctrl-single,pins = <
+			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+		>;
+	};
+
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_crs.rmii1_crs */
+			0x110 (PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
+			0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			0x13c (PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			0x140 (PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_ref_clk.rmii_ref_clk */
+		>;
+	};
+
+	cpsw_sleep: cpsw_sleep {
+		pinctrl-single,pins = <
+			/* Slave 1 reset value */
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	davinci_mdio_default: davinci_mdio_default {
+		pinctrl-single,pins = <
+			/* mdio_data.mdio_data */
+			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)
+			/* mdio_clk.mdio_clk */
+			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)
+		>;
+	};
+
+	davinci_mdio_sleep: davinci_mdio_sleep {
+		pinctrl-single,pins = <
+			/* MDIO reset value */
+			0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	nandflash_pins: nandflash_pins {
+		pinctrl-single,pins = <
+			0x00 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			0x04 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			0x08 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			0x0c (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			0x10 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			0x14 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			0x18 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			0x1c (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+
+			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			0x7c (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_csn0.gpmc_csn0 */
+			0x90 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_advn_ale.gpmc_advn_ale */
+			0x94 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_oen_ren.gpmc_oen_ren */
+			0x98 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_wen.gpmc_wen */
+			0x9c (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_be0n_cle.gpmc_be0n_cle */
+		>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tps: tps@24 {
+		reg = <0x24>;
+	};
+
+};
+
+/include/ "tps65217.dtsi"
+
+&tps {
+	regulators {
+		dcdc1_reg: regulator@0 {
+			regulator-name = "vdds_dpr";
+			regulator-always-on;
+		};
+
+		dcdc2_reg: regulator@1 {
+			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
+			regulator-name = "vdd_mpu";
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <1325000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		dcdc3_reg: regulator@2 {
+			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
+			regulator-name = "vdd_core";
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <1150000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo1_reg: regulator@3 {
+			regulator-name = "vio,vrtc,vdds";
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo2_reg: regulator@4 {
+			regulator-name = "vdd_3v3aux";
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo3_reg: regulator@5 {
+			regulator-name = "vdd_1v8";
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo4_reg: regulator@6 {
+			regulator-name = "vdd_3v3d";
+			regulator-boot-on;
+			regulator-always-on;
+		};
+	};
+};
+
+/* Ethernet MAC */
+&mac {
+	slaves = <1>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_default>;
+	pinctrl-1 = <&cpsw_sleep>;
+	status = "okay";
+};
+
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_default>;
+	pinctrl-1 = <&davinci_mdio_sleep>;
+	status = "okay";
+};
+
+/* NAND Flash */
+&elm {
+	status = "okay";
+};
+
+&gpmc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nandflash_pins>;
+	ranges = <0 0 0x08000000 0x01000000>; /* CS0 0 @addr 0x08000000, size 0x01000000 */
+	nand@0,0 {
+		reg = <0 0 0x01000000>; /* CS0 */
+		ti,nand-ecc-opt = "bch8";
+		ti,elm-id = <&elm>;
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+	};
+};
-- 
2.1.0

