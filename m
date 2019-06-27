From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 03/95] ARM: dts: dra71x: Disable rtc target module
Date: Wed, 26 Jun 2019 20:28:48 -0400
Message-ID: <20190627003021.19867-3-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit fe9edfe648ac444150ec95da1fb10e2728cc9789 ]

Introduce dra71x.dtsi to include dra71x specific changes.
rtc is fused out on dra71 and accessing target module
register is causing a boot crash hence disable it.

Fixes: 549fce068a3112 ("ARM: dts: dra7: Add l4 interconnect hierarchy and ti-sysc data")
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dra71-evm.dts |  2 +-
 arch/arm/boot/dts/dra71x.dtsi   | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/dra71x.dtsi

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index 82cc7ec37af0..c496ae83e27e 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -6,7 +6,7 @@
  * published by the Free Software Foundation.
  */
 
-#include "dra72-evm-common.dtsi"
+#include "dra71x.dtsi"
 #include "dra7-mmc-iodelay.dtsi"
 #include "dra72x-mmc-iodelay.dtsi"
 #include <dt-bindings/net/ti-dp83867.h>
diff --git a/arch/arm/boot/dts/dra71x.dtsi b/arch/arm/boot/dts/dra71x.dtsi
new file mode 100644
index 000000000000..aad7394902a6
--- /dev/null
+++ b/arch/arm/boot/dts/dra71x.dtsi
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "dra72-evm-common.dtsi"
+
+&rtctarget {
+	status = "disabled";
+};
-- 
2.20.1
