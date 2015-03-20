From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] ARM: dts: DRA7: Add bandgap and related thermal nodes
Date: Fri, 20 Mar 2015 14:47:40 -0500
Message-ID: <1426880861-9266-3-git-send-email-nm@ti.com>
References: <1426880861-9266-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426880861-9266-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

Add bandgap and related thermal nodes. The patch adds 5 thermal
sensors. Only one cooling device for mpu as of now. The sensors are
the exact same on both dra72 and dra7.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi   |   12 ++++++++++++
 arch/arm/boot/dts/dra72x.dtsi |    9 +++++++++
 arch/arm/boot/dts/dra74x.dtsi |    9 +++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index eea4a54d6cb3..4b975cc377fd 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -177,6 +177,18 @@
 			};
 		};
 
+		bandgap: bandgap@4a0021e0 {
+			reg = <0x4a0021e0 0xc
+				0x4a00232c 0xc
+				0x4a002380 0x2c
+				0x4a0023C0 0x3c
+				0x4a002564 0x8
+				0x4a002574 0x50>;
+				compatible = "ti,dra752-bandgap";
+				interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+				#thermal-sensor-cells = <1>;
+		};
+
 		cm_core_aon: cm_core_aon@4a005000 {
 			compatible = "ti,dra7-cm-core-aon";
 			reg = <0x4a005000 0x2000>;
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index e5a3d23a3df1..43bd0709bde9 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -20,6 +20,11 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <2>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
@@ -27,4 +32,8 @@
 		compatible = "arm,cortex-a15-pmu";
 		interrupts = <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	thermal_zones: thermal-zones {
+		#include "omap5-cpu-thermal.dtsi"
+	};
 };
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 10173fab1a15..4f2c870836fe 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -31,6 +31,11 @@
 			clock-names = "cpu";
 
 			clock-latency = <300000>; /* From omap-cpufreq driver */
+
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <2>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 		cpu@1 {
 			device_type = "cpu";
@@ -45,6 +50,10 @@
 			     <GIC_SPI DIRECT_IRQ(132) IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	thermal_zones: thermal-zones {
+		#include "omap5-cpu-thermal.dtsi"
+	};
+
 	ocp {
 		omap_dwc3_4: omap_dwc3_4@48940000 {
 			compatible = "ti,dwc3";
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
