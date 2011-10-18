From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v7 13/21] OMAP2+: UART: Remove old and unused clocks handling funcs
Date: Tue, 18 Oct 2011 20:56:08 +0530
Message-ID: <1318951576-10165-14-git-send-email-govindraj.raja@ti.com>
References: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58562 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932542Ab1JRP07 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Oct 2011 11:26:59 -0400
In-Reply-To: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

With runtime adaptation done remove clock_enable/disbale API's

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   36 ------------------------------------
 1 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 6b3f0bd..66c8360 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -56,8 +56,6 @@ struct omap_uart_state {
 	int num;
 	int can_sleep;
 
-	int clocked;
-
 	struct list_head node;
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
@@ -88,36 +86,8 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
 	},
 };
 
-static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
-{
-	if (uart->clocked)
-		return;
-
-	omap_device_enable(uart->pdev);
-	uart->clocked = 1;
-	omap_uart_restore_context(uart);
-}
-
 #ifdef CONFIG_PM
 
-static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
-{
-	if (!uart->clocked)
-		return;
-
-	omap_uart_save_context(uart);
-	uart->clocked = 0;
-	omap_device_idle(uart->pdev);
-}
-
-static void omap_uart_block_sleep(struct omap_uart_state *uart)
-{
-	omap_uart_enable_clocks(uart);
-
-	omap_uart_smart_idle_enable(uart, 0);
-	uart->can_sleep = 0;
-}
-
 int omap_uart_can_sleep(void)
 {
 	struct omap_uart_state *uart;
@@ -176,11 +146,6 @@ static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
 {}
 static void omap_uart_set_noidle(struct platform_device *pdev) {}
 static void omap_uart_set_forceidle(struct platform_device *pdev) {}
-static void omap_uart_block_sleep(struct omap_uart_state *uart)
-{
-	/* Needed to enable UART clocks when built without CONFIG_PM */
-	omap_uart_enable_clocks(uart);
-}
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_OMAP_MUX
@@ -426,7 +391,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_device_enable(uart->pdev);
 	omap_device_idle(uart->pdev);
 
-	omap_uart_block_sleep(uart);
 	console_unlock();
 
 	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
-- 
1.7.4.1

