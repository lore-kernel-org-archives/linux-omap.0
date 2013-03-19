From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 5/8] ARM: dts: omap4-panda: move generic sections to panda-common
Date: Tue, 19 Mar 2013 12:53:07 -0500
Message-ID: <1363715590-5131-6-git-send-email-nm@ti.com>
References: <1363715590-5131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45155 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933347Ab3CSRxk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 13:53:40 -0400
In-Reply-To: <1363715590-5131-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jon Hunter <jon-hunter@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

PandaBoard, PandaBoard-A4 revisions use OMAP4430.
PandaBoard-ES version of the board uses OMAP4460.

Move the original panda dts file into a common dtsi used by all panda
variants. This allows us to introduce SoC variation for PandaBoard ES
without impacting other PandaBoard versions that are supported.
As part of this change, since OMAP4460 adds on to OMAP4430, add
omap4.dtsi to omap4460.dtsi.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes in V2:
	- use omap443x.dtsi and 4460.dtsi
	- little more verbose commit log
V1: https://patchwork.kernel.org/patch/2273671/

 arch/arm/boot/dts/omap4-panda-a4.dts      |    5 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi |  251 +++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/omap4-panda-es.dts      |    3 +-
 arch/arm/boot/dts/omap4-panda.dts         |  245 +--------------------=
-------
 arch/arm/boot/dts/omap4460.dtsi           |    1 +
 5 files changed, 259 insertions(+), 246 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-panda-common.dtsi

diff --git a/arch/arm/boot/dts/omap4-panda-a4.dts b/arch/arm/boot/dts/o=
map4-panda-a4.dts
index 75466d2..e30cdf0 100644
--- a/arch/arm/boot/dts/omap4-panda-a4.dts
+++ b/arch/arm/boot/dts/omap4-panda-a4.dts
@@ -5,7 +5,10 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-/include/ "omap4-panda.dts"
+/dts-v1/;
+
+/include/ "omap443x.dtsi"
+/include/ "omap4-panda-common.dtsi"
=20
 /* Pandaboard Rev A4+ have external pullups on SCL & SDA */
 &dss_hdmi_pins {
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/=
dts/omap4-panda-common.dtsi
new file mode 100644
index 0000000..03bd60d
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -0,0 +1,251 @@
+/*
+ * Copyright (C) 2011-2013 Texas Instruments Incorporated - http://www=
=2Eti.com/
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/include/ "elpida_ecb240abacn.dtsi"
+
+/ {
+	model =3D "TI OMAP4 PandaBoard";
+	compatible =3D "ti,omap4-panda", "ti,omap4430", "ti,omap4";
+
+	memory {
+		device_type =3D "memory";
+		reg =3D <0x80000000 0x40000000>; /* 1 GB */
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+		heartbeat {
+			label =3D "pandaboard::status1";
+			gpios =3D <&gpio1 7 0>;
+			linux,default-trigger =3D "heartbeat";
+		};
+
+		mmc {
+			label =3D "pandaboard::status2";
+			gpios =3D <&gpio1 8 0>;
+			linux,default-trigger =3D "mmc0";
+		};
+	};
+
+	sound: sound {
+		compatible =3D "ti,abe-twl6040";
+		ti,model =3D "PandaBoard";
+
+		ti,mclk-freq =3D <38400000>;
+
+		ti,mcpdm =3D <&mcpdm>;
+
+		ti,twl6040 =3D <&twl6040>;
+
+		/* Audio routing */
+		ti,audio-routing =3D
+			"Headset Stereophone", "HSOL",
+			"Headset Stereophone", "HSOR",
+			"Ext Spk", "HFL",
+			"Ext Spk", "HFR",
+			"Line Out", "AUXL",
+			"Line Out", "AUXR",
+			"HSMIC", "Headset Mic",
+			"Headset Mic", "Headset Mic Bias",
+			"AFML", "Line In",
+			"AFMR", "Line In";
+	};
+};
+
+&omap4_pmx_core {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <
+			&twl6040_pins
+			&mcpdm_pins
+			&mcbsp1_pins
+			&dss_hdmi_pins
+			&tpd12s015_pins
+	>;
+
+	twl6040_pins: pinmux_twl6040_pins {
+		pinctrl-single,pins =3D <
+			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
+			0x160 0x100	/* sys_nirq2.sys_nirq2 INPUT | MODE0 */
+		>;
+	};
+
+	mcpdm_pins: pinmux_mcpdm_pins {
+		pinctrl-single,pins =3D <
+			0xc6 0x108	/* abe_pdm_ul_data.abe_pdm_ul_data INPUT PULLDOWN | MODE=
0 */
+			0xc8 0x108	/* abe_pdm_dl_data.abe_pdm_dl_data INPUT PULLDOWN | MODE=
0 */
+			0xca 0x118	/* abe_pdm_frame.abe_pdm_frame INPUT PULLUP | MODE0 */
+			0xcc 0x108	/* abe_pdm_lb_clk.abe_pdm_lb_clk INPUT PULLDOWN | MODE0 =
*/
+			0xce 0x108	/* abe_clks.abe_clks INPUT PULLDOWN | MODE0 */
+		>;
+	};
+
+	mcbsp1_pins: pinmux_mcbsp1_pins {
+		pinctrl-single,pins =3D <
+			0xbe 0x100	/* abe_mcbsp1_clkx.abe_mcbsp1_clkx INPUT | MODE0 */
+			0xc0 0x108	/* abe_mcbsp1_dr.abe_mcbsp1_dr INPUT PULLDOWN | MODE0 */
+			0xc2 0x8		/* abe_mcbsp1_dx.abe_mcbsp1_dx OUTPUT PULLDOWN | MODE0 */
+			0xc4 0x100	/* abe_mcbsp1_fsx.abe_mcbsp1_fsx INPUT | MODE0 */
+		>;
+	};
+
+	dss_hdmi_pins: pinmux_dss_hdmi_pins {
+		pinctrl-single,pins =3D <
+			0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
+			0x5c 0x118	/* hdmi_scl.hdmi_scl INPUT PULLUP | MODE 0 */
+			0x5e 0x118	/* hdmi_sda.hdmi_sda INPUT PULLUP | MODE 0 */
+		>;
+	};
+
+	tpd12s015_pins: pinmux_tpd12s015_pins {
+		pinctrl-single,pins =3D <
+			0x22 0x3	/* gpmc_a17.gpio_41 OUTPUT | MODE3 */
+			0x48 0x3	/* gpmc_nbe1.gpio_60 OUTPUT | MODE3 */
+			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
+		>;
+	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins =3D <
+			0xe2 0x118        /* i2c1_scl PULLUP | INPUTENABLE | MODE0 */
+			0xe4 0x118        /* i2c1_sda PULLUP | INPUTENABLE | MODE0 */
+		>;
+	};
+
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins =3D <
+			0xe6 0x118        /* i2c2_scl PULLUP | INPUTENABLE | MODE0 */
+			0xe8 0x118        /* i2c2_sda PULLUP | INPUTENABLE | MODE0 */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins =3D <
+			0xea 0x118        /* i2c3_scl PULLUP | INPUTENABLE | MODE0 */
+			0xec 0x118     /* i2c3_sda PULLUP | INPUTENABLE | MODE0 */
+		>;
+	};
+
+	i2c4_pins: pinmux_i2c4_pins {
+		pinctrl-single,pins =3D <
+			0xee 0x118        /* i2c4_scl PULLUP | INPUTENABLE | MODE0 */
+			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
+		>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&i2c1_pins>;
+
+	clock-frequency =3D <400000>;
+
+	twl: twl@48 {
+		reg =3D <0x48>;
+		/* SPI =3D 0, IRQ# =3D 7, 4 =3D active high level-sensitive */
+		interrupts =3D <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
+		interrupt-parent =3D <&gic>;
+	};
+
+	twl6040: twl@4b {
+		compatible =3D "ti,twl6040";
+		reg =3D <0x4b>;
+		/* SPI =3D 0, IRQ# =3D 119, 4 =3D active high level-sensitive */
+		interrupts =3D <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
+		interrupt-parent =3D <&gic>;
+		ti,audpwron-gpio =3D <&gpio4 31 0>;  /* gpio line 127 */
+
+		vio-supply =3D <&v1v8>;
+		v2v1-supply =3D <&v2v1>;
+		enable-active-high;
+	};
+};
+
+/include/ "twl6030.dtsi"
+
+&i2c2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&i2c2_pins>;
+
+	clock-frequency =3D <400000>;
+};
+
+&i2c3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&i2c3_pins>;
+
+	clock-frequency =3D <100000>;
+
+	/*
+	 * Display monitor features are burnt in their EEPROM as EDID data.
+	 * The EEPROM is connected as I2C slave device.
+	 */
+	eeprom@50 {
+		compatible =3D "ti,eeprom";
+		reg =3D <0x50>;
+	};
+};
+
+&i2c4 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&i2c4_pins>;
+
+	clock-frequency =3D <400000>;
+};
+
+&mmc1 {
+	vmmc-supply =3D <&vmmc>;
+	bus-width =3D <8>;
+};
+
+&mmc2 {
+	status =3D "disabled";
+};
+
+&mmc3 {
+	status =3D "disabled";
+};
+
+&mmc4 {
+	status =3D "disabled";
+};
+
+&mmc5 {
+	ti,non-removable;
+	bus-width =3D <4>;
+};
+
+&emif1 {
+	cs1-used;
+	device-handle =3D <&elpida_ECB240ABACN>;
+};
+
+&emif2 {
+	cs1-used;
+	device-handle =3D <&elpida_ECB240ABACN>;
+};
+
+&mcbsp2 {
+	status =3D "disabled";
+};
+
+&mcbsp3 {
+	status =3D "disabled";
+};
+
+&dmic {
+	status =3D "disabled";
+};
+
+&twl_usb_comparator {
+	usb-supply =3D <&vusb>;
+};
+
+&usb_otg_hs {
+	interface-type =3D <1>;
+	mode =3D <3>;
+	power =3D <50>;
+};
diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/o=
map4-panda-es.dts
index 2a6e344..f1d8c21 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -5,9 +5,10 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+/dts-v1/;
=20
-/include/ "omap4-panda.dts"
 /include/ "omap4460.dtsi"
+/include/ "omap4-panda-common.dtsi"
=20
 /* Audio routing is differnet between PandaBoard4430 and PandaBoardES =
*/
 &sound {
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap=
4-panda.dts
index e05b1b0..f8b221f 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -8,247 +8,4 @@
 /dts-v1/;
=20
 /include/ "omap443x.dtsi"
-/include/ "elpida_ecb240abacn.dtsi"
-
-/ {
-	model =3D "TI OMAP4 PandaBoard";
-	compatible =3D "ti,omap4-panda", "ti,omap4430", "ti,omap4";
-
-	memory {
-		device_type =3D "memory";
-		reg =3D <0x80000000 0x40000000>; /* 1 GB */
-	};
-
-	leds {
-		compatible =3D "gpio-leds";
-		heartbeat {
-			label =3D "pandaboard::status1";
-			gpios =3D <&gpio1 7 0>;
-			linux,default-trigger =3D "heartbeat";
-		};
-
-		mmc {
-			label =3D "pandaboard::status2";
-			gpios =3D <&gpio1 8 0>;
-			linux,default-trigger =3D "mmc0";
-		};
-	};
-
-	sound: sound {
-		compatible =3D "ti,abe-twl6040";
-		ti,model =3D "PandaBoard";
-
-		ti,mclk-freq =3D <38400000>;
-
-		ti,mcpdm =3D <&mcpdm>;
-
-		ti,twl6040 =3D <&twl6040>;
-
-		/* Audio routing */
-		ti,audio-routing =3D
-			"Headset Stereophone", "HSOL",
-			"Headset Stereophone", "HSOR",
-			"Ext Spk", "HFL",
-			"Ext Spk", "HFR",
-			"Line Out", "AUXL",
-			"Line Out", "AUXR",
-			"HSMIC", "Headset Mic",
-			"Headset Mic", "Headset Mic Bias",
-			"AFML", "Line In",
-			"AFMR", "Line In";
-	};
-};
-
-&omap4_pmx_core {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <
-			&twl6040_pins
-			&mcpdm_pins
-			&mcbsp1_pins
-			&dss_hdmi_pins
-			&tpd12s015_pins
-	>;
-
-	twl6040_pins: pinmux_twl6040_pins {
-		pinctrl-single,pins =3D <
-			0xe0 0x3	/* hdq_sio.gpio_127 OUTPUT | MODE3 */
-			0x160 0x100	/* sys_nirq2.sys_nirq2 INPUT | MODE0 */
-		>;
-	};
-
-	mcpdm_pins: pinmux_mcpdm_pins {
-		pinctrl-single,pins =3D <
-			0xc6 0x108	/* abe_pdm_ul_data.abe_pdm_ul_data INPUT PULLDOWN | MODE=
0 */
-			0xc8 0x108	/* abe_pdm_dl_data.abe_pdm_dl_data INPUT PULLDOWN | MODE=
0 */
-			0xca 0x118	/* abe_pdm_frame.abe_pdm_frame INPUT PULLUP | MODE0 */
-			0xcc 0x108	/* abe_pdm_lb_clk.abe_pdm_lb_clk INPUT PULLDOWN | MODE0 =
*/
-			0xce 0x108	/* abe_clks.abe_clks INPUT PULLDOWN | MODE0 */
-		>;
-	};
-
-	mcbsp1_pins: pinmux_mcbsp1_pins {
-		pinctrl-single,pins =3D <
-			0xbe 0x100	/* abe_mcbsp1_clkx.abe_mcbsp1_clkx INPUT | MODE0 */
-			0xc0 0x108	/* abe_mcbsp1_dr.abe_mcbsp1_dr INPUT PULLDOWN | MODE0 */
-			0xc2 0x8		/* abe_mcbsp1_dx.abe_mcbsp1_dx OUTPUT PULLDOWN | MODE0 */
-			0xc4 0x100	/* abe_mcbsp1_fsx.abe_mcbsp1_fsx INPUT | MODE0 */
-		>;
-	};
-
-	dss_hdmi_pins: pinmux_dss_hdmi_pins {
-		pinctrl-single,pins =3D <
-			0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
-			0x5c 0x118	/* hdmi_scl.hdmi_scl INPUT PULLUP | MODE 0 */
-			0x5e 0x118	/* hdmi_sda.hdmi_sda INPUT PULLUP | MODE 0 */
-		>;
-	};
-
-	tpd12s015_pins: pinmux_tpd12s015_pins {
-		pinctrl-single,pins =3D <
-			0x22 0x3	/* gpmc_a17.gpio_41 OUTPUT | MODE3 */
-			0x48 0x3	/* gpmc_nbe1.gpio_60 OUTPUT | MODE3 */
-			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
-		>;
-	};
-
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins =3D <
-			0xe2 0x118        /* i2c1_scl PULLUP | INPUTENABLE | MODE0 */
-			0xe4 0x118        /* i2c1_sda PULLUP | INPUTENABLE | MODE0 */
-		>;
-	};
-
-	i2c2_pins: pinmux_i2c2_pins {
-		pinctrl-single,pins =3D <
-			0xe6 0x118        /* i2c2_scl PULLUP | INPUTENABLE | MODE0 */
-			0xe8 0x118        /* i2c2_sda PULLUP | INPUTENABLE | MODE0 */
-		>;
-	};
-
-	i2c3_pins: pinmux_i2c3_pins {
-		pinctrl-single,pins =3D <
-			0xea 0x118        /* i2c3_scl PULLUP | INPUTENABLE | MODE0 */
-			0xec 0x118     /* i2c3_sda PULLUP | INPUTENABLE | MODE0 */
-		>;
-	};
-
-	i2c4_pins: pinmux_i2c4_pins {
-		pinctrl-single,pins =3D <
-			0xee 0x118        /* i2c4_scl PULLUP | INPUTENABLE | MODE0 */
-			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
-		>;
-	};
-};
-
-&i2c1 {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&i2c1_pins>;
-
-	clock-frequency =3D <400000>;
-
-	twl: twl@48 {
-		reg =3D <0x48>;
-		/* SPI =3D 0, IRQ# =3D 7, 4 =3D active high level-sensitive */
-		interrupts =3D <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
-		interrupt-parent =3D <&gic>;
-	};
-
-	twl6040: twl@4b {
-		compatible =3D "ti,twl6040";
-		reg =3D <0x4b>;
-		/* SPI =3D 0, IRQ# =3D 119, 4 =3D active high level-sensitive */
-		interrupts =3D <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
-		interrupt-parent =3D <&gic>;
-		ti,audpwron-gpio =3D <&gpio4 31 0>;  /* gpio line 127 */
-
-		vio-supply =3D <&v1v8>;
-		v2v1-supply =3D <&v2v1>;
-		enable-active-high;
-	};
-};
-
-/include/ "twl6030.dtsi"
-
-&i2c2 {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&i2c2_pins>;
-
-	clock-frequency =3D <400000>;
-};
-
-&i2c3 {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&i2c3_pins>;
-
-	clock-frequency =3D <100000>;
-
-	/*
-	 * Display monitor features are burnt in their EEPROM as EDID data.
-	 * The EEPROM is connected as I2C slave device.
-	 */
-	eeprom@50 {
-		compatible =3D "ti,eeprom";
-		reg =3D <0x50>;
-	};
-};
-
-&i2c4 {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&i2c4_pins>;
-
-	clock-frequency =3D <400000>;
-};
-
-&mmc1 {
-	vmmc-supply =3D <&vmmc>;
-	bus-width =3D <8>;
-};
-
-&mmc2 {
-	status =3D "disabled";
-};
-
-&mmc3 {
-	status =3D "disabled";
-};
-
-&mmc4 {
-	status =3D "disabled";
-};
-
-&mmc5 {
-	ti,non-removable;
-	bus-width =3D <4>;
-};
-
-&emif1 {
-	cs1-used;
-	device-handle =3D <&elpida_ECB240ABACN>;
-};
-
-&emif2 {
-	cs1-used;
-	device-handle =3D <&elpida_ECB240ABACN>;
-};
-
-&mcbsp2 {
-	status =3D "disabled";
-};
-
-&mcbsp3 {
-	status =3D "disabled";
-};
-
-&dmic {
-	status =3D "disabled";
-};
-
-&twl_usb_comparator {
-	usb-supply =3D <&vusb>;
-};
-
-&usb_otg_hs {
-	interface-type =3D <1>;
-	mode =3D <3>;
-	power =3D <50>;
-};
+/include/ "omap4-panda-common.dtsi"
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap44=
60.dtsi
index 0a1d38b..e09b3e1 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -7,6 +7,7 @@
  * version 2.  This program is licensed "as is" without any warranty o=
f any
  * kind, whether express or implied.
  */
+/include/ "omap4.dtsi"
=20
 / {
 	pmu {
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
