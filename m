From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2] OMAP2: Zoom2: Pass irqflags to 8250 driver
Date: Mon, 22 Jun 2009 18:25:26 -0500
Message-ID: <1245713126-18312-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52092 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbZFVX3M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Jun 2009 19:29:12 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5MNT96T000628
	for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 18:29:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Pass irqflags to 8250 driver from zoom2 board file
Zoom2 has IRQF_TRIGGER_RISING requirement for the 8250 GPIO irq

This patch is dependent on 8250 driver changes getting accepted upstream:
Refer: http://patchwork.kernel.org/patch/31884/

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---

Warning: 
could cause compilation break if 8250 patch is not integrated first

 arch/arm/mach-omap2/board-zoom-debugboard.c |    2 ++
 arch/arm/mach-omap2/serial.c                |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index bac5c43..f546063 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -12,6 +12,7 @@
 #include <linux/gpio.h>
 #include <linux/serial_8250.h>
 #include <linux/smsc911x.h>
+#include <linux/interrupt.h>
 
 #include <mach/gpmc.h>
 
@@ -84,6 +85,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.mapbase	= 0x10000000,
 		.irq		= OMAP_GPIO_IRQ(102),
 		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ,
+		.irqflags	= IRQF_SHARED | IRQF_TRIGGER_RISING,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
 		.uartclk	= QUART_CLK,
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b094c15..45d4884 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -429,7 +429,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		omap_ctrl_writew(v, uart->padconf);
 	}
 
-	p->flags |= UPF_SHARE_IRQ;
+	p->irqflags |= IRQF_SHARED;
 	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
 			  "serial idle", (void *)uart);
 	WARN_ON(ret);
-- 
1.6.0.3.613.g9f8f13

