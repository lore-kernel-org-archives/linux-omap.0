From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic
Date: Fri, 15 Jan 2010 17:35:15 -0800
Message-ID: <20100116013515.10065.30649.stgit@baageli.muru.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62356 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758563Ab0APBfF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 20:35:05 -0500
In-Reply-To: <20100116013205.10065.95921.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Define arch_decomp_setup() the same way as some other
architectures do. Use arch_id to configure the debug uart
based on the machine_is by storing it into the uart
scratchpad register for DEBUG_LL code to use.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/debug-macro.S |   67 +++++++++-
 arch/arm/mach-omap1/serial.c                   |   12 ++
 arch/arm/mach-omap2/include/mach/debug-macro.S |   76 ++++++++---
 arch/arm/mach-omap2/serial.c                   |   11 ++
 arch/arm/plat-omap/include/plat/serial.h       |   18 +++
 arch/arm/plat-omap/include/plat/uncompress.h   |  168 +++++++++++++++++-------
 6 files changed, 276 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index 23e4724..0174858 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -15,18 +15,71 @@
 
 #include <plat/serial.h>
 
+omap_uart_phys:	.word	0x0
+omap_uart_virt:	.word	0x0
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
+		ldreq	\rx, omap_uart_phys	@ physical base address
+		ldrne	\rx, omap_uart_virt	@ virtual base
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
+		str	\rx, omap_uart_phys
+		sub	\rx, \rx, #0xff000000	@ phys base
+		add	\rx, \rx, #0xfe000000	@ virt base
+		str	\rx, omap_uart_virt
+		b	9b
+99:
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 349de90..c36de59 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -52,6 +52,15 @@ static inline void omap_serial_outp(struct plat_serial8250_port *p, int offset,
  */
 static void __init omap_serial_reset(struct plat_serial8250_port *p)
 {
+	u8 scratchpad = 0;
+
+	/*
+	 * Save UART1 scratchpad register value for UART1 for DEBUG_LL.
+	 * See also include/plat/uncompress.h and include/mach/debug-macro.S.
+	 */
+	if (p->mapbase == OMAP1_UART1_BASE)
+		scratchpad = omap_serial_in(p, UART_SCR);
+
 	omap_serial_outp(p, UART_OMAP_MDR1, 0x07);	/* disable UART */
 	omap_serial_outp(p, UART_OMAP_SCR, 0x08);	/* TX watermark */
 	omap_serial_outp(p, UART_OMAP_MDR1, 0x00);	/* enable UART */
@@ -60,6 +69,9 @@ static void __init omap_serial_reset(struct plat_serial8250_port *p)
 		omap_serial_outp(p, UART_OMAP_SYSC, 0x01);
 		while (!(omap_serial_in(p, UART_OMAP_SYSC) & 0x01));
 	}
+
+	if (p->mapbase == OMAP1_UART1_BASE)
+		omap_serial_outp(p, UART_SCR, scratchpad);
 }
 
 static struct plat_serial8250_port serial_platform_data[] = {
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 0c96e1c..1b83584 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -15,32 +15,66 @@
 
 #include <plat/serial.h>
 
+omap_uart_phys:	.word	0x0
+omap_uart_virt:	.word	0x0
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
+		ldreq	\rx, omap_uart_phys	@ physical base address
+		ldrne	\rx, omap_uart_virt	@ virtual base
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
+
+		/* Configure the UART offset from the phys/virt base */
+21:		mov	\rx, #0x0006a000	@ OMAP2/3/4UART1
+		b	98f
+22:		mov	\rx, #0x0006a000
+		add	\rx, \rx, #0x00002000	@ OMAP2/3/4UART2
+		b	98f
+23:		mov	\rx, #0x0006a000	@ OMAP2/3/4UART1
+		add	\rx, \rx, #0x00004000	@ OMAP2UART3
+		b	98f
+33:		mov	\rx, #0x0006a000	@ OMAP2/3/4UART1
+		add	\rx, \rx, #0x00fb0000
+		add	\rx, \rx, #0x00006000	@ OMAP3UART3
+
+		/* Store both phys and virt address for the uart */
+98:		add	\rx, \rx, #0x48000000	@ phys base
+		str	\rx, omap_uart_phys
+		sub	\rx, \rx, #0x48000000	@ phys base
+		add	\rx, \rx, #0xfa000000	@ virt base
+		str	\rx, omap_uart_virt
+		b	10b
+99:
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 21e51c5..48157ce 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -161,11 +161,22 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
 static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 {
 	struct plat_serial8250_port *p = uart->p;
+	u8 scratchpad = 0;
+
+	/*
+	 * Save UART1 scratchpad register value for UART1 for DEBUG_LL.
+	 * See also include/plat/uncompress.h and include/mach/debug-macro.S.
+	 */
+	if (p->mapbase == OMAP2_UART1_BASE)	/* OMAP2/3/4UART1_BASE */
+		scratchpad = serial_read_reg(p, UART_SCR);
 
 	serial_write_reg(p, UART_OMAP_MDR1, 0x07);
 	serial_write_reg(p, UART_OMAP_SCR, 0x08);
 	serial_write_reg(p, UART_OMAP_MDR1, 0x00);
 	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
+
+	if (p->mapbase == OMAP2_UART1_BASE)	/* OMAP2/3/4UART1_BASE */
+		serial_write_reg(p, UART_SCR, scratchpad);
 }
 
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index c7e2b85..327362a 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -43,6 +43,24 @@
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
+#define OMAP4UART1		OMAP2UART1
+#define OMAP4UART2		OMAP2UART2
+#define OMAP4UART3		43
+#define OMAP4UART4		44
+
 /* This is only used by 8250.c for omap1510 */
 #define is_omap_port(pt)	({int __ret = 0;			\
 			if ((pt)->port.mapbase == OMAP1_UART1_BASE ||	\
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 13c305d..479bac8 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -19,62 +19,36 @@
 
 #include <linux/types.h>
 #include <linux/serial_reg.h>
+
+#include <asm/mach-types.h>
+
 #include <plat/serial.h>
 
-unsigned int system_rev;
+static volatile u8 *uart1_base;
+static volatile u8 *uart_base;
+static volatile int uart_shift;
 
-#define UART_OMAP_MDR1		0x08	/* mode definition register */
-#define OMAP_ID_730		0x355F
-#define OMAP_ID_850		0x362C
-#define ID_MASK			0x7fff
-#define check_port(base, shift) ((base[UART_OMAP_MDR1 << shift] & 7) == 0)
-#define omap_get_id() ((*(volatile unsigned int *)(0xfffed404)) >> 12) & ID_MASK
+/*
+ * Store the DEBUG_LL uart number into UART1 scratchpad register.
+ * See also debug-macro.S, and serial.c for related code.
+ *
+ * Please note that we currently assume that:
+ * - UART1 clocks are enabled for register access
+ * - UART1 scratchpad register can be used
+ */
+static void set_uart1_scratchpad(unsigned char port)
+{
+	uart1_base[UART_SCR << uart_shift] = port;
+}
 
 static void putc(int c)
 {
-	volatile u8 * uart = 0;
-	int shift = 2;
-
-#ifdef CONFIG_MACH_OMAP_PALMTE
-	return;
-#endif
-
-#ifdef CONFIG_ARCH_OMAP
-#ifdef	CONFIG_OMAP_LL_DEBUG_UART3
-	uart = (volatile u8 *)(OMAP_UART3_BASE);
-#elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
-	uart = (volatile u8 *)(OMAP_UART2_BASE);
-#elif defined(CONFIG_OMAP_LL_DEBUG_UART1)
-	uart = (volatile u8 *)(OMAP_UART1_BASE);
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
-
-		if (check_port(uart, shift))
-			break;
-		/* Silent boot if no serial ports are enabled. */
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
@@ -82,7 +56,105 @@ static inline void flush(void)
 }
 
 /*
+ * Macros to configure UART1 and debug UART
+ */
+#define _DEBUG_LL_ENTRY(mach, uart1, dbg_uart, shift, dbg_id, reset_fn)	\
+	if (machine_is_##mach()) {					\
+		uart1_base = (volatile u8 *)(uart1);			\
+		uart_base = (volatile u8 *)(dbg_uart);			\
+		uart_shift = (shift);					\
+		port = (dbg_id);					\
+		reset_fn;						\
+		break;							\
+	}
+
+#define DEBUG_LL_OMAP7XX(p, mach)					\
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART1_BASE, OMAP1_UART##p##_BASE,	\
+		OMAP7XX_PORT_SHIFT, OMAP1UART##p, set_uart1_scratchpad(port))
+
+#define DEBUG_LL_OMAP1(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART1_BASE, OMAP1_UART##p##_BASE,	\
+		OMAP_PORT_SHIFT, OMAP1UART##p, set_uart1_scratchpad(port))
+
+#define DEBUG_LL_OMAP2(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP2_UART1_BASE, OMAP2_UART##p##_BASE,	\
+		OMAP_PORT_SHIFT, OMAP2UART##p, set_uart1_scratchpad(port))
+
+#define DEBUG_LL_OMAP3(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP3_UART1_BASE, OMAP3_UART##p##_BASE,	\
+		OMAP_PORT_SHIFT, OMAP3UART##p, set_uart1_scratchpad(port))
+
+#define DEBUG_LL_OMAP4(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP4_UART1_BASE, OMAP4_UART##p##_BASE,	\
+		OMAP_PORT_SHIFT, OMAP4UART##p, set_uart1_scratchpad(port))
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

