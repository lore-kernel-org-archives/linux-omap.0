From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/07] ARM: OMAP2: Move sleep.S into sleep24xx.S
Date: Fri,  3 Oct 2008 14:56:44 +0300
Message-ID: <1223035009-23866-3-git-send-email-tony@atomide.com>
References: <1223035009-23866-1-git-send-email-tony@atomide.com>
 <1223035009-23866-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62848 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbYJCLyF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 07:54:05 -0400
In-Reply-To: <1223035009-23866-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Some register offsets are different for 242x and 243x. This
will allow compiling sleep code for both chips into the same
kernel. Pass the addresses for SDRC_DDLA_CTRL and SDRC_POWER to the
omap24xx_cpu_suspend instead of loading the values since the only.

Also fix a bug to call omap2_sram_suspend with the value of SDRC_DLLA_CTRL
instead of the address as that's what omap24xx_cpu_suspend expects to
determine between DDR and SDR. This bug has not been noticed as
the boards seem to have DDR instead of SDR.

Note that some PM patches are still missing. The PM patches will
be added later on once the base files are in sync with linux-omap
tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e7cf1b4..800639e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -14,7 +14,10 @@ obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
 
 # Power Management
-obj-$(CONFIG_PM) += pm.o sleep.o
+ifeq ($(CONFIG_PM),y)
+obj-y					+= pm.o
+obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
+endif
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
diff --git a/arch/arm/mach-omap2/sleep.S b/arch/arm/mach-omap2/sleep24xx.S
similarity index 85%
rename from arch/arm/mach-omap2/sleep.S
rename to arch/arm/mach-omap2/sleep24xx.S
index 87a706f..43336b9 100644
--- a/arch/arm/mach-omap2/sleep.S
+++ b/arch/arm/mach-omap2/sleep24xx.S
@@ -5,6 +5,10 @@
  * Texas Instruments, <www.ti.com>
  * Richard Woodruff <r-woodruff2@ti.com>
  *
+ * (C) Copyright 2006 Nokia Corporation
+ * Fixed idle loop sleep
+ * Igor Stoppa <igor.stoppa@nokia.com>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of
@@ -26,6 +30,8 @@
 #include <mach/io.h>
 #include <mach/pm.h>
 
+#include <mach/omap24xx.h>
+
 #include "sdrc.h"
 
 /* First address of reserved address space?  apparently valid for OMAP2 & 3 */
@@ -52,15 +58,14 @@ ENTRY(omap24xx_idle_loop_suspend_sz)
 	.word	. - omap24xx_idle_loop_suspend
 
 /*
- * omap242x_cpu_suspend() - Forces OMAP into deep sleep state by completing
+ * omap24xx_cpu_suspend() - Forces OMAP into deep sleep state by completing
  * SDRC shutdown then ARM shutdown.  Upon wake MPU is back on so just restore
  * SDRC.
  *
  * Input:
  * R0 :	DLL ctrl value pre-Sleep
- * R1 : Processor+Revision
- *	2420: 0x21 = 242xES1, 0x26 = 242xES2.2
- *	2430: 0x31 = 2430ES1, 0x32 = 2430ES2
+ * R1 : SDRC_DLLA_CTRL
+ * R2 : SDRC_POWER
  *
  * The if the DPLL is going to AutoIdle. It seems like the DPLL may be back on
  * when we get called, but the DLL probably isn't.  We will wait a bit more in
@@ -80,15 +85,14 @@ ENTRY(omap24xx_idle_loop_suspend_sz)
  */
 ENTRY(omap24xx_cpu_suspend)
 	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
-	mov	r3, #0x0		@ clear for mrc call
+	mov	r3, #0x0		@ clear for mcr call
 	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, hope SDR/DDR finished
 	nop
 	nop
-	ldr	r3, A_SDRC_POWER	@ addr of sdrc power
-	ldr	r4, [r3]		@ value of sdrc power
+	ldr	r4, [r2]		@ read SDRC_POWER
 	orr	r4, r4, #0x40		@ enable self refresh on idle req
 	mov	r5, #0x2000		@ set delay (DPLL relock + DLL relock)
-	str	r4, [r3]		@ make it so
+	str	r4, [r2]		@ make it so
 	mov	r2, #0
 	nop
 	mcr	p15, 0, r2, c7, c0, 4	@ wait for interrupt
@@ -97,14 +101,13 @@ loop:
 	subs	r5, r5, #0x1		@ awake, wait just a bit
 	bne	loop
 
-	/* The DPLL has on before we take the DDR out of self refresh */
+	/* The DPLL has to be on before we take the DDR out of self refresh */
 	bic	r4, r4, #0x40		@ now clear self refresh bit.
-	str	r4, [r3]		@ put vlaue back.
+	str	r4, [r2]		@ write to SDRC_POWER
 	ldr	r4, A_SDRC0		@ make a clock happen
-	ldr	r4, [r4]
+	ldr	r4, [r4]		@ read A_SDRC0
 	nop				@ start auto refresh only after clk ok
 	movs	r0, r0			@ see if DDR or SDR
-	ldrne	r1, A_SDRC_DLLA_CTRL_S	@ get addr of DLL ctrl
 	strne	r0, [r1]		@ rewrite DLLA to force DLL reload
 	addne	r1, r1, #0x8		@ move to DLLB
 	strne	r0, [r1]		@ rewrite DLLB to force DLL reload
@@ -116,13 +119,8 @@ loop2:
 	/* resume*/
 	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
 
-A_SDRC_POWER:
-	.word OMAP242X_SDRC_REGADDR(SDRC_POWER)
 A_SDRC0:
 	.word A_SDRC0_V
-A_SDRC_DLLA_CTRL_S:
-	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
 
 ENTRY(omap24xx_cpu_suspend_sz)
 	.word	. - omap24xx_cpu_suspend
-
diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
index 6063e96..768eb6e 100644
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -135,7 +135,8 @@ extern void omap_pm_suspend(void);
 extern void omap730_cpu_suspend(unsigned short, unsigned short);
 extern void omap1510_cpu_suspend(unsigned short, unsigned short);
 extern void omap1610_cpu_suspend(unsigned short, unsigned short);
-extern void omap24xx_cpu_suspend(u32 dll_ctrl, u32 cpu_revision);
+extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
+					void __iomem *sdrc_power);
 extern void omap730_idle_loop_suspend(void);
 extern void omap1510_idle_loop_suspend(void);
 extern void omap1610_idle_loop_suspend(void);
