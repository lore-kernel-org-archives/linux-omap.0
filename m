From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/8] arm: dts: omap3: Add cpu_thermal zone
Date: Thu, 9 Mar 2017 13:35:55 +0530
Message-ID: <1489046762-11288-2-git-send-email-j-keerthy@ti.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: tony@atomide.com, edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Add cpu_thermal zone.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/omap34xx.dtsi          |  8 ++++++--
 arch/arm/boot/dts/omap36xx.dtsi          |  8 ++++++--
 3 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-cpu-thermal.dtsi

diff --git a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
new file mode 100644
index 0000000..8dc3aa5
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
@@ -0,0 +1,20 @@
+/*
+ * Device Tree Source for OMAP3 SoC CPU thermal
+ *
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+cpu_thermal: cpu_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <1000>; /* milliseconds */
+	coefficients = <0 20000>;
+
+			/* sensor       ID */
+	thermal-sensors = <&bandgap     0>;
+};
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 834fdf1..ac4f879 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -14,7 +14,7 @@
 
 / {
 	cpus {
-		cpu@0 {
+		cpu: cpu@0 {
 			/* OMAP343x/OMAP35xx variants OPP1-5 */
 			operating-points = <
 				/* kHz    uV */
@@ -56,12 +56,16 @@
 			};
 		};
 
-		bandgap@48002524 {
+		bandgap: bandgap@48002524 {
 			reg = <0x48002524 0x4>;
 			compatible = "ti,omap34xx-bandgap";
 			#thermal-sensor-cells = <0>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		#include "omap3-cpu-thermal.dtsi"
+	};
 };
 
 &ssi {
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index d1a3e56..ade31d7 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -19,7 +19,7 @@
 
 	cpus {
 		/* OMAP3630/OMAP37xx 'standard device' variants OPP50 to OPP130 */
-		cpu@0 {
+		cpu: cpu@0 {
 			operating-points = <
 				/* kHz    uV */
 				300000  1012500
@@ -88,12 +88,16 @@
 			};
 		};
 
-		bandgap@48002524 {
+		bandgap: bandgap@48002524 {
 			reg = <0x48002524 0x4>;
 			compatible = "ti,omap36xx-bandgap";
 			#thermal-sensor-cells = <0>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		#include "omap3-cpu-thermal.dtsi"
+	};
 };
 
 /* OMAP3630 needs dss_96m_fck for VENC */
-- 
1.9.1
