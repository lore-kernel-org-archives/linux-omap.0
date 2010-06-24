From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH v3] Serial: Avoid using hwmod lookup using
     name string
Date: Thu, 24 Jun 2010 18:25:56 +0530 (IST)
Message-ID: <61551.192.168.10.88.1277384156.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20100624182556_92324"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54089 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736Ab0FXMz6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jun 2010 08:55:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

------=_20100624182556_92324
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Avoid using hwmod lookup using name string rather
retreive port info using the hwmod class interface.
Aviod populating uart_list in early init phase,
leave the uart_list empty and keep the omap hwmod info
in a seperate uart_oh list and if board file calls
serial init use this uart_oh list info to fill uart_list.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   90 ++++++++++++++++++++---------------------
 1 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 38a74d0..68cbd16 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -55,8 +55,6 @@
  */
 #define DEFAULT_TIMEOUT 0

-#define MAX_UART_HWMOD_NAME_LEN		16
-
 struct omap_uart_state {
 	int num;
 	int can_sleep;
@@ -96,6 +94,12 @@ struct omap_uart_state {
 #endif
 };

+struct uart_oh {
+	struct list_head node;
+	struct omap_hwmod *oh;
+};
+
+static LIST_HEAD(uart_oh_list);
 static LIST_HEAD(uart_list);
 static u8 num_uarts;

@@ -568,52 +572,37 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
 }
 #endif

-void __init omap_serial_early_init(void)
+static int omap_serial_port_init(struct omap_hwmod *oh, void *user)
 {
-	int i = 0;
-
-	do {
-		char oh_name[MAX_UART_HWMOD_NAME_LEN];
-		struct omap_hwmod *oh;
-		struct omap_uart_state *uart;
-
-		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
-			 "uart%d", i + 1);
-		oh = omap_hwmod_lookup(oh_name);
-		if (!oh)
-			break;
-
-		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
-		if (WARN_ON(!uart))
-			return;
-
-		uart->oh = oh;
-		uart->num = i++;
-		list_add_tail(&uart->node, &uart_list);
-		num_uarts++;
-
-		/*
-		 * NOTE: omap_hwmod_init() has not yet been called,
-		 *       so no hwmod functions will work yet.
-		 */
+	struct uart_oh *uoh;

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
+	uoh = kzalloc(sizeof(struct uart_oh), GFP_KERNEL);
+	if (WARN_ON(!uoh))
+		return -ENOMEM;
+	/*
+	 * During UART early init, device need to be probed
+	 * to determine SoC specific init before omap_device
+	 * is ready.  Therefore, don't allow idle here
+	 */
+	oh->flags |= HWMOD_INIT_NO_IDLE;
+	/*
+	 * Since UART hwmod is idle/enabled inside the
+	 * idle loop, interrupts are already disabled and
+	 * thus no locking is needed.  Since the mutex-based
+	 * locking in hwmod might sleep, allowing locking
+	 * may introduce problems.
+	 */
+	oh->flags |= HWMOD_NO_IDLE_LOCKING;
+	list_add_tail(&uoh->node, &uart_oh_list);
+	uoh->oh = oh;
+	num_uarts++;
+	return 0;
+}

-	} while (1);
+void __init omap_serial_early_init(void)
+{
+	omap_hwmod_for_each_by_class("uart",
+		omap_serial_port_init, NULL);
 }

 /**
@@ -769,7 +758,16 @@ void __init omap_serial_init_port(int port)
 void __init omap_serial_init(void)
 {
 	struct omap_uart_state *uart;
+	struct uart_oh *uoh;
+	int i = 0;

-	list_for_each_entry(uart, &uart_list, node)
+	list_for_each_entry(uoh, &uart_oh_list, node) {
+		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
+		if (WARN_ON(!uart))
+			return;
+		list_add_tail(&uart->node, &uart_list);
+		uart->num = i++;
+		uart->oh = uoh->oh;
 		omap_serial_init_port(uart->num);
+	}
 }
-- 
1.6.3.3

------=_20100624182556_92324
Content-Type: application/x-zip-compressed; name="patch.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch.zip"

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
SwUGAAAAAAEAAQCOAAAAWAYAAAAA
------=_20100624182556_92324--


