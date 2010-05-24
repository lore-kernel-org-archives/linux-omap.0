From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH] Serial: Avoid using hwmod lookup using name
     string
Date: Mon, 24 May 2010 18:38:42 +0530 (IST)
Message-ID: <48383.192.168.10.88.1274706522.squirrel@dbdmail.itg.ti.com>
References: <39979.192.168.10.88.1274431258.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20100524183842_68004"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44634 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073Ab0EXNIo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 May 2010 09:08:44 -0400
In-Reply-To: <39979.192.168.10.88.1274431258.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

------=_20100524183842_68004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Rebased on latest pm/wip-uart branch.

-- 
Regards,
Govindraj.R


Avoid using hwmod lookup using name string rather
retreive port info using the hwmod class interface.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   86 +++++++++++++++++++----------------------
 1 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index da9fee6..dc04139 100644
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
@@ -568,52 +566,48 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
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
+	 * so no hwmod functions will work yet.
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
+	uart->oh->flags |= HWMOD_INIT_NO_IDLE;

-		/*
-		 * NOTE: omap_hwmod_init() has not yet been called,
-		 *       so no hwmod functions will work yet.
-		 */
+	/*
+	 * Since UART hwmod is idle/enabled inside the
+	 * idle loop, interrupts are already disabled and
+	 * thus no locking is needed.  Since the mutex-based
+	 * locking in hwmod might sleep, allowing locking
+	 * may introduce problems.
+	 */
+	uart->oh->flags |= HWMOD_NO_IDLE_LOCKING;

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
+	return 0;
+}

-	} while (1);
+void __init omap_serial_early_init(void)
+{
+	omap_hwmod_for_each_by_class("uart",
+		omap_serial_port_init, NULL);
 }

 /**
-- 
1.6.3.3

------=_20100524183842_68004
Content-Type: application/x-zip-compressed;
      name="0001-Serial-Avoid-using-hwmod-lookup-using-name-string.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename=
     "0001-Serial-Avoid-using-hwmod-lookup-using-name-string.zip"

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
AQCOAAAAawUAAAAA
------=_20100524183842_68004--


