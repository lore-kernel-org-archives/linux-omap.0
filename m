From: Daniel Stone <daniel.stone@nokia.com>
Subject: [PATCH 1/2] ARM: OMAP2: Fix definition of SGX clock register bits
Date: Wed, 27 Aug 2008 04:31:26 +0300
Message-ID: <1219800687-11044-1-git-send-email-daniel.stone@nokia.com>
References: <20080827012736.GA10868@intune.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64126 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbYH0BbA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 21:31:00 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7R1UQQw007467
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 20:30:59 -0500
Received: from intune.research.nokia.com (intune.research.nokia.com [172.21.50.54])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m7R1UIus010613
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 04:30:18 +0300
In-Reply-To: <20080827012736.GA10868@intune.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The GFX/SGX functional and interface clocks have different masks, for
some unknown reason, so split EN_SGX_SHIFT into one each for fclk and
iclk.

Correct according to the TRM and the far more important 'does this
actually work at all?' metric.

Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h       |    4 ++--
 arch/arm/mach-omap2/cm-regbits-34xx.h |    8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index d7d6ffd..6518b1e 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1323,7 +1323,7 @@ static struct clk sgx_fck = {
 	.name		= "sgx_fck",
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430ES2_EN_SGX_SHIFT,
+	.enable_bit	= OMAP3430ES2_EN_SGX_FSHIFT,
 	.clksel_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430ES2_CLKSEL_SGX_MASK,
 	.clksel		= sgx_clksel,
@@ -1337,7 +1337,7 @@ static struct clk sgx_ick = {
 	.parent		= &l3_ick,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430ES2_EN_SGX_SHIFT,
+	.enable_bit	= OMAP3430ES2_EN_SGX_ISHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm		= { .name = "sgx_clkdm" },
 	.recalc		= &followparent_recalc,
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index ffb695b..06a78a7 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -339,9 +339,11 @@
 #define OMAP3430ES1_CLKACTIVITY_GFX_SHIFT		0
 #define OMAP3430ES1_CLKACTIVITY_GFX_MASK		(1 << 0)
 
-/* CM_FCLKEN_SGX */
-#define OMAP3430ES2_EN_SGX_SHIFT			1
-#define OMAP3430ES2_EN_SGX_MASK				(1 << 1)
+/* CM_FCLKEN_SGX/CM_ICLKEN_SGX */
+#define OMAP3430ES2_EN_SGX_FSHIFT			1
+#define OMAP3430ES2_EN_SGX_FMASK			(1 << 1)
+#define OMAP3430ES2_EN_SGX_ISHIFT			0
+#define OMAP3430ES2_EN_SGX_IMASK			(1 << 0)
 
 /* CM_CLKSEL_SGX */
 #define OMAP3430ES2_CLKSEL_SGX_SHIFT			0
-- 
1.5.6.3

