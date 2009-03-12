From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 42/86] [ARM] OMAP2: Fix definition of SGX clock register bits
Date: Thu, 12 Mar 2009 11:27:52 -0700
Message-ID: <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:33493 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689AbZCLSbt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:49 -0400
Received: by qyk28 with SMTP id 28so2233977qyk.33
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:46 -0700 (PDT)
In-Reply-To: <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Daniel Stone <daniel.stone@nokia.com>

The GFX/SGX functional and interface clocks have different masks, for
some unknown reason, so split EN_SGX_SHIFT into one each for fclk and
iclk.

Correct according to the TRM and the far more important 'does this
actually work at all?' metric.

linux-omap source commit is de1121fdb899f762b9e717f44eaf3fae7c00cd3e.

Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock34xx.h       |    4 ++--
 arch/arm/mach-omap2/cm-regbits-34xx.h |    8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 2c84717..6b39ad4 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1293,7 +1293,7 @@ static struct clk sgx_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP3430ES2_EN_SGX_SHIFT,
+	.enable_bit	= OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430ES2_CLKSEL_SGX_MASK,
 	.clksel		= sgx_clksel,
@@ -1307,7 +1307,7 @@ static struct clk sgx_ick = {
 	.parent		= &l3_ick,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP3430ES2_EN_SGX_SHIFT,
+	.enable_bit	= OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT,
 	.clkdm_name	= "sgx_clkdm",
 	.recalc		= &followparent_recalc,
 };
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index a46f93c..f3c327b 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -332,8 +332,12 @@
 #define OMAP3430ES1_CLKACTIVITY_GFX_MASK		(1 << 0)
 
 /* CM_FCLKEN_SGX */
-#define OMAP3430ES2_EN_SGX_SHIFT			1
-#define OMAP3430ES2_EN_SGX_MASK				(1 << 1)
+#define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT		1
+#define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_MASK		(1 << 1)
+
+/* CM_ICLKEN_SGX */
+#define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT		0
+#define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_MASK		(1 << 0)
 
 /* CM_CLKSEL_SGX */
 #define OMAP3430ES2_CLKSEL_SGX_SHIFT			0
-- 
1.6.1.2

