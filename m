From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/14] ARM: OMAP: Split sleep24xx.S into sleep242x.S and sleep243x.S
Date: Tue, 27 May 2008 21:20:11 -0700
Message-ID: <1211948418-16455-8-git-send-email-tony@atomide.com>
References: multi-omap-2008-05-27-212014
 <1211948418-16455-1-git-send-email-tony@atomide.com>
 <1211948418-16455-2-git-send-email-tony@atomide.com>
 <1211948418-16455-3-git-send-email-tony@atomide.com>
 <1211948418-16455-4-git-send-email-tony@atomide.com>
 <1211948418-16455-5-git-send-email-tony@atomide.com>
 <1211948418-16455-6-git-send-email-tony@atomide.com>
 <1211948418-16455-7-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:49672 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbYE1EUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 00:20:31 -0400
In-Reply-To: <1211948418-16455-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Split sleep24xx.S into sleep242x.S and sleep243x.S. This is easier
to follow than rewriting the registers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile    |   13 ++--
 arch/arm/mach-omap2/pm24xx.c    |   30 ++++-----
 arch/arm/mach-omap2/sleep242x.S |  131 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sleep243x.S |  131 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sleep24xx.S |  133 ---------------------------------------
 include/asm-arm/arch-omap/pm.h  |   12 +++-
 6 files changed, 289 insertions(+), 161 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sleep242x.S
 create mode 100644 arch/arm/mach-omap2/sleep243x.S
 delete mode 100644 arch/arm/mach-omap2/sleep24xx.S

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b617b66..db82eb1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -14,15 +14,14 @@ obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 # Power Management
 obj-$(CONFIG_PM) += pm.o
 
-ifeq ($(CONFIG_ARCH_OMAP2),y)
-obj-$(CONFIG_PM) += pm24xx.o sleep24xx.o
+ifeq ($(CONFIG_PM),y)
+obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
+obj-$(CONFIG_ARCH_OMAP2420)		+= sleep242x.o
+obj-$(CONFIG_ARCH_OMAP2430)		+= sleep243x.o
+obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
+obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 endif
 
-ifeq ($(CONFIG_ARCH_OMAP3),y)
-obj-$(CONFIG_PM) += pm34xx.o sleep34xx.o
-endif
-obj-$(CONFIG_PM_DEBUG) += pm-debug.o
-
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 787a95e..aab079e 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -52,10 +52,6 @@
 #include "sdrc.h"
 #include "pm.h"
 
-/* These addrs are in assembly language code to be patched at runtime */
-extern void *omap2_ocs_sdrc_power;
-extern void *omap2_ocs_sdrc_dlla_ctrl;
-
 static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(void __iomem *dllctrl);
 static void (*saved_idle)(void);
@@ -495,19 +491,19 @@ int __init omap2_pm_init(void)
 	 * These routines need to be in SRAM as that's the only
 	 * memory the MPU can see when it wakes up.
 	 */
-	omap2_sram_idle = omap_sram_push(omap24xx_idle_loop_suspend,
-					 omap24xx_idle_loop_suspend_sz);
-
-	omap2_sram_suspend = omap_sram_push(omap24xx_cpu_suspend,
-					    omap24xx_cpu_suspend_sz);
-
-	/* Patch in the correct register addresses for multiboot */
-	omap_sram_patch_va(omap24xx_cpu_suspend, &omap2_ocs_sdrc_power,
-			   omap2_sram_suspend,
-			   OMAP_SDRC_REGADDR(SDRC_POWER));
-	omap_sram_patch_va(omap24xx_cpu_suspend, &omap2_ocs_sdrc_dlla_ctrl,
-			   omap2_sram_suspend,
-			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
+	if (cpu_is_omap242x()) {
+		omap2_sram_idle = omap_sram_push(omap242x_idle_loop_suspend,
+						 omap242x_idle_loop_suspend_sz);
+
+		omap2_sram_suspend = omap_sram_push(omap242x_cpu_suspend,
+						    omap242x_cpu_suspend_sz);
+	} else {
+		omap2_sram_idle = omap_sram_push(omap243x_idle_loop_suspend,
+						 omap243x_idle_loop_suspend_sz);
+
+		omap2_sram_suspend = omap_sram_push(omap243x_cpu_suspend,
+						    omap243x_cpu_suspend_sz);
+	}
 
 	suspend_set_ops(&omap_pm_ops);
 	pm_idle = omap2_pm_idle;
diff --git a/arch/arm/mach-omap2/sleep242x.S b/arch/arm/mach-omap2/sleep242x.S
new file mode 100644
index 0000000..33bdd01
--- /dev/null
+++ b/arch/arm/mach-omap2/sleep242x.S
@@ -0,0 +1,131 @@
+/*
+ * linux/arch/arm/mach-omap2/sleep.S
+ *
+ * (C) Copyright 2004
+ * Texas Instruments, <www.ti.com>
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * (C) Copyright 2006 Nokia Corporation
+ * Fixed idle loop sleep
+ * Igor Stoppa <igor.stoppa@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/arch/io.h>
+#include <asm/arch/pm.h>
+
+#include <asm/arch/omap24xx.h>
+
+#include "sdrc.h"
+
+/* First address of reserved address space?  apparently valid for OMAP2 & 3 */
+#define A_SDRC0_V		(0xC0000000)
+
+	.text
+
+/*
+ * Forces OMAP into idle state
+ *
+ * omap242x_idle_loop_suspend() - This bit of code just executes the WFI
+ * for normal idles.
+ *
+ * Note: This code get's copied to internal SRAM at boot. When the OMAP
+ *	 wakes up it continues execution at the point it went to sleep.
+ */
+ENTRY(omap242x_idle_loop_suspend)
+	stmfd	sp!, {r0, lr}		@ save registers on stack
+	mov	r0, #0x0		@ clear for mrc call
+	mcr	p15, 0, r0, c7, c0, 4	@ wait for interrupt
+	ldmfd	sp!, {r0, pc}		@ restore regs and return
+
+ENTRY(omap242x_idle_loop_suspend_sz)
+	.word	. - omap242x_idle_loop_suspend
+
+/*
+ * omap242x_cpu_suspend() - Forces OMAP into deep sleep state by completing
+ * SDRC shutdown then ARM shutdown.  Upon wake MPU is back on so just restore
+ * SDRC.
+ *
+ * Input:
+ * R0 :	DLL ctrl value pre-Sleep
+ *
+ * The if the DPLL is going to AutoIdle. It seems like the DPLL may be back on
+ * when we get called, but the DLL probably isn't.  We will wait a bit more in
+ * case the DPLL isn't quite there yet. The code will wait on DLL for DDR even
+ * if in unlocked mode.
+ *
+ * For less than 242x-ES2.2 upon wake from a sleep mode where the external
+ * oscillator was stopped, a timing bug exists where a non-stabilized 12MHz
+ * clock can pass into the PRCM can cause problems at DSP and IVA.
+ * To work around this the code will switch to the 32kHz source prior to sleep.
+ * Post sleep we will shift back to using the DPLL.  Apparently,
+ * CM_IDLEST_CLKGEN does not reflect the full clock change so you need to wait
+ * 3x12MHz + 3x32kHz clocks for a full switch.
+ *
+ * The DLL load value is not kept in RETENTION or OFF.	It needs to be restored
+ * at wake
+ */
+ENTRY(omap242x_cpu_suspend)
+	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
+	mov	r3, #0x0		@ clear for mrc call
+	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, hope SDR/DDR finished
+	nop
+	nop
+	ldr	r3, omap2_ocs_sdrc_power	@ addr of sdrc power
+	ldr	r4, [r3]		@ value of sdrc power
+	orr	r4, r4, #0x40		@ enable self refresh on idle req
+	mov	r5, #0x2000		@ set delay (DPLL relock + DLL relock)
+	str	r4, [r3]		@ make it so
+	mov	r2, #0
+	nop
+	mcr	p15, 0, r2, c7, c0, 4	@ wait for interrupt
+	nop
+loop:
+	subs	r5, r5, #0x1		@ awake, wait just a bit
+	bne	loop
+
+	/* The DPLL has on before we take the DDR out of self refresh */
+	bic	r4, r4, #0x40		@ now clear self refresh bit.
+	str	r4, [r3]		@ put vlaue back.
+	ldr	r4, A_SDRC0		@ make a clock happen
+	ldr	r4, [r4]
+	nop				@ start auto refresh only after clk ok
+	movs	r0, r0			@ see if DDR or SDR
+	ldrne	r1, omap2_ocs_sdrc_dlla_ctrl	@ get addr of DLL ctrl
+	strne	r0, [r1]		@ rewrite DLLA to force DLL reload
+	addne	r1, r1, #0x8		@ move to DLLB
+	strne	r0, [r1]		@ rewrite DLLB to force DLL reload
+
+	mov	r5, #0x1000
+loop2:
+	subs	r5, r5, #0x1
+	bne	loop2
+	/* resume*/
+	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
+
+omap2_ocs_sdrc_power:
+	.word OMAP242X_SDRC_REGADDR(SDRC_POWER)
+A_SDRC0:
+	.word A_SDRC0_V
+omap2_ocs_sdrc_dlla_ctrl:
+	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
+
+ENTRY(omap242x_cpu_suspend_sz)
+	.word	. - omap242x_cpu_suspend
+
diff --git a/arch/arm/mach-omap2/sleep243x.S b/arch/arm/mach-omap2/sleep243x.S
new file mode 100644
index 0000000..9a2b4b7
--- /dev/null
+++ b/arch/arm/mach-omap2/sleep243x.S
@@ -0,0 +1,131 @@
+/*
+ * linux/arch/arm/mach-omap2/sleep.S
+ *
+ * (C) Copyright 2004
+ * Texas Instruments, <www.ti.com>
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * (C) Copyright 2006 Nokia Corporation
+ * Fixed idle loop sleep
+ * Igor Stoppa <igor.stoppa@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/arch/io.h>
+#include <asm/arch/pm.h>
+
+#include <asm/arch/omap24xx.h>
+
+#include "sdrc.h"
+
+/* First address of reserved address space?  apparently valid for OMAP2 & 3 */
+#define A_SDRC0_V		(0xC0000000)
+
+	.text
+
+/*
+ * Forces OMAP into idle state
+ *
+ * omap243x_idle_loop_suspend() - This bit of code just executes the WFI
+ * for normal idles.
+ *
+ * Note: This code get's copied to internal SRAM at boot. When the OMAP
+ *	 wakes up it continues execution at the point it went to sleep.
+ */
+ENTRY(omap243x_idle_loop_suspend)
+	stmfd	sp!, {r0, lr}		@ save registers on stack
+	mov	r0, #0x0		@ clear for mrc call
+	mcr	p15, 0, r0, c7, c0, 4	@ wait for interrupt
+	ldmfd	sp!, {r0, pc}		@ restore regs and return
+
+ENTRY(omap243x_idle_loop_suspend_sz)
+	.word	. - omap243x_idle_loop_suspend
+
+/*
+ * omap243x_cpu_suspend() - Forces OMAP into deep sleep state by completing
+ * SDRC shutdown then ARM shutdown.  Upon wake MPU is back on so just restore
+ * SDRC.
+ *
+ * Input:
+ * R0 :	DLL ctrl value pre-Sleep
+ *
+ * The if the DPLL is going to AutoIdle. It seems like the DPLL may be back on
+ * when we get called, but the DLL probably isn't.  We will wait a bit more in
+ * case the DPLL isn't quite there yet. The code will wait on DLL for DDR even
+ * if in unlocked mode.
+ *
+ * For less than 242x-ES2.2 upon wake from a sleep mode where the external
+ * oscillator was stopped, a timing bug exists where a non-stabilized 12MHz
+ * clock can pass into the PRCM can cause problems at DSP and IVA.
+ * To work around this the code will switch to the 32kHz source prior to sleep.
+ * Post sleep we will shift back to using the DPLL.  Apparently,
+ * CM_IDLEST_CLKGEN does not reflect the full clock change so you need to wait
+ * 3x12MHz + 3x32kHz clocks for a full switch.
+ *
+ * The DLL load value is not kept in RETENTION or OFF.	It needs to be restored
+ * at wake
+ */
+ENTRY(omap243x_cpu_suspend)
+	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
+	mov	r3, #0x0		@ clear for mrc call
+	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, hope SDR/DDR finished
+	nop
+	nop
+	ldr	r3, omap2_ocs_sdrc_power	@ addr of sdrc power
+	ldr	r4, [r3]		@ value of sdrc power
+	orr	r4, r4, #0x40		@ enable self refresh on idle req
+	mov	r5, #0x2000		@ set delay (DPLL relock + DLL relock)
+	str	r4, [r3]		@ make it so
+	mov	r2, #0
+	nop
+	mcr	p15, 0, r2, c7, c0, 4	@ wait for interrupt
+	nop
+loop:
+	subs	r5, r5, #0x1		@ awake, wait just a bit
+	bne	loop
+
+	/* The DPLL has on before we take the DDR out of self refresh */
+	bic	r4, r4, #0x40		@ now clear self refresh bit.
+	str	r4, [r3]		@ put vlaue back.
+	ldr	r4, A_SDRC0		@ make a clock happen
+	ldr	r4, [r4]
+	nop				@ start auto refresh only after clk ok
+	movs	r0, r0			@ see if DDR or SDR
+	ldrne	r1, omap2_ocs_sdrc_dlla_ctrl	@ get addr of DLL ctrl
+	strne	r0, [r1]		@ rewrite DLLA to force DLL reload
+	addne	r1, r1, #0x8		@ move to DLLB
+	strne	r0, [r1]		@ rewrite DLLB to force DLL reload
+
+	mov	r5, #0x1000
+loop2:
+	subs	r5, r5, #0x1
+	bne	loop2
+	/* resume*/
+	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
+
+omap2_ocs_sdrc_power:
+	.word OMAP243X_SDRC_REGADDR(SDRC_POWER)
+A_SDRC0:
+	.word A_SDRC0_V
+omap2_ocs_sdrc_dlla_ctrl:
+	.word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)
+
+ENTRY(omap243x_cpu_suspend_sz)
+	.word	. - omap243x_cpu_suspend
+
diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sleep24xx.S
deleted file mode 100644
index 3e0a7dc..0000000
--- a/arch/arm/mach-omap2/sleep24xx.S
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/sleep.S
- *
- * (C) Copyright 2004
- * Texas Instruments, <www.ti.com>
- * Richard Woodruff <r-woodruff2@ti.com>
- *
- * (C) Copyright 2006 Nokia Corporation
- * Fixed idle loop sleep
- * Igor Stoppa <igor.stoppa@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-
-#include <linux/linkage.h>
-#include <linux/poison.h>	/* for SRAM_VA_MAGIC */
-#include <asm/assembler.h>
-#include <asm/arch/io.h>
-#include <asm/arch/pm.h>
-
-#include <asm/arch/omap24xx.h>
-
-/* First address of reserved address space?  apparently valid for OMAP2 & 3 */
-#define A_SDRC0_V		(0xC0000000)
-
-	.text
-
-/*
- * Forces OMAP into idle state
- *
- * omap24xx_idle_loop_suspend() - This bit of code just executes the WFI
- * for normal idles.
- *
- * Note: This code get's copied to internal SRAM at boot. When the OMAP
- *	 wakes up it continues execution at the point it went to sleep.
- */
-ENTRY(omap24xx_idle_loop_suspend)
-	stmfd	sp!, {r0, lr}		@ save registers on stack
-	mov	r0, #0x0		@ clear for mrc call
-	mcr	p15, 0, r0, c7, c0, 4	@ wait for interrupt
-	ldmfd	sp!, {r0, pc}		@ restore regs and return
-
-ENTRY(omap24xx_idle_loop_suspend_sz)
-	.word	. - omap24xx_idle_loop_suspend
-
-/*
- * omap242x_cpu_suspend() - Forces OMAP into deep sleep state by completing
- * SDRC shutdown then ARM shutdown.  Upon wake MPU is back on so just restore
- * SDRC.
- *
- * Input:
- * R0 :	DLL ctrl value pre-Sleep
- *
- * The if the DPLL is going to AutoIdle. It seems like the DPLL may be back on
- * when we get called, but the DLL probably isn't.  We will wait a bit more in
- * case the DPLL isn't quite there yet. The code will wait on DLL for DDR even
- * if in unlocked mode.
- *
- * For less than 242x-ES2.2 upon wake from a sleep mode where the external
- * oscillator was stopped, a timing bug exists where a non-stabilized 12MHz
- * clock can pass into the PRCM can cause problems at DSP and IVA.
- * To work around this the code will switch to the 32kHz source prior to sleep.
- * Post sleep we will shift back to using the DPLL.  Apparently,
- * CM_IDLEST_CLKGEN does not reflect the full clock change so you need to wait
- * 3x12MHz + 3x32kHz clocks for a full switch.
- *
- * The DLL load value is not kept in RETENTION or OFF.	It needs to be restored
- * at wake
- */
-ENTRY(omap24xx_cpu_suspend)
-	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
-	mov	r3, #0x0		@ clear for mrc call
-	mcr	p15, 0, r3, c7, c10, 4	@ memory barrier, hope SDR/DDR finished
-	nop
-	nop
-	ldr	r3, omap2_ocs_sdrc_power	@ addr of sdrc power
-	ldr	r4, [r3]		@ value of sdrc power
-	orr	r4, r4, #0x40		@ enable self refresh on idle req
-	mov	r5, #0x2000		@ set delay (DPLL relock + DLL relock)
-	str	r4, [r3]		@ make it so
-	mov	r2, #0
-	nop
-	mcr	p15, 0, r2, c7, c0, 4	@ wait for interrupt
-	nop
-loop:
-	subs	r5, r5, #0x1		@ awake, wait just a bit
-	bne	loop
-
-	/* The DPLL has on before we take the DDR out of self refresh */
-	bic	r4, r4, #0x40		@ now clear self refresh bit.
-	str	r4, [r3]		@ put vlaue back.
-	ldr	r4, A_SDRC0		@ make a clock happen
-	ldr	r4, [r4]
-	nop				@ start auto refresh only after clk ok
-	movs	r0, r0			@ see if DDR or SDR
-	ldrne	r1, omap2_ocs_sdrc_dlla_ctrl	@ get addr of DLL ctrl
-	strne	r0, [r1]		@ rewrite DLLA to force DLL reload
-	addne	r1, r1, #0x8		@ move to DLLB
-	strne	r0, [r1]		@ rewrite DLLB to force DLL reload
-
-	mov	r5, #0x1000
-loop2:
-	subs	r5, r5, #0x1
-	bne	loop2
-	/* resume*/
-	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
-
-	.globl	omap2_ocs_sdrc_power
-	.globl	omap2_ocs_sdrc_dlla_ctrl
-
-omap2_ocs_sdrc_power:
-	.word SRAM_VA_MAGIC
-A_SDRC0:
-	.word A_SDRC0_V
-omap2_ocs_sdrc_dlla_ctrl:
-	.word SRAM_VA_MAGIC
-
-ENTRY(omap24xx_cpu_suspend_sz)
-	.word	. - omap24xx_cpu_suspend
-
diff --git a/include/asm-arm/arch-omap/pm.h b/include/asm-arm/arch-omap/pm.h
index d0c7d4d..bafe109 100644
--- a/include/asm-arm/arch-omap/pm.h
+++ b/include/asm-arm/arch-omap/pm.h
@@ -145,22 +145,26 @@ static inline void omap2_allow_sleep(void) { }
 extern void omap730_cpu_suspend(unsigned short, unsigned short);
 extern void omap1510_cpu_suspend(unsigned short, unsigned short);
 extern void omap1610_cpu_suspend(unsigned short, unsigned short);
-extern void omap24xx_cpu_suspend(u32 dll_ctrl, u32 cpu_revision);
+extern void omap242x_cpu_suspend(u32 dll_ctrl, u32 cpu_revision);
+extern void omap243x_cpu_suspend(u32 dll_ctrl, u32 cpu_revision);
 extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
 extern void omap730_idle_loop_suspend(void);
 extern void omap1510_idle_loop_suspend(void);
 extern void omap1610_idle_loop_suspend(void);
-extern void omap24xx_idle_loop_suspend(void);
+extern void omap242x_idle_loop_suspend(void);
+extern void omap243x_idle_loop_suspend(void);
 
 extern unsigned int omap730_cpu_suspend_sz;
 extern unsigned int omap1510_cpu_suspend_sz;
 extern unsigned int omap1610_cpu_suspend_sz;
-extern unsigned int omap24xx_cpu_suspend_sz;
+extern unsigned int omap242x_cpu_suspend_sz;
+extern unsigned int omap243x_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
 extern unsigned int omap730_idle_loop_suspend_sz;
 extern unsigned int omap1510_idle_loop_suspend_sz;
 extern unsigned int omap1610_idle_loop_suspend_sz;
-extern unsigned int omap24xx_idle_loop_suspend_sz;
+extern unsigned int omap242x_idle_loop_suspend_sz;
+extern unsigned int omap243x_idle_loop_suspend_sz;
 extern unsigned int omap34xx_suspend_sz;
 
 #ifdef CONFIG_OMAP_SERIAL_WAKE
-- 
1.5.3.6

