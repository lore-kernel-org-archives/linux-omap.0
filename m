From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 11/13] arm/dts: OMAP5: Add omap5 dts files
Date: Thu, 3 May 2012 12:56:20 +0530
Message-ID: <1336029982-31898-12-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46876 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab2ECH0i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 03:26:38 -0400
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com

Adding the minimum device tree files required for
OMAP5 to boot.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 arch/arm/boot/dts/omap5-evm.dts                    |   20 ++
 arch/arm/boot/dts/omap5.dtsi                       |  201 ++++++++++++++++++++
 3 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap5-evm.dts
 create mode 100644 arch/arm/boot/dts/omap5.dtsi

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index e78e8bc..3d450f6 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -47,3 +47,6 @@ Boards:
 
 - AM335X EVM : Software Developement Board for AM335x
   compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
+
+- OMAP5 EVM : Evaluation Module
+  compatible = "ti,omap5-evm", "ti,omap5"
diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
new file mode 100644
index 0000000..200c39a
--- /dev/null
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "omap5.dtsi"
+
+/ {
+	model = "TI OMAP5 EVM board";
+	compatible = "ti,omap5-evm", "ti,omap5";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>; /* 1 GB */
+	};
+};
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
new file mode 100644
index 0000000..b50c28d
--- /dev/null
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -0,0 +1,201 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ * Based on "omap4.dtsi"
+ */
+
+/*
+ * Carveout for multimedia usecases
+ * It should be the last 48MB of the first 512MB memory part
+ * In theory, it should not even exist. That zone should be reserved
+ * dynamically during the .reserve callback.
+ */
+/memreserve/ 0x9d000000 0x03000000;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "ti,omap5";
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		serial5 = &uart6;
+	};
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a15";
+		};
+		cpu@1 {
+			compatible = "arm,cortex-a15";
+		};
+	};
+
+	/*
+	 * The soc node represents the soc top level view. It is uses for IPs
+	 * that are not memory mapped in the MPU view or for the MPU itself.
+	 */
+	soc {
+		compatible = "ti,omap-infra";
+		mpu {
+			compatible = "ti,omap5-mpu";
+			ti,hwmods = "mpu";
+		};
+	};
+
+	/*
+	 * XXX: Use a flat representation of the OMAP4 interconnect.
+	 * The real OMAP interconnect network is quite complex.
+	 *
+	 * MPU -+-- MPU_PRIVATE - GIC, L2
+	 *      |
+	 *      +----------------+----------+
+	 *      |                |          |
+	 *      +            +- EMIF - DDR  |
+	 *      |            |              |
+	 *      |            +     +--------+
+	 *      |            |     |
+	 *      |            +- L4_ABE - AESS, MCBSP, TIMERs...
+	 *      |            |
+	 *      +- L3_MAIN --+- L4_CORE - IPs...
+	 *                   |
+	 *                   +- L4_PER - IPs...
+	 *                   |
+	 *
+	 * Since that will not bring real advantage to represent that in DT for
+	 * the moment, just use a fake OCP bus entry to represent the whole bus
+	 * hierarchy.
+	 */
+	ocp {
+		compatible = "ti,omap4-l3-noc", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
+
+		gic: interrupt-controller@48211000 {
+			compatible = "arm,cortex-a15-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x48211000 0x1000>,
+			      <0x48212000 0x1000>;
+		};
+
+		gpio1: gpio@4ae10000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio1";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio2: gpio@48055000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio2";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio3: gpio@48057000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio3";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio4: gpio@48059000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio4";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio5: gpio@4805b000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio5";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio6: gpio@4805d000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio6";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio7: gpio@48051000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio7";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio8: gpio@48053000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio8";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		uart1: serial@4806a000 {
+			compatible = "ti,omap4-uart";
+			ti,hwmods = "uart1";
+			clock-frequency = <48000000>;
+		};
+
+		uart2: serial@4806c000 {
+			compatible = "ti,omap4-uart";
+			ti,hwmods = "uart2";
+			clock-frequency = <48000000>;
+		};
+
+		uart3: serial@48020000 {
+			compatible = "ti,omap4-uart";
+			ti,hwmods = "uart3";
+			clock-frequency = <48000000>;
+		};
+
+		uart4: serial@4806e000 {
+			compatible = "ti,omap4-uart";
+			ti,hwmods = "uart4";
+			clock-frequency = <48000000>;
+		};
+
+		uart5: serial@48066000 {
+			compatible = "ti,omap5-uart";
+			ti,hwmods = "uart5";
+			clock-frequency = <48000000>;
+		};
+
+		uart6: serial@48068000 {
+			compatible = "ti,omap6-uart";
+			ti,hwmods = "uart6";
+			clock-frequency = <48000000>;
+		};
+	};
+};
+
-- 
1.7.1

