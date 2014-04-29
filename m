From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v4 2/5] ARM: dts: Add support for DRA72x family of devices
Date: Tue, 29 Apr 2014 16:35:10 +0530
Message-ID: <1398769513-8736-3-git-send-email-rnayak@ti.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, nm@ti.com, arnd@arndb.de, s-anna@ti.com, Rajendra Nayak <rnayak@ti.com>, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

DRA722 is part of DRA72x family which are single core cortex A15 devices
with most infrastructure IPs otherwise same as whats on the DRA74x family.

So move the cpu nodes into dra74x.dtsi and dra72x.dtsi respectively.

Also add a minimal dra72-evm dts file.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: linux-doc@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/arm/omap/omap.txt          |   12 ++++--
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    6 +--
 arch/arm/boot/dts/dra7.dtsi                        |   27 -------------
 arch/arm/boot/dts/dra72-evm.dts                    |   24 ++++++++++++
 arch/arm/boot/dts/dra72x.dtsi                      |   25 ++++++++++++
 arch/arm/boot/dts/dra74x.dtsi                      |   41 ++++++++++++++++++++
 7 files changed, 104 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72x.dtsi
 create mode 100644 arch/arm/boot/dts/dra74x.dtsi

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 36ede19..3bad259 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -80,7 +80,10 @@ SoCs:
   compatible = "ti,omap5432", "ti,omap5"
 
 - DRA742
-  compatible = "ti,dra7xx", "ti,dra7"
+  compatible = "ti,dra742", "ti,dra74", "ti,dra7"
+
+- DRA722
+  compatible = "ti,dra722", "ti,dra72", "ti,dra7"
 
 - AM4372
   compatible = "ti,am4372", "ti,am43"
@@ -120,5 +123,8 @@ Boards:
 - AM437x GP EVM
   compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
 
-- DRA7 EVM:  Software Developement Board for DRA7XX
-  compatible = "ti,dra7-evm", "ti,dra7"
+- DRA742 EVM:  Software Developement Board for DRA742
+  compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
+
+- DRA722 EVM: Software Development Board for DRA722
+  compatible = "ti,dra72-evm", "ti,dra722", "ti,dra72", "ti,dra7"
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
index 7807429..39b718a 100644
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
+	model = "TI DRA742";
+	compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7";
 
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
index 0000000..5147023
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
+	model = "TI DRA722";
+	compatible = "ti,dra72-evm", "ti,dra722", "ti,dra72", "ti,dra7";
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
index 0000000..f1ec22f
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
+	compatible = "ti,dra722", "ti,dra72", "ti,dra7";
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
index 0000000..a4e8bb9
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
+	compatible = "ti,dra742", "ti,dra74", "ti,dra7";
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

