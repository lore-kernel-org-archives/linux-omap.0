From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 3/3] Serial: Add omap-serial platform data support.
Date: Mon, 12 Apr 2010 16:12:36 +0530 (IST)
Message-ID: <33735.192.168.10.89.1271068956.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43022 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658Ab0DLKmi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Apr 2010 06:42:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch adds platform data support for omap-serial
driver, when omap-serial driver is enabled from menuconfig
the omap uarts will be handled using the omap-serial driver.
All 8250 platform support is binded with dependency on
omap-serial driver which is done inorder to support multi
omap buids.
Boards like zoom2/3 need both 8250(to handle QUART
on debug board)and omap-serial(to support omap uarts)
to be enabled. Thus when omap-serial is disabled
omap uarts will be handled with 8250 and if omap-serial
support is enabled it will handled with omap-serial driver.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |  139 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 132 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 14ed9fb..4f9354f 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -30,6 +30,9 @@
 #include <plat/clock.h>
 #include <plat/control.h>

+#include <plat/dma.h>
+#include <plat/omap-serial.h>
+
 #include "prm.h"
 #include "pm.h"
 #include "prm-regbits-34xx.h"
@@ -60,11 +63,13 @@ struct omap_uart_state {
 	struct clk *fck;
 	int clocked;

+	int dma_enabled;
 	int irq;
 	int regshift;
 	int irqflags;
 	void __iomem *membase;
 	resource_size_t mapbase;
+
 	struct list_head node;
 	struct platform_device pdev;

@@ -83,6 +88,7 @@ struct omap_uart_state {

 static LIST_HEAD(uart_list);

+#ifndef CONFIG_SERIAL_OMAP
 static struct plat_serial8250_port serial_platform_data0[] = {
 	{
 		.irq		= 72,
@@ -169,7 +175,107 @@ static struct omap_uart_state omap_uart[] = {
 	},
 #endif
 };
+#else
+static struct omap_uart_port_info uart1_port_info = {
+		.dma_enabled	= 0,
+};
+
+static struct omap_uart_port_info uart2_port_info = {
+		.dma_enabled	= 1,
+};
+
+static struct omap_uart_port_info uart3_port_info = {
+		.dma_enabled	= 0,
+};
+
+static struct resource omap_uart1_resources[] = {
+	{
+		.start          = OMAP2_UART1_BASE,
+		.end            = OMAP2_UART1_BASE + 0x3ff,
+		.flags          = IORESOURCE_MEM,
+	}, {
+		/* UART1 IRQ - 72*/
+		.start          = INT_24XX_UART1_IRQ,
+		.flags          = IORESOURCE_IRQ,
+	}, {
+		/* UART1 RX DMA CHANNEL -S_DMA_49- */
+		.start		= OMAP24XX_DMA_UART1_RX,
+		.flags		= IORESOURCE_DMA,
+	}, {
+		/* UART1 TX DMA CHANNEL -S_DMA_48- */
+		.start		= OMAP24XX_DMA_UART1_TX,
+		.flags		= IORESOURCE_DMA,
+	}
+};
+
+static struct resource omap_uart2_resources[] = {
+	{
+		.start          = OMAP2_UART2_BASE,
+		.end            = OMAP2_UART2_BASE + 0x3ff,
+		.flags          = IORESOURCE_MEM,
+	}, {
+		/* UART2 IRQ - 73*/
+		.start          = INT_24XX_UART2_IRQ,
+		.flags          = IORESOURCE_IRQ,
+	}, {
+		/* UART2 RX DMA CHANNEL -S_DMA_51- */
+		.start		= OMAP24XX_DMA_UART2_RX,
+		.flags		= IORESOURCE_DMA,
+	}, {
+		/* UART2 TX DMA CHANNEL -S_DMA_50- */
+		.start		= OMAP24XX_DMA_UART2_TX,
+		.flags		= IORESOURCE_DMA,
+	}
+};
+
+static struct resource omap_uart3_resources[] = {
+	{
+		.start          = OMAP2_UART3_BASE,
+		.end            = OMAP2_UART3_BASE + 0x3ff,
+		.flags          = IORESOURCE_MEM,
+	}, {
+		/* UART3 IRQ - 74*/
+		.start          = INT_24XX_UART3_IRQ,
+		.flags          = IORESOURCE_IRQ,
+	}, {
+		/* UART3 RX DMA CHANNEL -S_DMA_53- */
+		.start		= OMAP24XX_DMA_UART3_RX,
+		.flags		= IORESOURCE_DMA,
+	}, {
+		/* UART3 TX DMA CHANNEL -S_DMA_52- */
+		.start		= OMAP24XX_DMA_UART3_TX,
+		.flags		= IORESOURCE_DMA,
+	}
+};

+static struct omap_uart_state omap_uart[OMAP_MAX_HSUART_PORTS] = {
+	{
+		.pdev = {
+			.num_resources	= ARRAY_SIZE(omap_uart1_resources),
+			.resource	= omap_uart1_resources,
+			.dev		= {
+				.platform_data  = &uart1_port_info
+			},
+		}
+	}, {
+		.pdev = {
+			.num_resources	= ARRAY_SIZE(omap_uart2_resources),
+			.resource	= omap_uart2_resources,
+			.dev		= {
+				.platform_data  = &uart2_port_info,
+			},
+		}
+	}, {
+		.pdev = {
+			.num_resources	= ARRAY_SIZE(omap_uart3_resources),
+			.resource	= omap_uart3_resources,
+			.dev		= {
+				.platform_data  = &uart3_port_info,
+			},
+		}
+	}
+};
+#endif

 void __init omap2_set_globals_uart(struct omap_globals *omap2_globals)
 {
@@ -613,6 +719,8 @@ DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
+
+#ifndef CONFIG_SERIAL_OMAP
 /*
  * Override the default 8250 read handler: mem_serial_in()
  * Empty RX fifo read causes an abort on omap3630 and omap4
@@ -645,6 +753,7 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
 	}
 	__serial_write_reg(up, offset, value);
 }
+#endif

 void __init omap_serial_early_init(void)
 {
@@ -666,7 +775,6 @@ void __init omap_serial_early_init(void)
 		struct omap_uart_state *uart = &omap_uart[i];
 		struct platform_device *pdev = &uart->pdev;
 		struct device *dev = &pdev->dev;
-		struct plat_serial8250_port *p = dev->platform_data;

 		uart->num = i;
 		/*
@@ -713,10 +821,6 @@ void __init omap_serial_early_init(void)
 				continue;
 		}

-		p->private_data = uart;
-		p->membase = uart->membase;
-		p->mapbase = uart->mapbase;
-
 		if (cpu_is_omap44xx())
 			uart->irq += 32;
 	}
@@ -738,7 +842,12 @@ void __init omap_serial_init_port(int port)
 	struct omap_uart_state *uart;
 	struct platform_device *pdev;
 	struct device *dev;
+#ifndef CONFIG_SERIAL_OMAP
 	struct plat_serial8250_port *p;
+#else
+	struct omap_uart_port_info *omap_up;
+#endif
+
 	BUG_ON(port < 0);
 	BUG_ON(port >= ARRAY_SIZE(omap_uart));

@@ -746,6 +855,22 @@ void __init omap_serial_init_port(int port)
 	pdev = &uart->pdev;
 	dev = &pdev->dev;

+#ifndef CONFIG_SERIAL_OMAP
+	p = dev->platform_data;
+	p->private_data = uart;
+	p->membase = uart->membase;
+	p->mapbase = uart->mapbase;
+#else
+	omap_up = dev->platform_data;
+	uart->dma_enabled = omap_up->dma_enabled;
+	omap_up->uartclk = OMAP24XX_BASE_BAUD * 16;
+	omap_up->membase = uart->membase;
+	omap_up->mapbase = uart->mapbase;
+	omap_up->irqflags |= IRQF_SHARED;
+	omap_up->flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	pdev->name = DRIVER_NAME;
+	pdev->id = port;
+#endif
 	/* Don't proceed if there's no clocks available */
 	if (unlikely(!uart->ick || !uart->fck)) {
 		WARN(1, "%s: can't init uart%d, no clocks available\n",
@@ -758,7 +883,7 @@ void __init omap_serial_init_port(int port)
 	omap_uart_reset(uart);
 	omap_uart_idle_init(uart);

-	p = dev->platform_data;
+#ifndef CONFIG_SERIAL_OMAP
 	/*
 	 * omap44xx: Never read empty UART fifo
 	 * omap3xxx: Never read empty UART fifo on UARTs
@@ -772,7 +897,7 @@ void __init omap_serial_init_port(int port)
 		p->serial_in = serial_in_override;
 		p->serial_out = serial_out_override;
 	}
-
+#endif
 	list_add_tail(&uart->node, &uart_list);

 	if (WARN_ON(platform_device_register(pdev)))
-- 
1.6.3.3


