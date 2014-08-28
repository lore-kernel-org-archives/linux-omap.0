From: Stefan Roese <sr@denx.de>
Subject: [PATCH 2/4] arm: omap3: Add Technexion TAO3530 SOM omap3-tao3530.dtsi
Date: Thu, 28 Aug 2014 19:10:27 +0200
Message-ID: <1409245829-3938-2-git-send-email-sr@denx.de>
References: <1409245829-3938-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1409245829-3938-1-git-send-email-sr@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Tapani Utriainen <tapani@technexion.com>, linux-omap@vger.kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
List-Id: linux-omap@vger.kernel.org

The Technexion TAO3530 is a OMAP3530 based SOM. This patch adds the
basic support for it as an dtsi file which can be included by
baseboard equipped with this SOM. E.g. the Technexion Thunder
baseboard.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
Cc: Tapani Utriainen <tapani@technexion.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-tao3530.dtsi | 335 +++++++++++++++++++++++++++++++++++
 1 file changed, 335 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-tao3530.dtsi

diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
new file mode 100644
index 0000000..3ec32cd
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -0,0 +1,335 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014 Stefan Roese <sr@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "omap34xx-hs.dtsi"
+
+/ {
+	cpus {
+		cpu@0 {
+			cpu0-supply = <&vcc>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+
+	/* HS USB Port 2 Power */
+	hsusb2_power: hsusb2_power_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "hsusb2_vbus";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&twl_gpio 18 0>;	/* GPIO LEDA */
+		startup-delay-us = <70000>;
+	};
+
+	/* HS USB Host PHY on PORT 2 */
+	hsusb2_phy: hsusb2_phy {
+		compatible = "usb-nop-xceiv";
+		reset-gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;	/* gpio_162 */
+		vcc-supply = <&hsusb2_power>;
+	};
+
+	sound {
+		compatible = "ti,omap-twl4030";
+		ti,model = "omap3beagle";
+
+		/* McBSP2 is used for onboard sound, same as on beagle */
+		ti,mcbsp = <&mcbsp2>;
+		ti,codec = <&twl_audio>;
+	};
+
+	/* Regulator to enable/switch the vcc of the Wifi module */
+	mmc2_sdio_poweron: regulator-mmc2-sdio-poweron {
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-mmc2-sdio-poweron";
+		regulator-min-microvolt = <3150000>;
+		regulator-max-microvolt = <3150000>;
+		gpio = <&gpio5 29 GPIO_ACTIVE_LOW>;		/* gpio_157 */
+		enable-active-low;
+		startup-delay-us = <10000>;
+	};
+};
+
+&omap3_pmx_core {
+	hsusbb2_pins: pinmux_hsusbb2_pins {
+		pinctrl-single,pins = <
+			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
+			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
+			0x5c4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
+			0x5c6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
+			0x5c8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
+			0x5cA (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
+			0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
+			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
+			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
+			0x1aa (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 */
+			0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 */
+			0x1ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
+		>;
+	};
+
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
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_clk.sdmmc2_clk */
+			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_cmd.sdmmc2_cmd */
+			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat0.sdmmc2_dat0 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat2.sdmmc2_dat2 */
+			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat3.sdmmc2_dat3 */
+		>;
+	};
+
+	/* wlan GPIO output for WLAN_EN */
+	wlan_gpio: pinmux_wlan_gpio {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE4)	/* mcbsp1_fsr gpio_157 */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x16e (PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
+			0x170 (PIN_OUTPUT | MUX_MODE0) /* uart3_tx_irtx.uart3_tx_irtx */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			0x192 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
+			0x194 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
+		>;
+	};
+
+	mcspi1_pins: pinmux_mcspi1_pins {
+		pinctrl-single,pins = <
+			0x198 (PIN_INPUT | MUX_MODE0)	/* mcspi1_clk.mcspi1_clk gpio171 */
+			0x19e (PIN_OUTPUT | MUX_MODE0)	/* mcspi1_cs0.mcspi1_cs0 gpio174 */
+			0x19a (PIN_OUTPUT | MUX_MODE0)	/* mcspi1_simo.mcspi1_simo gpio172 */
+			0x19c (PIN_INPUT_PULLUP | MUX_MODE0)	/* mcspi1_somi.mcspi1_somi gpio173 */
+		>;
+	};
+
+	mcspi3_pins: pinmux_mcspi3_pins {
+		pinctrl-single,pins = <
+                        0x5ac (PIN_OUTPUT | MUX_MODE1)	/* etk_d0.mcspi3_simo gpio14 INPUT | MODE1 */
+                        0x5ae (PIN_INPUT_PULLUP | MUX_MODE1)	/* etk_d1.mcspi3_somi gpio15 INPUT | MODE1 */
+                        0x5b0 (PIN_OUTPUT | MUX_MODE1)	/* etk_d2.mcspi3_cs0 gpio16 INPUT | MODE1 */
+                        0x5b2 (PIN_INPUT | MUX_MODE1)	/* etk_d3.mcspi3_clk gpio17 INPUT | MODE1 */
+		>;
+	};
+
+	mcbsp3_pins: pinmux_mcbsp3_pins {
+		pinctrl-single,pins = <
+			0x13c (PIN_OUTPUT | MUX_MODE0)	/* mcbsp3_dx */
+			0x13e (PIN_INPUT | MUX_MODE0)	/* mcbsp3_dr */
+			0x140 (PIN_INPUT | MUX_MODE0)	/* mcbsp3_clkx */
+			0x142 (PIN_INPUT | MUX_MODE0)	/* mcbsp3_fsx */
+		>;
+	};
+};
+
+/* McBSP1: mux'ed with GPIO158 as clock for HA-DSP */
+&mcbsp1 {
+	status = "disabled";
+};
+
+&mcbsp2 {
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+
+		twl_audio: audio {
+			compatible = "ti,twl4030-audio";
+			codec {
+			};
+		};
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+};
+
+&mcspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi1_pins>;
+
+	spidev@0 {
+		compatible = "spidev";
+		spi-max-frequency = <48000000>;
+		reg = <0>;
+		spi-cpha;
+	};
+};
+
+&mcspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi3_pins>;
+
+	spidev@0 {
+		compatible = "spidev";
+		spi-max-frequency = <48000000>;
+		reg = <0>;
+		spi-cpha;
+	};
+};
+
+#include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&vmmc1>;
+	vmmc_aux-supply = <&vsim>;
+	cd-gpios = <&twl_gpio 0 0>;
+	bus-width = <8>;
+};
+
+// WiFi (Marvell 88W8686) on MMC2/SDIO
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&mmc2_sdio_poweron>;
+	non-removable;
+	bus-width = <4>;
+	cap-power-off-card;
+};
+
+&mmc3 {
+	status = "disabled";
+};
+
+&usbhshost {
+	port2-mode = "ehci-phy";
+};
+
+&usbhsehci {
+	phys = <0 &hsusb2_phy>;
+};
+
+&twl_gpio {
+	ti,use-leds;
+	/* pullups: BIT(1) */
+	ti,pullups = <0x000002>;
+	/*
+	 * pulldowns:
+	 * BIT(2), BIT(6), BIT(7), BIT(8), BIT(13)
+	 * BIT(15), BIT(16), BIT(17)
+	 */
+	ti,pulldowns = <0x03a1c4>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
+
+&mcbsp3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp3_pins>;
+};
+
+&gpmc {
+	nand@0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		nand-bus-width = <16>;
+
+		ti,nand-ecc-opt = "sw";
+		gpmc,device-nand;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <36>;
+		gpmc,cs-wr-off-ns = <36>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <24>;
+		gpmc,adv-wr-off-ns = <36>;
+		gpmc,oe-on-ns = <6>;
+		gpmc,oe-off-ns = <48>;
+		gpmc,we-on-ns = <6>;
+		gpmc,we-off-ns = <30>;
+		gpmc,rd-cycle-ns = <72>;
+		gpmc,wr-cycle-ns = <72>;
+		gpmc,access-ns = <54>;
+		gpmc,wr-access-ns = <30>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		x-loader@0 {
+			label = "X-Loader";
+			reg = <0 0x80000>;
+		};
+
+		bootloaders@80000 {
+			label = "U-Boot";
+			reg = <0x80000 0x1e0000>;
+		};
+
+		bootloaders_env@260000 {
+			label = "U-Boot Env";
+			reg = <0x260000 0x20000>;
+		};
+
+		kernel@280000 {
+			label = "Kernel";
+			reg = <0x280000 0x400000>;
+		};
+
+		filesystem@680000 {
+			label = "File System";
+			reg = <0x680000 0xf980000>;
+		};
+	};
+};
+
+&usb_otg_hs {
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
+	mode = <3>;
+	power = <50>;
+};
+
+&vaux2 {
+	regulator-name = "vdd_ehci";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-always-on;
+};
-- 
2.1.0
