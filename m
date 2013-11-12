From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv5 15/20] arm: dts: add omap5 CORE thermal data
Date: Tue, 12 Nov 2013 15:46:17 -0400
Message-ID: <1384285582-16933-16-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com
Cc: wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch changes a dtsi file to contain the thermal data
for CORE domain on OMAP5 and later SoCs. This data will
enable a thermal shutdown at 125C.

This thermal data can be reused across TI SoC devices.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
Change from v4:
- Using string constants instead of macros on trip types

 arch/arm/boot/dts/omap5-core-thermal.dtsi | 28 +++++++++++++++++++++++=
+++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap5-core-thermal.dtsi

diff --git a/arch/arm/boot/dts/omap5-core-thermal.dtsi b/arch/arm/boot/=
dts/omap5-core-thermal.dtsi
new file mode 100644
index 0000000..19212ac
--- /dev/null
+++ b/arch/arm/boot/dts/omap5-core-thermal.dtsi
@@ -0,0 +1,28 @@
+/*
+ * Device Tree Source for OMAP543x SoC CORE thermal
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.c=
om/
+ * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
+ *
+ * This file is licensed under the terms of the GNU General Public Lic=
ense
+ * version 2.  This program is licensed "as is" without any warranty o=
f any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+core_thermal: core_thermal {
+	polling-delay-passive =3D <250>; /* milliseconds */
+	polling-delay =3D <1000>; /* milliseconds */
+
+			/* sensor       ID */
+	thermal-sensors =3D <&bandgap     2>;
+
+	trips {
+		core_crit: core_crit {
+			temperature =3D <125000>; /* milliCelsius */
+			hysteresis =3D <2000>; /* milliCelsius */
+			type =3D "critical";
+		};
+	};
+};
--=20
1.8.2.1.342.gfa7285d

