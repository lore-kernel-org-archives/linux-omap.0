From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 3/3] Revert "ARM: dts: dra7: Move to operating-points-v2 table"
Date: Wed, 14 Sep 2016 15:57:17 -0500
Message-ID: <20160914205717.21975-4-d-gerlach@ti.com>
References: <20160914205717.21975-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160914205717.21975-1-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

This reverts commit f80bc97fd0a9711ef11bdb3e63c2c01115a82c47.

The original commit updated the cpufreq operating points tables for
dra7xx but was merged before the driver making use of the node was
merged, which breaks the existing cpufreq implementation on the system,
so revert the patch until the ti-cpufreq driver is merged.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi   | 26 +++++---------------------
 arch/arm/boot/dts/dra74x.dtsi |  1 -
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d9bfb94a2992..a0fbbf18d50c 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -82,9 +82,11 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 
-			operating-points-v2 = <&cpu0_opp_table>;
-			ti,syscon-efuse = <&scm_wkup 0x20c 0xf80000 19>;
-			ti,syscon-rev = <&scm_wkup 0x204>;
+			operating-points = <
+				/* kHz    uV */
+				1000000	1060000
+				1176000	1160000
+				>;
 
 			clocks = <&dpll_mpu_ck>;
 			clock-names = "cpu";
@@ -98,24 +100,6 @@
 		};
 	};
 
-	cpu0_opp_table: opp_table0 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp_nom@1000000000 {
-			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <1060000 850000 1150000>;
-			opp-supported-hw = <0xFF 0x01>;
-			opp-suspend;
-		};
-
-		opp_od@1176000000 {
-			opp-hz = /bits/ 64 <1176000000>;
-			opp-microvolt = <1160000 885000 1160000>;
-			opp-supported-hw = <0xFF 0x02>;
-		};
-	};
-
 	/*
 	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 8987b3e180a1..0a78347e6615 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -17,7 +17,6 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
-			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
 
-- 
2.9.3

