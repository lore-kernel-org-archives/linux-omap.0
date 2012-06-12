From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 17/20] ARM: OMAP4: put cpu1 back to sleep if no wake request
Date: Tue, 12 Jun 2012 18:31:32 +0300
Message-ID: <1339515095-9908-18-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52941 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab2FLPcY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 11:32:24 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

If AUX_CORE_BOOT0 does not indicate wakeup request for cpu1, put it back
to off. This is needed during wakeup from device off to prevent cpu1
from being stuck indefinitely in the wakeup loop and also to prevent
wakeup problem on GP chips with device off mode.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-headsmp.S |   83 ++++++++++++++++++++++++++++++++++--
 1 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 7bbb66e..de76666 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -19,8 +19,75 @@
 #include <linux/init.h>
 
 #include <plat/omap44xx.h>
+#include <mach/omap-secure.h>
+#include <asm/smp_scu.h>
+
+#include "prcm_mpu44xx.h"
+
+#define CPU1_PWRSTCTRL (OMAP4430_PRCM_MPU_BASE + OMAP4430_PRCM_MPU_CPU1_INST + \
+			OMAP4_PM_CPU1_PWRSTCTRL_OFFSET)
 
 	__CPUINIT
+
+/*
+ * Put CPU1 to off mode.
+ * Programs CPU1_PWRSTCTRL to OFF via secure API, and enters WFI which
+ * triggers the HW transition. omap_do_wfi() can't be used as we don't
+ * have MMU enabled and neither do we have stack at this point.
+ */
+ENTRY(omap_cpu1_off)
+	/*
+	 * If we are running from a cold boot, we can't enter idle
+	 * yet as PRCM does not contain valid programming for it.
+	 * Thus, we check the CPU1_PWRSTCTRL and see whether it contains
+	 * reset value (POWERSTATE=2), and if this is the case, exit early
+	 */
+	ldr	r12, =CPU1_PWRSTCTRL
+	ldr	r0, [r12]
+	and	r0, #3
+	cmp	r0, #2
+	beq	exit_cpu1_off		@ can't idle yet, exit
+
+	/*
+	 * Program SCU power state for this CPU to POWEROFF. Secure API
+	 * is used for this.
+	 */
+	mov	r0, #SCU_PM_POWEROFF
+	mov	r1, #0x0
+	ldr	r12, =OMAP4_MON_SCU_PWR_INDEX
+	dsb
+	smc     #0
+	dsb
+
+	isb
+	dsb
+	dmb
+	/*
+	 * Execute a WFI instruction to enter OFF.
+	 * Sixteen NOPs added after WFI to prevent speculative
+	 * pipeline execution.
+	 */
+	wfi
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+exit_cpu1_off:
+	mov	pc, lr
+ENDPROC(omap_cpu1_off)
+
 /*
  * OMAP4 specific entry point for secondary CPU to jump from ROM
  * code.  This routine also provides a holding flag into which
@@ -29,32 +96,40 @@
  * register AuxCoreBoot0.
  */
 ENTRY(omap_secondary_startup)
-hold:	ldr	r12,=0x103
+	ldr	r12,=0x103
 	dsb
 	smc	#0			@ read from AuxCoreBoot0
 	mov	r0, r0, lsr #9
 	mrc	p15, 0, r4, c0, c0, 5
 	and	r4, r4, #0x0f
 	cmp	r0, r4
-	bne	hold
+	beq	omap_cont_boot
+
+	bl	omap_cpu1_off
+	b	omap_secondary_startup
 
 	/*
 	 * we've been released from the wait loop,secondary_stack
 	 * should now contain the SVC stack for this core
 	 */
+omap_cont_boot:
 	b	secondary_startup
 ENDPROC(omap_secondary_startup)
 
 ENTRY(omap_secondary_startup_4460)
-hold_2:	ldr	r12,=0x103
+	ldr	r12,=0x103
 	dsb
 	smc	#0			@ read from AuxCoreBoot0
 	mov	r0, r0, lsr #9
 	mrc	p15, 0, r4, c0, c0, 5
 	and	r4, r4, #0x0f
 	cmp	r0, r4
-	bne	hold_2
+	beq	omap4460_cont_boot
+
+	bl	omap_cpu1_off
+	b	omap_secondary_startup_4460
 
+omap4460_cont_boot:
 	/*
 	 * GIC distributor control register has changed between
 	 * CortexA9 r1pX and r2pX. The Control Register secure
-- 
1.7.4.1

