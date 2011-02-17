From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] OMAP2xxx: clock: fix interface clocks and clockdomains
	for modules in the WKUP domain
Date: Wed, 16 Feb 2011 21:17:53 -0700
Message-ID: <20110217041752.16009.3279.stgit@twilight.localdomain>
References: <20110217041437.16009.52336.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55847 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290Ab1BQESa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 23:18:30 -0500
In-Reply-To: <20110217041437.16009.52336.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The parent of the interface clocks for GPTIMER1, MPU_WDT,
SYNCTIMER_32K, SCM, WDT1, and the ICR (2430 only) were all listed as
being l4_ck.  This isn't accurate; these modules exist inside the WKUP
domain, and the interface clock to these modules runs at the SYS_CLK
rate rather than the CORE L4 rate.

So, create a new clock "wu_l4_ick", similar to the OMAP3
"wkup_l4_ick", that serves as the parent for these clocks.

Also, these clocks were listed as existing inside core_l4_clkdm;
wkup_clkdm is probably more accurate.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2420_data.c |   33 +++++++++++++++++++-----------
 arch/arm/mach-omap2/clock2430_data.c |   37 +++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index fd5ba90..6e9d20d 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -826,6 +826,14 @@ static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk wu_l4_ick = {
+	.name		= "wu_l4_ick",
+	.ops		= &clkops_null,
+	.parent		= &sys_ck,
+	.clkdm_name	= "wkup_clkdm",
+	.recalc		= &followparent_recalc,
+};
+
 /*
  * CORE power domain ICLK & FCLK defines.
  * Many of the these can have more than one possible parent. Entries
@@ -847,8 +855,8 @@ static const struct clksel omap24xx_gpt_clksel[] = {
 static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1300,8 +1308,8 @@ static struct clk uart3_fck = {
 static struct clk gpios_ick = {
 	.name		= "gpios_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1320,8 +1328,8 @@ static struct clk gpios_fck = {
 static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1340,9 +1348,9 @@ static struct clk mpu_wdt_fck = {
 static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1351,8 +1359,8 @@ static struct clk sync_32k_ick = {
 static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_WDT1_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1361,9 +1369,9 @@ static struct clk wdt1_ick = {
 static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_OMAPCTRL_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1825,6 +1833,7 @@ static struct omap_clk omap2420_clks[] = {
 	/* L4 domain clocks */
 	CLK(NULL,	"l4_ck",	&l4_ck,		CK_242X),
 	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_242X),
+	CLK(NULL,	"wu_l4_ick",	&wu_l4_ick,	CK_242X),
 	/* virtual meta-group clock */
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
 	/* general l4 interface ck, multi-parent functional clk */
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 0d069ef..3378dbf 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -814,6 +814,14 @@ static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk wu_l4_ick = {
+	.name		= "wu_l4_ick",
+	.ops		= &clkops_null,
+	.parent		= &sys_ck,
+	.clkdm_name	= "wkup_clkdm",
+	.recalc		= &followparent_recalc,
+};
+
 /*
  * CORE power domain ICLK & FCLK defines.
  * Many of the these can have more than one possible parent. Entries
@@ -835,8 +843,8 @@ static const struct clksel omap24xx_gpt_clksel[] = {
 static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1380,8 +1388,8 @@ static struct clk uart3_fck = {
 static struct clk gpios_ick = {
 	.name		= "gpios_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1400,8 +1408,8 @@ static struct clk gpios_fck = {
 static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1420,9 +1428,9 @@ static struct clk mpu_wdt_fck = {
 static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
 	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1431,8 +1439,8 @@ static struct clk sync_32k_ick = {
 static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_WDT1_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1441,9 +1449,9 @@ static struct clk wdt1_ick = {
 static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
 	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_OMAPCTRL_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1452,8 +1460,8 @@ static struct clk omapctrl_ick = {
 static struct clk icr_ick = {
 	.name		= "icr_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
+	.parent		= &wu_l4_ick,
+	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_EN_ICR_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1914,6 +1922,7 @@ static struct omap_clk omap2430_clks[] = {
 	/* L4 domain clocks */
 	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X),
 	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X),
+	CLK(NULL,	"wu_l4_ick",	&wu_l4_ick,	CK_243X),
 	/* virtual meta-group clock */
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X),
 	/* general l4 interface ck, multi-parent functional clk */


