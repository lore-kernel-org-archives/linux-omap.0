From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/5] OMAP3 clock: add wait for USIM module to become active
Date: Tue, 16 Sep 2008 08:58:40 -0600
Message-ID: <20080916145838.1470.22491.stgit@localhost.localdomain>
References: <20080916145747.1470.51591.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47799 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbYIPPPO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 11:15:14 -0400
In-Reply-To: <20080916145747.1470.51591.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

This patch adds the register definitions and clock tree fields required
to wait for the USIM module to come out of idle when the USIM clocks are
enabled.  Register bit definitions are from the 34xx HS Addendum Rev B.
There, the clock is in fact named "USIM_ICLK".

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h       |    8 ++++----
 arch/arm/mach-omap2/cm-regbits-34xx.h |    7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 78f1295..7fc1b81 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2481,10 +2481,11 @@ static struct clk usim_fck = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430ES2_EN_USIMOCP_SHIFT,
+	.idlest_bit	= OMAP3430ES2_ST_USIMOCP_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430ES2_CLKSEL_USIMOCP_MASK,
 	.clksel		= usim_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES2,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2545,15 +2546,14 @@ static struct clk wkup_l4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-/* 3430ES2 only */
-/* Never specifically named in the TRM, so we have to infer a likely name */
 static struct clk usim_ick = {
 	.name		= "usim_ick",
 	.parent		= &wkup_l4_ick,
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430ES2_EN_USIMOCP_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
+	.idlest_bit	= OMAP3430ES2_ST_USIMOCP_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 5242ce9..6f3f5a3 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -383,6 +383,7 @@
 
 /* CM_FCLKEN_WKUP specific bits */
 #define OMAP3430ES2_EN_USIMOCP_SHIFT			9
+#define OMAP3430ES2_EN_USIMOCP_MASK			(1 << 9)
 
 /* CM_ICLKEN_WKUP specific bits */
 #define OMAP3430_EN_WDT1				(1 << 4)
@@ -391,6 +392,8 @@
 #define OMAP3430_EN_32KSYNC_SHIFT			2
 
 /* CM_IDLEST_WKUP specific bits */
+#define OMAP3430ES2_ST_USIMOCP_SHIFT			9
+#define OMAP3430ES2_ST_USIMOCP_MASK			(1 << 9)
 #define OMAP3430_ST_WDT2_SHIFT				5
 #define OMAP3430_ST_WDT2_MASK				(1 << 5)
 #define OMAP3430_ST_WDT1_SHIFT				4
@@ -399,6 +402,8 @@
 #define OMAP3430_ST_32KSYNC_MASK			(1 << 2)
 
 /* CM_AUTOIDLE_WKUP */
+#define OMAP3430ES2_AUTO_USIMOCP				(1 << 9)
+#define OMAP3430ES2_AUTO_USIMOCP_SHIFT			9
 #define OMAP3430_AUTO_WDT2				(1 << 5)
 #define OMAP3430_AUTO_WDT2_SHIFT			5
 #define OMAP3430_AUTO_WDT1				(1 << 4)
@@ -463,6 +468,8 @@
 #define OMAP3430_ST_CORE_CLK_MASK			(1 << 0)
 
 /* CM_IDLEST2_CKGEN */
+#define OMAP3430ES2_ST_USIM_CLK_SHIFT			2
+#define OMAP3430ES2_ST_USIM_CLK_MASK			(1 << 2)
 #define OMAP3430ES2_ST_120M_CLK_SHIFT			1
 #define OMAP3430ES2_ST_120M_CLK_MASK			(1 << 1)
 #define OMAP3430ES2_ST_PERIPH2_CLK_SHIFT		0


