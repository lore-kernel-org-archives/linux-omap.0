From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/8] ARM: dts: Add basic support for zoom3
Date: Thu, 10 Oct 2013 15:20:55 -0700
Message-ID: <20131010222055.9063.29343.stgit@localhost>
References: <20131010221833.9063.49904.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49447 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755761Ab3JJWU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 18:20:57 -0400
In-Reply-To: <20131010221833.9063.49904.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

I've tested serial, MMC, smsc911x and wl12xx on zoom3. As my
omap is an early ES revision, I have not been able to test
off-idle on this one. But anyways, I'd say we have enough
device tree support for the zoom to be able to drop the
board-zoom files. Patches are welcome to add further features
to this .dts file.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile              |    1 
 arch/arm/boot/dts/omap-zoom-common.dtsi |   33 +++++
 arch/arm/boot/dts/omap3-zoom3.dts       |  217 +++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap-zoom-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-zoom3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3c4e105..ce332c8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -176,6 +176,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-tobi.dtb \
 	omap3-igep0020.dtb \
 	omap3-igep0030.dtb \
+	omap3-zoom3.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
diff --git a/arch/arm/boot/dts/omap-zoom-common.dtsi b/arch/arm/boot/dts/omap-zoom-common.dtsi
new file mode 100644
index 0000000..b0ee342
--- /dev/null
+++ b/arch/arm/boot/dts/omap-zoom-common.dtsi
@@ -0,0 +1,33 @@
+/*
+ * Common features on the Zoom debug board
+ */
+
+#include "omap-gpmc-smsc911x.dtsi"
+
+&gpmc {
+	ranges = <3 0 0x10000000 0x00000400>,
+		 <7 0 0x2c000000 0x01000000>;
+
+	/*
+	 * Four port TL16CP754C serial port on GPMC,
+	 * they probably share the same GPIO IRQ
+	 * REVISIT: Add timing support from slls644g.pdf
+	 */
+	8250@3,0 {
+		compatible = "ns16550a";
+		reg = <3 0 0x100>;
+		bank-width = <2>;
+		reg-shift = <1>;
+		reg-io-width = <1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <6 IRQ_TYPE_EDGE_RISING>;	/* gpio102 */
+		clock-frequency = <1843200>;
+		current-speed = <115200>;
+	};
+
+	ethernet@gpmc {
+		reg = <7 0 0xff>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;	/* gpio158 */
+	};
+};
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
new file mode 100644
index 0000000..15eb9fe
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -0,0 +1,217 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap36xx.dtsi"
+#include "omap-zoom-common.dtsi"
+
+/ {
+	model = "TI Zoom3";
+	compatible = "ti,omap3-zoom3", "ti,omap36xx", "ti,omap3";
+
+	cpus {
+		cpu@0 {
+			cpu0-supply = <&vcc>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512 MB */
+	};
+
+	vddvario: regulator-vddvario {
+		  compatible = "regulator-fixed";
+		  regulator-name = "vddvario";
+		  regulator-always-on;
+	};
+
+	vdd33a: regulator-vdd33a {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd33a";
+		regulator-always-on;
+	};
+
+	wl12xx_vmmc: wl12xx_vmmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wl12xx_gpio>;
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio4 5 0>;	/* gpio101 */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+};
+
+&omap3_pmx_core {
+	/* REVISIT: twl gpio0 is mmc0_cd */
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
+			0x116 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
+			0x118 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat0.sdmmc1_dat0 */
+			0x11a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
+			0x11c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
+			0x11e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
+		>;
+	};
+
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
+			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
+			0x12c (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat0.sdmmc2_dat0 */
+			0x12e (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
+			0x130 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat2.sdmmc2_dat2 */
+			0x132 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat3.sdmmc2_dat3 */
+			0x134 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat4.sdmmc2_dat4 */
+			0x136 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat5.sdmmc2_dat5 */
+			0x138 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat6.sdmmc2_dat6 */
+			0x13a (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat7.sdmmc2_dat7 */
+		>;
+	};
+
+	mmc3_pins: pinmux_mmc3_pins {
+		pinctrl-single,pins = <
+			0x168 (PIN_INPUT | MUX_MODE4)	/* mcbsp1_clkx.gpio_162 WLAN IRQ */
+			0x1a0 (PIN_INPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs1.sdmmc3_cmd */
+			0x5a8 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_clk.sdmmc3_clk */
+			0x5b4 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d4.sdmmc3_dat0 */
+			0x5b6 (WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE2) /* etk_d5.sdmmc3_dat1 */
+			0x5b8 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d6.sdmmc3_dat2 */
+			0x5b2 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d3.sdmmc3_dat3 */
+		>;
+	};
+
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+                        0x150 (PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
+                        0x14e (PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
+                        0x152 (WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
+                        0x14c (PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
+		>;
+	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+                        0x144 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
+                        0x146 (PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
+                        0x14a (WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart2_rx.uart2_rx */
+                        0x148 (PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+                        0x16a (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
+                        0x16c (PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
+                        0x16e (WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
+                        0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+		>;
+	};
+
+	/* wl12xx GPIO output for WLAN_EN */
+	wl12xx_gpio: pinmux_wl12xx_gpio {
+		pinctrl-single,pins = <
+			0xea (PIN_OUTPUT| MUX_MODE4)		/* cam_d2.gpio_101 */
+		>;
+	};
+};
+
+&omap3_pmx_wkup {
+	wlan_host_wkup: pinmux_wlan_host_wkup_pins {
+		pinctrl-single,pins = <
+			0x1a (PIN_INPUT_PULLUP | MUX_MODE4)	/* sys_clkout1.gpio_10 WLAN_HOST_WKUP */
+		>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+	};
+};
+
+#include "twl4030.dtsi"
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+
+	/*
+	 * TVP5146 Video decoder-in for analog input support.
+	 */
+	tvp5146@5c {
+		compatible = "ti,tvp5146m2";
+		reg = <0x5c>;
+	};
+};
+
+&twl_gpio {
+	ti,use-leds;
+};
+
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
+	vmmc_aux-supply = <&vsim>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+};
+/*
+&mmc2 {
+	vmmc-supply = <&vmmc2>;
+	ti,non-removable;
+	bus-width = <8>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+};
+*/
+&mmc3 {
+	vmmc-supply = <&wl12xx_vmmc>;
+	non-removable;
+	bus-width = <4>;
+	cap-power-off-card;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins>;
+};
+
+&uart1 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart1_pins>;
+};
+
+&uart2 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart2_pins>;
+};
+
+&uart3 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart3_pins>;
+};
+
+&uart4 {
+       status = "disabled";
+};
+
+&usb_otg_hs {
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	mode = <3>;
+	power = <50>;
+};

