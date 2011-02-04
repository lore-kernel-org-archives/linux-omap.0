From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] omap: Use inituart to configure the debug serial port
	based on machine ID
Date: Thu, 03 Feb 2011 17:27:07 -0800
Message-ID: <20110204012707.26410.28508.stgit@baageli.muru.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20790 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab1BDB1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:27:22 -0500
In-Reply-To: <20110204012317.26410.55157.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Set the debug serial port based on machine ID. Note that most
of the patch is just trivial checking for the machine ID.

Also note that this code won't work for debugging the uncompress code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/debug-macro.S |   77 +++++++++++++-
 arch/arm/mach-omap1/serial.c                   |    7 +
 arch/arm/mach-omap2/include/mach/debug-macro.S |  130 ++++++++++++++++++++++--
 arch/arm/mach-omap2/serial.c                   |    7 +
 4 files changed, 204 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index db2cdf4..80dcf18 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -14,24 +14,87 @@
 #include <linux/serial_reg.h>
 
 #include <asm/memory.h>
+#include <asm/mach-types.h>
 
+#include <plat/io.h>
 #include <plat/serial.h>
 
 #define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
 
-		.pushsection .data
-omap_uart_phys:	.word	0x0
-omap_uart_virt:	.word	0x0
-		.popsection
-
+		/*
+		 * Intialize the debug serial port based on machine ID
+		 */
 		.macro	inituart, id, a, v
+		mrc	p15, 0, \a, c1, c0
+		tst	\a, #1			@ MMU enabled?
+		ldreq	\a, =omap_uart_v2p(omap_uart_phys)
+		ldrne	\a, =omap_uart_phys
+		mov	\v, #(UART_LSR << OMAP_PORT_SHIFT)
+		str	\v, [\a, #8]		@ save lsr, different for 7xx
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
+999:
 		.endm
 
 		/*
 		 * Note that this code won't work if the bootloader passes
 		 * a wrong machine ID number in r1. To debug, just hardcode
-		 * the desired UART phys and virt addresses temporarily into
-		 * the omap_uart_phys and omap_uart_virt above.
+		 * the desired omap_uart_phys, omap_uart_virt and omap_uart_lsr
+		 * temporarily into mach-omap[12]/serial.c and comment out
+		 * the inituart macro above.
 		 */
 		.macro	addruart, rp, rv
 
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 550ca9d..8b4ce4a 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -29,6 +29,13 @@
 
 #include "pm.h"
 
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
+/* Used by inituart, addruart and busyuart. See debug-macro.S */
+void __iomem *omap_uart_phys;
+void __iomem *omap_uart_virt;
+void __iomem *omap_uart_lsr;
+#endif
+
 static struct clk * uart1_ck;
 static struct clk * uart2_ck;
 static struct clk * uart3_ck;
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 336a838..45c29e3 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -14,27 +14,137 @@
 #include <linux/serial_reg.h>
 
 #include <asm/memory.h>
+#include <asm/mach-types.h>
 
+#include <plat/io.h>
 #include <plat/serial.h>
 
-#define UART_OFFSET(addr)	((addr) & 0x00ffffff)
-
 #define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
 
-		.pushsection .data
-omap_uart_phys:	.word	0
-omap_uart_virt:	.word	0
-omap_uart_lsr:	.word	0
-		.popsection
-
+		/*
+		 * Intialize the debug serial port based on machine ID
+		 */
 		.macro	inituart, id, a, v
+		mrc	p15, 0, \a, c1, c0
+		tst	\a, #1			@ MMU enabled?
+		ldreq	\a, =omap_uart_v2p(omap_uart_phys)
+		ldrne	\a, =omap_uart_phys
+		mov	\v, #(UART_LSR << OMAP_PORT_SHIFT)
+		str	\v, [\a, #8]		@ save lsr, different for zoom
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
 		.endm
 
 		/*
 		 * Note that this code won't work if the bootloader passes
 		 * a wrong machine ID number in r1. To debug, just hardcode
-		 * the desired UART phys and virt addresses temporarily into
-		 * the omap_uart_phys and omap_uart_virt above.
+		 * the desired omap_uart_phys, omap_uart_virt and omap_uart_lsr
+		 * temporarily into mach-omap[12]/serial.c and comment out
+		 * the inituart macro above.
 		 */
 		.macro	addruart, rp, rv
 
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 32e91a9..9a41d6c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -104,6 +104,13 @@ struct omap_uart_state {
 #endif
 };
 
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
+/* Used by inituart, addruart and busyuart. See debug-macro.S */
+void __iomem *omap_uart_phys;
+void __iomem *omap_uart_virt;
+void __iomem *omap_uart_lsr;
+#endif
+
 static LIST_HEAD(uart_list);
 static u8 num_uarts;
 

