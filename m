From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 1/8] ARM/dts: omap2: Add McBSP entries for OMAP2420 and OMAP2430 SoC
Date: Wed,  5 Sep 2012 14:58:49 +0300
Message-ID: <1346846336-27321-2-git-send-email-peter.ujfalusi@ti.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56605 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752464Ab2IEL6q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 07:58:46 -0400
Received: by ghrr11 with SMTP id r11so51346ghr.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 04:58:45 -0700 (PDT)
In-Reply-To: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

The McBSP IP within OMAP2420 and 2430 is different we need to create separate
dtsi files for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi | 39 +++++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi | 83 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap2420.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430.dtsi

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
new file mode 100644
index 0000000..6174d3d
--- /dev/null
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -0,0 +1,39 @@
+/*
+ * Device Tree Source for OMAP2420 SoC
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
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
+			interrupts = <59>, /* TX interrupt */
+				     <60>; /* RX interrupt */
+			interrupt-names = "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,hwmods = "mcbsp1";
+		};
+
+		mcbsp2: mcbsp@48076000 {
+			compatible = "ti,omap2420-mcbsp";
+			reg = <0x48076000 0xff>;
+			reg-names = "mpu";
+			interrupts = <62>, /* TX interrupt */
+				     <63>; /* RX interrupt */
+			interrupt-names = "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,hwmods = "mcbsp2";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
new file mode 100644
index 0000000..59a639a
--- /dev/null
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -0,0 +1,83 @@
+/*
+ * Device Tree Source for OMAP243x SoC
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
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
+			interrupts = <64>, /* OCP compliant interrupt */
+				     <59>, /* TX interrupt */
+				     <60>, /* RX interrupt */
+				     <61>; /* RX overflow interrupt */
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
+			interrupts = <16>, /* OCP compliant interrupt */
+				     <62>, /* TX interrupt */
+				     <63>; /* RX interrupt */
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
+			interrupts = <17>, /* OCP compliant interrupt */
+				     <89>, /* TX interrupt */
+				     <90>; /* RX interrupt */
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
+			interrupts = <18>, /* OCP compliant interrupt */
+				     <54>, /* TX interrupt */
+				     <55>; /* RX interrupt */
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
+			interrupts = <19>, /* OCP compliant interrupt */
+				     <81>, /* TX interrupt */
+				     <82>; /* RX interrupt */
+			interrupt-names = "common", "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp5";
+		};
+	};
+};
-- 
1.7.12

