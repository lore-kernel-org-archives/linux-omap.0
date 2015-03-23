From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 2/2] ARM: dts: am57xx-beagle-x15: Add thermal map to include fan and tmp102
Date: Mon, 23 Mar 2015 14:39:39 -0500
Message-ID: <1427139579-4215-3-git-send-email-nm@ti.com>
References: <1427139579-4215-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427139579-4215-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com, edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com, t-kristo@ti.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

BeagleBoard-X15 has capability for a fan and has an onboard TMP102
temperature sensor as well. This allows us to create a new thermal
zone (called, un-imaginatively "board"), and allows us to use some
active cooling as temperatures start edge upward in the system by
creating a new alert temperature (emperically 50C) for cpu.

NOTE: Fan is NOT mounted by default on the platform, in such a case,
all we end up doing is switch on a regulator and leak very minimal
current.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
	- slight change in omap4-cpu-thermal for usage in am57xx-dtsi
	- Not carrying forward ack due to change

V1: http://marc.info/?t=142688102700004&r=1&w=2

 arch/arm/boot/dts/am57xx-beagle-x15.dts  |   49 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi |    4 +--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 41642fe770a1..6a3621c23017 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -86,6 +86,7 @@
 		gpios =  <&tps659038_gpio 1 GPIO_ACTIVE_HIGH>;
 		gpio-fan,speed-map = <0     0>,
 				     <13000 1>;
+		#cooling-cells = <2>;
 	};
 
 	extcon_usb1: extcon_usb1 {
@@ -441,6 +442,7 @@
 		pinctrl-0 = <&tmp102_pins_default>;
 		interrupt-parent = <&gpio7>;
 		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+		#thermal-sensor-cells = <1>;
 	};
 };
 
@@ -559,3 +561,50 @@
 &usb2 {
 	dr_mode = "peripheral";
 };
+
+&cpu_trips {
+	cpu_alert1: cpu_alert1 {
+		temperature = <50000>; /* millicelsius */
+		hysteresis = <2000>; /* millicelsius */
+		type = "active";
+	};
+};
+
+&cpu_cooling_maps {
+	map1 {
+		trip = <&cpu_alert1>;
+		cooling-device = <&gpio_fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+	};
+};
+
+&thermal_zones {
+	board_thermal: board_thermal {
+		polling-delay-passive = <1250>; /* milliseconds */
+		polling-delay = <1500>; /* milliseconds */
+
+				/* sensor       ID */
+		thermal-sensors = <&tmp102     0>;
+
+		board_trips: trips {
+			board_alert0: board_alert {
+				temperature = <40000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "active";
+			};
+
+			board_crit: board_crit {
+				temperature = <105000>; /* millicelsius */
+				hysteresis = <0>; /* millicelsius */
+				type = "critical";
+			};
+		};
+
+		board_cooling_maps: cooling-maps {
+			map0 {
+				trip = <&board_alert0>;
+				cooling-device =
+				  <&gpio_fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+       };
+};
diff --git a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
index cb9458feb2e3..ab7f87ae96f0 100644
--- a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
@@ -18,7 +18,7 @@ cpu_thermal: cpu_thermal {
 			/* sensor       ID */
         thermal-sensors = <&bandgap     0>;
 
-        trips {
+	cpu_trips: trips {
                 cpu_alert0: cpu_alert {
                         temperature = <100000>; /* millicelsius */
                         hysteresis = <2000>; /* millicelsius */
@@ -31,7 +31,7 @@ cpu_thermal: cpu_thermal {
                 };
         };
 
-	cooling-maps {
+	cpu_cooling_maps: cooling-maps {
 		map0 {
 			trip = <&cpu_alert0>;
 			cooling-device =
-- 
1.7.9.5
