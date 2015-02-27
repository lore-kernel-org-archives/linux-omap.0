From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] ARM: dts: OMAP5: fix polling intervals for thermal zones
Date: Fri, 27 Feb 2015 15:59:03 +0200
Message-ID: <1425045543-19540-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49389 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbbB0N66 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Feb 2015 08:58:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

OMAP4 has a finer counter granularity, which allows for a delay of 1000ms
in the thermal zone polling intervals. OMAP5 has a different counter
mechanism, which allows at maximum a 500ms timer. Adjust the cpu thermal
zone polling interval accordingly.

Without this patch, the polling interval information is simply ignored,
and the following thermal warnings are printed during boot (assuming
thermal is enabled);

[    1.545343] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supported
[    1.552691] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supported
[    1.560029] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supported

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-core-thermal.dtsi |    2 +-
 arch/arm/boot/dts/omap5-gpu-thermal.dtsi  |    2 +-
 arch/arm/boot/dts/omap5.dtsi              |    4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-core-thermal.dtsi b/arch/arm/boot/dts/omap5-core-thermal.dtsi
index 19212ac..de8a3d4 100644
--- a/arch/arm/boot/dts/omap5-core-thermal.dtsi
+++ b/arch/arm/boot/dts/omap5-core-thermal.dtsi
@@ -13,7 +13,7 @@
 
 core_thermal: core_thermal {
 	polling-delay-passive = <250>; /* milliseconds */
-	polling-delay = <1000>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
 
 			/* sensor       ID */
 	thermal-sensors = <&bandgap     2>;
diff --git a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
index 1b87aca..bc3090f 100644
--- a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
@@ -13,7 +13,7 @@
 
 gpu_thermal: gpu_thermal {
 	polling-delay-passive = <250>; /* milliseconds */
-	polling-delay = <1000>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
 
 			/* sensor       ID */
 	thermal-sensors = <&bandgap     1>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b321fdf..fee1580 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -1079,4 +1079,8 @@
 	};
 };
 
+&cpu_thermal {
+	polling-delay = <500>; /* milliseconds */
+};
+
 /include/ "omap54xx-clocks.dtsi"
-- 
1.7.9.5

