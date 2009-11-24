From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/3] OMAP: UART: remove 8520 assumptions from UART core
Date: Tue, 24 Nov 2009 11:56:08 -0800
Message-ID: <1259092569-22352-3-git-send-email-khilman@deeprootsystems.com>
References: <1259092569-22352-1-git-send-email-khilman@deeprootsystems.com>
 <1259092569-22352-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:39096 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758084AbZKXT4I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 14:56:08 -0500
Received: by pxi10 with SMTP id 10so5177394pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 11:56:15 -0800 (PST)
In-Reply-To: <1259092569-22352-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Govindraj R <govindraj.raja@ti.com>

From: Govindraj R <govindraj.raja@ti.com>

In preparation for a new omap-serial driver, remove 8250 assumptions
and dependencies from the serial core.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |  202 ++++++++++++++++++++++-------------------
 1 files changed, 108 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2e17b57..3595ffa 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -19,15 +19,16 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/clock.h>
 #include <plat/control.h>
+#include <plat/dma.h>
 
 #include "prm.h"
 #include "pm.h"
@@ -47,12 +48,18 @@ struct omap_uart_state {
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
 	struct platform_device pdev;
 
@@ -71,6 +78,9 @@ struct omap_uart_state {
 
 static LIST_HEAD(uart_list);
 
+#ifdef CONFIG_SERIAL_8250
+#include <linux/serial_8250.h>
+
 static struct plat_serial8250_port serial_platform_data0[] = {
 	{
 		.mapbase	= OMAP_UART1_BASE,
@@ -124,18 +134,59 @@ static struct plat_serial8250_port serial_platform_data3[] = {
 	}
 };
 #endif
-static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
+
+static struct omap_uart_state omap_uart[] = {
+	{
+		.pdev = {
+			.name			= "serial8250",
+			.id			= PLAT8250_DEV_PLATFORM,
+			.dev			= {
+				.platform_data	= serial_platform_data0,
+			},
+		},
+	}, {
+		.pdev = {
+			.name			= "serial8250",
+			.id			= PLAT8250_DEV_PLATFORM1,
+			.dev			= {
+				.platform_data	= serial_platform_data1,
+			},
+		},
+	}, {
+		.pdev = {
+			.name			= "serial8250",
+			.id			= PLAT8250_DEV_PLATFORM2,
+			.dev			= {
+				.platform_data	= serial_platform_data2,
+			},
+		},
+	},
+#ifdef CONFIG_ARCH_OMAP4
+	{
+		.pdev = {
+			.name			= "serial8250",
+			.id			= 3,
+			.dev			= {
+				.platform_data	= serial_platform_data3,
+			},
+		},
+	},
+#endif
+};
+#endif
+
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
@@ -143,10 +194,9 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
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
@@ -158,20 +208,19 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
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
@@ -179,7 +228,6 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
 static void omap_uart_restore_context(struct omap_uart_state *uart)
 {
 	u16 efr = 0;
-	struct plat_serial8250_port *p = uart->p;
 
 	if (!enable_off_mode)
 		return;
@@ -189,25 +237,25 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 
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
@@ -272,10 +320,9 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
 	}
 }
 
-static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
-					  int enable)
+static void omap_uart_smart_idle_enable(struct omap_uart_state *p,
+					int enable)
 {
-	struct plat_serial8250_port *p = uart->p;
 	u16 sysc;
 
 	sysc = serial_read_reg(p, UART_OMAP_SYSC) & 0x7;
@@ -407,7 +454,6 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 
 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
-	struct plat_serial8250_port *p = uart->p;
 	int ret;
 
 	uart->can_sleep = 0;
@@ -469,8 +515,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->padconf = 0;
 	}
 
-	p->irqflags |= IRQF_SHARED;
-	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
+	uart->irqflags |= IRQF_SHARED;
+	ret = request_irq(uart->irq, omap_uart_interrupt, IRQF_SHARED,
 			  "serial idle", (void *)uart);
 	WARN_ON(ret);
 }
@@ -482,10 +528,10 @@ void omap_uart_enable_irqs(int enable)
 
 	list_for_each_entry(uart, &uart_list, node) {
 		if (enable)
-			ret = request_irq(uart->p->irq, omap_uart_interrupt,
+			ret = request_irq(uart->irq, omap_uart_interrupt,
 				IRQF_SHARED, "serial idle", (void *)uart);
 		else
-			free_irq(uart->p->irq, (void *)uart);
+			free_irq(uart->irq, (void *)uart);
 	}
 }
 
@@ -533,44 +579,6 @@ static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
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
 
 void __init omap_serial_early_init(void)
 {
@@ -585,16 +593,15 @@ void __init omap_serial_early_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
 		struct omap_uart_state *uart = &omap_uart[i];
-		struct platform_device *pdev = &uart->pdev;
-		struct device *dev = &pdev->dev;
-		struct plat_serial8250_port *p = dev->platform_data;
+
+		uart->num = i;
 
 		/*
 		 * Module 4KB + L4 interconnect 4KB
 		 * Static mapping, never released
 		 */
-		p->membase = ioremap(p->mapbase, SZ_8K);
-		if (!p->membase) {
+		uart->membase = ioremap(uart->mapbase, SZ_8K);
+		if (!uart->membase) {
 			printk(KERN_ERR "ioremap failed for uart%i\n", i + 1);
 			continue;
 		}
@@ -619,13 +626,10 @@ void __init omap_serial_early_init(void)
 				continue;
 		}
 
-		uart->num = i;
-		p->private_data = uart;
-		uart->p = p;
 		list_add_tail(&uart->node, &uart_list);
 
 		if (cpu_is_omap44xx())
-			p->irq += 32;
+			uart->irq += 32;
 
 		omap_uart_enable_clocks(uart);
 	}
@@ -639,10 +643,20 @@ void __init omap_serial_init(void)
 		struct omap_uart_state *uart = &omap_uart[i];
 		struct platform_device *pdev = &uart->pdev;
 		struct device *dev = &pdev->dev;
+#ifdef CONFIG_SERIAL_8250
+		struct plat_serial8250_port *p = dev->platform_data;
+#endif
 
 		omap_uart_reset(uart);
 		omap_uart_idle_init(uart);
 
+#ifdef CONFIG_SERIAL_8250
+		p->membase = uart->membase;
+		p->mapbase = uart->mapbase;
+		p->irq     = uart->irq;
+		p->irqflags = uart->irqflags;
+		p->private_data = uart;
+#endif
 		if (WARN_ON(platform_device_register(pdev)))
 			continue;
 		if ((cpu_is_omap34xx() && uart->padconf) ||
-- 
1.6.5.1

