From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 8/8] ARM: dts: Add OPP-V2 table for AM3517
Date: Wed, 11 Sep 2019 19:47:14 +0200
Message-ID: <6089486dcf1f327aa53348f5434cd57cc964c30f.1568224033.git.hns@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1568224032.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

The AM3517 only lists 600MHz @ 1.2V, but the register values for
0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
of the omap36 which OPPs would be OPP50 (300 MHz) and OPP100
(600 MHz).

This patch sets up the OPP50 and OPP100 tables at 300MHz and 600MHz
for the AM3517 with each having an operating voltage at 1.2V.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Adam Ford <aford173@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/am3517.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

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
2.19.1
