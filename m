From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 3/5] ARM: dts: am4372: Update operating-points-v2 table for cpu
Date: Mon, 6 Mar 2017 09:23:40 -0600
Message-ID: <1488813822-26042-4-git-send-email-d-gerlach@ti.com>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Lukasz Majewski <lukma@denx.de>, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

The operatings-points-v2 table for am4372 was merged before any user of
it was present in the kernel and before the binding had been finalized.
The new ti-cpufreq driver and binding expects the platform specific
properties to be part of the operating-points-v2 table rather than the
cpu node so let's move them there as the only user is the ti-cpufreq
driver.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 97fcaf415de1..176e09e9a45e 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -50,15 +50,14 @@
 			clock-names = "cpu";
 
 			operating-points-v2 = <&cpu0_opp_table>;
-			ti,syscon-efuse = <&scm_conf 0x610 0x3f 0>;
-			ti,syscon-rev = <&scm_conf 0x600>;
 
 			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 	};
 
-	cpu0_opp_table: opp_table0 {
-		compatible = "operating-points-v2";
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		syscon = <&scm_conf>;
 
 		opp50@300000000 {
 			opp-hz = /bits/ 64 <300000000>;
-- 
2.11.0
