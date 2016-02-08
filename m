From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/3] arm: dts: DRA7: Add IVA thermal data
Date: Mon, 8 Feb 2016 14:46:29 +0530
Message-ID: <1454922990-7501-3-git-send-email-j-keerthy@ti.com>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, edubezval@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch changes a dtsi file to contain the thermal data
for IVA domain. This data will enable a thermal shutdown at 125C.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra7-iva-thermal.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi

diff --git a/arch/arm/boot/dts/dra7-iva-thermal.dtsi b/arch/arm/boot/dts/dra7-iva-thermal.dtsi
new file mode 100644
index 0000000..dd74a53
--- /dev/null
+++ b/arch/arm/boot/dts/dra7-iva-thermal.dtsi
@@ -0,0 +1,27 @@
+/*
+ * Device Tree Source for DRA7x SoC IVA thermal
+ *
+ * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+iva_thermal: iva_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+
+			/* sensor       ID */
+	thermal-sensors = <&bandgap     4>;
+
+	trips {
+		iva_crit: iva_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
-- 
1.9.1
