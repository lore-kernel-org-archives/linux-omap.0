From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH 1/3] ARM: dts: split am335x-baltos-ir5221 into dts and dtsi files
Date: Tue, 26 Apr 2016 15:00:24 +0200
Message-ID: <1461675626-5818-2-git-send-email-yegorslists@googlemail.com>
References: <1461675626-5818-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461675626-5818-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Introduce am335x-baltos.dtsi, that provides common configuration
for the whole device family based on the same SODIMM module.

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 387 +--------------------------
 arch/arm/boot/dts/am335x-baltos.dtsi       | 408 +++++++++++++++++++++++++++++
 2 files changed, 409 insertions(+), 386 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-baltos.dtsi

diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index e432e15..d0faa7b 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -13,83 +13,19 @@
 
 /dts-v1/;
 
-#include "am33xx.dtsi"
-#include <dt-bindings/pwm/pwm.h>
-#include <dt-bindings/interrupt-controller/irq.h>
+#include "am335x-baltos.dtsi"
 
 / {
 	model = "OnRISC Baltos iR 5221";
-	compatible = "vscom,onrisc", "ti,am33xx";
-
-	cpus {
-		cpu@0 {
-			cpu0-supply = <&vdd1_reg>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x80000000 0x10000000>; /* 256 MB */
-	};
-
-	vbat: fixedregulator@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vbat";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-boot-on;
-	};
-
-	wl12xx_vmmc: fixedregulator@2 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&wl12xx_gpio>;
-		compatible = "regulator-fixed";
-		regulator-name = "vwl1271";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 8 0>;
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
 };
 
 &am33xx_pinmux {
-	mmc2_pins: pinmux_mmc2_pins {
-		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad8.mmc1_dat0_mux0 */
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad9.mmc1_dat1_mux0 */
-			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad10.mmc1_dat2_mux0 */
-			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad11.mmc1_dat3_mux0 */
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_csn1.mmc1_clk_mux0 */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_csn2.mmc1_cmd_mux0 */
-			AM33XX_IOPAD(0x9e4, PIN_INPUT_PULLUP | MUX_MODE7)      /* emu0.gpio3[7] */
-		>;
-	};
-
-	wl12xx_gpio: pinmux_wl12xx_gpio {
-		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9e8, PIN_OUTPUT_PULLUP | MUX_MODE7)      /* emu1.gpio3[8] */
-		>;
-	};
-
-	tps65910_pins: pinmux_tps65910_pins {
-		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE7)      /* gpmc_ben1.gpio1[28] */
-		>;
-	};
-
 	tca6416_pins: pinmux_tca6416_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
 		>;
 	};
 
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x958, PIN_INPUT | MUX_MODE2)      /* spi0_d1.i2c1_sda_mux3 */
-			AM33XX_IOPAD(0x95c, PIN_INPUT | MUX_MODE2)      /* spi0_cs0.i2c1_scl_mux3 */
-		>;
-	};
 
 	dcan1_pins: pinmux_dcan1_pins {
 		pinctrl-single,pins = <
@@ -98,13 +34,6 @@
 		>;
 	};
 
-	uart0_pins: pinmux_uart0_pins {
-		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart0_txd.uart0_txd */
-		>;
-	};
-
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)      /* uart1_rxd */
@@ -133,152 +62,6 @@
 		>;
 	};
 
-	cpsw_default: cpsw_default {
-		pinctrl-single,pins = <
-			/* Slave 1 */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)       /* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_tx_en.rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)      /* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)      /* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* rmii1_ref_clk.rmii1_refclk */
-
-
-			/* Slave 2 */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
-			AM33XX_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
-		>;
-	};
-
-	cpsw_sleep: cpsw_sleep {
-		pinctrl-single,pins = <
-			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
-
-			/* Slave 2 reset value*/
-			AM33XX_IOPAD(0x840, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x848, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x850, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x854, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-		>;
-	};
-
-	davinci_mdio_default: davinci_mdio_default {
-		pinctrl-single,pins = <
-			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
-		>;
-	};
-
-	davinci_mdio_sleep: davinci_mdio_sleep {
-		pinctrl-single,pins = <
-			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-		>;
-	};
-
-	nandflash_pins_s0: nandflash_pins_s0 {
-		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
-		>;
-	};
-};
-
-&elm {
-	status = "okay";
-};
-
-&gpmc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&nandflash_pins_s0>;
-	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
-	status = "okay";
-
-	nand@0,0 {
-		compatible = "ti,omap2-nand";
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
-		interrupt-parent = <&gpmc>;
-		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
-			     <1 IRQ_TYPE_NONE>;	/* termcount */
-		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
-		nand-bus-width = <8>;
-		ti,nand-ecc-opt = "bch8";
-		ti,nand-xfer-type = "polled";
-
-		gpmc,device-nand = "true";
-		gpmc,device-width = <1>;
-		gpmc,sync-clk-ps = <0>;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <44>;
-		gpmc,cs-wr-off-ns = <44>;
-		gpmc,adv-on-ns = <6>;
-		gpmc,adv-rd-off-ns = <34>;
-		gpmc,adv-wr-off-ns = <44>;
-		gpmc,we-on-ns = <0>;
-		gpmc,we-off-ns = <40>;
-		gpmc,oe-on-ns = <0>;
-		gpmc,oe-off-ns = <54>;
-		gpmc,access-ns = <64>;
-		gpmc,rd-cycle-ns = <82>;
-		gpmc,wr-cycle-ns = <82>;
-		gpmc,bus-turnaround-ns = <0>;
-		gpmc,cycle2cycle-delay-ns = <0>;
-		gpmc,clk-activation-ns = <0>;
-		gpmc,wr-access-ns = <40>;
-		gpmc,wr-data-mux-bus-ns = <0>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-		elm_id = <&elm>;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
-
-	status = "okay";
 };
 
 &uart1 {
@@ -304,28 +87,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-
-	status = "okay";
-	clock-frequency = <400000>;
-
-	tps: tps@2d {
-		reg = <0x2d>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <28 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&tps65910_pins>;
-	};
-
-	at24@50 {
-		compatible = "at24,24c02";
-		pagesize = <8>;
-		reg = <0x50>;
-	};
-
 	tca6416: gpio@20 {
 		compatible = "ti,tca6416";
 		reg = <0x20>;
@@ -338,14 +99,6 @@
 	};
 };
 
-&usb {
-	status = "okay";
-};
-
-&usb_ctrl_mod {
-	status = "okay";
-};
-
 &usb0_phy {
 	status = "okay";
 };
@@ -364,108 +117,6 @@
 	dr_mode = "otg";
 };
 
-&cppi41dma  {
-	status = "okay";
-};
-
-#include "tps65910.dtsi"
-
-&tps {
-	vcc1-supply = <&vbat>;
-	vcc2-supply = <&vbat>;
-	vcc3-supply = <&vbat>;
-	vcc4-supply = <&vbat>;
-	vcc5-supply = <&vbat>;
-	vcc6-supply = <&vbat>;
-	vcc7-supply = <&vbat>;
-	vccio-supply = <&vbat>;
-
-	ti,en-ck32k-xtal = <1>;
-
-	regulators {
-		vrtc_reg: regulator@0 {
-			regulator-always-on;
-		};
-
-		vio_reg: regulator@1 {
-			regulator-always-on;
-		};
-
-		vdd1_reg: regulator@2 {
-			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
-			regulator-name = "vdd_mpu";
-			regulator-min-microvolt = <912500>;
-			regulator-max-microvolt = <1312500>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
-
-		vdd2_reg: regulator@3 {
-			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
-			regulator-name = "vdd_core";
-			regulator-min-microvolt = <912500>;
-			regulator-max-microvolt = <1150000>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
-
-		vdd3_reg: regulator@4 {
-			regulator-always-on;
-		};
-
-		vdig1_reg: regulator@5 {
-			regulator-always-on;
-		};
-
-		vdig2_reg: regulator@6 {
-			regulator-always-on;
-		};
-
-		vpll_reg: regulator@7 {
-			regulator-always-on;
-		};
-
-		vdac_reg: regulator@8 {
-			regulator-always-on;
-		};
-
-		vaux1_reg: regulator@9 {
-			regulator-always-on;
-		};
-
-		vaux2_reg: regulator@10 {
-			regulator-always-on;
-		};
-
-		vaux33_reg: regulator@11 {
-			regulator-always-on;
-		};
-
-		vmmc_reg: regulator@12 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-	};
-};
-
-&mac {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&cpsw_default>;
-	pinctrl-1 = <&cpsw_sleep>;
-	dual_emac = <1>;
-
-	status = "okay";
-};
-
-&davinci_mdio {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&davinci_mdio_default>;
-	pinctrl-1 = <&davinci_mdio_sleep>;
-
-	status = "okay";
-};
-
 &cpsw_emac0 {
 	phy-mode = "rmii";
 	dual_emac_res_vlan = <1>;
@@ -485,42 +136,6 @@
 	rmii-clock-ext = <1>;
 };
 
-&mmc1 {
-	vmmc-supply = <&vmmc_reg>;
-	status = "okay";
-};
-
-&mmc2 {
-	status = "okay";
-	vmmc-supply = <&wl12xx_vmmc>;
-	ti,non-removable;
-	bus-width = <4>;
-	cap-power-off-card;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	wlcore: wlcore@2 {
-		compatible = "ti,wl1835";
-		reg = <2>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
-	};
-};
-
-&sham {
-	status = "okay";
-};
-
-&aes {
-	status = "okay";
-};
-
-&gpio0 {
-	ti,no-reset-on-init;
-};
-
 &dcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dcan1_pins>;
diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
new file mode 100644
index 0000000..c8609d8
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -0,0 +1,408 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * VScom OnRISC
+ * http://www.vscom.de
+ */
+
+#include "am33xx.dtsi"
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "vscom,onrisc", "ti,am33xx";
+
+	cpus {
+		cpu@0 {
+			cpu0-supply = <&vdd1_reg>;
+		};
+	};
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
+	wl12xx_vmmc: fixedregulator@2 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wl12xx_gpio>;
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 8 0>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+};
+
+&am33xx_pinmux {
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad8.mmc1_dat0_mux0 */
+			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad9.mmc1_dat1_mux0 */
+			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad10.mmc1_dat2_mux0 */
+			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad11.mmc1_dat3_mux0 */
+			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_csn1.mmc1_clk_mux0 */
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_csn2.mmc1_cmd_mux0 */
+			AM33XX_IOPAD(0x9e4, PIN_INPUT_PULLUP | MUX_MODE7)      /* emu0.gpio3[7] */
+		>;
+	};
+
+	wl12xx_gpio: pinmux_wl12xx_gpio {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x9e8, PIN_OUTPUT_PULLUP | MUX_MODE7)      /* emu1.gpio3[8] */
+		>;
+	};
+
+	tps65910_pins: pinmux_tps65910_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE7)      /* gpmc_ben1.gpio1[28] */
+		>;
+	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x958, PIN_INPUT | MUX_MODE2)      /* spi0_d1.i2c1_sda_mux3 */
+			AM33XX_IOPAD(0x95c, PIN_INPUT | MUX_MODE2)      /* spi0_cs0.i2c1_scl_mux3 */
+		>;
+	};
+
+	uart0_pins: pinmux_uart0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart0_txd.uart0_txd */
+		>;
+	};
+
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)       /* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_tx_en.rmii1_txen */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)      /* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)      /* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* rmii1_ref_clk.rmii1_refclk */
+
+
+			/* Slave 2 */
+			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
+			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
+			AM33XX_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
+			AM33XX_IOPAD(0x84c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
+			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
+			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
+			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
+			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
+			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
+		>;
+	};
+
+	cpsw_sleep: cpsw_sleep {
+		pinctrl-single,pins = <
+			/* Slave 1 reset value */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
+
+			/* Slave 2 reset value*/
+			AM33XX_IOPAD(0x840, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x848, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x850, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x854, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)
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
+	davinci_mdio_sleep: davinci_mdio_sleep {
+		pinctrl-single,pins = <
+			/* MDIO reset value */
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	nandflash_pins_s0: nandflash_pins_s0 {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
+			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+		>;
+	};
+};
+
+&elm {
+	status = "okay";
+};
+
+&gpmc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nandflash_pins_s0>;
+	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	status = "okay";
+
+	nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		interrupt-parent = <&gpmc>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
+		nand-bus-width = <8>;
+		ti,nand-ecc-opt = "bch8";
+		ti,nand-xfer-type = "polled";
+
+		gpmc,device-nand = "true";
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
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		elm_id = <&elm>;
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
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tps: tps@2d {
+		reg = <0x2d>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <28 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tps65910_pins>;
+	};
+
+	at24@50 {
+		compatible = "at24,24c02";
+		pagesize = <8>;
+		reg = <0x50>;
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
+	ti,en-ck32k-xtal = <1>;
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
+			regulator-max-microvolt = <1312500>;
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
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+};
+
+&mac {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_default>;
+	pinctrl-1 = <&cpsw_sleep>;
+	dual_emac = <1>;
+
+	status = "okay";
+};
+
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_default>;
+	pinctrl-1 = <&davinci_mdio_sleep>;
+
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&vmmc_reg>;
+	status = "okay";
+};
+
+&mmc2 {
+	status = "okay";
+	vmmc-supply = <&wl12xx_vmmc>;
+	ti,non-removable;
+	bus-width = <4>;
+	cap-power-off-card;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+	};
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
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
