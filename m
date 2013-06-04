From: Mike Turquette <mturquette@linaro.org>
Subject: [PATCH RFC 3/3] ARM: omap4: register DT clocks & remove old data
Date: Mon,  3 Jun 2013 23:39:18 -0700
Message-ID: <1370327958-19776-4-git-send-email-mturquette@linaro.org>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:51616 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757966Ab3FDGjm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jun 2013 02:39:42 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so6770418pbc.9
        for <linux-omap@vger.kernel.org>; Mon, 03 Jun 2013 23:39:41 -0700 (PDT)
In-Reply-To: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Tero Kristo <t-kristo@ti.com>, Rajendra <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Mike Turquette <mturquette@linaro.org>, Joel A Fernandes <joelagnel@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Now that some of the OMAP4 PRCM clock data has been converted to a
DeviceTree representation it is no longer needed as static clock data.
Register the DT clocks first, followed by the remaining static clocks.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Joel A Fernandes <joelagnel@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-omap2/cclock44xx_data.c | 54 ++++-------------------------------
 1 file changed, 6 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index 88e37a4..97fd65c 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -27,6 +27,7 @@
 #include <linux/clk-private.h>
 #include <linux/clkdev.h>
 #include <linux/io.h>
+#include <linux/clk/omap.h>
 
 #include "soc.h"
 #include "iomap.h"
@@ -61,18 +62,12 @@
 
 /* Root clocks */
 
-DEFINE_CLK_FIXED_RATE(extalt_clkin_ck, CLK_IS_ROOT, 59000000, 0x0);
-
 DEFINE_CLK_FIXED_RATE(pad_clks_src_ck, CLK_IS_ROOT, 12000000, 0x0);
 
 DEFINE_CLK_GATE(pad_clks_ck, "pad_clks_src_ck", &pad_clks_src_ck, 0x0,
 		OMAP4430_CM_CLKSEL_ABE, OMAP4430_PAD_CLKS_GATE_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_FIXED_RATE(pad_slimbus_core_clks_ck, CLK_IS_ROOT, 12000000, 0x0);
-
-DEFINE_CLK_FIXED_RATE(secure_32k_clk_src_ck, CLK_IS_ROOT, 32768, 0x0);
-
 DEFINE_CLK_FIXED_RATE(slimbus_src_clk, CLK_IS_ROOT, 12000000, 0x0);
 
 DEFINE_CLK_GATE(slimbus_clk, "slimbus_src_clk", &slimbus_src_clk, 0x0,
@@ -81,20 +76,6 @@ DEFINE_CLK_GATE(slimbus_clk, "slimbus_src_clk", &slimbus_src_clk, 0x0,
 
 DEFINE_CLK_FIXED_RATE(sys_32k_ck, CLK_IS_ROOT, 32768, 0x0);
 
-DEFINE_CLK_FIXED_RATE(virt_12000000_ck, CLK_IS_ROOT, 12000000, 0x0);
-
-DEFINE_CLK_FIXED_RATE(virt_13000000_ck, CLK_IS_ROOT, 13000000, 0x0);
-
-DEFINE_CLK_FIXED_RATE(virt_16800000_ck, CLK_IS_ROOT, 16800000, 0x0);
-
-DEFINE_CLK_FIXED_RATE(virt_19200000_ck, CLK_IS_ROOT, 19200000, 0x0);
-
-DEFINE_CLK_FIXED_RATE(virt_26000000_ck, CLK_IS_ROOT, 26000000, 0x0);
-
-DEFINE_CLK_FIXED_RATE(virt_27000000_ck, CLK_IS_ROOT, 27000000, 0x0);
-
-DEFINE_CLK_FIXED_RATE(virt_38400000_ck, CLK_IS_ROOT, 38400000, 0x0);
-
 static const char *sys_clkin_ck_parents[] = {
 	"virt_12000000_ck", "virt_13000000_ck", "virt_16800000_ck",
 	"virt_19200000_ck", "virt_26000000_ck", "virt_27000000_ck",
@@ -105,16 +86,6 @@ DEFINE_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, NULL, 0x0,
 	       OMAP4430_CM_SYS_CLKSEL, OMAP4430_SYS_CLKSEL_SHIFT,
 	       OMAP4430_SYS_CLKSEL_WIDTH, CLK_MUX_INDEX_ONE, NULL);
 
-DEFINE_CLK_FIXED_RATE(tie_low_clock_ck, CLK_IS_ROOT, 0, 0x0);
-
-DEFINE_CLK_FIXED_RATE(utmi_phy_clkout_ck, CLK_IS_ROOT, 60000000, 0x0);
-
-DEFINE_CLK_FIXED_RATE(xclk60mhsp1_ck, CLK_IS_ROOT, 60000000, 0x0);
-
-DEFINE_CLK_FIXED_RATE(xclk60mhsp2_ck, CLK_IS_ROOT, 60000000, 0x0);
-
-DEFINE_CLK_FIXED_RATE(xclk60motg_ck, CLK_IS_ROOT, 60000000, 0x0);
-
 /* Module clocks and DPLL outputs */
 
 static const char *abe_dpll_bypass_clk_mux_ck_parents[] = {
@@ -826,7 +797,7 @@ DEFINE_CLK_GATE(dss_sys_clk, "syc_clk_div_ck", &syc_clk_div_ck, 0x0,
 		OMAP4430_CM_DSS_DSS_CLKCTRL,
 		OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(dss_tv_clk, "extalt_clkin_ck", &extalt_clkin_ck, 0x0,
+DEFINE_CLK_GATE(dss_tv_clk, "extalt_clkin_ck", NULL, 0x0,
 		OMAP4430_CM_DSS_DSS_CLKCTRL,
 		OMAP4430_OPTFCLKEN_TV_CLK_SHIFT, 0x0, NULL);
 
@@ -1051,7 +1022,7 @@ DEFINE_CLK_GATE(slimbus2_fclk_0, "func_24mc_fclk", &func_24mc_fclk, 0x0,
 		OMAP4430_OPTFCLKEN_PER24MC_GFCLK_SHIFT, 0x0, NULL);
 
 DEFINE_CLK_GATE(slimbus2_slimbus_clk, "pad_slimbus_core_clks_ck",
-		&pad_slimbus_core_clks_ck, 0x0,
+		NULL, 0x0,
 		OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
 		OMAP4430_OPTFCLKEN_SLIMBUS_CLK_SHIFT, 0x0, NULL);
 
@@ -1442,27 +1413,11 @@ static struct omap_clk omap443x_clks[] = {
  * clocks common to omap44xx
  */
 static struct omap_clk omap44xx_clks[] = {
-	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck),
 	CLK(NULL,	"pad_clks_src_ck",		&pad_clks_src_ck),
 	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck),
-	CLK(NULL,	"pad_slimbus_core_clks_ck",	&pad_slimbus_core_clks_ck),
-	CLK(NULL,	"secure_32k_clk_src_ck",	&secure_32k_clk_src_ck),
 	CLK(NULL,	"slimbus_src_clk",		&slimbus_src_clk),
 	CLK(NULL,	"slimbus_clk",			&slimbus_clk),
 	CLK(NULL,	"sys_32k_ck",			&sys_32k_ck),
-	CLK(NULL,	"virt_12000000_ck",		&virt_12000000_ck),
-	CLK(NULL,	"virt_13000000_ck",		&virt_13000000_ck),
-	CLK(NULL,	"virt_16800000_ck",		&virt_16800000_ck),
-	CLK(NULL,	"virt_19200000_ck",		&virt_19200000_ck),
-	CLK(NULL,	"virt_26000000_ck",		&virt_26000000_ck),
-	CLK(NULL,	"virt_27000000_ck",		&virt_27000000_ck),
-	CLK(NULL,	"virt_38400000_ck",		&virt_38400000_ck),
-	CLK(NULL,	"sys_clkin_ck",			&sys_clkin_ck),
-	CLK(NULL,	"tie_low_clock_ck",		&tie_low_clock_ck),
-	CLK(NULL,	"utmi_phy_clkout_ck",		&utmi_phy_clkout_ck),
-	CLK(NULL,	"xclk60mhsp1_ck",		&xclk60mhsp1_ck),
-	CLK(NULL,	"xclk60mhsp2_ck",		&xclk60mhsp2_ck),
-	CLK(NULL,	"xclk60motg_ck",		&xclk60motg_ck),
 	CLK(NULL,	"abe_dpll_bypass_clk_mux_ck",	&abe_dpll_bypass_clk_mux_ck),
 	CLK(NULL,	"abe_dpll_refclk_mux_ck",	&abe_dpll_refclk_mux_ck),
 	CLK(NULL,	"dpll_abe_ck",			&dpll_abe_ck),
@@ -1690,6 +1645,9 @@ int __init omap4xxx_clk_init(void)
 {
 	int rc;
 
+	/* FIXME register clocks from DT first */
+	dt_omap_clk_init();
+
 	if (cpu_is_omap443x()) {
 		cpu_mask = RATE_IN_4430;
 		omap_clocks_register(omap443x_clks, ARRAY_SIZE(omap443x_clks));
-- 
1.8.1.2

