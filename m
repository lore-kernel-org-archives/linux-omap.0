From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/10] OMAP3 clock: rename RATE_IN_343X,
	RATE_IN_3430ES2 to match reality
Date: Mon, 26 Apr 2010 01:04:34 -0600
Message-ID: <20100426070432.9743.2866.stgit@localhost.localdomain>
References: <20100426070217.9743.92728.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52248 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab0DZHHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 03:07:35 -0400
In-Reply-To: <20100426070217.9743.92728.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Richard Woodruff <r-woodruff2@ti.com>, Rajendra Nayak <rnayak@ti.com>, Ranjith Lohithakshan <ranjithl@ti.com>

Rename the RATE_IN_343X clksel_rate.rate flag to be RATE_IN_3XXX, to reflect
that these rates are valid on all OMAP3 platforms, not just 343X.

Also rename the RATE_IN_OMAP3430ES2 clksel_rate.rate flag to be
RATE_IN_OMAP3430ES2PLUS, to reflect that these flags are valid on all
OMAP3 platforms after 3430ES2.

This patch should not result in any functional changes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c    |  237 ++++++++++++++++---------------
 arch/arm/mach-omap2/clock_common_data.c |   12 +-
 arch/arm/plat-omap/include/plat/clock.h |    3 
 3 files changed, 127 insertions(+), 125 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 56bd0d8..68aae9f 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -110,32 +110,32 @@ static struct clk virt_38_4m_ck = {
 };
 
 static const struct clksel_rate osc_sys_12m_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_13m_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_16_8m_rates[] = {
-	{ .div = 1, .val = 5, .flags = RATE_IN_3430ES2 },
+	{ .div = 1, .val = 5, .flags = RATE_IN_3430ES2PLUS },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_19_2m_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 2, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_26m_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 3, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_38_4m_rates[] = {
-	{ .div = 1, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 4, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -163,8 +163,8 @@ static struct clk osc_sys_ck = {
 };
 
 static const struct clksel_rate div2_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -213,22 +213,22 @@ static struct clk sys_clkout1 = {
 /* CM CLOCKS */
 
 static const struct clksel_rate div16_dpll_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 5, .val = 5, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
-	{ .div = 7, .val = 7, .flags = RATE_IN_343X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_343X },
-	{ .div = 9, .val = 9, .flags = RATE_IN_343X },
-	{ .div = 10, .val = 10, .flags = RATE_IN_343X },
-	{ .div = 11, .val = 11, .flags = RATE_IN_343X },
-	{ .div = 12, .val = 12, .flags = RATE_IN_343X },
-	{ .div = 13, .val = 13, .flags = RATE_IN_343X },
-	{ .div = 14, .val = 14, .flags = RATE_IN_343X },
-	{ .div = 15, .val = 15, .flags = RATE_IN_343X },
-	{ .div = 16, .val = 16, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_3XXX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_3XXX },
+	{ .div = 7, .val = 7, .flags = RATE_IN_3XXX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_3XXX },
+	{ .div = 9, .val = 9, .flags = RATE_IN_3XXX },
+	{ .div = 10, .val = 10, .flags = RATE_IN_3XXX },
+	{ .div = 11, .val = 11, .flags = RATE_IN_3XXX },
+	{ .div = 12, .val = 12, .flags = RATE_IN_3XXX },
+	{ .div = 13, .val = 13, .flags = RATE_IN_3XXX },
+	{ .div = 14, .val = 14, .flags = RATE_IN_3XXX },
+	{ .div = 15, .val = 15, .flags = RATE_IN_3XXX },
+	{ .div = 16, .val = 16, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -450,37 +450,37 @@ static struct clk dpll3_x2_ck = {
 };
 
 static const struct clksel_rate div31_dpll3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_3430ES2 },
-	{ .div = 4, .val = 4, .flags = RATE_IN_3430ES2 },
-	{ .div = 5, .val = 5, .flags = RATE_IN_3430ES2 },
-	{ .div = 6, .val = 6, .flags = RATE_IN_3430ES2 },
-	{ .div = 7, .val = 7, .flags = RATE_IN_3430ES2 },
-	{ .div = 8, .val = 8, .flags = RATE_IN_3430ES2 },
-	{ .div = 9, .val = 9, .flags = RATE_IN_3430ES2 },
-	{ .div = 10, .val = 10, .flags = RATE_IN_3430ES2 },
-	{ .div = 11, .val = 11, .flags = RATE_IN_3430ES2 },
-	{ .div = 12, .val = 12, .flags = RATE_IN_3430ES2 },
-	{ .div = 13, .val = 13, .flags = RATE_IN_3430ES2 },
-	{ .div = 14, .val = 14, .flags = RATE_IN_3430ES2 },
-	{ .div = 15, .val = 15, .flags = RATE_IN_3430ES2 },
-	{ .div = 16, .val = 16, .flags = RATE_IN_3430ES2 },
-	{ .div = 17, .val = 17, .flags = RATE_IN_3430ES2 },
-	{ .div = 18, .val = 18, .flags = RATE_IN_3430ES2 },
-	{ .div = 19, .val = 19, .flags = RATE_IN_3430ES2 },
-	{ .div = 20, .val = 20, .flags = RATE_IN_3430ES2 },
-	{ .div = 21, .val = 21, .flags = RATE_IN_3430ES2 },
-	{ .div = 22, .val = 22, .flags = RATE_IN_3430ES2 },
-	{ .div = 23, .val = 23, .flags = RATE_IN_3430ES2 },
-	{ .div = 24, .val = 24, .flags = RATE_IN_3430ES2 },
-	{ .div = 25, .val = 25, .flags = RATE_IN_3430ES2 },
-	{ .div = 26, .val = 26, .flags = RATE_IN_3430ES2 },
-	{ .div = 27, .val = 27, .flags = RATE_IN_3430ES2 },
-	{ .div = 28, .val = 28, .flags = RATE_IN_3430ES2 },
-	{ .div = 29, .val = 29, .flags = RATE_IN_3430ES2 },
-	{ .div = 30, .val = 30, .flags = RATE_IN_3430ES2 },
-	{ .div = 31, .val = 31, .flags = RATE_IN_3430ES2 },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 5, .val = 5, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 6, .val = 6, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 7, .val = 7, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 8, .val = 8, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 9, .val = 9, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 10, .val = 10, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 11, .val = 11, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 12, .val = 12, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 13, .val = 13, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 14, .val = 14, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 15, .val = 15, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 16, .val = 16, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 17, .val = 17, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 18, .val = 18, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 19, .val = 19, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 20, .val = 20, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 21, .val = 21, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 22, .val = 22, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 23, .val = 23, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 24, .val = 24, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 25, .val = 25, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 26, .val = 26, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 27, .val = 27, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 28, .val = 28, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 29, .val = 29, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 30, .val = 30, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 31, .val = 31, .flags = RATE_IN_3430ES2PLUS },
 	{ .div = 0 },
 };
 
@@ -708,12 +708,12 @@ static const struct clksel omap_96m_alwon_fck_clksel[] = {
 };
 
 static const struct clksel_rate omap_96m_dpll_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate omap_96m_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -799,12 +799,12 @@ static struct clk dpll4_m3x2_ck = {
 };
 
 static const struct clksel_rate omap_54m_d4m3x2_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate omap_54m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -825,12 +825,12 @@ static struct clk omap_54m_fck = {
 };
 
 static const struct clksel_rate omap_48m_cm96m_rates[] = {
-	{ .div = 2, .val = 0, .flags = RATE_IN_343X },
+	{ .div = 2, .val = 0, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate omap_48m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -1049,22 +1049,22 @@ static struct clk dpll5_m2_ck = {
 /* CM EXTERNAL CLOCK OUTPUTS */
 
 static const struct clksel_rate clkout2_src_core_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate clkout2_src_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate clkout2_src_96m_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 2, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate clkout2_src_54m_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 3, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -1090,11 +1090,11 @@ static struct clk clkout2_src_ck = {
 };
 
 static const struct clksel_rate sys_clkout2_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
-	{ .div = 2, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 8, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 16, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 8, .val = 3, .flags = RATE_IN_3XXX },
+	{ .div = 16, .val = 4, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -1125,9 +1125,9 @@ static struct clk corex2_fck = {
 /* DPLL power domain clock controls */
 
 static const struct clksel_rate div4_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -1161,8 +1161,8 @@ static struct clk mpu_ck = {
 
 /* arm_fck is divided by two when DPLL1 locked; otherwise, passthrough mpu_ck */
 static const struct clksel_rate arm_fck_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
-	{ .div = 2, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -1333,9 +1333,9 @@ static struct clk gfx_cg2_ck = {
 
 static const struct clksel_rate sgx_core_rates[] = {
 	{ .div = 2, .val = 5, .flags = RATE_IN_36XX },
-	{ .div = 3, .val = 0, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 3, .val = 0, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 6, .val = 2, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -1351,7 +1351,7 @@ static const struct clksel_rate sgx_corex2_rates[] = {
 };
 
 static const struct clksel_rate sgx_96m_rates[] = {
-	{ .div = 1,  .val = 3, .flags = RATE_IN_343X },
+	{ .div = 1,  .val = 3, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -1576,12 +1576,12 @@ static struct clk i2c1_fck = {
  * MCBSP 2, 3, 4 get their 96MHz clock from per_96m_fck.
  */
 static const struct clksel_rate common_mcbsp_96m_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate common_mcbsp_mcbsp_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -1714,12 +1714,12 @@ static struct clk hdq_fck = {
 /* DPLL3-derived clock */
 
 static const struct clksel_rate ssi_ssr_corex2_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_3XXX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -2353,18 +2353,18 @@ static struct clk usbhost_ick = {
 /* WKUP */
 
 static const struct clksel_rate usim_96m_rates[] = {
-	{ .div = 2,  .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4,  .val = 4, .flags = RATE_IN_343X },
-	{ .div = 8,  .val = 5, .flags = RATE_IN_343X },
-	{ .div = 10, .val = 6, .flags = RATE_IN_343X },
+	{ .div = 2,  .val = 3, .flags = RATE_IN_3XXX },
+	{ .div = 4,  .val = 4, .flags = RATE_IN_3XXX },
+	{ .div = 8,  .val = 5, .flags = RATE_IN_3XXX },
+	{ .div = 10, .val = 6, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate usim_120m_rates[] = {
-	{ .div = 4,  .val = 7,	.flags = RATE_IN_343X },
-	{ .div = 8,  .val = 8,	.flags = RATE_IN_343X },
-	{ .div = 16, .val = 9,	.flags = RATE_IN_343X },
-	{ .div = 20, .val = 10, .flags = RATE_IN_343X },
+	{ .div = 4,  .val = 7,	.flags = RATE_IN_3XXX },
+	{ .div = 8,  .val = 8,	.flags = RATE_IN_3XXX },
+	{ .div = 16, .val = 9,	.flags = RATE_IN_3XXX },
+	{ .div = 20, .val = 10, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -2951,22 +2951,22 @@ static struct clk mcbsp4_fck = {
 /* More information: ARM Cortex-A8 Technical Reference Manual, sect 10.1 */
 
 static const struct clksel_rate emu_src_sys_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate emu_src_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate emu_src_per_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 2, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate emu_src_mpu_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 3, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -2995,10 +2995,10 @@ static struct clk emu_src_ck = {
 };
 
 static const struct clksel_rate pclk_emu_rates[] = {
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -3019,9 +3019,9 @@ static struct clk pclk_fck = {
 };
 
 static const struct clksel_rate pclkx2_emu_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -3069,9 +3069,9 @@ static struct clk traceclk_src_fck = {
 };
 
 static const struct clksel_rate traceclk_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -3488,14 +3488,8 @@ int __init omap3xxx_clk_init(void)
 	struct omap_clk *c;
 	u32 cpu_clkflg = CK_3XXX;
 
-	if (cpu_is_omap3517()) {
-		cpu_mask = RATE_IN_343X | RATE_IN_3430ES2;
-		cpu_clkflg |= CK_3517;
-	} else if (cpu_is_omap3505()) {
-		cpu_mask = RATE_IN_343X | RATE_IN_3430ES2;
-		cpu_clkflg |= CK_3505;
-	} else if (cpu_is_omap34xx()) {
-		cpu_mask = RATE_IN_343X;
+	if (cpu_is_omap34xx()) {
+		cpu_mask = RATE_IN_3XXX;
 		cpu_clkflg |= CK_343X;
 
 		/*
@@ -3506,10 +3500,17 @@ int __init omap3xxx_clk_init(void)
 			/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
 			cpu_clkflg |= CK_3430ES1;
 		} else {
-			cpu_mask |= RATE_IN_3430ES2;
+			cpu_mask |= RATE_IN_3430ES2PLUS;
 			cpu_clkflg |= CK_3430ES2;
 		}
+	} else if (cpu_is_omap3517()) {
+		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
+		cpu_clkflg |= CK_3517;
+	} else if (cpu_is_omap3505()) {
+		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
+		cpu_clkflg |= CK_3505;
 	}
+
 	if (omap3_has_192mhz_clk())
 		omap_96m_alwon_fck = omap_96m_alwon_fck_3630;
 
diff --git a/arch/arm/mach-omap2/clock_common_data.c b/arch/arm/mach-omap2/clock_common_data.c
index 6f96dc4..1cf8131 100644
--- a/arch/arm/mach-omap2/clock_common_data.c
+++ b/arch/arm/mach-omap2/clock_common_data.c
@@ -20,20 +20,20 @@
 
 /* clksel_rate data common to 24xx/343x */
 const struct clksel_rate gpt_32k_rates[] = {
-	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_343X },
+	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_3XXX },
 	 { .div = 0 }
 };
 
 const struct clksel_rate gpt_sys_rates[] = {
-	 { .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X },
+	 { .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_3XXX },
 	 { .div = 0 }
 };
 
 const struct clksel_rate gfx_l3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_243X | RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_243X | RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_3XXX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | RATE_IN_3XXX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_243X | RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_243X | RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 9c551d6..dfc472c 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -198,12 +198,13 @@ extern struct clk dummy_ck;
 /* Clksel_rate flags */
 #define RATE_IN_242X		(1 << 0)
 #define RATE_IN_243X		(1 << 1)
-#define RATE_IN_343X		(1 << 2)	/* rates common to all 343X */
+#define RATE_IN_3XXX		(1 << 2)	/* rates common to all OMAP3 */
 #define RATE_IN_3430ES2		(1 << 3)	/* 3430ES2 rates only */
 #define RATE_IN_36XX		(1 << 4)
 #define RATE_IN_4430		(1 << 5)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 
+#define RATE_IN_3430ES2PLUS	(RATE_IN_3430ES2 | RATE_IN_36XX)
 
 #endif


