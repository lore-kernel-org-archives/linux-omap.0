From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 11/13] OMAP3630: PM: Errata i608: disable RTA
Date: Thu, 18 Nov 2010 19:54:56 -0600
Message-ID: <1290131698-6194-12-git-send-email-nm@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38903 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757057Ab0KSBzC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 20:55:02 -0500
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Errata id: i608
RTA (Retention Till Access) feature is not supported and leads to device
stability issues when enabled. This impacts modules with embedded memories
on OMAP3630

Workaround is to disable RTA on boot and coming out of core off.
For disabling rta coming out of off mode, we do this by overriding the
restore pointer for 3630 to allow us restore handler as the first point of
entry before caches are touched and is common for GP and HS devices.
to disable earlier than this could be possible by modifying the ppa for HS
devices, but not for GP devices.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/control.c   |    5 ++++-
 arch/arm/mach-omap2/control.h   |    5 +++++
 arch/arm/mach-omap2/pm34xx.c    |   12 ++++++++++++
 arch/arm/mach-omap2/sleep34xx.S |   25 +++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1fa3294..728f268 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -241,7 +241,10 @@ void omap3_save_scratchpad_contents(void)
 
 	/* Populate the Scratchpad contents */
 	scratchpad_contents.boot_config_ptr = 0x0;
-	if (omap_rev() != OMAP3430_REV_ES3_0 &&
+	if (cpu_is_omap3630())
+		scratchpad_contents.public_restore_ptr =
+			virt_to_phys(get_omap3630_restore_pointer());
+	else if (omap_rev() != OMAP3430_REV_ES3_0 &&
 					omap_rev() != OMAP3430_REV_ES3_1)
 		scratchpad_contents.public_restore_ptr =
 			virt_to_phys(get_restore_pointer());
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b6c6b7c..d7911c5 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -204,6 +204,10 @@
 #define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WKUP + 0x014)
 #define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WKUP + 0x018)
 
+/* 36xx-only RTA - Retention till Accesss control registers and bits */
+#define OMAP36XX_CONTROL_MEM_RTA_CTRL	0x40C
+#define OMAP36XX_RTA_DISABLE		0x0
+
 /* 34xx D2D idle-related pins, handled by PM core */
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
 #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
@@ -347,6 +351,7 @@ extern void omap3_save_scratchpad_contents(void);
 extern void omap3_clear_scratchpad_contents(void);
 extern u32 *get_restore_pointer(void);
 extern u32 *get_es3_restore_pointer(void);
+extern u32 *get_omap3630_restore_pointer(void);
 extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 218d0b0..1ced230 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -85,6 +85,7 @@ static int secure_ram_save_status;
 static int secure_ram_saved;
 
 #define PER_WAKEUP_ERRATA_i582	(1 << 0)
+#define RTA_ERRATA_i608		(1 << 1)
 static u16 pm34xx_errata;
 #define IS_PM34XX_ERRATA(id)	(pm34xx_errata & (id))
 
@@ -1049,6 +1050,8 @@ static void pm_errata_configure(void)
 		pm34xx_errata |= PER_WAKEUP_ERRATA_i582;
 		if (cpu_is_omap3630() && (omap_rev() > OMAP3630_REV_ES1_1))
 			pm34xx_errata &= ~PER_WAKEUP_ERRATA_i582;
+		if (cpu_is_omap3630())
+			pm34xx_errata |= RTA_ERRATA_i608;
 	}
 }
 
@@ -1115,6 +1118,15 @@ static int __init omap3_pm_init(void)
 	/* Allow per to wakeup the system if errata is applicable */
 	if (IS_PM34XX_ERRATA(PER_WAKEUP_ERRATA_i582) && cpu_is_omap34xx())
 		clkdm_add_wkdep(per_clkdm, wkup_clkdm);
+	/*
+	 * RTA is disabled during initialization as per errata i608
+	 * it is safer to disable rta by the bootloader, but we would like
+	 * to be doubly sure here and prevent any mishaps.
+	 */
+	if (IS_PM34XX_ERRATA(RTA_ERRATA_i608))
+		omap_ctrl_writel(OMAP36XX_RTA_DISABLE,
+			OMAP36XX_CONTROL_MEM_RTA_CTRL);
+
 
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 5a4468f..7259541 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -45,6 +45,8 @@
 #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
 #define SRAM_BASE_P		0x40200000
 #define CONTROL_STAT		0x480022F0
+#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
+					+ OMAP36XX_CONTROL_MEM_RTA_CTRL)
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
 				       * available */
 #define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
@@ -99,6 +101,14 @@ ENTRY(get_restore_pointer)
         ldmfd   sp!, {pc}     @ restore regs and return
 ENTRY(get_restore_pointer_sz)
         .word   . - get_restore_pointer
+	.text
+/* Function call to get the restore pointer for 3630 resume from OFF */
+ENTRY(get_omap3630_restore_pointer)
+        stmfd   sp!, {lr}     @ save registers on stack
+	adr	r0, restore_3630
+        ldmfd   sp!, {pc}     @ restore regs and return
+ENTRY(get_omap3630_restore_pointer_sz)
+        .word   . - get_omap3630_restore_pointer
 
 	.text
 /* Function call to get the restore pointer for for ES3 to resume from OFF */
@@ -246,6 +256,19 @@ copy_to_sram:
 	bne	copy_to_sram
 	ldr	r1, sram_base
 	blx	r1
+
+restore_3630:
+	/*b restore_es3630*/		@ Enable to debug restore code
+	ldr	r1, pm_prepwstst_core_p
+	ldr	r2, [r1]
+	and	r2, r2, #0x3
+	cmp	r2, #0x0	@ Check if previous power state of CORE is OFF
+	bne	restore
+	/* Disable rta before giving control */
+	ldr	r1, control_mem_rta
+	mov	r2, #OMAP36XX_RTA_DISABLE
+	str	r2, [r1]
+	/* Fall thru for the remaining logic */
 restore:
 	/* b restore*/  @ Enable to debug restore code
         /* Check what was the reason for mpu reset and store the reason in r9*/
@@ -650,6 +673,8 @@ cache_pred_disable_mask:
 	.word	0xFFFFE7FB
 control_stat:
 	.word	CONTROL_STAT
+control_mem_rta:
+	.word	CONTROL_MEM_RTA_CTRL
 kernel_flush:
 	.word v7_flush_dcache_all
 	/* these 2 words need to be at the end !!! */
-- 
1.6.3.3

