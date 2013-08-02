From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 29/31] ARM: dts: AM35xx: use DT clock data
Date: Fri, 2 Aug 2013 19:25:48 +0300
Message-ID: <1375460751-23676-30-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40806 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab3HBQ1y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:27:54 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

AM35xx now uses the clock data from device tree. Most of the data is
shared with OMAP3xxx, but as there is some delta, a new base .dtsi
file is also created for the SoC.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am3517-evm.dts        |    2 +-
 arch/arm/boot/dts/am3517.dtsi           |   36 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am3517_mt_ventoux.dts |    2 +-
 3 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/am3517.dtsi

diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index e99dfaf..9ff51d7 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-#include "omap34xx.dtsi"
+#include "am3517.dtsi"
 
 / {
 	model = "TI AM3517 EVM (AM3517/05)";
diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
new file mode 100644
index 0000000..cb7a58d
--- /dev/null
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -0,0 +1,36 @@
+/*
+ * Device Tree Source for AM3517 SoC
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include "omap3.dtsi"
+
+/ {
+	cpus {
+		cpu@0 {
+			/* OMAP343x/OMAP35xx variants OPP1-5 */
+			operating-points = <
+				/* kHz    uV */
+				125000   975000
+				250000  1075000
+				500000  1200000
+				550000  1270000
+				600000  1350000
+			>;
+			clock-latency = <300000>; /* From legacy driver */
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/include/ "am35xx-clocks.dtsi"
+		/include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
+	};
+};
diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dts/am3517_mt_ventoux.dts
index fdf5ce6..d00e934 100644
--- a/arch/arm/boot/dts/am3517_mt_ventoux.dts
+++ b/arch/arm/boot/dts/am3517_mt_ventoux.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-#include "omap34xx.dtsi"
+#include "am3517.dtsi"
 
 / {
 	model = "TeeJet Mt.Ventoux";
-- 
1.7.9.5

