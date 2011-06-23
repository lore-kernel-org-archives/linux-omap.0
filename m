From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 18/25] ARM: pm: samsung: move cpu_suspend into C code
Date: Thu, 23 Jun 2011 20:15:07 +0100
Message-ID: <E1QZpMp-0005n9-AZ@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46035 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005Ab1FWTPS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 15:15:18 -0400
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

Move the call to cpu_suspend into C code, and noticing that all the
s3c_cpu_save implementations are now identical, we can move this
into the common samsung code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-exynos4/pm.c              |    2 +-
 arch/arm/mach-exynos4/sleep.S           |   18 ------------------
 arch/arm/mach-s3c2412/pm.c              |    2 +-
 arch/arm/mach-s3c2416/pm.c              |    2 +-
 arch/arm/mach-s3c64xx/pm.c              |    2 +-
 arch/arm/mach-s3c64xx/sleep.S           |   18 ------------------
 arch/arm/mach-s5pv210/pm.c              |    2 +-
 arch/arm/mach-s5pv210/sleep.S           |   17 -----------------
 arch/arm/plat-s3c24xx/sleep.S           |   19 -------------------
 arch/arm/plat-samsung/include/plat/pm.h |    5 ++---
 arch/arm/plat-samsung/pm.c              |    6 +++---
 11 files changed, 10 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index 8755ca8..5c01c60 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -280,7 +280,7 @@ static struct sleep_save exynos4_l2cc_save[] = {
 	SAVE_ITEM(S5P_VA_L2CC + L2X0_AUX_CTRL),
 };
 
-void exynos4_cpu_suspend(void)
+void exynos4_cpu_suspend(unsigned long arg)
 {
 	unsigned long tmp;
 	unsigned long mask = 0xFFFFFFFF;
diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
index b56a491..0984078 100644
--- a/arch/arm/mach-exynos4/sleep.S
+++ b/arch/arm/mach-exynos4/sleep.S
@@ -33,24 +33,6 @@
 	.text
 
 	/*
-	 * s3c_cpu_save
-	 *
-	 * entry:
-	 *	r1 = v:p offset
-	 */
-
-ENTRY(s3c_cpu_save)
-	adr	r3, BSYM(exynos4_finish_suspend)
-	b	cpu_suspend
-
-exynos4_finish_suspend:
-	ldr	r0, =pm_cpu_sleep
-	ldr	r0, [ r0 ]
-	mov	pc, r0
-
-	.ltorg
-
-	/*
 	 * sleep magic, to allow the bootloader to check for an valid
 	 * image to resume to. Must be the first word before the
 	 * s3c_cpu_resume entry.
diff --git a/arch/arm/mach-s3c2412/pm.c b/arch/arm/mach-s3c2412/pm.c
index 752b13a..fecd854 100644
--- a/arch/arm/mach-s3c2412/pm.c
+++ b/arch/arm/mach-s3c2412/pm.c
@@ -37,7 +37,7 @@
 
 extern void s3c2412_sleep_enter(void);
 
-static void s3c2412_cpu_suspend(void)
+static void s3c2412_cpu_suspend(unsigned long arg)
 {
 	unsigned long tmp;
 
diff --git a/arch/arm/mach-s3c2416/pm.c b/arch/arm/mach-s3c2416/pm.c
index 41db2b2..268fda7 100644
--- a/arch/arm/mach-s3c2416/pm.c
+++ b/arch/arm/mach-s3c2416/pm.c
@@ -24,7 +24,7 @@
 
 extern void s3c2412_sleep_enter(void);
 
-static void s3c2416_cpu_suspend(void)
+static void s3c2416_cpu_suspend(unsigned long arg)
 {
 	flush_cache_all();
 
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index bc1c470..7cc1879 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -112,7 +112,7 @@ void s3c_pm_save_core(void)
  * this.
  */
 
-static void s3c64xx_cpu_suspend(void)
+static void s3c64xx_cpu_suspend(unsigned long arg)
 {
 	unsigned long tmp;
 
diff --git a/arch/arm/mach-s3c64xx/sleep.S b/arch/arm/mach-s3c64xx/sleep.S
index 2fd3433..34313f9 100644
--- a/arch/arm/mach-s3c64xx/sleep.S
+++ b/arch/arm/mach-s3c64xx/sleep.S
@@ -25,24 +25,6 @@
 
 	.text
 
-	/* s3c_cpu_save
-	 *
-	 * Save enough processor state to allow the restart of the pm.c
-	 * code after resume.
-	 *
-	 * entry:
-	 *	r1 = v:p offset
-	*/
-
-ENTRY(s3c_cpu_save)
-	adr	r3, BSYM(s3c64xx_finish_suspend)
-	b	cpu_suspend
-
-s3c64xx_finish_suspend:
-	@@ call final suspend code
-	ldr	r0, =pm_cpu_sleep
-	ldr	pc, [r0]
-	
 	/* Sleep magic, the word before the resume entry point so that the
 	 * bootloader can check for a resumeable image. */
 
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index 24febae..309e388 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -88,7 +88,7 @@ static struct sleep_save s5pv210_core_save[] = {
 	SAVE_ITEM(S3C2410_TCNTO(0)),
 };
 
-void s5pv210_cpu_suspend(void)
+void s5pv210_cpu_suspend(unsigned long arg)
 {
 	unsigned long tmp;
 
diff --git a/arch/arm/mach-s5pv210/sleep.S b/arch/arm/mach-s5pv210/sleep.S
index 28dfeff..e3452cc 100644
--- a/arch/arm/mach-s5pv210/sleep.S
+++ b/arch/arm/mach-s5pv210/sleep.S
@@ -32,23 +32,6 @@
 
 	.text
 
-	/* s3c_cpu_save
-	 *
-	 * entry:
-	 *	r1 = v:p offset
-	*/
-
-ENTRY(s3c_cpu_save)
-	adr	r3, BSYM(s5pv210_finish_suspend)
-	b	cpu_suspend
-
-s5pv210_finish_suspend:
-	ldr	r0, =pm_cpu_sleep
-	ldr	r0, [ r0 ]
-	mov	pc, r0
-
-	.ltorg
-
 	/* sleep magic, to allow the bootloader to check for an valid
 	 * image to resume to. Must be the first word before the
 	 * s3c_cpu_resume entry.
diff --git a/arch/arm/plat-s3c24xx/sleep.S b/arch/arm/plat-s3c24xx/sleep.S
index 6ada459..c566125 100644
--- a/arch/arm/plat-s3c24xx/sleep.S
+++ b/arch/arm/plat-s3c24xx/sleep.S
@@ -41,25 +41,6 @@
 
 	.text
 
-	/* s3c_cpu_save
-	 *
-	 * entry:
-	 *	r1 = v:p offset
-	*/
-
-ENTRY(s3c_cpu_save)
-	adr	r3, BSYM(s3c24xx_finish_suspend)
-	b	cpu_suspend
-
-s3c24xx_finish_suspend:
-	@@ jump to final code to send system to sleep
-	ldr	r0, =pm_cpu_sleep
-	@@ldr	pc, [ r0 ]
-	ldr	r0, [ r0 ]
-	mov	pc, r0
-	
-	.ltorg
-
 	/* sleep magic, to allow the bootloader to check for an valid
 	 * image to resume to. Must be the first word before the
 	 * s3c_cpu_resume entry.
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 7fb6f6b..0a5b7fa 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -42,7 +42,7 @@ extern unsigned long s3c_irqwake_eintallow;
 /* per-cpu sleep functions */
 
 extern void (*pm_cpu_prep)(void);
-extern void (*pm_cpu_sleep)(void);
+extern void (*pm_cpu_sleep)(unsigned long);
 
 /* Flags for PM Control */
 
@@ -52,10 +52,9 @@ extern unsigned char pm_uart_udivslot;  /* true to save UART UDIVSLOT */
 
 /* from sleep.S */
 
-extern int  s3c_cpu_save(unsigned long *saveblk, long);
 extern void s3c_cpu_resume(void);
 
-extern void s3c2410_cpu_suspend(void);
+extern void s3c2410_cpu_suspend(unsigned long);
 
 /* sleep save info */
 
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 3828191..3a6d076 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -231,7 +231,7 @@ static void __maybe_unused s3c_pm_show_resume_irqs(int start,
 
 
 void (*pm_cpu_prep)(void);
-void (*pm_cpu_sleep)(void);
+void (*pm_cpu_sleep)(unsigned long);
 
 #define any_allowed(mask, allow) (((mask) & (allow)) != (allow))
 
@@ -294,11 +294,11 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	s3c_pm_arch_stop_clocks();
 
-	/* s3c_cpu_save will also act as our return point from when
+	/* this will also act as our return point from when
 	 * we resume as it saves its own register state and restores it
 	 * during the resume.  */
 
-	s3c_cpu_save(0, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, 0, pm_cpu_sleep);
 
 	/* restore the system state */
 
-- 
1.7.4.4

