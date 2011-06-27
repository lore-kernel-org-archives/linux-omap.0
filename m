From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 6/7] OMAP4: hwmod data: TEMP: Fix timer1 main_clk
Date: Mon, 27 Jun 2011 18:33:10 +0200
Message-ID: <1309192391-12410-7-git-send-email-b-cousson@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53054 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807Ab1F0QeD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 12:34:03 -0400
In-Reply-To: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Since the timer is still not pm_runtime adapted, it is still
using directly the physical clock nodes at init time.

Replace the clock node by the original one in the clock data
file.

Keep the original name until the driver is fixed.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c       |   12 ++++++++----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 547f02b..f1cfa3c 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1765,15 +1765,19 @@ static struct clk dmic_sync_mux_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk dmt1_clk_mux_ck = {
-	.name		= "dmt1_clk_mux_ck",
+/* Merged dmt1_clk_mux into timer1 */
+static struct clk timer1_fck = {
+	.name		= "timer1_fck",
 	.parent		= &sys_clkin_ck,
 	.clksel		= abe_dpll_bypass_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.clkdm_name	= "l4_wkup_clkdm",
 };
 
 static const struct clksel fdif_fclk_div[] = {
@@ -2527,7 +2531,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"cm2_dm4_mux_ck",		&cm2_dm4_mux_ck,	CK_44XX),
 	CLK(NULL,	"cm2_dm9_mux_ck",		&cm2_dm9_mux_ck,	CK_44XX),
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_44XX),
-	CLK(NULL,	"dmt1_clk_mux_ck",		&dmt1_clk_mux_ck,	CK_44XX),
+	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_44XX),
 	CLK(NULL,	"fdif_fclk",			&fdif_fclk,	CK_44XX),
 	CLK(NULL,	"func_dmic_abe_gfclk",		&func_dmic_abe_gfclk,	CK_44XX),
 	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_44XX),
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 5c196a1..729b371 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4249,7 +4249,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.clkdm_name	= "l4_wkup_clkdm",
 	.mpu_irqs	= omap44xx_timer1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
-	.main_clk	= "dmt1_clk_mux_ck",
+	.main_clk	= "timer1_fck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
-- 
1.7.0.4

