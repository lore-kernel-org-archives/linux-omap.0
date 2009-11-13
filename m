From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCHv3 2/3] OMAP UART: Add platform data for omap-serial driver.
Date: Fri, 13 Nov 2009 12:24:09 +0530 (IST)
Message-ID: <45310.192.168.10.88.1258095249.squirrel@dbdmail.itg.ti.com>
References: <36298.192.168.10.88.1256714022.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43041 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbZKMGyD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 01:54:03 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAD6s9CN009714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 00:54:09 -0600
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id nAD6s79g011428
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 00:54:08 -0600 (CST)
In-Reply-To: <36298.192.168.10.88.1256714022.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From e7c74ee6d91d7940e1cbde03fb6bf710fa448a8a Mon Sep 17 00:00:00 2001
From: Govindraj R <govindraj.raja@ti.com>
Date: Fri, 13 Nov 2009 12:07:14 +0530
Subject: [PATCH] OMAP UART: Add platform data for omap-serial driver.

This patch modifies the serial-pm framework in place and
utilises the framework to work with omap-serial driver.

However future plan is to replace this with omap-device and
omap_hwmod support.

Signed-off-by: Govindraj R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |  335 ++++++++++++++++++++++++++++++------------
 1 files changed, 241 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2e17b57..49ac252 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -13,6 +13,9 @@
  * Copyright (C) 2009 Texas Instruments
  * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added support for Omap-Serial driver - Govindraj R <govindraj.raja@ti.com>
+ *
  * This file is subject to the terms and conditions of the GNU General Public
  * License. See the file "COPYING" in the main directory of this archive
  * for more details.
@@ -29,6 +32,9 @@
 #include <plat/clock.h>
 #include <plat/control.h>

+#include <plat/dma.h>
+#include <plat/omap-serial.h>
+
 #include "prm.h"
 #include "pm.h"
 #include "prm-regbits-34xx.h"
@@ -52,7 +58,12 @@ struct omap_uart_state {
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

@@ -71,6 +82,7 @@ struct omap_uart_state {

 static LIST_HEAD(uart_list);

+#ifdef CONFIG_SERIAL_8250
 static struct plat_serial8250_port serial_platform_data0[] = {
 	{
 		.mapbase	= OMAP_UART1_BASE,
@@ -124,18 +136,169 @@ static struct plat_serial8250_port serial_platform_data3[] = {
 	}
 };
 #endif
-static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
-					   int offset)
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
+
+#else
+static struct uart_port_info uart1_port_info = {
+		.dma_enabled	= 0,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16
+};
+
+static struct uart_port_info uart2_port_info = {
+		.dma_enabled	= 0,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16
+};
+
+static struct uart_port_info uart3_port_info = {
+		.dma_enabled	= 0,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16
+};
+
+static struct resource omap_uart1_resources[] = {
+	{
+		.start          = OMAP_UART1_BASE,
+		.end            = OMAP_UART1_BASE + 0x3ff,
+		.flags          = IORESOURCE_MEM,
+	}, {
+		/* UART1 IRQ - 72*/
+		.start          = INT_24XX_UART1_IRQ,
+		.flags          = IORESOURCE_IRQ,
+	}, {
+		/* UART1 TX DMA CHANNEL -S_DMA_48- */
+		.start		= OMAP24XX_DMA_UART1_TX,
+		.flags		= IORESOURCE_DMA,
+	}, {
+		/* UART1 RX DMA CHANNEL -S_DMA_49- */
+		.start		= OMAP24XX_DMA_UART1_RX,
+		.flags		= IORESOURCE_DMA,
+	}
+};
+
+static struct resource omap_uart2_resources[] = {
+	{
+		.start          = OMAP_UART2_BASE,
+		.end            = OMAP_UART2_BASE + 0x3ff,
+		.flags          = IORESOURCE_MEM,
+	}, {
+		/* UART2 IRQ - 73*/
+		.start          = INT_24XX_UART2_IRQ,
+		.flags          = IORESOURCE_IRQ,
+	}, {
+		/* UART2 TX DMA CHANNEL -S_DMA_50- */
+		.start		= OMAP24XX_DMA_UART2_TX,
+		.flags		= IORESOURCE_DMA,
+	}, {
+		/* UART2 RX DMA CHANNEL -S_DMA_51- */
+		.start		= OMAP24XX_DMA_UART2_RX,
+		.flags		= IORESOURCE_DMA,
+	}
+};
+
+static struct resource omap_uart3_resources[] = {
+	{
+		.start          = OMAP_UART3_BASE,
+		.end            = OMAP_UART3_BASE + 0x3ff,
+		.flags          = IORESOURCE_MEM,
+	}, {
+		/* UART3 IRQ - 74*/
+		.start          = INT_24XX_UART3_IRQ,
+		.flags          = IORESOURCE_IRQ,
+	}, {
+		/* UART3 TX DMA CHANNEL -S_DMA_52- */
+		.start		= OMAP24XX_DMA_UART3_TX,
+		.flags		= IORESOURCE_DMA,
+	}, {
+		/* UART3 RX DMA CHANNEL -S_DMA_53- */
+		.start		= OMAP24XX_DMA_UART3_RX,
+		.flags		= IORESOURCE_DMA,
+	}
+};
+
+static struct omap_uart_state omap_uart[] = {
+	{
+		.pdev = {
+			.name		= "omap-uart",
+			.id		= 1,
+			.num_resources	= ARRAY_SIZE(omap_uart1_resources),
+			.resource	= omap_uart1_resources,
+			.dev		= {
+				.platform_data  = &uart1_port_info
+			},
+		}
+	}, {
+		.pdev = {
+			.name		= "omap-uart",
+			.id		= 2,
+			.num_resources	= ARRAY_SIZE(omap_uart2_resources),
+			.resource	= omap_uart2_resources,
+			.dev		= {
+				.platform_data  = &uart2_port_info,
+			},
+		}
+	}, {
+		.pdev = {
+			.name		= "omap-uart",
+			.id		= 3,
+			.num_resources	= ARRAY_SIZE(omap_uart3_resources),
+			.resource	= omap_uart3_resources,
+			.dev		= {
+				.platform_data  = &uart3_port_info,
+			},
+		}
+	}
+};
+#endif
+
+static inline unsigned int serial_read_reg(struct omap_uart_state *up,
+							int offset)
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
@@ -143,10 +306,9 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
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
@@ -158,20 +320,19 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
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
@@ -179,7 +340,6 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
 static void omap_uart_restore_context(struct omap_uart_state *uart)
 {
 	u16 efr = 0;
-	struct plat_serial8250_port *p = uart->p;

 	if (!enable_off_mode)
 		return;
@@ -189,25 +349,25 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)

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
@@ -272,10 +432,9 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
 	}
 }

-static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
+static void omap_uart_smart_idle_enable(struct omap_uart_state *p,
 					  int enable)
 {
-	struct plat_serial8250_port *p = uart->p;
 	u16 sysc;

 	sysc = serial_read_reg(p, UART_OMAP_SYSC) & 0x7;
@@ -405,9 +564,34 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }

+
+static void omap_uart_port_init(struct omap_uart_state *uart)
+{
+	switch (uart->num) {
+	case 0:
+		uart->irq 	= INT_24XX_UART1_IRQ;
+		uart->mapbase 	= OMAP_UART1_BASE;
+		break;
+	case 1:
+		uart->irq 	= INT_24XX_UART2_IRQ;
+		uart->mapbase 	= OMAP_UART2_BASE;
+		break;
+	case 2:
+		uart->irq 	= INT_24XX_UART3_IRQ;
+		uart->mapbase 	= OMAP_UART3_BASE;
+		break;
+#ifdef CONFIG_ARCH_OMAP4
+	case 3:
+		uart->irq 	= 70;
+		uart->mapbase 	= OMAP_UART4_BASE;
+		break;
+#endif
+	}
+	uart->regshift = 2;
+}
+
 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
-	struct plat_serial8250_port *p = uart->p;
 	int ret;

 	uart->can_sleep = 0;
@@ -469,8 +653,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->padconf = 0;
 	}

-	p->irqflags |= IRQF_SHARED;
-	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
+	uart->irqflags |= IRQF_SHARED;
+	ret = request_irq(uart->irq, omap_uart_interrupt, IRQF_SHARED,
 			  "serial idle", (void *)uart);
 	WARN_ON(ret);
 }
@@ -482,10 +666,10 @@ void omap_uart_enable_irqs(int enable)

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

@@ -533,44 +717,6 @@ static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
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
@@ -585,16 +731,16 @@ void __init omap_serial_early_init(void)

 	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
 		struct omap_uart_state *uart = &omap_uart[i];
-		struct platform_device *pdev = &uart->pdev;
-		struct device *dev = &pdev->dev;
-		struct plat_serial8250_port *p = dev->platform_data;
+
+		uart->num = i;
+		omap_uart_port_init(uart);

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
@@ -619,13 +765,10 @@ void __init omap_serial_early_init(void)
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
@@ -639,7 +782,11 @@ void __init omap_serial_init(void)
 		struct omap_uart_state *uart = &omap_uart[i];
 		struct platform_device *pdev = &uart->pdev;
 		struct device *dev = &pdev->dev;
-
+#ifdef CONFIG_SERIAL_8250
+		struct plat_serial8250_port *p = dev->platform_data;
+		p->membase = uart->membase;
+		p->private_data = uart;
+#endif
 		omap_uart_reset(uart);
 		omap_uart_idle_init(uart);

-- 
1.5.5


