From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v6 16/16] OMAP2+: UART: Do not gate uart clocks if used for debug_prints
Date: Fri, 30 Sep 2011 16:32:41 +0530
Message-ID: <1317380561-661-7-git-send-email-govindraj.raja@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

If OMAP UART is used as console uart and debug is enabled,
avoid gating of uart clocks to print all debug prints.

If uart clocks are gated then the debug prints from omap_device
framework or hwmod framework can cause uart to enter recursive pm_runtime calls,
which can cause a deadlock over power lock usage.

For example: Say, uart clocks are cut and we get a print from omap_device_disable
stating disabling uart clocks. This print calls omap_uart driver console_write
which will call runtime API get_sync which means we enter from runtime API put
context to runtime API get context.

--> runtime put (take power lock)
    --> print disabling uart clocks
        --> call uart console write
            --> call get_sync (try to take power lock)

Also any clock enable API call from uart driver should not call any uart
operation until clocks are enabled back. Like get_sync having debug print
calling uart console write even before clocks are enabled.

So to avoid these scenarios, identify from bootargs  if OMAP_UART(ttyO) is used
in debug mode. If so, do not set device_may_wakeup. This will prevent
pm_runtime_enable in uart driver probe and will avoid uart clock gating.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
More details on this topic and experiments done listed here:
http://www.spinics.net/lists/linux-serial/msg04128.html

 arch/arm/mach-omap2/serial.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 15d6c51..777f81c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -285,8 +285,24 @@ static void omap_uart_set_forceidle(struct platform_device *pdev) {}
 static void omap_uart_hwmod_idle(struct platform_device *pdev) {}
 #endif /* CONFIG_PM */
 
+static int uart_debug;
+
+char *cmdline_find_option(char *str)
+{
+	extern char *saved_command_line;
+
+	return strstr(saved_command_line, str);
+}
+
 static int __init omap_serial_early_init(void)
 {
+	if (cmdline_find_option("debug") &&
+			cmdline_find_option(OMAP_SERIAL_NAME)) {
+		uart_debug = true;
+		pr_info("OMAP UART used as console in debug mode"
+			" uart clocks will not be gated");
+	}
+
 	do {
 		struct omap_hwmod *oh;
 
@@ -380,7 +396,8 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
-	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+			&& !uart_debug)
 		device_init_wakeup(&pdev->dev, true);
 
 	kfree(pdata);
-- 
1.7.4.1

