From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM-20081106] OMAP: PM: Few fixes to uart clock handling
Date: Wed, 19 Nov 2008 11:54:34 +0200
Message-ID: <1227088474-27452-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20007 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbYKSJyj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 04:54:39 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAJ9sEdv030981
	for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 11:54:36 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Omap3_can_sleep is not inside part of idle loop which is protected
with irg disable. If some irq handler is trying dump out something
after omap3_can_sleep and before irqs are disabled. It causes oops
because uart clocks are disabled.

Remove also some unused extra code from omap_uart_can_sleep

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/serial.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index ef30d8d..b06b797 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -314,21 +314,13 @@ void omap_uart_check_wakeup(void)
 int omap_uart_can_sleep(void)
 {
 	struct omap_uart_state *uart;
-	int can_sleep = 1;
 
 	list_for_each_entry(uart, &uart_list, node) {
-		if (!uart->clocked)
+		if (!uart->clocked || !uart->can_sleep)
 			continue;
 
-		if (!uart->can_sleep) {
-			can_sleep = 0;
-			continue;
-		}
-
 		/* This UART can now safely sleep. */
 		omap_uart_allow_sleep(uart);
-		if (clocks_off_while_idle)
-			omap_uart_disable_clocks(uart);
 	}
 
 	return 1;
@@ -435,7 +427,6 @@ static void omap_uart_pm(struct uart_port *port,
 		break;
 	case 3: /* suspend */
 		omap_uart_allow_sleep(uart);
-		omap_uart_disable_clocks(uart);
 		break;
 	}
 }
-- 
1.6.0.1

