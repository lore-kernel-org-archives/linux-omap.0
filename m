From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree data
Date: Fri, 20 Jul 2012 12:16:26 +0530
Message-ID: <1342766789-28148-2-git-send-email-anilkumar@ti.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57314 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab2GTGqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 02:46:50 -0400
In-Reply-To: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, AnilKumar Ch <anilkumar@ti.com>

Add device tree data for tps65910 regulator by adding all the
consumers necessary for AM335X-EVM. The data will be map to a
regulator constraints which is required for regulator set_voltage
and get_voltage calls.

All tps65910 PMIC regulator constraints are placed in a seperate
device tree include file (tps65910.dtsi).

This patch is tested by adding the I2C slave address of TPS65910
pmic to am335x-evm.dts file (Not included in this, I2C slave
addition patch will be submitted to linux-omap, where am335x-evm.dts
binding file is available).

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/tps65910.dtsi |  123 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 123 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/tps65910.dtsi

diff --git a/arch/arm/boot/dts/tps65910.dtsi b/arch/arm/boot/dts/tps65910.dtsi
new file mode 100644
index 0000000..b185235
--- /dev/null
+++ b/arch/arm/boot/dts/tps65910.dtsi
@@ -0,0 +1,123 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Integrated Power Management Chip
+ * http://www.ti.com/lit/ds/symlink/tps65910.pdf
+ */
+
+&tps {
+	compatible = "ti,tps65910";
+
+	regulators {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vrtc_reg: regulator@0 {
+			reg = <0>;
+			regulator-compatible = "vrtc";
+			regulator-always-on;
+		};
+
+		vio_reg: regulator@1 {
+			reg = <1>;
+			regulator-compatible = "vio";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vdd1_reg: regulator@2 {
+			reg = <2>;
+			regulator-compatible = "vdd1";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd2_reg: regulator@3 {
+			reg = <3>;
+			regulator-compatible = "vdd2";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd3_reg: regulator@4 {
+			reg = <4>;
+			regulator-compatible = "vdd3";
+			regulator-always-on;
+		};
+
+		vdig1_reg: regulator@5 {
+			reg = <5>;
+			regulator-compatible = "vdig1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <2700000>;
+			regulator-always-on;
+		};
+
+		vdig2_reg: regulator@6 {
+			reg = <6>;
+			regulator-compatible = "vdig2";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		vpll_reg: regulator@7 {
+			reg = <7>;
+			regulator-compatible = "vpll";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
+
+		vdac_reg: regulator@8 {
+			reg = <8>;
+			regulator-compatible = "vdac";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2850000>;
+			regulator-always-on;
+		};
+
+		vaux1_reg: regulator@9 {
+			reg = <9>;
+			regulator-compatible = "vaux1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2850000>;
+			regulator-always-on;
+		};
+
+		vaux2_reg: regulator@10 {
+			reg = <10>;
+			regulator-compatible = "vaux2";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vaux33_reg: regulator@11 {
+			reg = <11>;
+			regulator-compatible = "vaux33";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vmmc_reg: regulator@12 {
+			reg = <12>;
+			regulator-compatible = "vmmc";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+};
-- 
1.7.0.4

