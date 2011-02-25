From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/3] omap2plus: clock: Add an alias cpu_ck to be used in common cpufreq driver
Date: Fri, 25 Feb 2011 11:40:37 +0530
Message-ID: <1298614239-32196-2-git-send-email-santosh.shilimkar@ti.com>
References: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57504 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab1BYGKq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 01:10:46 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1P6AgW1032724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 00:10:44 -0600
In-Reply-To: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, vishwanath.bs@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Add an alias clock node for cpu clock control on all OMAP2PLUS devices.
The intention is avoid cpu_is_xxxx() checks in the common cpufreq driver.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    1 +
 arch/arm/mach-omap2/clock2430_data.c |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c |    1 +
 arch/arm/mach-omap2/clock44xx_data.c |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 0a992bc..3efe45b 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1799,6 +1799,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_242X),
 	/* virtual meta-group clock */
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
+	CLK(NULL,	"cpu_ck", &virt_prcm_set, CK_242X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index c047dcd..25b1c2d 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1903,6 +1903,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X),
 	/* virtual meta-group clock */
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X),
+	CLK(NULL,	"cpu_ck", &virt_prcm_set, CK_243X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 403a4a1..655d1a9 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3224,6 +3224,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_3XXX),
 	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_3XXX),
 	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_3XXX),
+	CLK(NULL,	"cpu_ck",	&dpll1_ck,	CK_3XXX),
 	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck,	CK_3XXX),
 	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_3XXX),
 	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_34XX | CK_36XX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index e8cb32f..4d5ede3 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3058,6 +3058,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dpll_iva_m4x2_ck",		&dpll_iva_m4x2_ck,	CK_443X),
 	CLK(NULL,	"dpll_iva_m5x2_ck",		&dpll_iva_m5x2_ck,	CK_443X),
 	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck,	CK_443X),
+	CLK(NULL,	"cpu_ck",			&dpll_mpu_ck,	CK_443X),
 	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck,	CK_443X),
 	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck,	CK_443X),
 	CLK(NULL,	"per_hsd_byp_clk_mux_ck",	&per_hsd_byp_clk_mux_ck,	CK_443X),
-- 
1.6.0.4

