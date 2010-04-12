From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 2/3] Serial: Remove 8250 driver assumptions
Date: Mon, 12 Apr 2010 16:12:22 +0530 (IST)
Message-ID: <33577.192.168.10.89.1271068942.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43000 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308Ab0DLKmY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Apr 2010 06:42:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch removes all 8250 dependecy from all functions
from the serial PM layer thus making it generic. This
helps us to re-use this existing framework with omap-serial
driver.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |  258 +++++++++++++++++++++++-------------------
 1 files changed, 142 insertions(+), 116 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3771254..14ed9fb 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -60,7 +60,11 @@ struct omap_uart_state {
 	struct clk *fck;
 	int clocked;

-	struct plat_serial8250_port *p;
+	int irq;
+	int regshift;
+	int irqflags;
+	void __iomem *membase;
+	resource_size_t mapbase;
 	struct list_head node;
 	struct platform_device pdev;

@@ -127,12 +131,52 @@ static struct plat_serial8250_port serial_platform_data3[] = {
 	}
 };

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
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
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
+
 void __init omap2_set_globals_uart(struct omap_globals *omap2_globals)
 {
-	serial_platform_data0[0].mapbase = omap2_globals->uart1_phys;
-	serial_platform_data1[0].mapbase = omap2_globals->uart2_phys;
-	serial_platform_data2[0].mapbase = omap2_globals->uart3_phys;
-	serial_platform_data3[0].mapbase = omap2_globals->uart4_phys;
+	omap_uart[0].mapbase = omap2_globals->uart1_phys;
+	omap_uart[1].mapbase = omap2_globals->uart2_phys;
+	omap_uart[2].mapbase = omap2_globals->uart3_phys;
+	omap_uart[3].mapbase = omap2_globals->uart4_phys;
 }

 static inline unsigned int __serial_read_reg(struct uart_port *up,
@@ -142,7 +186,7 @@ static inline unsigned int __serial_read_reg(struct uart_port *up,
 	return (unsigned int)__raw_readb(up->membase + offset);
 }

-static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
+static inline unsigned int serial_read_reg(struct omap_uart_state *up,
 					   int offset)
 {
 	offset <<= up->regshift;
@@ -156,11 +200,11 @@ static inline void __serial_write_reg(struct uart_port *up, int offset,
 	__raw_writeb(value, up->membase + offset);
 }

-static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
+static inline void serial_write_reg(struct omap_uart_state *uart, int offset,
 				    int value)
 {
-	offset <<= p->regshift;
-	__raw_writeb(value, p->membase + offset);
+	offset <<= uart->regshift;
+	__raw_writeb(value, uart->membase + offset);
 }

 /*
@@ -170,12 +214,11 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
  */
 static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 {
-	struct plat_serial8250_port *p = uart->p;
-
-	serial_write_reg(p, UART_OMAP_MDR1, 0x07);
-	serial_write_reg(p, UART_OMAP_SCR, 0x08);
-	serial_write_reg(p, UART_OMAP_MDR1, 0x00);
-	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
+	serial_write_reg(uart, UART_OMAP_MDR1, 0x07);
+	serial_write_reg(uart, UART_OMAP_SCR, 0x08);
+	serial_write_reg(uart, UART_OMAP_MDR1, 0x00);
+	serial_write_reg(uart, UART_OMAP_SYSC, (0x02 << 3) |
+					(1 << 2) | (1 << 0));
 }

 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
@@ -183,20 +226,19 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
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
@@ -204,7 +246,6 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
 static void omap_uart_restore_context(struct omap_uart_state *uart)
 {
 	u16 efr = 0;
-	struct plat_serial8250_port *p = uart->p;

 	if (!enable_off_mode)
 		return;
@@ -214,25 +255,25 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)

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
@@ -300,16 +341,15 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
 static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
 					  int enable)
 {
-	struct plat_serial8250_port *p = uart->p;
 	u16 sysc;

-	sysc = serial_read_reg(p, UART_OMAP_SYSC) & 0x7;
+	sysc = serial_read_reg(uart, UART_OMAP_SYSC) & 0x7;
 	if (enable)
 		sysc |= 0x2 << 3;
 	else
 		sysc |= 0x1 << 3;

-	serial_write_reg(p, UART_OMAP_SYSC, sysc);
+	serial_write_reg(uart, UART_OMAP_SYSC, sysc);
 }

 static void omap_uart_block_sleep(struct omap_uart_state *uart)
@@ -430,9 +470,24 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }

+static void omap_uart_irq_port_init(struct omap_uart_state *uart)
+{
+	switch (uart->num) {
+	case 0:
+		uart->irq	= INT_24XX_UART1_IRQ;
+		break;
+	case 1:
+		uart->irq	= INT_24XX_UART2_IRQ;
+		break;
+	case 2:
+		uart->irq	= INT_24XX_UART3_IRQ;
+		break;
+	}
+	uart->regshift = 2;
+}
+
 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
-	struct plat_serial8250_port *p = uart->p;
 	int ret;

 	uart->can_sleep = 0;
@@ -495,8 +550,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->padconf = 0;
 	}

-	p->irqflags |= IRQF_SHARED;
-	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
+	uart->irqflags |= IRQF_SHARED;
+	ret = request_irq(uart->irq, omap_uart_interrupt, IRQF_SHARED,
 			  "serial idle", (void *)uart);
 	WARN_ON(ret);
 }
@@ -508,10 +563,10 @@ void omap_uart_enable_irqs(int enable)

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

@@ -558,46 +613,6 @@ DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
-
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
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
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
-
 /*
  * Override the default 8250 read handler: mem_serial_in()
  * Empty RX fifo read causes an abort on omap3630 and omap4
@@ -630,6 +645,7 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
 	}
 	__serial_write_reg(up, offset, value);
 }
+
 void __init omap_serial_early_init(void)
 {
 	int i, nr_ports;
@@ -652,8 +668,17 @@ void __init omap_serial_early_init(void)
 		struct device *dev = &pdev->dev;
 		struct plat_serial8250_port *p = dev->platform_data;

+		uart->num = i;
+		/*
+		 * Populate irq value independently into
+		 * omap_uart_state structure.
+		 * Dont want to depend on 8250 structure.
+		 * TODO: will be removed while adding hwmod
+		 */
+		omap_uart_irq_port_init(uart);
+
 		/* Don't map zero-based physical address */
-		if (p->mapbase == 0) {
+		if (uart->mapbase == 0) {
 			dev_warn(dev, "no physical address for uart#%d,"
 				 " so skipping early_init...\n", i);
 			continue;
@@ -662,8 +687,8 @@ void __init omap_serial_early_init(void)
 		 * Module 4KB + L4 interconnect 4KB
 		 * Static mapping, never released
 		 */
-		p->membase = ioremap(p->mapbase, SZ_8K);
-		if (!p->membase) {
+		uart->membase = ioremap(uart->mapbase, SZ_8K);
+		if (!uart->membase) {
 			dev_err(dev, "ioremap failed for uart%i\n", i + 1);
 			continue;
 		}
@@ -688,12 +713,12 @@ void __init omap_serial_early_init(void)
 				continue;
 		}

-		uart->num = i;
 		p->private_data = uart;
-		uart->p = p;
+		p->membase = uart->membase;
+		p->mapbase = uart->mapbase;

 		if (cpu_is_omap44xx())
-			p->irq += 32;
+			uart->irq += 32;
 	}
 }

@@ -713,7 +738,7 @@ void __init omap_serial_init_port(int port)
 	struct omap_uart_state *uart;
 	struct platform_device *pdev;
 	struct device *dev;
-
+	struct plat_serial8250_port *p;
 	BUG_ON(port < 0);
 	BUG_ON(port >= ARRAY_SIZE(omap_uart));

@@ -733,36 +758,37 @@ void __init omap_serial_init_port(int port)
 	omap_uart_reset(uart);
 	omap_uart_idle_init(uart);

+	p = dev->platform_data;
+	/*
+	 * omap44xx: Never read empty UART fifo
+	 * omap3xxx: Never read empty UART fifo on UARTs
+	 * with IP rev >=0x52
+	 */
+	if (cpu_is_omap44xx()) {
+		p->serial_in = serial_in_override;
+		p->serial_out = serial_out_override;
+	} else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
+			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV) {
+		p->serial_in = serial_in_override;
+		p->serial_out = serial_out_override;
+	}
+
 	list_add_tail(&uart->node, &uart_list);

 	if (WARN_ON(platform_device_register(pdev)))
 		return;

 	if ((cpu_is_omap34xx() && uart->padconf) ||
-	    (uart->wk_en && uart->wk_mask)) {
+		(uart->wk_en && uart->wk_mask)) {
 		device_init_wakeup(dev, true);
 		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
 	}
-
-	/*
-	 * omap44xx: Never read empty UART fifo
-	 * omap3xxx: Never read empty UART fifo on UARTs
-	 * with IP rev >=0x52
-	 */
-	if (cpu_is_omap44xx()) {
-		uart->p->serial_in = serial_in_override;
-		uart->p->serial_out = serial_out_override;
-	} else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
-			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV) {
-		uart->p->serial_in = serial_in_override;
-		uart->p->serial_out = serial_out_override;
-	}
 }

 /**
  * omap_serial_init() - intialize all supported serial ports
  *
- * Initializes all available UARTs as serial ports. Platforms
+  * Initializes all available UARTs as serial ports. Platforms
  * can call this function when they want to have default behaviour
  * for serial ports (e.g initialize them all as serial ports).
  */
-- 
1.6.3.3


