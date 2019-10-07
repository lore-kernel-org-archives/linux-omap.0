From: Adam Ford <aford173@gmail.com>
Subject: [PATCH 2/2] ARM: dts: omap3: Add cpu trips and cooling map for omap34/36 families
Date: Mon,  7 Oct 2019 17:05:40 -0500
Message-ID: <20191007220540.30690-2-aford173@gmail.com>
References: <20191007220540.30690-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007220540.30690-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: adam.ford@logicpd.com, hns@goldelico.com, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The OMAP3530, OMAP3630, and DM3730 all show thresholds of 90C and 105C
depending on commercial or industrial temperature ratings.

This patch expands the thermal information to include the limits of 90
and 105C for alert and critical.  It sets the coolings-cells for the
34xx and 36xx CPU's which both point to omap3-cpu-thermal.dtsi.

For boards who never use industrial temperatures, these can be
changed on their respective device trees with something like:

&cpu_alert0 {
	temperature = <85000>; /* millicelsius */
};

&cpu_crit {
	temperature = <90000>; /* millicelsius */
};

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # on GTA04A5 with dm3730cbp100

diff --git a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
index 235ecfd61e2d..dfbd0cb0b00b 100644
--- a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
@@ -17,4 +17,25 @@ cpu_thermal: cpu_thermal {
 
 			/* sensor       ID */
 	thermal-sensors = <&bandgap     0>;
+
+	cpu_trips: trips {
+		cpu_alert0: cpu_alert {
+			temperature = <90000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu_crit: cpu_crit {
+			temperature = <105000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cpu_cooling_maps: cooling-maps {
+		map0 {
+			trip = <&cpu_alert0>;
+			cooling-device =
+				<&cpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 7b09cbee8bb8..99a7161bebb2 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -26,6 +26,7 @@
 				600000  1350000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
+			#cooling-cells = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 1e552f08f120..8096b6ef0ae1 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -28,6 +28,7 @@
 				800000  1325000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.17.1
