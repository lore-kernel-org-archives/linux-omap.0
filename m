From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 19/24] SERIAL: omap: simplify (2)
Date: Sat, 06 Oct 2012 13:45:27 +0100
Message-ID: <E1TKTl1-0002ne-8K@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Simplify:
	- set ECB
	...
	- LCR mode A
	- clear TCRTLR
	- LCR mode B
	- clear ECB
	- set ECB and update other bits
	- LCR mode A
	- update XONANY

to:
	- set ECB
	...
	- LCR mode B
	- set ECB and update other bits
	- LCR mode A
	- update XONANY and clear TCRTLR

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index e786eac..b497187 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -896,11 +896,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		up->efr &= ~(UART_EFR_CTS | UART_EFR_RTS);
 	}
 
-	/* Disable access to TCR/TLR */
-	serial_out(up, UART_MCR, up->mcr);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_out(up, UART_EFR, up->efr);
-
 	/* clear SW control mode bits */
 	up->efr &= OMAP_UART_SW_CLR;
 
@@ -920,9 +915,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (termios->c_iflag & IXOFF)
 		up->efr |= OMAP_UART_SW_TX;
 
-	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-
 	/*
 	 * IXANY Flag:
 	 * Enable any character to restart output.
@@ -934,6 +926,9 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		up->mcr &= ~UART_MCR_XONANY;
 
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_MCR, up->mcr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, up->efr);
-- 
1.7.4.4

