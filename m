From: Adam Ford <aford173@gmail.com>
Subject: [RFC v2 2/2] ARM: omap3: Consolidate thermal references to common omap3
Date: Fri, 13 Sep 2019 10:37:14 -0500
Message-ID: <20190913153714.30980-2-aford173@gmail.com>
References: <20190913153714.30980-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913153714.30980-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: adam.ford@logicpd.com, nm@ti.com, hns@goldelico.com, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Because the omap34xx, omap36xx and am3517 SoC's have the same
thermal junction limits, there is no need to duplicate the entry
multiple times.

This patch removes the thermal references from omap36xx and
omap34xx and pushes it into the common omap3.dtsi file with
the added benefit of enabling the thermal info on the AM3517.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:	Add node name for cpu and add cooling-cells entry

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 4043ecb38016..84704eb3b604 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -32,7 +32,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu: cpu@0 {
 			compatible = "arm,cortex-a8";
 			device_type = "cpu";
 			reg = <0x0>;
@@ -41,9 +41,14 @@
 			clock-names = "cpu";
 
 			clock-latency = <300000>; /* From omap-cpufreq driver */
+			#cooling-cells = <2>;
 		};
 	};
 
+	thermal_zones: thermal-zones {
+		#include "omap3-cpu-thermal.dtsi"
+	};
+
 	pmu@54000000 {
 		compatible = "arm,cortex-a8-pmu";
 		reg = <0x54000000 0x800000>;
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index f572a477f74c..b80378d6e5c1 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -101,10 +101,6 @@
 			};
 		};
 	};
-
-	thermal_zones: thermal-zones {
-		#include "omap3-cpu-thermal.dtsi"
-	};
 };
 
 &ssi {
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 6fb23ada1f64..ff2dca63a04e 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -140,10 +140,6 @@
 			};
 		};
 	};
-
-	thermal_zones: thermal-zones {
-		#include "omap3-cpu-thermal.dtsi"
-	};
 };
 
 /* OMAP3630 needs dss_96m_fck for VENC */
-- 
2.17.1
