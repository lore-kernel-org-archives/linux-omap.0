From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 12/25] ARM: pm: move cpu_init() call into core code
Date: Thu, 23 Jun 2011 20:13:05 +0100
Message-ID: <E1QZpKr-0005mY-Ti@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

As we have core code dealing with CPU suspend/resume, we can
re-initialize the CPUs exception banked registers via that code rather
than having platforms deal with that level of detail.  So, move the
call to cpu_init() out of platform code into core code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S    |    1 +
 arch/arm/mach-pxa/pm.c     |    1 -
 arch/arm/mach-sa1100/pm.c  |    2 --
 arch/arm/plat-samsung/pm.c |    4 ----
 4 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index e062677..5392274 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -88,6 +88,7 @@ ENDPROC(cpu_resume_turn_mmu_on)
 cpu_resume_after_mmu:
 	str	r5, [r2, r4, lsl #2]	@ restore old mapping
 	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
+	bl	cpu_init		@ restore the und/abt/irq banked regs
 	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_resume_after_mmu)
 
diff --git a/arch/arm/mach-pxa/pm.c b/arch/arm/mach-pxa/pm.c
index 51e1583..37178a8 100644
--- a/arch/arm/mach-pxa/pm.c
+++ b/arch/arm/mach-pxa/pm.c
@@ -42,7 +42,6 @@ int pxa_pm_enter(suspend_state_t state)
 
 	/* *** go zzz *** */
 	pxa_cpu_pm_fns->enter(state);
-	cpu_init();
 
 	if (state != PM_SUSPEND_STANDBY && pxa_cpu_pm_fns->restore) {
 		/* after sleeping, validate the checksum */
diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index c4661aa..d35885c 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -77,8 +77,6 @@ static int sa11x0_pm_enter(suspend_state_t state)
 	/* go zzz */
 	sa1100_cpu_suspend(PLAT_PHYS_OFFSET - PAGE_OFFSET);
 
-	cpu_init();
-
 	/*
 	 * Ensure not to come back here if it wasn't intended
 	 */
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 5c0a440..3828191 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -300,10 +300,6 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	s3c_cpu_save(0, PLAT_PHYS_OFFSET - PAGE_OFFSET);
 
-	/* restore the cpu state using the kernel's cpu init code. */
-
-	cpu_init();
-
 	/* restore the system state */
 
 	s3c_pm_restore_core();
-- 
1.7.4.4
