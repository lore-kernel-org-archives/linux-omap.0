From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/8] ARM: dts: Add basic support for TMDSEVM3730 (Mistral
 AM/DM37x EVM)
Date: Thu, 10 Oct 2013 15:20:53 -0700
Message-ID: <20131010222053.9063.81702.stgit@localhost>
References: <20131010221833.9063.49904.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49378 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755643Ab3JJWUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 18:20:55 -0400
In-Reply-To: <20131010221833.9063.49904.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

I've tested the serial, MMC, smsc911x, wl12xx, and off-idle support
with the pinctrl patches, so it probably works better than the
board-*.c files ever did. Also the board-omap3evm.c file is broken
for the DSS, and has been for a while. Patches are welcome to fix
it in this .dts file, let's just drop the board-*.c file for this.

Note that off-idle currently requires doing request_irq() on the
wake-up pin from pinctrl-single IRQ domain until we can handle
that in some Linux generic way.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile              |    1 
 arch/arm/boot/dts/omap3-evm-37xx.dts    |  146 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-evm-common.dtsi |   36 ++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-evm-37xx.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 802720e..3c4e105 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -172,6 +172,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-devkit8000.dtb \
 	omap3-beagle-xm.dtb \
 	omap3-evm.dtb \
+	omap3-evm-37xx.dtb \
 	omap3-tobi.dtb \
 	omap3-igep0020.dtb \
 	omap3-igep0030.dtb \
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
new file mode 100644
index 0000000..d1642f7
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -0,0 +1,146 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap36xx.dtsi"
+#include "omap3-evm-common.dtsi"
+
+
+/ {
+	model = "TI OMAP37XX EVM (TMDSEVM3730)";
+	compatible = "ti,omap3-evm-37xx", "ti,omap36xx";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+};
+
+&omap3_pmx_core {
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
+			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
+			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
+			0x11a (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat1.sdmmc1_dat1 */
+			0x11c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat2.sdmmc1_dat2 */
+			0x11e (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat3.sdmmc1_dat3 */
+			0x120 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat4.sdmmc1_dat4 */
+			0x122 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat5.sdmmc1_dat5 */
+			0x124 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat6.sdmmc1_dat6 */
+			0x126 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat7.sdmmc1_dat7 */
+		>;
+	};
+
+	/* NOTE: Clocked externally, needs INPUT also for sdmmc2_clk.sdmmc2_clk */
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
+			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
+			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
+			0x12e (WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1.sdmmc2_dat1 */
+			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
+			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x16e (WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
+			0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+		>;
+	};
+
+	wl12xx_gpio: pinmux_wl12xx_gpio {
+		pinctrl-single,pins = <
+			0x150 (PIN_OUTPUT | MUX_MODE4)		/* uart1_cts.gpio_150 */
+			0x14e (PIN_INPUT | MUX_MODE4)		/* uart1_rts.gpio_149 */
+		>;
+	};
+
+	smsc911x_pins: pinmux_smsc911x_pins {
+		pinctrl-single,pins = <
+			0x1a2 (PIN_INPUT | MUX_MODE4)		/* mcspi1_cs2.gpio_176 */
+		>;
+	};
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+};
+
+&mmc3 {
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
+
+&gpmc {
+	ranges = <0 0 0x00000000 0x20000000>,
+		 <5 0 0x2c000000 0x01000000>;
+
+	nand@0,0 {
+		linux,mtd-name= "micron,mt29c4g96maz";
+		reg = <0 0 0>;
+		nand-bus-width = <16>;
+		ti,nand-ecc-opt = "bch8";
+
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "SPL";
+			reg = <0 0x100000>;
+		};
+		partition@0x80000 {
+			label = "U-Boot";
+			reg = <0x100000 0x180000>;
+		};
+		partition@0x1c0000 {
+			label = "Environment";
+			reg = <0x280000 0x100000>;
+		};
+		partition@0x280000 {
+			label = "Kernel";
+			reg = <0x380000 0x300000>;
+		};
+		partition@0x780000 {
+			label = "Filesystem";
+			reg = <0x680000 0x1f980000>;
+		};
+	};
+
+	ethernet@gpmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&smsc911x_pins>;
+	};
+};
diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index 75753bb..0020b1d 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -2,6 +2,8 @@
  * Common support for omap3 EVM boards
  */
 
+#include "omap-gpmc-smsc911x.dtsi"
+
 / {
 	cpus {
 		cpu@0 {
@@ -17,6 +19,19 @@
 			linux,default-trigger = "default-on";
 		};
 	};
+
+	wl12xx_vmmc: wl12xx_vmmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wl12xx_gpio>;
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio5 22 0>;	/* gpio150 */
+		startup-delay-us = <70000>;
+		enable-active-high;
+		vin-supply = <&vmmc2>;
+	};
 };
 
 &i2c1 {
@@ -48,6 +63,19 @@
 	};
 };
 
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
+	vmmc_aux-supply = <&vsim>;
+	bus-width = <8>;
+};
+
+&mmc2 {
+	vmmc-supply = <&wl12xx_vmmc>;
+	non-removable;
+	bus-width = <4>;
+	cap-power-off-card;
+};
+
 &twl_gpio {
 	ti,use-leds;
 };
@@ -58,3 +86,11 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&gpmc {
+	ethernet@gpmc {
+		interrupt-parent = <&gpio6>;
+		interrupts = <16 8>;
+		reg = <5 0 0xff>;
+	};
+};

