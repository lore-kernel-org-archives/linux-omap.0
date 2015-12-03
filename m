From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: dts: Add basic support for dra62x j5-eco SoC
Date: Thu,  3 Dec 2015 15:11:39 -0800
Message-ID: <1449184300-15693-3-git-send-email-tony@atomide.com>
References: <1449184300-15693-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449184300-15693-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The dra762x j5-eco is similar to dm814x with a bit different clocks
and devices.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra62x-clocks.dtsi | 49 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra62x.dtsi        | 23 +++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra62x-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/dra62x.dtsi

diff --git a/arch/arm/boot/dts/dra62x-clocks.dtsi b/arch/arm/boot/dts/dra62x-clocks.dtsi
new file mode 100644
index 0000000..0e49741
--- /dev/null
+++ b/arch/arm/boot/dts/dra62x-clocks.dtsi
@@ -0,0 +1,49 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "dm814x-clocks.dtsi"
+
+/* Compared to dm814x, dra62x does not have hdic, l3 or dss PLLs */
+&adpll_hdvic_ck {
+	status = "disabled";
+};
+
+&adpll_l3_ck {
+	status = "disabled";
+};
+
+&adpll_dss_ck {
+	status = "disabled";
+};
+
+/* Compared to dm814x, dra62x has interconnect clocks on isp PLL */
+&sysclk4_ck {
+	clocks = <&adpll_isp_ck 1>;
+};
+
+&sysclk5_ck {
+	clocks = <&adpll_isp_ck 1>;
+};
+
+&sysclk6_ck {
+	clocks = <&adpll_isp_ck 1>;
+};
+
+/*
+ * Compared to dm814x, dra62x has different shifts and more mux options.
+ * Please add the extra options for ysclk_14 and 16 if really needed.
+ */
+&timer1_fck {
+	clocks = <&sysclk18_ck &aud_clkin0_ck &aud_clkin1_ck
+		  &aud_clkin2_ck &devosc_ck &auxosc_ck &tclkin_ck>;
+	ti,bit-shift = <4>;
+};
+
+&timer2_fck {
+	clocks = <&sysclk18_ck &aud_clkin0_ck &aud_clkin1_ck
+		  &aud_clkin2_ck &devosc_ck &auxosc_ck &tclkin_ck>;
+	ti,bit-shift = <8>;
+};
diff --git a/arch/arm/boot/dts/dra62x.dtsi b/arch/arm/boot/dts/dra62x.dtsi
new file mode 100644
index 0000000..d3cbb4e
--- /dev/null
+++ b/arch/arm/boot/dts/dra62x.dtsi
@@ -0,0 +1,23 @@
+/*
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include "dm814x.dtsi"
+
+/ {
+	compatible = "ti,dra62x";
+};
+
+/* Compared to dm814x, dra62x has different offsets for Ethernet */
+&mac {
+	reg = <0x4a100000 0x800
+		0x4a101200 0x100>;
+};
+
+&davinci_mdio {
+	reg = <0x4a101000 0x100>;
+};
+
+#include "dra62x-clocks.dtsi"
-- 
2.6.2
