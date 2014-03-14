From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC 6/9] ARM: dts: omap443x: Add opp-modifier entry and add higher OPPs
Date: Fri, 14 Mar 2014 14:25:32 -0500
Message-ID: <1394825135-60110-7-git-send-email-d-gerlach@ti.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43240 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935AbaCNT0a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 15:26:30 -0400
In-Reply-To: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, devicetree@vger.kernel.org, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jisheng Zhang <jszhang@marvell.com>, Anson Huang <Anson.Huang@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>

Add an entry for opp_modifier which configures OPPs on omap443x. Within
this, nodes are defined with the opp-modifier propety that are defined as
a list of frequency, offset from base register, and register value. The
CPU node passes a phandle to the appropriate child node to get the correct
table.

This patch also adds higher eFused OPPs for omap443x.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 16 ++++++++++++++++
 include/dt-bindings/opp/ti.h    |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index 8c1cfad..1c7e730 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "omap4.dtsi"
+#include <dt-bindings/opp/ti.h>
 
 / {
 	cpus {
@@ -20,9 +21,12 @@
 				600000  1200000
 				800000  1313000
 				1008000 1375000
+				1200000 1388000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
 
+			platform-opp-modifier = <&mpu_opp_modifier>;
+
 			/* cooling options */
 			cooling-min-level = <0>;
 			cooling-max-level = <3>;
@@ -42,6 +46,18 @@
 
 			#thermal-sensor-cells = <0>;
 		};
+
+		opp_modifier: opp_modifier@0x4A002218 {
+			compatible = "opp-modifier-reg-bit";
+			reg = <0x4A002218 0x04>;
+
+			mpu_opp_modifier: mpu_opp_modifier {
+				opp-modifier = <
+				/* kHz	offset	value */
+				1200000	0	OMAP4_EFUSE_HAS_PERF_SILICON_BIT
+				>;
+			};
+		};
 	};
 };
 
diff --git a/include/dt-bindings/opp/ti.h b/include/dt-bindings/opp/ti.h
index d3717be..cb62c32 100644
--- a/include/dt-bindings/opp/ti.h
+++ b/include/dt-bindings/opp/ti.h
@@ -25,4 +25,6 @@
 #define AM43XX_EFUSE_SMA_OPP_TURBO_800MHZ_BIT		(1 << 4)
 #define AM43XX_EFUSE_SMA_OPP_NITRO_1GHZ_BIT             (1 << 5)
 
+#define OMAP4_EFUSE_HAS_PERF_SILICON_BIT		(1 << 17)
+
 #endif		/* __DT_BINDINGS_OPP_TI_H__ */
-- 
1.9.0

