From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP3: PM: remove get_*_restore_pointer functions, directly use entry points
Date: Thu, 23 Jun 2011 17:16:14 -0700
Message-ID: <1308874574-30663-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:58906 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759972Ab1FXAQN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 20:16:13 -0400
Received: by pzk9 with SMTP id 9so2011948pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 17:16:12 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Jean Pihet <jean.pihet@newoldbits.com>

Upon return from off-mode, the ROM code jumps to a restore function
saved in the scratchpad.  Based on SoC revision or errata, this
restore entry point is different.  Current code uses some helper
functions in sleep34xx.S (get_*_restore_pointer) to get the restore
function entry point.

When returning from off-mode, this code is executed from SDRAM, so
there's no reason to use these helper functions when using the SDRAM
entry points directly would work just fine.

This patch uses ENTRY/ENDPROC to create "real" entry points for these
functions, and uses those values directly when writing the scratchpad.

Tested all three entry points
- restore_es3: 3430/n900
- restore_3630: 3630/Zoom3
- restore: 3530/Overo

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Jean Pihet <jean.pihet@newoldbits.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies on top of Russell's suspend cleanup/rejig, and available
(along with Russell's series) in my pm-wip/idle-suspend branch.

Russell, since it depends on your series, feel free to add it to your
series if you like.  Or if you prefer, we can take it through the OMAP
tree.

 arch/arm/mach-omap2/control.c   |    7 ++--
 arch/arm/mach-omap2/control.h   |    6 ++--
 arch/arm/mach-omap2/sleep34xx.S |   61 +++++++-------------------------------
 3 files changed, 19 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index da53ba3..aab884f 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -286,14 +286,15 @@ void omap3_save_scratchpad_contents(void)
 	scratchpad_contents.boot_config_ptr = 0x0;
 	if (cpu_is_omap3630())
 		scratchpad_contents.public_restore_ptr =
-			virt_to_phys(get_omap3630_restore_pointer());
+			virt_to_phys(omap3_restore_3630);
 	else if (omap_rev() != OMAP3430_REV_ES3_0 &&
 					omap_rev() != OMAP3430_REV_ES3_1)
 		scratchpad_contents.public_restore_ptr =
-			virt_to_phys(get_restore_pointer());
+			virt_to_phys(omap3_restore);
 	else
 		scratchpad_contents.public_restore_ptr =
-			virt_to_phys(get_es3_restore_pointer());
+			virt_to_phys(omap3_restore_es3);
+
 	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
 		scratchpad_contents.secure_ram_restore_ptr = 0x0;
 	else
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a016c8b..d4ef75d 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -386,9 +386,9 @@ extern void omap4_ctrl_pad_writel(u32 val, u16 offset);
 
 extern void omap3_save_scratchpad_contents(void);
 extern void omap3_clear_scratchpad_contents(void);
-extern u32 *get_restore_pointer(void);
-extern u32 *get_es3_restore_pointer(void);
-extern u32 *get_omap3630_restore_pointer(void);
+extern void omap3_restore(void);
+extern void omap3_restore_es3(void);
+extern void omap3_restore_3630(void);
 extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 9a1349e..177f70f 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -74,46 +74,6 @@
  * API functions
  */
 
-/*
- * The "get_*restore_pointer" functions are used to provide a
- * physical restore address where the ROM code jumps while waking
- * up from MPU OFF/OSWR state.
- * The restore pointer is stored into the scratchpad.
- */
-
-	.text
-/* Function call to get the restore pointer for resume from OFF */
-ENTRY(get_restore_pointer)
-	stmfd	sp!, {lr}	@ save registers on stack
-	adr	r0, restore
-	ldmfd	sp!, {pc}	@ restore regs and return
-ENDPROC(get_restore_pointer)
-	.align
-ENTRY(get_restore_pointer_sz)
-	.word	. - get_restore_pointer
-
-	.text
-/* Function call to get the restore pointer for 3630 resume from OFF */
-ENTRY(get_omap3630_restore_pointer)
-	stmfd	sp!, {lr}	@ save registers on stack
-	adr	r0, restore_3630
-	ldmfd	sp!, {pc}	@ restore regs and return
-ENDPROC(get_omap3630_restore_pointer)
-	.align
-ENTRY(get_omap3630_restore_pointer_sz)
-	.word	. - get_omap3630_restore_pointer
-
-	.text
-/* Function call to get the restore pointer for ES3 to resume from OFF */
-ENTRY(get_es3_restore_pointer)
-	stmfd	sp!, {lr}	@ save registers on stack
-	adr	r0, restore_es3
-	ldmfd	sp!, {pc}	@ restore regs and return
-ENDPROC(get_es3_restore_pointer)
-	.align
-ENTRY(get_es3_restore_pointer_sz)
-	.word	. - get_es3_restore_pointer
-
 	.text
 /*
  * L2 cache needs to be toggled for stable OFF mode functionality on 3630.
@@ -316,12 +276,12 @@ omap3_do_wfi:
  *  restore_3630: applies to 36xx
  *  restore: common code for 3xxx
  */
-restore_es3:
+ENTRY(omap3_restore_es3)
 	ldr	r5, pm_prepwstst_core_p
 	ldr	r4, [r5]
 	and	r4, r4, #0x3
 	cmp	r4, #0x0	@ Check if previous power state of CORE is OFF
-	bne	restore
+	bne	omap3_restore
 	adr	r0, es3_sdrc_fix
 	ldr	r1, sram_base
 	ldr	r2, es3_sdrc_fix_sz
@@ -333,22 +293,24 @@ copy_to_sram:
 	bne	copy_to_sram
 	ldr	r1, sram_base
 	blx	r1
-	b	restore
-
-restore_3630:
+	b	omap3_restore
+ENDPROC(omap3_restore_es3)
+	
+ENTRY(omap3_restore_3630)
 	ldr	r1, pm_prepwstst_core_p
 	ldr	r2, [r1]
 	and	r2, r2, #0x3
 	cmp	r2, #0x0	@ Check if previous power state of CORE is OFF
-	bne	restore
+	bne	omap3_restore
 	/* Disable RTA before giving control */
 	ldr	r1, control_mem_rta
 	mov	r2, #OMAP36XX_RTA_DISABLE
 	str	r2, [r1]
-
+ENDPROC(omap3_restore_3630)
+	
 	/* Fall through to common code for the remaining logic */
 
-restore:
+ENTRY(omap3_restore)
 	/*
 	 * Read the pwstctrl register to check the reason for mpu reset.
 	 * This tells us what was lost.
@@ -438,7 +400,8 @@ skipl2reen:
 
 	/* Now branch to the common CPU resume function */
 	b	cpu_resume
-
+ENDPROC(omap3_restore)
+	
 	.ltorg
 
 /*
-- 
1.7.4

