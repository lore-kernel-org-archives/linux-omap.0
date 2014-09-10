From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/16] tty: serial: 8250_core: remove UART_IER_RDI in serial8250_stop_rx()
Date: Wed, 10 Sep 2014 21:30:00 +0200
Message-ID: <1410377411-26656-6-git-send-email-bigeasy@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, heikki.krogerus@linux.intel.com
List-Id: linux-omap@vger.kernel.org

serial8250_do_startup() adds UART_IER_RDI and UART_IER_RLSI to ier.
serial8250_stop_rx() should remove both.
This is what the serial-omap driver has been doing and is now moved to
the 8250-core since it does no look to be *that* omap specific.

Cc: heikki.krogerus@linux.intel.com
Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ac88e66df65d..139f3d2b8aa9 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1390,7 +1390,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 
 	serial8250_rpm_get(up);
 
-	up->ier &= ~UART_IER_RLSI;
+	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	up->port.read_status_mask &= ~UART_LSR_DR;
 	serial_port_out(port, UART_IER, up->ier);
 
-- 
2.1.0
