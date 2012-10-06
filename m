From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 06/24] SERIAL: omap: allow hardware assisted rts/cts modes to
 be disabled
Date: Sat, 06 Oct 2012 13:41:02 +0100
Message-ID: <E1TKTgk-0002mj-L2@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

There is nothing which clears the auto RTS/CTS bits, so once hardware
flow control gets enabled, there's no possibility to disable it.
So, clear these bits when CRTSCTS is cleared.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 654dd78..f2535fe 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -917,6 +917,13 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_out(up, UART_EFR, up->efr);
 		serial_out(up, UART_LCR, cval);
+	} else {
+		/* Disable AUTORTS and AUTOCTS */
+		up->efr &= ~(UART_EFR_CTS | UART_EFR_RTS);
+
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(up, UART_EFR, up->efr);
+		serial_out(up, UART_LCR, cval);
 	}
 
 	serial_omap_set_mctrl(&up->port, up->port.mctrl);
-- 
1.7.4.4

