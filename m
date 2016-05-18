From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 7/8] ARM: dts: dra7: Move cpus node to parent dts for dra74x and dra72x
Date: Wed, 18 May 2016 18:36:32 -0500
Message-ID: <282afe5e02c165dfd6d5de7d7480a8854cfe16a8.1463606963.git.d-gerlach@ti.com>
References: <cover.1463606963.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1463606963.git.d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Yegor Yefremov <yegorslists@googlemail.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Nearly all of the information in the cpus node, especially for cpu0, is
the same between dra74x and dra72x so move the common information to
the parent dra7.dtsi to avoid duplication of data.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi   | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72x.dtsi | 16 ----------------
 arch/arm/boot/dts/dra74x.dtsi | 24 ------------------------
 3 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 406f6ff21d7f..104b62657163 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -73,6 +73,33 @@
 		interrupt-parent = <&gic>;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+
+			operating-points = <
+				/* kHz    uV */
+				1000000	1060000
+				1176000	1160000
+				>;
+
+			clocks = <&dpll_mpu_ck>;
+			clock-names = "cpu";
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
+
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <2>;
+			#cooling-cells = <2>; /* min followed by max */
+		};
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index 70a217050a4c..67107605fb4c 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -12,22 +12,6 @@
 / {
 	compatible = "ti,dra722", "ti,dra72", "ti,dra7";
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0>;
-
-			/* cooling options */
-			cooling-min-level = <0>;
-			cooling-max-level = <2>;
-			#cooling-cells = <2>; /* min followed by max */
-		};
-	};
-
 	pmu {
 		compatible = "arm,cortex-a15-pmu";
 		interrupt-parent = <&wakeupgen>;
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 4220eeffc65a..0c31db3a8919 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -13,30 +13,6 @@
 	compatible = "ti,dra742", "ti,dra74", "ti,dra7";
 
 	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0>;
-
-			operating-points = <
-				/* kHz    uV */
-				1000000	1060000
-				1176000	1160000
-				>;
-
-			clocks = <&dpll_mpu_ck>;
-			clock-names = "cpu";
-
-			clock-latency = <300000>; /* From omap-cpufreq driver */
-
-			/* cooling options */
-			cooling-min-level = <0>;
-			cooling-max-level = <2>;
-			#cooling-cells = <2>; /* min followed by max */
-		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
-- 
2.7.3

