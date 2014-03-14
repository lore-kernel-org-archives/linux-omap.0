From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC 9/9] ARM: dts: imx6q: Add opp-modifier device entry
Date: Fri, 14 Mar 2014 14:25:35 -0500
Message-ID: <1394825135-60110-10-git-send-email-d-gerlach@ti.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, devicetree@vger.kernel.org, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jisheng Zhang <jszhang@marvell.com>, Anson Huang <Anson.Huang@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add an entry for opp_modifier which configures OPPs on imx6q. Within
this nodes are defined with opp-modifier propety that are defined as a list
of frequency, offset from base register, and efuse value.

This is an untested example patch to show how opp-modifier could be used
for this platform.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/imx6q.dtsi  | 18 ++++++++++++++++++
 include/dt-bindings/opp/imx.h | 17 +++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 include/dt-bindings/opp/imx.h

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index f024ef2..4cc48ef 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -10,6 +10,7 @@
 
 #include "imx6q-pinfunc.h"
 #include "imx6qdl.dtsi"
+#include <dt-bindings/opp/imx.h>
 
 / {
 	cpus {
@@ -36,6 +37,8 @@
 			arm-supply = <&reg_arm>;
 			pu-supply = <&reg_pu>;
 			soc-supply = <&reg_soc>;
+
+			platform-opp-modifier = <&mpu_opp_modifier>;
 		};
 
 		cpu@1 {
@@ -140,6 +143,21 @@
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 4>;
 		};
+
+		opp_modifier: opp_modifier@0x021bc440 {
+			compatible = "opp-modifier-reg-val";
+			reg = <0x021bc440 0x04>;
+			opp,reg-mask = <0x00030000>;
+
+			mpu_opp_modifier: mpu_opp_modifier {
+				opp-modifier = <
+				/* kHz	offset	value */
+				1200000	0	OPP_OCOTP_CFG3_SPEED_1P2GHZ
+				996000	0	OPP_OCOTP_CFG3_SPEED_996MHZ
+				>;
+			};
+		};
+
 	};
 };
 
diff --git a/include/dt-bindings/opp/imx.h b/include/dt-bindings/opp/imx.h
new file mode 100644
index 0000000..2700ab9
--- /dev/null
+++ b/include/dt-bindings/opp/imx.h
@@ -0,0 +1,17 @@
+/*
+ * This header provides constants for iMX SoC OPP bindings.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_OPP_IMX_H__
+#define __DT_BINDINGS_OPP_IMX_H__
+
+#define OPP_OCOTP_CFG3_SPEED_1P2GHZ		(0x3 << 16)
+#define OPP_OCOTP_CFG3_SPEED_996MHZ		(0x2 << 16)
+#define OPP_OCOTP_CFG3_SPEED_852MHZ		(0x1 << 16)
+
+#endif		/* __DT_BINDINGS_OPP_IMX_H__ */
-- 
1.9.0

