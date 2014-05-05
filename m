From: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [v2 Patch 5/6] ARM: dts: dra7: Add prm_resets node
Date: Mon, 5 May 2014 15:09:26 -0500
Message-ID: <1399320567-3639-6-git-send-email-dmurphy@ti.com>
References: <1399320567-3639-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399320567-3639-1-git-send-email-dmurphy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the prcm_resets node to the prm parent node.

Add the draxx_resets file to define the
dra7xx reset lines that are handled by this reset
framework.

Signed-off-by: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi          |    7 +++
 arch/arm/boot/dts/dra7xx-resets.dtsi |   82 ++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra7xx-resets.dtsi

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 149b550..c008996 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -120,6 +120,12 @@
 
 			prm_clockdomains: clockdomains {
 			};
+
+			prm_resets: resets {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				#reset-cells = <1>;
+			};
 		};
 
 		cm_core_aon: cm_core_aon@4a005000 {
@@ -793,3 +799,4 @@
 };
 
 /include/ "dra7xx-clocks.dtsi"
+/include/ "dra7xx-resets.dtsi"
diff --git a/arch/arm/boot/dts/dra7xx-resets.dtsi b/arch/arm/boot/dts/dra7xx-resets.dtsi
new file mode 100644
index 0000000..4c4966d
--- /dev/null
+++ b/arch/arm/boot/dts/dra7xx-resets.dtsi
@@ -0,0 +1,82 @@
+/*
+ * Device Tree Source for DRA7XX reset data
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
+		reg = <0x410>,
+			  <0x414>;
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
+		reg = <0x510>,
+			  <0x514>;
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
+		reg = <0xf10>,
+			  <0xf14>;
+
+		iva_reset: iva_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+
+	pcie_rstctrl {
+		reg = <0x1310>,
+			  <0x1314>;
+
+		pcie1_reset: pcie1_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+
+		pcie2_reset: pcie2_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+
+	device_rstctrl {
+		reg = <0x1D00>,
+			  <0x1D04>;
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
