From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 06/11] OMAP: UART: use non-locking versions of hwmod
     enable/idle functions
Date: Fri, 17 Sep 2010 21:37:14 +0530 (IST)
Message-ID: <14140.10.24.255.18.1284739634.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Since the UART enable/idle is done during the idle path (with
interrupts disabled), use the non-locking versions of the hwmod
enable/idle functions.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b47194a..f03014f 100644
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




