From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [RFC PATCH] dts: Add am335x-wega-rdk.dtb sources for phyBOARD-Wega-AM335x
Date: Sat,  7 Mar 2015 15:59:53 +0300
Message-ID: <1425733193-12837-1-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, c.arlt@phytec.de, s.mueller-klieser@phytec.de, t.gamez@phytec.de, w.egorov@phytec.de, "Matwey V. Kornilov" <matwey@sai.msu.ru>
List-Id: linux-omap@vger.kernel.org

The following patch is to support Phytec phyBOARD-Wega-AM335x device.
The patch consists of the commits taken from

    git://git.phytec.de/linux-ti

and ported to upstream kernel with small modifications,
i.e. &ctrl_mod renamed to &usb_ctrl_mod.

The code has been written by the following developers:
    Christian Arlt <c.arlt@phytec.de>
    Stefan M=C3=BCller-Klieser <s.mueller-klieser@phytec.de>
    Teresa G=C3=A1mez <t.gamez@phytec.de>
    Wadim Egorov <w.egorov@phytec.de>

Tested-by: Matwey V. Kornilov <matwey@sai.msu.ru>
Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
The patch has been tested on 3.19.0 with openSUSE Factory on
phyBOARD-Wega-AM335x kit. The board successfully boots, ethernet works.

 arch/arm/boot/dts/Makefile                     |   3 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi      | 275 +++++++++++++++++=
++++++++
 arch/arm/boot/dts/am335x-phytec-lcd-018.dtsi   | 109 ++++++++++
 arch/arm/boot/dts/am335x-wega-peb-av-01.dtsi   |  71 +++++++
 arch/arm/boot/dts/am335x-wega-peb-av-02.dtsi   |  44 ++++
 arch/arm/boot/dts/am335x-wega-peb-eval-01.dtsi |  54 +++++
 arch/arm/boot/dts/am335x-wega-rdk.dts          | 136 ++++++++++++
 arch/arm/boot/dts/am335x-wega.dtsi             | 209 +++++++++++++++++=
++
 8 files changed, 900 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am335x-phycore-som.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-phytec-lcd-018.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-wega-peb-av-01.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-wega-peb-av-02.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-wega-peb-eval-01.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-wega-rdk.dts
 create mode 100644 arch/arm/boot/dts/am335x-wega.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..aa05ae4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -401,7 +401,8 @@ dtb-$(CONFIG_SOC_AM33XX) +=3D \
 	am335x-evmsk.dtb \
 	am335x-nano.dtb \
 	am335x-pepper.dtb \
-	am335x-lxm.dtb
+	am335x-lxm.dtb \
+	am335x-wega-rdk.dts
 dtb-$(CONFIG_ARCH_OMAP4) +=3D \
 	omap4-duovero-parlor.dtb \
 	omap4-panda.dtb \
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/=
dts/am335x-phycore-som.dtsi
new file mode 100644
index 0000000..aa7826d
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -0,0 +1,275 @@
+/*
+ * Copyright (C) 2014 Teresa G=C3=A1mez <t.gamez@phytec.de> Phytec Mes=
stechnik GmbH
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "am33xx.dtsi"
+
+/ {
+	model =3D "Phytec AM335x phyCORE";
+	compatible =3D "phytec,am335x-phycore-som", "ti,am33xx";
+
+	aliases {
+		rtc0 =3D &i2c_rtc;
+		rtc1 =3D &rtc;
+	};
+
+	cpus {
+		cpu@0 {
+			cpu0-supply =3D <&vdd1_reg>;
+		};
+	};
+
+	/* This is a dummy node. Will be set by a bootloader */
+	memory {
+		device_type =3D "memory";
+		reg =3D <0x80000000 0x20000000>; /* 512 MB */
+	};
+
+	vcc5v: fixedregulator@0 {
+		compatible =3D "regulator-fixed";
+	};
+};
+
+/* Crypto Module */
+&aes {
+	status =3D "okay";
+};
+
+&sham {
+	status =3D "okay";
+};
+
+/* Ethernet */
+&am33xx_pinmux {
+	ethernet0_pins: pinmux_ethernet0 {
+		pinctrl-single,pins =3D <
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			0x114 (PIN_OUTPUT | MUX_MODE1)		/* mii1_txen.rmii1_txen */
+			0x124 (PIN_OUTPUT | MUX_MODE1)		/* mii1_txd1.rmii1_txd1 */
+			0x128 (PIN_OUTPUT | MUX_MODE1)		/* mii1_txd0.rmii1_txd0 */
+			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_refclk.rmii1_refclk=
 */
+		>;
+	};
+
+	mdio_pins: pinmux_mdio {
+		pinctrl-single,pins =3D <
+			/* MDIO */
+			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.m=
dio_data */
+			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+		>;
+	};
+};
+
+&cpsw_emac0 {
+	phy_id =3D <&davinci_mdio>, <0>;
+	phy-mode =3D "rmii";
+	dual_emac_res_vlan =3D <1>;
+	status =3D "disabled";
+};
+
+&cpsw_emac1 {
+	status =3D "disabled";
+};
+
+&davinci_mdio {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&mdio_pins>;
+	status =3D "disabled";
+};
+
+&mac {
+	slaves =3D <1>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&ethernet0_pins>;
+};
+
+&phy_sel {
+	rmii-clock-ext;
+};
+
+/* I2C Busses */
+&am33xx_pinmux {
+	i2c0_pins: pinmux_i2c0 {
+		pinctrl-single,pins =3D <
+			0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+		>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&i2c0_pins>;
+	clock-frequency =3D <400000>;
+	status =3D "okay";
+
+	tps: pmic@2d {
+		reg =3D <0x2d>;
+	};
+
+	i2c_eeprom: eeprom@52 {
+		compatible =3D "at,24c32";
+		pagesize =3D <32>;
+		reg =3D <0x52>;
+		status =3D "disabled";
+	};
+
+	i2c_rtc: rtc@68 {
+		compatible =3D "mc,rv4162c7";
+		reg =3D <0x68>;
+		status =3D "disabled";
+	};
+};
+
+/* NAND memory */
+&am33xx_pinmux {
+		nandflash_pins: pinmux_nandflash {
+			pinctrl-single,pins =3D <
+			0x0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			0x4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			0x8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			0xc (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			0x10 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			0x14 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			0x18 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			0x1c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
+			0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+		>;
+	};
+};
+
+&elm {
+	status =3D "okay";
+};
+
+&gpmc {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&nandflash_pins>;
+	ranges =3D <0 0 0x08000000 0x10000000>;   /* CS0: NAND */
+	nandflash: nand@0,0 {
+		reg =3D <0 0 0>; /* CS0, offset 0 */
+		nand-bus-width =3D <8>;
+		ti,nand-ecc-opt =3D "bch8";
+		gpmc,device-nand =3D "true";
+		gpmc,device-width =3D <1>;
+		gpmc,sync-clk-ps =3D <0>;
+		gpmc,cs-on-ns =3D <0>;
+		gpmc,cs-rd-off-ns =3D <30>;
+		gpmc,cs-wr-off-ns =3D <30>;
+		gpmc,adv-on-ns =3D <0>;
+		gpmc,adv-rd-off-ns =3D <30>;
+		gpmc,adv-wr-off-ns =3D <30>;
+		gpmc,we-on-ns =3D <0>;
+		gpmc,we-off-ns =3D <20>;
+		gpmc,oe-on-ns =3D <10>;
+		gpmc,oe-off-ns =3D <30>;
+		gpmc,access-ns =3D <30>;
+		gpmc,rd-cycle-ns =3D <30>;
+		gpmc,wr-cycle-ns =3D <30>;
+		gpmc,wait-on-read =3D "true";
+		gpmc,wait-on-write =3D "true";
+		gpmc,bus-turnaround-ns =3D <0>;
+		gpmc,cycle2cycle-delay-ns =3D <50>;
+		gpmc,cycle2cycle-diffcsen;
+		gpmc,clk-activation-ns =3D <0>;
+		gpmc,wait-monitoring-ns =3D <0>;
+		gpmc,wr-access-ns =3D <30>;
+		gpmc,wr-data-mux-bus-ns =3D <0>;
+
+		elm_id =3D <&elm>;
+
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+	};
+};
+
+/* Power */
+#include "tps65910.dtsi"
+
+&tps {
+	vcc1-supply =3D <&vcc5v>;
+	vcc2-supply =3D <&vcc5v>;
+	vcc3-supply =3D <&vcc5v>;
+	vcc4-supply =3D <&vcc5v>;
+	vcc5-supply =3D <&vcc5v>;
+	vcc6-supply =3D <&vcc5v>;
+	vcc7-supply =3D <&vcc5v>;
+	vccio-supply =3D <&vcc5v>;
+
+	regulators {
+		vdd1_reg: regulator@2 {
+			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
+			regulator-name =3D "vdd_mpu";
+			regulator-min-microvolt =3D <912500>;
+			regulator-max-microvolt =3D <1312500>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd2_reg: regulator@3 {
+			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
+			regulator-name =3D "vdd_core";
+			regulator-min-microvolt =3D <912500>;
+			regulator-max-microvolt =3D <1150000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdig1_reg: regulator@5 {
+			regulator-name =3D "vdig1_1p8v";
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <1800000>;
+		};
+
+		vmmc_reg: regulator@12 {
+			regulator-min-microvolt =3D <1800000>;
+			regulator-max-microvolt =3D <3300000>;
+		};
+	};
+};
+
+&vcc5v {
+	regulator-name =3D "vcc5v";
+	regulator-min-microvolt =3D <5000000>;
+	regulator-max-microvolt =3D <5000000>;
+	regulator-boot-on;
+};
+
+/* SPI Busses */
+&am33xx_pinmux {
+	spi0_pins: pinmux_spi0 {
+		pinctrl-single,pins =3D <
+			0x150 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* spi0_clk.spi0_clk */
+			0x154 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* spi0_d0.spi0_d0 */
+			0x158 (PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_d1.spi0_d1 */
+			0x15c (PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_cs0.spi0_cs0 */
+		>;
+	};
+};
+
+&spi0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&spi0_pins>;
+	status =3D "okay";
+
+	serial_flash: m25p80@0 {
+		compatible =3D "m25p80";
+		spi-max-frequency =3D <48000000>;
+		reg =3D <0x0>;
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-phytec-lcd-018.dtsi b/arch/arm/bo=
ot/dts/am335x-phytec-lcd-018.dtsi
new file mode 100644
index 0000000..daa9b2e
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-phytec-lcd-018.dtsi
@@ -0,0 +1,109 @@
+/*
+ * Copyright (C) 2014 Wadim Egorov <w.egorov@phytec.de> PHYTEC Messtec=
hnik GmbH
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * The board specific DTS file have to:
+ *  - Specify pwms and enable gpios for backlight
+ *  - Mux the display enable pins if available
+ *  - Create the i2c_ts node on the specific i2c bus
+*/
+
+&am33xx_pinmux {
+	lcd_pins: pinmux_lcd {
+		pinctrl-single,pins =3D <
+			0xA0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
+			0xA4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
+			0xA8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
+			0xAC (PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
+			0xB0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
+			0xB4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
+			0xB8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
+			0xBC (PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
+			0xC0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
+			0xC4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
+			0xC8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
+			0xCC (PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
+			0xD0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
+			0xD4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
+			0xD8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
+			0xDC (PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
+			0x3C (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data16 */
+			0x38 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data17 */
+			0x34 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data18 */
+			0x30 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data19 */
+			0x2C (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data20 */
+			0x28 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data21 */
+			0x24 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data22 */
+			0x20 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data23 */
+			0xE0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
+			0xE4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
+			0xE8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
+			0xEC (PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+		>;
+	};
+};
+
+/ {
+	backlight: backlight {
+		compatible =3D "pwm-backlight";
+		brightness-levels =3D <0 4 8 16 32 64 128 255>;
+		default-brightness-level =3D <6>;
+		power-supply =3D <&lcd_3v3>;
+		status =3D "disabled";
+	};
+
+	lcd_3v3: fixedregulator-lcd {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "lcd_3v3";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		regulator-boot-on;
+	};
+
+	panel: panel {
+		compatible =3D "ti,tilcdc,panel";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&lcd_pins>;
+		status =3D "disabled";
+
+		panel-info {
+			ac-bias =3D <255>;
+			ac-bias-intrpt =3D <0>;
+			dma-burst-sz =3D <16>;
+			bpp =3D <32>;
+			fdd =3D <0x80>;
+			sync-edge =3D <0>;
+			sync-ctrl =3D <1>;
+			raster-order =3D <0>;
+			fifo-th =3D <0>;
+			invert-pxl-clk =3D <1>;
+		};
+
+		display-timings {
+			native-mode =3D <&timing0>;
+			timing0: ETM0700G0DH6 {
+				clock-frequency	=3D <40000000>;
+				hactive =3D <800>;
+				vactive =3D <480>;
+				hfront-porch =3D <40>;
+				hback-porch =3D <216>;
+				hsync-len =3D <128>;
+				vback-porch =3D <35>;
+				vfront-porch =3D <10>;
+				vsync-len =3D <2>;
+				hsync-active =3D <1>;
+				vsync-active =3D <1>;
+			};
+		};
+	};
+};
+
+&i2c_ts {
+	compatible =3D "edt,edt-ft5x06";
+	reg =3D <0x38>;
+};
diff --git a/arch/arm/boot/dts/am335x-wega-peb-av-01.dtsi b/arch/arm/bo=
ot/dts/am335x-wega-peb-av-01.dtsi
new file mode 100644
index 0000000..503ecb3
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-wega-peb-av-01.dtsi
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) 2014 Christian Arlt <c.arlt@phytec.de> Phytec Messtec=
hnik GmbH
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	hdmi: hdmi {
+		compatible =3D "ti,tilcdc,slave";
+		i2c =3D <&i2c0>;
+
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&hdmi_pins>;
+		status =3D "disabled";
+
+		panel-info {
+			/* required */
+			ac-bias =3D <255>;
+			ac-bias-intrpt =3D <0>;
+			dma-burst-sz =3D <16>;
+			bpp =3D <32>;
+			fdd =3D <16>;
+			sync-edge =3D <1>;	/* stabilizes picture	*/
+			sync-ctrl =3D <1>;
+			raster-order =3D <0>;
+			fifo-th =3D <0>;
+
+			/* optional */
+			invert-pxl-clk =3D <1>;
+			tft-alt-mode =3D <0>;
+		};
+	};
+};
+
+&am33xx_pinmux {
+	hdmi_pins: pinmux_hdmi {
+		pinctrl-single,pins =3D <
+			0xA0 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data0.lcd_data0 */
+			0xA4 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data1.lcd_data1 */
+			0xA8 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data2.lcd_data2 */
+			0xAC (PIN_OUTPUT | MUX_MODE0)   /* lcd_data3.lcd_data3 */
+			0xB0 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data4.lcd_data4 */
+			0xB4 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data5.lcd_data5 */
+			0xB8 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data6.lcd_data6 */
+			0xBC (PIN_OUTPUT | MUX_MODE0)   /* lcd_data7.lcd_data7 */
+			0xC0 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data8.lcd_data8 */
+			0xC4 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data9.lcd_data9 */
+			0xC8 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data10.lcd_data10 */
+			0xCC (PIN_OUTPUT | MUX_MODE0)   /* lcd_data11.lcd_data11 */
+			0xD0 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data12.lcd_data12 */
+			0xD4 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data13.lcd_data13 */
+			0xD8 (PIN_OUTPUT | MUX_MODE0)   /* lcd_data14.lcd_data14 */
+			0xDC (PIN_OUTPUT | MUX_MODE0)   /* lcd_data15.lcd_data15 */
+			0x3C (PIN_OUTPUT | MUX_MODE1)   /* gpmc_ad15.lcd_data16 */
+			0x38 (PIN_OUTPUT | MUX_MODE1)   /* gpmc_ad14.lcd_data17 */
+			0x34 (PIN_OUTPUT | MUX_MODE1)   /* gpmc_ad13.lcd_data18 */
+			0x30 (PIN_OUTPUT | MUX_MODE1)   /* gpmc_ad12.lcd_data19 */
+			0x2C (PIN_OUTPUT | MUX_MODE1)   /* gpmc_ad11.lcd_data20 */
+			0x28 (PIN_OUTPUT | MUX_MODE1)   /* gpmc_ad10.lcd_data21 */
+			0x24 (PIN_OUTPUT | MUX_MODE1)   /* gpmc_ad9.lcd_data22 */
+			0x20 (PIN_OUTPUT | MUX_MODE1)   /* gpmc_ad8.lcd_data23 */
+			0xE0 (PIN_OUTPUT | MUX_MODE0)   /* lcd_vsync.lcd_vsync */
+			0xE4 (PIN_OUTPUT | MUX_MODE0)   /* lcd_hsync.lcd_hsync */
+			0xE8 (PIN_OUTPUT | MUX_MODE0)   /* lcd_pclk.lcd_pclk */
+			0xEC (PIN_OUTPUT | MUX_MODE0)   /* lcd_ac_bias_en.lcd_ac_bias_en */
+			0x80 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_csn1.x_av_int_gpio1_30	*/
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-wega-peb-av-02.dtsi b/arch/arm/bo=
ot/dts/am335x-wega-peb-av-02.dtsi
new file mode 100644
index 0000000..fd76760
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-wega-peb-av-02.dtsi
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2014 Christian Arlt <c.arlt@phytec.de> Phytec Messtec=
hnik GmbH
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&am33xx_pinmux {
+	ecap2_pins: backlight_pins {
+		pinctrl-single,pins =3D <
+			0x19c (PIN_OUTPUT | MUX_MODE4)		/* mcasp0_ahclkr.ecap2_in_pwm2_out	=
*/
+		>;
+	};
+
+	ts_irq_pin: pinmux_ts_irq {
+		pinctrl-single,pins =3D <
+			0x80 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_csn1.x_av_int_gpio1_30	=
*/
+		>;
+	};
+};
+
+&i2c0 {
+	i2c_ts: touchscreen@38 {
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&ts_irq_pin>;
+		interrupt-parent =3D <&gpio1>;
+		interrupts =3D <30 0>;
+		status =3D "disabled";
+	};
+};
+
+&ecap2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&ecap2_pins>;
+	status =3D "disabled";
+};
+
+#include "am335x-phytec-lcd-018.dtsi"
+
+&backlight {
+	pwms =3D <&ecap2 0 100000 0>;
+	enable-gpios =3D <&gpio3 19 0>;
+};
diff --git a/arch/arm/boot/dts/am335x-wega-peb-eval-01.dtsi b/arch/arm/=
boot/dts/am335x-wega-peb-eval-01.dtsi
new file mode 100644
index 0000000..ecf3a78
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-wega-peb-eval-01.dtsi
@@ -0,0 +1,54 @@
+/* Copyright (C) 2014 Christian Arlt <c.arlt@phytec.de> Phytec Messtec=
hnik GmbH
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&am33xx_pinmux {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&user_buttons_pins>;
+
+	user_buttons_pins: pinmux_user_buttons {
+		pinctrl-single,pins =3D <
+			0x164 (PIN_INPUT | MUX_MODE7)	/* ecap0_in_pwm0_out.gpio0_7	*/
+			0x1B4 (PIN_INPUT | MUX_MODE7)	/* xdma_event_intr1.gpio0_20	*/
+			0x130 (PIN_INPUT | MUX_MODE7)	/* mii1_rx_clk.gpio3_10		*/
+		>;
+	};
+
+	user_leds_pins: pinmux_user_leds {
+		pinctrl-single,pins =3D <
+			0x134 (PIN_OUTPUT | MUX_MODE7)	/* mii1_rxd3.gpio2_18	*/
+			0x138 (PIN_OUTPUT | MUX_MODE7)	/* mii1_rxd2.gpio2_19	*/
+			0x12C (PIN_OUTPUT | MUX_MODE7)	/* mii1_tx_clk.gpio3_9	*/
+		>;
+	};
+};
+
+/ {
+	user_leds: user_leds {
+		compatible =3D "gpio-leds";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&user_leds_pins>;
+		status =3D "disabled";
+
+		user_led_green {
+			gpios =3D <&gpio3 9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger =3D "gpio";
+			default-state =3D "on";
+		};
+
+		user_led_yellow {
+			gpios =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger =3D "gpio";
+			default-state =3D "on";
+		};
+
+		user_led_red {
+			gpios =3D <&gpio2 18 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger =3D "gpio";
+			default-state =3D "on";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-wega-rdk.dts b/arch/arm/boot/dts/=
am335x-wega-rdk.dts
new file mode 100644
index 0000000..35481e3
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-wega-rdk.dts
@@ -0,0 +1,136 @@
+/*
+ * Copyright (C) 2014 Teresa G=C3=A1mez <t.gamez@phytec.de> Phytec Mes=
stechnik GmbH
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "am335x-phycore-som.dtsi"
+#include "am335x-wega.dtsi"
+#include "am335x-wega-peb-eval-01.dtsi"
+#include "am335x-wega-peb-av-01.dtsi"
+#include "am335x-wega-peb-av-02.dtsi"
+
+/* SoM */
+&cpsw_emac0 {
+	status =3D "okay";
+};
+
+&cpsw_emac1 {
+	status =3D "okay";
+};
+
+&mac {
+	status =3D "okay";
+};
+
+&davinci_mdio {
+	status =3D "okay";
+};
+
+&i2c_eeprom {
+	status =3D "okay";
+};
+
+&i2c_rtc {
+	status =3D "okay";
+};
+
+&nandflash {
+	partition@0 {
+		label =3D "xload";
+		reg =3D <0x0 0x20000>;
+	};
+
+	partition@1 {
+		label =3D "xload_backup1";
+		reg =3D <0x20000 0x20000>;
+	};
+
+	partition@2 {
+		label =3D "xload_backup2";
+		reg =3D <0x40000 0x20000>;
+	};
+
+	partition@3 {
+		label =3D "xload_backup3";
+		reg =3D <0x60000 0x20000>;
+	};
+
+	partition@4 {
+		label =3D "barebox";
+		reg =3D <0x80000 0x80000>;
+	};
+
+	partition@5 {
+		label =3D "bareboxenv";
+		reg =3D <0x100000 0x40000>;
+	};
+
+	partition@6 {
+		label =3D "oftree";
+		reg =3D <0x140000 0x40000>;
+	};
+
+	partition@7 {
+		label =3D "kernel";
+		reg =3D <0x180000 0x800000>;
+	};
+
+	partition@8 {
+		label =3D "root";
+		/*
+		 * setting size to 0x0 here, size will be extended to
+		 * end of nand flash while booting.
+		 */
+		reg =3D <0x980000 0x0>;
+	};
+};
+
+/* Carrierboard */
+&cppi41dma {
+	status =3D "okay";
+};
+
+&cpsw_emac1 {
+	status =3D "okay";
+};
+
+&usb_ctrl_mod {
+	status =3D "okay";
+};
+
+&dcan1 {
+	status =3D "okay";
+};
+
+&mmc1 {
+	status =3D "okay";
+};
+
+&uart0 {
+	status =3D "okay";
+};
+
+&uart1 {
+	status =3D "okay";
+};
+
+&usb {
+	status =3D "okay";
+};
+
+&usb0 {
+	status =3D "okay";
+};
+
+&usb0_phy {
+	status =3D "okay";
+};
+
+&usb1 {
+	status =3D "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am3=
35x-wega.dtsi
new file mode 100644
index 0000000..ef55ba4
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -0,0 +1,209 @@
+/*
+ * Copyright (C) 2014 Teresa G=C3=A1mez <t.gamez@phytec.de> Phytec Mes=
stechnik GmbH
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	model =3D "Phytec AM335x phyBOARD-WEGA";
+	compatible =3D "phytec,am335x-wega", "phytec,am335x-phycore-som", "ti=
,am33xx";
+
+	sound: sound_iface {
+		compatible =3D "ti,da830-evm-audio";
+	};
+
+	vcc3v3: fixedregulator@1 {
+		compatible =3D "regulator-fixed";
+	};
+};
+
+/* Audio */
+&am33xx_pinmux {
+	mcasp0_pins: pinmux_mcasp0 {
+		pinctrl-single,pins =3D <
+			0x190 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp0_aclkx.mcasp0_aclkx=
 */
+			0x194 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx */
+			0x198 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp0_axr0.mcasp0_axr0 *=
/
+			0x1A8 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_axr1.mcasp0_axr1 =
*/
+			0x1AC (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_ahclkx.mcasp0_ahc=
lkx */
+		>;
+	};
+};
+
+&i2c0 {
+	tlv320aic3007: audio_codec@18 {
+		compatible =3D "ti,tlv320aic3007";
+		reg =3D <0x18>;
+		AVDD-supply =3D <&vcc3v3>;
+		IOVDD-supply =3D <&vcc3v3>;
+		DRVDD-supply =3D <&vcc3v3>;
+		DVDD-supply =3D <&vdig1_reg>;
+	};
+};
+
+&mcasp0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&mcasp0_pins>;
+	op-mode =3D <0>;
+	tdm-slots =3D <2>;
+	serial-dir =3D <
+		2 1 0 0 /* # 0: INACTIVE, 1: TX, 2: RX */
+	>;
+	tx-num-evt =3D <16>;
+	rt-num-evt =3D <16>;
+	status =3D "okay";
+};
+
+&sound {
+	ti,model =3D "OnboardTLV320AIC3007";
+	ti,audio-codec =3D <&tlv320aic3007>;
+	ti,mcasp-controller =3D <&mcasp0>;
+	ti,codec-clock-rate =3D <25000000>;
+	ti,audio-routing =3D
+		"Line Out",		"LLOUT",
+		"Line Out",		"RLOUT",
+		"Speaker",		"SPOP",
+		"Speaker",		"SPOM",
+		"LINE1L",		"Line In",
+		"LINE1R",		"Line In";
+	status =3D "okay";
+};
+
+&vdig1_reg {
+		regulator-boot-on;
+		regulator-always-on;
+};
+
+/* CAN Busses */
+&am33xx_pinmux {
+	dcan1_pins: pinmux_dcan1 {
+		pinctrl-single,pins =3D <
+			0x168 (PIN_OUTPUT_PULLUP | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
+			0x16c (PIN_INPUT_PULLUP | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+		>;
+	};
+};
+
+&dcan1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&dcan1_pins>;
+};
+
+/* Ethernet */
+&am33xx_pinmux {
+	ethernet1_pins: pinmux_ethernet1 {
+		pinctrl-single,pins =3D <
+			0x40 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a0.mii2_txen */
+			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a1.mii2_rxdv */
+			0x48 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a2.mii2_txd3 */
+			0x4c (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a3.mii2_txd2 */
+			0x50 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a4.mii2_txd1 */
+			0x54 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_a5.mii2_txd0 */
+			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a6.mii2_txclk */
+			0x5c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a7.mii2_rxclk */
+			0x60 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a8.mii2_rxd3 */
+			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a9.mii2_rxd2 */
+			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a10.mii2_rxd1 */
+			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a11.mii2_rxd0 */
+			0x74 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_wpn.mii2_rxerr */
+			0x78 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ben1.mii2_col */
+		>;
+	};
+};
+
+&cpsw_emac1 {
+	phy_id =3D <&davinci_mdio>, <1>;
+	phy-mode =3D "mii";
+	dual_emac_res_vlan =3D <2>;
+	status =3D "disabled";
+};
+
+&mac {
+	slaves =3D <2>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&ethernet0_pins &ethernet1_pins>;
+	dual_emac =3D <1>;
+};
+
+/* MMC */
+&am33xx_pinmux {
+	mmc1_pins: pinmux_mmc1 {
+		pinctrl-single,pins =3D <
+			0x0F0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			0x0F4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			0x0F8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			0x0FC (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			0x160 (PIN_INPUT_PULLUP | MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
+		>;
+	};
+};
+
+&mmc1 {
+	vmmc-supply =3D <&vcc3v3>;
+	bus-width =3D <4>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&mmc1_pins>;
+	cd-gpios =3D <&gpio0 6 GPIO_ACTIVE_HIGH>;
+};
+
+/* Power */
+&vcc3v3 {
+	regulator-name =3D "vcc3v3";
+	regulator-min-microvolt =3D <3300000>;
+	regulator-max-microvolt =3D <3300000>;
+	regulator-boot-on;
+};
+
+/* UARTs */
+&am33xx_pinmux {
+	uart0_pins: pinmux_uart0 {
+		pinctrl-single,pins =3D <
+			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_rxd.uart0_rxd */
+			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart0_txd.uart0_txd */
+		>;
+	};
+
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins =3D <
+			0x180 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			0x184 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			0x178 (PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
+			0x17c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart1_rtsn.uart1_rtsn *=
/
+		>;
+	};
+};
+
+&uart0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart0_pins>;
+};
+
+&uart1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart1_pins>;
+};
+
+/* USB */
+&am33xx_pinmux {
+	usb_pins: pinmux_usb {
+		pinctrl-single,pins =3D <
+			0x21c (PIN_OUTPUT | MUX_MODE0)		/* usb0_drvvbus.usb0_drvvbus */
+			0x234 (PIN_OUTPUT | MUX_MODE0)		/* usb1_drvvbus.usb1_drvvbus */
+		>;
+	};
+};
+
+&usb {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&usb_pins>;
+};
+
+/* usb0 is in otg mode */
+
+&usb1 {
+	dr_mode =3D "host";
+};
--=20
2.1.4
