From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 11/18] ARM: OMAP24xx: PRM: move PRM init code within PRM driver from PM core
Date: Tue, 4 Mar 2014 18:19:11 +0200
Message-ID: <1393949958-816-12-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48484 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468AbaCDQUa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:30 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Done to isolate the PRM as its own driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c  |   34 +--------------------------------
 arch/arm/mach-omap2/prm2xxx.c |   42 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx.h |    1 +
 3 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 21fc935..97b3831 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -194,13 +194,6 @@ static void __init prcm_setup_regs(void)
 	struct powerdomain *pwrdm;
 
 	/*
-	 * Enable autoidle
-	 * XXX This should be handled by hwmod code or PRCM init code
-	 */
-	omap2_prm_write_mod_reg(OMAP24XX_AUTOIDLE_MASK, OCP_MOD,
-			  OMAP2_PRCM_SYSCONFIG_OFFSET);
-
-	/*
 	 * Set CORE powerdomain memory banks to retain their contents
 	 * during RETENTION
 	 */
@@ -228,37 +221,12 @@ static void __init prcm_setup_regs(void)
 	omap_pm_suspend = omap2_enter_full_retention;
 #endif
 
-	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
-	 * stabilisation */
-	omap2_prm_write_mod_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
-				OMAP2_PRCM_CLKSSETUP_OFFSET);
-
-	/* Configure automatic voltage transition */
-	omap2_prm_write_mod_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
-				OMAP2_PRCM_VOLTSETUP_OFFSET);
-	omap2_prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT_MASK |
-				(0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
-				OMAP24XX_MEMRETCTRL_MASK |
-				(0x1 << OMAP24XX_SETRET_LEVEL_SHIFT) |
-				(0x0 << OMAP24XX_VOLT_LEVEL_SHIFT),
-				OMAP24XX_GR_MOD, OMAP2_PRCM_VOLTCTRL_OFFSET);
-
-	/* Enable wake-up events */
-	omap2_prm_write_mod_reg(OMAP24XX_EN_GPIOS_MASK | OMAP24XX_EN_GPT1_MASK,
-				WKUP_MOD, PM_WKEN);
-
-	/* Enable SYS_CLKEN control when all domains idle */
-	omap2_prm_set_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, OMAP24XX_GR_MOD,
-				   OMAP2_PRCM_CLKSRC_CTRL_OFFSET);
+	omap2xxx_prm_init_pm();
 }
 
 int __init omap2_pm_init(void)
 {
-	u32 l;
-
 	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
-	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
-	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 
 	/* Look up important powerdomains */
 
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 12cf053..8d4db6f 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -135,6 +135,48 @@ void omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
 	omap2_prm_write_mod_reg(wkst, module, regs);
 }
 
+/**
+ * omap2xxx_prm_init_pm - initialize PM related registers for PRM
+ *
+ * Initializes PRM regiters for PM use. Called from PM init.
+ */
+void __init omap2xxx_prm_init_pm(void)
+{
+	u32 l;
+
+	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
+	pr_info("PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
+
+	/* Enable autoidle */
+	omap2_prm_write_mod_reg(OMAP24XX_AUTOIDLE_MASK, OCP_MOD,
+				OMAP2_PRCM_SYSCONFIG_OFFSET);
+
+	/*
+	 * REVISIT: Configure number of 32 kHz clock cycles for sys_clk
+	 * stabilisation
+	 */
+	omap2_prm_write_mod_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
+				OMAP2_PRCM_CLKSSETUP_OFFSET);
+
+	/* Configure automatic voltage transition */
+	omap2_prm_write_mod_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
+				OMAP2_PRCM_VOLTSETUP_OFFSET);
+	omap2_prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT_MASK |
+				(0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
+				OMAP24XX_MEMRETCTRL_MASK |
+				(0x1 << OMAP24XX_SETRET_LEVEL_SHIFT) |
+				(0x0 << OMAP24XX_VOLT_LEVEL_SHIFT),
+				OMAP24XX_GR_MOD, OMAP2_PRCM_VOLTCTRL_OFFSET);
+
+	/* Enable wake-up events */
+	omap2_prm_write_mod_reg(OMAP24XX_EN_GPIOS_MASK | OMAP24XX_EN_GPT1_MASK,
+				WKUP_MOD, PM_WKEN);
+
+	/* Enable SYS_CLKEN control when all domains idle */
+	omap2_prm_set_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, OMAP24XX_GR_MOD,
+				   OMAP2_PRCM_CLKSRC_CTRL_OFFSET);
+}
+
 int omap2xxx_clkdm_sleep(struct clockdomain *clkdm)
 {
 	omap2_prm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index e0e17b8..071bb6d 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -126,6 +126,7 @@ extern int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm);
 
 extern void omap2xxx_prm_dpll_reset(void);
 void omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
+void omap2xxx_prm_init_pm(void);
 
 extern int __init omap2xxx_prm_init(void);
 
-- 
1.7.9.5

