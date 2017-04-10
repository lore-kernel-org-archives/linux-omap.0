From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] PM / OPP: Use - instead of @ for DT entries
Date: Mon, 10 Apr 2017 14:51:35 +0530
Message-ID: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> (sunxi)
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
V2:
- Added more *-by tags.
- Included TI DT and example files as well.

 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 20 +++----
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
 Documentation/devicetree/bindings/opp/opp.txt      | 38 ++++++-------
 arch/arm/boot/dts/am4372.dtsi                      | 10 ++--
 arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
 arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
 arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
 arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
 arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
 arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
 arch/arm/boot/dts/pxa25x.dtsi                      |  8 +--
 arch/arm/boot/dts/pxa27x.dtsi                      | 14 ++---
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  8 +--
 arch/arm/boot/dts/uniphier-pro5.dtsi               | 32 +++++------
 arch/arm/boot/dts/uniphier-pxs2.dtsi               | 16 +++---
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 48 ++++++++--------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 50 ++++++++--------
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 14 ++---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 32 +++++------
 arch/arm64/boot/dts/zte/zx296718.dtsi              | 10 ++--
 20 files changed, 295 insertions(+), 295 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index d085ef90d27c..f8e946471a58 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -202,23 +202,23 @@ is able to support the bus frequency for all Exynos SoCs.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 			opp-microvolt = <800000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <800000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <800000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <825000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <875000>;
 		};
@@ -292,23 +292,23 @@ is able to support the bus frequency for all Exynos SoCs.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@80000000 {
+		opp-80000000 {
 			opp-hz = /bits/ 64 <80000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <1000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <1000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <1000000>;
 		};
@@ -318,19 +318,19 @@ is able to support the bus frequency for all Exynos SoCs.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 		};
-		opp@80000000 {
+		opp-80000000 {
 			opp-hz = /bits/ 64 <80000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 		};
 	};
@@ -339,19 +339,19 @@ is able to support the bus frequency for all Exynos SoCs.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 		};
-		opp@80000000 {
+		opp-80000000 {
 			opp-hz = /bits/ 64 <80000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
-		opp@300000000 {
+		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 		};
 	};
@@ -360,13 +360,13 @@ is able to support the bus frequency for all Exynos SoCs.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 		};
-		opp@80000000 {
+		opp-80000000 {
 			opp-hz = /bits/ 64 <80000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 63725498bd20..e36d261b9ba6 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -186,20 +186,20 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			clock-latency-ns = <290000>;
@@ -265,20 +265,20 @@ independently.
 		 * independently.
 		 */
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			opp-microamp = <90000;
@@ -341,20 +341,20 @@ DVFS state together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>;
 			opp-microamp = <70000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1000000 980000 1010000>;
 			opp-microamp = <80000>;
 			clock-latency-ns = <310000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1025000>;
 			opp-microamp = <90000>;
@@ -367,20 +367,20 @@ DVFS state together.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1300000000 {
+		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1050000 1045000 1055000>;
 			opp-microamp = <95000>;
 			clock-latency-ns = <400000>;
 			opp-suspend;
 		};
-		opp@1400000000 {
+		opp-1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
 			opp-microvolt = <1075000>;
 			opp-microamp = <100000>;
 			clock-latency-ns = <400000>;
 		};
-		opp@1500000000 {
+		opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1100000 1010000 1110000>;
 			opp-microamp = <95000>;
@@ -409,7 +409,7 @@ Example 4: Handling multiple regulators
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000>, /* Supply 0 */
 					<960000>, /* Supply 1 */
@@ -422,7 +422,7 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>, /* Supply 0 */
 					<965000 960000 975000>, /* Supply 1 */
@@ -435,7 +435,7 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000 970000 985000>, /* Supply 0 */
 					<965000 960000 975000>, /* Supply 1 */
@@ -467,7 +467,7 @@ Example 5: opp-supported-hw
 		status = "okay";
 		opp-shared;
 
-		opp@600000000 {
+		opp-600000000 {
 			/*
 			 * Supports all substrate and process versions for 0xF
 			 * cuts, i.e. only first four cuts.
@@ -478,7 +478,7 @@ Example 5: opp-supported-hw
 			...
 		};
 
-		opp@800000000 {
+		opp-800000000 {
 			/*
 			 * Supports:
 			 * - cuts: only one, 6th cut (represented by 6th bit).
@@ -510,7 +510,7 @@ Example 5: opp-supported-hw
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt-slow = <915000 900000 925000>;
 			opp-microvolt-fast = <975000 970000 985000>;
@@ -518,7 +518,7 @@ Example 5: opp-supported-hw
 			opp-microamp-fast =  <71000>;
 		};
 
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt-slow = <915000 900000 925000>, /* Supply vcc0 */
 					      <925000 910000 935000>; /* Supply vcc1 */
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 97fcaf415de1..1532ffe1de63 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -60,32 +60,32 @@
 	cpu0_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
 
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
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 9c28ef4508e0..590ee442d0ae 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -745,23 +745,23 @@
 			compatible = "operating-points-v2";
 			opp-shared;
 
-			opp@50000000 {
+			opp-50000000 {
 				opp-hz = /bits/ 64 <50000000>;
 				opp-microvolt = <800000>;
 			};
-			opp@100000000 {
+			opp-100000000 {
 				opp-hz = /bits/ 64 <100000000>;
 				opp-microvolt = <800000>;
 			};
-			opp@134000000 {
+			opp-134000000 {
 				opp-hz = /bits/ 64 <134000000>;
 				opp-microvolt = <800000>;
 			};
-			opp@200000000 {
+			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 				opp-microvolt = <825000>;
 			};
-			opp@400000000 {
+			opp-400000000 {
 				opp-hz = /bits/ 64 <400000000>;
 				opp-microvolt = <875000>;
 			};
@@ -835,23 +835,23 @@
 			compatible = "operating-points-v2";
 			opp-shared;
 
-			opp@50000000 {
+			opp-50000000 {
 				opp-hz = /bits/ 64 <50000000>;
 				opp-microvolt = <900000>;
 			};
-			opp@80000000 {
+			opp-80000000 {
 				opp-hz = /bits/ 64 <80000000>;
 				opp-microvolt = <900000>;
 			};
-			opp@100000000 {
+			opp-100000000 {
 				opp-hz = /bits/ 64 <100000000>;
 				opp-microvolt = <1000000>;
 			};
-			opp@134000000 {
+			opp-134000000 {
 				opp-hz = /bits/ 64 <134000000>;
 				opp-microvolt = <1000000>;
 			};
-			opp@200000000 {
+			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 				opp-microvolt = <1000000>;
 			};
@@ -861,19 +861,19 @@
 			compatible = "operating-points-v2";
 			opp-shared;
 
-			opp@50000000 {
+			opp-50000000 {
 				opp-hz = /bits/ 64 <50000000>;
 			};
-			opp@80000000 {
+			opp-80000000 {
 				opp-hz = /bits/ 64 <80000000>;
 			};
-			opp@100000000 {
+			opp-100000000 {
 				opp-hz = /bits/ 64 <100000000>;
 			};
-			opp@200000000 {
+			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 			};
-			opp@400000000 {
+			opp-400000000 {
 				opp-hz = /bits/ 64 <400000000>;
 			};
 		};
@@ -882,19 +882,19 @@
 			compatible = "operating-points-v2";
 			opp-shared;
 
-			opp@50000000 {
+			opp-50000000 {
 				opp-hz = /bits/ 64 <50000000>;
 			};
-			opp@80000000 {
+			opp-80000000 {
 				opp-hz = /bits/ 64 <80000000>;
 			};
-			opp@100000000 {
+			opp-100000000 {
 				opp-hz = /bits/ 64 <100000000>;
 			};
-			opp@200000000 {
+			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 			};
-			opp@300000000 {
+			opp-300000000 {
 				opp-hz = /bits/ 64 <300000000>;
 			};
 		};
@@ -903,13 +903,13 @@
 			compatible = "operating-points-v2";
 			opp-shared;
 
-			opp@50000000 {
+			opp-50000000 {
 				opp-hz = /bits/ 64 <50000000>;
 			};
-			opp@80000000 {
+			opp-80000000 {
 				opp-hz = /bits/ 64 <80000000>;
 			};
-			opp@100000000 {
+			opp-100000000 {
 				opp-hz = /bits/ 64 <100000000>;
 			};
 		};
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index f9408188f97f..3678d5b44d80 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -335,15 +335,15 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <1025000>;
 		};
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 			opp-microvolt = <1050000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1150000>;
 		};
@@ -353,13 +353,13 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
 	};
@@ -368,10 +368,10 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@5000000 {
+		opp-5000000 {
 			opp-hz = /bits/ 64 <5000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
@@ -380,10 +380,10 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@10000000 {
+		opp-10000000 {
 			opp-hz = /bits/ 64 <10000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
 	};
@@ -392,13 +392,13 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
 	};
@@ -407,13 +407,13 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos4412-prime.dtsi b/arch/arm/boot/dts/exynos4412-prime.dtsi
index e75bc170c89c..a67bd953d754 100644
--- a/arch/arm/boot/dts/exynos4412-prime.dtsi
+++ b/arch/arm/boot/dts/exynos4412-prime.dtsi
@@ -20,12 +20,12 @@
 };
 
 &cpu0_opp_table {
-	opp@1600000000 {
+	opp-1600000000 {
 		opp-hz = /bits/ 64 <1600000000>;
 		opp-microvolt = <1350000>;
 		clock-latency-ns = <200000>;
 	};
-	opp@1704000000 {
+	opp-1704000000 {
 		opp-hz = /bits/ 64 <1704000000>;
 		opp-microvolt = <1350000>;
 		clock-latency-ns = <200000>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 235bbb69ad7c..ce240d0198b3 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -76,73 +76,73 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <900000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@300000000 {
+		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <900000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <925000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <950000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <975000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@700000000 {
+		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
 			opp-microvolt = <987500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <200000>;
 			opp-suspend;
 		};
-		opp@900000000 {
+		opp-900000000 {
 			opp-hz = /bits/ 64 <900000000>;
 			opp-microvolt = <1037500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1087500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1137500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1187500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1300000000 {
+		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1250000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1400000000 {
+		opp-1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
 			opp-microvolt = <1287500>;
 			clock-latency-ns = <200000>;
 		};
-		cpu0_opp_1500: opp@1500000000 {
+		cpu0_opp_1500: opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1350000>;
 			clock-latency-ns = <200000>;
@@ -433,23 +433,23 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1050000>;
 		};
@@ -459,16 +459,16 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 		};
 	};
@@ -525,19 +525,19 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <925000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <1000000>;
 		};
@@ -547,10 +547,10 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
 	};
@@ -559,10 +559,10 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
 	};
@@ -571,10 +571,10 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7dc9dc82afd8..5cd6c7389d51 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -49,62 +49,62 @@
 		cluster_a15_opp_table: opp_table0 {
 			compatible = "operating-points-v2";
 			opp-shared;
-			opp@1800000000 {
+			opp-1800000000 {
 				opp-hz = /bits/ 64 <1800000000>;
 				opp-microvolt = <1250000>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1700000000 {
+			opp-1700000000 {
 				opp-hz = /bits/ 64 <1700000000>;
 				opp-microvolt = <1212500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1600000000 {
+			opp-1600000000 {
 				opp-hz = /bits/ 64 <1600000000>;
 				opp-microvolt = <1175000>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1500000000 {
+			opp-1500000000 {
 				opp-hz = /bits/ 64 <1500000000>;
 				opp-microvolt = <1137500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1400000000 {
+			opp-1400000000 {
 				opp-hz = /bits/ 64 <1400000000>;
 				opp-microvolt = <1112500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1300000000 {
+			opp-1300000000 {
 				opp-hz = /bits/ 64 <1300000000>;
 				opp-microvolt = <1062500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1200000000 {
+			opp-1200000000 {
 				opp-hz = /bits/ 64 <1200000000>;
 				opp-microvolt = <1037500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1100000000 {
+			opp-1100000000 {
 				opp-hz = /bits/ 64 <1100000000>;
 				opp-microvolt = <1012500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1000000000 {
+			opp-1000000000 {
 				opp-hz = /bits/ 64 <1000000000>;
 				opp-microvolt = < 987500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@900000000 {
+			opp-900000000 {
 				opp-hz = /bits/ 64 <900000000>;
 				opp-microvolt = < 962500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@800000000 {
+			opp-800000000 {
 				opp-hz = /bits/ 64 <800000000>;
 				opp-microvolt = < 937500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@700000000 {
+			opp-700000000 {
 				opp-hz = /bits/ 64 <700000000>;
 				opp-microvolt = < 912500>;
 				clock-latency-ns = <140000>;
@@ -114,42 +114,42 @@
 		cluster_a7_opp_table: opp_table1 {
 			compatible = "operating-points-v2";
 			opp-shared;
-			opp@1300000000 {
+			opp-1300000000 {
 				opp-hz = /bits/ 64 <1300000000>;
 				opp-microvolt = <1275000>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1200000000 {
+			opp-1200000000 {
 				opp-hz = /bits/ 64 <1200000000>;
 				opp-microvolt = <1212500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1100000000 {
+			opp-1100000000 {
 				opp-hz = /bits/ 64 <1100000000>;
 				opp-microvolt = <1162500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1000000000 {
+			opp-1000000000 {
 				opp-hz = /bits/ 64 <1000000000>;
 				opp-microvolt = <1112500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@900000000 {
+			opp-900000000 {
 				opp-hz = /bits/ 64 <900000000>;
 				opp-microvolt = <1062500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@800000000 {
+			opp-800000000 {
 				opp-hz = /bits/ 64 <800000000>;
 				opp-microvolt = <1025000>;
 				clock-latency-ns = <140000>;
 			};
-			opp@700000000 {
+			opp-700000000 {
 				opp-hz = /bits/ 64 <700000000>;
 				opp-microvolt = <975000>;
 				clock-latency-ns = <140000>;
 			};
-			opp@600000000 {
+			opp-600000000 {
 				opp-hz = /bits/ 64 <600000000>;
 				opp-microvolt = <937500>;
 				clock-latency-ns = <140000>;
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 8213016803e5..9ddb6bacac5a 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -24,60 +24,60 @@
 };
 
 &cluster_a15_opp_table {
-	opp@1700000000 {
+	opp-1700000000 {
 		opp-microvolt = <1250000>;
 	};
-	opp@1600000000 {
+	opp-1600000000 {
 		opp-microvolt = <1250000>;
 	};
-	opp@1500000000 {
+	opp-1500000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@1400000000 {
+	opp-1400000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@1300000000 {
+	opp-1300000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@1200000000 {
+	opp-1200000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@1100000000 {
+	opp-1100000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@1000000000 {
+	opp-1000000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@900000000 {
+	opp-900000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@800000000 {
+	opp-800000000 {
 		opp-microvolt = <900000>;
 	};
-	opp@700000000 {
+	opp-700000000 {
 		opp-microvolt = <900000>;
 	};
-	opp@600000000 {
+	opp-600000000 {
 		opp-hz = /bits/ 64 <600000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@500000000 {
+	opp-500000000 {
 		opp-hz = /bits/ 64 <500000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@400000000 {
+	opp-400000000 {
 		opp-hz = /bits/ 64 <400000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@300000000 {
+	opp-300000000 {
 		opp-hz = /bits/ 64 <300000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@200000000 {
+	opp-200000000 {
 		opp-hz = /bits/ 64 <200000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
@@ -85,46 +85,46 @@
 };
 
 &cluster_a7_opp_table {
-	opp@1300000000 {
+	opp-1300000000 {
 		opp-microvolt = <1250000>;
 	};
-	opp@1200000000 {
+	opp-1200000000 {
 		opp-microvolt = <1250000>;
 	};
-	opp@1100000000 {
+	opp-1100000000 {
 		opp-microvolt = <1250000>;
 	};
-	opp@1000000000 {
+	opp-1000000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@900000000 {
+	opp-900000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@800000000 {
+	opp-800000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@700000000 {
+	opp-700000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@600000000 {
+	opp-600000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@500000000 {
+	opp-500000000 {
 		opp-hz = /bits/ 64 <500000000>;
 		opp-microvolt = <1000000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@400000000 {
+	opp-400000000 {
 		opp-hz = /bits/ 64 <400000000>;
 		opp-microvolt = <1000000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@300000000 {
+	opp-300000000 {
 		opp-hz = /bits/ 64 <300000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@200000000 {
+	opp-200000000 {
 		opp-hz = /bits/ 64 <200000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
index f9f4726396a0..95d59be97213 100644
--- a/arch/arm/boot/dts/pxa25x.dtsi
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -93,22 +93,22 @@
 	pxa250_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
 
-		opp@99532800 {
+		opp-99532800 {
 			opp-hz = /bits/ 64 <99532800>;
 			opp-microvolt = <1000000 950000 1650000>;
 			clock-latency-ns = <20>;
 		};
-		opp@199065600 {
+		opp-199065600 {
 			opp-hz = /bits/ 64 <199065600>;
 			opp-microvolt = <1000000 950000 1650000>;
 			clock-latency-ns = <20>;
 		};
-		opp@298598400 {
+		opp-298598400 {
 			opp-hz = /bits/ 64 <298598400>;
 			opp-microvolt = <1100000 1045000 1650000>;
 			clock-latency-ns = <20>;
 		};
-		opp@398131200 {
+		opp-398131200 {
 			opp-hz = /bits/ 64 <398131200>;
 			opp-microvolt = <1300000 1235000 1650000>;
 			clock-latency-ns = <20>;
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index e0fab48ba6fa..5f1d6da02a4c 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -141,37 +141,37 @@
 	pxa270_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
 
-		opp@104000000 {
+		opp-104000000 {
 			opp-hz = /bits/ 64 <104000000>;
 			opp-microvolt = <900000 900000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@156000000 {
+		opp-156000000 {
 			opp-hz = /bits/ 64 <156000000>;
 			opp-microvolt = <1000000 1000000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@208000000 {
+		opp-208000000 {
 			opp-hz = /bits/ 64 <208000000>;
 			opp-microvolt = <1180000 1180000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@312000000 {
+		opp-312000000 {
 			opp-hz = /bits/ 64 <312000000>;
 			opp-microvolt = <1250000 1250000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@416000000 {
+		opp-416000000 {
 			opp-hz = /bits/ 64 <416000000>;
 			opp-microvolt = <1350000 1350000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@520000000 {
+		opp-520000000 {
 			opp-hz = /bits/ 64 <520000000>;
 			opp-microvolt = <1450000 1450000 1705000>;
 			clock-latency-ns = <20>;
 		};
-		opp@624000000 {
+		opp-624000000 {
 			opp-hz = /bits/ 64 <624000000>;
 			opp-microvolt = <1550000 1550000 1705000>;
 			clock-latency-ns = <20>;
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 0467fb365bfc..7c7f8d8abfa0 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -49,25 +49,25 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@648000000 {
+		opp-648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@816000000 {
+		opp-816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1100000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@1008000000 {
+		opp-1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1320000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index dbc5e5333163..22ef2842be3a 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -77,67 +77,67 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@116667000 {
+		opp-116667000 {
 			opp-hz = /bits/ 64 <116667000>;
 			clock-latency-ns = <300>;
 		};
-		opp@150000000 {
+		opp-150000000 {
 			opp-hz = /bits/ 64 <150000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@175000000 {
+		opp-175000000 {
 			opp-hz = /bits/ 64 <175000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@233334000 {
+		opp-233334000 {
 			opp-hz = /bits/ 64 <233334000>;
 			clock-latency-ns = <300>;
 		};
-		opp@300000000 {
+		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@350000000 {
+		opp-350000000 {
 			opp-hz = /bits/ 64 <350000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@466667000 {
+		opp-466667000 {
 			opp-hz = /bits/ 64 <466667000>;
 			clock-latency-ns = <300>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@700000000 {
+		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@933334000 {
+		opp-933334000 {
 			opp-hz = /bits/ 64 <933334000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1400000000 {
+		opp-1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
 			clock-latency-ns = <300>;
 		};
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index e9e031d63c1a..acaaa2187843 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -97,35 +97,35 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@150000000 {
+		opp-150000000 {
 			opp-hz = /bits/ 64 <150000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@300000000 {
+		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			clock-latency-ns = <300>;
 		};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
index c42dc39c3223..ec11343dc528 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
@@ -94,27 +94,27 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1075000>;
 		};
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 			opp-microvolt = <1000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <975000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 			opp-microvolt = <962500>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <937500>;
 		};
@@ -123,19 +123,19 @@
 	bus_g2d_266_opp_table: opp_table3 {
 		compatible = "operating-points-v2";
 
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
@@ -143,13 +143,13 @@
 	bus_gscl_opp_table: opp_table4 {
 		compatible = "operating-points-v2";
 
-		opp@333000000 {
+		opp-333000000 {
 			opp-hz = /bits/ 64 <333000000>;
 		};
-		opp@222000000 {
+		opp-222000000 {
 			opp-hz = /bits/ 64 <222000000>;
 		};
-		opp@166500000 {
+		opp-166500000 {
 			opp-hz = /bits/ 64 <166500000>;
 		};
 	};
@@ -158,22 +158,22 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 		};
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
@@ -181,16 +181,16 @@
 	bus_noc2_opp_table: opp_table6 {
 		compatible = "operating-points-v2";
 
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 16072c1c3ed3..727f36abf3d4 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -119,43 +119,43 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <925000>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@700000000 {
+		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
 			opp-microvolt = <975000>;
 		};
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1000000>;
 		};
-		opp@900000000 {
+		opp-900000000 {
 			opp-hz = /bits/ 64 <900000000>;
 			opp-microvolt = <1050000>;
 		};
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1075000>;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1112500>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1112500>;
 		};
-		opp@1300000000 {
+		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1150000>;
 		};
@@ -165,63 +165,63 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@700000000 {
+		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
 			opp-microvolt = <912500>;
 		};
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <912500>;
 		};
-		opp@900000000 {
+		opp-900000000 {
 			opp-hz = /bits/ 64 <900000000>;
 			opp-microvolt = <937500>;
 		};
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000>;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1012500>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1037500>;
 		};
-		opp@1300000000 {
+		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1062500>;
 		};
-		opp@1400000000 {
+		opp-1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
 			opp-microvolt = <1087500>;
 		};
-		opp@1500000000 {
+		opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1125000>;
 		};
-		opp@1600000000 {
+		opp-1600000000 {
 			opp-hz = /bits/ 64 <1600000000>;
 			opp-microvolt = <1137500>;
 		};
-		opp@1700000000 {
+		opp-1700000000 {
 			opp-hz = /bits/ 64 <1700000000>;
 			opp-microvolt = <1175000>;
 		};
-		opp@1800000000 {
+		opp-1800000000 {
 			opp-hz = /bits/ 64 <1800000000>;
 			opp-microvolt = <1212500>;
 		};
-		opp@1900000000 {
+		opp-1900000000 {
 			opp-hz = /bits/ 64 <1900000000>;
 			opp-microvolt = <1262500>;
 		};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index da881f5b6ed4..0f2bee028ab0 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -89,31 +89,31 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@245000000 {
+		opp-245000000 {
 			opp-hz = /bits/ 64 <245000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@250000000 {
+		opp-250000000 {
 			opp-hz = /bits/ 64 <250000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@490000000 {
+		opp-490000000 {
 			opp-hz = /bits/ 64 <490000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@653334000 {
+		opp-653334000 {
 			opp-hz = /bits/ 64 <653334000>;
 			clock-latency-ns = <300>;
 		};
-		opp@666667000 {
+		opp-666667000 {
 			opp-hz = /bits/ 64 <666667000>;
 			clock-latency-ns = <300>;
 		};
-		opp@980000000 {
+		opp-980000000 {
 			opp-hz = /bits/ 64 <980000000>;
 			clock-latency-ns = <300>;
 		};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index a6b3a70dae83..19f782408d54 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -116,35 +116,35 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@250000000 {
+		opp-250000000 {
 			opp-hz = /bits/ 64 <250000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@275000000 {
+		opp-275000000 {
 			opp-hz = /bits/ 64 <275000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@550000000 {
+		opp-550000000 {
 			opp-hz = /bits/ 64 <550000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@666667000 {
+		opp-666667000 {
 			opp-hz = /bits/ 64 <666667000>;
 			clock-latency-ns = <300>;
 		};
-		opp@733334000 {
+		opp-733334000 {
 			opp-hz = /bits/ 64 <733334000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			clock-latency-ns = <300>;
 		};
@@ -154,35 +154,35 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@250000000 {
+		opp-250000000 {
 			opp-hz = /bits/ 64 <250000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@275000000 {
+		opp-275000000 {
 			opp-hz = /bits/ 64 <275000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@550000000 {
+		opp-550000000 {
 			opp-hz = /bits/ 64 <550000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@666667000 {
+		opp-666667000 {
 			opp-hz = /bits/ 64 <666667000>;
 			clock-latency-ns = <300>;
 		};
-		opp@733334000 {
+		opp-733334000 {
 			opp-hz = /bits/ 64 <733334000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			clock-latency-ns = <300>;
 		};
diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index b850b2cd0adc..2c7dc69987df 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -118,27 +118,27 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			clock-latency-ns = <500000>;
 		};
 
-		opp@648000000 {
+		opp-648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			clock-latency-ns = <500000>;
 		};
 
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			clock-latency-ns = <500000>;
 		};
 
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			clock-latency-ns = <500000>;
 		};
 
-		opp@1188000000 {
+		opp-1188000000 {
 			opp-hz = /bits/ 64 <1188000000>;
 			clock-latency-ns = <500000>;
 		};
-- 
2.12.0.432.g71c3a4f4ba37
