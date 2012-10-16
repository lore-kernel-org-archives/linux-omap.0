From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 07/11] SERIAL: omap: remove setting of EFR SCD bit
Date: Tue, 16 Oct 2012 12:00:05 +0100
Message-ID: <E1TO4sX-0000WM-Io@rmk-PC.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53227 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab2JPLAO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 07:00:14 -0400
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The SCD (special character detect) bit enables comparisons with XOFF2,
which we do not program.  As the XOFF2 character remains unprogrammed,
there's little point enabling this feature along with its associated
interrupt.  Remove this, and ensure that the SCD bit is cleared.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7c313c2..71db4e6 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -704,13 +704,8 @@ serial_omap_configure_xonxoff
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
-	/* Enable special char function UARTi.EFR_REG[5] and
-	 * load the new software flow control mode IXON or IXOFF
-	 * and restore the UARTi.EFR_REG[4] ENHANCED_EN value.
-	 */
-	serial_out(up, UART_EFR, up->efr | UART_EFR_SCD);
+	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-
 	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
 	serial_out(up, UART_LCR, up->lcr);
 }
@@ -843,6 +838,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 	up->efr = serial_in(up, UART_EFR);
+	up->efr &= ~UART_EFR_SCD;
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-- 
1.7.4.4

