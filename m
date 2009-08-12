From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/10] OMAP2/3: Pass irqflags to 8250 driver
Date: Wed, 12 Aug 2009 15:14:42 +0300
Message-ID: <20090812121442.17601.39625.stgit@localhost>
References: <20090812120926.17601.85860.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63324 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbZHLMOn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 08:14:43 -0400
In-Reply-To: <20090812120926.17601.85860.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

From: Vikram Pandita <vikram.pandita@ti.com>

Pass irqflags to 8250 driver with platform_data. At least Zoom2 has
IRQF_TRIGGER_RISING requirement for the 8250 GPIO irq.

This patch is dependent on 8250 driver changes getting accepted upstream:
http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=commit;h=7053133124d5cdf207c1168c7a0c582a18e12ea7

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
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
index 555e735..3f29376 100644
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

