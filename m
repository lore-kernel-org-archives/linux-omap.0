From: Rostislav Lisovy <lisovy@gmail.com>
Subject: [PATCH 3/3] ARM: dts: am335x: Add Chiliboard DTS
Date: Mon,  9 Feb 2015 15:48:05 +0100
Message-ID: <1423493285-4231-3-git-send-email-lisovy@jablotron.cz>
References: <1423493285-4231-1-git-send-email-lisovy@jablotron.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423493285-4231-1-git-send-email-lisovy@jablotron.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rostislav Lisovy <lisovy@jablotron.cz>
List-Id: linux-omap@vger.kernel.org

Chiliboard uses ChiliSOM as its base.

Hardware specification:
* ChiliSOM (am335x, PMIC, DRAM, NAND)
* Ethernet PHY (id 0)
* USB host (usb1)
* microSD slot
* 2x GPIO LED

Signed-off-by: Rostislav Lisovy <lisovy@jablotron.cz>
---
 arch/arm/boot/dts/Makefile              |   3 +-
 arch/arm/boot/dts/am335x-chiliboard.dts | 112 ++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am335x-chiliboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..b316b38 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -401,7 +401,8 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-evmsk.dtb \
 	am335x-nano.dtb \
 	am335x-pepper.dtb \
-	am335x-lxm.dtb
+	am335x-lxm.dtb \
+	am335x-chiliboard.dtb
 dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-duovero-parlor.dtb \
 	omap4-panda.dtb \
diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/am335x-chiliboard.dts
new file mode 100644
index 0000000..2cf8ee2
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-chiliboard.dts
@@ -0,0 +1,112 @@
+/*
+ * Copyright (C) 2015 Jablotron s.r.o. -- http://www.jablotron.com/
+ * Author: Rostislav Lisovy <lisovy@jablotron.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+#include "am335x-chilisom.dtsi"
+
+/ {
+	model = "AM335x Chiliboard";
+	compatible = "grinn,am335x-chiliboard", "grinn,am335x-chilisom",
+		     "ti,am33xx";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_gpio_pins>;
+
+		led0 {
+			label = "led0";
+			gpios = <&gpio3 7 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+		};
+	};
+};
+
+&am33xx_pinmux {
+	usb1_drvvbus: usb1_drvvbus {
+		pinctrl-single,pins = <
+			0x234 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* usb1_drvvbus.usb1_drvvbus */
+		>;
+	};
+
+	sd_pins: pinmux_sd_card {
+		pinctrl-single,pins = <
+			0xf0 (PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
+			0xf4 (PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
+			0xf8 (PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
+			0xfc (PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
+			0x100 (PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
+			0x104 (PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
+			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+		>;
+	};
+
+	led_gpio_pins: led_gpio_pins {
+		pinctrl-single,pins = <
+			0x1e4 (PIN_OUTPUT | MUX_MODE7) /* emu0.gpio3_7 */
+			0x1e8 (PIN_OUTPUT | MUX_MODE7) /* emu1.gpio3_8 */
+		>;
+	};
+};
+
+&ldo4_reg {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+};
+
+/* Ethernet */
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "rmii";
+};
+
+&phy_sel {
+	rmii-clock-ext;
+};
+
+/* USB */
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_drvvbus>;
+
+	status = "okay";
+	dr_mode = "host";
+};
+
+&cppi41dma  {
+	status = "okay";
+};
+
+/* microSD */
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd_pins>;
+	vmmc-supply = <&ldo4_reg>;
+	bus-width = <0x4>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
-- 
2.1.0
