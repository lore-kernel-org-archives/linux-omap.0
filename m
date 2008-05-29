From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4/5] Fix mcbsp clock definition on clock34xx.h
Date: Thu, 29 May 2008 11:31:37 -0400
Message-ID: <1212075098-29819-3-git-send-email-edubezval@gmail.com>
References: <1212075098-29819-1-git-send-email-edubezval@gmail.com>
 <1212075098-29819-2-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64862 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbYE2PcZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 11:32:25 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4TFW2L6009549
	for <linux-omap@vger.kernel.org>; Thu, 29 May 2008 18:32:23 +0300
In-Reply-To: <1212075098-29819-2-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch fix the clock definition for mcbsps on clock34xx.h.
Device identification must be done using .id field, not
only name field.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap2/clock34xx.h |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 284c796..8f90b8c 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1480,7 +1480,8 @@ static const struct clksel mcbsp_15_clksel[] = {
 };
 
 static struct clk mcbsp5_fck = {
-	.name		= "mcbsp5_fck",
+	.name		= "mcbsp_fck",
+	.id		= 5,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
@@ -1493,7 +1494,8 @@ static struct clk mcbsp5_fck = {
 };
 
 static struct clk mcbsp1_fck = {
-	.name		= "mcbsp1_fck",
+	.name		= "mcbsp_fck",
+	.id		= 1,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
@@ -1941,7 +1943,8 @@ static struct clk gpt10_ick = {
 };
 
 static struct clk mcbsp5_ick = {
-	.name		= "mcbsp5_ick",
+	.name		= "mcbsp_ick",
+	.id		= 5,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
@@ -1951,7 +1954,8 @@ static struct clk mcbsp5_ick = {
 };
 
 static struct clk mcbsp1_ick = {
-	.name		= "mcbsp1_ick",
+	.name		= "mcbsp_ick",
+	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
@@ -2754,7 +2758,8 @@ static struct clk gpt2_ick = {
 };
 
 static struct clk mcbsp2_ick = {
-	.name		= "mcbsp2_ick",
+	.name		= "mcbsp_ick",
+	.id		= 2,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
@@ -2764,7 +2769,8 @@ static struct clk mcbsp2_ick = {
 };
 
 static struct clk mcbsp3_ick = {
-	.name		= "mcbsp3_ick",
+	.name		= "mcbsp_ick",
+	.id		= 3,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
@@ -2774,7 +2780,8 @@ static struct clk mcbsp3_ick = {
 };
 
 static struct clk mcbsp4_ick = {
-	.name		= "mcbsp4_ick",
+	.name		= "mcbsp_ick",
+	.id		= 4,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
@@ -2790,7 +2797,8 @@ static const struct clksel mcbsp_234_clksel[] = {
 };
 
 static struct clk mcbsp2_fck = {
-	.name		= "mcbsp2_fck",
+	.name		= "mcbsp_fck",
+	.id		= 2,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
@@ -2803,7 +2811,8 @@ static struct clk mcbsp2_fck = {
 };
 
 static struct clk mcbsp3_fck = {
-	.name		= "mcbsp3_fck",
+	.name		= "mcbsp_fck",
+	.id		= 3,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
@@ -2816,7 +2825,8 @@ static struct clk mcbsp3_fck = {
 };
 
 static struct clk mcbsp4_fck = {
-	.name		= "mcbsp4_fck",
+	.name		= "mcbsp_fck",
+	.id		= 4,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
-- 
1.5.5.GIT

