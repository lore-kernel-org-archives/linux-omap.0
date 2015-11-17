From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v2] arm, am335x: add support for the bosch shc board
Date: Tue, 17 Nov 2015 09:24:15 +0100
Message-ID: <1447748655-2088-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Georg.Soffel-k21M0aUVSxZWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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

Changes in v2:
- Use IOPAD pinmux macro as Robert Nelson
  suggested.

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
index 0000000..1b5b044
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -0,0 +1,577 @@
+/*
+ * support for the bosch am335x based shc c3 board
+ *
+ * Copyright, C) 2015 Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
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
+			AM33XX_IOPAD(0x9b4, PIN_INPUT | MUX_MODE6)
+		>;
+	};
+
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE0)
+		>;
+	};
+
+	cpsw_sleep: cpsw_sleep {
+		pinctrl-single,pins = <
+			/* Slave 1 reset value */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	davinci_mdio_default: davinci_mdio_default {
+		pinctrl-single,pins = <
+			/* mdio_data.mdio_data */
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)
+			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)
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
+	ehrpwm1_pins: pinmux_ehrpwm1 {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE6) /* gpmc_a3.gpio1_19 */
+		>;
+	};
+
+	emmc_pins: pinmux_emmc_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x880, PIN_INPUT | MUX_MODE2)
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)
+		>;
+	};
+
+	i2c0_pins: pinmux_i2c0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0)
+			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0)
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE5)
+		>;
+	};
+
+	mmc3_pins: pinmux_mmc3_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x830, PIN_INPUT | MUX_MODE3)
+			AM33XX_IOPAD(0x834, PIN_INPUT | MUX_MODE3)
+			AM33XX_IOPAD(0x838, PIN_INPUT | MUX_MODE3)
+			AM33XX_IOPAD(0x83c, PIN_INPUT | MUX_MODE3)
+			AM33XX_IOPAD(0x888, PIN_INPUT | MUX_MODE3)
+			AM33XX_IOPAD(0x88c, PIN_INPUT | MUX_MODE3)
+		>;
+	};
+
+	uart0_pins: pinmux_uart0_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x968, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x96c, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x974, PIN_OUTPUT | MUX_MODE0)
+		>;
+	};
+
+	uart1_pins: pinmux_uart1 {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)
+			AM33XX_IOPAD(0x984, PIN_OUTPUT | MUX_MODE0)
+		>;
+	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)
+			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)
+		>;
+	};
+
+	uart4_pins: pinmux_uart4_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE6)
+			AM33XX_IOPAD(0x874, PIN_OUTPUT_PULLUP | MUX_MODE6)
+		>;
+	};
+
+	user_leds_s0: user_leds_s0 {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x844, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x858, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x85c, PIN_OUTPUT_PULLUP | MUX_MODE7)
+			AM33XX_IOPAD(0x860, PIN_INPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x864, PIN_INPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x86c, PIN_INPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x878, PIN_OUTPUT_PULLUP | MUX_MODE7)
+			AM33XX_IOPAD(0x87c, PIN_INPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x894, PIN_INPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x958, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x95c, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_IOPAD(0x964, PIN_OUTPUT_PULLUP | MUX_MODE7)
+			AM33XX_IOPAD(0x9a0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x9a4, PIN_OUTPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x9a8, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLUP | MUX_MODE7)
+		>;
+	};
+};
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
