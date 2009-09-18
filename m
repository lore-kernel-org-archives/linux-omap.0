From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] OMAP3: PM: Fix compile time warning and errors
Date: Fri, 18 Sep 2009 17:18:52 +0530
Message-ID: <1253274532-29002-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49754 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbZIRLsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 07:48:51 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8IBmr3G017774
	for <linux-omap@vger.kernel.org>; Fri, 18 Sep 2009 06:48:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Made a mistake of enabling PM_DEBUG without DEBUG_FS. This leads to
compile time warnings and errors.

arch/arm/mach-omap2/pm-debug.c:56: warning: 'pm_dbg_init'
 declared 'static' but never defined

arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
arch/arm/mach-omap2/pm34xx.c:442: undefined reference to
 'pm_dbg_regset_save'
arch/arm/mach-omap2/built-in.o: In function `configure_vc':
arch/arm/mach-omap2/pm34xx.c:1221: undefined reference to
 'pm_dbg_regset_init'

Another alternate is to link these Kconfig options; but didn't seem
intuitive.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    2 ++
 arch/arm/mach-omap2/pm34xx.c   |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 1b4c160..175d461 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -53,7 +53,9 @@ int omap2_pm_debug;
 	regs[reg_count].name = #reg; \
 	regs[reg_count++].val = __raw_readl(OMAP2_IO_ADDRESS(0x480fe000 + (off)))
 
+#ifdef CONFIG_DEBUG_FS
 static int __init pm_dbg_init(void);
+#endif
 
 void omap2_pm_dump(int mode, int resume, unsigned int us)
 {
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7a1eb95..e3da0ab 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -438,8 +438,10 @@ void omap_sram_idle(void)
 	    core_next_state == PWRDM_POWER_OFF)
 		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
 
+#ifdef CONFIG_DEBUG_FS
 	if (regset_save_on_suspend)
 		pm_dbg_regset_save(1);
+#endif
 
 	/*
 	 * omap3_arm_context is the location where ARM registers
@@ -1218,7 +1220,9 @@ static void __init configure_vc(void)
 	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
 			OMAP3_PRM_VOLTSETUP2_OFFSET);
 
+#ifdef CONFIG_DEBUG_FS
 	pm_dbg_regset_init(1);
+#endif
 }
 
 static int __init omap3_pm_early_init(void)
-- 
1.6.2.2

