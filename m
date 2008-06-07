From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/16] ARM: OMAP2: Split sleep.S into sleep242x.S and sleep243x.S
Date: Fri,  6 Jun 2008 19:12:28 -0700
Message-ID: <1212804762-18413-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56622 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYFGCMo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 22:12:44 -0400
In-Reply-To: 1212803277-18007-1-git-send-email-tony@atomide.com
References: 1212803277-18007-1-git-send-email-tony@atomide.com
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Some register offsets are different for 242x and 243x. This
will allow compiling sleep code for both chips into the same
kernel.

Note that some PM patches are still missing. The PM patches will
be added later on once the base files are in sync with linux-omap
tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e7cf1b4..4e84673 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -14,7 +14,11 @@ obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
 
 # Power Management
-obj-$(CONFIG_PM) += pm.o sleep.o
+ifeq ($(CONFIG_PM),y)
+obj-y					+= pm.o
+obj-$(CONFIG_ARCH_OMAP2420)		+= sleep242x.o
+obj-$(CONFIG_ARCH_OMAP2430)		+= sleep243x.o
+endif
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
diff --git a/arch/arm/mach-omap2/sleep.S b/arch/arm/mach-omap2/sleep.S
deleted file mode 100644
index 46ccb9b..0000000
--- a/arch/arm/mach-omap2/sleep.S
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/sleep.S
- *
- * (C) Copyright 2004
- * Texas Instruments, <www.ti.com>
- * Richard Woodruff <r-woodruff2@ti.com>
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
-#include <asm/assembler.h>
-#include <asm/arch/io.h>
-#include <asm/arch/pm.h>
-
-#include "sdrc.h"
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
-	mov	r0, #0			@ clear for mcr setup
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
- * R1 : Processor+Revision
- *	2420: 0x21 = 242xES1, 0x26 = 242xES2.2
- *	2430: 0x31 = 2430ES1, 0x32 = 2430ES2
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
-	ldr	r3, A_SDRC_POWER	@ addr of sdrc power
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
-	ldrne	r1, A_SDRC_DLLA_CTRL_S	@ get addr of DLL ctrl
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
-A_SDRC_POWER:
-	.word OMAP242X_SDRC_REGADDR(SDRC_POWER)
-A_SDRC0:
-	.word A_SDRC0_V
-A_SDRC_DLLA_CTRL_S:
-	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
-
-ENTRY(omap24xx_cpu_suspend_sz)
-	.word	. - omap24xx_cpu_suspend
-
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
diff --git a/include/asm-arm/arch-omap/pm.h b/include/asm-arm/arch-omap/pm.h
index 1458805..fc72584 100644
--- a/include/asm-arm/arch-omap/pm.h
+++ b/include/asm-arm/arch-omap/pm.h
@@ -135,20 +135,24 @@ extern void omap_pm_suspend(void);
 extern void omap730_cpu_suspend(unsigned short, unsigned short);
 extern void omap1510_cpu_suspend(unsigned short, unsigned short);
 extern void omap1610_cpu_suspend(unsigned short, unsigned short);
-extern void omap24xx_cpu_suspend(u32 dll_ctrl, u32 cpu_revision);
+extern void omap242x_cpu_suspend(u32 dll_ctrl, u32 cpu_revision);
+extern void omap243x_cpu_suspend(u32 dll_ctrl, u32 cpu_revision);
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
 extern unsigned int omap730_idle_loop_suspend_sz;
 extern unsigned int omap1510_idle_loop_suspend_sz;
 extern unsigned int omap1610_idle_loop_suspend_sz;
-extern unsigned int omap24xx_idle_loop_suspend_sz;
+extern unsigned int omap242x_idle_loop_suspend_sz;
+extern unsigned int omap243x_idle_loop_suspend_sz;
 
 #ifdef CONFIG_OMAP_SERIAL_WAKE
 extern void omap_serial_wake_trigger(int enable);
