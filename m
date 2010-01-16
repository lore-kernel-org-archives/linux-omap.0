From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] omap: Clean the serial port defines
Date: Fri, 15 Jan 2010 17:35:10 -0800
Message-ID: <20100116013510.10065.59461.stgit@baageli.muru.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62300 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758439Ab0APBfE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 20:35:04 -0500
In-Reply-To: <20100116013205.10065.95921.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This way we don't have conflicts with the defines
with compiling in multiple omaps. Set the addresses
for uarts in struct omap_globals for the early serial
init code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/debug-macro.S |   16 +++++----
 arch/arm/mach-omap1/serial.c                   |    6 ++-
 arch/arm/mach-omap2/include/mach/debug-macro.S |   15 ++++----
 arch/arm/mach-omap2/serial.c                   |   15 ++++++--
 arch/arm/plat-omap/common.c                    |   18 ++++++++++
 arch/arm/plat-omap/include/plat/common.h       |    5 +++
 arch/arm/plat-omap/include/plat/serial.h       |   44 +++++++++++++-----------
 7 files changed, 77 insertions(+), 42 deletions(-)

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
index bf1eaf3..1c72b65 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -34,6 +34,7 @@
 #include <plat/control.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
+#include <plat/serial.h>
 
 #include <plat/clock.h>
 
@@ -233,11 +234,15 @@ static struct omap_globals omap242x_globals = {
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP2420_CTRL_BASE),
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
+	.uart1_phys	= OMAP2_UART1_BASE,
+	.uart2_phys	= OMAP2_UART2_BASE,
+	.uart3_phys	= OMAP2_UART3_BASE,
 };
 
 void __init omap2_set_globals_242x(void)
 {
 	__omap2_set_globals(&omap242x_globals);
+	omap2_set_globals_uart(&omap242x_globals);
 }
 #endif
 
@@ -251,11 +256,15 @@ static struct omap_globals omap243x_globals = {
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
+	.uart1_phys	= OMAP2_UART1_BASE,
+	.uart2_phys	= OMAP2_UART2_BASE,
+	.uart3_phys	= OMAP2_UART3_BASE,
 };
 
 void __init omap2_set_globals_243x(void)
 {
 	__omap2_set_globals(&omap243x_globals);
+	omap2_set_globals_uart(&omap243x_globals);
 }
 #endif
 
@@ -269,11 +278,15 @@ static struct omap_globals omap343x_globals = {
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
+	.uart1_phys	= OMAP3_UART1_BASE,
+	.uart2_phys	= OMAP3_UART2_BASE,
+	.uart3_phys	= OMAP3_UART3_BASE,
 };
 
 void __init omap2_set_globals_343x(void)
 {
 	__omap2_set_globals(&omap343x_globals);
+	omap2_set_globals_uart(&omap343x_globals);
 }
 #endif
 
@@ -285,6 +298,10 @@ static struct omap_globals omap4_globals = {
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
 	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
+	.uart1_phys	= OMAP4_UART1_BASE,
+	.uart2_phys	= OMAP4_UART2_BASE,
+	.uart3_phys	= OMAP4_UART3_BASE,
+	.uart4_phys	= OMAP4_UART4_BASE,
 };
 
 void __init omap2_set_globals_443x(void)
@@ -292,6 +309,7 @@ void __init omap2_set_globals_443x(void)
 	omap2_set_globals_tap(&omap4_globals);
 	omap2_set_globals_control(&omap4_globals);
 	omap2_set_globals_prcm(&omap4_globals);
+	omap2_set_globals_uart(&omap4_globals);
 }
 #endif
 
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 32c2227..a8fa0d7 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -47,6 +47,10 @@ struct omap_globals {
 	void __iomem	*prm;		/* Power and Reset Management */
 	void __iomem	*cm;		/* Clock Management */
 	void __iomem	*cm2;
+	unsigned long	uart1_phys;
+	unsigned long	uart2_phys;
+	unsigned long	uart3_phys;
+	unsigned long	uart4_phys;
 };
 
 void omap2_set_globals_242x(void);
@@ -59,6 +63,7 @@ void omap2_set_globals_tap(struct omap_globals *);
 void omap2_set_globals_sdrc(struct omap_globals *);
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
+void omap2_set_globals_uart(struct omap_globals *);
 
 /**
  * omap_test_timeout - busy-loop, testing a condition
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index f5a4a92..c7e2b85 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -15,37 +15,39 @@
 
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

