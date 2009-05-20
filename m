From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 08/13] OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
Date: Wed, 20 May 2009 16:19:31 -0700
Message-ID: <1242861576-13008-9-git-send-email-khilman@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-4-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-5-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-6-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-7-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-8-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:43119 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387AbZETXT7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:19:59 -0400
Received: by mail-px0-f171.google.com with SMTP id 1so365239pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:20:00 -0700 (PDT)
In-Reply-To: <1242861576-13008-8-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Add D2D clocks (modem_fck, sad2d_ick, mad2d_ick) to clock framework
and ensure that auto-idle bits are set for these clocks during PRCM
init.

Also add omap3_d2d_idle() function called durint PRCM setup which
ensures D2D pins are MUX'd correctly to enable retention for
standalone (no-modem) devices.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock34xx.c           |    3 ++
 arch/arm/mach-omap2/clock34xx.h           |   33 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/cm-regbits-34xx.h     |   14 ++++++++++++
 arch/arm/mach-omap2/pm34xx.c              |   25 ++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/control.h |    4 +++
 5 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index ba05aa4..13a36cf 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -129,6 +129,9 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2),
 	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2),
 	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck,	CK_3430ES1),
+	CLK(NULL,	"modem_fck",	&modem_fck,	CK_343X),
+	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_343X),
+	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_343X),
 	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_343X),
 	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_343X),
 	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2),
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 496f0e9..e433aec 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1230,6 +1230,37 @@ static struct clk d2d_26m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk modem_fck = {
+	.name		= "modem_fck",
+	.ops		= &clkops_omap2_dflt_wait,
+	.parent		= &sys_ck,
+	.init		= &omap2_init_clk_clkdm,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MODEM_SHIFT,
+	.clkdm_name	= "d2d_clkdm",
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sad2d_ick = {
+	.name		= "sad2d_ick",
+	.ops		= &clkops_omap2_dflt_wait,
+	.parent		= &l3_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_SAD2D_SHIFT,
+	.clkdm_name	= "d2d_clkdm",
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mad2d_ick = {
+	.name		= "mad2d_ick",
+	.ops		= &clkops_omap2_dflt_wait,
+	.parent		= &l3_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
+	.enable_bit	= OMAP3430_EN_MAD2D_SHIFT,
+	.clkdm_name	= "d2d_clkdm",
+	.recalc		= &followparent_recalc,
+};
+
 static const struct clksel omap343x_gpt_clksel[] = {
 	{ .parent = &omap_32k_fck, .rates = gpt_32k_rates },
 	{ .parent = &sys_ck,	   .rates = gpt_sys_rates },
@@ -1947,8 +1978,6 @@ static struct clk usb_l4_ick = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-/* XXX MDM_INTC_ICK, SAD2D_ICK ?? */
-
 /* SECURITY_L4_ICK2 based clocks */
 
 static struct clk security_l4_ick2 = {
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
index 6c91e43..d41e2c5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -420,14 +420,32 @@ static void __init omap3_iva_idle(void)
 			  OMAP3430_IVA2_MOD, RM_RSTCTRL);
 }
 
-static void __init prcm_setup_regs(void)
+static void __init omap3_d2d_idle(void)
 {
+	u16 mask, padconf;
+
+	/* In a stand alone OMAP3430 where there is not a stacked
+	 * modem for the D2D Idle Ack and D2D MStandby must be pulled
+	 * high. S CONTROL_PADCONF_SAD2D_IDLEACK and
+	 * CONTROL_PADCONF_SAD2D_MSTDBY to have a pull up. */
+	mask = (1 << 4) | (1 << 3); /* pull-up, enabled */
+	padconf = omap_ctrl_readw(OMAP3_PADCONF_SAD2D_MSTANDBY);
+	padconf |= mask;
+	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_MSTANDBY);
+
+	padconf = omap_ctrl_readw(OMAP3_PADCONF_SAD2D_IDLEACK);
+	padconf |= mask;
+	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_IDLEACK);
+
 	/* reset modem */
 	prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON |
 			  OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST,
 			  CORE_MOD, RM_RSTCTRL);
 	prm_write_mod_reg(0, CORE_MOD, RM_RSTCTRL);
+}
 
+static void __init prcm_setup_regs(void)
+{
 	/* XXX Reset all wkdeps. This should be done when initializing
 	 * powerdomains */
 	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
@@ -447,6 +465,7 @@ static void __init prcm_setup_regs(void)
 	 * Note that in the long run this should be done by clockfw
 	 */
 	cm_write_mod_reg(
+		OMAP3430_AUTO_MODEM |
 		OMAP3430ES2_AUTO_MMC3 |
 		OMAP3430ES2_AUTO_ICR |
 		OMAP3430_AUTO_AES2 |
@@ -474,7 +493,7 @@ static void __init prcm_setup_regs(void)
 		OMAP3430_AUTO_OMAPCTRL |
 		OMAP3430ES1_AUTO_FSHOSTUSB |
 		OMAP3430_AUTO_HSOTGUSB |
-		OMAP3430ES1_AUTO_D2D | /* This is es1 only */
+		OMAP3430_AUTO_SAD2D |
 		OMAP3430_AUTO_SSI,
 		CORE_MOD, CM_AUTOIDLE1);
 
@@ -488,6 +507,7 @@ static void __init prcm_setup_regs(void)
 
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
 		cm_write_mod_reg(
+			OMAP3430_AUTO_MAD2D |
 			OMAP3430ES2_AUTO_USBTLL,
 			CORE_MOD, CM_AUTOIDLE3);
 	}
@@ -581,6 +601,7 @@ static void __init prcm_setup_regs(void)
 			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 
 	omap3_iva_idle();
+	omap3_d2d_idle();
 }
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm)
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index a9f05e5..fcc5a9b 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -144,6 +144,10 @@
 #define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02b0)
 #define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
 
+/* 34xx D2D idle-related pins, handled by PM core */
+#define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
+#define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
+
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
  * that should be added.
-- 
1.6.2.2

