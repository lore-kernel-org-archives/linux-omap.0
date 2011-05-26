From: Nishanth Menon <nm@ti.com>
Subject: [RFC][PATCH 4/9] OMAP4: clocks: distinguish 4430 and 4460
Date: Wed, 25 May 2011 18:56:51 -0700
Message-ID: <1306375016-707-5-git-send-email-nm@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:54316 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757063Ab1EZB5U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 21:57:20 -0400
Received: by mail-yi0-f43.google.com with SMTP id 16so108272yie.30
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 18:57:18 -0700 (PDT)
In-Reply-To: <1306375016-707-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

omap4460 platform has a few clock nodes which are added
and a few which are missing (compared to the 4430 platform)
rename current 4430 definitions to 44XX and followon patches
will introduce the 4460 changes

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c          |  659 +++++++++++++------------
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    2 +
 arch/arm/plat-omap/include/plat/clock.h       |    2 +
 3 files changed, 335 insertions(+), 328 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 8c96567..96c0e3e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1,7 +1,7 @@
 /*
- * OMAP4 Clock data
+ * OMAP44xx Clock data
  *
- * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2009-2011 Texas Instruments, Inc.
  * Copyright (C) 2009-2010 Nokia Corporation
  *
  * Paul Walmsley (paul@pwsan.com)
@@ -127,42 +127,42 @@ static struct clk virt_38400000_ck = {
 };
 
 static const struct clksel_rate div_1_0_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 0, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate div_1_1_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 1, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate div_1_2_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 2, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate div_1_3_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 3, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate div_1_4_rates[] = {
-	{ .div = 1, .val = 4, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 4, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate div_1_5_rates[] = {
-	{ .div = 1, .val = 5, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 5, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate div_1_6_rates[] = {
-	{ .div = 1, .val = 6, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 6, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate div_1_7_rates[] = {
-	{ .div = 1, .val = 7, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 7, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
@@ -285,37 +285,37 @@ static struct clk dpll_abe_x2_ck = {
 };
 
 static const struct clksel_rate div31_1to31_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
-	{ .div = 2, .val = 2, .flags = RATE_IN_4430 },
-	{ .div = 3, .val = 3, .flags = RATE_IN_4430 },
-	{ .div = 4, .val = 4, .flags = RATE_IN_4430 },
-	{ .div = 5, .val = 5, .flags = RATE_IN_4430 },
-	{ .div = 6, .val = 6, .flags = RATE_IN_4430 },
-	{ .div = 7, .val = 7, .flags = RATE_IN_4430 },
-	{ .div = 8, .val = 8, .flags = RATE_IN_4430 },
-	{ .div = 9, .val = 9, .flags = RATE_IN_4430 },
-	{ .div = 10, .val = 10, .flags = RATE_IN_4430 },
-	{ .div = 11, .val = 11, .flags = RATE_IN_4430 },
-	{ .div = 12, .val = 12, .flags = RATE_IN_4430 },
-	{ .div = 13, .val = 13, .flags = RATE_IN_4430 },
-	{ .div = 14, .val = 14, .flags = RATE_IN_4430 },
-	{ .div = 15, .val = 15, .flags = RATE_IN_4430 },
-	{ .div = 16, .val = 16, .flags = RATE_IN_4430 },
-	{ .div = 17, .val = 17, .flags = RATE_IN_4430 },
-	{ .div = 18, .val = 18, .flags = RATE_IN_4430 },
-	{ .div = 19, .val = 19, .flags = RATE_IN_4430 },
-	{ .div = 20, .val = 20, .flags = RATE_IN_4430 },
-	{ .div = 21, .val = 21, .flags = RATE_IN_4430 },
-	{ .div = 22, .val = 22, .flags = RATE_IN_4430 },
-	{ .div = 23, .val = 23, .flags = RATE_IN_4430 },
-	{ .div = 24, .val = 24, .flags = RATE_IN_4430 },
-	{ .div = 25, .val = 25, .flags = RATE_IN_4430 },
-	{ .div = 26, .val = 26, .flags = RATE_IN_4430 },
-	{ .div = 27, .val = 27, .flags = RATE_IN_4430 },
-	{ .div = 28, .val = 28, .flags = RATE_IN_4430 },
-	{ .div = 29, .val = 29, .flags = RATE_IN_4430 },
-	{ .div = 30, .val = 30, .flags = RATE_IN_4430 },
-	{ .div = 31, .val = 31, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 1, .flags = RATE_IN_44XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_44XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_44XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_44XX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_44XX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_44XX },
+	{ .div = 7, .val = 7, .flags = RATE_IN_44XX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_44XX },
+	{ .div = 9, .val = 9, .flags = RATE_IN_44XX },
+	{ .div = 10, .val = 10, .flags = RATE_IN_44XX },
+	{ .div = 11, .val = 11, .flags = RATE_IN_44XX },
+	{ .div = 12, .val = 12, .flags = RATE_IN_44XX },
+	{ .div = 13, .val = 13, .flags = RATE_IN_44XX },
+	{ .div = 14, .val = 14, .flags = RATE_IN_44XX },
+	{ .div = 15, .val = 15, .flags = RATE_IN_44XX },
+	{ .div = 16, .val = 16, .flags = RATE_IN_44XX },
+	{ .div = 17, .val = 17, .flags = RATE_IN_44XX },
+	{ .div = 18, .val = 18, .flags = RATE_IN_44XX },
+	{ .div = 19, .val = 19, .flags = RATE_IN_44XX },
+	{ .div = 20, .val = 20, .flags = RATE_IN_44XX },
+	{ .div = 21, .val = 21, .flags = RATE_IN_44XX },
+	{ .div = 22, .val = 22, .flags = RATE_IN_44XX },
+	{ .div = 23, .val = 23, .flags = RATE_IN_44XX },
+	{ .div = 24, .val = 24, .flags = RATE_IN_44XX },
+	{ .div = 25, .val = 25, .flags = RATE_IN_44XX },
+	{ .div = 26, .val = 26, .flags = RATE_IN_44XX },
+	{ .div = 27, .val = 27, .flags = RATE_IN_44XX },
+	{ .div = 28, .val = 28, .flags = RATE_IN_44XX },
+	{ .div = 29, .val = 29, .flags = RATE_IN_44XX },
+	{ .div = 30, .val = 30, .flags = RATE_IN_44XX },
+	{ .div = 31, .val = 31, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
@@ -345,9 +345,9 @@ static struct clk abe_24m_fclk = {
 };
 
 static const struct clksel_rate div3_1to4_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 2, .val = 1, .flags = RATE_IN_4430 },
-	{ .div = 4, .val = 2, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 2, .val = 1, .flags = RATE_IN_44XX },
+	{ .div = 4, .val = 2, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
@@ -369,8 +369,8 @@ static struct clk abe_clk = {
 };
 
 static const struct clksel_rate div2_1to2_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 2, .val = 1, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 2, .val = 1, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
@@ -542,10 +542,10 @@ static struct clk div_core_ck = {
 };
 
 static const struct clksel_rate div4_1to8_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 2, .val = 1, .flags = RATE_IN_4430 },
-	{ .div = 4, .val = 2, .flags = RATE_IN_4430 },
-	{ .div = 8, .val = 3, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 2, .val = 1, .flags = RATE_IN_44XX },
+	{ .div = 4, .val = 2, .flags = RATE_IN_44XX },
+	{ .div = 8, .val = 3, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
@@ -1099,8 +1099,8 @@ static struct clk func_24mc_fclk = {
 };
 
 static const struct clksel_rate div2_4to8_rates[] = {
-	{ .div = 4, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 8, .val = 1, .flags = RATE_IN_4430 },
+	{ .div = 4, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 8, .val = 1, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
@@ -1130,8 +1130,8 @@ static struct clk func_48mc_fclk = {
 };
 
 static const struct clksel_rate div2_2to4_rates[] = {
-	{ .div = 2, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 4, .val = 1, .flags = RATE_IN_4430 },
+	{ .div = 2, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 4, .val = 1, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
@@ -1183,8 +1183,8 @@ static struct clk hsmmc6_fclk = {
 };
 
 static const struct clksel_rate div2_1to8_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 8, .val = 1, .flags = RATE_IN_4430 },
+	{ .div = 1, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 8, .val = 1, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
@@ -2751,8 +2751,8 @@ static struct clk usb_tll_hs_ick = {
 };
 
 static const struct clksel_rate div2_14to18_rates[] = {
-	{ .div = 14, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 18, .val = 1, .flags = RATE_IN_4430 },
+	{ .div = 14, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 18, .val = 1, .flags = RATE_IN_44XX },
 	{ .div = 0 },
 };
 
@@ -3015,284 +3015,287 @@ static struct clk auxclkreq5_ck = {
  */
 
 static struct omap_clk omap44xx_clks[] = {
-	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck,	CK_443X),
-	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck,	CK_443X),
-	CLK(NULL,	"pad_slimbus_core_clks_ck",	&pad_slimbus_core_clks_ck,	CK_443X),
-	CLK(NULL,	"secure_32k_clk_src_ck",	&secure_32k_clk_src_ck,	CK_443X),
-	CLK(NULL,	"slimbus_clk",			&slimbus_clk,	CK_443X),
-	CLK(NULL,	"sys_32k_ck",			&sys_32k_ck,	CK_443X),
-	CLK(NULL,	"virt_12000000_ck",		&virt_12000000_ck,	CK_443X),
-	CLK(NULL,	"virt_13000000_ck",		&virt_13000000_ck,	CK_443X),
-	CLK(NULL,	"virt_16800000_ck",		&virt_16800000_ck,	CK_443X),
-	CLK(NULL,	"virt_19200000_ck",		&virt_19200000_ck,	CK_443X),
-	CLK(NULL,	"virt_26000000_ck",		&virt_26000000_ck,	CK_443X),
-	CLK(NULL,	"virt_27000000_ck",		&virt_27000000_ck,	CK_443X),
-	CLK(NULL,	"virt_38400000_ck",		&virt_38400000_ck,	CK_443X),
-	CLK(NULL,	"sys_clkin_ck",			&sys_clkin_ck,	CK_443X),
-	CLK(NULL,	"tie_low_clock_ck",		&tie_low_clock_ck,	CK_443X),
-	CLK(NULL,	"utmi_phy_clkout_ck",		&utmi_phy_clkout_ck,	CK_443X),
-	CLK(NULL,	"xclk60mhsp1_ck",		&xclk60mhsp1_ck,	CK_443X),
-	CLK(NULL,	"xclk60mhsp2_ck",		&xclk60mhsp2_ck,	CK_443X),
-	CLK(NULL,	"xclk60motg_ck",		&xclk60motg_ck,	CK_443X),
-	CLK(NULL,	"abe_dpll_bypass_clk_mux_ck",	&abe_dpll_bypass_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"abe_dpll_refclk_mux_ck",	&abe_dpll_refclk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_ck",			&dpll_abe_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_x2_ck",		&dpll_abe_x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_m2x2_ck",		&dpll_abe_m2x2_ck,	CK_443X),
-	CLK(NULL,	"abe_24m_fclk",			&abe_24m_fclk,	CK_443X),
-	CLK(NULL,	"abe_clk",			&abe_clk,	CK_443X),
-	CLK(NULL,	"aess_fclk",			&aess_fclk,	CK_443X),
-	CLK(NULL,	"dpll_abe_m3x2_ck",		&dpll_abe_m3x2_ck,	CK_443X),
-	CLK(NULL,	"core_hsd_byp_clk_mux_ck",	&core_hsd_byp_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_ck",			&dpll_core_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_x2_ck",		&dpll_core_x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m6x2_ck",		&dpll_core_m6x2_ck,	CK_443X),
-	CLK(NULL,	"dbgclk_mux_ck",		&dbgclk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m2_ck",		&dpll_core_m2_ck,	CK_443X),
-	CLK(NULL,	"ddrphy_ck",			&ddrphy_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m5x2_ck",		&dpll_core_m5x2_ck,	CK_443X),
-	CLK(NULL,	"div_core_ck",			&div_core_ck,	CK_443X),
-	CLK(NULL,	"div_iva_hs_clk",		&div_iva_hs_clk,	CK_443X),
-	CLK(NULL,	"div_mpu_hs_clk",		&div_mpu_hs_clk,	CK_443X),
-	CLK(NULL,	"dpll_core_m4x2_ck",		&dpll_core_m4x2_ck,	CK_443X),
-	CLK(NULL,	"dll_clk_div_ck",		&dll_clk_div_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_m2_ck",		&dpll_abe_m2_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m3x2_ck",		&dpll_core_m3x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m7x2_ck",		&dpll_core_m7x2_ck,	CK_443X),
-	CLK(NULL,	"iva_hsd_byp_clk_mux_ck",	&iva_hsd_byp_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_ck",			&dpll_iva_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_x2_ck",		&dpll_iva_x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_m4x2_ck",		&dpll_iva_m4x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_m5x2_ck",		&dpll_iva_m5x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck,	CK_443X),
-	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck,	CK_443X),
-	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck,	CK_443X),
-	CLK(NULL,	"per_hsd_byp_clk_mux_ck",	&per_hsd_byp_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_ck",			&dpll_per_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m2_ck",		&dpll_per_m2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_x2_ck",		&dpll_per_x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m2x2_ck",		&dpll_per_m2x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m3x2_ck",		&dpll_per_m3x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m4x2_ck",		&dpll_per_m4x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m5x2_ck",		&dpll_per_m5x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m6x2_ck",		&dpll_per_m6x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m7x2_ck",		&dpll_per_m7x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_unipro_ck",		&dpll_unipro_ck,	CK_443X),
-	CLK(NULL,	"dpll_unipro_x2_ck",		&dpll_unipro_x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_unipro_m2x2_ck",		&dpll_unipro_m2x2_ck,	CK_443X),
-	CLK(NULL,	"usb_hs_clk_div_ck",		&usb_hs_clk_div_ck,	CK_443X),
-	CLK(NULL,	"dpll_usb_ck",			&dpll_usb_ck,	CK_443X),
-	CLK(NULL,	"dpll_usb_clkdcoldo_ck",	&dpll_usb_clkdcoldo_ck,	CK_443X),
-	CLK(NULL,	"dpll_usb_m2_ck",		&dpll_usb_m2_ck,	CK_443X),
-	CLK(NULL,	"ducati_clk_mux_ck",		&ducati_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"func_12m_fclk",		&func_12m_fclk,	CK_443X),
-	CLK(NULL,	"func_24m_clk",			&func_24m_clk,	CK_443X),
-	CLK(NULL,	"func_24mc_fclk",		&func_24mc_fclk,	CK_443X),
-	CLK(NULL,	"func_48m_fclk",		&func_48m_fclk,	CK_443X),
-	CLK(NULL,	"func_48mc_fclk",		&func_48mc_fclk,	CK_443X),
-	CLK(NULL,	"func_64m_fclk",		&func_64m_fclk,	CK_443X),
-	CLK(NULL,	"func_96m_fclk",		&func_96m_fclk,	CK_443X),
-	CLK(NULL,	"hsmmc6_fclk",			&hsmmc6_fclk,	CK_443X),
-	CLK(NULL,	"init_60m_fclk",		&init_60m_fclk,	CK_443X),
-	CLK(NULL,	"l3_div_ck",			&l3_div_ck,	CK_443X),
-	CLK(NULL,	"l4_div_ck",			&l4_div_ck,	CK_443X),
-	CLK(NULL,	"lp_clk_div_ck",		&lp_clk_div_ck,	CK_443X),
-	CLK(NULL,	"l4_wkup_clk_mux_ck",		&l4_wkup_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"per_abe_nc_fclk",		&per_abe_nc_fclk,	CK_443X),
-	CLK(NULL,	"mcasp2_fclk",			&mcasp2_fclk,	CK_443X),
-	CLK(NULL,	"mcasp3_fclk",			&mcasp3_fclk,	CK_443X),
-	CLK(NULL,	"ocp_abe_iclk",			&ocp_abe_iclk,	CK_443X),
-	CLK(NULL,	"per_abe_24m_fclk",		&per_abe_24m_fclk,	CK_443X),
-	CLK(NULL,	"pmd_stm_clock_mux_ck",		&pmd_stm_clock_mux_ck,	CK_443X),
-	CLK(NULL,	"pmd_trace_clk_mux_ck",		&pmd_trace_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"syc_clk_div_ck",		&syc_clk_div_ck,	CK_443X),
-	CLK(NULL,	"aes1_fck",			&aes1_fck,	CK_443X),
-	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_443X),
-	CLK(NULL,	"aess_fck",			&aess_fck,	CK_443X),
-	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_443X),
-	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
-	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
-	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
-	CLK("omapdss_dss",	"sys_clk",			&dss_sys_clk,	CK_443X),
-	CLK("omapdss_dss",	"tv_clk",			&dss_tv_clk,	CK_443X),
-	CLK("omapdss_dss",	"video_clk",			&dss_48mhz_clk,	CK_443X),
-	CLK("omapdss_dss",	"fck",				&dss_dss_clk,	CK_443X),
-	CLK("omapdss_dss",	"ick",				&dss_fck,	CK_443X),
-	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_443X),
-	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_443X),
-	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_443X),
-	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_443X),
-	CLK(NULL,	"fpka_fck",			&fpka_fck,	CK_443X),
-	CLK(NULL,	"gpio1_dbclk",			&gpio1_dbclk,	CK_443X),
-	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_443X),
-	CLK(NULL,	"gpio2_dbclk",			&gpio2_dbclk,	CK_443X),
-	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_443X),
-	CLK(NULL,	"gpio3_dbclk",			&gpio3_dbclk,	CK_443X),
-	CLK(NULL,	"gpio3_ick",			&gpio3_ick,	CK_443X),
-	CLK(NULL,	"gpio4_dbclk",			&gpio4_dbclk,	CK_443X),
-	CLK(NULL,	"gpio4_ick",			&gpio4_ick,	CK_443X),
-	CLK(NULL,	"gpio5_dbclk",			&gpio5_dbclk,	CK_443X),
-	CLK(NULL,	"gpio5_ick",			&gpio5_ick,	CK_443X),
-	CLK(NULL,	"gpio6_dbclk",			&gpio6_dbclk,	CK_443X),
-	CLK(NULL,	"gpio6_ick",			&gpio6_ick,	CK_443X),
-	CLK(NULL,	"gpmc_ick",			&gpmc_ick,	CK_443X),
-	CLK(NULL,	"gpu_fck",			&gpu_fck,	CK_443X),
-	CLK("omap2_hdq.0",	"fck",				&hdq1w_fck,	CK_443X),
-	CLK(NULL,	"hsi_fck",			&hsi_fck,	CK_443X),
-	CLK("omap_i2c.1",	"fck",				&i2c1_fck,	CK_443X),
-	CLK("omap_i2c.2",	"fck",				&i2c2_fck,	CK_443X),
-	CLK("omap_i2c.3",	"fck",				&i2c3_fck,	CK_443X),
-	CLK("omap_i2c.4",	"fck",				&i2c4_fck,	CK_443X),
-	CLK(NULL,	"ipu_fck",			&ipu_fck,	CK_443X),
-	CLK(NULL,	"iss_ctrlclk",			&iss_ctrlclk,	CK_443X),
-	CLK(NULL,	"iss_fck",			&iss_fck,	CK_443X),
-	CLK(NULL,	"iva_fck",			&iva_fck,	CK_443X),
-	CLK(NULL,	"kbd_fck",			&kbd_fck,	CK_443X),
-	CLK(NULL,	"l3_instr_ick",			&l3_instr_ick,	CK_443X),
-	CLK(NULL,	"l3_main_3_ick",		&l3_main_3_ick,	CK_443X),
-	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"mcasp_fck",			&mcasp_fck,	CK_443X),
-	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.1",	"fck",				&mcbsp1_fck,	CK_443X),
-	CLK(NULL,	"mcbsp2_sync_mux_ck",		&mcbsp2_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.2",	"fck",				&mcbsp2_fck,	CK_443X),
-	CLK(NULL,	"mcbsp3_sync_mux_ck",		&mcbsp3_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.3",	"fck",				&mcbsp3_fck,	CK_443X),
-	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck,	CK_443X),
-	CLK("omap-mcbsp.4",	"fck",				&mcbsp4_fck,	CK_443X),
-	CLK(NULL,	"mcpdm_fck",			&mcpdm_fck,	CK_443X),
-	CLK("omap2_mcspi.1",	"fck",				&mcspi1_fck,	CK_443X),
-	CLK("omap2_mcspi.2",	"fck",				&mcspi2_fck,	CK_443X),
-	CLK("omap2_mcspi.3",	"fck",				&mcspi3_fck,	CK_443X),
-	CLK("omap2_mcspi.4",	"fck",				&mcspi4_fck,	CK_443X),
-	CLK("omap_hsmmc.0",	"fck",				&mmc1_fck,	CK_443X),
-	CLK("omap_hsmmc.1",	"fck",				&mmc2_fck,	CK_443X),
-	CLK("omap_hsmmc.2",	"fck",				&mmc3_fck,	CK_443X),
-	CLK("omap_hsmmc.3",	"fck",				&mmc4_fck,	CK_443X),
-	CLK("omap_hsmmc.4",	"fck",				&mmc5_fck,	CK_443X),
-	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",	&ocp2scp_usb_phy_phy_48m,	CK_443X),
-	CLK(NULL,	"ocp2scp_usb_phy_ick",		&ocp2scp_usb_phy_ick,	CK_443X),
-	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_443X),
-	CLK("omap_rng",	"ick",				&rng_ick,	CK_443X),
-	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_443X),
-	CLK(NULL,	"sl2if_ick",			&sl2if_ick,	CK_443X),
-	CLK(NULL,	"slimbus1_fclk_1",		&slimbus1_fclk_1,	CK_443X),
-	CLK(NULL,	"slimbus1_fclk_0",		&slimbus1_fclk_0,	CK_443X),
-	CLK(NULL,	"slimbus1_fclk_2",		&slimbus1_fclk_2,	CK_443X),
-	CLK(NULL,	"slimbus1_slimbus_clk",		&slimbus1_slimbus_clk,	CK_443X),
-	CLK(NULL,	"slimbus1_fck",			&slimbus1_fck,	CK_443X),
-	CLK(NULL,	"slimbus2_fclk_1",		&slimbus2_fclk_1,	CK_443X),
-	CLK(NULL,	"slimbus2_fclk_0",		&slimbus2_fclk_0,	CK_443X),
-	CLK(NULL,	"slimbus2_slimbus_clk",		&slimbus2_slimbus_clk,	CK_443X),
-	CLK(NULL,	"slimbus2_fck",			&slimbus2_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
-	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
-	CLK(NULL,	"gpt10_fck",			&timer10_fck,	CK_443X),
-	CLK(NULL,	"gpt11_fck",			&timer11_fck,	CK_443X),
-	CLK(NULL,	"gpt2_fck",			&timer2_fck,	CK_443X),
-	CLK(NULL,	"gpt3_fck",			&timer3_fck,	CK_443X),
-	CLK(NULL,	"gpt4_fck",			&timer4_fck,	CK_443X),
-	CLK(NULL,	"gpt5_fck",			&timer5_fck,	CK_443X),
-	CLK(NULL,	"gpt6_fck",			&timer6_fck,	CK_443X),
-	CLK(NULL,	"gpt7_fck",			&timer7_fck,	CK_443X),
-	CLK(NULL,	"gpt8_fck",			&timer8_fck,	CK_443X),
-	CLK(NULL,	"gpt9_fck",			&timer9_fck,	CK_443X),
-	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_443X),
-	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
-	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
-	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_443X),
-	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
-	CLK("usbhs-omap.0",	"fs_fck",		&usb_host_fs_fck,	CK_443X),
-	CLK(NULL,	"utmi_p1_gfclk",		&utmi_p1_gfclk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&usb_host_hs_utmi_p1_clk,	CK_443X),
-	CLK(NULL,	"utmi_p2_gfclk",		&utmi_p2_gfclk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&usb_host_hs_utmi_p2_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_utmi_p3_clk",	&usb_host_hs_utmi_p3_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_hsic480m_p1_clk",	&usb_host_hs_hsic480m_p1_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_hsic60m_p1_clk",	&usb_host_hs_hsic60m_p1_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_hsic60m_p2_clk",	&usb_host_hs_hsic60m_p2_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_func48mclk",	&usb_host_hs_func48mclk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_fck",		&usb_host_hs_fck,	CK_443X),
-	CLK("usbhs-omap.0",	"hs_fck",		&usb_host_hs_fck,	CK_443X),
-	CLK("usbhs-omap.0",	"usbhost_ick",		&dummy_ck,		CK_443X),
-	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk,	CK_443X),
-	CLK(NULL,	"usb_otg_hs_xclk",		&usb_otg_hs_xclk,	CK_443X),
-	CLK("musb-omap2430",	"ick",				&usb_otg_hs_ick,	CK_443X),
-	CLK(NULL,	"usb_phy_cm_clk32k",		&usb_phy_cm_clk32k,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",	&usb_tll_hs_usb_ch2_clk,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick,	CK_443X),
-	CLK("usbhs-omap.0",	"usbtll_ick",		&usb_tll_hs_ick,	CK_443X),
-	CLK("usbhs-omap.0",	"usbtll_fck",		&dummy_ck,	CK_443X),
-	CLK(NULL,	"usim_ck",			&usim_ck,	CK_443X),
-	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
-	CLK(NULL,	"usim_fck",			&usim_fck,	CK_443X),
-	CLK("omap_wdt",	"fck",				&wd_timer2_fck,	CK_443X),
-	CLK(NULL,	"mailboxes_ick",		&dummy_ck,	CK_443X),
-	CLK(NULL,	"wd_timer3_fck",		&wd_timer3_fck,	CK_443X),
-	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_443X),
-	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_443X),
-	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt2_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt3_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt4_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt5_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt6_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt7_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt8_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt9_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt10_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpt11_ick",			&dummy_ck,	CK_443X),
-	CLK("omap_i2c.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap_i2c.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap_i2c.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap_i2c.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.0",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
-	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
-	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck,	CK_443X),
-	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck,	CK_443X),
-	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck,	CK_443X),
-	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck,	CK_443X),
-	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck,	CK_443X),
-	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq0_ck",		&auxclkreq0_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq1_ck",		&auxclkreq1_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq2_ck",		&auxclkreq2_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
+	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck,	CK_44XX),
+	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck,	CK_44XX),
+	CLK(NULL,	"pad_slimbus_core_clks_ck",	&pad_slimbus_core_clks_ck,	CK_44XX),
+	CLK(NULL,	"secure_32k_clk_src_ck",	&secure_32k_clk_src_ck,	CK_44XX),
+	CLK(NULL,	"slimbus_clk",			&slimbus_clk,	CK_44XX),
+	CLK(NULL,	"sys_32k_ck",			&sys_32k_ck,	CK_44XX),
+	CLK(NULL,	"virt_12000000_ck",		&virt_12000000_ck,	CK_44XX),
+	CLK(NULL,	"virt_13000000_ck",		&virt_13000000_ck,	CK_44XX),
+	CLK(NULL,	"virt_16800000_ck",		&virt_16800000_ck,	CK_44XX),
+	CLK(NULL,	"virt_19200000_ck",		&virt_19200000_ck,	CK_44XX),
+	CLK(NULL,	"virt_26000000_ck",		&virt_26000000_ck,	CK_44XX),
+	CLK(NULL,	"virt_27000000_ck",		&virt_27000000_ck,	CK_44XX),
+	CLK(NULL,	"virt_38400000_ck",		&virt_38400000_ck,	CK_44XX),
+	CLK(NULL,	"sys_clkin_ck",			&sys_clkin_ck,	CK_44XX),
+	CLK(NULL,	"tie_low_clock_ck",		&tie_low_clock_ck,	CK_44XX),
+	CLK(NULL,	"utmi_phy_clkout_ck",		&utmi_phy_clkout_ck,	CK_44XX),
+	CLK(NULL,	"xclk60mhsp1_ck",		&xclk60mhsp1_ck,	CK_44XX),
+	CLK(NULL,	"xclk60mhsp2_ck",		&xclk60mhsp2_ck,	CK_44XX),
+	CLK(NULL,	"xclk60motg_ck",		&xclk60motg_ck,	CK_44XX),
+	CLK(NULL,	"abe_dpll_bypass_clk_mux_ck",	&abe_dpll_bypass_clk_mux_ck,	CK_44XX),
+	CLK(NULL,	"abe_dpll_refclk_mux_ck",	&abe_dpll_refclk_mux_ck,	CK_44XX),
+	CLK(NULL,	"dpll_abe_ck",			&dpll_abe_ck,	CK_44XX),
+	CLK(NULL,	"dpll_abe_x2_ck",		&dpll_abe_x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_abe_m2x2_ck",		&dpll_abe_m2x2_ck,	CK_44XX),
+	CLK(NULL,	"abe_24m_fclk",			&abe_24m_fclk,	CK_44XX),
+	CLK(NULL,	"abe_clk",			&abe_clk,	CK_44XX),
+	CLK(NULL,	"aess_fclk",			&aess_fclk,	CK_44XX),
+	CLK(NULL,	"dpll_abe_m3x2_ck",		&dpll_abe_m3x2_ck,	CK_44XX),
+	CLK(NULL,	"core_hsd_byp_clk_mux_ck",	&core_hsd_byp_clk_mux_ck,	CK_44XX),
+	CLK(NULL,	"dpll_core_ck",			&dpll_core_ck,	CK_44XX),
+	CLK(NULL,	"dpll_core_x2_ck",		&dpll_core_x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_core_m6x2_ck",		&dpll_core_m6x2_ck,	CK_44XX),
+	CLK(NULL,	"dbgclk_mux_ck",		&dbgclk_mux_ck,	CK_44XX),
+	CLK(NULL,	"dpll_core_m2_ck",		&dpll_core_m2_ck,	CK_44XX),
+	CLK(NULL,	"ddrphy_ck",			&ddrphy_ck,	CK_44XX),
+	CLK(NULL,	"dpll_core_m5x2_ck",		&dpll_core_m5x2_ck,	CK_44XX),
+	CLK(NULL,	"div_core_ck",			&div_core_ck,	CK_44XX),
+	CLK(NULL,	"div_iva_hs_clk",		&div_iva_hs_clk,	CK_44XX),
+	CLK(NULL,	"div_mpu_hs_clk",		&div_mpu_hs_clk,	CK_44XX),
+	CLK(NULL,	"dpll_core_m4x2_ck",		&dpll_core_m4x2_ck,	CK_44XX),
+	CLK(NULL,	"dll_clk_div_ck",		&dll_clk_div_ck,	CK_44XX),
+	CLK(NULL,	"dpll_abe_m2_ck",		&dpll_abe_m2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_core_m3x2_ck",		&dpll_core_m3x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_core_m7x2_ck",		&dpll_core_m7x2_ck,	CK_44XX),
+	CLK(NULL,	"iva_hsd_byp_clk_mux_ck",	&iva_hsd_byp_clk_mux_ck,	CK_44XX),
+	CLK(NULL,	"dpll_iva_ck",			&dpll_iva_ck,	CK_44XX),
+	CLK(NULL,	"dpll_iva_x2_ck",		&dpll_iva_x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_iva_m4x2_ck",		&dpll_iva_m4x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_iva_m5x2_ck",		&dpll_iva_m5x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck,	CK_44XX),
+	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck,	CK_44XX),
+	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck,	CK_44XX),
+	CLK(NULL,	"per_hsd_byp_clk_mux_ck",	&per_hsd_byp_clk_mux_ck,	CK_44XX),
+	CLK(NULL,	"dpll_per_ck",			&dpll_per_ck,	CK_44XX),
+	CLK(NULL,	"dpll_per_m2_ck",		&dpll_per_m2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_per_x2_ck",		&dpll_per_x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_per_m2x2_ck",		&dpll_per_m2x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_per_m3x2_ck",		&dpll_per_m3x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_per_m4x2_ck",		&dpll_per_m4x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_per_m5x2_ck",		&dpll_per_m5x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_per_m6x2_ck",		&dpll_per_m6x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_per_m7x2_ck",		&dpll_per_m7x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_unipro_ck",		&dpll_unipro_ck,	CK_44XX),
+	CLK(NULL,	"dpll_unipro_x2_ck",		&dpll_unipro_x2_ck,	CK_44XX),
+	CLK(NULL,	"dpll_unipro_m2x2_ck",		&dpll_unipro_m2x2_ck,	CK_44XX),
+	CLK(NULL,	"usb_hs_clk_div_ck",		&usb_hs_clk_div_ck,	CK_44XX),
+	CLK(NULL,	"dpll_usb_ck",			&dpll_usb_ck,	CK_44XX),
+	CLK(NULL,	"dpll_usb_clkdcoldo_ck",	&dpll_usb_clkdcoldo_ck,	CK_44XX),
+	CLK(NULL,	"dpll_usb_m2_ck",		&dpll_usb_m2_ck,	CK_44XX),
+	CLK(NULL,	"ducati_clk_mux_ck",		&ducati_clk_mux_ck,	CK_44XX),
+	CLK(NULL,	"func_12m_fclk",		&func_12m_fclk,	CK_44XX),
+	CLK(NULL,	"func_24m_clk",			&func_24m_clk,	CK_44XX),
+	CLK(NULL,	"func_24mc_fclk",		&func_24mc_fclk,	CK_44XX),
+	CLK(NULL,	"func_48m_fclk",		&func_48m_fclk,	CK_44XX),
+	CLK(NULL,	"func_48mc_fclk",		&func_48mc_fclk,	CK_44XX),
+	CLK(NULL,	"func_64m_fclk",		&func_64m_fclk,	CK_44XX),
+	CLK(NULL,	"func_96m_fclk",		&func_96m_fclk,	CK_44XX),
+	CLK(NULL,	"hsmmc6_fclk",			&hsmmc6_fclk,	CK_44XX),
+	CLK(NULL,	"init_60m_fclk",		&init_60m_fclk,	CK_44XX),
+	CLK(NULL,	"l3_div_ck",			&l3_div_ck,	CK_44XX),
+	CLK(NULL,	"l4_div_ck",			&l4_div_ck,	CK_44XX),
+	CLK(NULL,	"lp_clk_div_ck",		&lp_clk_div_ck,	CK_44XX),
+	CLK(NULL,	"l4_wkup_clk_mux_ck",		&l4_wkup_clk_mux_ck,	CK_44XX),
+	CLK(NULL,	"per_abe_nc_fclk",		&per_abe_nc_fclk,	CK_44XX),
+	CLK(NULL,	"mcasp2_fclk",			&mcasp2_fclk,	CK_44XX),
+	CLK(NULL,	"mcasp3_fclk",			&mcasp3_fclk,	CK_44XX),
+	CLK(NULL,	"ocp_abe_iclk",			&ocp_abe_iclk,	CK_44XX),
+	CLK(NULL,	"per_abe_24m_fclk",		&per_abe_24m_fclk,	CK_44XX),
+	CLK(NULL,	"pmd_stm_clock_mux_ck",		&pmd_stm_clock_mux_ck,	CK_44XX),
+	CLK(NULL,	"pmd_trace_clk_mux_ck",		&pmd_trace_clk_mux_ck,	CK_44XX),
+	CLK(NULL,	"syc_clk_div_ck",		&syc_clk_div_ck,	CK_44XX),
+	CLK(NULL,	"aes1_fck",			&aes1_fck,	CK_44XX),
+	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_44XX),
+	CLK(NULL,	"aess_fck",			&aess_fck,	CK_44XX),
+	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_44XX),
+	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_44XX),
+	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_44XX),
+	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_44XX),
+	CLK("omapdss_dss",	"sys_clk",			&dss_sys_clk,	CK_44XX),
+	CLK("omapdss_dss",	"tv_clk",			&dss_tv_clk,	CK_44XX),
+	CLK("omapdss_dss",	"video_clk",			&dss_48mhz_clk,	CK_44XX),
+	CLK("omapdss_dss",	"fck",				&dss_dss_clk,	CK_44XX),
+	CLK("omapdss_dss",	"ick",				&dss_fck,	CK_44XX),
+	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_44XX),
+	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_44XX),
+	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_44XX),
+	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_44XX),
+	CLK(NULL,	"fpka_fck",			&fpka_fck,	CK_44XX),
+	CLK(NULL,	"gpio1_dbclk",			&gpio1_dbclk,	CK_44XX),
+	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_44XX),
+	CLK(NULL,	"gpio2_dbclk",			&gpio2_dbclk,	CK_44XX),
+	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_44XX),
+	CLK(NULL,	"gpio3_dbclk",			&gpio3_dbclk,	CK_44XX),
+	CLK(NULL,	"gpio3_ick",			&gpio3_ick,	CK_44XX),
+	CLK(NULL,	"gpio4_dbclk",			&gpio4_dbclk,	CK_44XX),
+	CLK(NULL,	"gpio4_ick",			&gpio4_ick,	CK_44XX),
+	CLK(NULL,	"gpio5_dbclk",			&gpio5_dbclk,	CK_44XX),
+	CLK(NULL,	"gpio5_ick",			&gpio5_ick,	CK_44XX),
+	CLK(NULL,	"gpio6_dbclk",			&gpio6_dbclk,	CK_44XX),
+	CLK(NULL,	"gpio6_ick",			&gpio6_ick,	CK_44XX),
+	CLK(NULL,	"gpmc_ick",			&gpmc_ick,	CK_44XX),
+	CLK(NULL,	"gpu_fck",			&gpu_fck,	CK_44XX),
+	CLK("omap2_hdq.0",	"fck",				&hdq1w_fck,	CK_44XX),
+	CLK(NULL,	"hsi_fck",			&hsi_fck,	CK_44XX),
+	CLK("omap_i2c.1",	"fck",				&i2c1_fck,	CK_44XX),
+	CLK("omap_i2c.2",	"fck",				&i2c2_fck,	CK_44XX),
+	CLK("omap_i2c.3",	"fck",				&i2c3_fck,	CK_44XX),
+	CLK("omap_i2c.4",	"fck",				&i2c4_fck,	CK_44XX),
+	CLK(NULL,	"ipu_fck",			&ipu_fck,	CK_44XX),
+	CLK(NULL,	"iss_ctrlclk",			&iss_ctrlclk,	CK_44XX),
+	CLK(NULL,	"iss_fck",			&iss_fck,	CK_44XX),
+	CLK(NULL,	"iva_fck",			&iva_fck,	CK_44XX),
+	CLK(NULL,	"kbd_fck",			&kbd_fck,	CK_44XX),
+	CLK(NULL,	"l3_instr_ick",			&l3_instr_ick,	CK_44XX),
+	CLK(NULL,	"l3_main_3_ick",		&l3_main_3_ick,	CK_44XX),
+	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_44XX),
+	CLK(NULL,	"mcasp_fck",			&mcasp_fck,	CK_44XX),
+	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck,	CK_44XX),
+	CLK("omap-mcbsp.1",	"fck",				&mcbsp1_fck,	CK_44XX),
+	CLK(NULL,	"mcbsp2_sync_mux_ck",		&mcbsp2_sync_mux_ck,	CK_44XX),
+	CLK("omap-mcbsp.2",	"fck",				&mcbsp2_fck,	CK_44XX),
+	CLK(NULL,	"mcbsp3_sync_mux_ck",		&mcbsp3_sync_mux_ck,	CK_44XX),
+	CLK("omap-mcbsp.3",	"fck",				&mcbsp3_fck,	CK_44XX),
+	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck,	CK_44XX),
+	CLK("omap-mcbsp.4",	"fck",				&mcbsp4_fck,	CK_44XX),
+	CLK(NULL,	"mcpdm_fck",			&mcpdm_fck,	CK_44XX),
+	CLK("omap2_mcspi.1",	"fck",				&mcspi1_fck,	CK_44XX),
+	CLK("omap2_mcspi.2",	"fck",				&mcspi2_fck,	CK_44XX),
+	CLK("omap2_mcspi.3",	"fck",				&mcspi3_fck,	CK_44XX),
+	CLK("omap2_mcspi.4",	"fck",				&mcspi4_fck,	CK_44XX),
+	CLK("omap_hsmmc.0",	"fck",				&mmc1_fck,	CK_44XX),
+	CLK("omap_hsmmc.1",	"fck",				&mmc2_fck,	CK_44XX),
+	CLK("omap_hsmmc.2",	"fck",				&mmc3_fck,	CK_44XX),
+	CLK("omap_hsmmc.3",	"fck",				&mmc4_fck,	CK_44XX),
+	CLK("omap_hsmmc.4",	"fck",				&mmc5_fck,	CK_44XX),
+	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",	&ocp2scp_usb_phy_phy_48m,	CK_44XX),
+	CLK(NULL,	"ocp2scp_usb_phy_ick",		&ocp2scp_usb_phy_ick,	CK_44XX),
+	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_44XX),
+	CLK("omap_rng",	"ick",				&rng_ick,	CK_44XX),
+	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_44XX),
+	CLK(NULL,	"sl2if_ick",			&sl2if_ick,	CK_44XX),
+	CLK(NULL,	"slimbus1_fclk_1",		&slimbus1_fclk_1,	CK_44XX),
+	CLK(NULL,	"slimbus1_fclk_0",		&slimbus1_fclk_0,	CK_44XX),
+	CLK(NULL,	"slimbus1_fclk_2",		&slimbus1_fclk_2,	CK_44XX),
+	CLK(NULL,	"slimbus1_slimbus_clk",		&slimbus1_slimbus_clk,	CK_44XX),
+	CLK(NULL,	"slimbus1_fck",			&slimbus1_fck,	CK_44XX),
+	CLK(NULL,	"slimbus2_fclk_1",		&slimbus2_fclk_1,	CK_44XX),
+	CLK(NULL,	"slimbus2_fclk_0",		&slimbus2_fclk_0,	CK_44XX),
+	CLK(NULL,	"slimbus2_slimbus_clk",		&slimbus2_slimbus_clk,	CK_44XX),
+	CLK(NULL,	"slimbus2_fck",			&slimbus2_fck,	CK_44XX),
+	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_44XX),
+	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_44XX),
+	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_44XX),
+	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_44XX),
+	CLK(NULL,	"gpt10_fck",			&timer10_fck,	CK_44XX),
+	CLK(NULL,	"gpt11_fck",			&timer11_fck,	CK_44XX),
+	CLK(NULL,	"gpt2_fck",			&timer2_fck,	CK_44XX),
+	CLK(NULL,	"gpt3_fck",			&timer3_fck,	CK_44XX),
+	CLK(NULL,	"gpt4_fck",			&timer4_fck,	CK_44XX),
+	CLK(NULL,	"gpt5_fck",			&timer5_fck,	CK_44XX),
+	CLK(NULL,	"gpt6_fck",			&timer6_fck,	CK_44XX),
+	CLK(NULL,	"gpt7_fck",			&timer7_fck,	CK_44XX),
+	CLK(NULL,	"gpt8_fck",			&timer8_fck,	CK_44XX),
+	CLK(NULL,	"gpt9_fck",			&timer9_fck,	CK_44XX),
+	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_44XX),
+	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_44XX),
+	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_44XX),
+	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_44XX),
+	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_44XX),
+	CLK("usbhs-omap.0",	"fs_fck",		&usb_host_fs_fck,	CK_44XX),
+	CLK(NULL,	"utmi_p1_gfclk",		&utmi_p1_gfclk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&usb_host_hs_utmi_p1_clk,	CK_44XX),
+	CLK(NULL,	"utmi_p2_gfclk",		&utmi_p2_gfclk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&usb_host_hs_utmi_p2_clk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_utmi_p3_clk",	&usb_host_hs_utmi_p3_clk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_hsic480m_p1_clk",	&usb_host_hs_hsic480m_p1_clk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_hsic60m_p1_clk",	&usb_host_hs_hsic60m_p1_clk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_hsic60m_p2_clk",	&usb_host_hs_hsic60m_p2_clk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_func48mclk",	&usb_host_hs_func48mclk,	CK_44XX),
+	CLK(NULL,	"usb_host_hs_fck",		&usb_host_hs_fck,	CK_44XX),
+	CLK("usbhs-omap.0",	"hs_fck",		&usb_host_hs_fck,	CK_44XX),
+	CLK("usbhs-omap.0",	"usbhost_ick",		&dummy_ck,		CK_44XX),
+	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk,	CK_44XX),
+	CLK(NULL,	"usb_otg_hs_xclk",		&usb_otg_hs_xclk,	CK_44XX),
+	CLK("musb-omap2430",	"ick",				&usb_otg_hs_ick,	CK_44XX),
+	CLK(NULL,	"usb_phy_cm_clk32k",		&usb_phy_cm_clk32k,	CK_44XX),
+	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",	&usb_tll_hs_usb_ch2_clk,	CK_44XX),
+	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk,	CK_44XX),
+	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk,	CK_44XX),
+	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick,	CK_44XX),
+	CLK("usbhs-omap.0",	"usbtll_ick",		&usb_tll_hs_ick,	CK_44XX),
+	CLK("usbhs-omap.0",	"usbtll_fck",		&dummy_ck,	CK_44XX),
+	CLK(NULL,	"usim_ck",			&usim_ck,	CK_44XX),
+	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_44XX),
+	CLK(NULL,	"usim_fck",			&usim_fck,	CK_44XX),
+	CLK("omap_wdt",	"fck",				&wd_timer2_fck,	CK_44XX),
+	CLK(NULL,	"mailboxes_ick",		&dummy_ck,	CK_44XX),
+	CLK(NULL,	"wd_timer3_fck",		&wd_timer3_fck,	CK_44XX),
+	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_44XX),
+	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_44XX),
+	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt2_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt3_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt4_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt5_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt6_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt7_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt8_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt9_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt10_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"gpt11_ick",			&dummy_ck,	CK_44XX),
+	CLK("omap_i2c.1",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap_i2c.2",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap_i2c.3",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap_i2c.4",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap_hsmmc.0",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap_hsmmc.1",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap_hsmmc.2",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap_hsmmc.3",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap_hsmmc.4",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap-mcbsp.1",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap-mcbsp.2",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap-mcbsp.3",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap-mcbsp.4",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap2_mcspi.1",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap2_mcspi.2",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap2_mcspi.3",	"ick",				&dummy_ck,	CK_44XX),
+	CLK("omap2_mcspi.4",	"ick",				&dummy_ck,	CK_44XX),
+	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_44XX),
+	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_44XX),
+	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_44XX),
+	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck,	CK_44XX),
+	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck,	CK_44XX),
+	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck,	CK_44XX),
+	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck,	CK_44XX),
+	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck,	CK_44XX),
+	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_44XX),
+	CLK(NULL,	"auxclkreq0_ck",		&auxclkreq0_ck,	CK_44XX),
+	CLK(NULL,	"auxclkreq1_ck",		&auxclkreq1_ck,	CK_44XX),
+	CLK(NULL,	"auxclkreq2_ck",		&auxclkreq2_ck,	CK_44XX),
+	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_44XX),
+	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_44XX),
+	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_44XX),
 };
 
 int __init omap4xxx_clk_init(void)
 {
 	struct omap_clk *c;
-	u32 cpu_clkflg;
+	u32 cpu_clkflg = 0;
 
-	if (cpu_is_omap44xx()) {
+	if (cpu_is_omap443x()) {
 		cpu_mask = RATE_IN_4430;
 		cpu_clkflg = CK_443X;
+	} else if (cpu_is_omap446x()) {
+		cpu_mask = RATE_IN_4460;
+		cpu_clkflg = CK_446X;
 	}
 
 	clk_init(&omap2_clk_functions);
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index f1899a3..324446b 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -39,11 +39,13 @@ struct omap_clk {
 #define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
 #define CK_443X		(1 << 11)
 #define CK_TI816X	(1 << 12)
+#define CK_446X		(1 << 13)
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
 #define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
 #define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
+#define CK_44XX		(CK_443X | CK_446X)
 
 
 #endif
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 006e599..21b1beb 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -58,10 +58,12 @@ struct clkops {
 #define RATE_IN_36XX		(1 << 4)
 #define RATE_IN_4430		(1 << 5)
 #define RATE_IN_TI816X		(1 << 6)
+#define RATE_IN_4460		(1 << 7)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
 #define RATE_IN_3XXX		(RATE_IN_34XX | RATE_IN_36XX)
+#define RATE_IN_44XX		(RATE_IN_4430 | RATE_IN_4460)
 
 /* RATE_IN_3430ES2PLUS_36XX includes 34xx/35xx with ES >=2, and all 36xx/37xx */
 #define RATE_IN_3430ES2PLUS_36XX	(RATE_IN_3430ES2PLUS | RATE_IN_36XX)
-- 
1.7.1

