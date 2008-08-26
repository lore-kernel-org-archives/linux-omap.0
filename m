From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 05/06] mpu off support - enables C3 and C5
Date: Tue, 26 Aug 2008 18:35:20 +0530 (IST)
Message-ID: <34126.192.168.10.89.1219755920.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41272 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbYHZNF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 09:05:26 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7QD5L7l005236
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:05:26 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7QD5JbL022179
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:05:20 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This enables support for MPU OFF.
Enables states C3 and C5.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/cpuidle34xx.c |    8 ++++++--
 arch/arm/mach-omap2/pm34xx.c      |    6 +++++-
 arch/arm/mach-omap2/sleep34xx.S   |    8 +++-----
 3 files changed, 14 insertions(+), 8 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-08-26
17:22:52.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-08-26
17:34:24.000000000 +0530
@@ -26,6 +26,7 @@
 #include <mach/pm.h>
 #include <mach/prcm.h>
 #include <mach/powerdomain.h>
+#include <mach/control.h>
 #include <linux/sched.h>

 #include "cpuidle34xx.h"
@@ -173,7 +174,7 @@ void omap_init_power_states(void)
 						CPUIDLE_FLAG_BALANCED;

 	/* C3 . MPU OFF + Core active */
-	omap3_power_states[3].valid = 0;
+	omap3_power_states[3].valid = 1;
 	omap3_power_states[3].type = OMAP3_STATE_C3;
 	omap3_power_states[3].sleep_latency = 1500;
 	omap3_power_states[3].wakeup_latency = 1800;
@@ -195,7 +196,7 @@ void omap_init_power_states(void)
 			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;

 	/* C5 . MPU OFF + Core CSWR */
-	omap3_power_states[5].valid = 0;
+	omap3_power_states[5].valid = 1;
 	omap3_power_states[5].type = OMAP3_STATE_C5;
 	omap3_power_states[5].sleep_latency = 3000;
 	omap3_power_states[5].wakeup_latency = 8500;
@@ -232,6 +233,9 @@ int omap3_idle_init(void)
 	struct cpuidle_state *state;
 	struct cpuidle_device *dev;

+	omap3_clear_scratchpad_contents();
+	omap3_save_scratchpad_contents();
+
 	omap_init_power_states();
 	cpuidle_register_driver(&omap3_idle_driver);

Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-08-26
17:33:54.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-08-26 17:34:24.000000000
+0530
@@ -241,6 +241,9 @@ void omap_sram_idle(void)
 		/* No need to save context */
 		save_state = 0;
 		break;
+	case PWRDM_POWER_OFF:
+		save_state = 3;
+		break;
 	default:
 		/* Invalid state */
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
@@ -271,7 +274,8 @@ void omap_sram_idle(void)
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 	}

-	_omap_sram_idle(NULL, save_state);
+	_omap_sram_idle(context_mem, save_state);
+
 	/* Restore table entry modified during MMU restoration */
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
 		restore_table_entry();
Index: linux-omap-2.6/arch/arm/mach-omap2/sleep34xx.S
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/sleep34xx.S	2008-08-26
17:22:23.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/sleep34xx.S	2008-08-26
17:34:24.000000000 +0530
@@ -37,12 +37,10 @@
 				OMAP3430_PM_PREPWSTST)
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
-#define PM_PWSTCTRL_MPU_P	OMAP34XX_PRM_REGADDR(MPU_MOD, PM_PWSTCTRL)
+#define PM_PWSTCTRL_MPU_P	0x483069E0
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
 				       * available */
-#define SCRATCHPAD_BASE_P	OMAP343X_CTRL_REGADDR(\
-				OMAP343X_CONTROL_MEM_WKUP +\
-				SCRATCHPAD_MEM_OFFS)
+#define SCRATCHPAD_BASE_P	0x48002910
 #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)

 	.text
@@ -97,7 +95,7 @@ loop:

 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
 restore:
-	/* b restore*/ 	@ Enable to debug restore code
+	/* b restore*/  @ Enable to debug restore code
         /* Check what was the reason for mpu reset and store the reason in r9*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost - In this case, we wont be here */


