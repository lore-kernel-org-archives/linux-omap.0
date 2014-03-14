From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC 4/9] ARM: dts: AM33XX: Add opp-modifier device entry and add higher OPPs
Date: Fri, 14 Mar 2014 14:25:30 -0500
Message-ID: <1394825135-60110-5-git-send-email-d-gerlach@ti.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45275 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbaCNT0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2014 15:26:36 -0400
In-Reply-To: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, devicetree@vger.kernel.org, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jisheng Zhang <jszhang@marvell.com>, Anson Huang <Anson.Huang@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>

Add an entry for opp_modifier which configures OPPs on am33xx. Within this
nodes are defined with opp-modifier propety that are defined as a list
of frequency, offset from base register, and efuse value. The CPU node
passes a phandle to the appropriate child node of the efuse node.

This patch also adds the ES2.x OPPs for am33xx.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 27 +++++++++++++++++++++++++--
 include/dt-bindings/opp/ti.h  | 22 ++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/opp/ti.h

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 6d95d3d..a09f4fb 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/am33xx.h>
+#include <dt-bindings/opp/ti.h>
 
 #include "skeleton.dtsi"
 
@@ -52,12 +53,17 @@
 			 */
 			operating-points = <
 				/* kHz    uV */
+				1000000 1351000
+				800000	1285000
 				720000  1285000
 				600000  1225000
-				500000  1125000
-				275000  1125000
+				300000  1125000
 			>;
+
 			voltage-tolerance = <2>; /* 2 percentage */
+
+			platform-opp-modifier = <&mpu_opp_modifier>;
+
 			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 	};
@@ -818,6 +824,23 @@
 			reg = <0x48310000 0x2000>;
 			interrupts = <111>;
 		};
+
+		opp_modifier: opp_modifier@0x44e107fc {
+			compatible = "opp-modifier-reg-bit";
+			reg = <0x44e107fc 0x04>;
+
+			opp,reg-bit-enable-low;
+
+			mpu_opp_modifier: mpu_opp_modifier {
+				opp-modifier = <
+				/* kHz	offset	value */
+				1000000	0	AM33XX_EFUSE_SMA_OPP_NITRO_1GHZ_BIT
+				800000	0	AM33XX_EFUSE_SMA_OPP_TURBO_800MHZ_BIT
+				720000	0	AM33XX_EFUSE_SMA_OPP_120_720MHZ_BIT
+				600000	0	AM33XX_EFUSE_SMA_OPP_100_600MHZ_BIT
+				>;
+			};
+		};
 	};
 };
 
diff --git a/include/dt-bindings/opp/ti.h b/include/dt-bindings/opp/ti.h
new file mode 100644
index 0000000..58436c1
--- /dev/null
+++ b/include/dt-bindings/opp/ti.h
@@ -0,0 +1,22 @@
+/*
+ * This header provides constants for TI SoC OPP bindings.
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_OPP_TI_H__
+#define __DT_BINDINGS_OPP_TI_H__
+
+#define AM33XX_EFUSE_SMA_OPP_50_300MHZ_BIT              (1 << 4)
+#define AM33XX_EFUSE_SMA_OPP_100_300MHZ_BIT             (1 << 5)
+#define AM33XX_EFUSE_SMA_OPP_100_600MHZ_BIT             (1 << 6)
+#define AM33XX_EFUSE_SMA_OPP_120_720MHZ_BIT             (1 << 7)
+#define AM33XX_EFUSE_SMA_OPP_TURBO_800MHZ_BIT		(1 << 8)
+#define AM33XX_EFUSE_SMA_OPP_NITRO_1GHZ_BIT             (1 << 9)
+
+#endif		/* __DT_BINDINGS_OPP_TI_H__ */
-- 
1.9.0

