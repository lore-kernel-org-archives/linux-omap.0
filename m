From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 06/25] ARM: pm: rejig suspend follow-on function calling
 convention
Date: Wed, 22 Jun 2011 16:10:31 +0100
Message-ID: <E1QZP4Z-0002W6-P4@rmk-PC.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Save the suspend function pointer onto the stack for use when returning.
Allocate r2 to pass an argument to the suspend function.

Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 358be13..b924bcc 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -10,6 +10,7 @@
 /*
  * Save CPU state for a suspend
  *  r1 = v:p offset
+ *  r2 = suspend function arg0
  *  r3 = virtual return function
  * Note: sp is decremented to allocate space for CPU state on stack
  * r0-r3,ip,lr corrupted
@@ -17,7 +18,6 @@
 ENTRY(cpu_suspend)
 	stmfd	sp!, {r3}
 	stmfd	sp!, {r4 - r11}
-	mov	r9, lr
 #ifdef MULTI_CPU
 	ldr	r10, =processor
 	ldr	r5, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
@@ -33,6 +33,7 @@ ENTRY(cpu_suspend)
 	stmfd	sp!, {r1, r6, ip}	@ save v:p, virt SP, phys resume fn
 	ldr	r5, =sleep_save_sp
 	add	r6, sp, r1		@ convert SP to phys
+	stmfd	sp!, {r2, lr}		@ save suspend func arg and pointer
 #ifdef CONFIG_SMP
 	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
 	ALT_UP(mov lr, #0)
@@ -51,12 +52,12 @@ ENTRY(cpu_suspend)
 	@ flush data cache
 #ifdef MULTI_CACHE
 	ldr	r10, =cpu_cache
-	mov	lr, r9
+	mov	lr, pc
 	ldr	pc, [r10, #CACHE_FLUSH_KERN_ALL]
 #else
-	mov	lr, r9
-	b	__cpuc_flush_kern_all
+	bl	__cpuc_flush_kern_all
 #endif
+	ldmfd	sp!, {r0, pc}		@ call suspend fn
 ENDPROC(cpu_suspend)
 	.ltorg
 
-- 
1.7.4.4
