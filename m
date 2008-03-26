From: =?utf-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@nokia.com>
Subject: [PATCH] 34XX: Fix to use correct shift values for gpio2-6 fclks
Date: Wed, 26 Mar 2008 13:57:38 +0200
Message-ID: <1206532658-11875-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45820 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbYCZL5s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Mar 2008 07:57:48 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2QBxiLD000388
	for <linux-omap@vger.kernel.org>; Wed, 26 Mar 2008 06:59:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Wrong shift values were used for gpio2-6  fclks (gpt2-6 shift).
---
 arch/arm/mach-omap2/clock34xx.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 3fda2c5..a6a3ed5 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2357,7 +2357,7 @@ static struct clk gpio6_fck = {
 	.name		= "gpio6_fck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
+	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
@@ -2366,7 +2366,7 @@ static struct clk gpio5_fck = {
 	.name		= "gpio5_fck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
+	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
@@ -2375,7 +2375,7 @@ static struct clk gpio4_fck = {
 	.name		= "gpio4_fck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
+	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
@@ -2384,7 +2384,7 @@ static struct clk gpio3_fck = {
 	.name		= "gpio3_fck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
+	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
@@ -2393,7 +2393,7 @@ static struct clk gpio2_fck = {
 	.name		= "gpio2_fck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
+	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
-- 
1.5.3.5

