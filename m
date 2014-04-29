From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC 10/11] ARM: dts: dra7: Add prm_resets node
Date: Tue, 29 Apr 2014 15:19:49 -0500
Message-ID: <1398802790-29287-11-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44073 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758373AbaD2UUe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 16:20:34 -0400
In-Reply-To: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org
Cc: t-kristo@ti.com, s-anna@ti.com, p.zabel@pengutronix.de, Dan Murphy <dmurphy@ti.com>

Add the prcm_resets node to the prm parent node.
Add the dt-bindings header to the DT file

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi                |    6 ++++++
 include/dt-bindings/reset/ti,dra7-resets.h |   22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/reset/ti,dra7-resets.h

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 149b550..3507730 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -9,6 +9,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/dra.h>
+#include <dt-bindings/reset/ti,dra7-resets.h>
 
 #include "skeleton.dtsi"
 
@@ -120,6 +121,11 @@
 
 			prm_clockdomains: clockdomains {
 			};
+
+			prm_resets: resets {
+				compatible = "ti,dra7-resets";
+				#reset-cells = <1>;
+			};
 		};
 
 		cm_core_aon: cm_core_aon@4a005000 {
diff --git a/include/dt-bindings/reset/ti,dra7-resets.h b/include/dt-bindings/reset/ti,dra7-resets.h
new file mode 100644
index 0000000..89be87b
--- /dev/null
+++ b/include/dt-bindings/reset/ti,dra7-resets.h
@@ -0,0 +1,22 @@
+/*
+ * DRA7xx reset index for PRCM Module
+ *
+ * Copyright 2014 Texas Instruments Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_RESET_TI_DRA7_H
+#define _DT_BINDINGS_RESET_TI_DRA7_H
+
+#define RESET_DEVICE_RESET			0
+#define RESET_DSP1_RESET			1
+#define RESET_IPU_CPU0_RESET		2
+#define RESET_IPU_CPU1_RESET		3
+#define RESET_IPU_MMU_CACHE_RESET	4
+#define RESET_IVA_RESET				5
+#define RESET_PCIE_RESET			6
+
+#endif
-- 
1.7.9.5

