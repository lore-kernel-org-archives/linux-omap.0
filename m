From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/21] OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
Date: Wed,  4 Feb 2009 18:05:56 -0800
Message-ID: <1233799567-22250-11-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-9-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-10-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:64709 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261AbZBECHF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:07:05 -0500
Received: by yx-out-2324.google.com with SMTP id 8so30yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:07:04 -0800 (PST)
In-Reply-To: <1233799567-22250-10-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Add D2D clocks (modem_fck, sad2d_ick, mad2d_ick) to clock framework,
and also ensure that auto-idle bits are set for these clocks during
PRCM init.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock34xx.h       |   38 +++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/cm-regbits-34xx.h |   14 ++++++++++++
 arch/arm/mach-omap2/pm34xx.c          |    4 ++-
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 179ea17..5c1902d 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1283,6 +1283,39 @@ static struct clk d2d_26m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk modem_fck = {
+	.name		= "modem_fck",
+	.parent		= &sys_ck,
+	.prcm_mod	= CORE_MOD,
+	.enable_reg	= CM_FCLKEN1,
+	.enable_bit	= OMAP3430_EN_MODEM_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "d2d_clkdm" },
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sad2d_ick = {
+	.name		= "sad2d_ick",
+	.parent		= &l3_ick,
+	.prcm_mod	= CORE_MOD,
+	.enable_reg	= CM_ICLKEN1,
+	.enable_bit	= OMAP3430_EN_SAD2D_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "d2d_clkdm" },
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mad2d_ick = {
+	.name		= "mad2d_ick",
+	.parent		= &l3_ick,
+	.prcm_mod	= CORE_MOD,
+	.enable_reg	= CM_ICLKEN3,
+	.enable_bit	= OMAP3430_EN_MAD2D_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "d2d_clkdm" },
+	.recalc		= &followparent_recalc,
+};
+
 static const struct clksel omap343x_gpt_clksel[] = {
 	{ .parent = &omap_32k_fck, .rates = gpt_32k_rates },
 	{ .parent = &sys_ck,	   .rates = gpt_sys_rates },
@@ -2187,8 +2220,6 @@ static struct clk usb_l4_ick = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-/* XXX MDM_INTC_ICK, SAD2D_ICK ?? */
-
 /* SECURITY_L4_ICK2 based clocks */
 
 static struct clk security_l4_ick2 = {
@@ -3402,6 +3433,9 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&sgx_fck,
 	&sgx_ick,
 	&d2d_26m_fck,
+	&modem_fck,
+	&sad2d_ick,
+	&mad2d_ick,
 	&gpt10_fck,
 	&gpt11_fck,
 	&cpefuse_fck,
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6f3f5a3..6923deb 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -145,6 +145,8 @@
 #define OMAP3430_CLKACTIVITY_MPU_MASK			(1 << 0)
 
 /* CM_FCLKEN1_CORE specific bits */
+#define OMAP3430_EN_MODEM				(1 << 31)
+#define OMAP3430_EN_MODEM_SHIFT				31
 
 /* CM_ICLKEN1_CORE specific bits */
 #define OMAP3430_EN_ICR					(1 << 29)
@@ -161,6 +163,8 @@
 #define OMAP3430_EN_MAILBOXES_SHIFT			7
 #define OMAP3430_EN_OMAPCTRL				(1 << 6)
 #define OMAP3430_EN_OMAPCTRL_SHIFT			6
+#define OMAP3430_EN_SAD2D				(1 << 3)
+#define OMAP3430_EN_SAD2D_SHIFT				3
 #define OMAP3430_EN_SDRC				(1 << 1)
 #define OMAP3430_EN_SDRC_SHIFT				1
 
@@ -176,6 +180,10 @@
 #define OMAP3430_EN_DES1				(1 << 0)
 #define OMAP3430_EN_DES1_SHIFT				0
 
+/* CM_ICLKEN3_CORE */
+#define OMAP3430_EN_MAD2D_SHIFT				3
+#define OMAP3430_EN_MAD2D				(1 << 3)
+
 /* CM_FCLKEN3_CORE specific bits */
 #define OMAP3430ES2_EN_TS_SHIFT				1
 #define OMAP3430ES2_EN_TS_MASK				(1 << 1)
@@ -231,6 +239,8 @@
 #define OMAP3430ES2_ST_CPEFUSE_MASK			(1 << 0)
 
 /* CM_AUTOIDLE1_CORE */
+#define OMAP3430_AUTO_MODEM				(1 << 31)
+#define OMAP3430_AUTO_MODEM_SHIFT			31
 #define OMAP3430ES2_AUTO_MMC3				(1 << 30)
 #define OMAP3430ES2_AUTO_MMC3_SHIFT			30
 #define OMAP3430ES2_AUTO_ICR				(1 << 29)
@@ -287,6 +297,8 @@
 #define OMAP3430_AUTO_HSOTGUSB_SHIFT			4
 #define OMAP3430ES1_AUTO_D2D				(1 << 3)
 #define OMAP3430ES1_AUTO_D2D_SHIFT			3
+#define OMAP3430_AUTO_SAD2D				(1 << 3)
+#define OMAP3430_AUTO_SAD2D_SHIFT			3
 #define OMAP3430_AUTO_SSI				(1 << 0)
 #define OMAP3430_AUTO_SSI_SHIFT				0
 
@@ -308,6 +320,8 @@
 #define	OMAP3430ES2_AUTO_USBTLL				(1 << 2)
 #define OMAP3430ES2_AUTO_USBTLL_SHIFT			2
 #define OMAP3430ES2_AUTO_USBTLL_MASK			(1 << 2)
+#define OMAP3430_AUTO_MAD2D_SHIFT			3
+#define OMAP3430_AUTO_MAD2D				(1 << 3)
 
 /* CM_CLKSEL_CORE */
 #define OMAP3430_CLKSEL_SSI_SHIFT			8
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index dc27599..87ac320 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -453,6 +453,7 @@ static void __init prcm_setup_regs(void)
 	 * Note that in the long run this should be done by clockfw
 	 */
 	cm_write_mod_reg(
+		OMAP3430_AUTO_MODEM |
 		OMAP3430ES2_AUTO_MMC3 |
 		OMAP3430ES2_AUTO_ICR |
 		OMAP3430_AUTO_AES2 |
@@ -480,7 +481,7 @@ static void __init prcm_setup_regs(void)
 		OMAP3430_AUTO_OMAPCTRL |
 		OMAP3430ES1_AUTO_FSHOSTUSB |
 		OMAP3430_AUTO_HSOTGUSB |
-		OMAP3430ES1_AUTO_D2D | /* This is es1 only */
+		OMAP3430_AUTO_SAD2D |
 		OMAP3430_AUTO_SSI,
 		CORE_MOD, CM_AUTOIDLE1);
 
@@ -494,6 +495,7 @@ static void __init prcm_setup_regs(void)
 
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
 		cm_write_mod_reg(
+			OMAP3430_AUTO_MAD2D |
 			OMAP3430ES2_AUTO_USBTLL,
 			CORE_MOD, CM_AUTOIDLE3);
 	}
-- 
1.6.1

