From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 09/10] arm: dra7: add DESHDCP clock
Date: Tue, 24 Mar 2015 16:55:09 +0200
Message-ID: <1427208910-17678-10-git-send-email-tomi.valkeinen@ti.com>
References: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46199 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374AbbCXO4P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 10:56:15 -0400
In-Reply-To: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add a new Linux clock for DRA7 based SoCs to control DESHDCP clock.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi               |  5 +++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi      | 10 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  1 +
 drivers/clk/ti/clk-7xx.c                  |  1 +
 4 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 312ede660b23..c06f30a76f5c 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -123,6 +123,11 @@
 							regulator-max-microvolt = <3000000>;
 						};
 					};
+
+					scm_conf_clocks: clocks {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
 				};
 
 				dra7_pmx_core: pinmux@1400 {
diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 0d76233840e6..a93754cf5e2f 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2057,3 +2057,13 @@
 		clocks = <&dpll_usb_ck>;
 	};
 };
+
+&scm_conf_clocks {
+	dss_deshdcp_clk: dss_deshdcp_clk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l3_iclk_div>;
+		ti,bit-shift = <0>;
+		reg = <0x558>;
+	};
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 0411b838b4fa..97e3d7a62729 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -459,6 +459,7 @@ static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 	{ .role = "video2_clk", .clk = "dss_video2_clk" },
 	{ .role = "video1_clk", .clk = "dss_video1_clk" },
 	{ .role = "hdmi_clk", .clk = "dss_hdmi_clk" },
+	{ .role = "hdcp_clk", .clk = "dss_deshdcp_clk" },
 };
 
 static struct omap_hwmod dra7xx_dss_hwmod = {
diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index ee32f4deebf4..7b859ec31a14 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -301,6 +301,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK("48824000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("48826000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK(NULL, "sys_clkin", "sys_clkin1"),
+	DT_CLK(NULL, "dss_deshdcp_clk", "dss_deshdcp_clk"),
 	{ .node_name = NULL },
 };
 
-- 
2.3.3

