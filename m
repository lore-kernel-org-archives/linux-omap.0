From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 13/24] SERIAL: omap: configure xon/xoff before setting modem
 control lines
Date: Sat, 06 Oct 2012 13:43:25 +0100
Message-ID: <E1TKTj3-0002nG-9h@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47282 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192Ab2JFMne (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 08:43:34 -0400
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ab5a5e0..cc1a907 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -956,10 +956,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_out(up, UART_LCR, cval);
 	}
 
-	serial_omap_set_mctrl(&up->port, up->port.mctrl);
 	/* Software Flow Control Configuration */
 	serial_omap_configure_xonxoff(up, termios);
 
+	serial_omap_set_mctrl(&up->port, up->port.mctrl);
+
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	pm_runtime_put(&up->pdev->dev);
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->port.line);
-- 
1.7.4.4

