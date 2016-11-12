From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Add minimal support for motorola droid 4 xt894
Date: Sat, 12 Nov 2016 08:57:59 -0800
Message-ID: <20161112165759.17316-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Marcel Partap <mpartap@gmx.net>, linux-arm-kernel@lists.infradead.org, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

Let's add minimal support for droid 4 with MMC and WLAN working.
It can be booted with appended dtb using kexec to a state where
MMC and WLAN work with currently no support for it's PMIC or
display.

Note that we are currently using fixed regulators as we don't
have support for it's cpcap PMIC. I'll be posting regmap_spi
based minimal cpcap patches later on for USB and the debug
UART on droid 4 multiplexed with the USB connector.

Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 188 +++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-droid4-xt894.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -570,6 +570,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-sl50.dtb \
 	am335x-wega-rdk.dtb
 dtb-$(CONFIG_ARCH_OMAP4) += \
+	omap4-droid4-xt894.dtb \
 	omap4-duovero-parlor.dtb \
 	omap4-kc1.dtb \
 	omap4-panda.dtb \
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
new file mode 100644
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -0,0 +1,188 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap443x.dtsi"
+
+/ {
+	model = "Motorola Droid 4 XT894";
+	compatible = "motorola,droid4", "ti,omap4430", "ti,omap4";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	/*
+	 * We seem to have only 1021 MB accessible, 1021 - 1022 is locked,
+	 * then 1023 - 1024 seems to contain mbm. For SRAM, see the notes
+	 * below about SRAM and L3_ICLK2 being unused by default,
+	 */
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x3fd00000>;	/* 1021 MB */
+	};
+
+	/* CPCAP really supports 1650000 to 3400000 range */
+	vmmc: regulator-mmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-always-on;
+	};
+
+	/* CPCAP really supports 3000000 to 3100000 range */
+	vemmc: regulator-emmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vemmc";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-always-on;
+	};
+
+	/* CPCAP really supports 1650000 to 1950000 range */
+	wl12xx_vmmc: regulator-wl12xx {
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271";
+		regulator-min-microvolt = <1650000>;
+		regulator-max-microvolt = <1650000>;
+		gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;	/* gpio94 */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+};
+
+/* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
+&gpmc {
+	status = "disabled";
+};
+
+&mmc1 {
+	vmmc-supply = <&vmmc>;
+	bus-width = <4>;
+	cd-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;	/* gpio106 */
+};
+
+&mmc2 {
+	vmmc-supply = <&vemmc>;
+	bus-width = <8>;
+	non-removable;
+};
+
+&mmc3 {
+	vmmc-supply = <&wl12xx_vmmc>;
+	interrupts-extended = <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core 0xde>;
+
+	non-removable;
+	bus-width = <4>;
+	cap-power-off-card;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1283";
+		reg = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>; /* gpio100 */
+		ref-clock-frequency = <26000000>;
+		tcxo-clock-frequency = <26000000>;
+	};
+};
+
+/* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
+&ocmcram {
+	status = "disabled";
+};
+
+&omap4_pmx_core {
+	usb_gpio_mux_sel1: pinmux_usb_gpio_mux_sel1_pins {
+		/* gpio_60 */
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x088, PIN_OUTPUT | MUX_MODE3)
+		>;
+	};
+
+	usb_ulpi_pins: pinmux_usb_ulpi_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x196, MUX_MODE7)
+		OMAP4_IOPAD(0x198, MUX_MODE7)
+		OMAP4_IOPAD(0x1b2, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1b4, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1b6, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1b8, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1ba, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1bc, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1be, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1c0, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1c2, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1c4, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1c6, PIN_INPUT_PULLUP | MUX_MODE0)
+		OMAP4_IOPAD(0x1c8, PIN_INPUT_PULLUP | MUX_MODE0)
+		>;
+	};
+
+	/* usb0_otg_dp and usb0_otg_dm */
+	usb_utmi_pins: pinmux_usb_utmi_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x196, PIN_INPUT | MUX_MODE0)
+		OMAP4_IOPAD(0x198, PIN_INPUT | MUX_MODE0)
+		OMAP4_IOPAD(0x1b2, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b4, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b6, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b8, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1ba, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1bc, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1be, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c0, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c2, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c4, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c6, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c8, PIN_INPUT_PULLUP | MUX_MODE7)
+		>;
+	};
+
+	/* uart3_tx_irtx and uart3_rx_irrx */
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x196, MUX_MODE7)
+		OMAP4_IOPAD(0x198, MUX_MODE7)
+		OMAP4_IOPAD(0x1b2, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b4, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b6, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1b8, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1ba, MUX_MODE2)
+		OMAP4_IOPAD(0x1bc, PIN_INPUT | MUX_MODE2)
+		OMAP4_IOPAD(0x1be, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c0, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c2, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c4, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c6, PIN_INPUT_PULLUP | MUX_MODE7)
+		OMAP4_IOPAD(0x1c8, PIN_INPUT_PULLUP | MUX_MODE7)
+		>;
+	};
+};
+
+&omap4_pmx_wkup {
+	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
+		/* gpio_wk0 */
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
+		>;
+	};
+};
+
+&uart3 {
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core 0x17c>;
+};
+
+/* Internal UTMI+ PHY used for OTG, CPCAP ULPI PHY for detection and charger */
+&usb_otg_hs {
+	interface-type = <1>;
+	mode = <3>;
+	power = <50>;
+};
-- 
2.10.2
