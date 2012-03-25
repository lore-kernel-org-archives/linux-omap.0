From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ARM: OMAP3: clock: fix DPLL4 CLKSEL masks
Date: Mon, 26 Mar 2012 00:08:07 +0300
Message-ID: <1332709687-22846-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50711 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab2CYVIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Mar 2012 17:08:13 -0400
Received: by wibhj6 with SMTP id hj6so3681998wib.1
        for <linux-omap@vger.kernel.org>; Sun, 25 Mar 2012 14:08:12 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>

Commit 2a9f5a4d455 "OMAP3 clock: remove unnecessary duplicate of dpll4_m2_ck,
added for 36xx" consolidated dpll4 clock structures between 34xx and 36xx,
but left 34xx CLKSEL masks for most dpll4 related clocks, which causes
clock code to not behave correctly when booting on DM3730 with higher
(36xx only) divisors set:
[    0.000000] WARNING: at arch/arm/mach-omap2/clkt_clksel.c:375 omap2_init_clksel_parent+0x104/0x114()
[    0.000000] clock: dpll4_m3_ck: init parent: could not find regval 0
[    0.000000] WARNING: at arch/arm/mach-omap2/clkt_clksel.c:194 omap2_clksel_recalc+0xd4/0xe4()
[    0.000000] clock: Could not find fieldval 0 for clock dpll4_m3_ck parent dpll4_ck

Fix this by switching to 36xx masks, as valid divisors will be limited
by clksel_rate lists.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 5d0064a..6c4b5db 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -745,7 +745,7 @@ static struct clk dpll4_m3_ck = {
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
+	.clksel_mask	= OMAP3630_CLKSEL_TV_MASK,
 	.clksel		= dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
@@ -830,7 +830,7 @@ static struct clk dpll4_m4_ck = {
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
+	.clksel_mask	= OMAP3630_CLKSEL_DSS1_MASK,
 	.clksel		= dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
@@ -857,7 +857,7 @@ static struct clk dpll4_m5_ck = {
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
+	.clksel_mask	= OMAP3630_CLKSEL_CAM_MASK,
 	.clksel		= dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.set_rate	= &omap2_clksel_set_rate,
@@ -884,7 +884,7 @@ static struct clk dpll4_m6_ck = {
 	.parent		= &dpll4_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
+	.clksel_mask	= OMAP3630_DIV_DPLL4_MASK,
 	.clksel		= dpll4_clksel,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
-- 
1.7.0.4

