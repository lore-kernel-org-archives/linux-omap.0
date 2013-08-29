From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 28/45] ARM: dts: AM35xx: use DT clock data
Date: Thu, 29 Aug 2013 16:16:20 +0300
Message-ID: <1377782197-10611-29-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49120 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511Ab3H2NSV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:18:21 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

AM35xx now uses the clock data from device tree. Most of the data is
shared with OMAP3xxx, but as there is some delta, a new base .dtsi
file is also created for the SoC.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am3517-evm.dts        |    2 +-
 arch/arm/boot/dts/am3517.dtsi           |  116 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am3517_mt_ventoux.dts |    2 +-
 3 files changed, 118 insertions(+), 2 deletions(-)
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
index 0000000..47aa7c2
--- /dev/null
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -0,0 +1,116 @@
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
+
+	clockdomains {
+		dss_clkdm: dss_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dss1_alwon_fck_3430es2>, <&dss_ick_3430es2>;
+		};
+
+		usbhost_clkdm: usbhost_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&usbhost_48m_fck>, <&usbhost_ick>;
+		};
+
+		core_l4_clkdm: core_l4_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&mmchs1_ick>, <&mmchs2_ick>, <&hdq_fck>,
+				 <&uart1_ick>, <&mcspi4_fck>, <&i2c3_fck>,
+				 <&mcspi2_ick>, <&uart2_ick>, <&mcspi3_ick>,
+				 <&i2c1_fck>, <&hdq_ick>, <&sha12_ick>,
+				 <&mcbsp5_ick>, <&mcspi3_fck>, <&aes2_ick>,
+				 <&mcspi1_ick>, <&uart2_fck>, <&mmchs2_fck>,
+				 <&mmchs1_fck>, <&i2c3_ick>, <&mcspi1_fck>,
+				 <&mcspi4_ick>, <&omapctrl_ick>, <&mcbsp1_ick>,
+				 <&mcspi2_fck>, <&gpt10_ick>, <&i2c2_fck>,
+				 <&i2c2_ick>, <&gpt11_ick>, <&i2c1_ick>,
+				 <&uart1_fck>;
+		};
+
+		wkup_clkdm: wkup_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&wdt1_ick>, <&gpt12_ick>, <&gpio1_ick>,
+				 <&gpt1_ick>, <&omap_32ksync_ick>, <&wdt2_ick>,
+				 <&wdt2_fck>;
+		};
+
+		dpll4_clkdm: dpll4_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll4_ck>;
+		};
+
+		core_l3_clkdm: core_l3_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&sdrc_ick>;
+		};
+
+		per_clkdm: per_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&gpt2_ick>, <&uart3_fck>, <&gpio3_ick>,
+				 <&mcbsp2_ick>, <&gpt6_ick>, <&mcbsp4_ick>,
+				 <&gpt4_ick>, <&mcbsp3_ick>, <&gpt8_ick>,
+				 <&uart3_ick>, <&gpt5_ick>, <&gpt7_ick>,
+				 <&gpio2_ick>, <&gpio6_ick>, <&gpt9_ick>,
+				 <&gpt3_ick>, <&gpio5_ick>, <&wdt3_ick>,
+				 <&gpio4_ick>, <&wdt3_fck>, <&uart4_ick>;
+		};
+
+		emu_clkdm: emu_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&emu_src_ck>;
+		};
+
+		sgx_clkdm: sgx_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&sgx_ick>;
+		};
+
+		dpll3_clkdm: dpll3_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll3_ck>;
+		};
+
+		dpll5_clkdm: dpll5_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll5_ck>;
+		};
+
+		dpll1_clkdm: dpll1_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll1_ck>;
+		};
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

