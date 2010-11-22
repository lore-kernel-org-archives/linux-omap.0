From: Cosmin Cojocar <cosmin.cojocar@gmail.com>
Subject: [PATCH v3 1/1] serial: omap-serial: Add support for kernel debugger
Date: Tue, 23 Nov 2010 00:24:12 +0100
Message-ID: <1290468252-23539-1-git-send-email-cosmin.cojocar@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54311 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757794Ab0KVXYW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 18:24:22 -0500
Received: by eye27 with SMTP id 27so4351177eye.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 15:24:21 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: govindraj.raja@ti.com
Cc: manjugk@ti.com, khilman@deeprootsystems.com, tony@atomide.com, ben-linux@fluff.org, tklauser@distanz.ch, feng.tang@intel.com, alan@linux.intel.com, gregkh@suse.de, linux-omap@vger.kernel.org, Cosmin Cojocar <cosmin.cojocar@gmail.com>

The kgdb invokes the poll_put_char and poll_get_char when communicating
with the host. This patch also changes the initialization order because the
kgdb will check at the very beginning, if there is a valid serial
driver.

Signed-off-by: Cosmin Cojocar <cosmin.cojocar@gmail.com>
---
 drivers/serial/Makefile      |    2 +-
 drivers/serial/omap-serial.c |   38 ++++++++++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index c570576..ad86113 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM) += of_serial.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL) += nwpserial.o
 obj-$(CONFIG_SERIAL_KS8695) += serial_ks8695.o
+obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
 obj-$(CONFIG_SERIAL_QE) += ucc_uart.o
 obj-$(CONFIG_SERIAL_TIMBERDALE)	+= timbuart.o
@@ -88,4 +89,3 @@ obj-$(CONFIG_SERIAL_ALTERA_JTAGUART) += altera_jtaguart.o
 obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
 obj-$(CONFIG_SERIAL_MRST_MAX3110)	+= mrst_max3110.o
 obj-$(CONFIG_SERIAL_MFD_HSU)	+= mfd.o
-obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-serial.c
index 03a96db..552759e 100644
--- a/drivers/serial/omap-serial.c
+++ b/drivers/serial/omap-serial.c
@@ -866,12 +866,6 @@ serial_omap_type(struct uart_port *port)
 	return up->name;
 }
 
-#ifdef CONFIG_SERIAL_OMAP_CONSOLE
-
-static struct uart_omap_port *serial_omap_console_ports[4];
-
-static struct uart_driver serial_omap_reg;
-
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
 static inline void wait_for_xmitr(struct uart_omap_port *up)
@@ -905,6 +899,34 @@ static inline void wait_for_xmitr(struct uart_omap_port *up)
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+
+static void serial_omap_poll_put_char(struct uart_port *port, unsigned char ch)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	wait_for_xmitr(up);
+	serial_out(up, UART_TX, ch);
+}
+
+static int serial_omap_poll_get_char(struct uart_port *port)
+{
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned int status = serial_in(up, UART_LSR);
+
+	if (!(status & UART_LSR_DR))
+		return NO_POLL_CHAR;
+
+	return serial_in(up, UART_RX);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
+#ifdef CONFIG_SERIAL_OMAP_CONSOLE
+
+static struct uart_omap_port *serial_omap_console_ports[4];
+
+static struct uart_driver serial_omap_reg;
+
 static void serial_omap_console_putchar(struct uart_port *port, int ch)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
@@ -1022,6 +1044,10 @@ static struct uart_ops serial_omap_pops = {
 	.request_port	= serial_omap_request_port,
 	.config_port	= serial_omap_config_port,
 	.verify_port	= serial_omap_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_put_char  = serial_omap_poll_put_char,
+	.poll_get_char  = serial_omap_poll_get_char,
+#endif
 };
 
 static struct uart_driver serial_omap_reg = {
-- 
1.6.3.3

