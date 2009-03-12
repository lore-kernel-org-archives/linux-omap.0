From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 05/86] [ARM] omap: add default .ops to all remaining OMAP2 clocks
Date: Thu, 12 Mar 2009 11:27:15 -0700
Message-ID: <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbZCLS3V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:21 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:19 -0700 (PDT)
In-Reply-To: <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c     |   35 ++++++----
 arch/arm/mach-omap2/clock.h     |    2 +
 arch/arm/mach-omap2/clock24xx.h |  115 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock34xx.h |  133 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 271 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 21fbe29..8c09711 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -264,16 +264,10 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	omap2_wait_clock_ready(st_reg, bit, clk->name);
 }
 
-/* Enables clock without considering parent dependencies or use count
- * REVISIT: Maybe change this to use clk->enable like on omap1?
- */
-int _omap2_clk_enable(struct clk *clk)
+static int omap2_dflt_clk_enable_wait(struct clk *clk)
 {
 	u32 regval32;
 
-	if (clk->ops && clk->ops->enable)
-		return clk->ops->enable(clk);
-
 	if (unlikely(clk->enable_reg == NULL)) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
 		       clk->name);
@@ -293,16 +287,10 @@ int _omap2_clk_enable(struct clk *clk)
 	return 0;
 }
 
-/* Disables clock without considering parent dependencies or use count */
-void _omap2_clk_disable(struct clk *clk)
+static void omap2_dflt_clk_disable(struct clk *clk)
 {
 	u32 regval32;
 
-	if (clk->ops && clk->ops->disable) {
-		clk->ops->disable(clk);
-		return;
-	}
-
 	if (clk->enable_reg == NULL) {
 		/*
 		 * 'Independent' here refers to a clock which is not
@@ -322,6 +310,25 @@ void _omap2_clk_disable(struct clk *clk)
 	wmb();
 }
 
+const struct clkops clkops_omap2_dflt_wait = {
+	.enable		= omap2_dflt_clk_enable_wait,
+	.disable	= omap2_dflt_clk_disable,
+};
+
+/* Enables clock without considering parent dependencies or use count
+ * REVISIT: Maybe change this to use clk->enable like on omap1?
+ */
+static int _omap2_clk_enable(struct clk *clk)
+{
+	return clk->ops->enable(clk);
+}
+
+/* Disables clock without considering parent dependencies or use count */
+static void _omap2_clk_disable(struct clk *clk)
+{
+	clk->ops->disable(clk);
+}
+
 void omap2_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 1fb330e..d4bdb59 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -51,6 +51,8 @@ u32 omap2_get_dpll_rate(struct clk *clk);
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
 void omap2_clk_prepare_for_reboot(void);
 
+extern const struct clkops clkops_omap2_dflt_wait;
+
 extern u8 cpu_mask;
 
 /* clksel_rate data common to 24xx/343x */
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index adc00e1..b59bf90 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -890,6 +890,7 @@ static const struct clksel common_clkout_src_clksel[] = {
 
 static struct clk sys_clkout_src = {
 	.name		= "sys_clkout_src",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES,
@@ -936,6 +937,7 @@ static struct clk sys_clkout = {
 /* In 2430, new in 2420 ES2 */
 static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
@@ -972,6 +974,7 @@ static struct clk sys_clkout2 = {
 
 static struct clk emul_ck = {
 	.name		= "emul_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "wkup_clkdm",
@@ -1051,6 +1054,7 @@ static const struct clksel dsp_fck_clksel[] = {
 
 static struct clk dsp_fck = {
 	.name		= "dsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
@@ -1096,6 +1100,7 @@ static struct clk dsp_irate_ick = {
 /* 2420 only */
 static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dsp_irate_ick,
 	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
@@ -1105,6 +1110,7 @@ static struct clk dsp_ick = {
 /* 2430 only - EN_DSP controls both dsp fclk and iclk on 2430 */
 static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dsp_irate_ick,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
@@ -1118,6 +1124,7 @@ static struct clk iva2_1_ick = {
  */
 static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT |
 				RATE_PROPAGATES | DELAYED_APP,
@@ -1135,6 +1142,7 @@ static struct clk iva1_ifck = {
 /* IVA1 mpu/int/i/f clocks are /2 of parent */
 static struct clk iva1_mpu_int_ifck = {
 	.name		= "iva1_mpu_int_ifck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &iva1_ifck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "iva1_clkdm",
@@ -1211,6 +1219,7 @@ static const struct clksel usb_l4_ick_clksel[] = {
 /* It is unclear from TRM whether usb_l4_ick is really in L3 or L4 clkdm */
 static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.name		= "usb_l4_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP | CONFIG_PARTICIPANT,
@@ -1284,6 +1293,7 @@ static const struct clksel ssi_ssr_sst_fck_clksel[] = {
 
 static struct clk ssi_ssr_sst_fck = {
 	.name		= "ssi_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
@@ -1320,6 +1330,7 @@ static const struct clksel gfx_fck_clksel[] = {
 
 static struct clk gfx_3d_fck = {
 	.name		= "gfx_3d_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "gfx_clkdm",
@@ -1335,6 +1346,7 @@ static struct clk gfx_3d_fck = {
 
 static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "gfx_clkdm",
@@ -1350,6 +1362,7 @@ static struct clk gfx_2d_fck = {
 
 static struct clk gfx_ick = {
 	.name		= "gfx_ick",		/* From l3 */
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "gfx_clkdm",
@@ -1380,6 +1393,7 @@ static const struct clksel mdm_ick_clksel[] = {
 
 static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm_name	= "mdm_clkdm",
@@ -1395,6 +1409,7 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 
 static struct clk mdm_osc_ck = {
 	.name		= "mdm_osc_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "mdm_clkdm",
@@ -1440,6 +1455,7 @@ static const struct clksel dss1_fck_clksel[] = {
 
 static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.name		= "dss_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,	/* really both l3 and l4 */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "dss_clkdm",
@@ -1450,6 +1466,7 @@ static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 
 static struct clk dss1_fck = {
 	.name		= "dss1_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,		/* Core or sys */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
@@ -1483,6 +1500,7 @@ static const struct clksel dss2_fck_clksel[] = {
 
 static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.name		= "dss2_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
@@ -1498,6 +1516,7 @@ static struct clk dss2_fck = {		/* Alt clk used in power management */
 
 static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.name		= "dss_54m_fck",	/* 54m tv clk */
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "dss_clkdm",
@@ -1526,6 +1545,7 @@ static const struct clksel omap24xx_gpt_clksel[] = {
 
 static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1536,6 +1556,7 @@ static struct clk gpt1_ick = {
 
 static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1552,6 +1573,7 @@ static struct clk gpt1_fck = {
 
 static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1562,6 +1584,7 @@ static struct clk gpt2_ick = {
 
 static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1576,6 +1599,7 @@ static struct clk gpt2_fck = {
 
 static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1586,6 +1610,7 @@ static struct clk gpt3_ick = {
 
 static struct clk gpt3_fck = {
 	.name		= "gpt3_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1600,6 +1625,7 @@ static struct clk gpt3_fck = {
 
 static struct clk gpt4_ick = {
 	.name		= "gpt4_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1610,6 +1636,7 @@ static struct clk gpt4_ick = {
 
 static struct clk gpt4_fck = {
 	.name		= "gpt4_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1624,6 +1651,7 @@ static struct clk gpt4_fck = {
 
 static struct clk gpt5_ick = {
 	.name		= "gpt5_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1634,6 +1662,7 @@ static struct clk gpt5_ick = {
 
 static struct clk gpt5_fck = {
 	.name		= "gpt5_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1648,6 +1677,7 @@ static struct clk gpt5_fck = {
 
 static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1658,6 +1688,7 @@ static struct clk gpt6_ick = {
 
 static struct clk gpt6_fck = {
 	.name		= "gpt6_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1672,6 +1703,7 @@ static struct clk gpt6_fck = {
 
 static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1681,6 +1713,7 @@ static struct clk gpt7_ick = {
 
 static struct clk gpt7_fck = {
 	.name		= "gpt7_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1695,6 +1728,7 @@ static struct clk gpt7_fck = {
 
 static struct clk gpt8_ick = {
 	.name		= "gpt8_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1705,6 +1739,7 @@ static struct clk gpt8_ick = {
 
 static struct clk gpt8_fck = {
 	.name		= "gpt8_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1719,6 +1754,7 @@ static struct clk gpt8_fck = {
 
 static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1729,6 +1765,7 @@ static struct clk gpt9_ick = {
 
 static struct clk gpt9_fck = {
 	.name		= "gpt9_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1743,6 +1780,7 @@ static struct clk gpt9_fck = {
 
 static struct clk gpt10_ick = {
 	.name		= "gpt10_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1753,6 +1791,7 @@ static struct clk gpt10_ick = {
 
 static struct clk gpt10_fck = {
 	.name		= "gpt10_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1767,6 +1806,7 @@ static struct clk gpt10_fck = {
 
 static struct clk gpt11_ick = {
 	.name		= "gpt11_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1777,6 +1817,7 @@ static struct clk gpt11_ick = {
 
 static struct clk gpt11_fck = {
 	.name		= "gpt11_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1791,6 +1832,7 @@ static struct clk gpt11_fck = {
 
 static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1801,6 +1843,7 @@ static struct clk gpt12_ick = {
 
 static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1815,6 +1858,7 @@ static struct clk gpt12_fck = {
 
 static struct clk mcbsp1_ick = {
 	.name		= "mcbsp_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
@@ -1826,6 +1870,7 @@ static struct clk mcbsp1_ick = {
 
 static struct clk mcbsp1_fck = {
 	.name		= "mcbsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
@@ -1837,6 +1882,7 @@ static struct clk mcbsp1_fck = {
 
 static struct clk mcbsp2_ick = {
 	.name		= "mcbsp_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
@@ -1848,6 +1894,7 @@ static struct clk mcbsp2_ick = {
 
 static struct clk mcbsp2_fck = {
 	.name		= "mcbsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
@@ -1859,6 +1906,7 @@ static struct clk mcbsp2_fck = {
 
 static struct clk mcbsp3_ick = {
 	.name		= "mcbsp_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -1870,6 +1918,7 @@ static struct clk mcbsp3_ick = {
 
 static struct clk mcbsp3_fck = {
 	.name		= "mcbsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -1881,6 +1930,7 @@ static struct clk mcbsp3_fck = {
 
 static struct clk mcbsp4_ick = {
 	.name		= "mcbsp_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -1892,6 +1942,7 @@ static struct clk mcbsp4_ick = {
 
 static struct clk mcbsp4_fck = {
 	.name		= "mcbsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -1903,6 +1954,7 @@ static struct clk mcbsp4_fck = {
 
 static struct clk mcbsp5_ick = {
 	.name		= "mcbsp_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 5,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -1914,6 +1966,7 @@ static struct clk mcbsp5_ick = {
 
 static struct clk mcbsp5_fck = {
 	.name		= "mcbsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 5,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -1925,6 +1978,7 @@ static struct clk mcbsp5_fck = {
 
 static struct clk mcspi1_ick = {
 	.name		= "mcspi_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1936,6 +1990,7 @@ static struct clk mcspi1_ick = {
 
 static struct clk mcspi1_fck = {
 	.name		= "mcspi_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
@@ -1947,6 +2002,7 @@ static struct clk mcspi1_fck = {
 
 static struct clk mcspi2_ick = {
 	.name		= "mcspi_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
@@ -1958,6 +2014,7 @@ static struct clk mcspi2_ick = {
 
 static struct clk mcspi2_fck = {
 	.name		= "mcspi_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
@@ -1969,6 +2026,7 @@ static struct clk mcspi2_fck = {
 
 static struct clk mcspi3_ick = {
 	.name		= "mcspi_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -1980,6 +2038,7 @@ static struct clk mcspi3_ick = {
 
 static struct clk mcspi3_fck = {
 	.name		= "mcspi_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -1991,6 +2050,7 @@ static struct clk mcspi3_fck = {
 
 static struct clk uart1_ick = {
 	.name		= "uart1_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2001,6 +2061,7 @@ static struct clk uart1_ick = {
 
 static struct clk uart1_fck = {
 	.name		= "uart1_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2011,6 +2072,7 @@ static struct clk uart1_fck = {
 
 static struct clk uart2_ick = {
 	.name		= "uart2_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2021,6 +2083,7 @@ static struct clk uart2_ick = {
 
 static struct clk uart2_fck = {
 	.name		= "uart2_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2031,6 +2094,7 @@ static struct clk uart2_fck = {
 
 static struct clk uart3_ick = {
 	.name		= "uart3_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2041,6 +2105,7 @@ static struct clk uart3_ick = {
 
 static struct clk uart3_fck = {
 	.name		= "uart3_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2051,6 +2116,7 @@ static struct clk uart3_fck = {
 
 static struct clk gpios_ick = {
 	.name		= "gpios_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2061,6 +2127,7 @@ static struct clk gpios_ick = {
 
 static struct clk gpios_fck = {
 	.name		= "gpios_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "wkup_clkdm",
@@ -2071,6 +2138,7 @@ static struct clk gpios_fck = {
 
 static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2081,6 +2149,7 @@ static struct clk mpu_wdt_ick = {
 
 static struct clk mpu_wdt_fck = {
 	.name		= "mpu_wdt_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "wkup_clkdm",
@@ -2091,6 +2160,7 @@ static struct clk mpu_wdt_fck = {
 
 static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ENABLE_ON_INIT,
@@ -2102,6 +2172,7 @@ static struct clk sync_32k_ick = {
 
 static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2112,6 +2183,7 @@ static struct clk wdt1_ick = {
 
 static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ENABLE_ON_INIT,
@@ -2123,6 +2195,7 @@ static struct clk omapctrl_ick = {
 
 static struct clk icr_ick = {
 	.name		= "icr_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2133,6 +2206,7 @@ static struct clk icr_ick = {
 
 static struct clk cam_ick = {
 	.name		= "cam_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2148,6 +2222,7 @@ static struct clk cam_ick = {
  */
 static struct clk cam_fck = {
 	.name		= "cam_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
@@ -2158,6 +2233,7 @@ static struct clk cam_fck = {
 
 static struct clk mailboxes_ick = {
 	.name		= "mailboxes_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2168,6 +2244,7 @@ static struct clk mailboxes_ick = {
 
 static struct clk wdt4_ick = {
 	.name		= "wdt4_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2178,6 +2255,7 @@ static struct clk wdt4_ick = {
 
 static struct clk wdt4_fck = {
 	.name		= "wdt4_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2188,6 +2266,7 @@ static struct clk wdt4_fck = {
 
 static struct clk wdt3_ick = {
 	.name		= "wdt3_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2198,6 +2277,7 @@ static struct clk wdt3_ick = {
 
 static struct clk wdt3_fck = {
 	.name		= "wdt3_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2208,6 +2288,7 @@ static struct clk wdt3_fck = {
 
 static struct clk mspro_ick = {
 	.name		= "mspro_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2218,6 +2299,7 @@ static struct clk mspro_ick = {
 
 static struct clk mspro_fck = {
 	.name		= "mspro_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2228,6 +2310,7 @@ static struct clk mspro_fck = {
 
 static struct clk mmc_ick = {
 	.name		= "mmc_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2238,6 +2321,7 @@ static struct clk mmc_ick = {
 
 static struct clk mmc_fck = {
 	.name		= "mmc_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2248,6 +2332,7 @@ static struct clk mmc_fck = {
 
 static struct clk fac_ick = {
 	.name		= "fac_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2258,6 +2343,7 @@ static struct clk fac_ick = {
 
 static struct clk fac_fck = {
 	.name		= "fac_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2268,6 +2354,7 @@ static struct clk fac_fck = {
 
 static struct clk eac_ick = {
 	.name		= "eac_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2278,6 +2365,7 @@ static struct clk eac_ick = {
 
 static struct clk eac_fck = {
 	.name		= "eac_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2288,6 +2376,7 @@ static struct clk eac_fck = {
 
 static struct clk hdq_ick = {
 	.name		= "hdq_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2298,6 +2387,7 @@ static struct clk hdq_ick = {
 
 static struct clk hdq_fck = {
 	.name		= "hdq_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2308,6 +2398,7 @@ static struct clk hdq_fck = {
 
 static struct clk i2c2_ick = {
 	.name		= "i2c_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
@@ -2319,6 +2410,7 @@ static struct clk i2c2_ick = {
 
 static struct clk i2c2_fck = {
 	.name		= "i2c_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
@@ -2330,6 +2422,7 @@ static struct clk i2c2_fck = {
 
 static struct clk i2chs2_fck = {
 	.name		= "i2c_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -2341,6 +2434,7 @@ static struct clk i2chs2_fck = {
 
 static struct clk i2c1_ick = {
 	.name		= "i2c_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
@@ -2352,6 +2446,7 @@ static struct clk i2c1_ick = {
 
 static struct clk i2c1_fck = {
 	.name		= "i2c_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
@@ -2363,6 +2458,7 @@ static struct clk i2c1_fck = {
 
 static struct clk i2chs1_fck = {
 	.name		= "i2c_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -2402,6 +2498,7 @@ static struct clk sdma_ick = {
 
 static struct clk vlynq_ick = {
 	.name		= "vlynq_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l3_clkdm",
@@ -2437,6 +2534,7 @@ static const struct clksel vlynq_fck_clksel[] = {
 
 static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP,
 	.clkdm_name	= "core_l3_clkdm",
@@ -2453,6 +2551,7 @@ static struct clk vlynq_fck = {
 
 static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2463,6 +2562,7 @@ static struct clk sdrc_ick = {
 
 static struct clk des_ick = {
 	.name		= "des_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2473,6 +2573,7 @@ static struct clk des_ick = {
 
 static struct clk sha_ick = {
 	.name		= "sha_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2483,6 +2584,7 @@ static struct clk sha_ick = {
 
 static struct clk rng_ick = {
 	.name		= "rng_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2493,6 +2595,7 @@ static struct clk rng_ick = {
 
 static struct clk aes_ick = {
 	.name		= "aes_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2503,6 +2606,7 @@ static struct clk aes_ick = {
 
 static struct clk pka_ick = {
 	.name		= "pka_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2513,6 +2617,7 @@ static struct clk pka_ick = {
 
 static struct clk usb_fck = {
 	.name		= "usb_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l3_clkdm",
@@ -2523,6 +2628,7 @@ static struct clk usb_fck = {
 
 static struct clk usbhs_ick = {
 	.name		= "usbhs_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
@@ -2533,6 +2639,7 @@ static struct clk usbhs_ick = {
 
 static struct clk mmchs1_ick = {
 	.name		= "mmchs_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2543,6 +2650,7 @@ static struct clk mmchs1_ick = {
 
 static struct clk mmchs1_fck = {
 	.name		= "mmchs_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
@@ -2553,6 +2661,7 @@ static struct clk mmchs1_fck = {
 
 static struct clk mmchs2_ick = {
 	.name		= "mmchs_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -2564,6 +2673,7 @@ static struct clk mmchs2_ick = {
 
 static struct clk mmchs2_fck = {
 	.name		= "mmchs_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -2574,6 +2684,7 @@ static struct clk mmchs2_fck = {
 
 static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2584,6 +2695,7 @@ static struct clk gpio5_ick = {
 
 static struct clk gpio5_fck = {
 	.name		= "gpio5_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2594,6 +2706,7 @@ static struct clk gpio5_fck = {
 
 static struct clk mdm_intc_ick = {
 	.name		= "mdm_intc_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2604,6 +2717,7 @@ static struct clk mdm_intc_ick = {
 
 static struct clk mmchsdb1_fck = {
 	.name		= "mmchsdb_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2614,6 +2728,7 @@ static struct clk mmchsdb1_fck = {
 
 static struct clk mmchsdb2_fck = {
 	.name		= "mmchsdb_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 203e2bd..0d6a11c 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -216,6 +216,7 @@ static struct clk mcbsp_clks = {
 
 static struct clk sys_clkout1 = {
 	.name		= "sys_clkout1",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &osc_sys_ck,
 	.enable_reg	= OMAP3430_PRM_CLKOUT_CTRL,
 	.enable_bit	= OMAP3430_CLKOUT_EN_SHIFT,
@@ -535,6 +536,7 @@ static struct clk dpll3_m3_ck = {
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll3_m3x2_ck = {
 	.name		= "dpll3_m3x2_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll3_m3_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_CORE_SHIFT,
@@ -626,6 +628,7 @@ static struct clk dpll4_m2_ck = {
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m2x2_ck = {
 	.name		= "dpll4_m2x2_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m2_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_96M_SHIFT,
@@ -693,6 +696,7 @@ static struct clk dpll4_m3_ck = {
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m3x2_ck = {
 	.name		= "dpll4_m3x2_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m3_ck,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
@@ -798,6 +802,7 @@ static struct clk dpll4_m4_ck = {
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m4x2_ck = {
 	.name		= "dpll4_m4x2_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m4_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
@@ -821,6 +826,7 @@ static struct clk dpll4_m5_ck = {
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m5x2_ck = {
 	.name		= "dpll4_m5x2_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m5_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
@@ -844,6 +850,7 @@ static struct clk dpll4_m6_ck = {
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m6x2_ck = {
 	.name		= "dpll4_m6x2_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m6_ck,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
@@ -960,6 +967,7 @@ static const struct clksel clkout2_src_clksel[] = {
 
 static struct clk clkout2_src_ck = {
 	.name		= "clkout2_src_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP3430_CM_CLKOUT_CTRL,
 	.enable_bit	= OMAP3430_CLKOUT2_EN_SHIFT,
@@ -1118,6 +1126,7 @@ static const struct clksel iva2_clksel[] = {
 
 static struct clk iva2_ck = {
 	.name		= "iva2_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll2_m2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, CM_FCLKEN),
@@ -1194,6 +1203,7 @@ static const struct clksel gfx_l3_clksel[] = {
 /* Virtual parent clock for gfx_l3_ick and gfx_l3_fck */
 static struct clk gfx_l3_ck = {
 	.name		= "gfx_l3_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l3_ick,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
@@ -1226,6 +1236,7 @@ static struct clk gfx_l3_ick = {
 
 static struct clk gfx_cg1_ck = {
 	.name		= "gfx_cg1_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
@@ -1237,6 +1248,7 @@ static struct clk gfx_cg1_ck = {
 
 static struct clk gfx_cg2_ck = {
 	.name		= "gfx_cg2_ck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
@@ -1268,6 +1280,7 @@ static const struct clksel sgx_clksel[] = {
 
 static struct clk sgx_fck = {
 	.name		= "sgx_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_SGX_SHIFT,
@@ -1281,6 +1294,7 @@ static struct clk sgx_fck = {
 
 static struct clk sgx_ick = {
 	.name		= "sgx_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l3_ick,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
@@ -1294,6 +1308,7 @@ static struct clk sgx_ick = {
 
 static struct clk d2d_26m_fck = {
 	.name		= "d2d_26m_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1311,6 +1326,7 @@ static const struct clksel omap343x_gpt_clksel[] = {
 
 static struct clk gpt10_fck = {
 	.name		= "gpt10_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1325,6 +1341,7 @@ static struct clk gpt10_fck = {
 
 static struct clk gpt11_fck = {
 	.name		= "gpt11_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1339,6 +1356,7 @@ static struct clk gpt11_fck = {
 
 static struct clk cpefuse_fck = {
 	.name		= "cpefuse_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_CPEFUSE_SHIFT,
@@ -1348,6 +1366,7 @@ static struct clk cpefuse_fck = {
 
 static struct clk ts_fck = {
 	.name		= "ts_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &omap_32k_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_TS_SHIFT,
@@ -1357,6 +1376,7 @@ static struct clk ts_fck = {
 
 static struct clk usbtll_fck = {
 	.name		= "usbtll_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &omap_120m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
@@ -1377,6 +1397,7 @@ static struct clk core_96m_fck = {
 
 static struct clk mmchs3_fck = {
 	.name		= "mmchs_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1388,6 +1409,7 @@ static struct clk mmchs3_fck = {
 
 static struct clk mmchs2_fck = {
 	.name		= "mmchs_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1399,6 +1421,7 @@ static struct clk mmchs2_fck = {
 
 static struct clk mspro_fck = {
 	.name		= "mspro_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
@@ -1409,6 +1432,7 @@ static struct clk mspro_fck = {
 
 static struct clk mmchs1_fck = {
 	.name		= "mmchs_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
@@ -1419,6 +1443,7 @@ static struct clk mmchs1_fck = {
 
 static struct clk i2c3_fck = {
 	.name		= "i2c_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1430,6 +1455,7 @@ static struct clk i2c3_fck = {
 
 static struct clk i2c2_fck = {
 	.name		= "i2c_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1441,6 +1467,7 @@ static struct clk i2c2_fck = {
 
 static struct clk i2c1_fck = {
 	.name		= "i2c_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1472,6 +1499,7 @@ static const struct clksel mcbsp_15_clksel[] = {
 
 static struct clk mcbsp5_fck = {
 	.name		= "mcbsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 5,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1486,6 +1514,7 @@ static struct clk mcbsp5_fck = {
 
 static struct clk mcbsp1_fck = {
 	.name		= "mcbsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1511,6 +1540,7 @@ static struct clk core_48m_fck = {
 
 static struct clk mcspi4_fck = {
 	.name		= "mcspi_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1521,6 +1551,7 @@ static struct clk mcspi4_fck = {
 
 static struct clk mcspi3_fck = {
 	.name		= "mcspi_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1531,6 +1562,7 @@ static struct clk mcspi3_fck = {
 
 static struct clk mcspi2_fck = {
 	.name		= "mcspi_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1541,6 +1573,7 @@ static struct clk mcspi2_fck = {
 
 static struct clk mcspi1_fck = {
 	.name		= "mcspi_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1551,6 +1584,7 @@ static struct clk mcspi1_fck = {
 
 static struct clk uart2_fck = {
 	.name		= "uart2_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
@@ -1560,6 +1594,7 @@ static struct clk uart2_fck = {
 
 static struct clk uart1_fck = {
 	.name		= "uart1_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
@@ -1569,6 +1604,7 @@ static struct clk uart1_fck = {
 
 static struct clk fshostusb_fck = {
 	.name		= "fshostusb_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
@@ -1589,6 +1625,7 @@ static struct clk core_12m_fck = {
 
 static struct clk hdq_fck = {
 	.name		= "hdq_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_12m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
@@ -1615,6 +1652,7 @@ static const struct clksel ssi_ssr_clksel[] = {
 
 static struct clk ssi_ssr_fck = {
 	.name		= "ssi_ssr_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
@@ -1655,6 +1693,7 @@ static struct clk core_l3_ick = {
 
 static struct clk hsotgusb_ick = {
 	.name		= "hsotgusb_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_HSOTGUSB_SHIFT,
@@ -1665,6 +1704,7 @@ static struct clk hsotgusb_ick = {
 
 static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SDRC_SHIFT,
@@ -1694,6 +1734,7 @@ static struct clk security_l3_ick = {
 
 static struct clk pka_ick = {
 	.name		= "pka_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &security_l3_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_PKA_SHIFT,
@@ -1715,6 +1756,7 @@ static struct clk core_l4_ick = {
 
 static struct clk usbtll_ick = {
 	.name		= "usbtll_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
@@ -1725,6 +1767,7 @@ static struct clk usbtll_ick = {
 
 static struct clk mmchs3_ick = {
 	.name		= "mmchs_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1737,6 +1780,7 @@ static struct clk mmchs3_ick = {
 /* Intersystem Communication Registers - chassis mode only */
 static struct clk icr_ick = {
 	.name		= "icr_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_ICR_SHIFT,
@@ -1747,6 +1791,7 @@ static struct clk icr_ick = {
 
 static struct clk aes2_ick = {
 	.name		= "aes2_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_AES2_SHIFT,
@@ -1757,6 +1802,7 @@ static struct clk aes2_ick = {
 
 static struct clk sha12_ick = {
 	.name		= "sha12_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SHA12_SHIFT,
@@ -1767,6 +1813,7 @@ static struct clk sha12_ick = {
 
 static struct clk des2_ick = {
 	.name		= "des2_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_DES2_SHIFT,
@@ -1777,6 +1824,7 @@ static struct clk des2_ick = {
 
 static struct clk mmchs2_ick = {
 	.name		= "mmchs_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1788,6 +1836,7 @@ static struct clk mmchs2_ick = {
 
 static struct clk mmchs1_ick = {
 	.name		= "mmchs_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
@@ -1798,6 +1847,7 @@ static struct clk mmchs1_ick = {
 
 static struct clk mspro_ick = {
 	.name		= "mspro_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
@@ -1808,6 +1858,7 @@ static struct clk mspro_ick = {
 
 static struct clk hdq_ick = {
 	.name		= "hdq_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
@@ -1818,6 +1869,7 @@ static struct clk hdq_ick = {
 
 static struct clk mcspi4_ick = {
 	.name		= "mcspi_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1829,6 +1881,7 @@ static struct clk mcspi4_ick = {
 
 static struct clk mcspi3_ick = {
 	.name		= "mcspi_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1840,6 +1893,7 @@ static struct clk mcspi3_ick = {
 
 static struct clk mcspi2_ick = {
 	.name		= "mcspi_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1851,6 +1905,7 @@ static struct clk mcspi2_ick = {
 
 static struct clk mcspi1_ick = {
 	.name		= "mcspi_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1862,6 +1917,7 @@ static struct clk mcspi1_ick = {
 
 static struct clk i2c3_ick = {
 	.name		= "i2c_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1873,6 +1929,7 @@ static struct clk i2c3_ick = {
 
 static struct clk i2c2_ick = {
 	.name		= "i2c_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1884,6 +1941,7 @@ static struct clk i2c2_ick = {
 
 static struct clk i2c1_ick = {
 	.name		= "i2c_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1895,6 +1953,7 @@ static struct clk i2c1_ick = {
 
 static struct clk uart2_ick = {
 	.name		= "uart2_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
@@ -1905,6 +1964,7 @@ static struct clk uart2_ick = {
 
 static struct clk uart1_ick = {
 	.name		= "uart1_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
@@ -1915,6 +1975,7 @@ static struct clk uart1_ick = {
 
 static struct clk gpt11_ick = {
 	.name		= "gpt11_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_GPT11_SHIFT,
@@ -1925,6 +1986,7 @@ static struct clk gpt11_ick = {
 
 static struct clk gpt10_ick = {
 	.name		= "gpt10_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_GPT10_SHIFT,
@@ -1935,6 +1997,7 @@ static struct clk gpt10_ick = {
 
 static struct clk mcbsp5_ick = {
 	.name		= "mcbsp_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 5,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1946,6 +2009,7 @@ static struct clk mcbsp5_ick = {
 
 static struct clk mcbsp1_ick = {
 	.name		= "mcbsp_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1957,6 +2021,7 @@ static struct clk mcbsp1_ick = {
 
 static struct clk fac_ick = {
 	.name		= "fac_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_FAC_SHIFT,
@@ -1967,6 +2032,7 @@ static struct clk fac_ick = {
 
 static struct clk mailboxes_ick = {
 	.name		= "mailboxes_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MAILBOXES_SHIFT,
@@ -1977,6 +2043,7 @@ static struct clk mailboxes_ick = {
 
 static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_OMAPCTRL_SHIFT,
@@ -1997,6 +2064,7 @@ static struct clk ssi_l4_ick = {
 
 static struct clk ssi_ick = {
 	.name		= "ssi_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &ssi_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
@@ -2015,6 +2083,7 @@ static const struct clksel usb_l4_clksel[] = {
 
 static struct clk usb_l4_ick = {
 	.name		= "usb_l4_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -2040,6 +2109,7 @@ static struct clk security_l4_ick2 = {
 
 static struct clk aes1_ick = {
 	.name		= "aes1_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &security_l4_ick2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_AES1_SHIFT,
@@ -2049,6 +2119,7 @@ static struct clk aes1_ick = {
 
 static struct clk rng_ick = {
 	.name		= "rng_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &security_l4_ick2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_RNG_SHIFT,
@@ -2058,6 +2129,7 @@ static struct clk rng_ick = {
 
 static struct clk sha11_ick = {
 	.name		= "sha11_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &security_l4_ick2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_SHA11_SHIFT,
@@ -2067,6 +2139,7 @@ static struct clk sha11_ick = {
 
 static struct clk des1_ick = {
 	.name		= "des1_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &security_l4_ick2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_DES1_SHIFT,
@@ -2083,6 +2156,7 @@ static const struct clksel dss1_alwon_fck_clksel[] = {
 
 static struct clk dss1_alwon_fck = {
 	.name		= "dss1_alwon_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m4x2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
@@ -2097,6 +2171,7 @@ static struct clk dss1_alwon_fck = {
 
 static struct clk dss_tv_fck = {
 	.name		= "dss_tv_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &omap_54m_fck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
@@ -2108,6 +2183,7 @@ static struct clk dss_tv_fck = {
 
 static struct clk dss_96m_fck = {
 	.name		= "dss_96m_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &omap_96m_fck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
@@ -2119,6 +2195,7 @@ static struct clk dss_96m_fck = {
 
 static struct clk dss2_alwon_fck = {
 	.name		= "dss2_alwon_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
@@ -2131,6 +2208,7 @@ static struct clk dss2_alwon_fck = {
 static struct clk dss_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "dss_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
@@ -2150,6 +2228,7 @@ static const struct clksel cam_mclk_clksel[] = {
 
 static struct clk cam_mclk = {
 	.name		= "cam_mclk",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m5x2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
@@ -2165,6 +2244,7 @@ static struct clk cam_mclk = {
 static struct clk cam_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "cam_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
@@ -2178,6 +2258,7 @@ static struct clk cam_ick = {
 
 static struct clk usbhost_120m_fck = {
 	.name		= "usbhost_120m_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &omap_120m_fck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
@@ -2189,6 +2270,7 @@ static struct clk usbhost_120m_fck = {
 
 static struct clk usbhost_48m_fck = {
 	.name		= "usbhost_48m_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &omap_48m_fck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
@@ -2201,6 +2283,7 @@ static struct clk usbhost_48m_fck = {
 static struct clk usbhost_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "usbhost_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
@@ -2212,6 +2295,7 @@ static struct clk usbhost_ick = {
 
 static struct clk usbhost_sar_fck = {
 	.name		= "usbhost_sar_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &osc_sys_ck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),
@@ -2249,6 +2333,7 @@ static const struct clksel usim_clksel[] = {
 /* 3430ES2 only */
 static struct clk usim_fck = {
 	.name		= "usim_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USIMOCP_SHIFT,
@@ -2262,6 +2347,7 @@ static struct clk usim_fck = {
 /* XXX should gpt1's clksel have wkup_32k_fck as the 32k opt? */
 static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
@@ -2285,6 +2371,7 @@ static struct clk wkup_32k_fck = {
 
 static struct clk gpio1_dbck = {
 	.name		= "gpio1_dbck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_32k_fck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
@@ -2295,6 +2382,7 @@ static struct clk gpio1_dbck = {
 
 static struct clk wdt2_fck = {
 	.name		= "wdt2_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_32k_fck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
@@ -2316,6 +2404,7 @@ static struct clk wkup_l4_ick = {
 /* Never specifically named in the TRM, so we have to infer a likely name */
 static struct clk usim_ick = {
 	.name		= "usim_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USIMOCP_SHIFT,
@@ -2326,6 +2415,7 @@ static struct clk usim_ick = {
 
 static struct clk wdt2_ick = {
 	.name		= "wdt2_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
@@ -2336,6 +2426,7 @@ static struct clk wdt2_ick = {
 
 static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT1_SHIFT,
@@ -2346,6 +2437,7 @@ static struct clk wdt1_ick = {
 
 static struct clk gpio1_ick = {
 	.name		= "gpio1_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
@@ -2356,6 +2448,7 @@ static struct clk gpio1_ick = {
 
 static struct clk omap_32ksync_ick = {
 	.name		= "omap_32ksync_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_32KSYNC_SHIFT,
@@ -2367,6 +2460,7 @@ static struct clk omap_32ksync_ick = {
 /* XXX This clock no longer exists in 3430 TRM rev F */
 static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT12_SHIFT,
@@ -2377,6 +2471,7 @@ static struct clk gpt12_ick = {
 
 static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
@@ -2411,6 +2506,7 @@ static struct clk per_48m_fck = {
 
 static struct clk uart3_fck = {
 	.name		= "uart3_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
@@ -2421,6 +2517,7 @@ static struct clk uart3_fck = {
 
 static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
@@ -2434,6 +2531,7 @@ static struct clk gpt2_fck = {
 
 static struct clk gpt3_fck = {
 	.name		= "gpt3_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
@@ -2447,6 +2545,7 @@ static struct clk gpt3_fck = {
 
 static struct clk gpt4_fck = {
 	.name		= "gpt4_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
@@ -2460,6 +2559,7 @@ static struct clk gpt4_fck = {
 
 static struct clk gpt5_fck = {
 	.name		= "gpt5_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
@@ -2473,6 +2573,7 @@ static struct clk gpt5_fck = {
 
 static struct clk gpt6_fck = {
 	.name		= "gpt6_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
@@ -2486,6 +2587,7 @@ static struct clk gpt6_fck = {
 
 static struct clk gpt7_fck = {
 	.name		= "gpt7_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
@@ -2499,6 +2601,7 @@ static struct clk gpt7_fck = {
 
 static struct clk gpt8_fck = {
 	.name		= "gpt8_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
@@ -2512,6 +2615,7 @@ static struct clk gpt8_fck = {
 
 static struct clk gpt9_fck = {
 	.name		= "gpt9_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
@@ -2534,6 +2638,7 @@ static struct clk per_32k_alwon_fck = {
 
 static struct clk gpio6_dbck = {
 	.name		= "gpio6_dbck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
@@ -2544,6 +2649,7 @@ static struct clk gpio6_dbck = {
 
 static struct clk gpio5_dbck = {
 	.name		= "gpio5_dbck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
@@ -2554,6 +2660,7 @@ static struct clk gpio5_dbck = {
 
 static struct clk gpio4_dbck = {
 	.name		= "gpio4_dbck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
@@ -2564,6 +2671,7 @@ static struct clk gpio4_dbck = {
 
 static struct clk gpio3_dbck = {
 	.name		= "gpio3_dbck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
@@ -2574,6 +2682,7 @@ static struct clk gpio3_dbck = {
 
 static struct clk gpio2_dbck = {
 	.name		= "gpio2_dbck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
@@ -2584,6 +2693,7 @@ static struct clk gpio2_dbck = {
 
 static struct clk wdt3_fck = {
 	.name		= "wdt3_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
@@ -2603,6 +2713,7 @@ static struct clk per_l4_ick = {
 
 static struct clk gpio6_ick = {
 	.name		= "gpio6_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
@@ -2613,6 +2724,7 @@ static struct clk gpio6_ick = {
 
 static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
@@ -2623,6 +2735,7 @@ static struct clk gpio5_ick = {
 
 static struct clk gpio4_ick = {
 	.name		= "gpio4_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
@@ -2633,6 +2746,7 @@ static struct clk gpio4_ick = {
 
 static struct clk gpio3_ick = {
 	.name		= "gpio3_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
@@ -2643,6 +2757,7 @@ static struct clk gpio3_ick = {
 
 static struct clk gpio2_ick = {
 	.name		= "gpio2_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
@@ -2653,6 +2768,7 @@ static struct clk gpio2_ick = {
 
 static struct clk wdt3_ick = {
 	.name		= "wdt3_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
@@ -2663,6 +2779,7 @@ static struct clk wdt3_ick = {
 
 static struct clk uart3_ick = {
 	.name		= "uart3_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
@@ -2673,6 +2790,7 @@ static struct clk uart3_ick = {
 
 static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
@@ -2683,6 +2801,7 @@ static struct clk gpt9_ick = {
 
 static struct clk gpt8_ick = {
 	.name		= "gpt8_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
@@ -2693,6 +2812,7 @@ static struct clk gpt8_ick = {
 
 static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
@@ -2703,6 +2823,7 @@ static struct clk gpt7_ick = {
 
 static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
@@ -2713,6 +2834,7 @@ static struct clk gpt6_ick = {
 
 static struct clk gpt5_ick = {
 	.name		= "gpt5_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
@@ -2723,6 +2845,7 @@ static struct clk gpt5_ick = {
 
 static struct clk gpt4_ick = {
 	.name		= "gpt4_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
@@ -2733,6 +2856,7 @@ static struct clk gpt4_ick = {
 
 static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
@@ -2743,6 +2867,7 @@ static struct clk gpt3_ick = {
 
 static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
@@ -2753,6 +2878,7 @@ static struct clk gpt2_ick = {
 
 static struct clk mcbsp2_ick = {
 	.name		= "mcbsp_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
@@ -2764,6 +2890,7 @@ static struct clk mcbsp2_ick = {
 
 static struct clk mcbsp3_ick = {
 	.name		= "mcbsp_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
@@ -2775,6 +2902,7 @@ static struct clk mcbsp3_ick = {
 
 static struct clk mcbsp4_ick = {
 	.name		= "mcbsp_ick",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
@@ -2792,6 +2920,7 @@ static const struct clksel mcbsp_234_clksel[] = {
 
 static struct clk mcbsp2_fck = {
 	.name		= "mcbsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -2806,6 +2935,7 @@ static struct clk mcbsp2_fck = {
 
 static struct clk mcbsp3_fck = {
 	.name		= "mcbsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -2820,6 +2950,7 @@ static struct clk mcbsp3_fck = {
 
 static struct clk mcbsp4_fck = {
 	.name		= "mcbsp_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -2988,6 +3119,7 @@ static struct clk traceclk_fck = {
 /* SmartReflex fclk (VDD1) */
 static struct clk sr1_fck = {
 	.name		= "sr1_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
@@ -2998,6 +3130,7 @@ static struct clk sr1_fck = {
 /* SmartReflex fclk (VDD2) */
 static struct clk sr2_fck = {
 	.name		= "sr2_fck",
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
-- 
1.6.1.2

