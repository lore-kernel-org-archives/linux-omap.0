From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2xxx: PM: enter WFI via inline asm if CORE
 stays active
Date: Wed, 6 Feb 2013 21:21:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302062119540.12769@utopia.booyaka.com>
References: <20121230182745.30526.47072.stgit@dusk.lan> <20121230182826.30526.27155.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37684 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757956Ab3BFVV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 16:21:59 -0500
In-Reply-To: <20121230182826.30526.27155.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Richard Woodruff <r-woodruff2@ti.com>

On Sun, 30 Dec 2012, Paul Walmsley wrote:

> There shouldn't be any need to jump to SRAM code if the OMAP CORE
> clockdomain (and consequently the SDRAM controller and CORE PLL) stays
> active during MPU WFI.  The SRAM code should only be needed when the RAM
> enters self-refresh.  So in the case where CORE stays active, just call
> WFI directly from the mach-omap2/pm24xx.c code.  This removes some
> unnecessary SRAM code.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Richard Woodruff <r-woodruff2@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Here's an updated version of this one.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 30 Dec 2012 10:15:48 -0700
Subject: [PATCH] ARM: OMAP2xxx: PM: enter WFI via inline asm if CORE stays
 active

There shouldn't be any need to jump to SRAM code if the OMAP CORE
clockdomain (and consequently the SDRAM controller and CORE PLL) stays
active during MPU WFI.  The SRAM code should only be needed when the RAM
enters self-refresh.  So in the case where CORE stays active, just call
WFI directly from the mach-omap2/pm24xx.c code.  This removes some
unnecessary SRAM code.

This second version replaces the inline WFI with the corresponding
coprocessor register call, using tlbflush.h as an example.  This is
because the assembler doesn't recognize WFI as a valid ARMv6
instruction.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm24xx.c    |   12 ++++++------
 arch/arm/mach-omap2/sleep24xx.S |   19 -------------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index c333fa6..8914b9e 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -54,7 +54,6 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 
-static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
 				  void __iomem *sdrc_power);
 
@@ -172,6 +171,8 @@ static int omap2_allow_mpu_retention(void)
 
 static void omap2_enter_mpu_retention(void)
 {
+	const int zero = 0;
+
 	/* Putting MPU into the WFI state while a transfer is active
 	 * seems to cause the I2C block to timeout. Why? Good question. */
 	if (omap2_i2c_active())
@@ -196,7 +197,8 @@ static void omap2_enter_mpu_retention(void)
 						 OMAP2_PM_PWSTCTRL);
 	}
 
-	omap2_sram_idle();
+	/* WFI */
+	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
 }
 
 static int omap2_can_sleep(void)
@@ -356,11 +358,9 @@ int __init omap2_pm_init(void)
 	/*
 	 * We copy the assembler sleep/wakeup routines to SRAM.
 	 * These routines need to be in SRAM as that's the only
-	 * memory the MPU can see when it wakes up.
+	 * memory the MPU can see when it wakes up after the entire
+	 * chip enters idle.
 	 */
-	omap2_sram_idle = omap_sram_push(omap24xx_idle_loop_suspend,
-					 omap24xx_idle_loop_suspend_sz);
-
 	omap2_sram_suspend = omap_sram_push(omap24xx_cpu_suspend,
 					    omap24xx_cpu_suspend_sz);
 
diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sleep24xx.S
index ce0ccd2..1d3cb25 100644
--- a/arch/arm/mach-omap2/sleep24xx.S
+++ b/arch/arm/mach-omap2/sleep24xx.S
@@ -37,25 +37,6 @@
 	.text
 
 /*
- * Forces OMAP into idle state
- *
- * omap24xx_idle_loop_suspend() - This bit of code just executes the WFI
- * for normal idles.
- *
- * Note: This code get's copied to internal SRAM at boot. When the OMAP
- *	 wakes up it continues execution at the point it went to sleep.
- */
-	.align	3
-ENTRY(omap24xx_idle_loop_suspend)
-	stmfd	sp!, {r0, lr}		@ save registers on stack
-	mov	r0, #0			@ clear for mcr setup
-	mcr	p15, 0, r0, c7, c0, 4	@ wait for interrupt
-	ldmfd	sp!, {r0, pc}		@ restore regs and return
-
-ENTRY(omap24xx_idle_loop_suspend_sz)
-	.word	. - omap24xx_idle_loop_suspend
-
-/*
  * omap24xx_cpu_suspend() - Forces OMAP into deep sleep state by completing
  * SDRC shutdown then ARM shutdown.  Upon wake MPU is back on so just restore
  * SDRC.
-- 
1.7.10.4

