From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree data
Date: Tue, 24 Jul 2012 11:48:52 +0530
Message-ID: <1343110735-10640-2-git-send-email-anilkumar@ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60055 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359Ab2GXGTQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 02:19:16 -0400
In-Reply-To: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, AnilKumar Ch <anilkumar@ti.com>

Add device tree data for tps65910 regulator by adding all tps65910
regulator nodes. Regulator is initialized based on compatible name
provided in tps65910 DT file.

All tps65910 PMIC regulator device tree nodes are placed in a
separate device tree include file (tps65910.dtsi). This patch
was tested on AM335x-EVM.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/tps65910.dtsi |   86 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 arch/arm/boot/dts/tps65910.dtsi

diff --git a/arch/arm/boot/dts/tps65910.dtsi b/arch/arm/boot/dts/tps65910.dtsi
new file mode 100644
index 0000000..92693a8
--- /dev/null
+++ b/arch/arm/boot/dts/tps65910.dtsi
@@ -0,0 +1,86 @@
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
+		};
+
+		vio_reg: regulator@1 {
+			reg = <1>;
+			regulator-compatible = "vio";
+		};
+
+		vdd1_reg: regulator@2 {
+			reg = <2>;
+			regulator-compatible = "vdd1";
+		};
+
+		vdd2_reg: regulator@3 {
+			reg = <3>;
+			regulator-compatible = "vdd2";
+		};
+
+		vdd3_reg: regulator@4 {
+			reg = <4>;
+			regulator-compatible = "vdd3";
+		};
+
+		vdig1_reg: regulator@5 {
+			reg = <5>;
+			regulator-compatible = "vdig1";
+		};
+
+		vdig2_reg: regulator@6 {
+			reg = <6>;
+			regulator-compatible = "vdig2";
+		};
+
+		vpll_reg: regulator@7 {
+			reg = <7>;
+			regulator-compatible = "vpll";
+		};
+
+		vdac_reg: regulator@8 {
+			reg = <8>;
+			regulator-compatible = "vdac";
+		};
+
+		vaux1_reg: regulator@9 {
+			reg = <9>;
+			regulator-compatible = "vaux1";
+		};
+
+		vaux2_reg: regulator@10 {
+			reg = <10>;
+			regulator-compatible = "vaux2";
+		};
+
+		vaux33_reg: regulator@11 {
+			reg = <11>;
+			regulator-compatible = "vaux33";
+		};
+
+		vmmc_reg: regulator@12 {
+			reg = <12>;
+			regulator-compatible = "vmmc";
+		};
+	};
+};
-- 
1.7.9.5

