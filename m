From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/6] 24xx PM: convert pm24xx.c code to use pwrdm/clkdm
	interfaces
Date: Tue, 20 May 2008 18:41:52 -0600
Message-ID: <20080521004135.6131.40281.stgit@localhost.localdomain>
References: <20080521003910.6131.63409.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45903 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933526AbYEUAqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 20:46:04 -0400
In-Reply-To: <20080521003910.6131.63409.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Convert the existing OMAP24xx pm24xx.c code to use the recent
powerdomain/clockdomain interface code.  This mostly consists of removing
direct register reads and writes and replacing it with code that can be
more generic.

Also update some of the comments to better reflect what is actually
happening on the chip.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/pm24xx.c |  106 +++++++++++++++++++++++++++++-------------
 1 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 787a95e..5d060de 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -52,6 +52,9 @@
 #include "sdrc.h"
 #include "pm.h"
 
+#include <asm/arch/powerdomain.h>
+#include <asm/arch/clockdomain.h>
+
 /* These addrs are in assembly language code to be patched at runtime */
 extern void *omap2_ocs_sdrc_power;
 extern void *omap2_ocs_sdrc_dlla_ctrl;
@@ -60,6 +63,12 @@ static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(void __iomem *dllctrl);
 static void (*saved_idle)(void);
 
+static struct powerdomain *mpu_pwrdm;
+static struct powerdomain *core_pwrdm;
+
+static struct clockdomain *dsp_clkdm;
+static struct clockdomain *gfx_clkdm;
+
 static struct clk *osc_ck, *emul_ck;
 
 static int omap2_fclks_active(void)
@@ -91,9 +100,12 @@ static void omap2_enter_full_retention(void)
 	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
 	prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
 
-	/* Try to enter retention */
-	prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) | OMAP_LOGICRETSTATE,
-			  MPU_MOD, PM_PWSTCTRL);
+	/*
+	 * Set MPU powerdomain's next power state to RETENTION;
+	 * preserve logic state during retention
+	 */
+	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
+	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
 
 	/* Workaround to kill USB */
 	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
@@ -326,9 +338,16 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
+static int _pm_clkdm_enable_hwsup(struct clockdomain *clkdm)
+{
+	omap2_clkdm_allow_idle(clkdm);
+	return 0;
+}
+
 static void __init prcm_setup_regs(void)
 {
-	u32 l;
+	int i, num_mem_banks;
+	struct powerdomain *pwrdm;
 
 	/* Enable autoidle */
 	__raw_writel(OMAP24XX_AUTOIDLE, OMAP24XX_PRCM_SYSCONFIG);
@@ -341,36 +360,36 @@ static void __init prcm_setup_regs(void)
 	if (cpu_is_omap2430())
 		prm_write_mod_reg(0, OMAP2430_MDM_MOD, PM_WKDEP);
 
-	l = prm_read_mod_reg(CORE_MOD, PM_PWSTCTRL);
-	/* Enable retention for all memory blocks */
-	l |= OMAP24XX_MEM3RETSTATE | OMAP24XX_MEM2RETSTATE |
-		OMAP24XX_MEM1RETSTATE;
-
-	/* Set power state to RETENTION */
-	l &= ~OMAP_POWERSTATE_MASK;
-	l |= 0x01 << OMAP_POWERSTATE_SHIFT;
-	prm_write_mod_reg(l, CORE_MOD, PM_PWSTCTRL);
-
-	prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
-			  OMAP_LOGICRETSTATE,
-			  MPU_MOD, PM_PWSTCTRL);
-
-	/* Power down DSP and GFX */
-	prm_write_mod_reg(OMAP24XX_FORCESTATE | (0x3 << OMAP_POWERSTATE_SHIFT),
-			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
-	prm_write_mod_reg(OMAP24XX_FORCESTATE | (0x3 << OMAP_POWERSTATE_SHIFT),
-			  GFX_MOD, PM_PWSTCTRL);
-
-	/* Enable clock auto control for all domains */
-	cm_write_mod_reg(OMAP24XX_AUTOSTATE_MPU_MASK, MPU_MOD, CM_CLKSTCTRL);
-	cm_write_mod_reg(OMAP24XX_AUTOSTATE_DSS_MASK |
-			 OMAP24XX_AUTOSTATE_L4_MASK |
-			 OMAP24XX_AUTOSTATE_L3_MASK,
-			 CORE_MOD, CM_CLKSTCTRL);
-	cm_write_mod_reg(OMAP24XX_AUTOSTATE_GFX_MASK, GFX_MOD, CM_CLKSTCTRL);
-	cm_write_mod_reg(OMAP2420_AUTOSTATE_IVA_MASK |
-			 OMAP24XX_AUTOSTATE_DSP_MASK,
-			 OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+	/*
+	 * Set CORE powerdomain memory banks to retain their contents
+	 * during RETENTION
+	 */
+	num_mem_banks = pwrdm_get_mem_bank_count(core_pwrdm);
+	for (i = 0; i < num_mem_banks; i++)
+		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_POWER_RET);
+
+	/* Set CORE powerdomain's next power state to RETENTION */
+	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
+
+	/*
+	 * Set MPU powerdomain's next power state to RETENTION;
+	 * preserve logic state during retention
+	 */
+	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
+	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
+
+	/* Force-power down DSP, GFX powerdomains */
+
+	pwrdm = clkdm_get_pwrdm(dsp_clkdm);
+	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
+	omap2_clkdm_sleep(dsp_clkdm);
+
+	pwrdm = clkdm_get_pwrdm(gfx_clkdm);
+	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
+	omap2_clkdm_sleep(gfx_clkdm);
+
+	/* Enable clockdomain hardware-supervised control for all clkdms */
+	clkdm_for_each(_pm_clkdm_enable_hwsup);
 
 	/* Enable clock autoidle for all domains */
 	cm_write_mod_reg(OMAP24XX_AUTO_CAM |
@@ -461,6 +480,25 @@ int __init omap2_pm_init(void)
 	l = __raw_readl(OMAP24XX_PRCM_REVISION);
 	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 
+	/* Look up important powerdomains, clockdomains */
+
+	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
+	if (!mpu_pwrdm)
+		pr_err("PM: mpu_pwrdm not found\n");
+
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
+	if (!core_pwrdm)
+		pr_err("PM: core_pwrdm not found\n");
+
+	dsp_clkdm = clkdm_lookup("dsp_clkdm");
+	if (!dsp_clkdm)
+		pr_err("PM: mpu_clkdm not found\n");
+
+	gfx_clkdm = clkdm_lookup("gfx_clkdm");
+	if (!gfx_clkdm)
+		pr_err("PM: gfx_clkdm not found\n");
+
+
 	osc_ck = clk_get(NULL, "osc_ck");
 	if (IS_ERR(osc_ck)) {
 		printk(KERN_ERR "could not get osc_ck\n");


