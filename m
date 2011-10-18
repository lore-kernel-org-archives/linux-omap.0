From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used for debug_prints
Date: Tue, 18 Oct 2011 21:05:41 +0530
Message-ID: <1318952141-10697-2-git-send-email-govindraj.raja@ti.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

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

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5e3bbce..e83951a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -65,6 +65,7 @@ static LIST_HEAD(uart_list);
 static u8 num_uarts;
 static u8 console_uart_id = -1;
 static u8 no_console_suspend;
+static u8 uart_debug;
 
 #define DEFAULT_RXDMA_POLLRATE		1	/* RX DMA polling rate (us) */
 #define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
@@ -310,6 +311,13 @@ static int __init omap_serial_early_init(void)
 		if (cmdline_find_option(uart_name)) {
 			console_uart_id = uart->num;
 
+			if (cmdline_find_option("debug")) {
+				uart_debug = true;
+				pr_info("%s used as console in debug mode"
+						" uart%d clocks will not be"
+						" gated", uart_name, uart->num);
+			}
+
 			if (cmdline_find_option("no_console_suspend"))
 				no_console_suspend = true;
 
@@ -414,7 +422,8 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 
 	oh->dev_attr = uart;
 
-	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+			&& !uart_debug)
 		device_init_wakeup(&pdev->dev, true);
 }
 
-- 
1.7.4.1

