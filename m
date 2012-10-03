From: jean.pihet@newoldbits.com
Subject: [PATCH 1/2] ARM: OMAP: hwmod: align the SmartReflex fck names
Date: Wed,  3 Oct 2012 17:47:56 +0200
Message-ID: <1349279277-7634-2-git-send-email-j-pihet@ti.com>
References: <1349279277-7634-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:59497 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383Ab2JCPrl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 11:47:41 -0400
Received: by wibhr7 with SMTP id hr7so2638104wib.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Oct 2012 08:47:40 -0700 (PDT)
In-Reply-To: <1349279277-7634-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbou@mail.ru>
Cc: J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Rename the smartreflex fck names for consistency and better readability;
rename the clock aliases for use by the SmartReflex driver, with the
"smartreflex.%d" format.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/clock33xx_data.c       |   12 ++++++------
 arch/arm/mach-omap2/clock3xxx_data.c       |   12 ++++++------
 arch/arm/mach-omap2/clock44xx_data.c       |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index 2026311..851fc54 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -548,16 +548,16 @@ static struct clk mcasp1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk smartreflex0_fck = {
-	.name		= "smartreflex0_fck",
+static struct clk smartreflex_mpu_fck = {
+	.name		= "smartreflex_mpu_fck",
 	.clkdm_name	= "l4_wkup_clkdm",
 	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk smartreflex1_fck = {
-	.name		= "smartreflex1_fck",
+static struct clk smartreflex_core_fck = {
+	.name		= "smartreflex_core_fck",
 	.clkdm_name	= "l4_wkup_clkdm",
 	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
@@ -1036,8 +1036,8 @@ static struct omap_clk am33xx_clks[] = {
 	CLK("davinci-mcasp.1",  NULL,           &mcasp1_fck,    CK_AM33XX),
 	CLK("NULL",	"mmc2_fck",		&mmc2_fck,	CK_AM33XX),
 	CLK(NULL,	"mmu_fck",		&mmu_fck,	CK_AM33XX),
-	CLK(NULL,	"smartreflex0_fck",	&smartreflex0_fck,	CK_AM33XX),
-	CLK(NULL,	"smartreflex1_fck",	&smartreflex1_fck,	CK_AM33XX),
+	CLK(NULL,	"smartreflex.0",	&smartreflex_mpu_fck,	CK_AM33XX),
+	CLK(NULL,	"smartreflex.1",	&smartreflex_core_fck,	CK_AM33XX),
 	CLK(NULL,	"timer1_fck",		&timer1_fck,	CK_AM33XX),
 	CLK(NULL,	"timer2_fck",		&timer2_fck,	CK_AM33XX),
 	CLK(NULL,	"timer3_fck",		&timer3_fck,	CK_AM33XX),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 700317a..796a1dc 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3050,8 +3050,8 @@ static struct clk traceclk_fck = {
 /* SR clocks */
 
 /* SmartReflex fclk (VDD1) */
-static struct clk sr1_fck = {
-	.name		= "sr1_fck",
+static struct clk smartreflex_mpu_iva_fck = {
+	.name		= "smartreflex_mpu_iva_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
@@ -3061,8 +3061,8 @@ static struct clk sr1_fck = {
 };
 
 /* SmartReflex fclk (VDD2) */
-static struct clk sr2_fck = {
-	.name		= "sr2_fck",
+static struct clk smartreflex_core_fck = {
+	.name		= "smartreflex_core_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
@@ -3448,8 +3448,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_3XXX),
 	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_3XXX),
 	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_3XXX),
-	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_34XX | CK_36XX),
+	CLK(NULL,	"smartreflex.0",	&smartreflex_mpu_iva_fck,	CK_34XX | CK_36XX),
+	CLK(NULL,	"smartreflex.1",	&smartreflex_core_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 500682c..b9b988a 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3224,9 +3224,9 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"slimbus2_fclk_0",		&slimbus2_fclk_0,	CK_443X),
 	CLK(NULL,	"slimbus2_slimbus_clk",		&slimbus2_slimbus_clk,	CK_443X),
 	CLK(NULL,	"slimbus2_fck",			&slimbus2_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
+	CLK(NULL,	"smartreflex.0",		&smartreflex_core_fck,	CK_443X),
+	CLK(NULL,	"smartreflex.1",		&smartreflex_iva_fck,	CK_443X),
+	CLK(NULL,	"smartreflex.2",		&smartreflex_mpu_fck,	CK_443X),
 	CLK(NULL,	"timer1_fck",			&timer1_fck,	CK_443X),
 	CLK(NULL,	"timer10_fck",			&timer10_fck,	CK_443X),
 	CLK(NULL,	"timer11_fck",			&timer11_fck,	CK_443X),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 94b38af..f1095a6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1368,7 +1368,7 @@ static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
 static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.name		= "smartreflex_mpu_iva",
 	.class		= &omap34xx_smartreflex_hwmod_class,
-	.main_clk	= "sr1_fck",
+	.main_clk	= "smartreflex_mpu_iva_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1386,7 +1386,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.name		= "smartreflex_mpu_iva",
 	.class		= &omap36xx_smartreflex_hwmod_class,
-	.main_clk	= "sr1_fck",
+	.main_clk	= "smartreflex_mpu_iva_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1413,7 +1413,7 @@ static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
 static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.name		= "smartreflex_core",
 	.class		= &omap34xx_smartreflex_hwmod_class,
-	.main_clk	= "sr2_fck",
+	.main_clk	= "smartreflex_core_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1431,7 +1431,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.name		= "smartreflex_core",
 	.class		= &omap36xx_smartreflex_hwmod_class,
-	.main_clk	= "sr2_fck",
+	.main_clk	= "smartreflex_core_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
-- 
1.7.10.4

