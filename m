From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 13/20] OMAP2+: UART: Remove old and unused clocks handling funcs
Date: Fri, 11 Nov 2011 15:29:11 +0530
Message-ID: <1321005551-21786-4-git-send-email-govindraj.raja@ti.com>
References: <1321005551-21786-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1321005551-21786-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

With runtime adaptation done remove clock_enable/disbale API's

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   36 ------------------------------------
 1 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index d1d8b88..6d574f0 100644
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
@@ -66,36 +64,8 @@ struct omap_uart_state {
 static LIST_HEAD(uart_list);
 static u8 num_uarts;
 
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
@@ -154,11 +124,6 @@ static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
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
@@ -404,7 +369,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_device_enable(uart->pdev);
 	omap_device_idle(uart->pdev);
 
-	omap_uart_block_sleep(uart);
 	console_unlock();
 
 	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
-- 
1.7.4.1

