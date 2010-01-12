From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP: UART: omap_device converions, remove implicit 8520 assumptions
Date: Tue, 12 Jan 2010 15:58:48 -0800
Message-ID: <1263340728-17929-3-git-send-email-khilman@deeprootsystems.com>
References: <1263340728-17929-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:62353 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab0ALX6z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 18:58:55 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so2460315pwj.21
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 15:58:55 -0800 (PST)
In-Reply-To: <1263340728-17929-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Govindraj R <govindraj.raja@ti.com>

Major rework of OMAP UART init for omap_device conversion as well as
use with either 8250 driver or new omap-serial driver.

Signifcant contributions and testing from Govindraj R <govindraj.raja@ti.com>.

In preparation for a new omap-serial driver, remove 8250 assumptions
and dependencies from the serial core.

Convert UART core and PM support to use omap_device layer.  Also add
support for both console on 8250 or omap-serial driver.

omap_device conversion:
- Convert clock API calls to omap_device calls
- Remove all static platform_data setup and configuration.  This is
  all done by the omap_device build phase.

Known issues:
- broken on OMAP4 until OMAP4 UART hwmods are available

Cc: Govindraj R <govindraj.raja@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |  474 +++++++++++++++++++++---------------------
 1 files changed, 242 insertions(+), 232 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 8c964be..9060fb8 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -19,18 +19,30 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+#include <linux/serial_8250.h>
+#endif
+
+#ifdef CONFIG_SERIAL_OMAP_CONSOLE
+#include <plat/omap-serial.h>
+#endif
 
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/clock.h>
 #include <plat/control.h>
+#include <plat/dma.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 #include "prm.h"
 #include "pm.h"
+#include "cm.h"
 #include "prm-regbits-34xx.h"
 
 #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
@@ -38,6 +50,8 @@
 
 #define DEFAULT_TIMEOUT (5 * HZ)
 
+#define MAX_UART_HWMOD_NAME_LEN		16
+
 struct omap_uart_state {
 	int num;
 	int can_sleep;
@@ -48,14 +62,21 @@ struct omap_uart_state {
 	void __iomem *wk_en;
 	u32 wk_mask;
 	u32 padconf;
+	u32 dma_enabled;
 
 	struct clk *ick;
 	struct clk *fck;
 	int clocked;
 
-	struct plat_serial8250_port *p;
+	int irq;
+	int regshift;
+	int irqflags;
+	void __iomem *membase;
+	resource_size_t mapbase;
+
 	struct list_head node;
-	struct platform_device pdev;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 	int context_valid;
@@ -71,60 +92,16 @@ struct omap_uart_state {
 };
 
 static LIST_HEAD(uart_list);
+static u8 num_uarts;
 
-static struct plat_serial8250_port serial_platform_data0[] = {
+static struct omap_device_pm_latency omap_uart_latency[] = {
 	{
-		.mapbase	= OMAP_UART1_BASE,
-		.irq		= 72,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP24XX_BASE_BAUD * 16,
-	}, {
-		.flags		= 0
-	}
-};
-
-static struct plat_serial8250_port serial_platform_data1[] = {
-	{
-		.mapbase	= OMAP_UART2_BASE,
-		.irq		= 73,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP24XX_BASE_BAUD * 16,
-	}, {
-		.flags		= 0
-	}
-};
-
-static struct plat_serial8250_port serial_platform_data2[] = {
-	{
-		.mapbase	= OMAP_UART3_BASE,
-		.irq		= 74,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP24XX_BASE_BAUD * 16,
-	}, {
-		.flags		= 0
-	}
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func	 = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
 };
 
-#ifdef CONFIG_ARCH_OMAP4
-static struct plat_serial8250_port serial_platform_data3[] = {
-	{
-		.mapbase	= OMAP_UART4_BASE,
-		.irq		= 70,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP24XX_BASE_BAUD * 16,
-	}, {
-		.flags		= 0
-	}
-};
-#endif
 static inline unsigned int __serial_read_reg(struct uart_port *up,
 					   int offset)
 {
@@ -132,18 +109,18 @@ static inline unsigned int __serial_read_reg(struct uart_port *up,
 	return (unsigned int)__raw_readb(up->membase + offset);
 }
 
-static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
+static inline unsigned int serial_read_reg(struct omap_uart_state *up,
 					   int offset)
 {
 	offset <<= up->regshift;
 	return (unsigned int)__raw_readb(up->membase + offset);
 }
 
-static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
+static inline void serial_write_reg(struct omap_uart_state *up, int offset,
 				    int value)
 {
-	offset <<= p->regshift;
-	__raw_writeb(value, p->membase + offset);
+	offset <<= up->regshift;
+	__raw_writeb(value, up->membase + offset);
 }
 
 /*
@@ -151,14 +128,12 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
  * properly. Note that the TX watermark initialization may not be needed
  * once the 8250.c watermark handling code is merged.
  */
-static inline void __init omap_uart_reset(struct omap_uart_state *uart)
-{
-	struct plat_serial8250_port *p = uart->p;
 
+static inline void __init omap_uart_reset(struct omap_uart_state *p)
+{
 	serial_write_reg(p, UART_OMAP_MDR1, 0x07);
 	serial_write_reg(p, UART_OMAP_SCR, 0x08);
 	serial_write_reg(p, UART_OMAP_MDR1, 0x00);
-	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
 }
 
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
@@ -166,20 +141,19 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 static void omap_uart_save_context(struct omap_uart_state *uart)
 {
 	u16 lcr = 0;
-	struct plat_serial8250_port *p = uart->p;
 
 	if (!enable_off_mode)
 		return;
 
-	lcr = serial_read_reg(p, UART_LCR);
-	serial_write_reg(p, UART_LCR, 0xBF);
-	uart->dll = serial_read_reg(p, UART_DLL);
-	uart->dlh = serial_read_reg(p, UART_DLM);
-	serial_write_reg(p, UART_LCR, lcr);
-	uart->ier = serial_read_reg(p, UART_IER);
-	uart->sysc = serial_read_reg(p, UART_OMAP_SYSC);
-	uart->scr = serial_read_reg(p, UART_OMAP_SCR);
-	uart->wer = serial_read_reg(p, UART_OMAP_WER);
+	lcr = serial_read_reg(uart, UART_LCR);
+	serial_write_reg(uart, UART_LCR, 0xBF);
+	uart->dll = serial_read_reg(uart, UART_DLL);
+	uart->dlh = serial_read_reg(uart, UART_DLM);
+	serial_write_reg(uart, UART_LCR, lcr);
+	uart->ier = serial_read_reg(uart, UART_IER);
+	uart->sysc = serial_read_reg(uart, UART_OMAP_SYSC);
+	uart->scr = serial_read_reg(uart, UART_OMAP_SCR);
+	uart->wer = serial_read_reg(uart, UART_OMAP_WER);
 
 	uart->context_valid = 1;
 }
@@ -187,7 +161,6 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
 static void omap_uart_restore_context(struct omap_uart_state *uart)
 {
 	u16 efr = 0;
-	struct plat_serial8250_port *p = uart->p;
 
 	if (!enable_off_mode)
 		return;
@@ -197,25 +170,25 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 
 	uart->context_valid = 0;
 
-	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
-	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
-	efr = serial_read_reg(p, UART_EFR);
-	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
-	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
-	serial_write_reg(p, UART_IER, 0x0);
-	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
-	serial_write_reg(p, UART_DLL, uart->dll);
-	serial_write_reg(p, UART_DLM, uart->dlh);
-	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
-	serial_write_reg(p, UART_IER, uart->ier);
-	serial_write_reg(p, UART_FCR, 0xA1);
-	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
-	serial_write_reg(p, UART_EFR, efr);
-	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
-	serial_write_reg(p, UART_OMAP_SCR, uart->scr);
-	serial_write_reg(p, UART_OMAP_WER, uart->wer);
-	serial_write_reg(p, UART_OMAP_SYSC, uart->sysc);
-	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+	serial_write_reg(uart, UART_OMAP_MDR1, 0x7);
+	serial_write_reg(uart, UART_LCR, 0xBF); /* Config B mode */
+	efr = serial_read_reg(uart, UART_EFR);
+	serial_write_reg(uart, UART_EFR, UART_EFR_ECB);
+	serial_write_reg(uart, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(uart, UART_IER, 0x0);
+	serial_write_reg(uart, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(uart, UART_DLL, uart->dll);
+	serial_write_reg(uart, UART_DLM, uart->dlh);
+	serial_write_reg(uart, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(uart, UART_IER, uart->ier);
+	serial_write_reg(uart, UART_FCR, 0xA1);
+	serial_write_reg(uart, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(uart, UART_EFR, efr);
+	serial_write_reg(uart, UART_LCR, UART_LCR_WLEN8);
+	serial_write_reg(uart, UART_OMAP_SCR, uart->scr);
+	serial_write_reg(uart, UART_OMAP_WER, uart->wer);
+	serial_write_reg(uart, UART_OMAP_SYSC, uart->sysc);
+	serial_write_reg(uart, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
 }
 #else
 static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
@@ -227,8 +200,7 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 	if (uart->clocked)
 		return;
 
-	clk_enable(uart->ick);
-	clk_enable(uart->fck);
+	omap_device_enable(uart->pdev);
 	uart->clocked = 1;
 	omap_uart_restore_context(uart);
 }
@@ -242,8 +214,7 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 
 	omap_uart_save_context(uart);
 	uart->clocked = 0;
-	clk_disable(uart->ick);
-	clk_disable(uart->fck);
+	omap_device_idle(uart->pdev);
 }
 
 static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
@@ -280,19 +251,26 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
 	}
 }
 
-static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
-					  int enable)
+static inline void omap_uart_smart_idle_enable(struct omap_uart_state *p,
+					       int enable)
 {
-	struct plat_serial8250_port *p = uart->p;
-	u16 sysc;
-
-	sysc = serial_read_reg(p, UART_OMAP_SYSC) & 0x7;
-	if (enable)
-		sysc |= 0x2 << 3;
-	else
-		sysc |= 0x1 << 3;
-
-	serial_write_reg(p, UART_OMAP_SYSC, sysc);
+	u32 sysc;
+
+	sysc = omap_hwmod_read_sysc(p->oh);
+	sysc &= ~SYSC_SIDLEMODE_MASK;
+	if (enable) {
+		/**
+		 * Errata 2.15: [UART]:Cannot Acknowledge Idle Requests
+		 * in Smartidle Mode When Configured for DMA Operations.
+		 */
+		if (p->dma_enabled)
+			sysc |= 0x0 << SYSC_SIDLEMODE_SHIFT;
+		else
+			sysc |= 0x2 << SYSC_SIDLEMODE_SHIFT;
+	} else {
+		sysc |= 0x1 << SYSC_SIDLEMODE_SHIFT;
+	}
+	omap_hwmod_write_sysc(sysc, p->oh);
 }
 
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
@@ -309,7 +287,7 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 
 static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 {
-	if (device_may_wakeup(&uart->pdev.dev))
+	if (device_may_wakeup(&uart->pdev->dev))
 		omap_uart_enable_wakeup(uart);
 	else
 		omap_uart_disable_wakeup(uart);
@@ -404,6 +382,7 @@ int omap_uart_can_sleep(void)
  * UART will not idle or sleep for its timeout period.
  *
  **/
+/* static int first_interrupt; */
 static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 {
 	struct omap_uart_state *uart = dev_id;
@@ -415,7 +394,6 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 
 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
-	struct plat_serial8250_port *p = uart->p;
 	int ret;
 
 	uart->can_sleep = 0;
@@ -477,9 +455,9 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->padconf = 0;
 	}
 
-	p->irqflags |= IRQF_SHARED;
-	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
-			  "serial idle", (void *)uart);
+	uart->irqflags |= IRQF_SHARED;
+	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt, 
+				   IRQF_SHARED, "serial idle", (void *)uart);
 	WARN_ON(ret);
 }
 
@@ -490,10 +468,13 @@ void omap_uart_enable_irqs(int enable)
 
 	list_for_each_entry(uart, &uart_list, node) {
 		if (enable)
-			ret = request_irq(uart->p->irq, omap_uart_interrupt,
-				IRQF_SHARED, "serial idle", (void *)uart);
+			ret = request_threaded_irq(uart->irq, NULL,
+						   omap_uart_interrupt,
+						   IRQF_SHARED,
+						   "serial idle",
+						   (void *)uart);
 		else
-			free_irq(uart->p->irq, (void *)uart);
+			free_irq(uart->irq, (void *)uart);
 	}
 }
 
@@ -501,10 +482,9 @@ static ssize_t sleep_timeout_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	struct platform_device *pdev = container_of(dev,
-					struct platform_device, dev);
-	struct omap_uart_state *uart = container_of(pdev,
-					struct omap_uart_state, pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	struct omap_uart_state *uart = odev->hwmods[0]->dev_attr;
 
 	return sprintf(buf, "%u\n", uart->timeout / HZ);
 }
@@ -513,10 +493,9 @@ static ssize_t sleep_timeout_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t n)
 {
-	struct platform_device *pdev = container_of(dev,
-					struct platform_device, dev);
-	struct omap_uart_state *uart = container_of(pdev,
-					struct omap_uart_state, pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	struct omap_uart_state *uart = odev->hwmods[0]->dev_attr;
 	unsigned int value;
 
 	if (sscanf(buf, "%u", &value) != 1) {
@@ -541,45 +520,8 @@ static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
 
-static struct omap_uart_state omap_uart[] = {
-	{
-		.pdev = {
-			.name			= "serial8250",
-			.id			= PLAT8250_DEV_PLATFORM,
-			.dev			= {
-				.platform_data	= serial_platform_data0,
-			},
-		},
-	}, {
-		.pdev = {
-			.name			= "serial8250",
-			.id			= PLAT8250_DEV_PLATFORM1,
-			.dev			= {
-				.platform_data	= serial_platform_data1,
-			},
-		},
-	}, {
-		.pdev = {
-			.name			= "serial8250",
-			.id			= PLAT8250_DEV_PLATFORM2,
-			.dev			= {
-				.platform_data	= serial_platform_data2,
-			},
-		},
-	},
-#ifdef CONFIG_ARCH_OMAP4
-	{
-		.pdev = {
-			.name			= "serial8250",
-			.id			= 3,
-			.dev			= {
-				.platform_data	= serial_platform_data3,
-			},
-		},
-	},
-#endif
-};
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 /*
  * Override the default 8250 read handler: mem_serial_in()
  * Empty RX fifo read causes an abort on omap3630 and omap4
@@ -597,61 +539,40 @@ static unsigned int serial_in_override(struct uart_port *up, int offset)
 
 	return __serial_read_reg(up, offset);
 }
+#endif
 
 void __init omap_serial_early_init(void)
 {
-	int i;
-	char name[16];
-
-	/*
-	 * Make sure the serial ports are muxed on at this point.
-	 * You have to mux them off in device drivers later on
-	 * if not needed.
-	 */
-
-	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
-		struct omap_uart_state *uart = &omap_uart[i];
-		struct platform_device *pdev = &uart->pdev;
-		struct device *dev = &pdev->dev;
-		struct plat_serial8250_port *p = dev->platform_data;
-
-		/*
-		 * Module 4KB + L4 interconnect 4KB
-		 * Static mapping, never released
-		 */
-		p->membase = ioremap(p->mapbase, SZ_8K);
-		if (!p->membase) {
-			printk(KERN_ERR "ioremap failed for uart%i\n", i + 1);
-			continue;
-		}
+	int i = 0;
 
-		sprintf(name, "uart%d_ick", i+1);
-		uart->ick = clk_get(NULL, name);
-		if (IS_ERR(uart->ick)) {
-			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
-			uart->ick = NULL;
-		}
+	do {
+		char oh_name[MAX_UART_HWMOD_NAME_LEN];
+		struct omap_hwmod *oh;
+		struct omap_uart_state *uart;
 
-		sprintf(name, "uart%d_fck", i+1);
-		uart->fck = clk_get(NULL, name);
-		if (IS_ERR(uart->fck)) {
-			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
-			uart->fck = NULL;
-		}
-
-		/* FIXME: Remove this once the clkdev is ready */
-		if (!cpu_is_omap44xx()) {
-			if (!uart->ick || !uart->fck)
-				continue;
-		}
+		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
+			 "uart%d_hwmod", i + 1);
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh)
+			break;
 
-		uart->num = i;
-		p->private_data = uart;
-		uart->p = p;
+		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
+		if (WARN_ON(!uart))
+			return;
 
-		if (cpu_is_omap44xx())
-			p->irq += 32;
-	}
+		uart->oh = oh;
+		uart->num = i++;
+		list_add_tail(&uart->node, &uart_list);
+		num_uarts++;
+
+		/* NOTE: omap_hwmod_init() has not yet been called,
+		 *       so no hwmod functions will work yet. */
+#ifdef CONFIG_DEBUG_LL
+		/* For DEBUG_LL, don't reset/idle the UARTs otherwise
+		 * early UART access will fault. */
+		uart->oh->flags |= HWMOD_INIT_NO_IDLE;
+#endif
+	} while(1);
 }
 
 /**
@@ -668,41 +589,130 @@ void __init omap_serial_early_init(void)
 void __init omap_serial_init_port(int port)
 {
 	struct omap_uart_state *uart;
-	struct platform_device *pdev;
-	struct device *dev;
+	char *name;
 
 	BUG_ON(port < 0);
-	BUG_ON(port >= ARRAY_SIZE(omap_uart));
+	BUG_ON(port >= num_uarts);
 
-	uart = &omap_uart[port];
-	pdev = &uart->pdev;
-	dev = &pdev->dev;
+	list_for_each_entry(uart, &uart_list, node)
+		if (port == uart->num)
+			break;
 
-	omap_uart_enable_clocks(uart);
+	{
+		struct omap_hwmod *oh = uart->oh;
+		struct omap_device *od;
+		void *pdata = NULL;
+		u32 pdata_size = 0;
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+		struct plat_serial8250_port ports[2] = {
+			{},
+			{.flags = 0},
+		};
+		struct plat_serial8250_port *p = &ports[0];
+
+		name = "serial8250";
+		uart->dma_enabled = 0;
+
+		/* 
+		 * !! 8250 driver does not use standard IORESOURCE* It
+		 * has it's own custom pdata that can be taken from
+		 * the hwmod resource data.  But, this needs to be
+		 * done after the build.
+		 *
+		 * ?? does it have to be done before the register ??
+		 * YES, because platform_device_data_add() copies
+		 * pdata, it does not use a pointer.
+		 */
+		p->flags = UPF_BOOT_AUTOCONF;
+		p->iotype = UPIO_MEM;
+		p->regshift = 2;
+		p->uartclk = OMAP24XX_BASE_BAUD * 16;
+		p->irq = oh->mpu_irqs[0].irq;
+		p->mapbase = oh->slaves[0]->addr->pa_start;
+		p->membase = oh->_rt_va;
+		p->irqflags = IRQF_SHARED;
+		p->private_data = uart;
 
-	omap_uart_reset(uart);
-	omap_uart_idle_init(uart);
+		pdata = &ports[0];
+		pdata_size = 2 * sizeof(struct plat_serial8250_port);
+#endif
+#ifdef CONFIG_SERIAL_OMAP_CONSOLE
+		struct omap_uart_port_info omap_up;
 
-	list_add_tail(&uart->node, &uart_list);
+		name = "omap-hsuart";
+		uart->dma_enabled = 0;
 
-	if (WARN_ON(platform_device_register(pdev)))
-		return;
+		omap_up.dma_enabled = uart->dma_enabled;
+		omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
+		omap_up.mapbase = oh->slaves[0]->addr->pa_start;
+		omap_up.membase = oh->_rt_va;
+		omap_up.irqflags = IRQF_SHARED;
+		omap_up.flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
 
-	if ((cpu_is_omap34xx() && uart->padconf) ||
-	    (uart->wk_en && uart->wk_mask)) {
-		device_init_wakeup(dev, true);
-		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
-	}
+		pdata = &omap_up;
+		pdata_size = sizeof(struct omap_uart_port_info);
+#endif
 
+		if (WARN_ON(!oh))
+			return;
+
+		od = omap_device_build(name, uart->num, oh, pdata, pdata_size,
+				       omap_uart_latency,
+				       ARRAY_SIZE(omap_uart_latency));
+		WARN(IS_ERR(od), "Could not build omap_device for %s: %s.\n",
+		     name, oh->name);
+
+		uart->irq = oh->mpu_irqs[0].irq;
+		uart->regshift = 2;	       
+		uart->mapbase = oh->slaves[0]->addr->pa_start;
+		uart->membase = oh->_rt_va;
+		uart->pdev = &od->pdev;
+
+		oh->dev_attr = uart;
+
+#ifdef CONFIG_DEBUG_LL
+		/* 
+		 * Because of earlyprintk output, UART did not get idled
+		 * on init.  Now that omap_device is ready, ensure full idle
+		 * before doing omap_device_enable().
+		 */
+		omap_hwmod_idle(uart->oh);
+#endif
+		omap_device_enable(uart->pdev);
+		omap_uart_idle_init(uart);
+		omap_uart_reset(uart);
+		omap_hwmod_enable_wakeup(uart->oh);
+		omap_device_idle(uart->pdev);
+
+		/* 
+		 * Need to block sleep long enough for interrupt driven
+		 * driver to start.  Console driver is in polling mode
+		 * so device needs to be kept enabled while polling driver
+		 * is in use.
+		 */
+		uart->timeout = (30 * HZ);
+		omap_uart_block_sleep(uart);
+		uart->timeout = DEFAULT_TIMEOUT;
+
+		if ((cpu_is_omap34xx() && uart->padconf) ||
+		    (uart->wk_en && uart->wk_mask)) {
+			device_init_wakeup(&od->pdev.dev, true);
+			DEV_CREATE_FILE(&od->pdev.dev, &dev_attr_sleep_timeout);
+		}
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 		/* omap44xx: Never read empty UART fifo
 		 * omap3xxx: Never read empty UART fifo on UARTs
 		 * with IP rev >=0x52
 		 */
 		if (cpu_is_omap44xx())
-			uart->p->serial_in = serial_in_override;
-		else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
+			p->serial_in = serial_in_override;
+		else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
 				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
-			uart->p->serial_in = serial_in_override;
+			p->serial_in = serial_in_override;
+#endif
+	}
 }
 
 /**
@@ -714,8 +724,8 @@ void __init omap_serial_init_port(int port)
  */
 void __init omap_serial_init(void)
 {
-	int i;
+	struct omap_uart_state *uart;
 
-	for (i = 0; i < ARRAY_SIZE(omap_uart); i++)
-		omap_serial_init_port(i);
+	list_for_each_entry(uart, &uart_list, node)
+		omap_serial_init_port(uart->num);
 }
-- 
1.6.6

