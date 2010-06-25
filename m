From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH] Serial: Avoid populating uart_list in early
     init phase
Date: Fri, 25 Jun 2010 19:11:41 +0530 (IST)
Message-ID: <17901.10.24.255.17.1277473301.squirrel@dbdmail.itg.ti.com>
References: <61551.192.168.10.88.1277384156.squirrel@dbdmail.itg.ti.com>
    <87zkykxdqe.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20100625191141_51283"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57616 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755516Ab0FYNln (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jun 2010 09:41:43 -0400
In-Reply-To: <87zkykxdqe.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

------=_20100625191141_51283
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Leave the uart_list empty and keep the omap hwmod info
in a seperate uart_oh list and if board file calls
serial init use this uart_oh list info to fill uart_list.
The board file can also call just init_port to initialise
a single uart instance, so make init_port flexible to handle
individual uart instance by avoiding filling uart_list
in any non port_init function.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
As per earlier dicussion:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31157.html

 arch/arm/mach-omap2/serial.c |   60 +++++++++++++++++++++++++----------------
 1 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 24b8c60..246ae02 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -97,6 +97,13 @@ struct omap_uart_state {
 #endif
 };

+struct uart_oh {
+	struct list_head node;
+	struct omap_hwmod *oh;
+	int uart_num;
+};
+
+static LIST_HEAD(uart_oh_list);
 static LIST_HEAD(uart_list);
 static u8 num_uarts;

@@ -593,39 +600,32 @@ static void serial_out_override(struct uart_port *up, int offset, int value)

 void __init omap_serial_early_init(void)
 {
-	int i = 0;
+	struct omap_hwmod *oh;
+	struct uart_oh *uoh;
+	char oh_name[MAX_UART_HWMOD_NAME_LEN];

 	do {
-		char oh_name[MAX_UART_HWMOD_NAME_LEN];
-		struct omap_hwmod *oh;
-		struct omap_uart_state *uart;
+		uoh = kzalloc(sizeof(struct uart_oh), GFP_KERNEL);
+		if (WARN_ON(!uoh))
+			return;

 		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
-			 "uart%d", i + 1);
+			 "uart%d", num_uarts + 1);
 		oh = omap_hwmod_lookup(oh_name);
 		if (!oh)
 			break;
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
 		/*
 		 * NOTE: omap_hwmod_init() has not yet been called,
-		 *       so no hwmod functions will work yet.
-		 */
-
-		/*
+		 * so no hwmod functions will work yet.
 		 * During UART early init, device need to be probed
 		 * to determine SoC specific init before omap_device
-		 * is ready.  Therefore, don't allow idle here
+		 * is ready. Therefore, don't allow idle here
 		 */
-		uart->oh->flags |= HWMOD_INIT_NO_IDLE;
+		oh->flags |= HWMOD_INIT_NO_IDLE;
+		uoh->oh = oh;
+		uoh->uart_num = num_uarts;
+		list_add_tail(&uoh->node, &uart_oh_list);
+		num_uarts++;
 	} while (1);
 }

@@ -645,6 +645,7 @@ void __init omap_serial_init_port(int port)
 	struct omap_uart_state *uart;
 	struct omap_hwmod *oh;
 	struct omap_device *od;
+	struct uart_oh *uoh;
 	void *pdata = NULL;
 	u32 pdata_size = 0;
 	char *name;
@@ -663,6 +664,17 @@ void __init omap_serial_init_port(int port)
 	if (WARN_ON(port >= num_uarts))
 		return;

+	uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
+	if (WARN_ON(!uart))
+		return;
+
+	uart->num = port;
+	list_add_tail(&uart->node, &uart_list);
+	list_for_each_entry(uoh, &uart_oh_list, node)
+		if (port == uoh->uart_num)
+			break;
+
+	uart->oh = uoh->oh;
 	list_for_each_entry(uart, &uart_list, node)
 		if (port == uart->num)
 			break;
@@ -781,8 +793,8 @@ void __init omap_serial_init_port(int port)
  */
 void __init omap_serial_init(void)
 {
-	struct omap_uart_state *uart;
+	struct uart_oh *uoh;

-	list_for_each_entry(uart, &uart_list, node)
-		omap_serial_init_port(uart->num);
+	list_for_each_entry(uoh, &uart_oh_list, node)
+		omap_serial_init_port(uoh->uart_num);
 }
-- 
1.6.3.3

------=_20100625191141_51283
Content-Type: application/x-zip-compressed; name="patch.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch.zip"

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
BQYAAAAAAQABAJEAAADiBQAAAAA=
------=_20100625191141_51283--


