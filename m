From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/6] ARM/dts: OMAP2: Add McBSP entries for OMAP2420 and OMAP2430 SoC
Date: Thu, 23 Aug 2012 12:29:08 +0300
Message-ID: <1345714153-13094-2-git-send-email-peter.ujfalusi@ti.com>
References: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:35124 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758187Ab2HWJ30 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 05:29:26 -0400
Received: by obbup19 with SMTP id up19so1187471obb.26
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 02:29:25 -0700 (PDT)
In-Reply-To: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

The McBSP IP within OMAP2420 and 2430 is different we need to create separate
dtsi files for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi |   39 ++++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi |   83 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap2420.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430.dtsi

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
new file mode 100644
index 0000000..f375c68
--- /dev/null
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -0,0 +1,39 @@
+/*
+ * Device Tree Source for OMAP2420 SoC
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "omap2.dtsi"
+
+/ {
+	compatible = "ti,omap2420", "ti,omap2";
+
+	ocp {
+		mcbsp1: mcbsp@48074000 {
+			compatible = "ti,omap2420-mcbsp";
+			reg = <0x48074000 0xff>;
+			reg-names = "mpu";
+			interrupts = <0 59 0x4>, /* TX interrupt */
+				     <0 60 0x4>; /* RX interrupt */
+			interrupt-names = "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,hwmods = "mcbsp1";
+		};
+
+		mcbsp2: mcbsp@48076000 {
+			compatible = "ti,omap2420-mcbsp";
+			reg = <0x48076000 0xff>;
+			reg-names = "mpu";
+			interrupts = <0 62 0x4>, /* TX interrupt */
+				     <0 63 0x4>; /* RX interrupt */
+			interrupt-names = "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,hwmods = "mcbsp2";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
new file mode 100644
index 0000000..531e346
--- /dev/null
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -0,0 +1,83 @@
+/*
+ * Device Tree Source for OMAP243x SoC
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "omap2.dtsi"
+
+/ {
+	compatible = "ti,omap2430", "ti,omap2";
+
+	ocp {
+		mcbsp1: mcbsp@48074000 {
+			compatible = "ti,omap2430-mcbsp";
+			reg = <0x48074000 0xff>;
+			reg-names = "mpu";
+			interrupts = <0 64 0x4>, /* OCP compliant interrupt */
+				     <0 59 0x4>, /* TX interrupt */
+				     <0 60 0x4>, /* RX interrupt */
+				     <0 61 0x4>; /* RX overflow interrupt */
+			interrupt-names = "common", "tx", "rx", "rx_overflow";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp1";
+		};
+
+		mcbsp2: mcbsp@48076000 {
+			compatible = "ti,omap2430-mcbsp";
+			reg = <0x48076000 0xff>;
+			reg-names = "mpu";
+			interrupts = <0 16 0x4>, /* OCP compliant interrupt */
+				     <0 62 0x4>, /* TX interrupt */
+				     <0 63 0x4>; /* RX interrupt */
+			interrupt-names = "common", "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp2";
+		};
+
+		mcbsp3: mcbsp@4808c000 {
+			compatible = "ti,omap2430-mcbsp";
+			reg = <0x4808c000 0xff>;
+			reg-names = "mpu";
+			interrupts = <0 17 0x4>, /* OCP compliant interrupt */
+				     <0 89 0x4>, /* TX interrupt */
+				     <0 90 0x4>; /* RX interrupt */
+			interrupt-names = "common", "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp3";
+		};
+
+		mcbsp4: mcbsp@4808e000 {
+			compatible = "ti,omap2430-mcbsp";
+			reg = <0x4808e000 0xff>;
+			reg-names = "mpu";
+			interrupts = <0 18 0x4>, /* OCP compliant interrupt */
+				     <0 54 0x4>, /* TX interrupt */
+				     <0 55 0x4>; /* RX interrupt */
+			interrupt-names = "common", "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp4";
+		};
+
+		mcbsp5: mcbsp@48096000 {
+			compatible = "ti,omap2430-mcbsp";
+			reg = <0x48096000 0xff>;
+			reg-names = "mpu";
+			interrupts = <0 19 0x4>, /* OCP compliant interrupt */
+				     <0 81 0x4>, /* TX interrupt */
+				     <0 82 0x4>; /* RX interrupt */
+			interrupt-names = "common", "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp5";
+		};
+	};
+};
-- 
1.7.8.6

