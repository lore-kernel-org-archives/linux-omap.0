From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 16/24] SERIAL: omap: simplify
Date: Sat, 06 Oct 2012 13:44:26 +0100
Message-ID: <E1TKTk2-0002nS-9E@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We have the sequence:
	- LCR mode B
	- write EFR with ECB clear
	- LCR mode normal
	- LCR mode B
	- write EFR with ECB clear

This can be simplified to just two writes:
	- LCR mode B
	- write EFR with ECB clear

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 70c9661..da0d4b1 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -890,19 +890,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 		/* Disable access to TCR/TLR */
 		serial_out(up, UART_MCR, up->mcr);
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		serial_out(up, UART_EFR, up->efr);
-		serial_out(up, UART_LCR, cval);
 	} else {
 		/* Disable AUTORTS and AUTOCTS */
 		up->efr &= ~(UART_EFR_CTS | UART_EFR_RTS);
-
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		serial_out(up, UART_EFR, up->efr);
-		serial_out(up, UART_LCR, cval);
 	}
 
-	/* Software Flow Control Configuration */
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, up->efr);
 
-- 
1.7.4.4

