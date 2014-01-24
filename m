From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] serial: omap-serial: Move info message to probe function
Date: Fri, 24 Jan 2014 18:09:41 +0100
Message-ID: <1390583381-9076-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48425 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbaAXRJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jan 2014 12:09:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Tony Lindgren <tony@atomide.com>

Currently the info message about a missing wakeirq for uart is printed
every time the serial driver's startup function is called. This happens
multiple times and not just once.

This patch moves the infomessage to the probe function to display it
only once.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/tty/serial/omap-serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index fa511eb..2051581 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -738,9 +738,6 @@ static int serial_omap_startup(struct uart_port *port)
 			return retval;
 		}
 		disable_irq(up->wakeirq);
-	} else {
-		dev_info(up->port.dev, "no wakeirq for uart%d\n",
-			 up->port.line);
 	}
 
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
@@ -1687,6 +1684,9 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.iotype = UPIO_MEM;
 	up->port.irq = uartirq;
 	up->wakeirq = wakeirq;
+	if (!up->wakeirq)
+		dev_info(up->port.dev, "no wakeirq for uart%d\n",
+			 up->port.line);
 
 	up->port.regshift = 2;
 	up->port.fifosize = 64;
-- 
1.8.5.2

