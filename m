From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] omap: Clean the serial port defines
Date: Wed, 20 Jan 2010 15:10:44 -0800
Message-ID: <20100120231044.GE23467@atomide.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
 <20100116013510.10065.59461.stgit@baageli.muru.com>
 <FCCFB4CDC6E5564B9182F639FC356087030070F290@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59773 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab0ATXKj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 18:10:39 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087030070F290@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Pandita, Vikram <vikram.pandita@ti.com> [100118 16:37]:

<snip>

> Is it possible to use the same approach as mach-omap2/ for physical address assignments?
> I like that approach.
> Refer this part from mach-omap2:
> 	+	serial_platform_data0[0].mapbase = omap2_globals->uart1_phys;
> 	+	serial_platform_data1[0].mapbase = omap2_globals->uart2_phys;
> 	+	serial_platform_data2[0].mapbase = omap2_globals->uart3_phys;	
> 
> > 		.irq		= INT_UART1,
> > 		.flags		= UPF_BOOT_AUTOCONF,
> > 		.iotype		= UPIO_MEM,

It would be possible if we had omap1_globals. But we don't have it as
the address space is so similar across all omap1 processors.

> > 		.macro	busyuart,rd,rx
> >-1001:		ldrb	\rd, [\rx, #(0x5 << 2)]	@ OMAP-1510 and friends
> >-		and	\rd, \rd, #0x60
> >-		teq	\rd, #0x60
> >-		beq	1002f
> >-		ldrb	\rd, [\rx, #(0x5 << 0)]	@ OMAP-730 only
> >-		and	\rd, \rd, #0x60
> >-		teq	\rd, #0x60
> >+1001:		ldrb	\rd, [\rx, #(UART_LSR << OMAP_PORT_SHIFT)]
> 
> Zoom2/3 kind of boards have external debug Serial port.
> For those boards and maybe others, the shift value is 1 and not OMAP_PORT_SHIFT(2).

OK, thanks for pointing that out. Let's add the shift as a variable
in debug-macro.S, see the next patch in the series.
 
> This solution is not extensible to zoom2/3 boards with external debug board uarts.
> How do we address that? 
 
It should be doable, we need to initialize zoom external uart physical
and virtual address in uncompress.h, and also initialize the shift for
it.
 
> >diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> <snip>
> >@@ -269,11 +278,15 @@ static struct omap_globals omap343x_globals = {
> > 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
> > 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
> > 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
> >+	.uart1_phys	= OMAP3_UART1_BASE,
> >+	.uart2_phys	= OMAP3_UART2_BASE,
> >+	.uart3_phys	= OMAP3_UART3_BASE,
> 
> OMAP3630 also has 4 UARTS and this same global is getting used for both 34xx and 36xx.
> This is not right.
> 
> For 3630 uart4_phys = 0x49042000

OK, updated.

> >+#define OMAP3_UART1_BASE	0x4806a000
> >+#define OMAP3_UART2_BASE	0x4806c000
> >+#define OMAP3_UART3_BASE	0x49020000
> 
> Need to add 0x4904 2000 for 3630 UART4

OK, added now. Care to look and ack the attached updated patch?

Regards,

Tony


--W/nzBZO5zC0uMSeA
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="serial-port-defines-v2.patch"

>From ecfb8e2561eb91a76797fdf38204bfa70f1d062b Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 20 Jan 2010 14:11:59 -0800
Subject: [PATCH] omap: Clean the serial port defines

This way we don't have conflicts with the defines
with compiling in multiple omaps. Set the addresses
for uarts in struct omap_globals for the early serial
init code.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index aedb746..23e4724 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -11,6 +11,10 @@
  *
 */
 
+#include <linux/serial_reg.h>
+
+#include <plat/serial.h>
+
 		.macro	addruart,rx
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
@@ -30,13 +34,13 @@
 		.endm
 
 		.macro	busyuart,rd,rx
-1001:		ldrb	\rd, [\rx, #(0x5 << 2)]	@ OMAP-1510 and friends
-		and	\rd, \rd, #0x60
-		teq	\rd, #0x60
+1001:		ldrb	\rd, [\rx, #(UART_LSR << OMAP_PORT_SHIFT)]
+		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
+		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
 		beq	1002f
-		ldrb	\rd, [\rx, #(0x5 << 0)]	@ OMAP-730 only
-		and	\rd, \rd, #0x60
-		teq	\rd, #0x60
+		ldrb	\rd, [\rx, #(UART_LSR << OMAP7XX_PORT_SHIFT)]
+		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
+		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
 		bne	1001b
 1002:
 		.endm
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 6e5207c..349de90 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -64,7 +64,7 @@ static void __init omap_serial_reset(struct plat_serial8250_port *p)
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.mapbase	= OMAP_UART1_BASE,
+		.mapbase	= OMAP1_UART1_BASE,
 		.irq		= INT_UART1,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -72,7 +72,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.uartclk	= OMAP16XX_BASE_BAUD * 16,
 	},
 	{
-		.mapbase	= OMAP_UART2_BASE,
+		.mapbase	= OMAP1_UART2_BASE,
 		.irq		= INT_UART2,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -80,7 +80,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.uartclk	= OMAP16XX_BASE_BAUD * 16,
 	},
 	{
-		.mapbase	= OMAP_UART3_BASE,
+		.mapbase	= OMAP1_UART3_BASE,
 		.irq		= INT_UART3,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 7390596..c178e68 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -68,7 +68,7 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 static void __init omap_sdp_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_36xx();
 	omap2_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 6512b21..bb1bb8f 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -27,7 +27,7 @@
 
 static void __init omap_zoom_map_io(void)
 {
-	omap2_set_globals_343x();
+	omap2_set_globals_36xx();
 	omap2_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index e9f255d..0c96e1c 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -11,6 +11,10 @@
  *
 */
 
+#include <linux/serial_reg.h>
+
+#include <plat/serial.h>
+
 		.macro	addruart,rx
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
@@ -44,15 +48,10 @@
 		.endm
 
 		.macro	busyuart,rd,rx
-1001:		ldrb	\rd, [\rx, #(0x5 << 2)]	@ OMAP-1510 and friends
-		and	\rd, \rd, #0x60
-		teq	\rd, #0x60
-		beq	1002f
-		ldrb	\rd, [\rx, #(0x5 << 0)]	@ OMAP-730 only
-		and	\rd, \rd, #0x60
-		teq	\rd, #0x60
+1001:		ldrb	\rd, [\rx, #(UART_LSR << OMAP_PORT_SHIFT)]
+		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
+		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
 		bne	1001b
-1002:
 		.endm
 
 		.macro	waituart,rd,rx
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 837b347..21e51c5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -74,7 +74,6 @@ static LIST_HEAD(uart_list);
 
 static struct plat_serial8250_port serial_platform_data0[] = {
 	{
-		.mapbase	= OMAP_UART1_BASE,
 		.irq		= 72,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -87,7 +86,6 @@ static struct plat_serial8250_port serial_platform_data0[] = {
 
 static struct plat_serial8250_port serial_platform_data1[] = {
 	{
-		.mapbase	= OMAP_UART2_BASE,
 		.irq		= 73,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -100,7 +98,6 @@ static struct plat_serial8250_port serial_platform_data1[] = {
 
 static struct plat_serial8250_port serial_platform_data2[] = {
 	{
-		.mapbase	= OMAP_UART3_BASE,
 		.irq		= 74,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -114,7 +111,6 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 #ifdef CONFIG_ARCH_OMAP4
 static struct plat_serial8250_port serial_platform_data3[] = {
 	{
-		.mapbase	= OMAP_UART4_BASE,
 		.irq		= 70,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -125,6 +121,17 @@ static struct plat_serial8250_port serial_platform_data3[] = {
 	}
 };
 #endif
+
+void __init omap2_set_globals_uart(struct omap_globals *omap2_globals)
+{
+	serial_platform_data0[0].mapbase = omap2_globals->uart1_phys;
+	serial_platform_data1[0].mapbase = omap2_globals->uart2_phys;
+	serial_platform_data2[0].mapbase = omap2_globals->uart3_phys;
+#ifdef CONFIG_ARCH_OMAP4
+	serial_platform_data3[0].mapbase = omap2_globals->uart4_phys;
+#endif
+}
+
 static inline unsigned int __serial_read_reg(struct uart_port *up,
 					   int offset)
 {
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index bf1eaf3..dddce03 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -34,6 +34,7 @@
 #include <plat/control.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
+#include <plat/serial.h>
 
 #include <plat/clock.h>
 
@@ -219,6 +220,7 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 	omap2_set_globals_sdrc(omap2_globals);
 	omap2_set_globals_control(omap2_globals);
 	omap2_set_globals_prcm(omap2_globals);
+	omap2_set_globals_uart(omap2_globals);
 }
 
 #endif
@@ -233,6 +235,9 @@ static struct omap_globals omap242x_globals = {
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP2420_CTRL_BASE),
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
+	.uart1_phys	= OMAP2_UART1_BASE,
+	.uart2_phys	= OMAP2_UART2_BASE,
+	.uart3_phys	= OMAP2_UART3_BASE,
 };
 
 void __init omap2_set_globals_242x(void)
@@ -251,6 +256,9 @@ static struct omap_globals omap243x_globals = {
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
+	.uart1_phys	= OMAP2_UART1_BASE,
+	.uart2_phys	= OMAP2_UART2_BASE,
+	.uart3_phys	= OMAP2_UART3_BASE,
 };
 
 void __init omap2_set_globals_243x(void)
@@ -259,9 +267,9 @@ void __init omap2_set_globals_243x(void)
 }
 #endif
 
-#if defined(CONFIG_ARCH_OMAP3430)
+#if defined(CONFIG_ARCH_OMAP3)
 
-static struct omap_globals omap343x_globals = {
+static struct omap_globals omap3_globals = {
 	.class	= OMAP343X_CLASS,
 	.tap	= OMAP2_L4_IO_ADDRESS(0x4830A000),
 	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
@@ -269,11 +277,21 @@ static struct omap_globals omap343x_globals = {
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
+	.uart1_phys	= OMAP3_UART1_BASE,
+	.uart2_phys	= OMAP3_UART2_BASE,
+	.uart3_phys	= OMAP3_UART3_BASE,
 };
 
 void __init omap2_set_globals_343x(void)
 {
-	__omap2_set_globals(&omap343x_globals);
+	__omap2_set_globals(&omap3_globals);
+}
+
+void __init omap2_set_globals_36xx(void)
+{
+	omap3_globals.uart4_phys = OMAP3_UART4_BASE;
+
+	__omap2_set_globals(&omap3_globals);
 }
 #endif
 
@@ -285,6 +303,10 @@ static struct omap_globals omap4_globals = {
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
 	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
+	.uart1_phys	= OMAP4_UART1_BASE,
+	.uart2_phys	= OMAP4_UART2_BASE,
+	.uart3_phys	= OMAP4_UART3_BASE,
+	.uart4_phys	= OMAP4_UART4_BASE,
 };
 
 void __init omap2_set_globals_443x(void)
@@ -292,6 +314,7 @@ void __init omap2_set_globals_443x(void)
 	omap2_set_globals_tap(&omap4_globals);
 	omap2_set_globals_control(&omap4_globals);
 	omap2_set_globals_prcm(&omap4_globals);
+	omap2_set_globals_uart(&omap4_globals);
 }
 #endif
 
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 32c2227..e04a58e 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -47,11 +47,16 @@ struct omap_globals {
 	void __iomem	*prm;		/* Power and Reset Management */
 	void __iomem	*cm;		/* Clock Management */
 	void __iomem	*cm2;
+	unsigned long	uart1_phys;
+	unsigned long	uart2_phys;
+	unsigned long	uart3_phys;
+	unsigned long	uart4_phys;
 };
 
 void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_343x(void);
+void omap2_set_globals_36xx(void);
 void omap2_set_globals_443x(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
@@ -59,6 +64,7 @@ void omap2_set_globals_tap(struct omap_globals *);
 void omap2_set_globals_sdrc(struct omap_globals *);
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
+void omap2_set_globals_uart(struct omap_globals *);
 
 /**
  * omap_test_timeout - busy-loop, testing a condition
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index f5a4a92..7f5a7a8 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -15,37 +15,40 @@
 
 #include <linux/init.h>
 
-#if defined(CONFIG_ARCH_OMAP1)
 /* OMAP1 serial ports */
-#define OMAP_UART1_BASE		0xfffb0000
-#define OMAP_UART2_BASE		0xfffb0800
-#define OMAP_UART3_BASE		0xfffb9800
-#elif defined(CONFIG_ARCH_OMAP2)
+#define OMAP1_UART1_BASE	0xfffb0000
+#define OMAP1_UART2_BASE	0xfffb0800
+#define OMAP1_UART3_BASE	0xfffb9800
+
 /* OMAP2 serial ports */
-#define OMAP_UART1_BASE		0x4806a000
-#define OMAP_UART2_BASE		0x4806c000
-#define OMAP_UART3_BASE		0x4806e000
-#elif defined(CONFIG_ARCH_OMAP3)
+#define OMAP2_UART1_BASE	0x4806a000
+#define OMAP2_UART2_BASE	0x4806c000
+#define OMAP2_UART3_BASE	0x4806e000
+
 /* OMAP3 serial ports */
-#define OMAP_UART1_BASE		0x4806a000
-#define OMAP_UART2_BASE		0x4806c000
-#define OMAP_UART3_BASE		0x49020000
-#elif defined(CONFIG_ARCH_OMAP4)
+#define OMAP3_UART1_BASE	0x4806a000
+#define OMAP3_UART2_BASE	0x4806c000
+#define OMAP3_UART3_BASE	0x49020000
+#define OMAP3_UART4_BASE	0x49042000	/* Only on 36xx */
+
 /* OMAP4 serial ports */
-#define OMAP_UART1_BASE		0x4806a000
-#define OMAP_UART2_BASE		0x4806c000
-#define OMAP_UART3_BASE		0x48020000
-#define OMAP_UART4_BASE		0x4806e000
-#endif
+#define OMAP4_UART1_BASE	0x4806a000
+#define OMAP4_UART2_BASE	0x4806c000
+#define OMAP4_UART3_BASE	0x48020000
+#define OMAP4_UART4_BASE	0x4806e000
+
+#define OMAP_PORT_SHIFT		2
+#define OMAP7XX_PORT_SHIFT	0
 
 #define OMAP1510_BASE_BAUD	(12000000/16)
 #define OMAP16XX_BASE_BAUD	(48000000/16)
 #define OMAP24XX_BASE_BAUD	(48000000/16)
 
+/* This is only used by 8250.c for omap1510 */
 #define is_omap_port(pt)	({int __ret = 0;			\
-			if ((pt)->port.mapbase == OMAP_UART1_BASE ||	\
-			    (pt)->port.mapbase == OMAP_UART2_BASE ||	\
-			    (pt)->port.mapbase == OMAP_UART3_BASE)	\
+			if ((pt)->port.mapbase == OMAP1_UART1_BASE ||	\
+			    (pt)->port.mapbase == OMAP1_UART2_BASE ||	\
+			    (pt)->port.mapbase == OMAP1_UART3_BASE)	\
 				__ret = 1;				\
 			__ret;						\
 			})
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 13c305d..e5723c3 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -40,12 +40,13 @@ static void putc(int c)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP
+	/* Will get removed in the next patch, set to OMAP3 to compile */
 #ifdef	CONFIG_OMAP_LL_DEBUG_UART3
-	uart = (volatile u8 *)(OMAP_UART3_BASE);
+	uart = (volatile u8 *)(OMAP3_UART3_BASE);
 #elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
-	uart = (volatile u8 *)(OMAP_UART2_BASE);
+	uart = (volatile u8 *)(OMAP3_UART2_BASE);
 #elif defined(CONFIG_OMAP_LL_DEBUG_UART1)
-	uart = (volatile u8 *)(OMAP_UART1_BASE);
+	uart = (volatile u8 *)(OMAP3_UART1_BASE);
 #elif defined(CONFIG_OMAP_LL_DEBUG_NONE)
 	return;
 #else

--W/nzBZO5zC0uMSeA--
