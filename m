From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC 5/9] ARM: dts: AM4372: Add opp-modifier device entry and add higher OPPs
Date: Fri, 14 Mar 2014 14:25:31 -0500
Message-ID: <1394825135-60110-6-git-send-email-d-gerlach@ti.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45297 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbaCNT06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2014 15:26:58 -0400
In-Reply-To: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, devicetree@vger.kernel.org, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jisheng Zhang <jszhang@marvell.com>, Anson Huang <Anson.Huang@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>

Add an entry for opp_modifier which configures OPPs on AM4372. Within
this, nodes are defined with the opp-modifier propety that are defined as
a list of frequency, offset from base register, and efuse value.
The CPU node passes a phandle to the appropriate child node to get the
correct table.

This patch also adds higher eFused OPPs for AM4372.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 30 ++++++++++++++++++++++++++++++
 include/dt-bindings/opp/ti.h  |  6 ++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c6bd4d9..dbaa2e3 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/opp/ti.h>
 
 #include "skeleton.dtsi"
 
@@ -33,6 +34,17 @@
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
+
+			operating-points = <
+				/* kHz    uV */
+				300000	950000
+				600000	1100000
+				720000	1200000
+				800000	1260000
+				1000000 1325000
+			>;
+
+			platform-opp-modifier = <&mpu_opp_modifier>;
 		};
 	};
 
@@ -662,6 +674,24 @@
 			dma-names = "tx", "rx";
 		};
 
+		opp_modifier: opp_modifier@0x44e10610 {
+			compatible = "opp-modifier-reg-bit";
+			reg = <0x44e10610 0x04>;
+
+			opp,reg-bit-enable-low;
+
+			mpu_opp_modifier: mpu_opp_modifier {
+				opp-modifier = <
+				/* kHz	offset	value */
+				1000000	0	AM43XX_EFUSE_SMA_OPP_NITRO_1GHZ_BIT
+				800000	0	AM43XX_EFUSE_SMA_OPP_TURBO_800MHZ_BIT
+				720000	0	AM43XX_EFUSE_SMA_OPP_120_720MHZ_BIT
+				600000	0	AM43XX_EFUSE_SMA_OPP_100_600MHZ_BIT
+				300000	0	AM43XX_EFUSE_SMA_OPP_50_300MHZ_BIT
+				>;
+			};
+		};
+
 		mcasp0: mcasp@48038000 {
 			compatible = "ti,am33xx-mcasp-audio";
 			ti,hwmods = "mcasp0";
diff --git a/include/dt-bindings/opp/ti.h b/include/dt-bindings/opp/ti.h
index 58436c1..d3717be 100644
--- a/include/dt-bindings/opp/ti.h
+++ b/include/dt-bindings/opp/ti.h
@@ -19,4 +19,10 @@
 #define AM33XX_EFUSE_SMA_OPP_TURBO_800MHZ_BIT		(1 << 8)
 #define AM33XX_EFUSE_SMA_OPP_NITRO_1GHZ_BIT             (1 << 9)
 
+#define AM43XX_EFUSE_SMA_OPP_50_300MHZ_BIT              (1 << 0)
+#define AM43XX_EFUSE_SMA_OPP_100_600MHZ_BIT             (1 << 2)
+#define AM43XX_EFUSE_SMA_OPP_120_720MHZ_BIT             (1 << 3)
+#define AM43XX_EFUSE_SMA_OPP_TURBO_800MHZ_BIT		(1 << 4)
+#define AM43XX_EFUSE_SMA_OPP_NITRO_1GHZ_BIT             (1 << 5)
+
 #endif		/* __DT_BINDINGS_OPP_TI_H__ */
-- 
1.9.0

