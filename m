From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/9] ARM: dts: dra72: Add separate dtsi for tps65917
Date: Fri, 14 Oct 2016 18:30:27 +0530
Message-ID: <20161014130033.14172-4-lokeshvutla@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161014130033.14172-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

dra72-evm-common.dtsi consolidates dra72-evm.dts and dra72-evm-revc.dts
which also include tps65917 pmic support as both the evms uses the same
pmic. But, dra71-evm has mostly similar features with a different pmic.
In order to exploit dra72-evm-common.dtsi, creating a separate dtsi
for tps65915 support and including it in respective board files.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra72-evm-common.dtsi   | 128 ----------------------------
 arch/arm/boot/dts/dra72-evm-revc.dts      |  21 +++--
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi | 134 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72-evm.dts           |  14 ++--
 4 files changed, 154 insertions(+), 143 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72-evm-tps65917.dtsi

diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 8537b6a..9903ac7 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -214,123 +214,6 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
-	tps65917: tps65917@58 {
-		compatible = "ti,tps65917";
-		reg = <0x58>;
-
-		interrupts = <GIC_SPI 2 IRQ_TYPE_NONE>;  /* IRQ_SYS_1N */
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		ti,system-power-controller;
-
-		tps65917_pmic {
-			compatible = "ti,tps65917-pmic";
-
-			smps1-in-supply = <&vsys_3v3>;
-			smps2-in-supply = <&vsys_3v3>;
-			smps3-in-supply = <&vsys_3v3>;
-			smps4-in-supply = <&vsys_3v3>;
-			smps5-in-supply = <&vsys_3v3>;
-			ldo1-in-supply = <&vsys_3v3>;
-			ldo2-in-supply = <&vsys_3v3>;
-			ldo3-in-supply = <&vsys_3v3>;
-			ldo4-in-supply = <&evm_5v0>;
-			ldo5-in-supply = <&vsys_3v3>;
-
-			tps65917_regulators: regulators {
-				smps1_reg: smps1 {
-					/* VDD_MPU */
-					regulator-name = "smps1";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1250000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				smps2_reg: smps2 {
-					/* VDD_CORE */
-					regulator-name = "smps2";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1150000>;
-					regulator-boot-on;
-					regulator-always-on;
-				};
-
-				smps3_reg: smps3 {
-					/* VDD_GPU IVA DSPEVE */
-					regulator-name = "smps3";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1250000>;
-					regulator-boot-on;
-					regulator-always-on;
-				};
-
-				smps4_reg: smps4 {
-					/* VDDS1V8 */
-					regulator-name = "smps4";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				smps5_reg: smps5 {
-					/* VDD_DDR */
-					regulator-name = "smps5";
-					regulator-min-microvolt = <1350000>;
-					regulator-max-microvolt = <1350000>;
-					regulator-boot-on;
-					regulator-always-on;
-				};
-
-				ldo1_reg: ldo1 {
-					/* LDO1_OUT --> SDIO  */
-					regulator-name = "ldo1";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
-					regulator-boot-on;
-					regulator-allow-bypass;
-				};
-
-				ldo3_reg: ldo3 {
-					/* VDDA_1V8_PHY */
-					regulator-name = "ldo3";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-boot-on;
-					regulator-always-on;
-				};
-
-				ldo5_reg: ldo5 {
-					/* VDDA_1V8_PLL */
-					regulator-name = "ldo5";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				ldo4_reg: ldo4 {
-					/* VDDA_3V_USB: VDDA_USBHS33 */
-					regulator-name = "ldo4";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-boot-on;
-				};
-			};
-		};
-
-		tps65917_power_button {
-			compatible = "ti,palmas-pwrbutton";
-			interrupt-parent = <&tps65917>;
-			interrupts = <1 IRQ_TYPE_NONE>;
-			wakeup-source;
-			ti,palmas-long-press-seconds = <6>;
-		};
-	};
-
 	pcf_gpio_21: gpio@21 {
 		compatible = "ti,pcf8575", "nxp,pcf8575";
 		reg = <0x21>;
@@ -480,14 +363,6 @@
 	};
 };
 
-&usb2_phy1 {
-	phy-supply = <&ldo4_reg>;
-};
-
-&usb2_phy2 {
-	phy-supply = <&ldo4_reg>;
-};
-
 &omap_dwc3_1 {
 	extcon = <&extcon_usb1>;
 };
@@ -509,7 +384,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins_default>;
 	vmmc-supply = <&evm_3v3_sd>;
-	vmmc_aux-supply = <&ldo1_reg>;
 	bus-width = <4>;
 	/*
 	 * SDCD signal is not being used here - using the fact that GPIO mode
@@ -606,8 +480,6 @@
 
 &dss {
 	status = "ok";
-
-	vdda_video-supply = <&ldo5_reg>;
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index 064b322..4ea2a0c 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -17,17 +17,22 @@
 	};
 };
 
-&tps65917_regulators {
-	ldo2_reg: ldo2 {
-		/* LDO2_OUT --> VDDA_1V8_PHY2 */
-		regulator-name = "ldo2";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-		regulator-boot-on;
+&i2c1 {
+	tps65917: tps65917@58 {
+		reg = <0x58>;
+
+		interrupts = <GIC_SPI 2 IRQ_TYPE_NONE>;  /* IRQ_SYS_1N */
 	};
 };
 
+#include "dra72-evm-tps65917.dtsi"
+
+&ldo2_reg {
+	/* LDO2_OUT --> VDDA_1V8_PHY2 */
+	regulator-always-on;
+	regulator-boot-on;
+};
+
 &hdmi {
 	vdda-supply = <&ldo2_reg>;
 };
diff --git a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
new file mode 100644
index 0000000..ee6dac4
--- /dev/null
+++ b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
@@ -0,0 +1,134 @@
+/*
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Integrated Power Management Chip
+ * http://www.ti.com/lit/ds/symlink/tps65917-q1.pdf
+ */
+
+&tps65917 {
+	compatible = "ti,tps65917";
+
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	ti,system-power-controller;
+
+	tps65917_pmic {
+		compatible = "ti,tps65917-pmic";
+
+		smps1-in-supply = <&vsys_3v3>;
+		smps2-in-supply = <&vsys_3v3>;
+		smps3-in-supply = <&vsys_3v3>;
+		smps4-in-supply = <&vsys_3v3>;
+		smps5-in-supply = <&vsys_3v3>;
+		ldo1-in-supply = <&vsys_3v3>;
+		ldo2-in-supply = <&vsys_3v3>;
+		ldo3-in-supply = <&vsys_3v3>;
+		ldo4-in-supply = <&evm_5v0>;
+		ldo5-in-supply = <&vsys_3v3>;
+
+		tps65917_regulators: regulators {
+			smps1_reg: smps1 {
+				/* VDD_MPU */
+				regulator-name = "smps1";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			smps2_reg: smps2 {
+				/* VDD_CORE */
+				regulator-name = "smps2";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			smps3_reg: smps3 {
+				/* VDD_GPU IVA DSPEVE */
+				regulator-name = "smps3";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			smps4_reg: smps4 {
+				/* VDDS1V8 */
+				regulator-name = "smps4";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			smps5_reg: smps5 {
+				/* VDD_DDR */
+				regulator-name = "smps5";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: ldo1 {
+				/* LDO1_OUT --> SDIO  */
+				regulator-name = "ldo1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-allow-bypass;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-name = "ldo2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-allow-bypass;
+			};
+
+			ldo3_reg: ldo3 {
+				/* VDDA_1V8_PHY */
+				regulator-name = "ldo3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5_reg: ldo5 {
+				/* VDDA_1V8_PLL */
+				regulator-name = "ldo5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo4_reg: ldo4 {
+				/* VDDA_3V_USB: VDDA_USBHS33 */
+				regulator-name = "ldo4";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+			};
+		};
+	};
+
+	tps65917_power_button {
+		compatible = "ti,palmas-pwrbutton";
+		interrupt-parent = <&tps65917>;
+		interrupts = <1 IRQ_TYPE_NONE>;
+		wakeup-source;
+		ti,palmas-long-press-seconds = <6>;
+	};
+};
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index e3a9b69..cd9c4ff 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -15,16 +15,16 @@
 	};
 };
 
-&tps65917_regulators {
-	ldo2_reg: ldo2 {
-		/* LDO2_OUT --> TP1017 (UNUSED)  */
-		regulator-name = "ldo2";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-allow-bypass;
+&i2c1 {
+	tps65917: tps65917@58 {
+		reg = <0x58>;
+
+		interrupts = <GIC_SPI 2 IRQ_TYPE_NONE>;  /* IRQ_SYS_1N */
 	};
 };
 
+#include "dra72-evm-tps65917.dtsi"
+
 &hdmi {
 	vdda-supply = <&ldo3_reg>;
 };
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
