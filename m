From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/3] ARM: dts: OMAP5+: separate the cpu thermal zone definition from omap4
Date: Fri, 20 Mar 2015 14:47:39 -0500
Message-ID: <1426880861-9266-2-git-send-email-nm@ti.com>
References: <1426880861-9266-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426880861-9266-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

OMAP4 has a finer counter granularity, which allows for a delay of 1000ms
in the thermal zone polling intervals. OMAP5/DRA7 have different counter
mechanism, which allows at maximum a 500ms timer. Adjust the cpu thermal
zone accordingly for OMAP5/DRA7.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5-cpu-thermal.dtsi |   41 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi             |    2 +-
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/omap5-cpu-thermal.dtsi

diff --git a/arch/arm/boot/dts/omap5-cpu-thermal.dtsi b/arch/arm/boot/dts/omap5-cpu-thermal.dtsi
new file mode 100644
index 000000000000..4a6427c1e47e
--- /dev/null
+++ b/arch/arm/boot/dts/omap5-cpu-thermal.dtsi
@@ -0,0 +1,41 @@
+/*
+ * Device Tree Source for OMAP4/5 SoC CPU thermal
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Contact: Tero Kristo <t-kristo@ti.com>
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
+	polling-delay = <500>; /* milliseconds */
+
+			/* sensor       ID */
+	thermal-sensors = <&bandgap     0>;
+
+	cpu_trips: trips {
+		cpu_alert0: cpu_alert {
+			temperature = <100000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
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
+			cooling-device =
+				<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index ddff674bd05e..e650d4eb59dd 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -67,7 +67,7 @@
 	};
 
 	thermal-zones {
-		#include "omap4-cpu-thermal.dtsi"
+		#include "omap5-cpu-thermal.dtsi"
 		#include "omap5-gpu-thermal.dtsi"
 		#include "omap5-core-thermal.dtsi"
 	};
-- 
1.7.9.5
