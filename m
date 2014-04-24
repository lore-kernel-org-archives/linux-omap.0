From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 2/4] ARM: dts: Add support for DRA72x family of devices
Date: Thu, 24 Apr 2014 15:36:25 +0530
Message-ID: <1398333987-19454-3-git-send-email-rnayak@ti.com>
References: <1398333987-19454-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58538 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687AbaDXKI3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:08:29 -0400
In-Reply-To: <1398333987-19454-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, nm@ti.com, arnd@arndb.de, Rajendra Nayak <rnayak@ti.com>, linux-doc@vger.kernel.org

DRA72x is a single core cortex A15 device with most infrastructure IPs otherwise
same as whats on the DRA74x devices.

So move the cpu nodes into dra74x.dtsi and dra72x.dtsi respectively.

Also add a minimal dra72-evm dts file.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: linux-doc@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/arm/omap/omap.txt          |   14 +++++--
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    6 +--
 arch/arm/boot/dts/dra7.dtsi                        |   27 -------------
 arch/arm/boot/dts/dra72-evm.dts                    |   24 ++++++++++++
 arch/arm/boot/dts/dra72x.dtsi                      |   25 ++++++++++++
 arch/arm/boot/dts/dra74x.dtsi                      |   41 ++++++++++++++++++++
 7 files changed, 105 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72x.dtsi
 create mode 100644 arch/arm/boot/dts/dra74x.dtsi

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 36ede19..1bc2338 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -79,8 +79,11 @@ SoCs:
 - OMAP5432
   compatible = "ti,omap5432", "ti,omap5"
 
-- DRA742
-  compatible = "ti,dra7xx", "ti,dra7"
+- DRA74x
+  compatible = "ti,dra74", "ti,dra7"
+
+- DRA72x
+  compatible = "ti,dra72", "ti,dra7"
 
 - AM4372
   compatible = "ti,am4372", "ti,am43"
@@ -120,5 +123,8 @@ Boards:
 - AM437x GP EVM
   compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
 
-- DRA7 EVM:  Software Developement Board for DRA7XX
-  compatible = "ti,dra7-evm", "ti,dra7"
+- DRA74 EVM:  Software Developement Board for DRA74x
+  compatible = "ti,dra7-evm", "ti,dra74", "ti,dra7"
+
+- DRA72 EVM: Software Development Board for DRA72x
+  compatible = "ti,dra72-evm", "ti,dra72", "ti,dra7"
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 35c146f..ff98a97 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -288,7 +288,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	am3517_mt_ventoux.dtb \
 	am43x-epos-evm.dtb \
 	am437x-gp-evm.dtb \
-	dra7-evm.dtb
+	dra7-evm.dtb \
+	dra72-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_QCOM) += qcom-msm8660-surf.dtb \
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 7807429..df6a6db 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -7,11 +7,11 @@
  */
 /dts-v1/;
 
-#include "dra7.dtsi"
+#include "dra74x.dtsi"
 
 / {
-	model = "TI DRA7";
-	compatible = "ti,dra7-evm", "ti,dra7";
+	model = "TI DRA74x";
+	compatible = "ti,dra7-evm", "ti,dra74", "ti,dra7";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1c0f8e1..e27fec7 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -33,33 +33,6 @@
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
-
-			clocks = <&dpll_mpu_ck>;
-			clock-names = "cpu";
-
-			clock-latency = <300000>; /* From omap-cpufreq driver */
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
index 0000000..ead6440
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
+	compatible = "ti,dra72-evm", "ti,dra72", "ti,dra7";
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
index 0000000..236e5e3
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
+	compatible = "ti,dra72", "ti,dra7";
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
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
new file mode 100644
index 0000000..493deab
--- /dev/null
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -0,0 +1,41 @@
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
+	compatible = "ti,dra74", "ti,dra7";
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
+
+			clocks = <&dpll_mpu_ck>;
+			clock-names = "cpu";
+
+			clock-latency = <300000>; /* From omap-cpufreq driver */
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

