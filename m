From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCHv2 2/3] OMAP UART: Add platform data for omap-serial driver.
Date: Wed, 28 Oct 2009 12:43:42 +0530 (IST)
Message-ID: <36298.192.168.10.88.1256714022.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757393AbZJ1HNh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 03:13:37 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9S7DgVI028906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 02:13:42 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9S7DeYL009780
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 02:13:41 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 0f017ffac2990876331a2378e7845d91b2e0088c Mon Sep 17 00:00:00 2001
From: Govindraj R <govindraj.raja@ti.com>
Date: Wed, 28 Oct 2009 12:23:02 +0530
Subject: [PATCHv2 2/3] OMAP UART: Add platform data for omap-serial driver.

This patch adds platform data support for omap-serial driver.

Signed-off-by: Govindraj R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |  166 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 166 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index dabc089..aa3a282 100644
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
@@ -29,6 +32,10 @@
 #include <plat/clock.h>
 #include <plat/control.h>

+#ifdef CONFIG_SERIAL_OMAP
+#include <plat/dma.h>
+#include <plat/omap-serial.h>
+#endif
 #include "prm.h"
 #include "pm.h"
 #include "prm-regbits-34xx.h"
@@ -37,6 +44,7 @@

 #define DEFAULT_TIMEOUT (5 * HZ)

+#ifdef CONFIG_SERIAL_8250
 struct omap_uart_state {
 	int num;
 	int can_sleep;
@@ -654,3 +662,161 @@ void __init omap_serial_init(void)
 		}
 	}
 }
+#endif
+
+#ifdef CONFIG_SERIAL_OMAP
+
+static struct uart_port_info uart1_port_info = {
+		.dma_enabled	= 0,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16
+};
+
+static struct uart_port_info uart2_port_info = {
+		.dma_enabled	= 1,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16
+};
+
+static struct uart_port_info uart3_port_info = {
+		.dma_enabled	= 0,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16
+};
+
+static struct resource omap2_uart1_resources[] = {
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
+static struct resource omap2_uart2_resources[] = {
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
+static struct resource omap2_uart3_resources[] = {
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
+/* OMAP UART platform structure */
+static struct platform_device uart1_device = {
+	.name			= "omap-uart",
+	.id			= 1,
+	.num_resources		= ARRAY_SIZE(omap2_uart1_resources),
+	.resource		= omap2_uart1_resources,
+	.dev			= {
+		.platform_data  = &uart1_port_info
+	},
+};
+static struct platform_device uart2_device = {
+	.name			= "omap-uart",
+	.id			= 2,
+	.num_resources		= ARRAY_SIZE(omap2_uart2_resources),
+	.resource		= omap2_uart2_resources,
+	.dev			= {
+		.platform_data  = &uart2_port_info,
+	},
+};
+static struct platform_device uart3_device = {
+	.name			= "omap-uart",
+	.id			= 3,
+	.num_resources		= ARRAY_SIZE(omap2_uart3_resources),
+	.resource		= omap2_uart3_resources,
+	.dev			= {
+		.platform_data  = &uart3_port_info,
+	},
+};
+
+static struct platform_device *uart_devices[] = {
+	&uart1_device,
+	&uart2_device,
+	&uart3_device,
+};
+
+void omap_serial_hsuart_wakeup_source_init(int num)
+{
+	struct omap_hsuart_state *uart = &omap_hsuart[num];
+
+	if (cpu_is_omap34xx()) {
+		u32 mod = (uart->num == 2) ? OMAP3430_PER_MOD : CORE_MOD;
+		u32 wk_mask = 0;
+		u32 padconf = 0;
+
+		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
+		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
+		switch (uart->num) {
+		case 0:
+			wk_mask = OMAP3430_ST_UART1_MASK;
+			padconf = 0x182;
+			break;
+		case 1:
+			wk_mask = OMAP3430_ST_UART2_MASK;
+			padconf = 0x17a;
+			break;
+		case 2:
+			wk_mask = OMAP3430_ST_UART3_MASK;
+			padconf = 0x19e;
+			break;
+		}
+		uart->wk_mask = wk_mask;
+		uart->padconf = padconf;
+	} else {
+		uart->wk_en = 0;
+		uart->wk_st = 0;
+		uart->wk_mask = 0;
+		uart->padconf = 0;
+	}
+}
+
+void __init omap_serial_init(void)
+{
+	int ret = 0, i;
+	for (i = 0; i < ARRAY_SIZE(uart_devices); i++)
+		omap_hsuart_idle_init(i);
+
+	ret = platform_add_devices(uart_devices, ARRAY_SIZE(uart_devices));
+}
+#endif /* CONFIG_SERIAL_OMAP */
-- 
1.5.5





