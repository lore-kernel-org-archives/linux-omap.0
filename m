From: Adam Ford <aford173@gmail.com>
Subject: [RFC 1/2] ARM: dts: omap3: Add cpu trips and cooling map for omap3 family
Date: Fri, 13 Sep 2019 10:04:08 -0500
Message-ID: <20190913150410.27391-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: adam.ford@logicpd.com, nm@ti.com, hns@goldelico.com, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The OMAP3530, AM3517 and DM3730 all show thresholds of 90C and 105C
depending on commercial or industrial temperature ratings.  This
patch expands the thermal information to the limits of 90 and 105
for alert and critical.

For boards who never use industrial temperatures, these can be
changed on their respective device trees with something like:

&cpu_alert0 {
	temperature = <85000>; /* millicelsius */
};

&cpu_crit {
	temperature = <90000>; /* millicelsius */
};

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
index 235ecfd61e2d..11452590ea85 100644
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
+				<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
 };
-- 
2.17.1
