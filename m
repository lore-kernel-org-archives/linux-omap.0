From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 05/25] ARM: pm: move return address (for cpu_resume) to top
 of stack
Date: Thu, 23 Jun 2011 20:10:43 +0100
Message-ID: <E1QZpIZ-0005ly-EP@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Move the return address for cpu_resume to the top of stack so that
cpu_resume looks more like a normal function.

Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 97a6577..f8e9251 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -15,6 +15,7 @@
  * r0-r3,r9,r10,lr corrupted
  */
 ENTRY(cpu_suspend)
+	stmfd	sp!, {r3}
 	mov	r9, lr
 #ifdef MULTI_CPU
 	ldr	r10, =processor
@@ -24,7 +25,7 @@ ENTRY(cpu_suspend)
 	sub	sp, sp, r0		@ allocate CPU state on stack
 	mov	r0, sp			@ save pointer
 	add	ip, ip, r1		@ convert resume fn to phys
-	stmfd	sp!, {r1, r2, r3, ip}	@ save v:p, virt SP, retfn, phys resume fn
+	stmfd	sp!, {r1, r2, ip}	@ save v:p, virt SP, phys resume fn
 	ldr	r3, =sleep_save_sp
 	add	r2, sp, r1		@ convert SP to phys
 #ifdef CONFIG_SMP
@@ -44,7 +45,7 @@ ENTRY(cpu_suspend)
 	sub	sp, sp, r0		@ allocate CPU state on stack
 	mov	r0, sp			@ save pointer
 	add	ip, ip, r1		@ convert resume fn to phys
-	stmfd	sp!, {r1, r2, r3, ip}	@ save v:p, virt SP, retfn, phys resume fn
+	stmfd	sp!, {r1, r2, ip}	@ save v:p, virt SP, phys resume fn
 	ldr	r3, =sleep_save_sp
 	add	r2, sp, r1		@ convert SP to phys
 #ifdef CONFIG_SMP
@@ -99,7 +100,7 @@ ENDPROC(cpu_resume_turn_mmu_on)
 cpu_resume_after_mmu:
 	str	r5, [r2, r4, lsl #2]	@ restore old mapping
 	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
-	mov	pc, lr
+	ldmfd	sp!, {pc}
 ENDPROC(cpu_resume_after_mmu)
 
 /*
@@ -122,12 +123,11 @@ ENTRY(cpu_resume)
 	ldr	r0, sleep_save_sp	@ stack phys addr
 #endif
 	setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r1  @ set SVC, irqs off
-	@ load v:p, stack, return fn, resume fn
-  ARM(	ldmia	r0!, {r1, sp, lr, pc}	)
-THUMB(	ldmia	r0!, {r1, r2, r3, r4}	)
+	@ load v:p, stack, resume fn
+  ARM(	ldmia	r0!, {r1, sp, pc}	)
+THUMB(	ldmia	r0!, {r1, r2, r3}	)
 THUMB(	mov	sp, r2			)
-THUMB(	mov	lr, r3			)
-THUMB(	bx	r4			)
+THUMB(	bx	r3			)
 ENDPROC(cpu_resume)
 
 sleep_save_sp:
-- 
1.7.4.4
