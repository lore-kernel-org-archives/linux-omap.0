From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 15/24] SERIAL: omap: don't read back LCR/MCR/EFR
Date: Sat, 06 Oct 2012 13:44:06 +0100
Message-ID: <E1TKTji-0002nO-5K@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

There's really no reason to read back these registers while setting
the termios modes, provided we keep our cached copies up to date.
Remove these readbacks.

This has the benefit that we know that the EFR_ECB and MCR_TCRTLR
bits will always be clear, so we don't need to keep masking these
bits throughout the code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index b6f8b88..70c9661 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -885,8 +885,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		/* Enable AUTORTS and AUTOCTS */
 		up->efr |= UART_EFR_CTS | UART_EFR_RTS;
 
+		/* Ensure MCR RTS is asserted */
+		up->mcr |= UART_MCR_RTS;
+
 		/* Disable access to TCR/TLR */
-		serial_out(up, UART_MCR, up->mcr | UART_MCR_RTS);
+		serial_out(up, UART_MCR, up->mcr);
 		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_out(up, UART_EFR, up->efr);
 		serial_out(up, UART_LCR, cval);
@@ -900,10 +903,8 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/* Software Flow Control Configuration */
-	up->lcr = serial_in(up, UART_LCR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	up->efr = serial_in(up, UART_EFR);
-	serial_out(up, UART_EFR, up->efr & ~UART_EFR_ECB);
+	serial_out(up, UART_EFR, up->efr);
 
 	serial_out(up, UART_XON1, termios->c_cc[VSTART]);
 	serial_out(up, UART_XOFF1, termios->c_cc[VSTOP]);
@@ -930,8 +931,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 
-	up->mcr = serial_in(up, UART_MCR);
-
 	/*
 	 * IXANY Flag:
 	 * Enable any character to restart output.
@@ -947,7 +946,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
+	serial_out(up, UART_MCR, up->mcr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, up->lcr);
-- 
1.7.4.4

