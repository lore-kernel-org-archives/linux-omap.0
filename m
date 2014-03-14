From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/3] arm: dts: Add support for DRA72x family of devices
Date: Fri, 14 Mar 2014 14:50:40 +0530
Message-ID: <1394788841-15112-3-git-send-email-rnayak@ti.com>
References: <1394788841-15112-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40101 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898AbaCNJWH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 05:22:07 -0400
In-Reply-To: <1394788841-15112-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, Rajendra Nayak <rnayak@ti.com>

DRA72x is a single core cortex A15 device with most infrastructure IPs otherwise
same as whats on the DRA75x devices.

So move the cpu nodes into dra75x.dtsi and dra72x.dtsi respectively.

Also add a minimal dra72-evm dts file.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    6 ++++
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    4 +--
 arch/arm/boot/dts/dra7.dtsi                        |   22 ------------
 arch/arm/boot/dts/dra72-evm.dts                    |   24 +++++++++++++
 arch/arm/boot/dts/dra72x.dtsi                      |   25 ++++++++++++++
 arch/arm/boot/dts/dra75x.dtsi                      |   36 ++++++++++++++++++++
 7 files changed, 95 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72x.dtsi
 create mode 100644 arch/arm/boot/dts/dra75x.dtsi

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 0491868..a8b1a69 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -82,6 +82,9 @@ SoCs:
 - DRA752
   compatible = "ti,dra7xx", "ti,dra7"
 
+- DRA72x
+  compatible = "ti,dra72x", "ti,dra7"
+
 - AM4372
   compatible = "ti,am4372", "ti,am43"
 
@@ -116,3 +119,6 @@ Boards:
 
 - DRA7 EVM:  Software Developement Board for DRA7XX
   compatible = "ti,dra7-evm", "ti,dra7"
+
+- DRA72 EVM: Software Development Board for DRA72x
+  compatible = "ti,dra72-evm", "ti,dra72x", "ti,dra7"
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0320303..c0231da 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -231,7 +231,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	am3517-evm.dtb \
 	am3517_mt_ventoux.dtb \
 	am43x-epos-evm.dtb \
-	dra7-evm.dtb
+	dra7-evm.dtb \
+	dra72-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..f344de2 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -7,10 +7,10 @@
  */
 /dts-v1/;
 
-#include "dra7.dtsi"
+#include "dra75x.dtsi"
 
 / {
-	model = "TI DRA7";
+	model = "TI DRA75x";
 	compatible = "ti,dra7-evm", "ti,dra752", "ti,dra7";
 
 	memory {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1fd75aa..a1da2c71 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -33,28 +33,6 @@
 		serial5 = &uart6;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0>;
-
-			operating-points = <
-				/* kHz    uV */
-				1000000	1060000
-				1176000	1160000
-				>;
-		};
-		cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <1>;
-		};
-	};
-
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
new file mode 100644
index 0000000..d105e66
--- /dev/null
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "dra72x.dtsi"
+
+/ {
+	model = "TI DRA72x";
+	compatible = "ti,dra72-evm", "ti,dra72x", "ti,dra7";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>; /* 1024 MB */
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
new file mode 100644
index 0000000..701e40c
--- /dev/null
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ * Based on "omap4.dtsi"
+ */
+
+#include "dra7.dtsi"
+
+/ {
+	compatible = "ti,dra72x", "ti,dra7xx";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/dra75x.dtsi b/arch/arm/boot/dts/dra75x.dtsi
new file mode 100644
index 0000000..67da666
--- /dev/null
+++ b/arch/arm/boot/dts/dra75x.dtsi
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ * Based on "omap4.dtsi"
+ */
+
+#include "dra7.dtsi"
+
+/ {
+	compatible = "ti,dra75x", "ti,dra7xx";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+
+			operating-points = <
+				/* kHz    uV */
+				1000000	1060000
+				1176000	1160000
+				>;
+		};
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+		};
+	};
+};
-- 
1.7.9.5

