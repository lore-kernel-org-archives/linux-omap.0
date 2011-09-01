From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 09/11] ARM: pm: get rid of cpu_resume_turn_mmu_on
Date: Thu, 01 Sep 2011 13:51:19 +0100
Message-ID: <E1Qz6jn-00078h-Ok@rmk-PC.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57084 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571Ab1IAOCG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 10:02:06 -0400
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.org

We don't require cpu_resume_turn_mmu_on as we can combine the ldr
instruction with the following code provided we ensure that
cpu_resume_mmu is aligned for older CPUs.  Note that we also align
to a 32-byte boundary to ensure that the code can't cross a section
boundary.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S   |    8 ++------
 arch/arm/kernel/suspend.c |    4 ++--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 25d42df..c9a43ca 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -72,19 +72,15 @@ ENDPROC(cpu_suspend_abort)
 /*
  * r0 = control register value
  */
+	.align	5
 ENTRY(cpu_resume_mmu)
 	ldr	r3, =cpu_resume_after_mmu
-	b	cpu_resume_turn_mmu_on
-ENDPROC(cpu_resume_mmu)
-	.ltorg
-	.align	5
-ENTRY(cpu_resume_turn_mmu_on)
 	mcr	p15, 0, r0, c1, c0, 0	@ turn on MMU, I-cache, etc
 	mrc	p15, 0, r0, c0, c0, 0	@ read id reg
 	mov	r0, r0
 	mov	r0, r0
 	mov	pc, r3			@ jump to virtual address
-ENDPROC(cpu_resume_turn_mmu_on)
+ENDPROC(cpu_resume_mmu)
 cpu_resume_after_mmu:
 	bl	cpu_init		@ restore the und/abt/irq banked regs
 	mov	r0, #0			@ return zero on success
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 7606122..115736a 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -9,7 +9,7 @@
 static pgd_t *suspend_pgd;
 
 extern int __cpu_suspend(int, long, unsigned long, int (*)(unsigned long));
-extern void cpu_resume_turn_mmu_on(void);
+extern void cpu_resume_mmu(void);
 
 /*
  * Hide the first two arguments to __cpu_suspend - these are an implementation
@@ -41,7 +41,7 @@ static int __init cpu_suspend_init(void)
 {
 	suspend_pgd = pgd_alloc(&init_mm);
 	if (suspend_pgd) {
-		unsigned long addr = virt_to_phys(cpu_resume_turn_mmu_on);
+		unsigned long addr = virt_to_phys(cpu_resume_mmu);
 		identity_mapping_add(suspend_pgd, addr, addr + SECTION_SIZE);
 	}
 	return suspend_pgd ? 0 : -ENOMEM;
-- 
1.7.4.4

