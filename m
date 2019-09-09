From: Adam Ford <aford173@gmail.com>
Subject: [PATCH 2/2] ARM: dts: Add OPP-V2 table for AM3517
Date: Mon,  9 Sep 2019 10:45:02 -0500
Message-ID: <20190909154502.19804-2-aford173@gmail.com>
References: <20190909154502.19804-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190909154502.19804-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: neolynx@gmail.com, letux-kernel@openphoenux.org, andreas@kemnade.info, tony@atomide.com, adam.ford@logicpd.com, hns@goldelico.com, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The AM3517 only lists 600MHz @ 1.2V, but the revister values for
0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
of the omap36 which has OPPs would be OPP50 (300 MHz) and OPP100
(600 MHz).

This patch sets up the OPP50 and OPP100 tables at 300MHz and 600MHz
for the AM3517 with each having an operating voltage at 1.2V.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 23ea381d363f..a0f23361d4bc 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -16,6 +16,37 @@
 		can = &hecc;
 	};
 
+	cpus {
+		cpu: cpu@0 {
+			/* Based on OMAP3630 variants OPP50 and OPP100 */
+			operating-points-v2 = <&cpu0_opp_table>;
+
+			clock-latency = <300000>; /* From legacy driver */
+		};
+	};
+
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		syscon = <&scm_conf>;
+		/*
+		 * AM3517 TRM only lists 600MHz @ 1.2V, but omap36xx
+		 * appear to operate at 300MHz as well. Since AM3517 only
+		 * lists one operating voltage, it will remain fixed at 1.2V
+		 */
+		opp50-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1200000>;
+			opp-supported-hw = <0xffffffff 0xffffffff>;
+			opp-suspend;
+		};
+
+		opp100-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1200000>;
+			opp-supported-hw = <0xffffffff 0xffffffff>;
+		};
+	};
+
 	ocp@68000000 {
 		am35x_otg_hs: am35x_otg_hs@5c040000 {
 			compatible = "ti,omap3-musb";
-- 
2.17.1
