From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 17/20] OMAP2+: UART: Use custom activate func for console uart.
Date: Fri, 11 Nov 2011 15:31:50 +0530
Message-ID: <1321005712-21871-3-git-send-email-govindraj.raja@ti.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53797 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1KKKCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Nov 2011 05:02:16 -0500
In-Reply-To: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

Omap-uart can be used as console uart to print early boot
messages using earlyprintk so for console uart prevent
hwmod reset or idling during bootup.

Identify the console_uart set the id and use the custom
pm_latency ops for console uart for the first time
to idle console uart left enabled from bootup and then enable
them back and reset pm_latency ops to default ops.

Thanks to Kevin Hilman <khilman@ti.com> for suggesting
this approach.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   86 +++++++++++++++++++++++++++++------------
 1 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 4d65d00..631d72a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -61,8 +61,10 @@ struct omap_uart_state {
 	struct platform_device *pdev;
 };
 
+static struct omap_device_pm_latency *default_uart_latency;
 static LIST_HEAD(uart_list);
 static u8 num_uarts;
+static u8 console_uart_id = -1;
 
 #define DEFAULT_RXDMA_POLLRATE		1	/* RX DMA polling rate (us) */
 #define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
@@ -78,6 +80,34 @@ static struct omap_uart_port_info omap_serial_default_info[] __initdata = {
 	},
 };
 
+static int console_uart_enable_hwmod(struct omap_device *od)
+{
+	console_lock();
+	/*
+	 * For early console we prevented hwmod reset and idle
+	 * So before we enable the uart clocks idle the console
+	 * uart clocks, then enable back the console uart hwmod.
+	 */
+	omap_hwmod_idle(od->hwmods[0]);
+	omap_hwmod_enable(od->hwmods[0]);
+	console_unlock();
+
+	/*
+	 * Restore the default activate/deactivate funcs,
+	 * since now we have set the hwmod state machine right
+	 * with the idle/enable for console uart
+	 */
+	od->pm_lats = default_uart_latency;
+
+	return 0;
+}
+
+static struct omap_device_pm_latency console_uart_latency[] = {
+	{
+		.activate_func	 = console_uart_enable_hwmod,
+	},
+};
+
 #ifdef CONFIG_PM
 
 int omap_uart_can_sleep(void)
@@ -264,12 +294,20 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
 static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
 #endif
 
+char *cmdline_find_option(char *str)
+{
+	extern char *saved_command_line;
+
+	return strstr(saved_command_line, str);
+}
+
 static int __init omap_serial_early_init(void)
 {
 	do {
 		char oh_name[MAX_UART_HWMOD_NAME_LEN];
 		struct omap_hwmod *oh;
 		struct omap_uart_state *uart;
+		char uart_name[MAX_UART_HWMOD_NAME_LEN];
 
 		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
 			 "uart%d", num_uarts + 1);
@@ -284,18 +322,23 @@ static int __init omap_serial_early_init(void)
 		uart->oh = oh;
 		uart->num = num_uarts++;
 		list_add_tail(&uart->node, &uart_list);
+		snprintf(uart_name, MAX_UART_HWMOD_NAME_LEN,
+				"%s%d", OMAP_SERIAL_NAME, uart->num);
+
+		if (cmdline_find_option(uart_name)) {
+			console_uart_id = uart->num;
+			/*
+			 * omap-uart can be used for earlyprintk logs
+			 * So if omap-uart is used as console then prevent
+			 * uart reset and idle to get logs from omap-uart
+			 * until uart console driver is available to take
+			 * care for console messages.
+			 * Idling or resetting omap-uart while printing logs
+			 * early boot logs can stall the boot-up.
+			 */
+			oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
+		}
 
-		/*
-		 * NOTE: omap_hwmod_setup*() has not yet been called,
-		 *       so no hwmod functions will work yet.
-		 */
-
-		/*
-		 * During UART early init, device need to be probed
-		 * to determine SoC specific init before omap_device
-		 * is ready.  Therefore, don't allow idle here
-		 */
-		uart->oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
 	} while (1);
 
 	return 0;
@@ -324,6 +367,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	u32 pdata_size = 0;
 	char *name;
 	struct omap_uart_port_info omap_up;
+	struct omap_device *od;
 
 	if (WARN_ON(!bdata))
 		return;
@@ -369,6 +413,12 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	WARN(IS_ERR(pdev), "Could not build omap_device for %s: %s.\n",
 	     name, oh->name);
 
+	if (console_uart_id == bdata->id) {
+		od = to_omap_device(pdev);
+		default_uart_latency = od->pm_lats;
+		od->pm_lats = console_uart_latency;
+	}
+
 	omap_device_disable_idle_on_suspend(pdev);
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
@@ -376,20 +426,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 
 	oh->dev_attr = uart;
 
-	console_lock(); /* in case the earlycon is on the UART */
-
-	/*
-	 * Because of early UART probing, UART did not get idled
-	 * on init.  Now that omap_device is ready, ensure full idle
-	 * before doing omap_device_enable().
-	 */
-	omap_hwmod_idle(uart->oh);
-
-	omap_device_enable(uart->pdev);
-	omap_device_idle(uart->pdev);
-
-	console_unlock();
-
 	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
 		device_init_wakeup(&pdev->dev, true);
 }
-- 
1.7.4.1

