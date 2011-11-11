From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 19/20] OMAP2+: UART: Do not gate uart clocks if used for debug_prints
Date: Fri, 11 Nov 2011 15:31:52 +0530
Message-ID: <1321005712-21871-5-git-send-email-govindraj.raja@ti.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44664 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613Ab1KKKCY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 05:02:24 -0500
In-Reply-To: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

If OMAP UART is used as console uart and debug is enabled,
avoid gating of uart clocks to print all debug prints.

If uart clocks are gated then the debug prints from omap_device
framework or hwmod framework can cause uart to enter recursive
pm_runtime calls, which can cause a deadlock over power lock usage.

For example: Say, uart clocks are cut and we get a print from
omap_device_disable stating disabling uart clocks. This print
calls omap_uart driver console_write which will call runtime API
get_sync which means we enter from runtime API put context to
runtime API get context.

--> runtime put (take power lock)
    --> print disabling uart clocks
        --> call uart console write
            --> call get_sync (try to take power lock)

Also any clock enable API call from uart driver should not call any uart
operation until clocks are enabled back. Like get_sync having debug print
calling uart console write even before clocks are enabled.

So to avoid these scenarios, identify from bootargs if OMAP_UART(ttyO) is used
in debug mode. If so, do not set device_may_wakeup. This will prevent
pm_runtime_enable in uart driver and will avoid uart clock gating.
Debug is enabled either by adding debug word in bootarg or by setting
loglevel=10

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5d910ef..a5d9c9c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -66,6 +66,7 @@ static LIST_HEAD(uart_list);
 static u8 num_uarts;
 static u8 console_uart_id = -1;
 static u8 no_console_suspend;
+static u8 uart_debug;
 
 #define DEFAULT_RXDMA_POLLRATE		1	/* RX DMA polling rate (us) */
 #define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
@@ -329,6 +330,13 @@ static int __init omap_serial_early_init(void)
 		if (cmdline_find_option(uart_name)) {
 			console_uart_id = uart->num;
 
+			if (console_loglevel >= 10) {
+				uart_debug = true;
+				pr_info("%s used as console in debug mode"
+						" uart%d clocks will not be"
+						" gated", uart_name, uart->num);
+			}
+
 			if (cmdline_find_option("no_console_suspend"))
 				no_console_suspend = true;
 
@@ -432,7 +440,8 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 
 	oh->dev_attr = uart;
 
-	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+			&& !uart_debug)
 		device_init_wakeup(&pdev->dev, true);
 }
 
-- 
1.7.4.1

