From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v5 15/15] OMAP2+: UART: Do not gate uart clocks if used for debug_prints
Date: Wed, 21 Sep 2011 17:43:52 +0530
Message-ID: <1316607232-21709-6-git-send-email-govindraj.raja@ti.com>
References: <1316607232-21709-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50659 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753493Ab1IUMOI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Sep 2011 08:14:08 -0400
In-Reply-To: <1316607232-21709-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Govindraj R <govindraj.raja@ti.com>

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

 arch/arm/mach-omap2/serial.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 87696bf..3d92b77f 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -266,8 +266,24 @@ struct omap_hwmod *omap_uart_hwmod_lookup(int num)
 	return oh;
 }
 
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
 
@@ -361,7 +377,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
-	if ((cpu_is_omap34xx() && bdata->pads))
+	if ((cpu_is_omap34xx() && bdata->pads) && !uart_debug)
 		device_init_wakeup(&pdev->dev, true);
 
 	kfree(pdata);
-- 
1.7.4.1

