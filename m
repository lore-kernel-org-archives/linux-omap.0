From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] omap: Remove code configuring the DEBUG_LL serial port
	using uncompress code
Date: Thu, 03 Feb 2011 17:27:05 -0800
Message-ID: <20110204012705.26410.63930.stgit@baageli.muru.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20720 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab1BDB1U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:27:20 -0500
In-Reply-To: <20110204012317.26410.55157.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This code gets too complex and has a dependency to the uncompress code
for initializing the serial port. The following patches will use inituart
for machine specific debug uart init.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/debug-macro.S |   47 -------------
 arch/arm/mach-omap2/include/mach/debug-macro.S |   84 ------------------------
 arch/arm/plat-omap/include/plat/serial.h       |   34 ----------
 arch/arm/plat-omap/include/plat/uncompress.h   |   32 ++-------
 4 files changed, 9 insertions(+), 188 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index bf0cc57..db2cdf4 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -18,7 +18,6 @@
 #include <plat/serial.h>
 
 #define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
-#define omap_uart_p2v(x)	((x) - PLAT_PHYS_OFFSET + PAGE_OFFSET)
 
 		.pushsection .data
 omap_uart_phys:	.word	0x0
@@ -37,57 +36,13 @@ omap_uart_virt:	.word	0x0
 		.macro	addruart, rp, rv
 
 		/* Use omap_uart_phys/virt if already configured */
-9:		mrc	p15, 0, \rp, c1, c0
+		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
 		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
 		ldrne	\rp, =omap_uart_phys	@ MMU enabled
 		add	\rv, \rp, #4		@ omap_uart_virt
 		ldr	\rp, [\rp, #0]
 		ldr	\rv, [\rv, #0]
-		cmp	\rp, #0			@ is port configured?
-		cmpne	\rv, #0
-		bne	99f			@ already configured
-
-		/* Check the debug UART configuration set in uncompress.h */
-		mrc	p15, 0, \rp, c1, c0
-		tst	\rp, #1			@ MMU enabled?
-		ldreq	\rp, =OMAP_UART_INFO	@ MMU not enabled
-		ldrne	\rp, =omap_uart_p2v(OMAP_UART_INFO)	@ MMU enabled
-		ldr	\rp, [\rp, #0]
-
-		/* Select the UART to use based on the UART1 scratchpad value */
-10:		cmp	\rp, #0			@ no port configured?
-		beq	11f			@ if none, try to use UART1
-		cmp	\rp, #OMAP1UART1
-		beq	11f			@ configure OMAP1UART1
-		cmp	\rp, #OMAP1UART2
-		beq	12f			@ configure OMAP1UART2
-		cmp	\rp, #OMAP1UART3
-		beq	13f			@ configure OMAP2UART3
-
-		/* Configure the UART offset from the phys/virt base */
-11:		mov	\rp, #0x00fb0000	@ OMAP1UART1
-		b	98f
-12:		mov	\rp, #0x00fb0000	@ OMAP1UART1
-		orr	\rp, \rp, #0x00000800	@ OMAP1UART2
-		b	98f
-13:		mov	\rp, #0x00fb0000	@ OMAP1UART1
-		orr	\rp, \rp, #0x00000800	@ OMAP1UART2
-		orr	\rp, \rp, #0x00009000	@ OMAP1UART3
-
-		/* Store both phys and virt address for the uart */
-98:		add	\rp, \rp, #0xff000000	@ phys base
-		mrc	p15, 0, \rv, c1, c0
-		tst	\rv, #1			@ MMU enabled?
-		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
-		ldrne	\rv, =omap_uart_phys	@ MMU enabled
-		str	\rp, [\rv, #0]
-		sub	\rp, \rp, #0xff000000	@ phys base
-		add	\rp, \rp, #0xfe000000	@ virt base
-		add	\rv, \rv, #4		@ omap_uart_lsr
-		str	\rp, [\rv, #0]
-		b	9b
-99:
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 6bbe2dd..336a838 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -20,7 +20,6 @@
 #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
 
 #define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
-#define omap_uart_p2v(x)	((x) - PLAT_PHYS_OFFSET + PAGE_OFFSET)
 
 		.pushsection .data
 omap_uart_phys:	.word	0
@@ -40,94 +39,13 @@ omap_uart_lsr:	.word	0
 		.macro	addruart, rp, rv
 
 		/* Use omap_uart_phys/virt if already configured */
-10:		mrc	p15, 0, \rp, c1, c0
+		mrc	p15, 0, \rp, c1, c0
 		tst	\rp, #1			@ MMU enabled?
 		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
 		ldrne	\rp, =omap_uart_phys	@ MMU enabled
 		add	\rv, \rp, #4		@ omap_uart_virt
 		ldr	\rp, [\rp, #0]
 		ldr	\rv, [\rv, #0]
-		cmp	\rp, #0			@ is port configured?
-		cmpne	\rv, #0
-		bne	99f			@ already configured
-
-		/* Check the debug UART configuration set in uncompress.h */
-		mrc	p15, 0, \rp, c1, c0
-		tst	\rp, #1			@ MMU enabled?
-		ldreq	\rp, =OMAP_UART_INFO	@ MMU not enabled
-		ldrne	\rp, =omap_uart_p2v(OMAP_UART_INFO)	@ MMU enabled
-		ldr	\rp, [\rp, #0]
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
-		cmp	\rp, #OMAP4UART3	@ only on 44xx
-		beq	43f			@ configure OMAP4UART3
-		cmp	\rp, #OMAP3UART4	@ only on 36xx
-		beq	34f			@ configure OMAP3UART4
-		cmp	\rp, #OMAP4UART4	@ only on 44xx
-		beq	44f			@ configure OMAP4UART4
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
-95:		ldr	\rp, =ZOOM_UART_BASE
-		mrc	p15, 0, \rv, c1, c0
-		tst	\rv, #1			@ MMU enabled?
-		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
-		ldrne	\rv, =omap_uart_phys	@ MMU enabled
-		str	\rp, [\rv, #0]
-		ldr	\rp, =ZOOM_UART_VIRT
-		add	\rv, \rv, #4		@ omap_uart_virt
-		str	\rp, [\rv, #0]
-		mov	\rp, #(UART_LSR << ZOOM_PORT_SHIFT)
-		add	\rv, \rv, #4		@ omap_uart_lsr
-		str	\rp, [\rv, #0]
-		b	10b
-
-		/* Store both phys and virt address for the uart */
-98:		add	\rp, \rp, #0x48000000	@ phys base
-		mrc	p15, 0, \rv, c1, c0
-		tst	\rv, #1			@ MMU enabled?
-		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
-		ldrne	\rv, =omap_uart_phys	@ MMU enabled
-		str	\rp, [\rv, #0]
-		sub	\rp, \rp, #0x48000000	@ phys base
-		add	\rp, \rp, #0xfa000000	@ virt base
-		add	\rv, \rv, #4		@ omap_uart_virt
-		str	\rp, [\rv, #0]
-		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
-		add	\rv, \rv, #4		@ omap_uart_lsr
-		str	\rp, [\rv, #0]
-
-		b	10b
-99:
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 8ff605c..7d9ed90 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -15,20 +15,6 @@
 
 #include <linux/init.h>
 
-/*
- * Memory entry used for the DEBUG_LL UART configuration. See also
- * uncompress.h and debug-macro.S.
- *
- * Note that using a memory location for storing the UART configuration
- * has at least two limitations:
- *
- * 1. Kernel uncompress code cannot overlap OMAP_UART_INFO as the
- *    uncompress code could then partially overwrite itself
- * 2. We assume printascii is called at least once before paging_init,
- *    and addruart has a chance to read OMAP_UART_INFO
- */
-#define OMAP_UART_INFO		(PLAT_PHYS_OFFSET + 0x3ffc)
-
 /* OMAP1 serial ports */
 #define OMAP1_UART1_BASE	0xfffb0000
 #define OMAP1_UART2_BASE	0xfffb0800
@@ -63,26 +49,6 @@
 #define OMAP16XX_BASE_BAUD	(48000000/16)
 #define OMAP24XX_BASE_BAUD	(48000000/16)
 
-/*
- * DEBUG_LL port encoding stored into the UART1 scratchpad register by
- * decomp_setup in uncompress.h
- */
-#define OMAP1UART1		11
-#define OMAP1UART2		12
-#define OMAP1UART3		13
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
-#define ZOOM_UART		95		/* Only on zoom2/3 */
-
 /* This is only used by 8250.c for omap1510 */
 #define is_omap_port(pt)	({int __ret = 0;			\
 			if ((pt)->port.mapbase == OMAP1_UART1_BASE ||	\
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index ad98b85..ea1ffe4 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -30,15 +30,6 @@
 static volatile u8 *uart_base;
 static int uart_shift;
 
-/*
- * Store the DEBUG_LL uart number into memory.
- * See also debug-macro.S, and serial.c for related code.
- */
-static void set_omap_uart_info(unsigned char port)
-{
-	*(volatile u32 *)OMAP_UART_INFO = port;
-}
-
 static void putc(int c)
 {
 	if (!uart_base)
@@ -60,43 +51,34 @@ static inline void flush(void)
 /*
  * Macros to configure UART1 and debug UART
  */
-#define _DEBUG_LL_ENTRY(mach, dbg_uart, dbg_shft, dbg_id)		\
+#define _DEBUG_LL_ENTRY(mach, dbg_uart, dbg_shft)			\
 	if (machine_is_##mach()) {					\
 		uart_base = (volatile u8 *)(dbg_uart);			\
 		uart_shift = (dbg_shft);				\
-		port = (dbg_id);					\
-		set_omap_uart_info(port);				\
 		break;							\
 	}
 
 #define DEBUG_LL_OMAP7XX(p, mach)					\
-	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP7XX_PORT_SHIFT,	\
-		OMAP1UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP7XX_PORT_SHIFT)
 
 #define DEBUG_LL_OMAP1(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP1UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP_PORT_SHIFT)
 
 #define DEBUG_LL_OMAP2(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP2_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP2UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP2_UART##p##_BASE, OMAP_PORT_SHIFT)
 
 #define DEBUG_LL_OMAP3(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP3_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP3UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP3_UART##p##_BASE, OMAP_PORT_SHIFT)
 
 #define DEBUG_LL_OMAP4(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP4UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT)
 
 /* Zoom2/3 shift is different for UART1 and external port */
 #define DEBUG_LL_ZOOM(mach)						\
-	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
+	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT)
 
 static inline void __arch_decomp_setup(unsigned long arch_id)
 {
-	int port = 0;
-
 	/*
 	 * Initialize the port based on the machine ID from the bootloader.
 	 * Note that we're using macros here instead of switch statement

