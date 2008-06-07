From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/21] ARM: OMAP: SRAM: Move sram-fn.S from plat-omap to mach-omap1
Date: Fri,  6 Jun 2008 18:30:39 -0700
Message-ID: <1212802253-17797-8-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
 <1212802253-17797-3-git-send-email-tony@atomide.com>
 <1212802253-17797-4-git-send-email-tony@atomide.com>
 <1212802253-17797-5-git-send-email-tony@atomide.com>
 <1212802253-17797-6-git-send-email-tony@atomide.com>
 <1212802253-17797-7-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55324 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849AbYFGBbK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:10 -0400
In-Reply-To: <1212802253-17797-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

This file is omap1 specific.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index c06f525..5e9416e 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := io.o id.o clock.o irq.o mux.o serial.o devices.o
+obj-y := io.o id.o sram.o clock.o irq.o mux.o serial.o devices.o
 
 obj-$(CONFIG_OMAP_MPU_TIMER)	+= time.o
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
diff --git a/arch/arm/mach-omap1/sram.S b/arch/arm/mach-omap1/sram.S
new file mode 100644
index 0000000..9e1813c
--- /dev/null
+++ b/arch/arm/mach-omap1/sram.S
@@ -0,0 +1,57 @@
+/*
+ * linux/arch/arm/plat-omap/sram-fn.S
+ *
+ * Functions that need to be run in internal SRAM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/arch/io.h>
+#include <asm/hardware.h>
+
+	.text
+
+/*
+ * Reprograms ULPD and CKCTL.
+ */
+ENTRY(sram_reprogram_clock)
+	stmfd	sp!, {r0 - r12, lr}		@ save registers on stack
+
+	mov	r2, #IO_ADDRESS(DPLL_CTL) & 0xff000000
+	orr	r2, r2, #IO_ADDRESS(DPLL_CTL) & 0x00ff0000
+	orr	r2, r2, #IO_ADDRESS(DPLL_CTL) & 0x0000ff00
+
+	mov	r3, #IO_ADDRESS(ARM_CKCTL) & 0xff000000
+	orr	r3, r3, #IO_ADDRESS(ARM_CKCTL) & 0x00ff0000
+	orr	r3, r3, #IO_ADDRESS(ARM_CKCTL) & 0x0000ff00
+
+	tst	r0, #1 << 4			@ want lock mode?
+	beq	newck				@ nope
+	bic	r0, r0, #1 << 4			@ else clear lock bit
+	strh	r0, [r2]			@ set dpll into bypass mode
+	orr	r0, r0, #1 << 4			@ set lock bit again
+
+newck:
+	strh	r1, [r3]			@ write new ckctl value
+	strh	r0, [r2]			@ write new dpll value
+
+	mov	r4, #0x0700			@ let the clocks settle
+	orr	r4, r4, #0x00ff
+delay:	sub	r4, r4, #1
+	cmp	r4, #0
+	bne	delay
+
+lock:	ldrh	r4, [r2], #0			@ read back dpll value
+	tst	r0, #1 << 4			@ want lock mode?
+	beq	out				@ nope
+	tst	r4, #1 << 0			@ dpll rate locked?
+	beq	lock				@ try again
+
+out:
+	ldmfd	sp!, {r0 - r12, pc}		@ restore regs and return
+ENTRY(sram_reprogram_clock_sz)
+	.word	. - sram_reprogram_clock
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index bc639a3..2c4051c 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := common.o sram.o sram-fn.o clock.o devices.o dma.o mux.o gpio.o \
+obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
 	 usb.o fb.o
 obj-m :=
 obj-n :=
diff --git a/arch/arm/plat-omap/sram-fn.S b/arch/arm/plat-omap/sram-fn.S
deleted file mode 100644
index 9e1813c..0000000
--- a/arch/arm/plat-omap/sram-fn.S
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * linux/arch/arm/plat-omap/sram-fn.S
- *
- * Functions that need to be run in internal SRAM
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/arch/io.h>
-#include <asm/hardware.h>
-
-	.text
-
-/*
- * Reprograms ULPD and CKCTL.
- */
-ENTRY(sram_reprogram_clock)
-	stmfd	sp!, {r0 - r12, lr}		@ save registers on stack
-
-	mov	r2, #IO_ADDRESS(DPLL_CTL) & 0xff000000
-	orr	r2, r2, #IO_ADDRESS(DPLL_CTL) & 0x00ff0000
-	orr	r2, r2, #IO_ADDRESS(DPLL_CTL) & 0x0000ff00
-
-	mov	r3, #IO_ADDRESS(ARM_CKCTL) & 0xff000000
-	orr	r3, r3, #IO_ADDRESS(ARM_CKCTL) & 0x00ff0000
-	orr	r3, r3, #IO_ADDRESS(ARM_CKCTL) & 0x0000ff00
-
-	tst	r0, #1 << 4			@ want lock mode?
-	beq	newck				@ nope
-	bic	r0, r0, #1 << 4			@ else clear lock bit
-	strh	r0, [r2]			@ set dpll into bypass mode
-	orr	r0, r0, #1 << 4			@ set lock bit again
-
-newck:
-	strh	r1, [r3]			@ write new ckctl value
-	strh	r0, [r2]			@ write new dpll value
-
-	mov	r4, #0x0700			@ let the clocks settle
-	orr	r4, r4, #0x00ff
-delay:	sub	r4, r4, #1
-	cmp	r4, #0
-	bne	delay
-
-lock:	ldrh	r4, [r2], #0			@ read back dpll value
-	tst	r0, #1 << 4			@ want lock mode?
-	beq	out				@ nope
-	tst	r4, #1 << 0			@ dpll rate locked?
-	beq	lock				@ try again
-
-out:
-	ldmfd	sp!, {r0 - r12, pc}		@ restore regs and return
-ENTRY(sram_reprogram_clock_sz)
-	.word	. - sram_reprogram_clock
