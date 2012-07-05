From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v1 12/14] arm/dts: OMAP5: Add omap5 dts files
Date: Thu, 5 Jul 2012 17:38:54 +0530
Message-ID: <1341490136-25901-17-git-send-email-santosh.shilimkar@ti.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34054 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725Ab2GEMKi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 08:10:38 -0400
In-Reply-To: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, R Sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: R Sricharan <r.sricharan@ti.com>

Adding the minimum device tree files required for
OMAP5 to boot.

Reviewed-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts |   20 +++++
 arch/arm/boot/dts/omap5.dtsi    |  184 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap5-evm.dts
 create mode 100644 arch/arm/boot/dts/omap5.dtsi

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
index 0000000..57e5270
--- /dev/null
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -0,0 +1,184 @@
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
+	 * XXX: Use a flat representation of the OMAP3 interconnect.
+	 * The real OMAP interconnect network is quite complex.
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
-- 
1.7.9.5

