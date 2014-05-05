From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC] [v2 Patch 4/6] ARM: dts: am4372: Add prcm_resets node
Date: Mon, 5 May 2014 15:09:25 -0500
Message-ID: <1399320567-3639-5-git-send-email-dmurphy@ti.com>
References: <1399320567-3639-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40386 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163AbaEEUJy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 May 2014 16:09:54 -0400
In-Reply-To: <1399320567-3639-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com
Cc: Dan Murphy <dmurphy@ti.com>

Add the prcm_resets node to the prcm parent node.

Add the am34xx_resets file to define the
am34xx reset lines that are handled by this reset
framework.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        |    7 +++++
 arch/arm/boot/dts/am43xx-resets.dtsi |   52 ++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 arch/arm/boot/dts/am43xx-resets.dtsi

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d1f8707..e1ba7ed 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -84,6 +84,12 @@
 
 			prcm_clockdomains: clockdomains {
 			};
+
+			prcm_resets: resets {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				#reset-cells = <1>;
+			};
 		};
 
 		scrm: scrm@44e10000 {
@@ -739,3 +745,4 @@
 };
 
 /include/ "am43xx-clocks.dtsi"
+/include/ "am43xx-resets.dtsi"
diff --git a/arch/arm/boot/dts/am43xx-resets.dtsi b/arch/arm/boot/dts/am43xx-resets.dtsi
new file mode 100644
index 0000000..ef338ba
--- /dev/null
+++ b/arch/arm/boot/dts/am43xx-resets.dtsi
@@ -0,0 +1,52 @@
+/*
+ * Device Tree Source for AM43XX reset data
+ *
+ * Copyright (C) 2014 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&prcm_resets {
+	icss_rstctrl {
+		reg = <0x810>,
+			  <0x814>;
+
+		icss_reset: icss_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+
+	gfx_rstctrl {
+		reg = <0x410>,
+			  <0x414>;
+
+		gfx_reset: gfx_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+
+	per_rstctrl {
+		reg = <0x2010>,
+			  <0x2014>;
+
+		iva_reset: iva_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+
+	device_rstctrl {
+		reg = <0x4000>,
+			  <0x4004>;
+
+		device_reset: device_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+
+};
-- 
1.7.9.5

