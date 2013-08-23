From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 11/14] arm: dts: add omap5 GPU thermal data
Date: Fri, 23 Aug 2013 19:15:52 -0400
Message-ID: <1377299755-5134-12-git-send-email-eduardo.valentin@ti.com>
References: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, grant.likely@linaro.org, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com
Cc: durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@linaro.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch changes a dtsi file to contain the thermal data
for GPU domain on OMAP5 and later SoCs. This data will
enable a thermal shutdown at 125C.

This thermal data can be reused across TI SoC devices.

Cc: "Beno=C3=AEt Cousson" <b-cousson@linaro.org>
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
 arch/arm/boot/dts/omap5-gpu-thermal.dtsi | 27 ++++++++++++++++++++++++=
+++
 1 file changed, 27 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap5-gpu-thermal.dtsi

diff --git a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi b/arch/arm/boot/d=
ts/omap5-gpu-thermal.dtsi
new file mode 100644
index 0000000..f421492
--- /dev/null
+++ b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
@@ -0,0 +1,27 @@
+
+/*
+ * Device Tree Source for OMAP543x SoC GPU thermal
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
+gpu_thermal: gpu_thermal {
+	#thermal-cells =3D <1>;
+	mask =3D <0x01>; /* trips writability */
+	passive_delay =3D <250>; /* milliseconds */
+	polling_delay =3D <1000>; /* milliseconds */
+	trips {
+		crit@125000{
+			temperature =3D <125000>; /* milliCelsius */
+			hysteresis =3D <2000>; /* milliCelsius */
+			type =3D <THERMAL_TRIP_CRITICAL>;
+		};
+	};
+};
--=20
1.8.2.1.342.gfa7285d
