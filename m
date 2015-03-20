From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/3] ARM: dts: am57xx-beagle-x15: Add thermal map
Date: Fri, 20 Mar 2015 14:47:41 -0500
Message-ID: <1426880861-9266-4-git-send-email-nm@ti.com>
References: <1426880861-9266-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41478 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbbCTTsM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 15:48:12 -0400
In-Reply-To: <1426880861-9266-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

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
 arch/arm/boot/dts/am57xx-beagle-x15.dts |   49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

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
-- 
1.7.9.5

