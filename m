From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 6/7] OMAP3: PM: add scratchpad locking function
Date: Wed, 17 Feb 2010 18:02:29 -0600
Message-ID: <1266451350-4480-7-git-send-email-khilman@deeprootsystems.com>
References: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
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
Cc: Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Rajendra Nayak <rnayak@ti.com>

This patch implements locking using the semaphore in scratchpad
memory preventing any concurrent access to scratchpad from OMAP
and Baseband/Modem processor.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 22fcc14..12a8ba0 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -33,6 +33,8 @@
 #include "prm.h"
 #include "sdrc.h"
 
+#define SDRC_SCRATCHPAD_SEM_V	0xfa00291c
+
 #define PM_PREPWSTST_CORE_V	OMAP34XX_PRM_REGADDR(CORE_MOD, \
 				OMAP3430_PM_PREPWSTST)
 #define PM_PREPWSTST_CORE_P	0x48306AE8
@@ -57,6 +59,37 @@
 #define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
 #define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
 
+        .text
+/* Function to aquire the semaphore in scratchpad */
+ENTRY(lock_scratchpad_sem)
+	stmfd	sp!, {lr}	@ save registers on stack
+wait_sem:
+	mov	r0,#1
+	ldr	r1, sdrc_scratchpad_sem
+wait_loop:
+	ldr	r2, [r1]	@ load the lock value
+	cmp	r2, r0		@ is the lock free ?
+	beq	wait_loop	@ not free...
+	swp	r2, r0, [r1]	@ semaphore free so lock it and proceed
+	cmp	r2, r0		@ did we succeed ?
+	beq	wait_sem	@ no - try again
+	ldmfd	sp!, {pc}	@ restore regs and return
+sdrc_scratchpad_sem:
+        .word SDRC_SCRATCHPAD_SEM_V
+ENTRY(lock_scratchpad_sem_sz)
+        .word   . - lock_scratchpad_sem
+
+        .text
+/* Function to release the scratchpad semaphore */
+ENTRY(unlock_scratchpad_sem)
+	stmfd	sp!, {lr}	@ save registers on stack
+	ldr	r3, sdrc_scratchpad_sem
+	mov	r2,#0
+	str	r2,[r3]
+	ldmfd	sp!, {pc}	@ restore regs and return
+ENTRY(unlock_scratchpad_sem_sz)
+        .word   . - unlock_scratchpad_sem
+
 	.text
 /* Function call to get the restore pointer for resume from OFF */
 ENTRY(get_restore_pointer)
-- 
1.6.6
