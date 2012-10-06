From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 18/24] SERIAL: omap: move xon/xoff setting earlier
Date: Sat, 06 Oct 2012 13:45:07 +0100
Message-ID: <E1TKTkh-0002na-4w@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47318 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013Ab2JFMpP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 08:45:15 -0400
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

Take advantage of the switch to mode B for accessing the TCR register,
and move the xon/xoff configuration there.  This allows further
simplication of this sequence.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 22877ac..e786eac 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -871,16 +871,20 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 
-	/* Enable access to TCR/TLR */
+	/* Configure flow control */
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	/* XON1/XOFF1 accessible mode B, TCRTLR=0, ECB=0 */
+	serial_out(up, UART_XON1, termios->c_cc[VSTART]);
+	serial_out(up, UART_XOFF1, termios->c_cc[VSTOP]);
+
+	/* Enable access to TCR/TLR */
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 
 	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
 
-	/* Hardware Flow Control Configuration */
-
 	if (termios->c_cflag & CRTSCTS) {
 		/* Enable AUTORTS and AUTOCTS */
 		up->efr |= UART_EFR_CTS | UART_EFR_RTS;
@@ -897,9 +901,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, up->efr);
 
-	serial_out(up, UART_XON1, termios->c_cc[VSTART]);
-	serial_out(up, UART_XOFF1, termios->c_cc[VSTOP]);
-
 	/* clear SW control mode bits */
 	up->efr &= OMAP_UART_SW_CLR;
 
-- 
1.7.4.4

