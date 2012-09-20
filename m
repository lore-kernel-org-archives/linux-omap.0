From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH] ARM: OMAP: hwmod: align the SmartReflex fck names
Date: Thu, 20 Sep 2012 11:48:23 +0200
Message-ID: <1348134503-28220-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42907 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2ITJsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 05:48:36 -0400
Received: by weyx8 with SMTP id x8so1135883wey.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 02:48:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

Rename the smartreflex fck names:
- for consistency and better readability,
- for use by the SmartReflex driver, through the hwmod .main_clk
  field.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c       |   12 ++++++------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 83bed9a..6c1bdee 100644
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
@@ -3447,8 +3447,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_3XXX),
 	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_3XXX),
 	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_3XXX),
-	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_34XX | CK_36XX),
+	CLK(NULL,	"smartreflex_mpu_iva_fck",	&smartreflex_mpu_iva_fck,	CK_34XX | CK_36XX),
+	CLK(NULL,	"smartreflex_core_fck",	&smartreflex_core_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c9e3820..2b2b8fc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1359,7 +1359,7 @@ static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
 static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.name		= "smartreflex_mpu_iva",
 	.class		= &omap34xx_smartreflex_hwmod_class,
-	.main_clk	= "sr1_fck",
+	.main_clk	= "smartreflex_mpu_iva_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1377,7 +1377,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.name		= "smartreflex_mpu_iva",
 	.class		= &omap36xx_smartreflex_hwmod_class,
-	.main_clk	= "sr1_fck",
+	.main_clk	= "smartreflex_mpu_iva_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1404,7 +1404,7 @@ static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
 static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.name		= "smartreflex_core",
 	.class		= &omap34xx_smartreflex_hwmod_class,
-	.main_clk	= "sr2_fck",
+	.main_clk	= "smartreflex_core_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1422,7 +1422,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.name		= "smartreflex_core",
 	.class		= &omap36xx_smartreflex_hwmod_class,
-	.main_clk	= "sr2_fck",
+	.main_clk	= "smartreflex_core_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
-- 
1.7.7.6

