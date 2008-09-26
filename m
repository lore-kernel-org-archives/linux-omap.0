From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 13/16] OMAP3: MPU Off support
Date: Fri, 26 Sep 2008 17:49:56 +0530
Message-ID: <01fe01c91fd2$30258bd0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34367 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbYIZMUG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:20:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This enables support for MPU OFF in idle.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c    |   11 ++++++++++-
 arch/arm/mach-omap2/sleep34xx.S |   13 ++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-26 14:18:38.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-26 14:30:38.000000000 +0530
@@ -31,6 +31,7 @@
 #include <mach/powerdomain.h>
 #include <mach/common.h>
 #include <mach/control.h>
+#include <mach/sdrc.h>
 #include <asm/tlbflush.h>
 
 #include "cm.h"
@@ -206,6 +207,9 @@ static void omap_sram_idle(void)
 		/* No need to save context */
 		save_state = 0;
 		break;
+	case PWRDM_POWER_OFF:
+		save_state = 3;
+		break;
 	default:
 		/* Invalid state */
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
@@ -237,7 +241,12 @@ static void omap_sram_idle(void)
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 	}
 
-	_omap_sram_idle(NULL, save_state);
+	/*
+	 * omap3_arm_context is the location where ARM registers
+	 * get saved. The restore path then reads from this
+	 * location and restores them back.
+	 */
+	_omap_sram_idle(omap3_arm_context, save_state);
 	/* Restore table entry modified during MMU restoration */
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
 		restore_table_entry();
Index: linux-omap-2.6/arch/arm/mach-omap2/sleep34xx.S
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/sleep34xx.S	2008-09-26 14:00:37.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/sleep34xx.S	2008-09-26 14:28:09.000000000 +0530
@@ -37,12 +37,15 @@
 				OMAP3430_PM_PREPWSTST)
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
-#define PM_PWSTCTRL_MPU_P	OMAP34XX_PRM_REGADDR(MPU_MOD, PM_PWSTCTRL)
+/*
+ * This is the physical address of the register as specified
+ * by the _P. To be used while the MMU is still disabled.
+ */
+#define PM_PWSTCTRL_MPU_P	(OMAP3430_PRM_BASE + MPU_MOD + PM_PWSTCTRL)
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
 				       * available */
-#define SCRATCHPAD_BASE_P	OMAP343X_CTRL_REGADDR(\
-				OMAP343X_CONTROL_MEM_WKUP +\
-				SCRATCHPAD_MEM_OFFS)
+#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
+						+ SCRATCHPAD_MEM_OFFS)
 #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
 
 	.text
@@ -97,7 +100,7 @@ loop:
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
 restore:
-	/* b restore*/ 	@ Enable to debug restore code
+	/* b restore*/  @ Enable to debug restore code
         /* Check what was the reason for mpu reset and store the reason in r9*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost - In this case, we wont be here */

