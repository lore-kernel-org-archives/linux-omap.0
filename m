From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 04/25] ARM: pm: make MULTI_CPU and !MULTI_CPU resume paths
 the same
Date: Thu, 23 Jun 2011 20:10:23 +0100
Message-ID: <E1QZpIF-0005ls-Ar@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Eliminate the differences between MULTI_CPU and non-MULTI_CPU resume
paths, making the saved structure identical irrespective of the way
the kernel was configured.

Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 6398ead..97a6577 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -40,9 +40,11 @@ ENTRY(cpu_suspend)
 #else
 	mov	r2, sp			@ current virtual SP
 	ldr	r0, =cpu_suspend_size
+	ldr	ip, =cpu_do_resume
 	sub	sp, sp, r0		@ allocate CPU state on stack
 	mov	r0, sp			@ save pointer
-	stmfd	sp!, {r1, r2, r3}	@ save v:p, virt SP, return fn
+	add	ip, ip, r1		@ convert resume fn to phys
+	stmfd	sp!, {r1, r2, r3, ip}	@ save v:p, virt SP, retfn, phys resume fn
 	ldr	r3, =sleep_save_sp
 	add	r2, sp, r1		@ convert SP to phys
 #ifdef CONFIG_SMP
@@ -120,20 +122,12 @@ ENTRY(cpu_resume)
 	ldr	r0, sleep_save_sp	@ stack phys addr
 #endif
 	setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r1  @ set SVC, irqs off
-#ifdef MULTI_CPU
 	@ load v:p, stack, return fn, resume fn
   ARM(	ldmia	r0!, {r1, sp, lr, pc}	)
 THUMB(	ldmia	r0!, {r1, r2, r3, r4}	)
 THUMB(	mov	sp, r2			)
 THUMB(	mov	lr, r3			)
 THUMB(	bx	r4			)
-#else
-	@ load v:p, stack, return fn
-  ARM(	ldmia	r0!, {r1, sp, lr}	)
-THUMB(	ldmia	r0!, {r1, r2, lr}	)
-THUMB(	mov	sp, r2			)
-	b	cpu_do_resume
-#endif
 ENDPROC(cpu_resume)
 
 sleep_save_sp:
-- 
1.7.4.4
