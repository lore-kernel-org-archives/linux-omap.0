From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH 3/4] Serial: Avoid using hwmod lookup using
     name string
Date: Fri, 4 Jun 2010 19:13:57 +0530 (IST)
Message-ID: <53451.192.168.10.88.1275659037.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51362 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756119Ab0FDNn7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jun 2010 09:43:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Avoid using hwmod lookup using name string rather
retreive port info using the hwmod class interface.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   76 ++++++++++++++++++++----------------------
 1 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 70a9089..017332b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -56,8 +56,6 @@
  */
 #define DEFAULT_TIMEOUT 0

-#define MAX_UART_HWMOD_NAME_LEN		16
-
 struct omap_uart_state {
 	int num;
 	int can_sleep;
@@ -596,52 +594,50 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
 }
 #endif

-void __init omap_serial_early_init(void)
+static int omap_serial_port_init(struct omap_hwmod *oh, void *user)
 {
-	int i = 0;
+	struct omap_uart_state *uart;
+	static int i;

-	do {
-		char oh_name[MAX_UART_HWMOD_NAME_LEN];
-		struct omap_hwmod *oh;
-		struct omap_uart_state *uart;
+	uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
+	if (WARN_ON(!uart))
+		return -ENOMEM;

-		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
-			 "uart%d", i + 1);
-		oh = omap_hwmod_lookup(oh_name);
-		if (!oh)
-			break;
+	uart->oh = oh;
+	uart->num = i++;
+	list_add_tail(&uart->node, &uart_list);
+	num_uarts++;

-		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
-		if (WARN_ON(!uart))
-			return;
+	/*
+	 * NOTE: omap_hwmod_init() has not yet been called,
+	 *       so no hwmod functions will work yet.
+	 */

-		uart->oh = oh;
-		uart->num = i++;
-		list_add_tail(&uart->node, &uart_list);
-		num_uarts++;
+	/*
+	 * During UART early init, device need to be probed
+	 * to determine SoC specific init before omap_device
+	 * is ready.  Therefore, don't allow idle here
+	 */

-		/*
-		 * NOTE: omap_hwmod_init() has not yet been called,
-		 *       so no hwmod functions will work yet.
-		 */
+	uart->oh->flags |= HWMOD_INIT_NO_IDLE;

-		/*
-		 * During UART early init, device need to be probed
-		 * to determine SoC specific init before omap_device
-		 * is ready.  Therefore, don't allow idle here
-		 */
-		uart->oh->flags |= HWMOD_INIT_NO_IDLE;
-
-		/*
-		 * Since UART hwmod is idle/enabled inside the
-		 * idle loop, interrupts are already disabled and
-		 * thus no locking is needed.  Since the mutex-based
-		 * locking in hwmod might sleep, allowing locking
-		 * may introduce problems.
-		 */
-		uart->oh->flags |= HWMOD_NO_IDLE_LOCKING;
+	/*
+	 * Since UART hwmod is idle/enabled inside the
+	 * idle loop, interrupts are already disabled and
+	 * thus no locking is needed.  Since the mutex-based
+	 * locking in hwmod might sleep, allowing locking
+	 * may introduce problems.
+	 */
+
+	uart->oh->flags |= HWMOD_NO_IDLE_LOCKING;

-	} while (1);
+	return 0;
+}
+
+void __init omap_serial_early_init(void)
+{
+	omap_hwmod_for_each_by_class("uart",
+		omap_serial_port_init, NULL);
 }

 /**
-- 
1.6.3.3


