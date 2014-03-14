From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC 8/9] ARM: dts: dra7: Add opp-modifier device entry and add higher OPPs
Date: Fri, 14 Mar 2014 14:25:34 -0500
Message-ID: <1394825135-60110-9-git-send-email-d-gerlach@ti.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, devicetree@vger.kernel.org, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jisheng Zhang <jszhang@marvell.com>, Anson Huang <Anson.Huang@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add an entry for opp-modifier which configures OPPs on 43xx. Within
this, nodes are defined with the opp-modifier propety that are defined as
a list of frequency, offset from base register, and efuse value.
The CPU node passes a phandle to the appropriate child node to get the
correct table.

This patch also adds higher eFused OPPs for dra7.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi  | 18 ++++++++++++++++++
 include/dt-bindings/opp/ti.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1fd75aa..ffd0bae 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -9,6 +9,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/dra.h>
+#include <dt-bindings/opp/ti.h>
 
 #include "skeleton.dtsi"
 
@@ -46,7 +47,10 @@
 				/* kHz    uV */
 				1000000	1060000
 				1176000	1160000
+				1500000	1260000
 				>;
+
+			platform-opp-modifier = <&mpu_opp_modifier>;
 		};
 		cpu@1 {
 			device_type = "cpu";
@@ -621,6 +625,20 @@
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
+
+		opp_modifier: opp_modifier@0x4AE0C20C {
+			compatible = "opp-modifier-reg-val";
+			reg = <0x4AE0C20C 0x04>;
+			opp,reg-mask = <0x000000F7>;
+
+			mpu_opp_modifier: mpu_opp_modifier {
+				opp-modifier = <
+				/* kHz	offset	value */
+				1500000	0	DRA7_EFUSE_HAS_HIGH_MPU_OPP
+				1176000	0	DRA7_EFUSE_HAS_OD_MPU_OPP
+				>;
+			};
+		};
 	};
 };
 
diff --git a/include/dt-bindings/opp/ti.h b/include/dt-bindings/opp/ti.h
index cb62c32..0f5efe8 100644
--- a/include/dt-bindings/opp/ti.h
+++ b/include/dt-bindings/opp/ti.h
@@ -27,4 +27,7 @@
 
 #define OMAP4_EFUSE_HAS_PERF_SILICON_BIT		(1 << 17)
 
+#define DRA7_EFUSE_HAS_OD_MPU_OPP			11
+#define DRA7_EFUSE_HAS_HIGH_MPU_OPP			15
+
 #endif		/* __DT_BINDINGS_OPP_TI_H__ */
-- 
1.9.0

