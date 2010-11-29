From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/5] OMAP3630: PM: Erratum i608: disable RTA
Date: Mon, 29 Nov 2010 14:19:51 -0600
Message-ID: <1291061993-4740-4-git-send-email-nm@ti.com>
References: <1291061993-4740-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34781 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501Ab0K2UT4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 15:19:56 -0500
In-Reply-To: <1291061993-4740-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwa <vishwanath.bs@ti.com>

Erratum id: i608
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
v2: fixed missing b restore for 3430 es3.1 code.
	introduced erratum handling logic here splitting it out of uart errata
	typo fixes for erratum
v1: http://marc.info/?l=linux-omap&m=129013172825240&w=2

 arch/arm/mach-omap2/control.c   |    5 ++++-
 arch/arm/mach-omap2/control.h   |    5 +++++
 arch/arm/mach-omap2/pm34xx.c    |   23 +++++++++++++++++++++++
 arch/arm/mach-omap2/sleep34xx.S |   26 ++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 1 deletions(-)

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
index 75c0cd1..bd426cc 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -54,6 +54,10 @@
 #define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
 
+#define RTA_ERRATUM_i608		(1 << 0)
+static u16 pm34xx_errata;
+#define IS_PM34XX_ERRATUM(id)		(pm34xx_errata & (id))
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -979,6 +983,14 @@ void omap_push_sram_idle(void)
 				save_secure_ram_context_sz);
 }
 
+static void pm_errata_configure(void)
+{
+	if (cpu_is_omap34xx()) {
+		if (cpu_is_omap3630())
+			pm34xx_errata |= RTA_ERRATUM_i608;
+	}
+}
+
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
@@ -988,6 +1000,8 @@ static int __init omap3_pm_init(void)
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
+	pm_errata_configure();
+
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
 	/* XXX prcm_setup_regs needs to be before enabling hw
@@ -1035,6 +1049,15 @@ static int __init omap3_pm_init(void)
 	pm_idle = omap3_pm_idle;
 	omap3_idle_init();
 
+	/*
+	 * RTA is disabled during initialization as per erratum i608
+	 * it is safer to disable rta by the bootloader, but we would like
+	 * to be doubly sure here and prevent any mishaps.
+	 */
+	if (IS_PM34XX_ERRATUM(RTA_ERRATUM_i608))
+		omap_ctrl_writel(OMAP36XX_RTA_DISABLE,
+			OMAP36XX_CONTROL_MEM_RTA_CTRL);
+
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 3fbd1e5..cc3507b 100644
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
@@ -246,6 +256,20 @@ copy_to_sram:
 	bne	copy_to_sram
 	ldr	r1, sram_base
 	blx	r1
+	b	restore
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
@@ -650,6 +674,8 @@ cache_pred_disable_mask:
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

