From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 04/16] tty: serial: 8250_core: use the ->line argument as a hint in serial8250_find_match_or_unused()
Date: Wed, 10 Sep 2014 21:29:59 +0200
Message-ID: <1410377411-26656-5-git-send-email-bigeasy@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Tony noticed that the old omap-serial driver picked the uart "number"
based on the hint given from device tree or platform device's id.
The 8250 based omap driver doesn't do this because the core code does
not honour the ->line argument which is passed by the driver.

This patch aims to keep the same behaviour as with omap-serial. The
function will first try to use the line suggested ->line argument and
then fallback to the old strategy in case the port is taken.

That means the the third uart will always be ttyS2 even if the previous
two have not been enabled in DT.

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 547afde9fdda..ac88e66df65d 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3516,6 +3516,11 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 		if (uart_match_port(&serial8250_ports[i].port, port))
 			return &serial8250_ports[i];
 
+	/* try line number first if still available */
+	i = port->line;
+	if (i < nr_uarts && serial8250_ports[i].port.type == PORT_UNKNOWN &&
+			serial8250_ports[i].port.iobase == 0)
+		return &serial8250_ports[i];
 	/*
 	 * We didn't find a matching entry, so look for the first
 	 * free entry.  We look for one which hasn't been previously
-- 
2.1.0
