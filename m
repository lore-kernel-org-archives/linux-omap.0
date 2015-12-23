From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 5/6] ARM: LG Optimus Black (P970) codename sniper support,
 with basic features
Date: Wed, 23 Dec 2015 11:58:38 +0100
Message-ID: <1450868319-20513-6-git-send-email-contact@paulk.fr>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450868319-20513-1-git-send-email-contact@paulk.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Kocialkowski <contact@paulk.fr>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The LG Optimus Black (P970) codename sniper is a smartphone that was designed
and manufactured by LG Electronics (LGE) and released back in 2011.
It is using an OMAP3630 SoC, GP version.

This adds devicetree support for the device, with only a few basic features
supported, such as debug uart, i2c, internal emmc and external mmc.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/omap3-sniper.dts | 220 +++++++++++++++++++++++++++++++++++++
 2 files changed, 221 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-sniper.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 30bbc37..2c71106 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -447,6 +447,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += \
 	omap3-sbc-t3517.dtb \
 	omap3-sbc-t3530.dtb \
 	omap3-sbc-t3730.dtb \
+	omap3-sniper.dtb \
 	omap3-thunder.dtb \
 	omap3-zoom3.dtb
 dtb-$(CONFIG_SOC_TI81XX) += \
diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3-sniper.dts
new file mode 100644
index 0000000..6c2d99a
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-sniper.dts
@@ -0,0 +1,220 @@
+/*
+ * Copyright (C) 2015 Paul Kocialkowski <contact@paulk.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap36xx.dtsi"
+
+/ {
+	model = "LG Optimus Black (P970)";
+	compatible = "lge,omap3-sniper", "ti,omap36xx", "ti,omap3";
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
+};
+
+&omap3_pmx_core {
+	pinctrl-names = "default";
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x16e (PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx */
+			0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx */
+		>;
+	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			0x18a (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+		>;
+	};
+
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			0x18e (PIN_INPUT | MUX_MODE0)		/* i2c2_scl */
+			0x190 (PIN_INPUT | MUX_MODE0)		/* i2c2_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			0x192 (PIN_INPUT | MUX_MODE0)		/* i2c3_scl */
+			0x194 (PIN_INPUT | MUX_MODE0)		/* i2c3_sda */
+		>;
+	};
+
+	lp8720_en_pin: pinmux_lp8720_en_pin {
+		pinctrl-single,pins = <
+			0x80 (PIN_OUTPUT | MUX_MODE4)		/* gpio_37 */
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x114 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_clk */
+			0x116 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_cmd */
+			0x118 (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat0 */
+			0x11a (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat1 */
+			0x11c (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat2 */
+			0x11e (PIN_INPUT | MUX_MODE0)		/* sdmmc1_dat3 */
+		>;
+	};
+
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			0x128 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_clk */
+			0x12a (PIN_INPUT | MUX_MODE0)		/* sdmmc2_cmd */
+			0x12c (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat0 */
+			0x12e (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat1 */
+			0x130 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat2 */
+			0x132 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat3 */
+			0x134 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat4 */
+			0x136 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat5 */
+			0x138 (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat6 */
+			0x13a (PIN_INPUT | MUX_MODE0)		/* sdmmc2_dat7 */
+		>;
+	};
+};
+
+&omap3_pmx_wkup {
+	pinctrl-names = "default";
+
+	mmc1_cd_pin: pinmux_mmc1_cd_pin {
+		pinctrl-single,pins = <
+			0x1a (PIN_INPUT | MUX_MODE4)		/* gpio_10 */
+		>;
+	};
+};
+
+&gpio1 {
+	ti,no-reset-on-init;
+};
+
+&gpio2 {
+	ti,no-reset-on-init;
+};
+
+&gpio3 {
+	ti,no-reset-on-init;
+};
+
+&gpio4 {
+	ti,no-reset-on-init;
+};
+
+&gpio5 {
+	ti,no-reset-on-init;
+};
+
+&gpio6 {
+	ti,no-reset-on-init;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+
+	interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	clock-frequency = <2600000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+
+		twl_power: power {
+			compatible = "ti,twl4030-power";
+			ti,use_poweroff;
+		};
+	};
+};
+
+#include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+
+	clock-frequency = <400000>;
+
+	lp8720@7d {
+		pinctrl-names = "default";
+		pinctrl-0 = <&lp8720_en_pin>;
+
+		compatible = "ti,lp8720";
+		reg = <0x7d>;
+
+		ti,enable-gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;	/* gpio_37 */
+
+		lp8720_ldo1: ldo1 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+	};
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins &mmc1_cd_pin>;
+	vmmc-supply = <&lp8720_ldo1>;
+	cd-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;			/* gpio 10 */
+	bus-width = <4>;
+};
+
+&mmc2 {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&vmmc2>;
+	ti,non-removable;
+	bus-width = <8>;
+};
+
+&mmc3 {
+	status = "disabled";
+};
+
+/*
+ * The TWL4030 VAUX2 and VDAC regulators power sensors that are slaves on I2C3.
+ * When not powered, these sensors cause the I2C3 clock to stay low at all times,
+ * making it impossible to reach other devices on I2C3.
+ */
+
+&vaux2 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-always-on;
+};
+
+&vdac {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-always-on;
+};
-- 
1.9.1
