From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC] [v2 Patch 6/6] ARM: dts: omap5: Add prm_resets node
Date: Mon, 5 May 2014 15:09:27 -0500
Message-ID: <1399320567-3639-7-git-send-email-dmurphy@ti.com>
References: <1399320567-3639-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48461 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163AbaEEUJz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 May 2014 16:09:55 -0400
In-Reply-To: <1399320567-3639-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com
Cc: Dan Murphy <dmurphy@ti.com>

Add the prm_resets node to the prm parent node.

Add the omap54xx_resets file to define the
omap5 reset lines that are handled by this reset
framework.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi           |    7 ++++
 arch/arm/boot/dts/omap54xx-resets.dtsi |   66 ++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap54xx-resets.dtsi

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index f8c9855..b6e3c4c 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -134,6 +134,12 @@
 
 			prm_clockdomains: clockdomains {
 			};
+
+			prm_resets: resets {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				#reset-cells = <1>;
+			};
 		};
 
 		cm_core_aon: cm_core_aon@4a004000 {
@@ -873,3 +879,4 @@
 };
 
 /include/ "omap54xx-clocks.dtsi"
+/include/ "omap54xx-resets.dtsi"
diff --git a/arch/arm/boot/dts/omap54xx-resets.dtsi b/arch/arm/boot/dts/omap54xx-resets.dtsi
new file mode 100644
index 0000000..cba6f52
--- /dev/null
+++ b/arch/arm/boot/dts/omap54xx-resets.dtsi
@@ -0,0 +1,66 @@
+/*
+ * Device Tree Source for OMAP5 reset data
+ *
+ * Copyright (C) 2014 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&prm_resets {
+	dsp_rstctrl {
+		reg = <0x1c00>,
+			  <0x1c04>;
+
+		dsp_reset: dsp_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+
+		dsp_mmu_reset: dsp_mmu_reset {
+			control-bit = <0x02>;
+			status-bit = <0x02>;
+		};
+	};
+
+	ipu_rstctrl {
+		reg = <0x910>,
+			  <0x914>;
+
+		ipu_cpu0_reset: ipu_cpu0_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+
+		ipu_cpu1_reset: ipu_cpu1_reset {
+			control-bit = <0x02>;
+			status-bit = <0x02>;
+		};
+
+		ipu_mmu_reset: ipu_mmu_reset {
+			control-bit = <0x04>;
+			status-bit = <0x04>;
+		};
+	};
+
+	iva_rstctrl {
+		reg = <0x1210>,
+			  <0x1214>;
+
+		iva_reset: iva_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+
+	device_rstctrl {
+		reg = <0x1c00>,
+			  <0x1c04>;
+
+		device_reset: device_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+};
-- 
1.7.9.5

