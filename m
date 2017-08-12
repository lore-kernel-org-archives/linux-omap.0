From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 8/8] ARM: dts: Add support for dra76-evm
Date: Sat, 12 Aug 2017 09:36:05 +0530
Message-ID: <20170812040605.21259-9-lokeshvutla@ti.com>
References: <20170812040605.21259-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170812040605.21259-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Praneeth Bajjuri <praneeth-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

dra76-evm is a board based on TI's dra76 processor targeting
for infotainment systems. Adding support for this platform.

dra76-evm and dra7-evm has a similar layout except with few differences.
So create a dra7-evm-common.dtsi with similarities on dra76-evm and
dra7-evm. Include this common dtsi in both dra7-evm.dts and dra76-evm.dts

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi             | 258 +++++++++++++
 arch/arm/boot/dts/dra7-evm.dts                     | 248 +-----------
 arch/arm/boot/dts/dra76-evm.dts                    | 423 +++++++++++++++++++++
 5 files changed, 687 insertions(+), 248 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra7-evm-common.dtsi
 create mode 100644 arch/arm/boot/dts/dra76-evm.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 9c6bebe43449..68d6e60d8d17 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -187,6 +187,9 @@ Boards:
 - AM5718 IDK
   compatible = "ti,am5718-idk", "ti,am5718", "ti,dra7"
 
+- DRA762 EVM:  Software Development Board for DRA762
+  compatible = "ti,dra76-evm", "ti,dra762", "ti,dra7"
+
 - DRA742 EVM:  Software Development Board for DRA742
   compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35dc9a7..d563d91a18e3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -657,7 +657,8 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 	dra7-evm.dtb \
 	dra72-evm.dtb \
 	dra72-evm-revc.dtb \
-	dra71-evm.dtb
+	dra71-evm.dtb \
+	dra76-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-kuroboxpro.dtb \
 	orion5x-lacie-d2-network.dtb \
diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
new file mode 100644
index 000000000000..343e95f9a001
--- /dev/null
+++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
@@ -0,0 +1,258 @@
+/*
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clk/ti-dra7-atl.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	extcon_usb1: extcon_usb1 {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pcf_gpio_21 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	sound0: sound0 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "DRA7xx-EVM";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line", "Line Out",
+			"Microphone", "Mic Jack",
+			"Line", "Line In";
+		simple-audio-card,routing =
+			"Headphone Jack",	"HPLOUT",
+			"Headphone Jack",	"HPROUT",
+			"Line Out",		"LLOUT",
+			"Line Out",		"RLOUT",
+			"MIC3L",		"Mic Jack",
+			"MIC3R",		"Mic Jack",
+			"Mic Jack",		"Mic Bias",
+			"LINE1L",		"Line In",
+			"LINE1R",		"Line In";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound0_master>;
+		simple-audio-card,frame-master = <&sound0_master>;
+		simple-audio-card,bitclock-inversion;
+
+		sound0_master: simple-audio-card,cpu {
+			sound-dai = <&mcasp3>;
+			system-clock-frequency = <5644800>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			clocks = <&atl_clkin2_ck>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led0 {
+			label = "dra7:usr1";
+			gpios = <&pcf_lcd 4 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led1 {
+			label = "dra7:usr2";
+			gpios = <&pcf_lcd 5 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led2 {
+			label = "dra7:usr3";
+			gpios = <&pcf_lcd 6 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led3 {
+			label = "dra7:usr4";
+			gpios = <&pcf_lcd 7 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		USER1 {
+			label = "btnUser1";
+			linux,code = <BTN_0>;
+			gpios = <&pcf_lcd 2 GPIO_ACTIVE_LOW>;
+		};
+
+		USER2 {
+			label = "btnUser2";
+			linux,code = <BTN_1>;
+			gpios = <&pcf_lcd 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+	clock-frequency = <400000>;
+};
+
+&mcspi1 {
+	status = "okay";
+};
+
+&mcspi2 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+	interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+			      <&dra7_pmx_core 0x3e0>;
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&qspi {
+	status = "okay";
+
+	spi-max-frequency = <76800000>;
+	m25p80@0 {
+		compatible = "s25fl256s1";
+		spi-max-frequency = <76800000>;
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* MTD partition table.
+		 * The ROM checks the first four physical blocks
+		 * for a valid file to boot and the flash here is
+		 * 64KiB block size.
+		 */
+		partition@0 {
+			label = "QSPI.SPL";
+			reg = <0x00000000 0x000010000>;
+		};
+		partition@1 {
+			label = "QSPI.SPL.backup1";
+			reg = <0x00010000 0x00010000>;
+		};
+		partition@2 {
+			label = "QSPI.SPL.backup2";
+			reg = <0x00020000 0x00010000>;
+		};
+		partition@3 {
+			label = "QSPI.SPL.backup3";
+			reg = <0x00030000 0x00010000>;
+		};
+		partition@4 {
+			label = "QSPI.u-boot";
+			reg = <0x00040000 0x00100000>;
+		};
+		partition@5 {
+			label = "QSPI.u-boot-spl-os";
+			reg = <0x00140000 0x00080000>;
+		};
+		partition@6 {
+			label = "QSPI.u-boot-env";
+			reg = <0x001c0000 0x00010000>;
+		};
+		partition@7 {
+			label = "QSPI.u-boot-env.backup1";
+			reg = <0x001d0000 0x0010000>;
+		};
+		partition@8 {
+			label = "QSPI.kernel";
+			reg = <0x001e0000 0x0800000>;
+		};
+		partition@9 {
+			label = "QSPI.file-system";
+			reg = <0x009e0000 0x01620000>;
+		};
+	};
+};
+
+&omap_dwc3_1 {
+	extcon = <&extcon_usb1>;
+};
+
+&usb1 {
+	dr_mode = "otg";
+	extcon = <&extcon_usb1>;
+};
+
+&usb2 {
+	dr_mode = "host";
+};
+
+&atl {
+	assigned-clocks = <&abe_dpll_sys_clk_mux>,
+			  <&atl_gfclk_mux>,
+			  <&dpll_abe_ck>,
+			  <&dpll_abe_m2x2_ck>,
+			  <&atl_clkin2_ck>;
+	assigned-clock-parents = <&sys_clkin2>, <&dpll_abe_m2_ck>;
+	assigned-clock-rates = <0>, <0>, <180633600>, <361267200>, <5644800>;
+
+	status = "okay";
+
+	atl2 {
+		bws = <DRA7_ATL_WS_MCASP2_FSX>;
+		aws = <DRA7_ATL_WS_MCASP3_FSX>;
+	};
+};
+
+&mcasp3 {
+	#sound-dai-cells = <0>;
+
+	assigned-clocks = <&mcasp3_ahclkx_mux>;
+	assigned-clock-parents = <&atl_clkin2_ck>;
+
+	status = "okay";
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	/* 4 serializer */
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+		1 2 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
+
+&mailbox5 {
+	status = "okay";
+	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
+		status = "okay";
+	};
+	mbox_dsp1_ipc3x: mbox_dsp1_ipc3x {
+		status = "okay";
+	};
+};
+
+&mailbox6 {
+	status = "okay";
+	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
+		status = "okay";
+	};
+	mbox_dsp2_ipc3x: mbox_dsp2_ipc3x {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index f47fc4daf062..c3009bda62e3 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -8,9 +8,7 @@
 /dts-v1/;
 
 #include "dra74x.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clk/ti-dra7-atl.h>
-#include <dt-bindings/input/input.h>
+#include "dra7-evm-common.dtsi"
 
 / {
 	model = "TI DRA742";
@@ -21,10 +19,6 @@
 		reg = <0x0 0x80000000 0x0 0x60000000>; /* 1536 MB */
 	};
 
-	chosen {
-		stdout-path = &uart1;
-	};
-
 	evm_3v3_sd: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3_sd";
@@ -51,11 +45,6 @@
 		regulator-max-microvolt = <1800000>;
 	};
 
-	extcon_usb1: extcon_usb1 {
-		compatible = "linux,extcon-usb-gpio";
-		id-gpio = <&pcf_gpio_21 1 GPIO_ACTIVE_HIGH>;
-	};
-
 	extcon_usb2: extcon_usb2 {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&pcf_gpio_21 2 GPIO_ACTIVE_HIGH>;
@@ -73,85 +62,6 @@
 		gpio = <&gpio7 11 GPIO_ACTIVE_HIGH>;
 	};
 
-	sound0: sound0 {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "DRA7xx-EVM";
-		simple-audio-card,widgets =
-			"Headphone", "Headphone Jack",
-			"Line", "Line Out",
-			"Microphone", "Mic Jack",
-			"Line", "Line In";
-		simple-audio-card,routing =
-			"Headphone Jack",	"HPLOUT",
-			"Headphone Jack",	"HPROUT",
-			"Line Out",		"LLOUT",
-			"Line Out",		"RLOUT",
-			"MIC3L",		"Mic Jack",
-			"MIC3R",		"Mic Jack",
-			"Mic Jack",		"Mic Bias",
-			"LINE1L",		"Line In",
-			"LINE1R",		"Line In";
-		simple-audio-card,format = "dsp_b";
-		simple-audio-card,bitclock-master = <&sound0_master>;
-		simple-audio-card,frame-master = <&sound0_master>;
-		simple-audio-card,bitclock-inversion;
-
-		sound0_master: simple-audio-card,cpu {
-			sound-dai = <&mcasp3>;
-			system-clock-frequency = <5644800>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&tlv320aic3106>;
-			clocks = <&atl_clkin2_ck>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		led0 {
-			label = "dra7:usr1";
-			gpios = <&pcf_lcd 4 GPIO_ACTIVE_LOW>;
-			default-state = "off";
-		};
-
-		led1 {
-			label = "dra7:usr2";
-			gpios = <&pcf_lcd 5 GPIO_ACTIVE_LOW>;
-			default-state = "off";
-		};
-
-		led2 {
-			label = "dra7:usr3";
-			gpios = <&pcf_lcd 6 GPIO_ACTIVE_LOW>;
-			default-state = "off";
-		};
-
-		led3 {
-			label = "dra7:usr4";
-			gpios = <&pcf_lcd 7 GPIO_ACTIVE_LOW>;
-			default-state = "off";
-		};
-	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		autorepeat;
-
-		USER1 {
-			label = "btnUser1";
-			linux,code = <BTN_0>;
-			gpios = <&pcf_lcd 2 GPIO_ACTIVE_LOW>;
-		};
-
-		USER2 {
-			label = "btnUser2";
-			linux,code = <BTN_1>;
-			gpios = <&pcf_lcd 3 GPIO_ACTIVE_LOW>;
-		};
-	};
 };
 
 &dra7_pmx_core {
@@ -406,33 +316,6 @@
 	};
 };
 
-&i2c3 {
-	status = "okay";
-	clock-frequency = <400000>;
-};
-
-&mcspi1 {
-	status = "okay";
-};
-
-&mcspi2 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-	interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
-			      <&dra7_pmx_core 0x3e0>;
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&uart3 {
-	status = "okay";
-};
-
 &mmc1 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -459,84 +342,10 @@
 	cpu0-supply = <&smps123_reg>;
 };
 
-&qspi {
-	status = "okay";
-
-	spi-max-frequency = <76800000>;
-	m25p80@0 {
-		compatible = "s25fl256s1";
-		spi-max-frequency = <76800000>;
-		reg = <0>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		/* MTD partition table.
-		 * The ROM checks the first four physical blocks
-		 * for a valid file to boot and the flash here is
-		 * 64KiB block size.
-		 */
-		partition@0 {
-			label = "QSPI.SPL";
-			reg = <0x00000000 0x000010000>;
-		};
-		partition@1 {
-			label = "QSPI.SPL.backup1";
-			reg = <0x00010000 0x00010000>;
-		};
-		partition@2 {
-			label = "QSPI.SPL.backup2";
-			reg = <0x00020000 0x00010000>;
-		};
-		partition@3 {
-			label = "QSPI.SPL.backup3";
-			reg = <0x00030000 0x00010000>;
-		};
-		partition@4 {
-			label = "QSPI.u-boot";
-			reg = <0x00040000 0x00100000>;
-		};
-		partition@5 {
-			label = "QSPI.u-boot-spl-os";
-			reg = <0x00140000 0x00080000>;
-		};
-		partition@6 {
-			label = "QSPI.u-boot-env";
-			reg = <0x001c0000 0x00010000>;
-		};
-		partition@7 {
-			label = "QSPI.u-boot-env.backup1";
-			reg = <0x001d0000 0x0010000>;
-		};
-		partition@8 {
-			label = "QSPI.kernel";
-			reg = <0x001e0000 0x0800000>;
-		};
-		partition@9 {
-			label = "QSPI.file-system";
-			reg = <0x009e0000 0x01620000>;
-		};
-	};
-};
-
-&omap_dwc3_1 {
-	extcon = <&extcon_usb1>;
-};
-
 &omap_dwc3_2 {
 	extcon = <&extcon_usb2>;
 };
 
-&usb1 {
-	dr_mode = "otg";
-	extcon = <&extcon_usb1>;
-};
-
-&usb2 {
-	dr_mode = "host";
-};
-
 &elm {
 	status = "okay";
 };
@@ -665,58 +474,3 @@
 	pinctrl-1 = <&dcan1_pins_sleep>;
 	pinctrl-2 = <&dcan1_pins_default>;
 };
-
-&atl {
-	assigned-clocks = <&abe_dpll_sys_clk_mux>,
-			  <&atl_gfclk_mux>,
-			  <&dpll_abe_ck>,
-			  <&dpll_abe_m2x2_ck>,
-			  <&atl_clkin2_ck>;
-	assigned-clock-parents = <&sys_clkin2>, <&dpll_abe_m2_ck>;
-	assigned-clock-rates = <0>, <0>, <180633600>, <361267200>, <5644800>;
-
-	status = "okay";
-
-	atl2 {
-		bws = <DRA7_ATL_WS_MCASP2_FSX>;
-		aws = <DRA7_ATL_WS_MCASP3_FSX>;
-	};
-};
-
-&mcasp3 {
-	#sound-dai-cells = <0>;
-
-	assigned-clocks = <&mcasp3_ahclkx_mux>;
-	assigned-clock-parents = <&atl_clkin2_ck>;
-
-	status = "okay";
-
-	op-mode = <0>;          /* MCASP_IIS_MODE */
-	tdm-slots = <2>;
-	/* 4 serializer */
-	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
-		1 2 0 0
-	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
-};
-
-&mailbox5 {
-	status = "okay";
-	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
-		status = "okay";
-	};
-	mbox_dsp1_ipc3x: mbox_dsp1_ipc3x {
-		status = "okay";
-	};
-};
-
-&mailbox6 {
-	status = "okay";
-	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
-		status = "okay";
-	};
-	mbox_dsp2_ipc3x: mbox_dsp2_ipc3x {
-		status = "okay";
-	};
-};
diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
new file mode 100644
index 000000000000..b024a65c6e27
--- /dev/null
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -0,0 +1,423 @@
+/*
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "dra76x.dtsi"
+#include "dra7-evm-common.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	model = "TI DRA762 EVM";
+	compatible = "ti,dra76-evm", "ti,dra762", "ti,dra7";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+
+	vsys_12v0: fixedregulator-vsys12v0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_5v0: fixedregulator-vsys5v0 {
+		/* Output of Cntlr B of TPS43351-Q1 on dra76-evm */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vsys_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_3v3: fixedregulator-vsys3v3 {
+		/* Output of Cntlr A of TPS43351-Q1 on dra76-evm */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vsys_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vio_3v3: fixedregulator-vio_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vio_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vsys_3v3>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vio_3v3_sd: fixedregulator-sd {
+		compatible = "regulator-fixed";
+		regulator-name = "vio_3v3_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vio_3v3>;
+		enable-active-high;
+		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
+	};
+
+	vio_1v8: fixedregulator-vio_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vio_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&smps5_reg>;
+	};
+
+	vtt_fixed: fixedregulator-vtt {
+		compatible = "regulator-fixed";
+		regulator-name = "vtt_fixed";
+		regulator-min-microvolt = <1350000>;
+		regulator-max-microvolt = <1350000>;
+		vin-supply = <&vsys_3v3>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	aic_dvdd: fixedregulator-aic_dvdd {
+		/* TPS77018DBVT */
+		compatible = "regulator-fixed";
+		regulator-name = "aic_dvdd";
+		vin-supply = <&vio_3v3>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&dra7_pmx_core {
+	mmc1_pins_default: mmc1_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x376c, PIN_INPUT | MUX_MODE14)	/* mmc1sdcd.gpio219 */
+			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
+			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
+			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
+			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
+			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
+		>;
+	};
+
+	mmc1_pins_sdr12: pinmux_mmc1_sdr12_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_clk.clk */
+			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_cmd.cmd */
+			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat0.dat0 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat1.dat1 */
+			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat2.dat2 */
+			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat3.dat3 */
+		>;
+	};
+
+	mmc2_pins_default: mmc2_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x349c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a23.mmc2_clk */
+			DRA7XX_CORE_IOPAD(0x34b0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_cs1.mmc2_cmd */
+			DRA7XX_CORE_IOPAD(0x34a0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a24.mmc2_dat0 */
+			DRA7XX_CORE_IOPAD(0x34a4, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a25.mmc2_dat1 */
+			DRA7XX_CORE_IOPAD(0x34a8, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a26.mmc2_dat2 */
+			DRA7XX_CORE_IOPAD(0x34ac, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a27.mmc2_dat3 */
+			DRA7XX_CORE_IOPAD(0x348c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a19.mmc2_dat4 */
+			DRA7XX_CORE_IOPAD(0x3490, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a20.mmc2_dat5 */
+			DRA7XX_CORE_IOPAD(0x3494, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a21.mmc2_dat6 */
+			DRA7XX_CORE_IOPAD(0x3498, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
+		>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tps65917: tps65917@58 {
+		compatible = "ti,tps65917";
+		reg = <0x58>;
+		ti,system-power-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		tps65917_pmic {
+			compatible = "ti,tps65917-pmic";
+
+			smps12-in-supply = <&vsys_3v3>;
+			smps3-in-supply = <&vsys_3v3>;
+			smps4-in-supply = <&vsys_3v3>;
+			smps5-in-supply = <&vsys_3v3>;
+			ldo1-in-supply = <&vsys_3v3>;
+			ldo2-in-supply = <&vsys_3v3>;
+			ldo3-in-supply = <&vsys_5v0>;
+			ldo4-in-supply = <&vsys_5v0>;
+			ldo5-in-supply = <&vsys_3v3>;
+
+			tps65917_regulators: regulators {
+				smps12_reg: smps12 {
+					/* VDD_DSPEVE */
+					regulator-name = "smps12";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				smps3_reg: smps3 {
+					/* VDD_CORE */
+					regulator-name = "smps3";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				smps4_reg: smps4 {
+					/* VDD_IVA */
+					regulator-name = "smps4";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				smps5_reg: smps5 {
+					/* VDDS1V8 */
+					regulator-name = "smps5";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				ldo1_reg: ldo1 {
+					/* LDO1_OUT --> VDA_PHY1_1V8  */
+					regulator-name = "ldo1";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					regulator-allow-bypass;
+				};
+
+				ldo2_reg: ldo2 {
+					/* LDO2_OUT --> VDA_PHY2_1V8 */
+					regulator-name = "ldo2";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-allow-bypass;
+					regulator-always-on;
+				};
+
+				ldo3_reg: ldo3 {
+					/* VDA_USB_3V3 */
+					regulator-name = "ldo3";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				ldo5_reg: ldo5 {
+					/* VDDA_1V8_PLL */
+					regulator-name = "ldo5";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				ldo4_reg: ldo4 {
+					/* VDD_SDIO_DV */
+					regulator-name = "ldo4";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+			};
+		};
+
+		tps65917_power_button {
+			compatible = "ti,palmas-pwrbutton";
+			interrupt-parent = <&tps65917>;
+			interrupts = <1 IRQ_TYPE_NONE>;
+			wakeup-source;
+			ti,palmas-long-press-seconds = <6>;
+		};
+	};
+
+	lp87565: lp87565@60 {
+		compatible = "ti,lp87565-q1";
+		reg = <0x60>;
+
+		buck10-in-supply =<&vsys_3v3>;
+		buck23-in-supply =<&vsys_3v3>;
+
+		regulators: regulators {
+			buck10_reg: buck10 {
+				/*VDD_MPU*/
+				regulator-name = "buck10";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck23_reg: buck23 {
+				/* VDD_GPU*/
+				regulator-name = "buck23";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	pcf_lcd: pcf8757@20 {
+		compatible = "ti,pcf8575", "nxp,pcf8575";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	pcf_gpio_21: pcf8757@21 {
+		compatible = "ti,pcf8575", "nxp,pcf8575";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	pcf_hdmi: pcf8575@26 {
+		compatible = "ti,pcf8575", "nxp,pcf8575";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		p1 {
+			/* vin6_sel_s0: high: VIN6, low: audio */
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "vin6_sel_s0";
+		};
+	};
+
+	tlv320aic3106: tlv320aic3106@19 {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x19>;
+		adc-settle-ms = <40>;
+		ai3x-micbias-vg = <1>;		/* 2.0V */
+		status = "okay";
+
+		/* Regulators */
+		AVDD-supply = <&vio_3v3>;
+		IOVDD-supply = <&vio_3v3>;
+		DRVDD-supply = <&vio_3v3>;
+		DVDD-supply = <&aic_dvdd>;
+	};
+};
+
+&cpu0 {
+	vdd-supply = <&buck10_reg>;
+};
+
+&mmc1 {
+	status = "okay";
+	vmmc-supply = <&vio_3v3_sd>;
+	vmmc_aux-supply = <&ldo4_reg>;
+	bus-width = <4>;
+	/*
+	 * SDCD signal is not being used here - using the fact that GPIO mode
+	 * is always hardwired.
+	 */
+	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_default>;
+};
+
+&mmc2 {
+	status = "okay";
+	vmmc-supply = <&vio_1v8>;
+	bus-width = <8>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins_default>;
+};
+
+/* No RTC on this device */
+&rtc {
+	status = "disabled";
+};
+
+&mac {
+	status = "okay";
+
+	dual_emac;
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <2>;
+	phy-mode = "rgmii-id";
+	dual_emac_res_vlan = <1>;
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <3>;
+	phy-mode = "rgmii-id";
+	dual_emac_res_vlan = <2>;
+};
+
+&davinci_mdio {
+	dp83867_0: ethernet-phy@2 {
+		reg = <2>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+		ti,min-output-impedance;
+		ti,dp83867-rxctrl-strap-quirk;
+	};
+
+	dp83867_1: ethernet-phy@3 {
+		reg = <3>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+		ti,min-output-impedance;
+		ti,dp83867-rxctrl-strap-quirk;
+	};
+};
+
+&usb2_phy1 {
+	phy-supply = <&ldo3_reg>;
+};
+
+&usb2_phy2 {
+	phy-supply = <&ldo3_reg>;
+};
+
+&qspi {
+	spi-max-frequency = <96000000>;
+	m25p80@0 {
+		spi-max-frequency = <96000000>;
+	};
+};
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
