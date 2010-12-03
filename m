From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/6] omap2+: Use omap_device_board_data for platform level
	serial init
Date: Thu, 02 Dec 2010 16:45:28 -0800
Message-ID: <20101203004528.31687.93327.stgit@baageli.muru.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33952 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080Ab0LCApg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 19:45:36 -0500
In-Reply-To: <20101203004040.31687.9476.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is needed to pass board specific data such as pads used.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c             |   27 ++++++++++++++++++---------
 arch/arm/plat-omap/include/plat/serial.h |    5 ++++-
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 905626e..45c3ee3 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -698,16 +698,16 @@ void __init omap_serial_early_init(void)
 
 /**
  * omap_serial_init_port() - initialize single serial port
- * @port: serial port number (0-3)
+ * @bdata: port specific board data pointer
  *
- * This function initialies serial driver for given @port only.
+ * This function initialies serial driver for given port only.
  * Platforms can call this function instead of omap_serial_init()
  * if they don't plan to use all available UARTs as serial ports.
  *
  * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
  * use only one of the two.
  */
-void __init omap_serial_init_port(int port)
+void __init omap_serial_init_port(struct omap_device_board_data *bdata)
 {
 	struct omap_uart_state *uart;
 	struct omap_hwmod *oh;
@@ -725,13 +725,15 @@ void __init omap_serial_init_port(int port)
 	struct omap_uart_port_info omap_up;
 #endif
 
-	if (WARN_ON(port < 0))
+	if (WARN_ON(!bdata))
 		return;
-	if (WARN_ON(port >= num_uarts))
+	if (WARN_ON(bdata->id < 0))
+		return;
+	if (WARN_ON(bdata->id >= num_uarts))
 		return;
 
 	list_for_each_entry(uart, &uart_list, node)
-		if (port == uart->num)
+		if (bdata->id == uart->num)
 			break;
 
 	oh = uart->oh;
@@ -797,7 +799,7 @@ void __init omap_serial_init_port(int port)
 	if (WARN_ON(!oh))
 		return;
 
-	od = omap_device_build(name, uart->num, oh, NULL,
+	od = omap_device_build(name, uart->num, oh, bdata,
 			       pdata, pdata_size, omap_uart_latency,
 			       ARRAY_SIZE(omap_uart_latency), false);
 	WARN(IS_ERR(od), "Could not build omap_device for %s: %s.\n",
@@ -860,7 +862,14 @@ void __init omap_serial_init_port(int port)
 void __init omap_serial_init(void)
 {
 	struct omap_uart_state *uart;
+	struct omap_device_board_data bdata;
 
-	list_for_each_entry(uart, &uart_list, node)
-		omap_serial_init_port(uart->num);
+	list_for_each_entry(uart, &uart_list, node) {
+		bdata.id = uart->num;
+		bdata.flags = 0;
+		bdata.pads = NULL;
+		bdata.pads_cnt = 0;
+		omap_serial_init_port(&bdata);
+
+	}
 }
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 19145f5..dfa6346 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -93,9 +93,12 @@
 			})
 
 #ifndef __ASSEMBLER__
+
+struct omap_device_board_data;
+
 extern void __init omap_serial_early_init(void);
 extern void omap_serial_init(void);
-extern void omap_serial_init_port(int port);
+extern void omap_serial_init_port(struct omap_device_board_data *bdata);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);

