From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] serial: omap: Add omapserial earlycon
Date: Thu, 19 Jan 2017 15:29:38 +0530
Message-ID: <20170119095938.30976-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

Add DT earlycon for omap_serial driver. This boot console is included
with CONFIG_SERIAL_EARLYCON=y, CONFIG_OF=y, CONFIG_SERIAL_OMAP=y, and
CONFIG_OF_EARLY_FLATTREE=y.

This boot console is enabled with the command line option "earlycon"
(without "=<name>...") when the DT 'stdout-path' property matches a
compatible uart.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/tty/serial/omap-serial.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index a2a529994ba5..3bbc4b5b6245 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1234,6 +1234,61 @@ static int serial_omap_poll_get_char(struct uart_port *port)
 
 #ifdef CONFIG_SERIAL_OMAP_CONSOLE
 
+#ifdef CONFIG_SERIAL_EARLYCON
+static unsigned int __init omap_serial_early_in(struct uart_port *port,
+						int offset)
+{
+	offset <<= port->regshift;
+	return readw(port->membase + offset);
+}
+
+static void __init omap_serial_early_out(struct uart_port *port, int offset,
+					 int value)
+{
+	offset <<= port->regshift;
+	writew(value, port->membase + offset);
+}
+
+static void __init omap_serial_early_putc(struct uart_port *port, int c)
+{
+	unsigned int status;
+
+	for (;;) {
+		status = omap_serial_early_in(port, UART_LSR);
+		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
+			break;
+		cpu_relax();
+	}
+	omap_serial_early_out(port, UART_TX, c);
+}
+
+static void __init early_omap_serial_write(struct console *console,
+					   const char *s, unsigned int count)
+{
+	struct earlycon_device *device = console->data;
+	struct uart_port *port = &device->port;
+
+	uart_console_write(port, s, count, omap_serial_early_putc);
+}
+
+static int __init early_omap_serial_setup(struct earlycon_device *device,
+					  const char *options)
+{
+	struct uart_port *port = &device->port;
+
+	if (!(device->port.membase || device->port.iobase))
+		return -ENODEV;
+
+	port->regshift = 2;
+	device->con->write = early_omap_serial_write;
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(omapserial, "ti,omap2-uart", early_omap_serial_setup);
+OF_EARLYCON_DECLARE(omapserial, "ti,omap3-uart", early_omap_serial_setup);
+OF_EARLYCON_DECLARE(omapserial, "ti,omap4-uart", early_omap_serial_setup);
+#endif /* CONFIG_SERIAL_EARLYCON */
+
 static struct uart_omap_port *serial_omap_console_ports[OMAP_MAX_HSUART_PORTS];
 
 static struct uart_driver serial_omap_reg;
-- 
2.11.0
