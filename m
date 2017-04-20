From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 2/7] ARM: TI: Use - instead of @ for DT OPP entries
Date: Thu, 20 Apr 2017 16:25:06 +0530
Message-ID: <5f0656140309d53a45058c048ca059c4ba294756.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Compiling the DT file with W=1, DTC warns like follows:

Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
unit name, but no reg property

Fix this by replacing '@' with '-' as the OPP nodes will never have a
"reg" property.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/cpufreq/ti-cpufreq.txt       | 20 ++++++++++----------
 arch/arm/boot/dts/am335x-boneblack.dts               |  2 +-
 arch/arm/boot/dts/am33xx.dtsi                        | 20 ++++++++++----------
 arch/arm/boot/dts/am4372.dtsi                        | 10 +++++-----
 arch/arm/boot/dts/dra7.dtsi                          |  4 ++--
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
index ba0e15ad5bd9..0c38e4b8fc51 100644
--- a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
+++ b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
@@ -63,64 +63,64 @@ cpu0_opp_table: opp-table {
 	 * because they can not be enabled simultaneously on a
 	 * single SoC.
 	 */
-	opp50@300000000 {
+	opp50-300000000 {
 		opp-hz = /bits/ 64 <300000000>;
 		opp-microvolt = <950000 931000 969000>;
 		opp-supported-hw = <0x06 0x0010>;
 		opp-suspend;
 	};
 
-	opp100@275000000 {
+	opp100-275000000 {
 		opp-hz = /bits/ 64 <275000000>;
 		opp-microvolt = <1100000 1078000 1122000>;
 		opp-supported-hw = <0x01 0x00FF>;
 		opp-suspend;
 	};
 
-	opp100@300000000 {
+	opp100-300000000 {
 		opp-hz = /bits/ 64 <300000000>;
 		opp-microvolt = <1100000 1078000 1122000>;
 		opp-supported-hw = <0x06 0x0020>;
 		opp-suspend;
 	};
 
-	opp100@500000000 {
+	opp100-500000000 {
 		opp-hz = /bits/ 64 <500000000>;
 		opp-microvolt = <1100000 1078000 1122000>;
 		opp-supported-hw = <0x01 0xFFFF>;
 	};
 
-	opp100@600000000 {
+	opp100-600000000 {
 		opp-hz = /bits/ 64 <600000000>;
 		opp-microvolt = <1100000 1078000 1122000>;
 		opp-supported-hw = <0x06 0x0040>;
 	};
 
-	opp120@600000000 {
+	opp120-600000000 {
 		opp-hz = /bits/ 64 <600000000>;
 		opp-microvolt = <1200000 1176000 1224000>;
 		opp-supported-hw = <0x01 0xFFFF>;
 	};
 
-	opp120@720000000 {
+	opp120-720000000 {
 		opp-hz = /bits/ 64 <720000000>;
 		opp-microvolt = <1200000 1176000 1224000>;
 		opp-supported-hw = <0x06 0x0080>;
 	};
 
-	oppturbo@720000000 {
+	oppturbo-720000000 {
 		opp-hz = /bits/ 64 <720000000>;
 		opp-microvolt = <1260000 1234800 1285200>;
 		opp-supported-hw = <0x01 0xFFFF>;
 	};
 
-	oppturbo@800000000 {
+	oppturbo-800000000 {
 		opp-hz = /bits/ 64 <800000000>;
 		opp-microvolt = <1260000 1234800 1285200>;
 		opp-supported-hw = <0x06 0x0100>;
 	};
 
-	oppnitro@1000000000 {
+	oppnitro-1000000000 {
 		opp-hz = /bits/ 64 <1000000000>;
 		opp-microvolt = <1325000 1298500 1351500>;
 		opp-supported-hw = <0x04 0x0200>;
diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 935ed17d22e4..d154d3133c16 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -22,7 +22,7 @@
 	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
 	 * to support 1GHz OPP so enable it for PG 2.0 on this board.
 	 */
-	oppnitro@1000000000 {
+	oppnitro-1000000000 {
 		opp-supported-hw = <0x06 0x0100>;
 	};
 };
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9e242943dcec..bdacb3dd689c 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -64,64 +64,64 @@
 		 * because the can not be enabled simultaneously on a
 		 * single SoC.
 		 */
-		opp50@300000000 {
+		opp50-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <950000 931000 969000>;
 			opp-supported-hw = <0x06 0x0010>;
 			opp-suspend;
 		};
 
-		opp100@275000000 {
+		opp100-275000000 {
 			opp-hz = /bits/ 64 <275000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
 			opp-supported-hw = <0x01 0x00FF>;
 			opp-suspend;
 		};
 
-		opp100@300000000 {
+		opp100-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
 			opp-supported-hw = <0x06 0x0020>;
 			opp-suspend;
 		};
 
-		opp100@500000000 {
+		opp100-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
 			opp-supported-hw = <0x01 0xFFFF>;
 		};
 
-		opp100@600000000 {
+		opp100-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
 			opp-supported-hw = <0x06 0x0040>;
 		};
 
-		opp120@600000000 {
+		opp120-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1200000 1176000 1224000>;
 			opp-supported-hw = <0x01 0xFFFF>;
 		};
 
-		opp120@720000000 {
+		opp120-720000000 {
 			opp-hz = /bits/ 64 <720000000>;
 			opp-microvolt = <1200000 1176000 1224000>;
 			opp-supported-hw = <0x06 0x0080>;
 		};
 
-		oppturbo@720000000 {
+		oppturbo-720000000 {
 			opp-hz = /bits/ 64 <720000000>;
 			opp-microvolt = <1260000 1234800 1285200>;
 			opp-supported-hw = <0x01 0xFFFF>;
 		};
 
-		oppturbo@800000000 {
+		oppturbo-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1260000 1234800 1285200>;
 			opp-supported-hw = <0x06 0x0100>;
 		};
 
-		oppnitro@1000000000 {
+		oppnitro-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1325000 1298500 1351500>;
 			opp-supported-hw = <0x04 0x0200>;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 176e09e9a45e..e5b061469bf8 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -59,32 +59,32 @@
 		compatible = "operating-points-v2-ti-cpu";
 		syscon = <&scm_conf>;
 
-		opp50@300000000 {
+		opp50-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <950000 931000 969000>;
 			opp-supported-hw = <0xFF 0x01>;
 			opp-suspend;
 		};
 
-		opp100@600000000 {
+		opp100-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1100000 1078000 1122000>;
 			opp-supported-hw = <0xFF 0x04>;
 		};
 
-		opp120@720000000 {
+		opp120-720000000 {
 			opp-hz = /bits/ 64 <720000000>;
 			opp-microvolt = <1200000 1176000 1224000>;
 			opp-supported-hw = <0xFF 0x08>;
 		};
 
-		oppturbo@800000000 {
+		oppturbo-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1260000 1234800 1285200>;
 			opp-supported-hw = <0xFF 0x10>;
 		};
 
-		oppnitro@1000000000 {
+		oppnitro-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1325000 1298500 1351500>;
 			opp-supported-hw = <0xFF 0x20>;
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 57892f264cea..25908dd338ee 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -99,14 +99,14 @@
 		compatible = "operating-points-v2-ti-cpu";
 		syscon = <&scm_wkup>;
 
-		opp_nom@1000000000 {
+		opp_nom-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1060000 850000 1150000>;
 			opp-supported-hw = <0xFF 0x01>;
 			opp-suspend;
 		};
 
-		opp_od@1176000000 {
+		opp_od-1176000000 {
 			opp-hz = /bits/ 64 <1176000000>;
 			opp-microvolt = <1160000 885000 1160000>;
 			opp-supported-hw = <0xFF 0x02>;
-- 
2.12.0.432.g71c3a4f4ba37
