From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 20/25] ARM: pm: pxa: move cpu_suspend into C code
Date: Thu, 23 Jun 2011 20:15:47 +0100
Message-ID: <E1QZpNT-0005na-RN@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We don't need a veneer for cpu_suspend, it can be called directly from
C code now.  Move it into the PXA CPU suspend functions, along with
the accumulator register saving/restoring.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pxa/include/mach/pm.h |    4 +-
 arch/arm/mach-pxa/pxa25x.c          |    3 +-
 arch/arm/mach-pxa/pxa27x.c          |   11 ++++++-
 arch/arm/mach-pxa/pxa3xx.c          |   13 ++++++-
 arch/arm/mach-pxa/sleep.S           |   58 +++-------------------------------
 arch/arm/mach-pxa/zeus.c            |    3 +-
 6 files changed, 33 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/pm.h b/arch/arm/mach-pxa/include/mach/pm.h
index f15afe0..a566720 100644
--- a/arch/arm/mach-pxa/include/mach/pm.h
+++ b/arch/arm/mach-pxa/include/mach/pm.h
@@ -22,8 +22,8 @@ struct pxa_cpu_pm_fns {
 extern struct pxa_cpu_pm_fns *pxa_cpu_pm_fns;
 
 /* sleep.S */
-extern void pxa25x_cpu_suspend(unsigned int, long);
-extern void pxa27x_cpu_suspend(unsigned int, long);
+extern void pxa25x_finish_suspend(unsigned long);
+extern void pxa27x_finish_suspend(unsigned long);
 
 extern int pxa_pm_enter(suspend_state_t state);
 extern int pxa_pm_prepare(void);
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index fed363c..fd7725c 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -244,7 +244,8 @@ static void pxa25x_cpu_pm_enter(suspend_state_t state)
 
 	switch (state) {
 	case PM_SUSPEND_MEM:
-		pxa25x_cpu_suspend(PWRMODE_SLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+		cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, PWRMODE_SLEEP,
+			    pxa25x_finish_suspend);
 		break;
 	}
 }
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 2fecbec..824379d 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -284,6 +284,11 @@ void pxa27x_cpu_pm_restore(unsigned long *sleep_save)
 void pxa27x_cpu_pm_enter(suspend_state_t state)
 {
 	extern void pxa_cpu_standby(void);
+#ifndef CONFIG_IWMMXT
+	u64 acc0;
+
+	asm volatile("mra %Q0, %R0, acc0" : "=r" (acc0));
+#endif
 
 	/* ensure voltage-change sequencer not initiated, which hangs */
 	PCFR &= ~PCFR_FVC;
@@ -299,7 +304,11 @@ void pxa27x_cpu_pm_enter(suspend_state_t state)
 		pxa_cpu_standby();
 		break;
 	case PM_SUSPEND_MEM:
-		pxa27x_cpu_suspend(pwrmode, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+		cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, pwrmode,
+			    pxa27x_finish_suspend);
+#ifndef CONFIG_IWMMXT
+		asm volatile("mar acc0, %Q0, %R0" : "=r" (acc0));
+#endif
 		break;
 	}
 }
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 8521d7d..220fd8c 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -141,8 +141,13 @@ static void pxa3xx_cpu_pm_suspend(void)
 {
 	volatile unsigned long *p = (volatile void *)0xc0000000;
 	unsigned long saved_data = *p;
+#ifndef CONFIG_IWMMXT
+	u64 acc0;
 
-	extern void pxa3xx_cpu_suspend(long);
+	asm volatile("mra %Q0, %R0, acc0" : "=r" (acc0));
+#endif
+
+	extern void pxa3xx_finish_suspend(unsigned long);
 
 	/* resuming from D2 requires the HSIO2/BOOT/TPM clocks enabled */
 	CKENA |= (1 << CKEN_BOOT) | (1 << CKEN_TPM);
@@ -162,11 +167,15 @@ static void pxa3xx_cpu_pm_suspend(void)
 	/* overwrite with the resume address */
 	*p = virt_to_phys(cpu_resume);
 
-	pxa3xx_cpu_suspend(PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, 0, pxa3xx_finish_suspend);
 
 	*p = saved_data;
 
 	AD3ER = 0;
+
+#ifndef CONFIG_IWMMXT
+	asm volatile("mar acc0, %Q0, %R0" : "=r" (acc0));
+#endif
 }
 
 static void pxa3xx_cpu_pm_enter(suspend_state_t state)
diff --git a/arch/arm/mach-pxa/sleep.S b/arch/arm/mach-pxa/sleep.S
index 3a67887..1e544be 100644
--- a/arch/arm/mach-pxa/sleep.S
+++ b/arch/arm/mach-pxa/sleep.S
@@ -24,22 +24,9 @@
 
 #ifdef CONFIG_PXA3xx
 /*
- * pxa3xx_cpu_suspend() - forces CPU into sleep state (S2D3C4)
- *
- * r0 = v:p offset
+ * pxa3xx_finish_suspend() - forces CPU into sleep state (S2D3C4)
  */
-ENTRY(pxa3xx_cpu_suspend)
-
-#ifndef CONFIG_IWMMXT
-	mra	r2, r3, acc0
-#endif
-	stmfd	sp!, {r2 - r12, lr}	@ save registers on stack
-	mov	r1, r0
-	adr	r3, BSYM(pxa3xx_finish_suspend)
-	bl	cpu_suspend
-	b	pxa_cpu_resume
-
-pxa3xx_finish_suspend:
+ENTRY(pxa3xx_finish_suspend)
 	mov	r0, #0x06		@ S2D3C4 mode
 	mcr	p14, 0, r0, c7, c0, 0	@ enter sleep
 
@@ -48,25 +35,13 @@ pxa3xx_finish_suspend:
 
 #ifdef CONFIG_PXA27x
 /*
- * pxa27x_cpu_suspend()
+ * pxa27x_finish_suspend()
  *
  * Forces CPU into sleep state.
  *
  * r0 = value for PWRMODE M field for desired sleep state
- * r1 = v:p offset
  */
-ENTRY(pxa27x_cpu_suspend)
-
-#ifndef CONFIG_IWMMXT
-	mra	r2, r3, acc0
-#endif
-	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
-	mov	r2, r0				@ save sleep mode
-	adr	r3, BSYM(pxa27x_finish_suspend)
-	bl	cpu_suspend
-	b	pxa_cpu_resume
-
-pxa27x_finish_suspend:
+ENTRY(pxa27x_finish_suspend)
 	@ Put the processor to sleep
 	@ (also workaround for sighting 28071)
 
@@ -103,22 +78,14 @@ pxa27x_finish_suspend:
 
 #ifdef CONFIG_PXA25x
 /*
- * pxa25x_cpu_suspend()
+ * pxa25x_finish_suspend()
  *
  * Forces CPU into sleep state.
  *
  * r0 = value for PWRMODE M field for desired sleep state
- * r1 = v:p offset
  */
 
-ENTRY(pxa25x_cpu_suspend)
-	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
-	mov	r2, r0				@ save sleep mode
-	adr	r3, BSYM(pxa25x_finish_suspend)
-	bl	cpu_suspend
-	b	pxa_cpu_resume
-
-pxa25x_finish_suspend:
+ENTRY(pxa25x_finish_suspend)
 	@ prepare value for sleep mode
 	mov	r1, r0				@ sleep mode
 
@@ -202,16 +169,3 @@ pxa_cpu_do_suspend:
 	mcr	p14, 0, r1, c7, c0, 0		@ PWRMODE
 
 20:	b	20b				@ loop waiting for sleep
-
-/*
- * pxa_cpu_resume()
- *
- * entry point from bootloader into kernel during resume
- */
-	.align 5
-pxa_cpu_resume:
-	ldmfd	sp!, {r2, r3}
-#ifndef CONFIG_IWMMXT
-	mar	acc0, r2, r3
-#endif
-	ldmfd	sp!, {r4 - r12, pc}		@ return to caller
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 00363c7..28eb410 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -676,7 +676,8 @@ static struct pxa2xx_udc_mach_info zeus_udc_info = {
 static void zeus_power_off(void)
 {
 	local_irq_disable();
-	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, PWRMODE_DEEPSLEEP,
+		    pxa27x_finish_suspend);
 }
 #else
 #define zeus_power_off   NULL
-- 
1.7.4.4
