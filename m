From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>
Subject: [PATCH] serial: Add driver for OMAP UARTs
Date: Mon, 9 Apr 2007 23:44:33 +0300
Message-ID: <20070409204433.GA23320@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>From 1b812d197f1451fc03335a999472a25e8c1830c6 Mon Sep 17 00:00:00 2001
From: Juha Yrjola <juha.yrjola@solidboot.com>
Date: Mon, 9 Apr 2007 23:43:34 +0300
Subject: [PATCH] serial: Add driver for OMAP UARTs

An OMAP-specific UART driver is needed when support for advanced
functionality (such as DMA transfers and power management) is added.
Currently it helps to work around UART initialization bugs at least
in the OMAP2420 silicon.

Only OMAP24xx CPUs are supported at the moment, although adding
support for OMAP1 should not be a big deal.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
---
 arch/arm/configs/n800_defconfig              |    8 +-
 arch/arm/configs/omap_2430sdp_defconfig      |   12 +-
 arch/arm/configs/omap_apollon_2420_defconfig |   12 +-
 arch/arm/configs/omap_generic_2420_defconfig |    7 +-
 arch/arm/configs/omap_h4_2420_defconfig      |   12 +-
 arch/arm/mach-omap2/serial.c                 |  190 ++----
 drivers/serial/Kconfig                       |   23 +
 drivers/serial/Makefile                      |    1 +
 drivers/serial/omap.c                        |  893 ++++++++++++++++++++++++++
 include/linux/serial_core.h                  |    2 +
 10 files changed, 994 insertions(+), 166 deletions(-)
 create mode 100644 drivers/serial/omap.c

diff --git a/arch/arm/configs/n800_defconfig b/arch/arm/configs/n800_defconfig
index 6664184..aa18816 100644
--- a/arch/arm/configs/n800_defconfig
+++ b/arch/arm/configs/n800_defconfig
@@ -762,15 +762,13 @@ CONFIG_HW_CONSOLE=y
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_OMAP=y
+CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/omap_2430sdp_defconfig b/arch/arm/configs/omap_2430sdp_defconfig
index 19d49b0..c560f95 100644
--- a/arch/arm/configs/omap_2430sdp_defconfig
+++ b/arch/arm/configs/omap_2430sdp_defconfig
@@ -673,19 +673,13 @@ CONFIG_HW_CONSOLE=y
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=32
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
-CONFIG_SERIAL_8250_EXTENDED=y
-CONFIG_SERIAL_8250_MANY_PORTS=y
-CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_SERIAL_8250_DETECT_IRQ=y
-CONFIG_SERIAL_8250_RSA=y
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_OMAP=y
+CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/omap_apollon_2420_defconfig b/arch/arm/configs/omap_apollon_2420_defconfig
index 2cef064..fe25bcc 100644
--- a/arch/arm/configs/omap_apollon_2420_defconfig
+++ b/arch/arm/configs/omap_apollon_2420_defconfig
@@ -600,19 +600,13 @@ CONFIG_HW_CONSOLE=y
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=32
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
-CONFIG_SERIAL_8250_EXTENDED=y
-CONFIG_SERIAL_8250_MANY_PORTS=y
-CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_SERIAL_8250_DETECT_IRQ=y
-CONFIG_SERIAL_8250_RSA=y
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_OMAP=y
+CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/omap_generic_2420_defconfig b/arch/arm/configs/omap_generic_2420_defconfig
index 94d4659..2bd1552 100644
--- a/arch/arm/configs/omap_generic_2420_defconfig
+++ b/arch/arm/configs/omap_generic_2420_defconfig
@@ -322,14 +322,13 @@ CONFIG_HW_CONSOLE=y
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_OMAP=y
+CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/omap_h4_2420_defconfig b/arch/arm/configs/omap_h4_2420_defconfig
index 8ef2d68..bb30278 100644
--- a/arch/arm/configs/omap_h4_2420_defconfig
+++ b/arch/arm/configs/omap_h4_2420_defconfig
@@ -659,19 +659,13 @@ CONFIG_HW_CONSOLE=y
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=32
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
-CONFIG_SERIAL_8250_EXTENDED=y
-CONFIG_SERIAL_8250_MANY_PORTS=y
-CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_SERIAL_8250_DETECT_IRQ=y
-CONFIG_SERIAL_8250_RSA=y
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_OMAP=y
+CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index e9c367f..a76f44a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -14,82 +14,79 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/ioport.h>
 
 #include <asm/io.h>
 
-#include <asm/arch/common.h>
+#include <asm/arch/serial.h>
 #include <asm/arch/board.h>
 
-static struct clk * uart1_ick = NULL;
-static struct clk * uart1_fck = NULL;
-static struct clk * uart2_ick = NULL;
-static struct clk * uart2_fck = NULL;
-static struct clk * uart3_ick = NULL;
-static struct clk * uart3_fck = NULL;
-
-static struct plat_serial8250_port serial_platform_data[] = {
+static struct resource omap2_uart1_resources[] = {
 	{
-		.membase	= (char *)IO_ADDRESS(OMAP_UART1_BASE),
-		.mapbase	= (unsigned long)OMAP_UART1_BASE,
-		.irq		= 72,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.start		= OMAP_UART1_BASE,
+		.end		= OMAP_UART1_BASE + 0x3ff,
+		.flags		= IORESOURCE_MEM,
 	}, {
-		.membase	= (char *)IO_ADDRESS(OMAP_UART2_BASE),
-		.mapbase	= (unsigned long)OMAP_UART2_BASE,
-		.irq		= 73,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.start		= 72,
+		.flags		= IORESOURCE_IRQ,
+	}
+};
+
+static struct resource omap2_uart2_resources[] = {
+	{
+		.start		= OMAP_UART2_BASE,
+		.end		= OMAP_UART2_BASE + 0x3ff,
+		.flags		= IORESOURCE_MEM,
 	}, {
-		.membase	= (char *)IO_ADDRESS(OMAP_UART3_BASE),
-		.mapbase	= (unsigned long)OMAP_UART3_BASE,
-		.irq		= 74,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP16XX_BASE_BAUD * 16,
+		.start		= 73,
+		.flags		= IORESOURCE_IRQ,
+	}
+};
+
+static struct resource omap2_uart3_resources[] = {
+	{
+		.start		= OMAP_UART3_BASE,
+		.end		= OMAP_UART3_BASE + 0x3ff,
+		.flags		= IORESOURCE_MEM,
 	}, {
-		.flags		= 0
+		.start		= 74,
+		.flags		= IORESOURCE_IRQ,
 	}
 };
 
-static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
-					   int offset)
-{
-	offset <<= up->regshift;
-	return (unsigned int)__raw_readb(up->membase + offset);
-}
+static struct platform_device uart1_device = {
+	.name			= "omap-uart",
+	.id			= 1,
+	.num_resources		= ARRAY_SIZE(omap2_uart1_resources),
+	.resource		= omap2_uart1_resources,
+};
 
-static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
-				    int value)
-{
-	offset <<= p->regshift;
-	__raw_writeb(value, (unsigned long)(p->membase + offset));
-}
+static struct platform_device uart2_device = {
+	.name			= "omap-uart",
+	.id			= 2,
+	.num_resources		= ARRAY_SIZE(omap2_uart2_resources),
+	.resource		= omap2_uart2_resources,
+};
 
-/*
- * Internal UARTs need to be initialized for the 8250 autoconfig to work
- * properly. Note that the TX watermark initialization may not be needed
- * once the 8250.c watermark handling code is merged.
- */
-static inline void __init omap_serial_reset(struct plat_serial8250_port *p)
-{
-	serial_write_reg(p, UART_OMAP_MDR1, 0x07);
-	serial_write_reg(p, UART_OMAP_SCR, 0x08);
-	serial_write_reg(p, UART_OMAP_MDR1, 0x00);
-	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
-}
+static struct platform_device uart3_device = {
+	.name			= "omap-uart",
+	.id			= 3,
+	.num_resources		= ARRAY_SIZE(omap2_uart3_resources),
+	.resource		= omap2_uart3_resources,
+};
+
+static struct platform_device *uart_devices[] = {
+	&uart1_device,
+	&uart2_device,
+	&uart3_device
+};
 
-void __init omap_serial_init()
+void __init omap_serial_init(void)
 {
-	int i;
+	int i, r;
 	const struct omap_uart_config *info;
 
 	/*
@@ -100,81 +97,14 @@ void __init omap_serial_init()
 
 	info = omap_get_config(OMAP_TAG_UART,
 			       struct omap_uart_config);
-
 	if (info == NULL)
 		return;
 
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
-		struct plat_serial8250_port *p = serial_platform_data + i;
-
-		if (!(info->enabled_uarts & (1 << i))) {
-			p->membase = 0;
-			p->mapbase = 0;
+	for (i = 0; i < ARRAY_SIZE(uart_devices); i++) {
+		if (!(info->enabled_uarts & (1 << i)))
 			continue;
-		}
-
-		switch (i) {
-		case 0:
-			uart1_ick = clk_get(NULL, "uart1_ick");
-			if (IS_ERR(uart1_ick))
-				printk("Could not get uart1_ick\n");
-			else {
-				clk_enable(uart1_ick);
-			}
-
-			uart1_fck = clk_get(NULL, "uart1_fck");
-			if (IS_ERR(uart1_fck))
-				printk("Could not get uart1_fck\n");
-			else {
-				clk_enable(uart1_fck);
-			}
-			break;
-		case 1:
-			uart2_ick = clk_get(NULL, "uart2_ick");
-			if (IS_ERR(uart2_ick))
-				printk("Could not get uart2_ick\n");
-			else {
-				clk_enable(uart2_ick);
-			}
-
-			uart2_fck = clk_get(NULL, "uart2_fck");
-			if (IS_ERR(uart2_fck))
-				printk("Could not get uart2_fck\n");
-			else {
-				clk_enable(uart2_fck);
-			}
-			break;
-		case 2:
-			uart3_ick = clk_get(NULL, "uart3_ick");
-			if (IS_ERR(uart3_ick))
-				printk("Could not get uart3_ick\n");
-			else {
-				clk_enable(uart3_ick);
-			}
-
-			uart3_fck = clk_get(NULL, "uart3_fck");
-			if (IS_ERR(uart3_fck))
-				printk("Could not get uart3_fck\n");
-			else {
-				clk_enable(uart3_fck);
-			}
-			break;
-		}
-
-		omap_serial_reset(p);
+		r = platform_device_register(uart_devices[i]);
+		if (r < 0)
+			printk("Failed to register UART%d\n", i + 1);
 	}
 }
-
-static struct platform_device serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= serial_platform_data,
-	},
-};
-
-static int __init omap_init(void)
-{
-	return platform_device_register(&serial_device);
-}
-arch_initcall(omap_init);
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ad9f321..edca795 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -474,6 +474,29 @@ config SERIAL_PXA_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
+config SERIAL_OMAP
+	bool "OMAP serial port support"
+	depends on ARM && ARCH_OMAP
+	select SERIAL_CORE
+	help
+	  If you have a machine based on an Texas Instruments OMAP CPU you
+	  can enable its onboard serial ports by enabling this option.
+
+config SERIAL_OMAP_CONSOLE
+	bool "Console on OMAP serial port"
+	depends on SERIAL_OMAP
+	select SERIAL_CORE_CONSOLE
+	help
+	  If you have enabled the serial port on the Texas Instruments OMAP
+	  CPU you can make it the console by answering Y to this option.
+
+	  Even if you say Y here, the currently visible virtual console
+	  (/dev/tty0) will still be used as the system console by default, but
+	  you can alter that using a kernel command line option such as
+	  "console=ttyS0". (Try "man bootparam" or see the documentation of
+	  your boot loader (lilo or loadlin) about how to pass options to the
+	  kernel at boot time.)
+
 config SERIAL_SA1100
 	bool "SA1100 serial port support"
 	depends on ARM && ARCH_SA1100
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 6b3560c..5d9f6d4 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
 obj-$(CONFIG_SERIAL_PXA) += pxa.o
+obj-$(CONFIG_SERIAL_OMAP) += omap.o
 obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
 obj-$(CONFIG_SERIAL_S3C2410) += s3c2410.o
diff --git a/drivers/serial/omap.c b/drivers/serial/omap.c
new file mode 100644
index 0000000..db53951
--- /dev/null
+++ b/drivers/serial/omap.c
@@ -0,0 +1,893 @@
+/*
+ *  linux/drivers/serial/omap.c
+ *
+ *
+ *  Copyright (C) 2007 Nokia Corporation
+ *  Author: Juha Yrjola
+ *
+ *  Based on drivers/serial/pxa.c by Nicolas Pitre.
+ *  Copyright (C) 2003 Monta Vista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#if defined(CONFIG_SERIAL_OMAP_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/sysrq.h>
+#include <linux/serial_reg.h>
+#include <linux/circ_buf.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial_core.h>
+#include <linux/clk.h>
+
+#include <asm/io.h>
+#include <asm/hardware.h>
+#include <asm/irq.h>
+
+struct uart_omap_port {
+	struct uart_port	port;
+	int			shift;
+	struct clk		*iclk, *fclk;
+
+	struct platform_device	*pdev;
+
+	unsigned char		ier;
+	unsigned char		lcr;
+	unsigned char		mcr;
+	unsigned int		lsr_break_flag;
+	char			name[12];
+};
+
+static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
+{
+	offset <<= up->shift;
+	return readb(up->port.membase + offset);
+}
+
+static inline void serial_out(struct uart_omap_port *up, int offset, int value)
+{
+	offset <<= up->shift;
+	writeb(value, up->port.membase + offset);
+}
+
+static void enable_uart_clocks(struct uart_omap_port *up)
+{
+	clk_enable(up->fclk);
+	if (up->iclk != NULL)
+		clk_enable(up->iclk);
+}
+
+static void disable_uart_clocks(struct uart_omap_port *up)
+{
+	clk_disable(up->fclk);
+	if (up->iclk != NULL)
+		clk_disable(up->iclk);
+}
+
+static void serial_omap_enable_ms(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+
+	up->ier |= UART_IER_MSI;
+	serial_out(up, UART_IER, up->ier);
+}
+
+static void serial_omap_stop_tx(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+
+	if (up->ier & UART_IER_THRI) {
+		up->ier &= ~UART_IER_THRI;
+		serial_out(up, UART_IER, up->ier);
+	}
+}
+
+static void serial_omap_stop_rx(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+
+	up->ier &= ~UART_IER_RLSI;
+	up->port.read_status_mask &= ~UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+}
+
+static inline void receive_chars(struct uart_omap_port *up, int *status)
+{
+	struct tty_struct *tty = up->port.info->tty;
+	unsigned int ch, flag;
+	int max_count = 256;
+
+	do {
+		ch = serial_in(up, UART_RX);
+		flag = TTY_NORMAL;
+		up->port.icount.rx++;
+
+		if (unlikely(*status & (UART_LSR_BI | UART_LSR_PE |
+				       UART_LSR_FE | UART_LSR_OE))) {
+			/*
+			 * For statistics only
+			 */
+			if (*status & UART_LSR_BI) {
+				*status &= ~(UART_LSR_FE | UART_LSR_PE);
+				up->port.icount.brk++;
+				/*
+				 * We do the SysRQ and SAK checking
+				 * here because otherwise the break
+				 * may get masked by ignore_status_mask
+				 * or read_status_mask.
+				 */
+				if (uart_handle_break(&up->port))
+					goto ignore_char;
+			} else if (*status & UART_LSR_PE)
+				up->port.icount.parity++;
+			else if (*status & UART_LSR_FE)
+				up->port.icount.frame++;
+			if (*status & UART_LSR_OE)
+				up->port.icount.overrun++;
+
+			/*
+			 * Mask off conditions which should be ignored.
+			 */
+			*status &= up->port.read_status_mask;
+
+#ifdef CONFIG_SERIAL_OMAP_CONSOLE
+			if (up->port.line == up->port.cons->index) {
+				/* Recover the break flag from console xmit */
+				*status |= up->lsr_break_flag;
+				up->lsr_break_flag = 0;
+			}
+#endif
+			if (*status & UART_LSR_BI) {
+				flag = TTY_BREAK;
+			} else if (*status & UART_LSR_PE)
+				flag = TTY_PARITY;
+			else if (*status & UART_LSR_FE)
+				flag = TTY_FRAME;
+		}
+
+		if (uart_handle_sysrq_char(&up->port, ch))
+			goto ignore_char;
+
+		uart_insert_char(&up->port, *status, UART_LSR_OE, ch, flag);
+
+	ignore_char:
+		*status = serial_in(up, UART_LSR);
+	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
+	tty_flip_buffer_push(tty);
+}
+
+static void transmit_chars(struct uart_omap_port *up)
+{
+	struct circ_buf *xmit = &up->port.info->xmit;
+	int count;
+
+	if (up->port.x_char) {
+		serial_out(up, UART_TX, up->port.x_char);
+		up->port.icount.tx++;
+		up->port.x_char = 0;
+		return;
+	}
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
+		serial_omap_stop_tx(&up->port);
+		return;
+	}
+
+	count = 16;
+	do {
+		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		up->port.icount.tx++;
+		if (uart_circ_empty(xmit))
+			break;
+	} while (--count > 0);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&up->port);
+
+	if (uart_circ_empty(xmit))
+		serial_omap_stop_tx(&up->port);
+}
+
+static void serial_omap_start_tx(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+
+	if (!(up->ier & UART_IER_THRI)) {
+		up->ier |= UART_IER_THRI;
+		serial_out(up, UART_IER, up->ier);
+	}
+}
+
+static inline void check_modem_status(struct uart_omap_port *up)
+{
+	int status;
+
+	status = serial_in(up, UART_MSR);
+
+	if ((status & UART_MSR_ANY_DELTA) == 0)
+		return;
+
+	if (status & UART_MSR_TERI)
+		up->port.icount.rng++;
+	if (status & UART_MSR_DDSR)
+		up->port.icount.dsr++;
+	if (status & UART_MSR_DDCD)
+		uart_handle_dcd_change(&up->port, status & UART_MSR_DCD);
+	if (status & UART_MSR_DCTS)
+		uart_handle_cts_change(&up->port, status & UART_MSR_CTS);
+
+	wake_up_interruptible(&up->port.info->delta_msr_wait);
+}
+
+/*
+ * This handles the interrupt from one port.
+ */
+static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
+{
+	struct uart_omap_port *up = dev_id;
+	unsigned int iir, lsr;
+
+	iir = serial_in(up, UART_IIR);
+	if (iir & UART_IIR_NO_INT)
+		return IRQ_NONE;
+	lsr = serial_in(up, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		receive_chars(up, &lsr);
+	check_modem_status(up);
+	if (lsr & UART_LSR_THRE)
+		transmit_chars(up);
+	return IRQ_HANDLED;
+}
+
+static unsigned int serial_omap_tx_empty(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	return ret;
+}
+
+static unsigned int serial_omap_get_mctrl(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned char status;
+	unsigned int ret;
+
+	status = serial_in(up, UART_MSR);
+
+	ret = 0;
+	if (status & UART_MSR_DCD)
+		ret |= TIOCM_CAR;
+	if (status & UART_MSR_RI)
+		ret |= TIOCM_RNG;
+	if (status & UART_MSR_DSR)
+		ret |= TIOCM_DSR;
+	if (status & UART_MSR_CTS)
+		ret |= TIOCM_CTS;
+	return ret;
+}
+
+static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned char mcr = 0;
+
+	if (mctrl & TIOCM_RTS)
+		mcr |= UART_MCR_RTS;
+	if (mctrl & TIOCM_DTR)
+		mcr |= UART_MCR_DTR;
+	if (mctrl & TIOCM_OUT1)
+		mcr |= UART_MCR_OUT1;
+	if (mctrl & TIOCM_OUT2)
+		mcr |= UART_MCR_OUT2;
+	if (mctrl & TIOCM_LOOP)
+		mcr |= UART_MCR_LOOP;
+
+	mcr |= up->mcr;
+
+	serial_out(up, UART_MCR, mcr);
+}
+
+static void serial_omap_break_ctl(struct uart_port *port, int break_state)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	if (break_state == -1)
+		up->lcr |= UART_LCR_SBC;
+	else
+		up->lcr &= ~UART_LCR_SBC;
+	serial_out(up, UART_LCR, up->lcr);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static int serial_omap_startup(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned long flags;
+	int retval;
+
+	enable_uart_clocks(up);
+
+	/*
+	 * Allocate the IRQ
+	 */
+	retval = request_irq(up->port.irq, serial_omap_irq, 0, up->name, up);
+	if (retval) {
+		disable_uart_clocks(up);
+		return retval;
+	}
+
+	/* Stop the baud clock */
+	serial_out(up, UART_LCR, 1 << 7);
+	serial_out(up, UART_DLL, 0);
+	serial_out(up, UART_DLM, 0);
+	serial_out(up, UART_LCR, 0);
+
+	/* Reset the UART */
+	serial_out(up, UART_OMAP_MDR1, 0x07);
+	udelay(50);
+	serial_out(up, UART_OMAP_MDR1, 0x00);
+
+	/* Enable access to EFR */
+	serial_out(up, UART_LCR, 0xbf);
+	/* Enable access to extra features */
+	serial_out(up, UART_EFR, 1 << 4);
+	/* Enable sleep mode */
+	serial_out(up, UART_IER, 1 << 4);
+
+	/* Set FIFO triggering */
+	serial_out(up, UART_SCR, 0x00);
+	serial_out(up, UART_FCR, (0x01 << 6) | (0x01 << 4) |
+		   UART_FCR_ENABLE_FIFO);
+	serial_out(up, UART_FCR, (0x01 << 6) | (0x01 << 4) |
+		   UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT |
+		   UART_FCR_ENABLE_FIFO);
+	udelay(50);
+
+	/* Disable access to extra features */
+	serial_out(up, UART_EFR, 0);
+
+	serial_out(up, UART_FCR, 0);
+	serial_out(up, UART_LCR, 0x00);
+
+	/*
+	 * Clear the interrupt registers.
+	 */
+	(void) serial_in(up, UART_LSR);
+	(void) serial_in(up, UART_RX);
+	(void) serial_in(up, UART_IIR);
+	(void) serial_in(up, UART_MSR);
+
+	/*
+	 * Now, initialize the UART
+	 */
+	serial_out(up, UART_LCR, UART_LCR_WLEN8);
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	up->port.mctrl |= TIOCM_OUT2;
+	serial_omap_set_mctrl(&up->port, up->port.mctrl);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	/*
+	 * Finally, enable interrupts.  Note: Modem status interrupts
+	 * are set via set_termios(), which will be occurring imminently
+	 * anyway, so we don't enable them here.
+	 */
+	up->ier = UART_IER_RLSI | UART_IER_RDI | UART_IER_RTOIE;
+	serial_out(up, UART_IER, up->ier);
+
+	/*
+	 * And clear the interrupt registers again for luck.
+	 */
+	(void) serial_in(up, UART_LSR);
+	(void) serial_in(up, UART_RX);
+	(void) serial_in(up, UART_IIR);
+	(void) serial_in(up, UART_MSR);
+
+	return 0;
+}
+
+static void serial_omap_shutdown(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned long flags;
+
+	free_irq(up->port.irq, up);
+
+	/*
+	 * Disable interrupts from this port
+	 */
+	up->ier = 0;
+	serial_out(up, UART_IER, 0);
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	up->port.mctrl &= ~TIOCM_OUT2;
+	serial_omap_set_mctrl(&up->port, up->port.mctrl);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	/*
+	 * Disable break condition and FIFOs
+	 */
+	serial_out(up, UART_LCR, serial_in(up, UART_LCR) & ~UART_LCR_SBC);
+	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO |
+				  UART_FCR_CLEAR_RCVR |
+				  UART_FCR_CLEAR_XMIT);
+	serial_out(up, UART_FCR, 0);
+
+	disable_uart_clocks(up);
+
+	clk_put(up->fclk);
+	if (up->iclk != NULL)
+		clk_put(up->iclk);
+}
+
+static void
+serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
+			struct ktermios *old)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned char cval, fcr = 0;
+	unsigned long flags;
+	unsigned int baud, quot;
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		cval = UART_LCR_WLEN5;
+		break;
+	case CS6:
+		cval = UART_LCR_WLEN6;
+		break;
+	case CS7:
+		cval = UART_LCR_WLEN7;
+		break;
+	default:
+	case CS8:
+		cval = UART_LCR_WLEN8;
+		break;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		cval |= UART_LCR_STOP;
+	if (termios->c_cflag & PARENB)
+		cval |= UART_LCR_PARITY;
+	if (!(termios->c_cflag & PARODD))
+		cval |= UART_LCR_EPAR;
+
+	/*
+	 * Ask the core to calculate the divisor for us.
+	 */
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
+	quot = uart_get_divisor(port, baud);
+
+	fcr = (0x01 << 6) | (0x01 << 4) | UART_FCR_ENABLE_FIFO;
+
+	/*
+	 * Ok, we're now changing the port state.  Do it with
+	 * interrupts disabled.
+	 */
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	/*
+	 * Update the per-port timeout.
+	 */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	up->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
+	if (termios->c_iflag & INPCK)
+		up->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		up->port.read_status_mask |= UART_LSR_BI;
+
+	/*
+	 * Characters to ignore
+	 */
+	up->port.ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		up->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
+	if (termios->c_iflag & IGNBRK) {
+		up->port.ignore_status_mask |= UART_LSR_BI;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			up->port.ignore_status_mask |= UART_LSR_OE;
+	}
+
+	/*
+	 * ignore all characters if CREAD is not set
+	 */
+	if ((termios->c_cflag & CREAD) == 0)
+		up->port.ignore_status_mask |= UART_LSR_DR;
+
+	/*
+	 * CTS flow control flag and modem status interrupts
+	 */
+	up->ier &= ~UART_IER_MSI;
+	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
+		up->ier |= UART_IER_MSI;
+
+	serial_out(up, UART_IER, up->ier);
+
+	serial_out(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
+	serial_out(up, UART_DLL, quot & 0xff);		/* LS of divisor */
+	serial_out(up, UART_DLM, quot >> 8);		/* MS of divisor */
+	serial_out(up, UART_LCR, cval);		/* reset DLAB */
+	up->lcr = cval;					/* Save LCR */
+	serial_omap_set_mctrl(&up->port, up->port.mctrl);
+	serial_out(up, UART_FCR, fcr);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static void
+serial_omap_pm(struct uart_port *port, unsigned int state,
+	       unsigned int oldstate)
+{
+}
+
+static void serial_omap_release_port(struct uart_port *port)
+{
+}
+
+static int serial_omap_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void serial_omap_config_port(struct uart_port *port, int flags)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	up->port.type = PORT_OMAP;
+}
+
+static int
+serial_omap_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	/* we don't want the core code to modify any port params */
+	return -EINVAL;
+}
+
+static const char *
+serial_omap_type(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	return up->name;
+}
+
+#ifdef CONFIG_SERIAL_OMAP_CONSOLE
+
+static struct uart_omap_port *serial_omap_console_ports[3];
+
+static struct uart_driver serial_omap_reg;
+
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
+
+/*
+ *	Wait for transmitter & holding register to empty
+ */
+static inline void wait_for_xmitr(struct uart_omap_port *up)
+{
+	unsigned int status, tmout = 10000;
+
+	/* Wait up to 10ms for the character(s) to be sent. */
+	do {
+		status = serial_in(up, UART_LSR);
+
+		if (status & UART_LSR_BI)
+			up->lsr_break_flag = UART_LSR_BI;
+
+		if (--tmout == 0)
+			break;
+		udelay(1);
+	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
+
+	/* Wait up to 1s for flow control if necessary */
+	if (up->port.flags & UPF_CONS_FLOW) {
+		tmout = 1000000;
+		while (--tmout &&
+		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
+			udelay(1);
+	}
+}
+
+static void serial_omap_console_putchar(struct uart_port *port, int ch)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+
+	wait_for_xmitr(up);
+	serial_out(up, UART_TX, ch);
+}
+
+/*
+ * Print a string to the serial port trying not to disturb
+ * any possible real use of the port...
+ *
+ *	The console_lock must be held when we get here.
+ */
+static void
+serial_omap_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct uart_omap_port *up = serial_omap_console_ports[co->index];
+	unsigned int ier;
+
+	/*
+	 *	First save the IER then disable the interrupts
+	 */
+	ier = serial_in(up, UART_IER);
+	serial_out(up, UART_IER, 0);
+
+	uart_console_write(&up->port, s, count, serial_omap_console_putchar);
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the IER
+	 */
+	wait_for_xmitr(up);
+	serial_out(up, UART_IER, ier);
+}
+
+static int __init
+serial_omap_console_setup(struct console *co, char *options)
+{
+	struct uart_omap_port *up;
+	int baud = 9600;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+	int r;
+
+	if (co->index == -1 || co->index >= serial_omap_reg.nr ||
+	    serial_omap_console_ports[co->index] == NULL)
+		co->index = 0;
+
+	if (serial_omap_console_ports[co->index] == NULL)
+		return -ENODEV;
+        up = serial_omap_console_ports[co->index];
+
+	enable_uart_clocks(up);
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	r = uart_set_options(&up->port, co, baud, parity, bits, flow);
+
+	return r;
+}
+
+static struct console serial_omap_console = {
+	.name		= "ttyS",
+	.write		= serial_omap_console_write,
+	.device		= uart_console_device,
+	.setup		= serial_omap_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &serial_omap_reg,
+};
+
+static void serial_omap_add_console_port(struct uart_omap_port *up)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(serial_omap_console_ports); i++)
+		if (serial_omap_console_ports[i] == NULL) {
+			serial_omap_console_ports[i] = up;
+			break;
+		}
+}
+
+#if 0
+static int __init
+serial_omap_console_init(void)
+{
+	register_console(&serial_omap_console);
+	return 0;
+}
+
+device_initcall(serial_omap_console_init);
+#endif
+
+#define OMAP_CONSOLE	&serial_omap_console
+
+#else
+
+#define OMAP_CONSOLE	NULL
+
+static inline void serial_omap_add_console_port(struct uart_omap_port *up) {}
+
+#endif
+
+struct uart_ops serial_omap_pops = {
+	.tx_empty	= serial_omap_tx_empty,
+	.set_mctrl	= serial_omap_set_mctrl,
+	.get_mctrl	= serial_omap_get_mctrl,
+	.stop_tx	= serial_omap_stop_tx,
+	.start_tx	= serial_omap_start_tx,
+	.stop_rx	= serial_omap_stop_rx,
+	.enable_ms	= serial_omap_enable_ms,
+	.break_ctl	= serial_omap_break_ctl,
+	.startup	= serial_omap_startup,
+	.shutdown	= serial_omap_shutdown,
+	.set_termios	= serial_omap_set_termios,
+	.pm		= serial_omap_pm,
+	.type		= serial_omap_type,
+	.release_port	= serial_omap_release_port,
+	.request_port	= serial_omap_request_port,
+	.config_port	= serial_omap_config_port,
+	.verify_port	= serial_omap_verify_port,
+};
+
+static struct uart_driver serial_omap_reg = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "OMAP serial",
+	.dev_name	= "ttyS",
+	.major		= TTY_MAJOR,
+	.minor		= 64,
+	.nr		= 3,
+	.cons		= OMAP_CONSOLE,
+};
+
+static int serial_omap_suspend(struct platform_device *dev, pm_message_t state)
+{
+        struct uart_omap_port *sport = platform_get_drvdata(dev);
+
+        if (sport)
+                uart_suspend_port(&serial_omap_reg, &sport->port);
+
+        return 0;
+}
+
+static int serial_omap_resume(struct platform_device *dev)
+{
+        struct uart_omap_port *sport = platform_get_drvdata(dev);
+
+        if (sport)
+                uart_resume_port(&serial_omap_reg, &sport->port);
+
+        return 0;
+}
+
+static int line = 0;
+
+static int serial_omap_probe(struct platform_device *pdev)
+{
+	struct uart_omap_port	*up;
+	struct resource		*mem, *irq;
+	char			buf[16];
+	int r;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "no mem resource?\n");
+		return -ENODEV;
+	}
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!irq) {
+		dev_err(&pdev->dev, "no irq resource?\n");
+		return -ENODEV;
+	}
+
+	r = (int) request_mem_region(mem->start, (mem->end - mem->start) + 1,
+				     pdev->dev.driver->name);
+	if (!r) {
+		dev_err(&pdev->dev, "memory region already claimed\n");
+		return -EBUSY;
+	}
+
+	up = kzalloc(sizeof(*up), GFP_KERNEL);
+	if (up == NULL) {
+		r = -ENOMEM;
+		goto do_release_region;
+	}
+	sprintf(up->name, "OMAP UART%d", pdev->id);
+
+	platform_set_drvdata(pdev, up);
+	up->pdev = pdev;
+
+	if (!cpu_class_is_omap1()) {
+		sprintf(buf, "uart%d_fck", pdev->id);
+		up->fclk = clk_get(&pdev->dev, buf);
+		if (IS_ERR(up->fclk)) {
+			dev_err(&pdev->dev, "could not get fclk\n");
+			return PTR_ERR(up->fclk);
+		}
+		sprintf(buf, "uart%d_ick", pdev->id);
+		up->iclk = clk_get(&pdev->dev, buf);
+		if (IS_ERR(up->iclk)) {
+			dev_err(&pdev->dev, "could not get iclk\n");
+			clk_put(up->fclk);
+			return PTR_ERR(up->iclk);
+		}
+	}
+
+	up->port.type = PORT_OMAP;
+	up->port.iotype = UPIO_MEM;
+	up->port.membase = (void *) io_p2v(mem->start);
+	up->port.mapbase = mem->start;
+	up->port.irq = irq->start;
+	up->port.fifosize = 64;
+	up->port.ops = &serial_omap_pops;
+	up->port.line = line++;
+
+	up->port.uartclk = 2995200 * 16;
+	up->shift = 2;
+
+	serial_omap_add_console_port(up);
+
+	uart_add_one_port(&serial_omap_reg, &up->port);
+	platform_set_drvdata(pdev, up);
+
+	return 0;
+
+do_release_region:
+	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	return r;
+}
+
+static int serial_omap_remove(struct platform_device *dev)
+{
+	struct uart_omap_port *sport = platform_get_drvdata(dev);
+
+	platform_set_drvdata(dev, NULL);
+
+	if (sport)
+		uart_remove_one_port(&serial_omap_reg, &sport->port);
+
+	return 0;
+}
+
+static struct platform_driver serial_omap_driver = {
+	.probe          = serial_omap_probe,
+	.remove         = serial_omap_remove,
+
+	.suspend	= serial_omap_suspend,
+	.resume		= serial_omap_resume,
+	.driver		= {
+	        .name	= "omap-uart",
+	},
+};
+
+int __init serial_omap_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&serial_omap_reg);
+	if (ret != 0)
+		return ret;
+
+	ret = platform_driver_register(&serial_omap_driver);
+	if (ret != 0)
+		uart_unregister_driver(&serial_omap_reg);
+
+	return ret;
+}
+
+void __exit serial_omap_exit(void)
+{
+	platform_driver_unregister(&serial_omap_driver);
+	uart_unregister_driver(&serial_omap_reg);
+}
+
+subsys_initcall(serial_omap_init);
+module_exit(serial_omap_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 586aaba..6b1c646 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -135,6 +135,8 @@
 /* Xilinx uartlite */
 #define PORT_UARTLITE	74
 
+#define PORT_OMAP	75
+
 #ifdef __KERNEL__
 
 #include <linux/compiler.h>
-- 
1.5.1
