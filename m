From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] arm, am335x: add support for the bosch shc board
Date: Mon, 16 Nov 2015 09:15:58 +0100
Message-ID: <1447661758-5095-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Georg.Soffel-k21M0aUVSxZWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

add support for the am335x based shc board.

UART: 0-2 and 4
DRAM: 512 MiB
MMC:  OMAP SD/MMC: 0 @ 26 MHz
      OMAP SD/MMC: 1 @ 26 MHz
I2C:  at24 eeprom, pcf8563
USB:  USB1 (host)

Signed-off-by: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
---
The following patches are needed to get all working
for the shc board:
- disable clkout on pcf8563
  accepted.
  http://www.spinics.net/lists/devicetree/msg98542.html

- leds: leds-gpio: add shutdown function
  accepted.
  https://lkml.org/lkml/2015/10/13/169

- net: phy: smsc: disable energy detect mode
  accepted
  [PATCH v2 2/2] net: phy: smsc: disable energy detect mode
  https://lkml.org/lkml/2015/10/17/2
  [PATCH v2 1/2] drivers: net: cpsw: add phy-handle parsing
  https://lkml.org/lkml/2015/10/17/4

- ARM: OMAP2+: omap_hwmod: Introduce ti,no-init dt property
  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328204.html
  @Dave: What is the current state of this patch?
  I have the same problem here on this am335x based board

- [PATCH v2] regulator: tps65217: remove tps65217.dtsi file
  http://www.kernelhub.org/?msg=868907&p=2

- bootlog and automated tests:
  http://xeidos.ddns.net/buildbot/waterfall

 arch/arm/boot/dts/Makefile       |   3 +-
 arch/arm/boot/dts/am335x-shc.dts | 577 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 579 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am335x-shc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 30bbc37..65d750f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -466,7 +466,8 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-pepper.dtb \
 	am335x-lxm.dtb \
 	am335x-chiliboard.dtb \
-	am335x-wega-rdk.dtb
+	am335x-wega-rdk.dtb \
+	am335x-shc.dtb
 dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-duovero-parlor.dtb \
 	omap4-panda.dtb \
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
new file mode 100644
index 0000000..c2aceea
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -0,0 +1,577 @@
+/*
+ * support for the bosch am335x based shc c3 board
+ *
+ * Copyright (C) 2015 Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "am33xx.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Bosch SHC";
+	compatible = "ti,am335x-shc", "ti,am335x-bone", "ti,am33xx";
+
+	aliases {
+		mmcblk0 = &mmc1;
+		mmcblk1 = &mmc2;
+	};
+
+	cpus {
+		cpu@0 {
+			/*
+			 * To consider voltage drop between PMIC and SoC,
+			 * tolerance value is reduced to 2% from 4% and
+			 * voltage value is increased as a precaution.
+			 */
+			operating-points = <
+				/* kHz    uV */
+				594000  1225000
+				294000  1125000
+			>;
+			voltage-tolerance = <2>; /* 2 percentage */
+			cpu0-supply = <&dcdc2_reg>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		back_button {
+			label = "Back Button";
+			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_BACK>;
+			debounce-interval = <1000>;
+			gpio-key,wakeup;
+		};
+
+		front_button {
+			label = "Front Button";
+			gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_FRONT>;
+			debounce-interval = <1000>;
+			gpio-key,wakeup;
+		};
+	};
+
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
+		compatible = "gpio-leds";
+
+		led@1 {
+			label = "shc:power:red";
+			gpios = <&gpio0 23 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@2 {
+			label = "shc:power:bl";
+			gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "timer";
+			default-state = "on";
+		};
+
+		led@3 {
+			label = "shc:lan:red";
+			gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@4 {
+			label = "shc:lan:bl";
+			gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@5 {
+			label = "shc:cloud:red";
+			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@6 {
+			label = "shc:cloud:bl";
+			gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512 MB */
+	};
+
+	vmmcsd_fixed: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&aes {
+	status = "okay";
+};
+
+&cppi41dma  {
+	status = "okay";
+};
+
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_default>;
+	pinctrl-1 = <&davinci_mdio_sleep>;
+	status = "okay";
+
+	ethernetphy0: ethernet-phy@0 {
+		reg = <0>;
+		smsc,disable-energy-detect;
+	};
+};
+
+&epwmss1 {
+	status = "okay";
+
+	ehrpwm1: ehrpwm@48302200 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ehrpwm1_pins>;
+		status = "okay";
+	};
+};
+
+&gpio1 {
+	hmtc_rst {
+		gpio-hog;
+		gpios = <24 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "homematic_reset";
+	};
+
+	hmtc_prog {
+		gpio-hog;
+		gpios = <27 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "homematic_program";
+	};
+};
+
+&gpio3 {
+	zgb_rst {
+		gpio-hog;
+		gpios = <18 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "zigbee_reset";
+	};
+
+	zgb_boot {
+		gpio-hog;
+		gpios = <19 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "zigbee_boot";
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tps: tps@24 {
+		reg = <0x24>;
+	};
+
+	at24@50 {
+		compatible = "at24,24c32";
+		pagesize = <32>;
+		reg = <0x50>;
+	};
+
+	pcf8563@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&mac {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_default>;
+	pinctrl-1 = <&cpsw_sleep>;
+	status = "okay";
+	slaves = <1>;
+	cpsw_emac0: slave@4a100200  {
+		phy_id = <&davinci_mdio>, <0>;
+		phy-mode = "mii";
+		phy-handle = <&ethernetphy0>;
+	};
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	bus-width = <0x4>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+	max-frequency = <26000000>;
+	vmmc-supply = <&vmmcsd_fixed>;
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_pins>;
+	bus-width = <8>;
+	max-frequency = <26000000>;
+	sd-uhs-sdr25;
+	vmmc-supply = <&vmmcsd_fixed>;
+	status = "okay";
+};
+
+&mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins>;
+	bus-width = <4>;
+	cap-power-off-card;
+	max-frequency = <26000000>;
+	sd-uhs-sdr25;
+	vmmc-supply = <&vmmcsd_fixed>;
+	status = "okay";
+};
+
+&rtc {
+	ti,no-init;
+};
+
+&sham {
+	status = "okay";
+};
+
+&tps {
+	compatible = "ti,tps65217";
+	ti,pmic-shutdown-controller;
+
+	regulators {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dcdc1_reg: regulator@0 {
+			reg = <0>;
+			regulator-name = "vdds_dpr";
+			regulator-compatible = "dcdc1";
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1450000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		dcdc2_reg: regulator@1 {
+			reg = <1>;
+			/*
+			 * VDD_MPU voltage limits 0.95V - 1.26V with
+			 * +/-4% tolerance
+			 */
+			regulator-compatible = "dcdc2";
+			regulator-name = "vdd_mpu";
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <1375000>;
+			regulator-boot-on;
+			regulator-always-on;
+			regulator-ramp-delay = <70000>;
+		};
+
+		dcdc3_reg: regulator@2 {
+			reg = <2>;
+			/*
+			 * VDD_CORE voltage limits 0.95V - 1.1V with
+			 * +/-4% tolerance
+			 */
+			regulator-name = "vdd_core";
+			regulator-compatible = "dcdc3";
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <1125000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		ldo1_reg: regulator@3 {
+			reg = <3>;
+			regulator-name = "vio,vrtc,vdds";
+			regulator-compatible = "ldo1";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		ldo2_reg: regulator@4 {
+			reg = <4>;
+			regulator-name = "vdd_3v3aux";
+			regulator-compatible = "ldo2";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		ldo3_reg: regulator@5 {
+			reg = <5>;
+			regulator-name = "vdd_1v8";
+			regulator-compatible = "ldo3";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		ldo4_reg: regulator@6 {
+			reg = <6>;
+			regulator-name = "vdd_3v3a";
+			regulator-compatible = "ldo4";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins>;
+	status = "okay";
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
+&usb1_phy {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&am33xx_pinmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&clkout2_pin>;
+
+	clkout2_pin: pinmux_clkout2_pin {
+		pinctrl-single,pins = <
+			/* xdma_event_intr1.clkout2 */
+			0x1b4 (PIN_INPUT | MUX_MODE6)
+		>;
+	};
+
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			0x124 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x128 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)
+			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+
+	cpsw_sleep: cpsw_sleep {
+		pinctrl-single,pins = <
+			/* Slave 1 reset value */
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
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
+	ehrpwm1_pins: pinmux_ehrpwm1 {
+		pinctrl-single,pins = <
+			0x4c (PIN_OUTPUT | MUX_MODE6) /* gpmc_a3.gpio1_19 */
+		>;
+	};
+
+	emmc_pins: pinmux_emmc_pins {
+		pinctrl-single,pins = <
+			0x80 (PIN_INPUT | MUX_MODE2)
+			0x84 (PIN_INPUT_PULLUP | MUX_MODE2)
+			0x00 (PIN_INPUT_PULLUP | MUX_MODE1)
+			0x04 (PIN_INPUT_PULLUP | MUX_MODE1)
+			0x08 (PIN_INPUT_PULLUP | MUX_MODE1)
+			0x0c (PIN_INPUT_PULLUP | MUX_MODE1)
+			0x10 (PIN_INPUT_PULLUP | MUX_MODE1)
+			0x14 (PIN_INPUT_PULLUP | MUX_MODE1)
+			0x18 (PIN_INPUT_PULLUP | MUX_MODE1)
+			0x1c (PIN_INPUT_PULLUP | MUX_MODE1)
+		>;
+	};
+
+	i2c0_pins: pinmux_i2c0_pins {
+		pinctrl-single,pins = <
+			0x188 (PIN_INPUT | MUX_MODE0)
+			0x18c (PIN_INPUT | MUX_MODE0)
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x160 (PIN_INPUT | MUX_MODE5)
+		>;
+	};
+
+	mmc3_pins: pinmux_mmc3_pins {
+		pinctrl-single,pins = <
+			0x30 (PIN_INPUT | MUX_MODE3)
+			0x34 (PIN_INPUT | MUX_MODE3)
+			0x38 (PIN_INPUT | MUX_MODE3)
+			0x3c (PIN_INPUT | MUX_MODE3)
+			0x88 (PIN_INPUT | MUX_MODE3)
+			0x8c (PIN_INPUT | MUX_MODE3)
+		>;
+	};
+
+	uart0_pins: pinmux_uart0_pins {
+		pinctrl-single,pins = <
+			0x168 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x16c (PIN_OUTPUT | MUX_MODE0)
+			0x170 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x174 (PIN_OUTPUT | MUX_MODE0)
+		>;
+	};
+
+	uart1_pins: pinmux_uart1 {
+		pinctrl-single,pins = <
+			0x178 (PIN_INPUT_PULLDOWN | MUX_MODE0)
+			0x17C (PIN_OUTPUT | MUX_MODE0)
+			0x180 (PIN_INPUT | MUX_MODE0)
+			0x184 (PIN_OUTPUT | MUX_MODE0)
+		>;
+	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			0x150 (PIN_INPUT | MUX_MODE1)
+			0x154 (PIN_OUTPUT | MUX_MODE1)
+		>;
+	};
+
+	uart4_pins: pinmux_uart4_pins {
+		pinctrl-single,pins = <
+			0x70 (PIN_INPUT_PULLUP | MUX_MODE6)
+			0x74 (PIN_OUTPUT_PULLUP | MUX_MODE6)
+		>;
+	};
+
+	user_leds_s0: user_leds_s0 {
+		pinctrl-single,pins = <
+			0x20 (PIN_OUTPUT | MUX_MODE7)
+			0x24 (PIN_OUTPUT | MUX_MODE7)
+			0x28 (PIN_OUTPUT | MUX_MODE7)
+			0x2c (PIN_OUTPUT | MUX_MODE7)
+			0x40 (PIN_OUTPUT | MUX_MODE7)
+			0x44 (PIN_OUTPUT | MUX_MODE7)
+			0x48 (PIN_OUTPUT | MUX_MODE7)
+			0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+			0x54 (PIN_OUTPUT | MUX_MODE7)
+			0x58 (PIN_OUTPUT | MUX_MODE7)
+			0x5c (PIN_OUTPUT_PULLUP | MUX_MODE7)
+			0x60 (PIN_INPUT | MUX_MODE7)
+			0x64 (PIN_INPUT | MUX_MODE7)
+			0x68 (PIN_INPUT | MUX_MODE7)
+			0x6c (PIN_INPUT | MUX_MODE7)
+			0x78 (PIN_OUTPUT_PULLUP | MUX_MODE7)
+			0x7c (PIN_INPUT | MUX_MODE7)
+			0x90 (PIN_OUTPUT | MUX_MODE7)
+			0x94 (PIN_INPUT | MUX_MODE7)
+			0x98 (PIN_OUTPUT | MUX_MODE7)
+			0x9c (PIN_OUTPUT | MUX_MODE7)
+			0xa0 (PIN_OUTPUT | MUX_MODE7)
+			0xa4 (PIN_OUTPUT | MUX_MODE7)
+			0xa8 (PIN_OUTPUT | MUX_MODE7)
+			0xac (PIN_OUTPUT | MUX_MODE7)
+			0xb0 (PIN_OUTPUT | MUX_MODE7)
+			0xb4 (PIN_OUTPUT | MUX_MODE7)
+			0xb8 (PIN_OUTPUT | MUX_MODE7)
+			0xbc (PIN_OUTPUT | MUX_MODE7)
+			0xc0 (PIN_OUTPUT | MUX_MODE7)
+			0xc4 (PIN_OUTPUT | MUX_MODE7)
+			0xc8 (PIN_OUTPUT | MUX_MODE7)
+			0xcc (PIN_OUTPUT | MUX_MODE7)
+			0xd0 (PIN_OUTPUT | MUX_MODE7)
+			0xd4 (PIN_OUTPUT | MUX_MODE7)
+			0xd8 (PIN_OUTPUT | MUX_MODE7)
+			0xdc (PIN_OUTPUT | MUX_MODE7)
+			0xe0 (PIN_OUTPUT | MUX_MODE7)
+			0xe4 (PIN_OUTPUT | MUX_MODE7)
+			0xe8 (PIN_OUTPUT | MUX_MODE7)
+			0xec (PIN_OUTPUT | MUX_MODE7)
+			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x158 (PIN_OUTPUT | MUX_MODE7)
+			0x15c (PIN_OUTPUT | MUX_MODE7)
+			0x164 (PIN_OUTPUT_PULLUP | MUX_MODE7)
+			0x1a0 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+			0x1a4 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x1ac (PIN_INPUT_PULLUP | MUX_MODE7)
+		>;
+	};
+};
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
