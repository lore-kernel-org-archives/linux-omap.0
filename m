From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 2/4] ARM: OMAP2+: AM33XX: Add tps65217 device tree data
Date: Tue, 24 Jul 2012 11:48:53 +0530
Message-ID: <1343110735-10640-3-git-send-email-anilkumar@ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40716 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755363Ab2GXGTU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 02:19:20 -0400
In-Reply-To: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, AnilKumar Ch <anilkumar@ti.com>

Add device tree data for tps65217 regulator by adding all tps65217
regulator nodes. Regulator is initialized based on compatible name
provided in tps65217 DT file.

All tps65217 PMIC regulator device tree nodes are placed in a
separate device tree include file (tps65217.dtsi). This patch
was tested on AM335x-Bone.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/tps65217.dtsi |   56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
new file mode 100644
index 0000000..a632724
--- /dev/null
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -0,0 +1,56 @@
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
+ * http://www.ti.com/lit/ds/symlink/tps65217.pdf
+ */
+
+&tps {
+	compatible = "ti,tps65217";
+
+	regulators {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dcdc1_reg: regulator@0 {
+			reg = <0>;
+			regulator-compatible = "dcdc1";
+		};
+
+		dcdc2_reg: regulator@1 {
+			reg = <1>;
+			regulator-compatible = "dcdc2";
+		};
+
+		dcdc3_reg: regulator@2 {
+			reg = <2>;
+			regulator-compatible = "dcdc3";
+		};
+
+		ldo1_reg: regulator@3 {
+			reg = <3>;
+			regulator-compatible = "ldo1";
+		};
+
+		ldo2_reg: regulator@4 {
+			reg = <4>;
+			regulator-compatible = "ldo2";
+		};
+
+		ldo3_reg: regulator@5 {
+			reg = <5>;
+			regulator-compatible = "ldo3";
+		};
+
+		ldo4_reg: regulator@6 {
+			reg = <6>;
+			regulator-compatible = "ldo4";
+		};
+	};
+};
-- 
1.7.9.5

