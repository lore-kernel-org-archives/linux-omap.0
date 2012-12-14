From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] ARM: OMAP4: clock data: DPLLs are missing bypass clocks
 in their parent lists
Date: Fri, 14 Dec 2012 00:32:52 -0700
Message-ID: <20121214073251.24383.67602.stgit@dusk.lan>
References: <20121214072028.24383.41000.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56605 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab2LNHfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 02:35:24 -0500
In-Reply-To: <20121214072028.24383.41000.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mike Turquette <mturquette@linaro.org>

Booting OMAP4460 Pandaboard ES with a recent u-boot results in this
warning:

WARNING: at arch/arm/mach-omap2/dpll3xxx.c:427 omap3_noncore_dpll_enable+0xf4/0x110()

The OMAP4 DPLL parent clock name arrays only listed the reference
clocks, not the bypass clocks.  Fix by adding the bypass clocks to the
DPLL parent lists.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-omap2/cclock44xx_data.c |   31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index a3c54b2..4536bae 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -233,7 +233,7 @@ static struct dpll_data dpll_core_dd = {
 
 
 static const char *dpll_core_ck_parents[] = {
-	"sys_clkin_ck",
+	"sys_clkin_ck", "core_hsd_byp_clk_mux_ck"
 };
 
 static struct clk dpll_core_ck;
@@ -363,6 +363,10 @@ static struct dpll_data dpll_iva_dd = {
 	.min_divider	= 1,
 };
 
+static const char *dpll_iva_ck_parents[] = {
+	"sys_clkin_ck", "iva_hsd_byp_clk_mux_ck"
+};
+
 static struct clk dpll_iva_ck;
 
 static struct clk_hw_omap dpll_iva_ck_hw = {
@@ -373,7 +377,7 @@ static struct clk_hw_omap dpll_iva_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_iva_ck, dpll_core_ck_parents, dpll_abe_ck_ops);
+DEFINE_STRUCT_CLK(dpll_iva_ck, dpll_iva_ck_parents, dpll_abe_ck_ops);
 
 static const char *dpll_iva_x2_ck_parents[] = {
 	"dpll_iva_ck",
@@ -416,6 +420,10 @@ static struct dpll_data dpll_mpu_dd = {
 	.min_divider	= 1,
 };
 
+static const char *dpll_mpu_ck_parents[] = {
+	"sys_clkin_ck", "div_mpu_hs_clk"
+};
+
 static struct clk dpll_mpu_ck;
 
 static struct clk_hw_omap dpll_mpu_ck_hw = {
@@ -426,7 +434,7 @@ static struct clk_hw_omap dpll_mpu_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_mpu_ck, dpll_core_ck_parents, dpll_abe_ck_ops);
+DEFINE_STRUCT_CLK(dpll_mpu_ck, dpll_mpu_ck_parents, dpll_abe_ck_ops);
 
 DEFINE_CLK_FIXED_FACTOR(mpu_periphclk, "dpll_mpu_ck", &dpll_mpu_ck, 0x0, 1, 2);
 
@@ -464,6 +472,9 @@ static struct dpll_data dpll_per_dd = {
 	.min_divider	= 1,
 };
 
+static const char *dpll_per_ck_parents[] = {
+	"sys_clkin_ck", "per_hsd_byp_clk_mux_ck"
+};
 
 static struct clk dpll_per_ck;
 
@@ -475,7 +486,7 @@ static struct clk_hw_omap dpll_per_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_per_ck, dpll_core_ck_parents, dpll_abe_ck_ops);
+DEFINE_STRUCT_CLK(dpll_per_ck, dpll_per_ck_parents, dpll_abe_ck_ops);
 
 DEFINE_CLK_DIVIDER(dpll_per_m2_ck, "dpll_per_ck", &dpll_per_ck, 0x0,
 		   OMAP4430_CM_DIV_M2_DPLL_PER, OMAP4430_DPLL_CLKOUT_DIV_SHIFT,
@@ -559,6 +570,10 @@ static struct dpll_data dpll_usb_dd = {
 	.min_divider	= 1,
 };
 
+static const char *dpll_usb_ck_parents[] = {
+	"sys_clkin_ck", "usb_hs_clk_div_ck"
+};
+
 static struct clk dpll_usb_ck;
 
 static struct clk_hw_omap dpll_usb_ck_hw = {
@@ -569,7 +584,7 @@ static struct clk_hw_omap dpll_usb_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_usb_ck, dpll_core_ck_parents, dpll_abe_ck_ops);
+DEFINE_STRUCT_CLK(dpll_usb_ck, dpll_usb_ck_parents, dpll_abe_ck_ops);
 
 static const char *dpll_usb_clkdcoldo_ck_parents[] = {
 	"dpll_usb_ck",
@@ -696,9 +711,13 @@ DEFINE_CLK_DIVIDER(syc_clk_div_ck, "sys_clkin_ck", &sys_clkin_ck, 0x0,
 		   OMAP4430_CM_ABE_DSS_SYS_CLKSEL, OMAP4430_CLKSEL_0_0_SHIFT,
 		   OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
+static const char *dbgclk_mux_ck_parents[] = {
+	"sys_clkin_ck"
+};
+
 static struct clk dbgclk_mux_ck;
 DEFINE_STRUCT_CLK_HW_OMAP(dbgclk_mux_ck, NULL);
-DEFINE_STRUCT_CLK(dbgclk_mux_ck, dpll_core_ck_parents,
+DEFINE_STRUCT_CLK(dbgclk_mux_ck, dbgclk_mux_ck_parents,
 		  dpll_usb_clkdcoldo_ck_ops);
 
 /* Leaf clocks controlled by modules */


