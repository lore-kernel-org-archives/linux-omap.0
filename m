From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 1/4] tty: serial: 8250 core: provide a function to export uart_8250_port
Date: Fri,  4 Jul 2014 18:34:08 +0200
Message-ID: <1404491651-1388-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

There is no access to access a struct uart_8250_port for a specific
line. This is only required outside of the 8250/uart callbacks like for
devices' suspend & remove callbacks. For those the 8250-core provides
wrapper like serial8250_unregister_port() which passes the struct
to the proper function based on the line argument.

For runtime suspend I need access to this struct not only to make
serial_out() work but also to properly restore up->ier and up->mcr.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250.h      | 2 ++
 drivers/tty/serial/8250/8250_core.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 1ebf853..34c3cd1 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -110,6 +110,8 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
 	up->dl_write(up, value);
 }
 
+struct uart_8250_port *serial8250_get_port(int line);
+
 #if defined(__alpha__) && !defined(CONFIG_PCI)
 /*
  * Digital did something really horribly wrong with the OUT1 and OUT2
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 7a91c6d..0c90160 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2755,6 +2755,12 @@ static struct uart_ops serial8250_pops = {
 
 static struct uart_8250_port serial8250_ports[UART_NR];
 
+struct uart_8250_port *serial8250_get_port(int line)
+{
+	return &serial8250_ports[line];
+}
+EXPORT_SYMBOL_GPL(serial8250_get_port);
+
 static void (*serial8250_isa_config)(int port, struct uart_port *up,
 	unsigned short *capabilities);
 
-- 
2.0.0
