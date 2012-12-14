From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/2] ARM: dts: OMAP2+: Add PMU nodes
Date: Fri, 14 Dec 2012 15:18:50 -0600
Message-ID: <1355519930-3851-3-git-send-email-jon-hunter@ti.com>
References: <1355519930-3851-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47023 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932377Ab2LNVTE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 16:19:04 -0500
In-Reply-To: <1355519930-3851-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Jon Hunter <jon-hunter@ti.com>

Add PMU nodes for OMAP2, OMAP3 and OMAP4460 devices.

Please note that the node for OMAP4460 has been placed in a separate
header file for OMAP4460, because the node is not compatible with
OMAP4430.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi         |    5 +++++
 arch/arm/boot/dts/omap3.dtsi         |    6 ++++++
 arch/arm/boot/dts/omap4-panda-es.dts |    2 ++
 arch/arm/boot/dts/omap4460.dtsi      |   18 ++++++++++++++++++
 arch/arm/mach-omap2/pmu.c            |    2 ++
 5 files changed, 33 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4460.dtsi

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 761c4b6..27f5ea1 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -26,6 +26,11 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,arm1136-pmu";
+		interrupts = <3>;
+	};
+
 	soc {
 		compatible = "ti,omap-infra";
 		mpu {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..6c63118 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -26,6 +26,12 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a8-pmu";
+		interrupts = <3>;
+		ti,hwmods = "debugss";
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
index 73bc1a6..2a6e344 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -5,7 +5,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
 /include/ "omap4-panda.dts"
+/include/ "omap4460.dtsi"
 
 /* Audio routing is differnet between PandaBoard4430 and PandaBoardES */
 &sound {
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
new file mode 100644
index 0000000..1270890
--- /dev/null
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -0,0 +1,18 @@
+/*
+ * Device Tree Source for OMAP4460 SoC
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 54 0x4
+			      0 55 0x4>;
+		ti,hwmods = "debugss";
+	};
+};
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index 6e620eb..1a0799c 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -11,6 +11,8 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <linux/of.h>
+
 #include <asm/pmu.h>
 
 #include "soc.h"
-- 
1.7.10.4

