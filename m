From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] omap: Combine debug-macro.S for omap1 and omap2+
Date: Thu, 03 Feb 2011 17:27:12 -0800
Message-ID: <20110204012712.26410.70158.stgit@baageli.muru.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20952 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab1BDB11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:27:27 -0500
In-Reply-To: <20110204012317.26410.55157.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Now the DEBUG_LL code is the same for all omaps.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/debug-macro.S |  140 -------------
 arch/arm/mach-omap2/include/mach/debug-macro.S |  191 ------------------
 arch/arm/plat-omap/include/plat/debug-macro.S  |  257 ++++++++++++++++++++++++
 3 files changed, 259 insertions(+), 329 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/debug-macro.S

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index bae924e..fbf6f34 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -11,142 +11,4 @@
  *
 */
 
-#include <linux/serial_reg.h>
-
-#include <asm/memory.h>
-#include <asm/mach-types.h>
-
-#include <plat/io.h>
-#include <plat/serial.h>
-
-#define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
-
-		/*
-		 * Intialize the debug serial port based on machine ID
-		 */
-		.macro	inituart, id, a, v
-		mrc	p15, 0, \a, c1, c0
-		tst	\a, #1			@ MMU enabled?
-#ifdef CONFIG_AUTO_ZRELADDR
-		ldreq	\a, =omap_uart_phys
-		biceq	\a, \a, #0xf8000000	@ clear top bits of virt addr
-		moveq	\v, pc			@ copy pc
-		andeq	\v, \v, #0xf8000000	@ clear lower bits
-		orreq	\a, \v			@ combile to get phys addr
-#else
-		ldreq	\a, =omap_uart_v2p(omap_uart_phys)
-#endif
-		ldrne	\a, =omap_uart_phys
-		mov	\v, #(UART_LSR << OMAP_PORT_SHIFT)
-		str	\v, [\a, #8]		@ save lsr, different for 7xx
-
-		/* omap7xx/8xx based boards using uart1 with shift 0 */
-		ldr	\v, =MACH_TYPE_HERALD
-		cmp	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_PERSEUS2
-		cmpne	\id, \v
-		ldreq	\v, =OMAP1_UART1_BASE
-		streq	\v, [\a, #0]		@ save port phys addr
-		ldreq	\v, =(OMAP1_UART1_BASE - OMAP1_IO_OFFSET)
-		streq	\v, [\a, #4]		@ save port virt addr
-		moveq	\v, #(UART_LSR << OMAP7XX_PORT_SHIFT)
-		streq	\v, [\a, #8]		@ save lsr, different for 7xx
-		beq	999f
-
-		/* omap15xx/16xx based boards using uart1 */
-		ldr	\v, =MACH_TYPE_AMS_DELTA
-		cmp	\id, \v
-		ldrne	\v, =MACH_TYPE_NOKIA770
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_H2
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_H3
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_INNOVATOR
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_OSK
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_PALMTE
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_PALMZ71
-		cmpne	\id, \v
-		ldreq	\v, =OMAP1_UART1_BASE
-		streq	\v, [\a, #0]		@ save port phys addr
-		ldreq	\v, =(OMAP1_UART1_BASE - OMAP1_IO_OFFSET)
-		streq	\v, [\a, #4]		@ save port virt addr
-		beq	999f
-
-		/* omap15xx/16xx based boards using uart2 */
-		ldr	\v, =MACH_TYPE_OMAP_PALMTT
-		cmp	\id, \v
-		ldreq	\v, =OMAP1_UART2_BASE
-		streq	\v, [\a, #0]		@ save port phys addr
-		ldreq	\v, =(OMAP1_UART2_BASE - OMAP1_IO_OFFSET)
-		streq	\v, [\a, #4]		@ save port virt addr
-		beq	999f
-
-		/* omap15xx/16xx based boards using uart3 */
-		ldr	\v, =MACH_TYPE_SX1
-		cmp	\id, \v
-		ldreq	\v, =OMAP1_UART3_BASE
-		streq	\v, [\a, #0]		@ save port phys addr
-		ldreq	\v, =(OMAP1_UART3_BASE - OMAP1_IO_OFFSET)
-		streq	\v, [\a, #4]		@ save port virt addr
-		beq	999f
-
-999:
-		.endm
-
-		/*
-		 * Note that this code won't work if the bootloader passes
-		 * a wrong machine ID number in r1. To debug, just hardcode
-		 * the desired omap_uart_phys, omap_uart_virt and omap_uart_lsr
-		 * temporarily into mach-omap[12]/serial.c and comment out
-		 * the inituart macro above.
-		 */
-		.macro	addruart, rp, rv
-
-		/* Use omap_uart_phys/virt if already configured */
-		mrc	p15, 0, \rp, c1, c0
-		tst	\rp, #1			@ MMU enabled?
-#ifdef CONFIG_AUTO_ZRELADDR
-		ldreq	\rp, =omap_uart_phys	@ MMU disabled
-		biceq	\rp, \rp, #0xf8000000	@ clear top bits of virt addr
-		moveq	\rv, pc			@ copy pc
-		andeq	\rv, \rv, #0xf8000000	@ clear lower bits
-		orreq	\rp, \rv		@ combine to get phys addr
-#else
-		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
-#endif
-		ldrne	\rp, =omap_uart_phys	@ MMU enabled
-		add	\rv, \rp, #4		@ omap_uart_virt
-		ldr	\rp, [\rp, #0]
-		ldr	\rv, [\rv, #0]
-		.endm
-
-		.macro	senduart,rd,rx
-		strb	\rd, [\rx]
-		.endm
-
-		.macro	busyuart,rd,rx
-1001:		mrc	p15, 0, \rd, c1, c0
-		tst	\rd, #1			@ MMU enabled?
-#ifdef CONFIG_AUTO_ZRELADDR
-		ldreq	\rd, =omap_uart_lsr	@ MMU disabled
-		biceq	\rd, \rd, #0xf8000000	@ clear top bits of virt addr
-		roreq	\rd, \rd, #27		@ rotate bits
-		orreq	\rd, pc, lsr #27	@ orr with top bits of pc
-		roreq	\rd, \rd, #5		@ rotate bits back
-#else
-		ldreq	\rd, =omap_uart_v2p(omap_uart_lsr)	@ MMU disabled
-#endif
-		ldrne	\rd, =omap_uart_lsr	@ MMU enabled
-		ldr	\rd, [\rd, #0]
-		ldrb	\rd, [\rx, \rd]
-		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-		bne	1001b
-		.endm
-
-		.macro	waituart,rd,rx
-		.endm
+#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 80e0bdc..9a7edaf 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -11,193 +11,4 @@
  *
 */
 
-#include <linux/serial_reg.h>
-
-#include <asm/memory.h>
-#include <asm/mach-types.h>
-
-#include <plat/io.h>
-#include <plat/serial.h>
-
-#define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
-
-		/*
-		 * Intialize the debug serial port based on machine ID
-		 */
-		.macro	inituart, id, a, v
-		mrc	p15, 0, \a, c1, c0
-		tst	\a, #1			@ MMU enabled?
-		ldreq	\a, =omap_uart_phys
-#ifdef CONFIG_AUTO_ZRELADDR
-		ldreq	\a, =omap_uart_phys
-		biceq	\a, \a, #0xf8000000	@ clear top bits of virt addr
-		moveq	\v, pc			@ copy pc
-		andeq	\v, \v, #0xf8000000	@ clear lower bits
-		orreq	\a, \v			@ combile to get phys addr
-#else
-		ldreq	\a, =omap_uart_v2p(omap_uart_phys)
-#endif
-		ldrne	\a, =omap_uart_phys	@ MMU enabled
-		mov	\v, #(UART_LSR << OMAP_PORT_SHIFT)
-		str	\v, [\a, #8]		@ save lsr, different for zoom
-
-		/* omap2 based boards using uart1 */
-		ldr	\v, =MACH_TYPE_OMAP2EVM
-		cmp	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_2430SDP
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_APOLLON
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_H4
-		cmpne	\id, \v
-		ldreq	\v, =OMAP2_UART1_BASE
-		streq	\v, [\a, #0]		@ save port phys addr
-		ldreq	\v, =(OMAP2_UART1_BASE + OMAP2_L4_IO_OFFSET)
-		streq	\v, [\a, #4]		@ save port virt addr
-		beq	999f
-
-		/* omap2 based boards using uart3 */
-		ldr	\v, =MACH_TYPE_NOKIA_N800
-		cmp	\id, \v
-		ldrne	\v, =MACH_TYPE_NOKIA_N810
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_NOKIA_N810_WIMAX
-		cmpne	\id, \v
-		ldreq	\v, =OMAP2_UART3_BASE
-		streq	\v, [\a, #0]		@ save port phys addr
-		ldreq	\v, =(OMAP2_UART3_BASE + OMAP2_L4_IO_OFFSET)
-		streq	\v, [\a, #4]		@ save port virt addr
-		beq	999f
-
-		/* omap3 based boards using uart1 */
-		ldr	\v, =MACH_TYPE_OMAP3EVM
-		cmp	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_3430SDP
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_3630SDP
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP3530_LV_SOM
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP3_TORPEDO
-		cmpne	\id, \v
-		ldreq	\v, =OMAP3_UART1_BASE
-		streq	\v, [\a, #0]		@ save port phys addr
-		ldreq	\v, =(OMAP3_UART1_BASE + OMAP2_L4_IO_OFFSET)
-		streq	\v, [\a, #4]		@ save port virt addr
-		beq	999f
-
-		/* omap3 based boards using uart3 */
-		ldr	\v, =MACH_TYPE_CM_T35
-		cmp	\id, \v
-		ldrne	\v, =MACH_TYPE_CM_T3517
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_CRANEBOARD
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_DEVKIT8000
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_IGEP0020
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_IGEP0030
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_NOKIA_RM680
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_NOKIA_RX51
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP3517EVM
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP3_BEAGLE
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP3_PANDORA
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_LDP
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_OVERO
-		cmpne	\id, \v
-		ldrne	\v, =MACH_TYPE_TOUCHBOOK
-		cmpne	\id, \v
-		ldreq	\v, =OMAP3_UART3_BASE
-		streq	\v, [\a, #0]		@ save port phys addr
-		ldreq	\v, =(OMAP3_UART3_BASE + OMAP2_L4_IO_OFFSET)
-		streq	\v, [\a, #4]		@ save port virt addr
-		beq	999f
-
-		/* omap4 based boards using uart3 */
-		ldr	\v, =MACH_TYPE_OMAP_4430SDP
-		cmp	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP4_PANDA
-		cmpne	\id, \v
-		ldreq	\v, =OMAP4_UART3_BASE
-		streq	\v, [\a, #0]		@ save port phys addr
-		ldreq	\v, =(OMAP4_UART3_BASE + OMAP2_L4_IO_OFFSET)
-		streq	\v, [\a, #4]		@ save port virt addr
-		beq	999f
-
-		/* zoom2/3 external uart */
-		ldr	\v, =MACH_TYPE_OMAP_ZOOM2
-		cmp	\id, \v
-		ldrne	\v, =MACH_TYPE_OMAP_ZOOM3
-		cmpne	\id, \v
-		ldreq	\v, =ZOOM_UART_BASE
-		streq	\v, [\a, #0]		@ save port phys addr
-		ldreq	\v, =ZOOM_UART_VIRT
-		streq	\v, [\a, #4]		@ save port virt addr
-		moveq	\v, #(UART_LSR << ZOOM_PORT_SHIFT)
-		streq	\v, [\a, #8]		@ save lsr, different for zoom
-		beq	999f
-
-999:
-		.endm
-
-		/*
-		 * Note that this code won't work if the bootloader passes
-		 * a wrong machine ID number in r1. To debug, just hardcode
-		 * the desired omap_uart_phys, omap_uart_virt and omap_uart_lsr
-		 * temporarily into mach-omap[12]/serial.c and comment out
-		 * the inituart macro above.
-		 */
-		.macro	addruart, rp, rv
-
-		/* Use omap_uart_phys/virt if already configured */
-		mrc	p15, 0, \rp, c1, c0
-		tst	\rp, #1			@ MMU enabled?
-#ifdef CONFIG_AUTO_ZRELADDR
-		ldreq	\rp, =omap_uart_phys	@ MMU disabled
-		biceq	\rp, \rp, #0xf8000000	@ clear top bits of virt addr
-		moveq	\rv, pc			@ copy pc
-		andeq	\rv, \rv, #0xf8000000	@ clear lower bits
-		orreq	\rp, \rv		@ combine to get phys addr
-#else
-		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
-#endif
-		ldrne	\rp, =omap_uart_phys	@ MMU enabled
-		add	\rv, \rp, #4		@ omap_uart_virt
-		ldr	\rp, [\rp, #0]
-		ldr	\rv, [\rv, #0]
-		.endm
-
-		.macro	senduart,rd,rx
-		strb	\rd, [\rx]
-		.endm
-
-		.macro	busyuart,rd,rx
-1001:		mrc	p15, 0, \rd, c1, c0
-		tst	\rd, #1			@ MMU enabled?
-#ifdef CONFIG_AUTO_ZRELADDR
-		ldreq	\rd, =omap_uart_lsr	@ MMU disabled
-		biceq	\rd, \rd, #0xf8000000	@ clear top bits of virt addr
-		roreq	\rd, \rd, #27		@ rotate bits
-		orreq	\rd, pc, lsr #27	@ orr with top bits of pc
-		roreq	\rd, \rd, #5		@ rotate bits back
-#else
-		ldreq	\rd, =omap_uart_v2p(omap_uart_lsr)	@ MMU disabled
-#endif
-		ldrne	\rd, =omap_uart_lsr	@ MMU enabled
-		ldr	\rd, [\rd, #0]
-		ldrb	\rd, [\rx, \rd]
-		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
-		bne	1001b
-		.endm
-
-		.macro	waituart,rd,rx
-		.endm
+#include <plat/debug-macro.S>
diff --git a/arch/arm/plat-omap/include/plat/debug-macro.S b/arch/arm/plat-omap/include/plat/debug-macro.S
new file mode 100644
index 0000000..1a1a5e8
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/debug-macro.S
@@ -0,0 +1,257 @@
+/* arch/arm/plat-omap/include/mach/debug-macro.S
+ *
+ * Debugging macro include header
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+#include <linux/serial_reg.h>
+
+#include <asm/memory.h>
+#include <asm/mach-types.h>
+
+#include <plat/io.h>
+#include <plat/serial.h>
+
+#define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
+
+		/*
+		 * Intialize the debug serial port based on machine ID
+		 */
+		.macro	inituart, id, a, v
+		mrc	p15, 0, \a, c1, c0
+		tst	\a, #1			@ MMU enabled?
+		ldreq	\a, =omap_uart_phys
+#ifdef CONFIG_AUTO_ZRELADDR
+		ldreq	\a, =omap_uart_phys
+		biceq	\a, \a, #0xf8000000	@ clear top bits of virt addr
+		moveq	\v, pc			@ copy pc
+		andeq	\v, \v, #0xf8000000	@ clear lower bits
+		orreq	\a, \v			@ combile to get phys addr
+#else
+		ldreq	\a, =omap_uart_v2p(omap_uart_phys)
+#endif
+		ldrne	\a, =omap_uart_phys	@ MMU enabled
+		mov	\v, #(UART_LSR << OMAP_PORT_SHIFT)
+		str	\v, [\a, #8]		@ save lsr, different for zoom
+
+		/* omap7xx/8xx based boards using uart1 with shift 0 */
+		ldr	\v, =MACH_TYPE_HERALD
+		cmp	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_PERSEUS2
+		cmpne	\id, \v
+		ldreq	\v, =OMAP1_UART1_BASE
+		streq	\v, [\a, #0]		@ save port phys addr
+		ldreq	\v, =(OMAP1_UART1_BASE - OMAP1_IO_OFFSET)
+		streq	\v, [\a, #4]		@ save port virt addr
+		moveq	\v, #(UART_LSR << OMAP7XX_PORT_SHIFT)
+		streq	\v, [\a, #8]		@ save lsr, different for 7xx
+		beq	999f
+
+		/* omap15xx/16xx based boards using uart1 */
+		ldr	\v, =MACH_TYPE_AMS_DELTA
+		cmp	\id, \v
+		ldrne	\v, =MACH_TYPE_NOKIA770
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_H2
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_H3
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_INNOVATOR
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_OSK
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_PALMTE
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_PALMZ71
+		cmpne	\id, \v
+		ldreq	\v, =OMAP1_UART1_BASE
+		streq	\v, [\a, #0]		@ save port phys addr
+		ldreq	\v, =(OMAP1_UART1_BASE - OMAP1_IO_OFFSET)
+		streq	\v, [\a, #4]		@ save port virt addr
+		beq	999f
+
+		/* omap15xx/16xx based boards using uart2 */
+		ldr	\v, =MACH_TYPE_OMAP_PALMTT
+		cmp	\id, \v
+		ldreq	\v, =OMAP1_UART2_BASE
+		streq	\v, [\a, #0]		@ save port phys addr
+		ldreq	\v, =(OMAP1_UART2_BASE - OMAP1_IO_OFFSET)
+		streq	\v, [\a, #4]		@ save port virt addr
+		beq	999f
+
+		/* omap15xx/16xx based boards using uart3 */
+		ldr	\v, =MACH_TYPE_SX1
+		cmp	\id, \v
+		ldreq	\v, =OMAP1_UART3_BASE
+		streq	\v, [\a, #0]		@ save port phys addr
+		ldreq	\v, =(OMAP1_UART3_BASE - OMAP1_IO_OFFSET)
+		streq	\v, [\a, #4]		@ save port virt addr
+		beq	999f
+
+		/* omap2 based boards using uart1 */
+		ldr	\v, =MACH_TYPE_OMAP2EVM
+		cmp	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_2430SDP
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_APOLLON
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_H4
+		cmpne	\id, \v
+		ldreq	\v, =OMAP2_UART1_BASE
+		streq	\v, [\a, #0]		@ save port phys addr
+		ldreq	\v, =(OMAP2_UART1_BASE + OMAP2_L4_IO_OFFSET)
+		streq	\v, [\a, #4]		@ save port virt addr
+		beq	999f
+
+		/* omap2 based boards using uart3 */
+		ldr	\v, =MACH_TYPE_NOKIA_N800
+		cmp	\id, \v
+		ldrne	\v, =MACH_TYPE_NOKIA_N810
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_NOKIA_N810_WIMAX
+		cmpne	\id, \v
+		ldreq	\v, =OMAP2_UART3_BASE
+		streq	\v, [\a, #0]		@ save port phys addr
+		ldreq	\v, =(OMAP2_UART3_BASE + OMAP2_L4_IO_OFFSET)
+		streq	\v, [\a, #4]		@ save port virt addr
+		beq	999f
+
+		/* omap3 based boards using uart1 */
+		ldr	\v, =MACH_TYPE_OMAP3EVM
+		cmp	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_3430SDP
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_3630SDP
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP3530_LV_SOM
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP3_TORPEDO
+		cmpne	\id, \v
+		ldreq	\v, =OMAP3_UART1_BASE
+		streq	\v, [\a, #0]		@ save port phys addr
+		ldreq	\v, =(OMAP3_UART1_BASE + OMAP2_L4_IO_OFFSET)
+		streq	\v, [\a, #4]		@ save port virt addr
+		beq	999f
+
+		/* omap3 based boards using uart3 */
+		ldr	\v, =MACH_TYPE_CM_T35
+		cmp	\id, \v
+		ldrne	\v, =MACH_TYPE_CM_T3517
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_CRANEBOARD
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_DEVKIT8000
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_IGEP0020
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_IGEP0030
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_NOKIA_RM680
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_NOKIA_RX51
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP3517EVM
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP3_BEAGLE
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP3_PANDORA
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_LDP
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_OVERO
+		cmpne	\id, \v
+		ldrne	\v, =MACH_TYPE_TOUCHBOOK
+		cmpne	\id, \v
+		ldreq	\v, =OMAP3_UART3_BASE
+		streq	\v, [\a, #0]		@ save port phys addr
+		ldreq	\v, =(OMAP3_UART3_BASE + OMAP2_L4_IO_OFFSET)
+		streq	\v, [\a, #4]		@ save port virt addr
+		beq	999f
+
+		/* omap4 based boards using uart3 */
+		ldr	\v, =MACH_TYPE_OMAP_4430SDP
+		cmp	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP4_PANDA
+		cmpne	\id, \v
+		ldreq	\v, =OMAP4_UART3_BASE
+		streq	\v, [\a, #0]		@ save port phys addr
+		ldreq	\v, =(OMAP4_UART3_BASE + OMAP2_L4_IO_OFFSET)
+		streq	\v, [\a, #4]		@ save port virt addr
+		beq	999f
+
+		/* zoom2/3 external uart */
+		ldr	\v, =MACH_TYPE_OMAP_ZOOM2
+		cmp	\id, \v
+		ldrne	\v, =MACH_TYPE_OMAP_ZOOM3
+		cmpne	\id, \v
+		ldreq	\v, =ZOOM_UART_BASE
+		streq	\v, [\a, #0]		@ save port phys addr
+		ldreq	\v, =ZOOM_UART_VIRT
+		streq	\v, [\a, #4]		@ save port virt addr
+		moveq	\v, #(UART_LSR << ZOOM_PORT_SHIFT)
+		streq	\v, [\a, #8]		@ save lsr, different for zoom
+		beq	999f
+
+999:
+		.endm
+
+		/*
+		 * Note that this code won't work if the bootloader passes
+		 * a wrong machine ID number in r1. To debug, just hardcode
+		 * the desired omap_uart_phys, omap_uart_virt and omap_uart_lsr
+		 * temporarily into mach-omap[12]/serial.c and comment out
+		 * the inituart macro above.
+		 */
+		.macro	addruart, rp, rv
+
+		/* Use omap_uart_phys/virt if already configured */
+		mrc	p15, 0, \rp, c1, c0
+		tst	\rp, #1			@ MMU enabled?
+#ifdef CONFIG_AUTO_ZRELADDR
+		ldreq	\rp, =omap_uart_phys	@ MMU disabled
+		biceq	\rp, \rp, #0xf8000000	@ clear top bits of virt addr
+		moveq	\rv, pc			@ copy pc
+		andeq	\rv, \rv, #0xf8000000	@ clear lower bits
+		orreq	\rp, \rv		@ combine to get phys addr
+#else
+		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
+#endif
+		ldrne	\rp, =omap_uart_phys	@ MMU enabled
+		add	\rv, \rp, #4		@ omap_uart_virt
+		ldr	\rp, [\rp, #0]
+		ldr	\rv, [\rv, #0]
+		.endm
+
+		.macro	senduart,rd,rx
+		strb	\rd, [\rx]
+		.endm
+
+		.macro	busyuart,rd,rx
+1001:		mrc	p15, 0, \rd, c1, c0
+		tst	\rd, #1			@ MMU enabled?
+#ifdef CONFIG_AUTO_ZRELADDR
+		ldreq	\rd, =omap_uart_lsr	@ MMU disabled
+		biceq	\rd, \rd, #0xf8000000	@ clear top bits of virt addr
+		roreq	\rd, \rd, #27		@ rotate bits
+		orreq	\rd, pc, lsr #27	@ orr with top bits of pc
+		roreq	\rd, \rd, #5		@ rotate bits back
+#else
+		ldreq	\rd, =omap_uart_v2p(omap_uart_lsr)	@ MMU disabled
+#endif
+		ldrne	\rd, =omap_uart_lsr	@ MMU enabled
+		ldr	\rd, [\rd, #0]
+		ldrb	\rd, [\rx, \rd]
+		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
+		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
+		bne	1001b
+		.endm
+
+		.macro	waituart,rd,rx
+		.endm

