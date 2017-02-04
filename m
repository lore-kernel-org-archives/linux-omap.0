From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] ARM: dts: Configure regulators for droid 4
Date: Sat,  4 Feb 2017 12:17:22 -0800
Message-ID: <20170204201722.1544-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

With drivers/mfd/motorola-cpcap.c and drivers/regulator/cpcap-regulator.c
we can now configure proper regulators for droid 4.

Let's add regulator voltages and switch over MMC, eMMC and WLAN to use
the CPCAP regulators.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 151 +++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-droid4-xt894.dts       |  25 +---
 2 files changed, 155 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
new file mode 100644
--- /dev/null
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -0,0 +1,151 @@
+/*
+ * Common CPCAP configuration used on Motorola phones
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&mcspi1 {
+	cpcap: pmic@0 {
+		compatible = "motorola,cpcap", "st,6556002";
+		reg = <0>;	/* cs0 */
+		interrupt-parent = <&gpio1>;
+		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		spi-max-frequency = <3000000>;
+		spi-cs-high;
+
+		cpcap_regulator: regulator {
+			compatible = "motorola,mapphone-cpcap-regulator";
+
+			cpcap_regulators: regulators {
+			};
+		};
+	};
+};
+
+&cpcap_regulators {
+	sw5: SW5 {
+		regulator-min-microvolt = <5050000>;
+		regulator-max-microvolt = <5050000>;
+		regulator-enable-ramp-delay = <50000>;
+		regulator-boot-on;
+	};
+
+	vcam: VCAM {
+		regulator-min-microvolt = <2900000>;
+		regulator-max-microvolt = <2900000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	/* Used by DSS */
+	vcsi: VCSI {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-enable-ramp-delay = <1000>;
+		regulator-boot-on;
+	};
+
+	vdac: VDAC {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	vdig: VDIG {
+		regulator-min-microvolt = <1875000>;
+		regulator-max-microvolt = <1875000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	vfuse: VFUSE {
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <3150000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	vhvio: VHVIO {
+		regulator-min-microvolt = <2775000>;
+		regulator-max-microvolt = <2775000>;
+		regulator-enable-ramp-delay = <1000>;
+		regulator-always-on;
+	};
+
+	/* Used by eMMC at mmc2 */
+	vsdio: VSDIO {
+		regulator-min-microvolt = <2900000>;
+		regulator-max-microvolt = <2900000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	vpll: VPLL {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-enable-ramp-delay = <100>;
+	};
+
+	vrf1: VRF1 {
+		regulator-min-microvolt = <2775000>;
+		regulator-max-microvolt = <2775000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	vrf2: VRF2 {
+		regulator-min-microvolt = <2775000>;
+		regulator-max-microvolt = <2775000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	vrfref: VRFREF {
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2775000>;
+		regulator-enable-ramp-delay = <100>;
+	};
+
+	vwlan1: VWLAN1 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1900000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	vwlan2: VWLAN2 {
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	vsim: VSIM {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2900000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	/* Used by micro-SDIO at mmc1 */
+	vsimcard: VSIMCARD {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2900000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	vvib: VVIB {
+		regulator-min-microvolt = <1300000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-enable-ramp-delay = <500>;
+	};
+
+	vusb: VUSB {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	vaudio: VAUDIO {
+		regulator-min-microvolt = <2775000>;
+		regulator-max-microvolt = <2775000>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+};
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/input/input.h>
 #include "omap443x.dtsi"
+#include "motorola-cpcap-mapphone.dtsi"
 
 / {
 	model = "Motorola Droid 4 XT894";
@@ -26,25 +27,7 @@
 		reg = <0x80000000 0x3fd00000>;	/* 1021 MB */
 	};
 
-	/* CPCAP really supports 1650000 to 3400000 range */
-	vmmc: regulator-mmc {
-		compatible = "regulator-fixed";
-		regulator-name = "vmmc";
-		regulator-min-microvolt = <3000000>;
-		regulator-max-microvolt = <3000000>;
-		regulator-always-on;
-	};
-
-	/* CPCAP really supports 3000000 to 3100000 range */
-	vemmc: regulator-emmc {
-		compatible = "regulator-fixed";
-		regulator-name = "vemmc";
-		regulator-min-microvolt = <3000000>;
-		regulator-max-microvolt = <3000000>;
-		regulator-always-on;
-	};
-
-	/* CPCAP really supports 1650000 to 1950000 range */
+	/* This is probably coming straight from the battery.. */
 	wl12xx_vmmc: regulator-wl12xx {
 		compatible = "regulator-fixed";
 		regulator-name = "vwl1271";
@@ -136,13 +119,13 @@
 };
 
 &mmc1 {
-	vmmc-supply = <&vmmc>;
+	vmmc-supply = <&vsimcard>;
 	bus-width = <4>;
 	cd-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;	/* gpio106 */
 };
 
 &mmc2 {
-	vmmc-supply = <&vemmc>;
+	vmmc-supply = <&vsdio>;
 	bus-width = <8>;
 	non-removable;
 };
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
