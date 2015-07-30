From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 1/3] serial: 8250: unlock port for uart_write_wakeup()
Date: Fri, 31 Jul 2015 00:54:21 +0200
Message-ID: <87h9ol2r4y.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org, nsekhar@ti.comtony@atomide.com, nm@ti.com, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

uart_write_wakeup() should be called without holding the port lock.
Otherwise a possible recursive spinlock issue can occur, such as
the following callchain:

8250_core.c:serial8250_tx_chars() - called with port locked
 serial_core.c:uart_write_wakeup()
  tty_io.c:tty_wakeup()
   st_core.c:st_tty_wakeup()
    st_core.c:st_tx_wakeup()
     st_core.c:st_int_write()
      serial_core.c:uart_write() - locks port

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c |    6 +++++-
 drivers/tty/serial/8250/8250_omap.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 37fff12..5ac2425 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1559,8 +1559,12 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 		}
 	} while (--count > 0);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
+		/* do not hold lock for call to uart_write_wakeup() */
+		spin_unlock(&port->lock);
 		uart_write_wakeup(port);
+		spin_lock(&port->lock);
+	}
 
 	DEBUG_INTR("THRE...");
 
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index d75a66c..5b39892 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -861,8 +861,12 @@ static void omap_8250_dma_tx_complete(void *param)
 		omap8250_restore_regs(p);
 	}
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
+		/* do not hold lock for call to uart_write_wakeup() */
+		spin_unlock(&p->port.lock);
 		uart_write_wakeup(&p->port);
+		spin_lock(&p->port.lock);
+	}
 
 	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port)) {
 		int ret;
-- 
1.7.10.4
