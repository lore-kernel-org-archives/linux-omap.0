From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH 6/6] Serial: Update UART HWMOD layer.
Date: Thu, 20 May 2010 19:09:17 +0530 (IST)
Message-ID: <49040.192.168.10.88.1274362757.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39911 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab0ETNjS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 09:39:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.co>


This patch does the following changes to the UART HWMOD layer:

a.) Binding 8250 code with CONFIG_8250 and omap-serial code with
    CONFIG_OMAP_SERIAL needs to re-considered.
    The reason being during multi-omap builds both can be enabled.
    For ZOOM boards where we have a debug board uart which needs to
    be handled with 8250 and omap-uarts can be handled either using
    omap-serial or 8250 in such scenearios both driver will try to
    take over omap-uarts. So keeping dependency towards omap-serial,
    if it is enabled then we will use omap-serial to handle omap-uarts
    else if it is not defined we will use 8250 to handle omap-uarts.
b.) Use driver name defined in omap-serial.h for name parameter.
c.) Since we request threaded_irq during omap_uart_idle_init
    we need to use threaded_irq only while enabling and disabling
    the interrupt line.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 9b71c1e..38a74d0 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -25,12 +25,9 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-
-#ifdef CONFIG_SERIAL_8250_CONSOLE
 #include <linux/serial_8250.h>
-#endif

-#ifdef CONFIG_SERIAL_OMAP_CONSOLE
+#ifdef CONFIG_SERIAL_OMAP
 #include <plat/omap-serial.h>
 #endif

@@ -483,8 +480,11 @@ void omap_uart_enable_irqs(int enable)

 	list_for_each_entry(uart, &uart_list, node) {
 		if (enable)
-			ret = request_irq(uart->irq, omap_uart_interrupt,
-				IRQF_SHARED, "serial idle", (void *)uart);
+			ret = request_threaded_irq(uart->irq, NULL,
+						   omap_uart_interrupt,
+						   IRQF_SHARED,
+						   "serial idle",
+						   (void *)uart);
 		else
 			free_irq(uart->irq, (void *)uart);
 	}
@@ -529,11 +529,11 @@ DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
 #define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
 #else
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
+static void omap_uart_block_sleep(struct omap_uart_state *uart) {}
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */

-
-#ifdef CONFIG_SERIAL_8250_CONSOLE
+#ifndef CONFIG_SERIAL_OMAP
 /*
  * Override the default 8250 read handler: mem_serial_in()
  * Empty RX fifo read causes an abort on omap3630 and omap4
@@ -635,14 +635,13 @@ void __init omap_serial_init_port(int port)
 	void *pdata = NULL;
 	u32 pdata_size = 0;
 	char *name;
-#ifdef CONFIG_SERIAL_8250_CONSOLE
+#ifndef CONFIG_SERIAL_OMAP
 	struct plat_serial8250_port ports[2] = {
 		{},
 		{.flags = 0},
 	};
 	struct plat_serial8250_port *p = &ports[0];
-#endif
-#ifdef CONFIG_SERIAL_OMAP_CONSOLE
+#else
 	struct omap_uart_port_info omap_up;
 #endif

@@ -657,7 +656,7 @@ void __init omap_serial_init_port(int port)

 	oh = uart->oh;
 	uart->dma_enabled = 0;
-#ifdef CONFIG_SERIAL_8250_CONSOLE
+#ifndef CONFIG_SERIAL_OMAP
 	name = "serial8250";

 	/*
@@ -680,7 +679,6 @@ void __init omap_serial_init_port(int port)
 	p->irqflags = IRQF_SHARED;
 	p->private_data = uart;

-#if 0
 	/*
 	 * omap44xx: Never read empty UART fifo
 	 * omap3xxx: Never read empty UART fifo on UARTs
@@ -696,13 +694,12 @@ void __init omap_serial_init_port(int port)
 		p->serial_in = serial_in_override;
 		p->serial_out = serial_out_override;
 	}
-#endif

 	pdata = &ports[0];
 	pdata_size = 2 * sizeof(struct plat_serial8250_port);
-#endif
-#ifdef CONFIG_SERIAL_OMAP_CONSOLE
-	name = "omap-hsuart";
+#else
+
+	name = DRIVER_NAME;

 	omap_up.dma_enabled = uart->dma_enabled;
 	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
-- 
1.6.3.3





