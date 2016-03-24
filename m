From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: AM572x-IDK Initial Support
Date: Thu, 24 Mar 2016 17:30:44 -0500
Message-ID: <1458858644-13800-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>

The AM572x-IDK board is a board based on TI's AM5728 SOC
which has a dual core 1.5GHz A15 processor. This board is a
development platform for the Industrial market with:
- 2GB of DDR3L
- Dual 1Gbps Ethernet
- HDMI,
- PRU-ICSS
- uSD
- 16GB eMMC
- CAN
- RS-485
- PCIe
- USB3.0
- Video Input Port
- Industrial IO port and expansion connector

The link to the data sheet and TRM can be found here:

http://www.ti.com/product/AM5728

This patch creates a common dtsi file that will provide a common board
dtsi file to define the nodes that are common to AM57xx (including the
upcoming AM5718) IDK boards.

Initial support is only for basic peripherals

Signed-off-by: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
Based on 6f30d29c603c Add linux-next specific files for 20160324

Test log: http://pastebin.ubuntu.com/15490907/

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am572x-idk.dts                   |  85 ++++++
 arch/arm/boot/dts/am57xx-idk-common.dtsi           | 308 +++++++++++++++++++++
 4 files changed, 397 insertions(+)
 create mode 100644 arch/arm/boot/dts/am572x-idk.dts
 create mode 100644 arch/arm/boot/dts/am57xx-idk-common.dtsi

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 21e71a5e866e..38659aa35ce3 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -169,6 +169,9 @@ Boards:
 - AM57XX SBC-AM57x
   compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
 
+- AM5728 IDK
+  compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
+
 - DRA742 EVM:  Software Development Board for DRA742
   compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b25621ae2ff7..fec03c814a95 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -526,6 +526,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 	am57xx-beagle-x15.dtb \
 	am57xx-cl-som-am57x.dtb \
 	am57xx-sbc-am57x.dtb \
+	am572x-idk.dtb \
 	dra7-evm.dtb \
 	dra72-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += \
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
new file mode 100644
index 000000000000..bb51f6de7b45
--- /dev/null
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "dra74x.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "am57xx-idk-common.dtsi"
+
+/ {
+	model = "TI AM5728 IDK";
+	compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74",
+		     "ti,dra7";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+
+	extcon_usb2: extcon_usb2 {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led@0 {
+			label = "status0:red:cpu0";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "cpu0";
+		};
+
+		led@1 {
+			label = "status0:green:usr";
+			gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@2 {
+			label = "status0:blue:heartbeat";
+			gpios = <&gpio3 12 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led@3 {
+			label = "status1:red:cpu1";
+			gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "cpu1";
+		};
+
+		led@4 {
+			label = "status1:green:usr";
+			gpios = <&gpio7 23 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@5 {
+			label = "status1:blue:mmc0";
+			gpios = <&gpio7 22 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "mmc0";
+		};
+	};
+};
+
+&omap_dwc3_2 {
+	extcon = <&extcon_usb2>;
+};
+
+&mmc1 {
+	status = "okay";
+	vmmc-supply = <&v3_3d>;
+	vmmc_aux-supply = <&ldo1_reg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
+};
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
new file mode 100644
index 000000000000..f1d734a31339
--- /dev/null
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -0,0 +1,308 @@
+/*
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	aliases {
+		rtc0 = &tps659038_rtc;
+		rtc1 = &rtc;
+	};
+
+	vmain: fixedregulator-vmain {
+		compatible = "regulator-fixed";
+		regulator-name = "VMAIN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	v3_3d: fixedregulator-v3_3d {
+		compatible = "regulator-fixed";
+		regulator-name = "V3_3D";
+		vin-supply = <&smps9_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vtt_fixed: fixedregulator-vtt {
+		/* TPS51200 */
+		compatible = "regulator-fixed";
+		regulator-name = "vtt_fixed";
+		vin-supply = <&v3_3d>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	src_clk_x1: src_clk_x1 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <20000000>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tps659038: tps659038@58 {
+		compatible = "ti,tps659038";
+		reg = <0x58>;
+		interrupts-extended = <&gpio6 16 IRQ_TYPE_LEVEL_HIGH
+			       &dra7_pmx_core 0x418>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		ti,system-power-controller;
+
+		tps659038_pmic {
+			compatible = "ti,tps659038-pmic";
+			regulators {
+				smps12_reg: smps12 {
+					/* VDD_MPU */
+					vin-supply = <&vmain>;
+					regulator-name = "smps12";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				smps3_reg: smps3 {
+					/* VDD_DDR EMIF1 EMIF2 */
+					vin-supply = <&vmain>;
+					regulator-name = "smps3";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				smps45_reg: smps45 {
+					/* VDD_DSPEVE on AM572 */
+					/* VDD_IVA + VDD_DSP on AM571 */
+					vin-supply = <&vmain>;
+					regulator-name = "smps45";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				smps6_reg: smps6 {
+					/* VDD_GPU */
+					vin-supply = <&vmain>;
+					regulator-name = "smps6";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				smps7_reg: smps7 {
+					/* VDD_CORE */
+					vin-supply = <&vmain>;
+					regulator-name = "smps7";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1150000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				smps8_reg: smps8 {
+					/* 5728 - VDD_IVAHD */
+					/* 5718 - N.C. test point */
+					vin-supply = <&vmain>;
+					regulator-name = "smps8";
+				};
+
+				smps9_reg: smps9 {
+					/* VDD_3_3D */
+					vin-supply = <&vmain>;
+					regulator-name = "smps9";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				ldo1_reg: ldo1 {
+					/* VDDSHV8 - VSDMMC  */
+					/* NOTE: on rev 1.3a, data supply */
+					vin-supply = <&vmain>;
+					regulator-name = "ldo1";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				ldo2_reg: ldo2 {
+					/* VDDSH18V */
+					vin-supply = <&vmain>;
+					regulator-name = "ldo2";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				ldo3_reg: ldo3 {
+					/* R1.3a 572x V1_8PHY_LDO3: USB, SATA */
+					vin-supply = <&vmain>;
+					regulator-name = "ldo3";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				ldo4_reg: ldo4 {
+					/* R1.3a 572x V1_8PHY_LDO4: PCIE, HDMI*/
+					vin-supply = <&vmain>;
+					regulator-name = "ldo4";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				/* LDO5-8 unused */
+
+				ldo9_reg: ldo9 {
+					/* VDD_RTC  */
+					vin-supply = <&vmain>;
+					regulator-name = "ldo9";
+					regulator-min-microvolt = <840000>;
+					regulator-max-microvolt = <1160000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				ldoln_reg: ldoln {
+					/* VDDA_1V8_PLL */
+					vin-supply = <&vmain>;
+					regulator-name = "ldoln";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				ldousb_reg: ldousb {
+					/* VDDA_3V_USB: VDDA_USBHS33 */
+					vin-supply = <&vmain>;
+					regulator-name = "ldousb";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				ldortc_reg: ldortc {
+					/* VDDA_RTC  */
+					vin-supply = <&vmain>;
+					regulator-name = "ldortc";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				regen1: regen1 {
+					/* VDD_3V3_ON */
+					regulator-name = "regen1";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				regen2: regen2 {
+					/* Needed for PMIC internal resource */
+					regulator-name = "regen2";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+			};
+		};
+
+		tps659038_rtc: tps659038_rtc {
+			compatible = "ti,palmas-rtc";
+			interrupt-parent = <&tps659038>;
+			interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+			wakeup-source;
+		};
+
+		tps659038_pwr_button: tps659038_pwr_button {
+			compatible = "ti,palmas-pwrbutton";
+			interrupt-parent = <&tps659038>;
+			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+			wakeup-source;
+			ti,palmas-long-press-seconds = <12>;
+		};
+
+		tps659038_gpio: tps659038_gpio {
+			compatible = "ti,palmas-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
+};
+
+&uart3 {
+	status = "okay";
+	interrupts-extended = <&crossbar_mpu GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH
+			       &dra7_pmx_core 0x248>;
+};
+
+&rtc {
+	status = "okay";
+	ext-clk-src;
+};
+
+&mac {
+	status = "okay";
+	dual_emac;
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "rgmii";
+	dual_emac_res_vlan = <1>;
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "rgmii";
+	dual_emac_res_vlan = <2>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&ldousb_reg>;
+};
+
+&usb2_phy2 {
+	phy-supply = <&ldousb_reg>;
+};
+
+&usb1 {
+	dr_mode = "host";
+};
+
+&usb2 {
+	dr_mode = "otg";
+};
+
+&mmc2 {
+	status = "okay";
+	vmmc-supply = <&v3_3d>;
+	bus-width = <8>;
+	ti,non-removable;
+	max-frequency = <96000000>;
+};
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
