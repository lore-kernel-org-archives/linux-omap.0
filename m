From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] arm: boot: dts: am4372: add operating points
Date: Fri, 8 May 2015 14:57:29 -0500
Message-ID: <1431115050-23693-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41919 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbbEHT7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 May 2015 15:59:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Felipe Balbi <balbi@ti.com>

By adding operating points, cpufreq-dt has a
chance of running and doing something useful.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c80a3e233792..ea1db20f64fc 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -38,6 +38,15 @@
 			clocks = <&dpll_mpu_ck>;
 			clock-names = "cpu";
 
+			operating-points = <
+				/* kHz		uV */
+				1000000		1325000 /* OPP_NITRO */
+				 800000		1260000 /* OPP_TURBO */
+				 720000		1200000 /* OPP_120 */
+				 600000		1100000 /* OPP_100 */
+				 300000		 950000 /* OPP_50 */
+			>;
+
 			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 	};
-- 
2.4.0.rc3

