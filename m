From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 01/24] SERIAL: omap: fix set_mctrl() breakage
Date: Sat, 06 Oct 2012 13:39:20 +0100
Message-ID: <E1TKTf6-0002mO-Oj@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47220 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805Ab2JFMkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 08:40:35 -0400
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

c538d20c7f (and maybe previous commits) broke set_mctrl() by making
it only capable of setting bits in the MCR register.  This prevents
software controlled flow control and modem control line manipulation
via TIOCMSET/TIOCMBIC from working correctly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d3cda0c..0a50669 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -488,7 +488,7 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
-	unsigned char mcr = 0;
+	unsigned char mcr = 0, old_mcr;
 
 	dev_dbg(up->port.dev, "serial_omap_set_mctrl+%d\n", up->port.line);
 	if (mctrl & TIOCM_RTS)
@@ -503,8 +503,10 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		mcr |= UART_MCR_LOOP;
 
 	pm_runtime_get_sync(&up->pdev->dev);
-	up->mcr = serial_in(up, UART_MCR);
-	up->mcr |= mcr;
+	old_mcr = serial_in(up, UART_MCR);
+	old_mcr &= ~(UART_MCR_LOOP | UART_MCR_OUT2 | UART_MCR_OUT1 |
+		     UART_MCR_DTR | UART_MCR_RTS);
+	up->mcr = old_mcr | mcr;
 	serial_out(up, UART_MCR, up->mcr);
 	pm_runtime_put(&up->pdev->dev);
 }
-- 
1.7.4.4

