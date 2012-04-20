From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] tty: serial_core: Add mechanism to identify port closure.
Date: Fri, 20 Apr 2012 16:27:53 +0530
Message-ID: <1334919473-18870-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

From: "Govindraj.R" <govindraj.raja@ti.com>

Currently all low level uart driver register to serial_core layer
this core layer exposes various serial uart ops.

Currently the core layer provides startup and shutdown hooks
to low level driver, but in port suspend case the shutdown gets called
from uart_suspend_port this makes little difficult in low level driver
to any action specific to port closure.

For example if low level driver tries to disable uart platform
specific wakeups after port closure in low level driver it can be only done
in shutdown ops since this ops is called even in suspend case low level
driver needs some info whether the current shutdown ops is result of
port close or if its suspend ops.

To differentiate this expand the core layer uart_port info with closing flag
this flag is set to true during shutdown and set to false while port open.

Thus closing flag added with this patch can be used in low level driver to
identify the port close.

Discussion reference:
http://marc.info/?l=linux-omap&m=133491321605924&w=2

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/serial_core.c |    3 +++
 include/linux/serial_core.h      |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9c4c05b..0dc246d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1284,6 +1284,8 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 		uart_wait_until_sent(tty, uport->timeout);
 	}
 
+	state->uart_port->closing = true;
+
 	mutex_lock(&port->mutex);
 	uart_shutdown(tty, state);
 	uart_flush_buffer(tty);
@@ -1518,6 +1520,7 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
 	if (port->count == 1)
 		uart_change_pm(state, 0);
 
+	state->uart_port->closing = false;
 	/*
 	 * Start up the serial port.
 	 */
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2db407a..f5cd1ee 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -381,6 +381,7 @@ struct uart_port {
 	unsigned char		irq_wake;
 	unsigned char		unused[2];
 	void			*private_data;		/* generic platform data pointer */
+	unsigned char		closing;
 };
 
 static inline int serial_port_in(struct uart_port *up, int offset)
-- 
1.7.9

