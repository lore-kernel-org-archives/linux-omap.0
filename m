From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 4/8] ARM: dts: am4372: Add operating-points-v2 table
Date: Wed, 18 May 2016 18:36:29 -0500
Message-ID: <ac373ad0594ce79516614d52fef59b76fbea4563.1463606963.git.d-gerlach@ti.com>
References: <cover.1463606963.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1463606963.git.d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Yegor Yefremov <yegorslists@googlemail.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add an operating-points-v2 table with all OPPs available for all silicon
revisions along with necessary data for use by ti-cpufreq to selectively
enable the appropriate OPPs at runtime.

Information from AM437x Data Manual, SPRS851B, Revised April 2015,
Table 5-2.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 12fcde4d4d2e..8bf2db276128 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -44,10 +44,49 @@
 			clocks = <&dpll_mpu_ck>;
 			clock-names = "cpu";
 
+			operating-points-v2 = <&cpu0_opp_table>;
+			ti,syscon-efuse = <&scm_conf 0x610 0x3f 0>;
+			ti,syscon-rev = <&scm_conf 0x600>;
+
 			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp50@300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <950000 931000 969000>;
+			opp-supported-hw = <0xFF 0x01>;
+			opp-suspend;
+		};
+
+		opp100@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1100000 1078000 1122000>;
+			opp-supported-hw = <0xFF 0x04>;
+		};
+
+		opp120@720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1200000 1176000 1224000>;
+			opp-supported-hw = <0xFF 0x08>;
+		};
+
+		oppturbo@800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1260000 1234800 1285200>;
+			opp-supported-hw = <0xFF 0x10>;
+		};
+
+		oppnitro@1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1325000 1298500 1351500>;
+			opp-supported-hw = <0xFF 0x20>;
+		};
+	};
+
 	gic: interrupt-controller@48241000 {
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
-- 
2.7.3

