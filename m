From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] 8250: Allow platform to register PM hook
Date: Wed, 26 Nov 2008 16:25:22 -0800
Message-ID: <1227745523-5408-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:60969 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbYK0AZ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 19:25:29 -0500
Received: by qyk4 with SMTP id 4so1008608qyk.13
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 16:25:27 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org

Allow platform code to register a PM hook with the 8250 driver.  This
enables platform specific code to be run for suspend/resume events.

Since the per-port PM hook is local to the 8250 driver ('struct
uart_port' doesn't have a PM hook) I pass the pm hook from the
platform probe via serial8250_register_port().

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/serial/8250.c       |    7 +++++--
 include/linux/serial_8250.h |    7 ++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 5f383d8..993a242 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2842,7 +2842,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.dev		= &dev->dev;
 		if (share_irqs)
 			port.flags |= UPF_SHARE_IRQ;
-		ret = serial8250_register_port(&port);
+		ret = serial8250_register_port(&port, p->pm);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
 				"(IO%lx MEM%llx IRQ%d): %d\n", i,
@@ -2966,7 +2966,9 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
  *
  *	On success the port is ready to use and the line number is returned.
  */
-int serial8250_register_port(struct uart_port *port)
+int serial8250_register_port(struct uart_port *port,
+			     void (*pm)(struct uart_port *, unsigned int state,
+					unsigned int oldstate))
 {
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
@@ -2990,6 +2992,7 @@ int serial8250_register_port(struct uart_port *port)
 		uart->port.flags        = port->flags | UPF_BOOT_AUTOCONF;
 		uart->port.mapbase      = port->mapbase;
 		uart->port.private_data = port->private_data;
+		uart->pm = pm;
 		if (port->dev)
 			uart->port.dev = port->dev;
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 3d37c94..97723c5 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -28,6 +28,9 @@ struct plat_serial8250_port {
 	unsigned char	iotype;		/* UPIO_* */
 	unsigned char	hub6;
 	upf_t		flags;		/* UPF_* flags */
+
+	void		(*pm)(struct uart_port *, unsigned int state,
+			      unsigned int oldstate);
 };
 
 /*
@@ -57,7 +60,9 @@ enum {
  */
 struct uart_port;
 
-int serial8250_register_port(struct uart_port *);
+int serial8250_register_port(struct uart_port *,
+			     void (*pm)(struct uart_port *, unsigned int state,
+					unsigned int oldstate));
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
-- 
1.6.0.3

