From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 09/15] ARM: dts: OMAP5: Add CPU OPP table
Date: Wed, 9 Oct 2013 18:24:52 -0500
Message-ID: <1381361098-8283-8-git-send-email-nm@ti.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
 <1381361098-8283-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1381361098-8283-1-git-send-email-nm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

From: J Keerthy <j-keerthy@ti.com>

Add DT OPP table for OMAP54xx family of devices. This data is
decoded by OF with of_init_opp_table() helper function.

The data is based on OMAP543x ES2.0 DM Operating Condition Addendum
Version 0.6(April 2013)

NOTE: The voltage and frequency values work well only on NOM samples
and are supposed to work properly only with ABB/AVS for ALL OPPs.

TODO: Add SPEED BIN OPP after ABB and AVS support so the cpufreq works
on all samples seamlessly. Clock node is pending alignment for clock
dts conversion

[nm@ti.com: sync to latest and fixes]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: J Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 2e83e24..4be15e0 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -37,6 +37,13 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
+
+			operating-points = <
+				/* kHz    uV */
+				500000  880000
+				1000000 1060000
+				1500000 1250000
+			>;
 		};
 		cpu@1 {
 			device_type = "cpu";
-- 
1.7.9.5

