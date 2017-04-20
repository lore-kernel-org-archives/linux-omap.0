From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 2/7] ARM: TI: Use - instead of @ for DT OPP entries
Date: Thu, 20 Apr 2017 11:14:13 +0530
Message-ID: <f28bf0c7a177c78b5f6d298462a0bb627dfae937.1492666725.git.viresh.kumar@linaro.org>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1492666725.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492666725.git.viresh.kumar@linaro.org>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
 arch/arm/boot/dts/am4372.dtsi                        | 10 +++++-----
 2 files changed, 15 insertions(+), 15 deletions(-)

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
-- 
2.12.0.432.g71c3a4f4ba37
