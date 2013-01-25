From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP2xxx: clock data: clean up unused null clocks
Date: Fri, 25 Jan 2013 09:32:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301250932040.12241@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41993 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab3AYJcy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 04:32:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, rnayak@ti.com


Remove some clocks that don't appear to be used by anything
and which are not associated with any hardware registers.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cclock2420_data.c |   16 +---------------
 arch/arm/mach-omap2/cclock2430_data.c |   16 +---------------
 2 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock2420_data.c b/arch/arm/mach-omap2/cclock2420_data.c
index 7e5febe..c3acd2d 100644
--- a/arch/arm/mach-omap2/cclock2420_data.c
+++ b/arch/arm/mach-omap2/cclock2420_data.c
@@ -622,15 +622,10 @@ static struct clk_hw_omap gpios_fck_hw = {
 
 DEFINE_STRUCT_CLK(gpios_fck, gpios_fck_parent_names, aes_ick_ops);
 
-static struct clk wu_l4_ick;
-
-DEFINE_STRUCT_CLK_HW_OMAP(wu_l4_ick, "wkup_clkdm");
-DEFINE_STRUCT_CLK(wu_l4_ick, dpll_ck_parent_names, core_ck_ops);
-
 static struct clk gpios_ick;
 
 static const char *gpios_ick_parent_names[] = {
-	"wu_l4_ick",
+	"sys_ck",
 };
 
 static struct clk_hw_omap gpios_ick_hw = {
@@ -1682,13 +1677,6 @@ static struct clk_hw_omap wdt1_ick_hw = {
 
 DEFINE_STRUCT_CLK(wdt1_ick, gpios_ick_parent_names, aes_ick_ops);
 
-static struct clk wdt1_osc_ck;
-
-static const struct clk_ops wdt1_osc_ck_ops = {};
-
-DEFINE_STRUCT_CLK_HW_OMAP(wdt1_osc_ck, NULL);
-DEFINE_STRUCT_CLK(wdt1_osc_ck, sys_ck_parent_names, wdt1_osc_ck_ops);
-
 static struct clk wdt3_fck;
 
 static struct clk_hw_omap wdt3_fck_hw = {
@@ -1767,7 +1755,6 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_242X),
 	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_242X),
 	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_242X),
-	CLK(NULL,	"ck_wdt1_osc",	&wdt1_osc_ck,	CK_242X),
 	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_242X),
 	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_242X),
 	CLK(NULL,	"sys_clkout2_src", &sys_clkout2_src, CK_242X),
@@ -1797,7 +1784,6 @@ static struct omap_clk omap2420_clks[] = {
 	/* L4 domain clocks */
 	CLK(NULL,	"l4_ck",	&l4_ck,		CK_242X),
 	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_242X),
-	CLK(NULL,	"wu_l4_ick",	&wu_l4_ick,	CK_242X),
 	/* virtual meta-group clock */
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
 	/* general l4 interface ck, multi-parent functional clk */
diff --git a/arch/arm/mach-omap2/cclock2430_data.c b/arch/arm/mach-omap2/cclock2430_data.c
index eda079b..7560ec9 100644
--- a/arch/arm/mach-omap2/cclock2430_data.c
+++ b/arch/arm/mach-omap2/cclock2430_data.c
@@ -601,15 +601,10 @@ static struct clk_hw_omap gpios_fck_hw = {
 
 DEFINE_STRUCT_CLK(gpios_fck, gpio5_fck_parent_names, aes_ick_ops);
 
-static struct clk wu_l4_ick;
-
-DEFINE_STRUCT_CLK_HW_OMAP(wu_l4_ick, "wkup_clkdm");
-DEFINE_STRUCT_CLK(wu_l4_ick, dpll_ck_parent_names, core_ck_ops);
-
 static struct clk gpios_ick;
 
 static const char *gpios_ick_parent_names[] = {
-	"wu_l4_ick",
+	"sys_ck",
 };
 
 static struct clk_hw_omap gpios_ick_hw = {
@@ -1811,13 +1806,6 @@ static struct clk_hw_omap wdt1_ick_hw = {
 
 DEFINE_STRUCT_CLK(wdt1_ick, gpios_ick_parent_names, aes_ick_ops);
 
-static struct clk wdt1_osc_ck;
-
-static const struct clk_ops wdt1_osc_ck_ops = {};
-
-DEFINE_STRUCT_CLK_HW_OMAP(wdt1_osc_ck, NULL);
-DEFINE_STRUCT_CLK(wdt1_osc_ck, sys_ck_parent_names, wdt1_osc_ck_ops);
-
 static struct clk wdt4_fck;
 
 static struct clk_hw_omap wdt4_fck_hw = {
@@ -1869,7 +1857,6 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_243X),
 	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_243X),
 	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_243X),
-	CLK(NULL,	"ck_wdt1_osc",	&wdt1_osc_ck,	CK_243X),
 	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_243X),
 	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_243X),
 	CLK(NULL,	"emul_ck",	&emul_ck,	CK_243X),
@@ -1898,7 +1885,6 @@ static struct omap_clk omap2430_clks[] = {
 	/* L4 domain clocks */
 	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X),
 	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X),
-	CLK(NULL,	"wu_l4_ick",	&wu_l4_ick,	CK_243X),
 	/* virtual meta-group clock */
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X),
 	/* general l4 interface ck, multi-parent functional clk */
-- 
1.7.10.4

