From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 25/27] OMAP3: PM: Wait for SDRC ready iso a blind delay
Date: Wed, 14 Oct 2009 14:58:08 -0700
Message-ID: <1255557490-16787-26-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-16-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-20-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-21-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-22-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-23-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-24-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-25-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-25-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch improves the wakeup SRAM code polling the SDRC to become ready
instead of just waiting for a fixed amount of time.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   48 +++++++++++++++++++++++++++++---------
 1 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 3868ae4..0d33916 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -29,6 +29,7 @@
 #include <mach/io.h>
 #include <mach/control.h>
 
+#include "cm.h"
 #include "prm.h"
 #include "sdrc.h"
 
@@ -38,6 +39,7 @@
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
 #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + PM_PWSTCTRL
+#define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
 #define SRAM_BASE_P		0x40200000
 #define CONTROL_STAT		0x480022F0
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
@@ -52,6 +54,8 @@
 #define SDRC_MR_1_P		(OMAP343X_SDRC_BASE + SDRC_MR_1)
 #define SDRC_EMR2_1_P		(OMAP343X_SDRC_BASE + SDRC_EMR2_1)
 #define SDRC_MANUAL_1_P		(OMAP343X_SDRC_BASE + SDRC_MANUAL_1)
+#define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
+#define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
 
 	.text
 /* Function call to get the restore pointer for resume from OFF */
@@ -187,7 +191,7 @@ loop:
 	nop
 	nop
 	nop
-	bl i_dll_wait
+	bl wait_sdrc_ok
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
 restore_es3:
@@ -539,21 +543,41 @@ skip_l2_inval:
 	nop
 	nop
 	nop
-	bl i_dll_wait
+	bl wait_sdrc_ok
 	/* restore regs and return */
 	ldmfd   sp!, {r0-r12, pc}
 
-i_dll_wait:
-	ldr     r4, clk_stabilize_delay
+/* Make sure SDRC accesses are ok */
+wait_sdrc_ok:
+        ldr     r4, cm_idlest1_core
+        ldr     r5, [r4]
+        and     r5, r5, #0x2
+        cmp     r5, #0
+        bne     wait_sdrc_ok
+        ldr     r4, sdrc_power
+        ldr     r5, [r4]
+        bic     r5, r5, #0x40
+        str     r5, [r4]
+wait_dll_lock:
+        /* Is dll in lock mode? */
+        ldr     r4, sdrc_dlla_ctrl
+        ldr     r5, [r4]
+        tst     r5, #0x4
+        bxne    lr
+        /* wait till dll locks */
+        ldr     r4, sdrc_dlla_status
+        ldr     r5, [r4]
+        and     r5, r5, #0x4
+        cmp     r5, #0x4
+        bne     wait_dll_lock
+        bx      lr
 
-i_dll_delay:
-	subs    r4, r4, #0x1
-	bne     i_dll_delay
-	ldr     r4, sdrc_power
-	ldr     r5, [r4]
-	bic     r5, r5, #0x40
-	str     r5, [r4]
-	bx	lr
+cm_idlest1_core:
+	.word	CM_IDLEST1_CORE_V
+sdrc_dlla_status:
+	.word	SDRC_DLLA_STATUS_V
+sdrc_dlla_ctrl:
+	.word	SDRC_DLLA_CTRL_V
 pm_prepwstst_core:
 	.word	PM_PREPWSTST_CORE_V
 pm_prepwstst_core_p:
-- 
1.6.4.3
