From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 2/5] ARM: dts: Amazon Kindle Fire (first generation) codename kc1 basic support
Date: Tue, 29 Mar 2016 21:28:24 +0200
Message-ID: <1459279707-17611-4-git-send-email-contact@paulk.fr>
References: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

The Amazon Kindle Fire (first generation) codename kc1 is a tablet that was
released by Amazon back in 2011. It is using an OMAP4430 SoC GP version.

This adds devicetree support for the device, with only a few basic features
supported, such as debug uart, i2c and internal emmc.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/Makefile      |   1 +
 arch/arm/boot/dts/omap4-kc1.dts | 140 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-kc1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 95c1923..5923334 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -503,6 +503,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-wega-rdk.dtb
 dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-duovero-parlor.dtb \
+	omap4-kc1.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
diff --git a/arch/arm/boot/dts/omap4-kc1.dts b/arch/arm/boot/dts/omap4-kc1.dts
new file mode 100644
index 0000000..9fe4441
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-kc1.dts
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2016 Paul Kocialkowski <contact@paulk.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap443x.dtsi"
+
+/ {
+	model = "Amazon Kindle Fire (first generation)";
+	compatible = "amazon,omap4-kc1", "ti,omap4430", "ti,omap4";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512 MB */
+	};
+};
+
+&omap4_pmx_core {
+	pinctrl-names = "default";
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x144, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx */
+			OMAP4_IOPAD(0x146, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx */
+		>;
+	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x122, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			OMAP4_IOPAD(0x124, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+		>;
+	};
+
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x126, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_scl */
+			OMAP4_IOPAD(0x128, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x12a, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
+			OMAP4_IOPAD(0x12c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
+		>;
+	};
+
+	i2c4_pins: pinmux_i2c4_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x12e, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
+			OMAP4_IOPAD(0x130, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
+		>;
+	};
+
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x040, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_dat0 */
+			OMAP4_IOPAD(0x042, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_dat1 */
+			OMAP4_IOPAD(0x044, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_dat2 */
+			OMAP4_IOPAD(0x046, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_dat3 */
+			OMAP4_IOPAD(0x048, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_dat4 */
+			OMAP4_IOPAD(0x04a, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_dat5 */
+			OMAP4_IOPAD(0x04c, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_dat6 */
+			OMAP4_IOPAD(0x04e, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_dat7 */
+			OMAP4_IOPAD(0x082, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_clk */
+			OMAP4_IOPAD(0x084, PIN_INPUT_PULLUP | MUX_MODE1)	/* sdmmc2_cmd */
+		>;
+	};
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART3_RX>;
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	clock-frequency = <400000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		/* IRQ# = 7 */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
+	};
+};
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
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+
+	clock-frequency = <400000>;
+};
+
+&mmc1 {
+	status = "disabled";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+
+	vmmc-supply = <&vaux1>;
+	ti,non-removable;
+	bus-width = <8>;
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
+#include "twl6030.dtsi"
+#include "twl6030_omap4.dtsi"
-- 
2.7.4
