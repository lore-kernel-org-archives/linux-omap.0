From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 1/2] OMAP1/2/3/4: DEBUG_LL run time detection
Date: Fri, 18 Sep 2009 19:39:39 -0500
Message-ID: <1253320780-19396-2-git-send-email-vikram.pandita@ti.com>
References: <1253320780-19396-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39731 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbZISAoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 20:44:32 -0400
In-Reply-To: <1253320780-19396-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>

This patch cleans up the DEBUG_LL infrastructure for omap boards.

The decision of finding the physical address of debug uart is done
at runtime now, making possible to use a single defconfig for multiple boards.

This patch gets rid of  menuconfig options of choosing low level debug uarts.

Changes are:
Implement dynamic uart detection functions in a new file:
	arch/arm/plat-omap/debug-low-level.c
	Functions:
	get_uart_base()		Returns debug uart physical address
	get_uart_virt_base()	Returns debug uart virtual address
	get_uart_shift()	Returns debug uart register shift

The same functions get used in the uncompressing stage of kernel
as well as for debug low level functions of kernel

Following comments from Russell King have been incorporated:
http://marc.info/?l=linux-arm-kernel&m=125321699528719&w=2

Changes have been tested on:
	SDP3430: UART1
	Zoom1: UART3
	Beagle: UART3
	Zoom2: External Uart

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-zoom-debugboard.c   |    5 +-
 arch/arm/plat-omap/Kconfig                    |   16 ---
 arch/arm/plat-omap/Makefile                   |    2 +-
 arch/arm/plat-omap/debug-low-level.c          |  123 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/debug-macro.S |   60 +++++--------
 arch/arm/plat-omap/include/mach/uncompress.h  |   27 +++---
 6 files changed, 164 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm/plat-omap/debug-low-level.c

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 1f13e2a..70a4bba 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -82,9 +82,10 @@ static inline void __init zoom2_init_smsc911x(void)
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.mapbase	= 0x10000000,
+		.membase	= IOMEM(ZOOM2_EXT_QUART_VIRT),
+		.mapbase	= ZOOM2_EXT_QUART_PHYS,
 		.irq		= OMAP_GPIO_IRQ(102),
-		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ,
+		.flags		= UPF_BOOT_AUTOCONF|UPF_SHARE_IRQ,
 		.irqflags	= IRQF_SHARED | IRQF_TRIGGER_RISING,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 64b3f52..dc00780 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -162,22 +162,6 @@ config OMAP_DM_TIMER
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
 
-choice
-	prompt "Low-level debug console UART"
-	depends on ARCH_OMAP
-	default OMAP_LL_DEBUG_UART1
-
-config OMAP_LL_DEBUG_UART1
-	bool "UART1"
-
-config OMAP_LL_DEBUG_UART2
-	bool "UART2"
-
-config OMAP_LL_DEBUG_UART3
-	bool "UART3"
-
-endchoice
-
 config OMAP_SERIAL_WAKE
 	bool "Enable wake-up events for serial ports"
 	depends on ARCH_OMAP1 && OMAP_MUX
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 98f0191..e205a06 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
-	 usb.o fb.o io.o
+	 usb.o fb.o io.o debug-low-level.o
 obj-m :=
 obj-n :=
 obj-  :=
diff --git a/arch/arm/plat-omap/debug-low-level.c b/arch/arm/plat-omap/debug-low-level.c
new file mode 100644
index 0000000..c134694
--- /dev/null
+++ b/arch/arm/plat-omap/debug-low-level.c
@@ -0,0 +1,123 @@
+/*
+ * Common debug-low-level.c file
+ * This file is created by Vikram Pandita <vikram.pandita@ti.com>
+ *
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/types.h>
+#include <asm/mach-types.h>
+
+u32 get_uart_base(void)
+{
+	static u32  omap_uart_debug_ll_phy_addr;
+
+	if (omap_uart_debug_ll_phy_addr)
+		return omap_uart_debug_ll_phy_addr;
+
+	/* Add logic here for new platforms, using __machine_arch_type */
+
+	/* TODO: REVISIT -- Check Completeness
+	 * DEFINE PHY ADDRESS for EACH BOARD HERE: omap1/2/3/4 */
+#if defined(CONFIG_ARCH_OMAP1)
+	switch (__machine_arch_type) {
+	case MACH_TYPE_OMAP_PALMTT:
+	case MACH_TYPE_SX1:
+		/* UART2 */
+		omap_uart_debug_ll_phy_addr = (u32 *)0xfffb0800;
+	break;
+	default:
+			/* UART1 */
+		omap_uart_debug_ll_phy_addr = (u32 *)0xfffb0000;
+	break;
+	}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2)
+	switch (__machine_arch_type) {
+	case MACH_TYPE_NOKIA_N800:
+	case MACH_TYPE_NOKIA_N810:
+	case MACH_TYPE_NOKIA_N810_WIMAX:
+		/* UART3 */
+		omap_uart_debug_ll_phy_addr = (u32 *)0x4806e000;
+	break;
+	default:
+		/* UART1 */
+		omap_uart_debug_ll_phy_addr = (u32 *)0x4806a000;
+	break;
+	}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP3)
+	switch (__machine_arch_type) {
+	case MACH_TYPE_OMAP_LDP:
+	case MACH_TYPE_OVERO:
+	case MACH_TYPE_OMAP3_PANDORA:
+	case MACH_TYPE_NOKIA_RX51:
+	case MACH_TYPE_OMAP3_BEAGLE:
+		/* UART3 */
+		omap_uart_debug_ll_phy_addr = 0x49020000;
+	break;
+	case MACH_TYPE_OMAP_ZOOM2:
+		/* EXTERNEL UART */
+		omap_uart_debug_ll_phy_addr = 0x10000000;
+	break;
+	default:
+		/* UART1 */
+		omap_uart_debug_ll_phy_addr = 0x4806a000;
+	break;
+	}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+	switch (__machine_arch_type) {
+	/* OMAP3: UART1 */
+	case MACH_TYPE_OMAP_4430SDP:
+	default:
+		omap_uart_debug_ll_phy_addr = (u32 *)0x4806a000;
+	break;
+	}
+#endif
+
+	return omap_uart_debug_ll_phy_addr;
+}
+
+u32 get_uart_virt_base(void)
+{
+	u32 val = 0;
+
+#ifdef CONFIG_ARCH_OMAP1
+	/* omap1 */
+	val = 0xfef00000;
+#else
+	/* omap2/3/4... */
+	if (MACH_TYPE_OMAP_ZOOM2 == __machine_arch_type)
+		val = 0xFB000000 | get_uart_base(); /* ZOOM2_EXT_QUART_VIRT */
+	else
+		val = 0xd8000000 | get_uart_base();
+#endif
+
+	return val;
+}
+
+u8 get_uart_shift(void)
+{
+	u8 shift = 0;
+#ifdef CONFIG_ARCH_OMAP1
+	/* omap1 */
+	shift = 0;
+#else
+	shift = 2;
+	if (MACH_TYPE_OMAP_ZOOM2 == __machine_arch_type) {
+		/* External UART has a shift=1 requirement
+		* Internal OMAP UARTs have shift=2 requirement
+		*/
+		shift = 1;
+	}
+#endif
+
+	return shift;
+}
diff --git a/arch/arm/plat-omap/include/mach/debug-macro.S b/arch/arm/plat-omap/include/mach/debug-macro.S
index ac24050..548fcd4 100644
--- a/arch/arm/plat-omap/include/mach/debug-macro.S
+++ b/arch/arm/plat-omap/include/mach/debug-macro.S
@@ -12,42 +12,20 @@
 */
 
 		.macro	addruart,rx
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-#ifdef CONFIG_ARCH_OMAP1
-		moveq	\rx, #0xff000000	@ physical base address
-		movne	\rx, #0xfe000000	@ virtual base
-		orr	\rx, \rx, #0x00fb0000
-#ifdef CONFIG_OMAP_LL_DEBUG_UART3
-		orr	\rx, \rx, #0x00009000	@ UART 3
-#endif
-#if defined(CONFIG_OMAP_LL_DEBUG_UART2) || defined(CONFIG_OMAP_LL_DEBUG_UART3)
-		orr	\rx, \rx, #0x00000800	@ UART 2 & 3
-#endif
-
-#elif  CONFIG_ARCH_OMAP2
-		moveq	\rx, #0x48000000	@ physical base address
-		movne	\rx, #0xd8000000	@ virtual base
-		orr	\rx, \rx, #0x0006a000
-#ifdef CONFIG_OMAP_LL_DEBUG_UART2
-		add	\rx, \rx, #0x00002000	@ UART 2
-#endif
-#ifdef CONFIG_OMAP_LL_DEBUG_UART3
-		add	\rx, \rx, #0x00004000	@ UART 3
-#endif
-
-#elif defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-		moveq	\rx, #0x48000000	@ physical base address
-		movne	\rx, #0xd8000000	@ virtual base
-		orr	\rx, \rx, #0x0006a000
-#ifdef CONFIG_OMAP_LL_DEBUG_UART2
-		add	\rx, \rx, #0x00002000	@ UART 2
-#endif
-#ifdef CONFIG_OMAP_LL_DEBUG_UART3
-		add	\rx, \rx, #0x00fb0000	@ UART 3
-		add	\rx, \rx, #0x00006000
-#endif
-#endif
+		mrc	p15, 0, r2, c1, c0
+		tst	r2, #1			@ MMU enabled?
+		bne	1110f
+		push	{r0, r1, r2, lr}
+		bl	get_uart_base
+		mov	\rx, r0
+		pop	{r0, r1, r2, lr}
+		b 1111f
+1110:
+		push	{r0, r1, r2, lr}
+		bl	get_uart_virt_base
+		mov	\rx, r0
+		pop	{r0, r1, r2, lr}
+1111:
 		.endm
 
 		.macro	senduart,rd,rx
@@ -55,13 +33,21 @@
 		.endm
 
 		.macro	busyuart,rd,rx
-1001:		ldrb	\rd, [\rx, #(0x5 << 2)]	@ OMAP-1510 and friends
+1001:
+		mov	\rd, #5
+		push	{r0, \rx, lr}
+		bl	get_uart_shift
+		mov	\rd, \rd, lsl r0
+		pop	{r0, \rx, lr}
+		ldrb	\rd, [\rx, \rd]
 		and	\rd, \rd, #0x60
 		teq	\rd, #0x60
+#ifdef CONFIG_ARCH_OMAP1
 		beq	1002f
 		ldrb	\rd, [\rx, #(0x5 << 0)]	@ OMAP-730 only
 		and	\rd, \rd, #0x60
 		teq	\rd, #0x60
+#endif
 		bne	1001b
 1002:
 		.endm
diff --git a/arch/arm/plat-omap/include/mach/uncompress.h b/arch/arm/plat-omap/include/mach/uncompress.h
index 0814c5f..bbb8dbe 100644
--- a/arch/arm/plat-omap/include/mach/uncompress.h
+++ b/arch/arm/plat-omap/include/mach/uncompress.h
@@ -20,8 +20,8 @@
 #include <linux/types.h>
 #include <linux/serial_reg.h>
 #include <mach/serial.h>
-
-unsigned int system_rev;
+#include <asm/mach-types.h>
+#include "../../debug-low-level.c"
 
 #define UART_OMAP_MDR1		0x08	/* mode definition register */
 #define OMAP_ID_730		0x355F
@@ -29,23 +29,20 @@ unsigned int system_rev;
 #define check_port(base, shift) ((base[UART_OMAP_MDR1 << shift] & 7) == 0)
 #define omap_get_id() ((*(volatile unsigned int *)(0xfffed404)) >> 12) & ID_MASK
 
+static volatile u8 *uart;
+
 static void putc(int c)
 {
-	volatile u8 * uart = 0;
 	int shift = 2;
 
 #ifdef CONFIG_MACH_OMAP_PALMTE
 	return;
 #endif
 
-#ifdef CONFIG_ARCH_OMAP
-#ifdef	CONFIG_OMAP_LL_DEBUG_UART3
-	uart = (volatile u8 *)(OMAP_UART3_BASE);
-#elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
-	uart = (volatile u8 *)(OMAP_UART2_BASE);
-#else
-	uart = (volatile u8 *)(OMAP_UART1_BASE);
-#endif
+	if (!uart)
+		return;
+
+	shift = get_uart_shift();
 
 #ifdef CONFIG_ARCH_OMAP1
 	/* Determine which serial port to use */
@@ -62,7 +59,6 @@ static void putc(int c)
 		return;
 	} while (0);
 #endif /* CONFIG_ARCH_OMAP1 */
-#endif
 
 	/*
 	 * Now, xmit each character
@@ -76,8 +72,13 @@ static inline void flush(void)
 {
 }
 
+static inline void __arch_decomp_setup(void)
+{
+	uart = (u8 *)get_uart_base();
+}
+
 /*
  * nothing to do
  */
-#define arch_decomp_setup()
+#define arch_decomp_setup()	__arch_decomp_setup()
 #define arch_decomp_wdog()
-- 
1.6.5.rc0

