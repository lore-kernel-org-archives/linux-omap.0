From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 06/13 v2] OMAP: UART: use non-locking versions of hwmod
     enable/idle functions
Date: Wed, 22 Sep 2010 20:43:59 +0530 (IST)
Message-ID: <37596.172.24.137.131.1285168439.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46872 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584Ab0IVPOC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 11:14:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

Since the UART enable/idle is done during the idle path (with
interrupts disabled), use the non-locking versions of the hwmod
enable/idle functions.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index ff83e91..72b5c98 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -105,10 +105,29 @@ struct omap_uart_state {
 static LIST_HEAD(uart_list);
 static u8 num_uarts;

+/*
+ * Since these idle/enable hooks are used in the idle path itself
+ * which has interrupts disabled, use the non-locking versions of
+ * the hwmod enable/disable functions.
+ */
+static int uart_idle_hwmod(struct omap_device *od)
+{
+	_omap_hwmod_idle(od->hwmods[0]);
+
+	return 0;
+}
+
+static int uart_enable_hwmod(struct omap_device *od)
+{
+	_omap_hwmod_enable(od->hwmods[0]);
+
+	return 0;
+}
+
 static struct omap_device_pm_latency omap_uart_latency[] = {
 	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func	 = omap_device_enable_hwmods,
+		.deactivate_func = uart_idle_hwmod,
+		.activate_func	 = uart_enable_hwmod,
 		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
 };
-- 
1.6.3.3



