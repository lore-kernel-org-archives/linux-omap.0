From: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [v2 Patch 3/6] ARM: dts: am33xx: Add prcm_resets node
Date: Mon, 5 May 2014 15:09:24 -0500
Message-ID: <1399320567-3639-4-git-send-email-dmurphy@ti.com>
References: <1399320567-3639-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399320567-3639-1-git-send-email-dmurphy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the prcm_resets node to the prcm parent node.

Add the am33xx_resets file to define the
am33xx reset lines that are handled by this reset
framework.

Signed-off-by: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx-resets.dtsi |   42 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi        |    7 ++++++
 2 files changed, 49 insertions(+)
 create mode 100644 arch/arm/boot/dts/am33xx-resets.dtsi

diff --git a/arch/arm/boot/dts/am33xx-resets.dtsi b/arch/arm/boot/dts/am33xx-resets.dtsi
new file mode 100644
index 0000000..9260626
--- /dev/null
+++ b/arch/arm/boot/dts/am33xx-resets.dtsi
@@ -0,0 +1,42 @@
+/*
+ * Device Tree Source for AM33XX reset data
+ *
+ * Copyright (C) 2014 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&prcm_resets {
+	gfx_rstctrl {
+		reg = <0x1104>,
+			  <0x1114>;
+
+		gfx_reset: gfx_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+
+	per_rstctrl {
+		reg = <0xD00>,
+			  <0xD0C>;
+
+		iva_reset: iva_reset {
+			control-bit = <0x04>;
+			status-bit = <0x10>;
+		};
+	};
+
+	device_rstctrl {
+		reg = <0xf00>,
+			  <0xf08>;
+
+		device_reset: device_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index cb6811e..6b1a6df 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -117,6 +117,12 @@
 
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
@@ -833,3 +839,4 @@
 };
 
 /include/ "am33xx-clocks.dtsi"
+/include/ "am33xx-resets.dtsi"
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
