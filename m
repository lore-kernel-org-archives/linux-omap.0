From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] arm:omap:serial:cleanup: use module rev instead of cpu_is_xxxx
Date: Mon, 7 Nov 2011 20:27:40 +0530
Message-ID: <1320677860-32663-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41231 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab1KGO5q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Nov 2011 09:57:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

For OMAP3 uarts (module rev >= 0x52) and all successor devices
(omap4, TI81xx, AM33xx, etc...) empty fifo read errata is applicable,
so we can get rid of cpu_is_xxxx check and simply check for module rev here.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
NOTE: This patch has been tested on OMAP3EVM, and I expect to work on all OMAP3
family of devices (including TI816x, TI814x, AM335x, etc...).
but I am quite not sure about OMAP2 device, can anybody comment/test?

 arch/arm/mach-omap2/serial.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 9992dbf..ac274dc 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -740,16 +740,16 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	p->private_data = uart;
 
 	/*
-	 * omap44xx, ti816x: Never read empty UART fifo
+	 * all >omap3 family of devices: Never read empty UART fifo
 	 * omap3xxx: Never read empty UART fifo on UARTs
 	 * with IP rev >=0x52
 	 */
 	uart->regshift = p->regshift;
 	uart->membase = p->membase;
-	if (cpu_is_omap44xx() || cpu_is_ti816x())
-		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
-	else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
-			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+	if (cpu_is_omap34xx() && (serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
+			< UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+		uart->errata &= ~UART_ERRATA_FIFO_FULL_ABORT;
+	else
 		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
 
 	if (uart->errata & UART_ERRATA_FIFO_FULL_ABORT) {
-- 
1.7.0.4

