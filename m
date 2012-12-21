From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/8] ARM: OMAP2+: Remove now obsolete uncompress.h and
 debug-macro.S
Date: Fri, 21 Dec 2012 09:48:24 -0800
Message-ID: <20121221174824.GO21056@atomide.com>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64929 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751136Ab2LURs1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 12:48:27 -0500
Content-Disposition: inline
In-Reply-To: <20121219192354.22098.33408.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

These are no longer needed, we now have to select the
debug_ll port manually. The new multiplatform version of the
debug_ll code is in arch/arm/include/debug/omap2plus.S.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ /dev/null
@@ -1,165 +0,0 @@
-/* arch/arm/mach-omap2/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-
-#include <linux/serial_reg.h>
-
-#include <mach/serial.h>
-
-#define UART_OFFSET(addr)	((addr) & 0x00ffffff)
-
-		.pushsection .data
-omap_uart_phys:	.word	0
-omap_uart_virt:	.word	0
-omap_uart_lsr:	.word	0
-		.popsection
-
-		/*
-		 * Note that this code won't work if the bootloader passes
-		 * a wrong machine ID number in r1. To debug, just hardcode
-		 * the desired UART phys and virt addresses temporarily into
-		 * the omap_uart_phys and omap_uart_virt above.
-		 */
-		.macro	addruart, rp, rv, tmp
-
-		/* Use omap_uart_phys/virt if already configured */
-10:		adr	\rp, 99f		@ get effective addr of 99f
-		ldr	\rv, [\rp]		@ get absolute addr of 99f
-		sub	\rv, \rv, \rp		@ offset between the two
-		ldr	\rp, [\rp, #4]		@ abs addr of omap_uart_phys
-		sub	\tmp, \rp, \rv		@ make it effective
-		ldr	\rp, [\tmp, #0]		@ omap_uart_phys
-		ldr	\rv, [\tmp, #4]		@ omap_uart_virt
-		cmp	\rp, #0			@ is port configured?
-		cmpne	\rv, #0
-		bne	100f			@ already configured
-
-		/* Check the debug UART configuration set in uncompress.h */
-		mov	\rp, pc
-		ldr	\rv, =OMAP_UART_INFO_OFS
-		and	\rp, \rp, #0xff000000
-		ldr	\rp, [\rp, \rv]
-
-		/* Select the UART to use based on the UART1 scratchpad value */
-		cmp	\rp, #0			@ no port configured?
-		beq	21f			@ if none, try to use UART1
-		cmp	\rp, #OMAP2UART1	@ OMAP2/3/4UART1
-		beq	21f			@ configure OMAP2/3/4UART1
-		cmp	\rp, #OMAP2UART2	@ OMAP2/3/4UART2
-		beq	22f			@ configure OMAP2/3/4UART2
-		cmp	\rp, #OMAP2UART3	@ only on 24xx
-		beq	23f			@ configure OMAP2UART3
-		cmp	\rp, #OMAP3UART3	@ only on 34xx
-		beq	33f			@ configure OMAP3UART3
-		cmp	\rp, #OMAP4UART3	@ only on 44xx/54xx
-		beq	43f			@ configure OMAP4/5UART3
-		cmp	\rp, #OMAP3UART4	@ only on 36xx
-		beq	34f			@ configure OMAP3UART4
-		cmp	\rp, #OMAP4UART4	@ only on 44xx/54xx
-		beq	44f			@ configure OMAP4/5UART4
-		cmp	\rp, #TI81XXUART1	@ ti81Xx UART offsets different
-		beq	81f			@ configure UART1
-		cmp	\rp, #TI81XXUART2	@ ti81Xx UART offsets different
-		beq	82f			@ configure UART2
-		cmp	\rp, #TI81XXUART3	@ ti81Xx UART offsets different
-		beq	83f			@ configure UART3
-		cmp	\rp, #AM33XXUART1	@ AM33XX UART offsets different
-		beq	84f			@ configure UART1
-		cmp	\rp, #ZOOM_UART		@ only on zoom2/3
-		beq	95f			@ configure ZOOM_UART
-
-		/* Configure the UART offset from the phys/virt base */
-21:		mov	\rp, #UART_OFFSET(OMAP2_UART1_BASE)	@ omap2/3/4
-		b	98f
-22:		mov	\rp, #UART_OFFSET(OMAP2_UART2_BASE)	@ omap2/3/4
-		b	98f
-23:		mov	\rp, #UART_OFFSET(OMAP2_UART3_BASE)
-		b	98f
-33:		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
-		add	\rp, \rp, #0x00fb0000
-		add	\rp, \rp, #0x00006000		@ OMAP3_UART3_BASE
-		b	98f
-34:		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
-		add	\rp, \rp, #0x00fb0000
-		add	\rp, \rp, #0x00028000		@ OMAP3_UART4_BASE
-		b	98f
-43:		mov	\rp, #UART_OFFSET(OMAP4_UART3_BASE)
-		b	98f
-44:		mov	\rp, #UART_OFFSET(OMAP4_UART4_BASE)
-		b	98f
-81:		mov	\rp, #UART_OFFSET(TI81XX_UART1_BASE)
-		b	98f
-82:		mov	\rp, #UART_OFFSET(TI81XX_UART2_BASE)
-		b	98f
-83:		mov	\rp, #UART_OFFSET(TI81XX_UART3_BASE)
-		b	98f
-84:		ldr	\rp, =AM33XX_UART1_BASE
-		and	\rp, \rp, #0x00ffffff
-		b	97f
-95:		ldr	\rp, =ZOOM_UART_BASE
-		str	\rp, [\tmp, #0]		@ omap_uart_phys
-		ldr	\rp, =ZOOM_UART_VIRT
-		str	\rp, [\tmp, #4]		@ omap_uart_virt
-		mov	\rp, #(UART_LSR << ZOOM_PORT_SHIFT)
-		str	\rp, [\tmp, #8]		@ omap_uart_lsr
-		b	10b
-
-		/* AM33XX: Store both phys and virt address for the uart */
-97:		add	\rp, \rp, #0x44000000	@ phys base
-		str	\rp, [\tmp, #0]		@ omap_uart_phys
-		sub	\rp, \rp, #0x44000000	@ phys base
-		add	\rp, \rp, #0xf9000000	@ virt base
-		str	\rp, [\tmp, #4]		@ omap_uart_virt
-		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
-		str	\rp, [\tmp, #8]		@ omap_uart_lsr
-
-		b	10b
-
-		/* Store both phys and virt address for the uart */
-98:		add	\rp, \rp, #0x48000000	@ phys base
-		str	\rp, [\tmp, #0]		@ omap_uart_phys
-		sub	\rp, \rp, #0x48000000	@ phys base
-		add	\rp, \rp, #0xfa000000	@ virt base
-		str	\rp, [\tmp, #4]		@ omap_uart_virt
-		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
-		str	\rp, [\tmp, #8]		@ omap_uart_lsr
-
-		b	10b
-
-		.align
-99:		.word	.
-		.word	omap_uart_phys
-		.ltorg
-
-100:		/* Pass the UART_LSR reg address */
-		ldr	\tmp, [\tmp, #8]	@ omap_uart_lsr
-		add	\rp, \rp, \tmp
-		add	\rv, \rv, \tmp
-		.endm
-
-		.macro	senduart,rd,rx
-		orr	\rd, \rd, \rx, lsl #24	@ preserve LSR reg offset
-		bic	\rx, \rx, #0xff		@ get base (THR) reg address
-		strb	\rd, [\rx]		@ send lower byte of rd
-		orr	\rx, \rx, \rd, lsr #24	@ restore original rx (LSR)
-		bic	\rd, \rd, #(0xff << 24)	@ restore original rd
-		.endm
-
-		.macro	busyuart,rd,rx
-1001:		ldrb	\rd, [\rx]		@ rx contains UART_LSR address
-		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-		bne	1001b
-		.endm
-
-		.macro	waituart,rd,rx
-		.endm
--- a/arch/arm/mach-omap2/include/mach/serial.h
+++ b/arch/arm/mach-omap2/include/mach/serial.h
@@ -8,20 +8,6 @@
  * GNU General Public License for more details.
  */
 
-/*
- * Memory entry used for the DEBUG_LL UART configuration, relative to
- * start of RAM. See also uncompress.h and debug-macro.S.
- *
- * Note that using a memory location for storing the UART configuration
- * has at least two limitations:
- *
- * 1. Kernel uncompress code cannot overlap OMAP_UART_INFO as the
- *    uncompress code could then partially overwrite itself
- * 2. We assume printascii is called at least once before paging_init,
- *    and addruart has a chance to read OMAP_UART_INFO
- */
-#define OMAP_UART_INFO_OFS	0x3ffc
-
 /* OMAP2 serial ports */
 #define OMAP2_UART1_BASE	0x4806a000
 #define OMAP2_UART2_BASE	0x4806c000
@@ -68,29 +54,6 @@
 
 #define OMAP24XX_BASE_BAUD	(48000000/16)
 
-/*
- * DEBUG_LL port encoding stored into the UART1 scratchpad register by
- * decomp_setup in uncompress.h
- */
-#define OMAP2UART1		21
-#define OMAP2UART2		22
-#define OMAP2UART3		23
-#define OMAP3UART1		OMAP2UART1
-#define OMAP3UART2		OMAP2UART2
-#define OMAP3UART3		33
-#define OMAP3UART4		34		/* Only on 36xx */
-#define OMAP4UART1		OMAP2UART1
-#define OMAP4UART2		OMAP2UART2
-#define OMAP4UART3		43
-#define OMAP4UART4		44
-#define TI81XXUART1		81
-#define TI81XXUART2		82
-#define TI81XXUART3		83
-#define AM33XXUART1		84
-#define OMAP5UART3		OMAP4UART3
-#define OMAP5UART4		OMAP4UART4
-#define ZOOM_UART		95		/* Only on zoom2/3 */
-
 #ifndef __ASSEMBLER__
 
 struct omap_board_data;
--- a/arch/arm/mach-omap2/include/mach/uncompress.h
+++ /dev/null
@@ -1,176 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/uncompress.h
- *
- * Serial port stubs for kernel decompress status messages
- *
- * Initially based on:
- * linux-2.4.15-rmk1-dsplinux1.6/arch/arm/plat-omap/include/mach1510/uncompress.h
- * Copyright (C) 2000 RidgeRun, Inc.
- * Author: Greg Lonnon <glonnon@ridgerun.com>
- *
- * Rewritten by:
- * Author: <source@mvista.com>
- * 2004 (c) MontaVista Software, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/types.h>
-#include <linux/serial_reg.h>
-
-#include <asm/memory.h>
-#include <asm/mach-types.h>
-
-#include <mach/serial.h>
-
-#define MDR1_MODE_MASK			0x07
-
-volatile u8 *uart_base;
-int uart_shift;
-
-/*
- * Store the DEBUG_LL uart number into memory.
- * See also debug-macro.S, and serial.c for related code.
- */
-static void set_omap_uart_info(unsigned char port)
-{
-	/*
-	 * Get address of some.bss variable and round it down
-	 * a la CONFIG_AUTO_ZRELADDR.
-	 */
-	u32 ram_start = (u32)&uart_shift & 0xf8000000;
-	u32 *uart_info = (u32 *)(ram_start + OMAP_UART_INFO_OFS);
-	*uart_info = port;
-}
-
-static void putc(int c)
-{
-	if (!uart_base)
-		return;
-
-	/* Check for UART 16x mode */
-	if ((uart_base[UART_OMAP_MDR1 << uart_shift] & MDR1_MODE_MASK) != 0)
-		return;
-
-	while (!(uart_base[UART_LSR << uart_shift] & UART_LSR_THRE))
-		barrier();
-	uart_base[UART_TX << uart_shift] = c;
-}
-
-static inline void flush(void)
-{
-}
-
-/*
- * Macros to configure UART1 and debug UART
- */
-#define _DEBUG_LL_ENTRY(mach, dbg_uart, dbg_shft, dbg_id)		\
-	if (machine_is_##mach()) {					\
-		uart_base = (volatile u8 *)(dbg_uart);			\
-		uart_shift = (dbg_shft);				\
-		port = (dbg_id);					\
-		set_omap_uart_info(port);				\
-		break;							\
-	}
-
-#define DEBUG_LL_OMAP2(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP2_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP2UART##p)
-
-#define DEBUG_LL_OMAP3(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP3_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP3UART##p)
-
-#define DEBUG_LL_OMAP4(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP4UART##p)
-
-#define DEBUG_LL_OMAP5(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP5_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP5UART##p)
-/* Zoom2/3 shift is different for UART1 and external port */
-#define DEBUG_LL_ZOOM(mach)						\
-	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
-
-#define DEBUG_LL_TI81XX(p, mach)					\
-	_DEBUG_LL_ENTRY(mach, TI81XX_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		TI81XXUART##p)
-
-#define DEBUG_LL_AM33XX(p, mach)					\
-	_DEBUG_LL_ENTRY(mach, AM33XX_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		AM33XXUART##p)
-
-static inline void arch_decomp_setup(void)
-{
-	int port = 0;
-
-	/*
-	 * Initialize the port based on the machine ID from the bootloader.
-	 * Note that we're using macros here instead of switch statement
-	 * as machine_is functions are optimized out for the boards that
-	 * are not selected.
-	 */
-	do {
-		/* omap2 based boards using UART1 */
-		DEBUG_LL_OMAP2(1, omap_2430sdp);
-		DEBUG_LL_OMAP2(1, omap_apollon);
-		DEBUG_LL_OMAP2(1, omap_h4);
-
-		/* omap2 based boards using UART3 */
-		DEBUG_LL_OMAP2(3, nokia_n800);
-		DEBUG_LL_OMAP2(3, nokia_n810);
-		DEBUG_LL_OMAP2(3, nokia_n810_wimax);
-
-		/* omap3 based boards using UART1 */
-		DEBUG_LL_OMAP2(1, omap3evm);
-		DEBUG_LL_OMAP3(1, omap_3430sdp);
-		DEBUG_LL_OMAP3(1, omap_3630sdp);
-		DEBUG_LL_OMAP3(1, omap3530_lv_som);
-		DEBUG_LL_OMAP3(1, omap3_torpedo);
-
-		/* omap3 based boards using UART3 */
-		DEBUG_LL_OMAP3(3, cm_t35);
-		DEBUG_LL_OMAP3(3, cm_t3517);
-		DEBUG_LL_OMAP3(3, cm_t3730);
-		DEBUG_LL_OMAP3(3, craneboard);
-		DEBUG_LL_OMAP3(3, devkit8000);
-		DEBUG_LL_OMAP3(3, igep0020);
-		DEBUG_LL_OMAP3(3, igep0030);
-		DEBUG_LL_OMAP3(3, nokia_rm680);
-		DEBUG_LL_OMAP3(3, nokia_rm696);
-		DEBUG_LL_OMAP3(3, nokia_rx51);
-		DEBUG_LL_OMAP3(3, omap3517evm);
-		DEBUG_LL_OMAP3(3, omap3_beagle);
-		DEBUG_LL_OMAP3(3, omap3_pandora);
-		DEBUG_LL_OMAP3(3, omap_ldp);
-		DEBUG_LL_OMAP3(3, overo);
-		DEBUG_LL_OMAP3(3, touchbook);
-
-		/* omap4 based boards using UART3 */
-		DEBUG_LL_OMAP4(3, omap_4430sdp);
-		DEBUG_LL_OMAP4(3, omap4_panda);
-
-		/* omap5 based boards using UART3 */
-		DEBUG_LL_OMAP5(3, omap5_sevm);
-
-		/* zoom2/3 external uart */
-		DEBUG_LL_ZOOM(omap_zoom2);
-		DEBUG_LL_ZOOM(omap_zoom3);
-
-		/* TI8168 base boards using UART3 */
-		DEBUG_LL_TI81XX(3, ti8168evm);
-
-		/* TI8148 base boards using UART1 */
-		DEBUG_LL_TI81XX(1, ti8148evm);
-
-		/* AM33XX base boards using UART1 */
-		DEBUG_LL_AM33XX(1, am335xevm);
-	} while (0);
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_wdog()
