From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 06/25] ARM: pm: extract common code from MULTI_CPU/!MULTI_CPU
 paths
Date: Thu, 23 Jun 2011 20:11:03 +0100
Message-ID: <E1QZpIt-0005m2-I0@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Very little code is different between these two paths now, so extract
the common code.

Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |   24 ++++++------------------
 1 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index f8e9251..0a778c3 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -19,29 +19,13 @@ ENTRY(cpu_suspend)
 	mov	r9, lr
 #ifdef MULTI_CPU
 	ldr	r10, =processor
-	mov	r2, sp			@ current virtual SP
 	ldr	r0, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
 	ldr	ip, [r10, #CPU_DO_RESUME] @ virtual resume function
-	sub	sp, sp, r0		@ allocate CPU state on stack
-	mov	r0, sp			@ save pointer
-	add	ip, ip, r1		@ convert resume fn to phys
-	stmfd	sp!, {r1, r2, ip}	@ save v:p, virt SP, phys resume fn
-	ldr	r3, =sleep_save_sp
-	add	r2, sp, r1		@ convert SP to phys
-#ifdef CONFIG_SMP
-	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
-	ALT_UP(mov lr, #0)
-	and	lr, lr, #15
-	str	r2, [r3, lr, lsl #2]	@ save phys SP
 #else
-	str	r2, [r3]		@ save phys SP
-#endif
-	mov	lr, pc
-	ldr	pc, [r10, #CPU_DO_SUSPEND] @ save CPU state
-#else
-	mov	r2, sp			@ current virtual SP
 	ldr	r0, =cpu_suspend_size
 	ldr	ip, =cpu_do_resume
+#endif
+	mov	r2, sp			@ current virtual SP
 	sub	sp, sp, r0		@ allocate CPU state on stack
 	mov	r0, sp			@ save pointer
 	add	ip, ip, r1		@ convert resume fn to phys
@@ -56,6 +40,10 @@ ENTRY(cpu_suspend)
 #else
 	str	r2, [r3]		@ save phys SP
 #endif
+#ifdef MULTI_CPU
+	mov	lr, pc
+	ldr	pc, [r10, #CPU_DO_SUSPEND] @ save CPU state
+#else
 	bl	cpu_do_suspend
 #endif
 
-- 
1.7.4.4
