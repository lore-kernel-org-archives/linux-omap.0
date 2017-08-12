From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 7/8] ARM: dts: Add support for dra76x family of devices
Date: Sat, 12 Aug 2017 09:36:04 +0530
Message-ID: <20170812040605.21259-8-lokeshvutla@ti.com>
References: <20170812040605.21259-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170812040605.21259-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Praneeth Bajjuri <praneeth-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

dra76 family is a high-performance, infotainment application
device, based on OMAP architecture on a 28-nm technology.
This contains most of the subsystems, peripherals that are
available on dra74, dra72 family. This SoC mainly features
Subsystems:
- 2 x Cortex-A15 with max speed of 1.8GHz
- 2 X DSP
- 2 X Cortex-M4 IPU
- ISS
- CAL
- DSS
- VPE
- VIP
Connectivity peripherals:
- 1 USB3.0 and 3 USB2.0 subsystems
- 2 x SATA
- 2 x PCI Express Gen2
- 3-port Gigabit ethernet switch
- 2 x CAN
- MCAN

Adding basic dts support for DRA76 family while reusing the
data available in dra7.dtsi, dra74x.dtsi.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra76x.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra76x.dtsi

diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
new file mode 100644
index 000000000000..1c88c581ff18
--- /dev/null
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "dra74x.dtsi"
+
+/ {
+	compatible = "ti,dra762", "ti,dra7";
+
+};
+
+/* MCAN interrupts are hard-wired to irqs 67, 68 */
+&crossbar_mpu {
+	ti,irqs-skip = <10 67 68 133 139 140>;
+};
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
