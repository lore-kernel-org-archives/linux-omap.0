From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 13/25] ARM: pm: sa1100: move cpu_suspend into C code
Date: Thu, 23 Jun 2011 20:13:26 +0100
Message-ID: <E1QZpLC-0005mj-0s@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46015 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932893Ab1FWTNe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 15:13:34 -0400
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

We don't need a veneer for cpu_suspend, it can be called directly from
C code now.  Move it into sa11x0_pm_enter() along with the re-enabling
of clock switching.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/pm.c    |    4 ++--
 arch/arm/mach-sa1100/sleep.S |   11 ++---------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index d35885c..259ed3b 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -32,7 +32,7 @@
 #include <asm/system.h>
 #include <asm/mach/time.h>
 
-extern void sa1100_cpu_suspend(long);
+extern void sa1100_finish_suspend(unsigned long);
 
 #define SAVE(x)		sleep_save[SLEEP_SAVE_##x] = x
 #define RESTORE(x)	x = sleep_save[SLEEP_SAVE_##x]
@@ -75,7 +75,7 @@ static int sa11x0_pm_enter(suspend_state_t state)
 	PSPR = virt_to_phys(cpu_resume);
 
 	/* go zzz */
-	sa1100_cpu_suspend(PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, 0, sa1100_finish_suspend);
 
 	/*
 	 * Ensure not to come back here if it wasn't intended
diff --git a/arch/arm/mach-sa1100/sleep.S b/arch/arm/mach-sa1100/sleep.S
index f3fe397..e822331 100644
--- a/arch/arm/mach-sa1100/sleep.S
+++ b/arch/arm/mach-sa1100/sleep.S
@@ -22,20 +22,13 @@
 
 		.text
 /*
- * sa1100_cpu_suspend()
+ * sa1100_finish_suspend()
  *
  * Causes sa11x0 to enter sleep state
  *
  */
 
-ENTRY(sa1100_cpu_suspend)
-	stmfd	sp!, {r4 - r12, lr}		@ save registers on stack
-	mov	r1, r0
-	adr	r3, BSYM(sa1100_finish_suspend)
-	bl	cpu_suspend
-	ldmfd	sp!, {r4 - r12, pc}		@ return to caller
-
-sa1100_finish_suspend:
+ENTRY(sa1100_finish_suspend)
 	@ disable clock switching
 	mcr	p15, 0, r1, c15, c2, 2
 
-- 
1.7.4.4

