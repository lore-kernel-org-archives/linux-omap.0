From: Adam Ford <aford173@gmail.com>
Subject: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Thu, 12 Sep 2019 13:30:37 -0500
Message-ID: <20190912183037.18449-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hns@goldelico.com, tony@atomide.com, neolynx@gmail.com, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, andreas@kemnade.info, nm@ti.com, adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>
List-Id: linux-omap@vger.kernel.org

The thermal sensor in the omap3 family isn't accurate, but it's
better than nothing.  The various OPP's enabled for the omap3630
support up to OPP1G, however the datasheet for the DM3730 states
that OPP130 and OPP1G are not available above TJ of 90C.

This patch configures the thermal throttling to limit the
operating points of the omap3630 to Only OPP50 and OPP100 if
the thermal sensor reads a value above 90C.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 4bb4f534afe2..58b9d347019f 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -25,6 +25,7 @@
 
 			vbb-supply = <&abb_mpu_iva>;
 			clock-latency = <300000>; /* From omap-cpufreq driver */
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -195,6 +196,31 @@
 	};
 };
 
+&cpu_thermal {
+	cpu_trips: trips {
+		/* OPP130 and OPP1G are not available above TJ of 90C. */
+		cpu_alert0: cpu_alert {
+			temperature = <90000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+
+		cpu_crit: cpu_crit {
+			temperature = <125000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cpu_cooling_maps: cooling-maps {
+		map0 {
+			trip = <&cpu_alert0>;
+			/* Only allow OPP50 and OPP100 */
+			cooling-device = <&cpu 0 1>;
+		};
+	};
+};
+
 /* OMAP3630 needs dss_96m_fck for VENC */
 &venc {
 	clocks = <&dss_tv_fck>, <&dss_96m_fck>;
-- 
2.17.1
