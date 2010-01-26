From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/14] omap: Make uncompress code and DEBUG_LL code generic
Date: Tue, 26 Jan 2010 12:12:39 -0800
Message-ID: <20100126201239.15382.34792.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57819 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab0AZUMV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:21 -0500
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Define arch_decomp_setup() the same way as some other
architectures do. Use arch_id to configure the debug uart
based on the machine_is by storing it into the uart
scratchpad register for DEBUG_LL code to use.

Note that to avoid merge conflicts, this patch is using
hardcoded register r1 until tmp register is being passed
for all addruart macros.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/debug-macro.S |   72 +++++++++
 arch/arm/mach-omap2/include/mach/debug-macro.S |  117 +++++++++++++--
 arch/arm/plat-omap/include/plat/serial.h       |   33 ++++
 arch/arm/plat-omap/include/plat/uncompress.h   |  182 ++++++++++++++++++------
 4 files changed, 322 insertions(+), 82 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index 23e4724..0187391 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -15,18 +15,76 @@
 
 #include <plat/serial.h>
 
+		.pushsection .data
+omap_uart_phys:	.word	0x0
+omap_uart_virt:	.word	0x0
+		.popsection
+
+		/*
+		 * Note that this code won't work if the bootloader passes
+		 * a wrong machine ID number in r1. To debug, just hardcode
+		 * the desired UART phys and virt addresses temporarily into
+		 * the omap_uart_phys and omap_uart_virt above.
+		 */
 		.macro	addruart,rx
+
+		/* Use omap_uart_phys/virt if already configured */
+9:		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1			@ MMU enabled?
+		ldreq	\rx, =omap_uart_phys	@ physical base address
+		ldrne	\rx, =omap_uart_virt	@ virtual base
+		ldr	\rx, [\rx, #0]
+		cmp	\rx, #0			@ is port configured?
+		bne	99f			@ already configured
+
+		/* Check 7XX UART1 scratchpad register for uart to use */
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1			@ MMU enabled?
+		moveq	\rx, #0xff000000	@ physical base address
+		movne	\rx, #0xfe000000	@ virtual base
+		orr	\rx, \rx, #0x00fb0000	@ OMAP1UART1
+		ldrb	\rx, [\rx, #(UART_SCR << OMAP7XX_PORT_SHIFT)]
+		cmp	\rx, #0			@ anything in 7XX scratchpad?
+		bne	10f			@ found 7XX uart
+
+		/* Check 15xx/16xx UART1 scratchpad register for uart to use */
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
 		moveq	\rx, #0xff000000	@ physical base address
 		movne	\rx, #0xfe000000	@ virtual base
-		orr	\rx, \rx, #0x00fb0000
-#ifdef CONFIG_OMAP_LL_DEBUG_UART3
-		orr	\rx, \rx, #0x00009000	@ UART 3
-#endif
-#if defined(CONFIG_OMAP_LL_DEBUG_UART2) || defined(CONFIG_OMAP_LL_DEBUG_UART3)
-		orr	\rx, \rx, #0x00000800	@ UART 2 & 3
-#endif
+		orr	\rx, \rx, #0x00fb0000	@ OMAP1UART1
+		ldrb	\rx, [\rx, #(UART_SCR << OMAP_PORT_SHIFT)]
+
+		/* Select the UART to use based on the UART1 scratchpad value */
+10:		cmp	\rx, #0			@ no port configured?
+		beq	11f			@ if none, try to use UART1
+		cmp	\rx, #OMAP1UART1
+		beq	11f			@ configure OMAP1UART1
+		cmp	\rx, #OMAP1UART2
+		beq	12f			@ configure OMAP1UART2
+		cmp	\rx, #OMAP1UART3
+		beq	13f			@ configure OMAP2UART3
+
+		/* Configure the UART offset from the phys/virt base */
+11:		mov	\rx, #0x00fb0000	@ OMAP1UART1
+		b	98f
+12:		mov	\rx, #0x00fb0000	@ OMAP1UART1
+		orr	\rx, \rx, #0x00000800	@ OMAP1UART2
+		b	98f
+13:		mov	\rx, #0x00fb0000	@ OMAP1UART1
+		orr	\rx, \rx, #0x00000800	@ OMAP1UART2
+		orr	\rx, \rx, #0x00009000	@ OMAP1UART3
+
+		/* Store both phys and virt address for the uart */
+98:		add	\rx, \rx, #0xff000000	@ phys base
+		ldr	r1, =omap_uart_phys
+		str	\rx, [r1, #0]
+		sub	\rx, \rx, #0xff000000	@ phys base
+		add	\rx, \rx, #0xfe000000	@ virt base
+		ldr	r1, =omap_uart_virt
+		str	\rx, [r1, #0]
+		b	9b
+99:
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 0c96e1c..eb05a22 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -15,32 +15,103 @@
 
 #include <plat/serial.h>
 
+#define UART_OFFSET(addr)	((addr) & 0x00ffffff)
+
+		.pushsection .data
+omap_uart_phys:	.word	0
+omap_uart_virt:	.word	0
+omap_uart_lsr:	.word	0
+		.popsection
+
+		/*
+		 * Note that this code won't work if the bootloader passes
+		 * a wrong machine ID number in r1. To debug, just hardcode
+		 * the desired UART phys and virt addresses temporarily into
+		 * the omap_uart_phys and omap_uart_virt above.
+		 */
 		.macro	addruart,rx
+
+		/* Use omap_uart_phys/virt if already configured */
+10:		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1			@ MMU enabled?
+		ldreq	\rx, =omap_uart_phys	@ physical base address
+		ldrne	\rx, =omap_uart_virt	@ virtual base address
+		ldr	\rx, [\rx, #0]
+		cmp	\rx, #0			@ is port configured?
+		bne	99f			@ already configured
+
+		/* Check UART1 scratchpad register for uart to use */
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
-#ifdef  CONFIG_ARCH_OMAP2
 		moveq	\rx, #0x48000000	@ physical base address
 		movne	\rx, #0xfa000000	@ virtual base
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
-		movne	\rx, #0xfa000000	@ virtual base
-		orr	\rx, \rx, #0x0006a000
-#ifdef CONFIG_OMAP_LL_DEBUG_UART2
-		add	\rx, \rx, #0x00002000	@ UART 2
-#endif
-#ifdef CONFIG_OMAP_LL_DEBUG_UART3
-		add	\rx, \rx, #0x00fb0000	@ UART 3
-		add	\rx, \rx, #0x00006000
-#endif
-#endif
+		orr	\rx, \rx, #0x0006a000	@ uart1 on omap2/3/4
+		ldrb	\rx, [\rx, #(UART_SCR << OMAP_PORT_SHIFT)] @ scratchpad
+
+		/* Select the UART to use based on the UART1 scratchpad value */
+		cmp	\rx, #0			@ no port configured?
+		beq	21f			@ if none, try to use UART1
+		cmp	\rx, #OMAP2UART1	@ OMAP2/3/4UART1
+		beq	21f			@ configure OMAP2/3/4UART1
+		cmp	\rx, #OMAP2UART2	@ OMAP2/3/4UART2
+		beq	22f			@ configure OMAP2/3/4UART2
+		cmp	\rx, #OMAP2UART3	@ only on 24xx
+		beq	23f			@ configure OMAP2UART3
+		cmp	\rx, #OMAP3UART3	@ only on 34xx
+		beq	33f			@ configure OMAP3UART3
+		cmp	\rx, #OMAP4UART3	@ only on 44xx
+		beq	43f			@ configure OMAP4UART3
+		cmp	\rx, #OMAP3UART4	@ only on 36xx
+		beq	34f			@ configure OMAP3UART4
+		cmp	\rx, #OMAP4UART4	@ only on 44xx
+		beq	44f			@ configure OMAP4UART4
+		cmp	\rx, #ZOOM_UART		@ only on zoom2/3
+		beq	95f			@ configure ZOOM_UART
+
+		/* Configure the UART offset from the phys/virt base */
+21:		mov	\rx, #UART_OFFSET(OMAP2_UART1_BASE)	@ omap2/3/4
+		b	98f
+22:		mov	\rx, #UART_OFFSET(OMAP2_UART2_BASE)	@ omap2/3/4
+		b	98f
+23:		mov	\rx, #UART_OFFSET(OMAP2_UART3_BASE)
+		b	98f
+33:		mov	\rx, #UART_OFFSET(OMAP3_UART1_BASE)
+		add	\rx, \rx, #0x00fb0000
+		add	\rx, \rx, #0x00006000		@ OMAP3_UART3_BASE
+		b	98f
+34:		mov	\rx, #UART_OFFSET(OMAP3_UART1_BASE)
+		add	\rx, \rx, #0x00fb0000
+		add	\rx, \rx, #0x00028000		@ OMAP3_UART4_BASE
+		b	98f
+43:		mov	\rx, #UART_OFFSET(OMAP4_UART3_BASE)
+		b	98f
+44:		mov	\rx, #UART_OFFSET(OMAP4_UART4_BASE)
+		b	98f
+95:		mov	\rx, #ZOOM_UART_BASE
+		ldr	r1, =omap_uart_phys
+		str	\rx, [r1, #0]
+		mov	\rx, #ZOOM_UART_VIRT
+		ldr	r1, =omap_uart_virt
+		str	\rx, [r1, #0]
+		mov	\rx, #(UART_LSR << ZOOM_PORT_SHIFT)
+		ldr	r1, =omap_uart_lsr
+		str	\rx, [r1, #0]
+		b	10b
+
+		/* Store both phys and virt address for the uart */
+98:		add	\rx, \rx, #0x48000000	@ phys base
+		ldr	r1, =omap_uart_phys
+		str	\rx, [r1, #0]
+		sub	\rx, \rx, #0x48000000	@ phys base
+		add	\rx, \rx, #0xfa000000	@ virt base
+		ldr	r1, =omap_uart_virt
+		str	\rx, [r1, #0]
+		mov	\rx, #(UART_LSR << OMAP_PORT_SHIFT)
+		ldr	r1, =omap_uart_lsr
+		str	\rx, [r1, #0]
+
+		b	10b
+99:
 		.endm
 
 		.macro	senduart,rd,rx
@@ -48,7 +119,9 @@
 		.endm
 
 		.macro	busyuart,rd,rx
-1001:		ldrb	\rd, [\rx, #(UART_LSR << OMAP_PORT_SHIFT)]
+1001:		ldr	\rd, =omap_uart_lsr
+		ldr	\rd, [\rd, #0]
+		ldrb	\rd, [\rx, \rd]
 		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
 		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
 		bne	1001b
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 7f5a7a8..67ffa08 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -26,24 +26,49 @@
 #define OMAP2_UART3_BASE	0x4806e000
 
 /* OMAP3 serial ports */
-#define OMAP3_UART1_BASE	0x4806a000
-#define OMAP3_UART2_BASE	0x4806c000
+#define OMAP3_UART1_BASE	OMAP2_UART1_BASE
+#define OMAP3_UART2_BASE	OMAP2_UART2_BASE
 #define OMAP3_UART3_BASE	0x49020000
 #define OMAP3_UART4_BASE	0x49042000	/* Only on 36xx */
 
 /* OMAP4 serial ports */
-#define OMAP4_UART1_BASE	0x4806a000
-#define OMAP4_UART2_BASE	0x4806c000
+#define OMAP4_UART1_BASE	OMAP2_UART1_BASE
+#define OMAP4_UART2_BASE	OMAP2_UART1_BASE
 #define OMAP4_UART3_BASE	0x48020000
 #define OMAP4_UART4_BASE	0x4806e000
 
+/* External port on Zoom2/3 */
+#define ZOOM_UART_BASE		0x10000000
+#define ZOOM_UART_VIRT		0xfb000000
+
 #define OMAP_PORT_SHIFT		2
 #define OMAP7XX_PORT_SHIFT	0
+#define ZOOM_PORT_SHIFT		1
 
 #define OMAP1510_BASE_BAUD	(12000000/16)
 #define OMAP16XX_BASE_BAUD	(48000000/16)
 #define OMAP24XX_BASE_BAUD	(48000000/16)
 
+/*
+ * DEBUG_LL port encoding stored into the UART1 scratchpad register by
+ * decomp_setup in uncompress.h
+ */
+#define OMAP1UART1		11
+#define OMAP1UART2		12
+#define OMAP1UART3		13
+#define OMAP2UART1		21
+#define OMAP2UART2		22
+#define OMAP2UART3		23
+#define OMAP3UART1		OMAP2UART1
+#define OMAP3UART2		OMAP2UART2
+#define OMAP3UART3		33
+#define OMAP3UART4		34		/* Only on 36xx */
+#define OMAP4UART1		OMAP2UART1
+#define OMAP4UART2		OMAP2UART2
+#define OMAP4UART3		43
+#define OMAP4UART4		44
+#define ZOOM_UART		95		/* Only on zoom2/3 */
+
 /* This is only used by 8250.c for omap1510 */
 #define is_omap_port(pt)	({int __ret = 0;			\
 			if ((pt)->port.mapbase == OMAP1_UART1_BASE ||	\
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index e5723c3..81d9ec5 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -19,63 +19,38 @@
 
 #include <linux/types.h>
 #include <linux/serial_reg.h>
+
+#include <asm/mach-types.h>
+
 #include <plat/serial.h>
 
-unsigned int system_rev;
+static volatile u8 *uart1_base;
+static int uart1_shift;
 
-#define UART_OMAP_MDR1		0x08	/* mode definition register */
-#define OMAP_ID_730		0x355F
-#define OMAP_ID_850		0x362C
-#define ID_MASK			0x7fff
-#define check_port(base, shift) ((base[UART_OMAP_MDR1 << shift] & 7) == 0)
-#define omap_get_id() ((*(volatile unsigned int *)(0xfffed404)) >> 12) & ID_MASK
+static volatile u8 *uart_base;
+static int uart_shift;
 
-static void putc(int c)
+/*
+ * Store the DEBUG_LL uart number into UART1 scratchpad register.
+ * See also debug-macro.S, and serial.c for related code.
+ *
+ * Please note that we currently assume that:
+ * - UART1 clocks are enabled for register access
+ * - UART1 scratchpad register can be used
+ */
+static void set_uart1_scratchpad(unsigned char port)
 {
-	volatile u8 * uart = 0;
-	int shift = 2;
-
-#ifdef CONFIG_MACH_OMAP_PALMTE
-	return;
-#endif
-
-#ifdef CONFIG_ARCH_OMAP
-	/* Will get removed in the next patch, set to OMAP3 to compile */
-#ifdef	CONFIG_OMAP_LL_DEBUG_UART3
-	uart = (volatile u8 *)(OMAP3_UART3_BASE);
-#elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
-	uart = (volatile u8 *)(OMAP3_UART2_BASE);
-#elif defined(CONFIG_OMAP_LL_DEBUG_UART1)
-	uart = (volatile u8 *)(OMAP3_UART1_BASE);
-#elif defined(CONFIG_OMAP_LL_DEBUG_NONE)
-	return;
-#else
-	return;
-#endif
-
-#ifdef CONFIG_ARCH_OMAP1
-	/* Determine which serial port to use */
-	do {
-		/* MMU is not on, so cpu_is_omapXXXX() won't work here */
-		unsigned int omap_id = omap_get_id();
-
-		if (omap_id == OMAP_ID_730 || omap_id == OMAP_ID_850)
-			shift = 0;
+	uart1_base[UART_SCR << uart1_shift] = port;
+}
 
-		if (check_port(uart, shift))
-			break;
-		/* Silent boot if no serial ports are enabled. */
+static void putc(int c)
+{
+	if (!uart_base)
 		return;
-	} while (0);
-#endif /* CONFIG_ARCH_OMAP1 */
-#endif
 
-	/*
-	 * Now, xmit each character
-	 */
-	while (!(uart[UART_LSR << shift] & UART_LSR_THRE))
+	while (!(uart_base[UART_LSR << uart_shift] & UART_LSR_THRE))
 		barrier();
-	uart[UART_TX << shift] = c;
+	uart_base[UART_TX << uart_shift] = c;
 }
 
 static inline void flush(void)
@@ -83,7 +58,116 @@ static inline void flush(void)
 }
 
 /*
+ * Macros to configure UART1 and debug UART
+ */
+#define _DEBUG_LL_ENTRY(mach, uart1_phys, uart1_shft,			\
+			dbg_uart, dbg_shft, dbg_id)			\
+	if (machine_is_##mach()) {					\
+		uart1_base = (volatile u8 *)(uart1_phys);		\
+		uart1_shift = (uart1_shft);				\
+		uart_base = (volatile u8 *)(dbg_uart);			\
+		uart_shift = (dbg_shft);				\
+		port = (dbg_id);					\
+		set_uart1_scratchpad(port);				\
+		break;							\
+	}
+
+#define DEBUG_LL_OMAP7XX(p, mach)					\
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART1_BASE, OMAP7XX_PORT_SHIFT,	\
+		OMAP1_UART##p##_BASE, OMAP7XX_PORT_SHIFT, OMAP1UART##p)
+
+#define DEBUG_LL_OMAP1(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART1_BASE, OMAP_PORT_SHIFT,	\
+		OMAP1_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP1UART##p)
+
+#define DEBUG_LL_OMAP2(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP2_UART1_BASE, OMAP_PORT_SHIFT,	\
+		OMAP2_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP2UART##p)
+
+#define DEBUG_LL_OMAP3(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP3_UART1_BASE, OMAP_PORT_SHIFT,	\
+		OMAP3_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP3UART##p)
+
+#define DEBUG_LL_OMAP4(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP4_UART1_BASE, OMAP_PORT_SHIFT,	\
+		OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP4UART##p)
+
+/* Zoom2/3 shift is different for UART1 and external port */
+#define DEBUG_LL_ZOOM(mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP2_UART1_BASE, OMAP_PORT_SHIFT,	\
+		ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
+
+static inline void __arch_decomp_setup(unsigned long arch_id)
+{
+	int port = 0;
+
+	/*
+	 * Initialize the port based on the machine ID from the bootloader.
+	 * Note that we're using macros here instead of switch statement
+	 * as machine_is functions are optimized out for the boards that
+	 * are not selected.
+	 */
+	do {
+		/* omap7xx/8xx based boards using UART1 with shift 0 */
+		DEBUG_LL_OMAP7XX(1, herald);
+		DEBUG_LL_OMAP7XX(1, omap_perseus2);
+
+		/* omap15xx/16xx based boards using UART1 */
+		DEBUG_LL_OMAP1(1, ams_delta);
+		DEBUG_LL_OMAP1(1, nokia770);
+		DEBUG_LL_OMAP1(1, omap_h2);
+		DEBUG_LL_OMAP1(1, omap_h3);
+		DEBUG_LL_OMAP1(1, omap_innovator);
+		DEBUG_LL_OMAP1(1, omap_osk);
+		DEBUG_LL_OMAP1(1, omap_palmte);
+		DEBUG_LL_OMAP1(1, omap_palmz71);
+
+		/* omap15xx/16xx based boards using UART2 */
+		DEBUG_LL_OMAP1(2, omap_palmtt);
+
+		/* omap15xx/16xx based boards using UART3 */
+		DEBUG_LL_OMAP1(3, sx1);
+
+		/* omap2 based boards using UART1 */
+		DEBUG_LL_OMAP2(1, omap2evm);
+		DEBUG_LL_OMAP2(1, omap_2430sdp);
+		DEBUG_LL_OMAP2(1, omap_apollon);
+		DEBUG_LL_OMAP2(1, omap_h4);
+
+		/* omap2 based boards using UART3 */
+		DEBUG_LL_OMAP2(3, nokia_n800);
+		DEBUG_LL_OMAP2(3, nokia_n810);
+		DEBUG_LL_OMAP2(3, nokia_n810_wimax);
+
+		/* omap3 based boards using UART1 */
+		DEBUG_LL_OMAP2(1, omap3evm);
+		DEBUG_LL_OMAP3(1, omap_3430sdp);
+		DEBUG_LL_OMAP3(1, omap_3630sdp);
+
+		/* omap3 based boards using UART3 */
+		DEBUG_LL_OMAP3(3, cm_t35);
+		DEBUG_LL_OMAP3(3, igep0020);
+		DEBUG_LL_OMAP3(3, nokia_rx51);
+		DEBUG_LL_OMAP3(3, omap3517evm);
+		DEBUG_LL_OMAP3(3, omap3_beagle);
+		DEBUG_LL_OMAP3(3, omap3_pandora);
+		DEBUG_LL_OMAP3(3, omap_ldp);
+		DEBUG_LL_OMAP3(3, overo);
+		DEBUG_LL_OMAP3(3, touchbook);
+
+		/* omap4 based boards using UART3 */
+		DEBUG_LL_OMAP4(3, omap_4430sdp);
+
+		/* zoom2/3 external uart */
+		DEBUG_LL_ZOOM(omap_zoom2);
+		DEBUG_LL_ZOOM(omap_zoom3);
+
+	} while (0);
+}
+
+#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
+
+/*
  * nothing to do
  */
-#define arch_decomp_setup()
 #define arch_decomp_wdog()

