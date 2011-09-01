From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 10/11] ARM: pm: convert some assembly to C
Date: Thu, 01 Sep 2011 13:51:39 +0100
Message-ID: <E1Qz6k7-00078l-SM@rmk-PC.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34120 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757516Ab1IAOAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 10:00:04 -0400
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.org

Convert some of the sleep.S guts to C code, which makes it easier to
use our macros and to add L2 cache handling.  We provide a helper
function, __cpu_suspend_save(), which deals with saving the common
state, setting up for resume, and flushing caches.

The remainder left as assembly code is the saving of the CPU general
purpose registers, and allocating space on the stack to save the CPU
specific registers and resume state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/proc-fns.h |    8 ++++++
 arch/arm/kernel/sleep.S         |   53 ++++++++++++--------------------------
 arch/arm/kernel/suspend.c       |   24 +++++++++++++++--
 3 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 633d1cb..9e92cb2 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -81,6 +81,10 @@ extern void cpu_dcache_clean_area(void *, int);
 extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
 extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
 extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
+
+/* These three are private to arch/arm/kernel/suspend.c */
+extern void cpu_do_suspend(void *);
+extern void cpu_do_resume(void *);
 #else
 #define cpu_proc_init			processor._proc_init
 #define cpu_proc_fin			processor._proc_fin
@@ -89,6 +93,10 @@ extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
 #define cpu_dcache_clean_area		processor.dcache_clean_area
 #define cpu_set_pte_ext			processor.set_pte_ext
 #define cpu_do_switch_mm		processor.switch_mm
+
+/* These three are private to arch/arm/kernel/suspend.c */
+#define cpu_do_suspend			processor.do_suspend
+#define cpu_do_resume			processor.do_resume
 #endif
 
 extern void cpu_resume(void);
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index c9a43ca..020e99c 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -8,54 +8,35 @@
 	.text
 
 /*
- * Save CPU state for a suspend
- *  r0 = phys addr of temporary page tables
- *  r1 = v:p offset
- *  r2 = suspend function arg0
- *  r3 = suspend function
+ * Save CPU state for a suspend.  This saves the CPU general purpose
+ * registers, and allocates space on the kernel stack to save the CPU
+ * specific registers and some other data for resume.
+ *  r0 = suspend function arg0
+ *  r1 = suspend function
  */
 ENTRY(__cpu_suspend)
 	stmfd	sp!, {r4 - r11, lr}
-	mov	r4, r0
 #ifdef MULTI_CPU
 	ldr	r10, =processor
-	ldr	r5, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
-	ldr	ip, [r10, #CPU_DO_RESUME] @ virtual resume function
+	ldr	r4, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
 #else
-	ldr	r5, =cpu_suspend_size
-	ldr	ip, =cpu_do_resume
+	ldr	r4, =cpu_suspend_size
 #endif
-	mov	r6, sp			@ current virtual SP
-	sub	sp, sp, r5		@ allocate CPU state on stack
-	mov	r0, sp			@ save pointer to CPU save block
-	add	ip, ip, r1		@ convert resume fn to phys
-	stmfd	sp!, {r4, r6, ip}	@ save phys pgd, virt SP, phys resume fn
-	ldr	r5, =sleep_save_sp
-	add	r6, sp, r1		@ convert SP to phys
-	stmfd	sp!, {r2, r3}		@ save suspend func arg and pointer
+	mov	r5, sp			@ current virtual SP
+	add	r4, r4, #12		@ Space for pgd, virt sp, phys resume fn
+	sub	sp, sp, r4		@ allocate CPU state on stack
+	stmfd	sp!, {r0, r1}		@ save suspend func arg and pointer
+	add	r0, sp, #8		@ save pointer to save block
+	mov	r1, r4			@ size of save block
+	mov	r2, r5			@ virtual SP
+	ldr	r3, =sleep_save_sp
 #ifdef CONFIG_SMP
 	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
 	ALT_UP(mov lr, #0)
 	and	lr, lr, #15
-	str	r6, [r5, lr, lsl #2]	@ save phys SP
-#else
-	str	r6, [r5]		@ save phys SP
-#endif
-#ifdef MULTI_CPU
-	mov	lr, pc
-	ldr	pc, [r10, #CPU_DO_SUSPEND] @ save CPU state
-#else
-	bl	cpu_do_suspend
-#endif
-
-	@ flush data cache
-#ifdef MULTI_CACHE
-	ldr	r10, =cpu_cache
-	mov	lr, pc
-	ldr	pc, [r10, #CACHE_FLUSH_KERN_ALL]
-#else
-	bl	__cpuc_flush_kern_all
+	add	r3, r3, lr, lsl #2
 #endif
+	bl	__cpu_suspend_save
 	adr	lr, BSYM(cpu_suspend_abort)
 	ldmfd	sp!, {r0, pc}		@ call suspend fn
 ENDPROC(__cpu_suspend)
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 115736a..c78a88f 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -8,10 +8,29 @@
 
 static pgd_t *suspend_pgd;
 
-extern int __cpu_suspend(int, long, unsigned long, int (*)(unsigned long));
+extern int __cpu_suspend(unsigned long, int (*)(unsigned long));
 extern void cpu_resume_mmu(void);
 
 /*
+ * This is called by __cpu_suspend() to save the state, and do whatever
+ * flushing is required to ensure that when the CPU goes to sleep we have
+ * the necessary data available when the caches are not searched.
+ */
+void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
+{
+	*save_ptr = virt_to_phys(ptr);
+
+	/* This must correspond to the LDM in cpu_resume() assembly */
+	*ptr++ = virt_to_phys(suspend_pgd);
+	*ptr++ = sp;
+	*ptr++ = virt_to_phys(cpu_do_resume);
+
+	cpu_do_suspend(ptr);
+
+	flush_cache_all();
+}
+
+/*
  * Hide the first two arguments to __cpu_suspend - these are an implementation
  * detail which platform code shouldn't have to know about.
  */
@@ -29,8 +48,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 * resume (indicated by a zero return code), we need to switch
 	 * back to the correct page tables.
 	 */
-	ret = __cpu_suspend(virt_to_phys(suspend_pgd),
-			    PHYS_OFFSET - PAGE_OFFSET, arg, fn);
+	ret = __cpu_suspend(arg, fn);
 	if (ret == 0)
 		cpu_switch_mm(mm->pgd, mm);
 
-- 
1.7.4.4

