From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: Serial: Improved sleep logic
Date: Tue,  2 Feb 2010 13:30:24 +0200
Message-ID: <1265110224-29473-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55821 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab0BBJlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 04:41:09 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o129ciWP016351
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 03:41:08 -0600
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o129erTd021611
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 11:40:53 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Only RX interrupt will now kick the sleep prevent timer. In addition, TX
fifo status is checked before disabling clocks, this will prevent occasional
garbage being printed on serial line. Smartidle is also disabled while
entering idle if we have data in the transmit buffer, because having this
enabled will prevent wakeups from the TX interrupt, and this causes
pauses while sending large blocks of data.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/serial.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 777e802..e11dfe9 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -317,7 +317,8 @@ static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 	if (!uart->clocked)
 		return;
 
-	omap_uart_smart_idle_enable(uart, 1);
+	if (serial_read_reg(uart->p, UART_LSR) & UART_LSR_TEMT)
+		omap_uart_smart_idle_enable(uart, 1);
 	uart->can_sleep = 1;
 	del_timer(&uart->timer);
 }
@@ -335,7 +336,11 @@ void omap_uart_prepare_idle(int num)
 
 	list_for_each_entry(uart, &uart_list, node) {
 		if (num == uart->num && uart->can_sleep) {
-			omap_uart_disable_clocks(uart);
+			if (serial_read_reg(uart->p, UART_LSR) &
+					UART_LSR_TEMT)
+				omap_uart_disable_clocks(uart);
+			else
+				omap_uart_smart_idle_enable(uart, 0);
 			return;
 		}
 	}
@@ -407,8 +412,14 @@ int omap_uart_can_sleep(void)
 static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 {
 	struct omap_uart_state *uart = dev_id;
+	u8 lsr;
 
-	omap_uart_block_sleep(uart);
+	lsr = serial_read_reg(uart->p, UART_LSR);
+	/* Check for receive interrupt */
+	if (lsr & UART_LSR_DR)
+		omap_uart_block_sleep(uart);
+	if (lsr & UART_LSR_TEMT && uart->can_sleep)
+		omap_uart_smart_idle_enable(uart, 1);
 
 	return IRQ_NONE;
 }
-- 
1.5.4.3

