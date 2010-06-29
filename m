From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH 1/3] OMAP3:PM:  Keep UART clocks disabled is resume idle path
Date: Tue, 29 Jun 2010 12:28:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323763481@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51988 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab0F2G7F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 02:59:05 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Teerth Reddy <teerth@ti.com>

The UART clocks should not be turned on in resume idle path. The UART clocks
should be turned on only when there is a uart wakeup event. This optimization
will help save power.

Signed-off-by: Raja Govindraj <govindraj.raja@ti.com>
Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3771254..d545eed 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -343,6 +343,7 @@ static void omap_uart_idle_timer(unsigned long data)
 {
 	struct omap_uart_state *uart = (struct omap_uart_state *)data;
 
+	uart->timeout = DEFAULT_TIMEOUT;
 	omap_uart_allow_sleep(uart);
 }
 
@@ -364,7 +365,6 @@ void omap_uart_resume_idle(int num)
 
 	list_for_each_entry(uart, &uart_list, node) {
 		if (num == uart->num) {
-			omap_uart_enable_clocks(uart);
 
 			/* Check for IO pad wakeup */
 			if (cpu_is_omap34xx() && uart->padconf) {
@@ -436,7 +436,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	int ret;
 
 	uart->can_sleep = 0;
-	uart->timeout = DEFAULT_TIMEOUT;
+	uart->timeout = 30 * HZ;
 	setup_timer(&uart->timer, omap_uart_idle_timer,
 		    (unsigned long) uart);
 	if (uart->timeout)
-- 
1.5.4.3

