From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 14/24] SERIAL: omap: serial_omap_configure_xonxoff() contents
 into set_termios
Date: Sat, 06 Oct 2012 13:43:45 +0100
Message-ID: <E1TKTjN-0002nK-O1@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47291 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab2JFMny (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 08:43:54 -0400
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |  109 ++++++++++++++++++--------------------
 1 files changed, 51 insertions(+), 58 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index cc1a907..b6f8b88 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -680,63 +680,6 @@ static void serial_omap_shutdown(struct uart_port *port)
 	free_irq(up->port.irq, up);
 }
 
-static inline void
-serial_omap_configure_xonxoff
-		(struct uart_omap_port *up, struct ktermios *termios)
-{
-	up->lcr = serial_in(up, UART_LCR);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	up->efr = serial_in(up, UART_EFR);
-	serial_out(up, UART_EFR, up->efr & ~UART_EFR_ECB);
-
-	serial_out(up, UART_XON1, termios->c_cc[VSTART]);
-	serial_out(up, UART_XOFF1, termios->c_cc[VSTOP]);
-
-	/* clear SW control mode bits */
-	up->efr &= OMAP_UART_SW_CLR;
-
-	/*
-	 * IXON Flag:
-	 * Enable XON/XOFF flow control on input.
-	 * Receiver compares XON1, XOFF1.
-	 */
-	if (termios->c_iflag & IXON)
-		up->efr |= OMAP_UART_SW_RX;
-
-	/*
-	 * IXOFF Flag:
-	 * Enable XON/XOFF flow control on output.
-	 * Transmit XON1, XOFF1
-	 */
-	if (termios->c_iflag & IXOFF)
-		up->efr |= OMAP_UART_SW_TX;
-
-	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-
-	up->mcr = serial_in(up, UART_MCR);
-
-	/*
-	 * IXANY Flag:
-	 * Enable any character to restart output.
-	 * Operation resumes after receiving any
-	 * character after recognition of the XOFF character
-	 */
-	if (termios->c_iflag & IXANY)
-		up->mcr |= UART_MCR_XONANY;
-	else
-		up->mcr &= ~UART_MCR_XONANY;
-
-	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_out(up, UART_EFR, up->efr);
-	serial_out(up, UART_LCR, up->lcr);
-}
-
 static void serial_omap_uart_qos_work(struct work_struct *work)
 {
 	struct uart_omap_port *up = container_of(work, struct uart_omap_port,
@@ -957,7 +900,57 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/* Software Flow Control Configuration */
-	serial_omap_configure_xonxoff(up, termios);
+	up->lcr = serial_in(up, UART_LCR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	up->efr = serial_in(up, UART_EFR);
+	serial_out(up, UART_EFR, up->efr & ~UART_EFR_ECB);
+
+	serial_out(up, UART_XON1, termios->c_cc[VSTART]);
+	serial_out(up, UART_XOFF1, termios->c_cc[VSTOP]);
+
+	/* clear SW control mode bits */
+	up->efr &= OMAP_UART_SW_CLR;
+
+	/*
+	 * IXON Flag:
+	 * Enable XON/XOFF flow control on input.
+	 * Receiver compares XON1, XOFF1.
+	 */
+	if (termios->c_iflag & IXON)
+		up->efr |= OMAP_UART_SW_RX;
+
+	/*
+	 * IXOFF Flag:
+	 * Enable XON/XOFF flow control on output.
+	 * Transmit XON1, XOFF1
+	 */
+	if (termios->c_iflag & IXOFF)
+		up->efr |= OMAP_UART_SW_TX;
+
+	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+
+	up->mcr = serial_in(up, UART_MCR);
+
+	/*
+	 * IXANY Flag:
+	 * Enable any character to restart output.
+	 * Operation resumes after receiving any
+	 * character after recognition of the XOFF character
+	 */
+	if (termios->c_iflag & IXANY)
+		up->mcr |= UART_MCR_XONANY;
+	else
+		up->mcr &= ~UART_MCR_XONANY;
+
+	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, up->efr);
+	serial_out(up, UART_LCR, up->lcr);
 
 	serial_omap_set_mctrl(&up->port, up->port.mctrl);
 
-- 
1.7.4.4

