From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 04/24] SERIAL: omap: fix MCR TCRTLR bit handling
Date: Sat, 06 Oct 2012 13:40:21 +0100
Message-ID: <E1TKTg5-0002ma-PI@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The MCR TCRTLR bit can only be changed when ECB is set in the EFR.
Unfortunately, several places were trying to alter this bit while ECB
was clear:

- serial_omap_configure_xonxoff() was attempting to clear the bit after
  explicitly clearing the ECB bit.
- serial_omap_set_termios() was trying the same trick after setting the
  SCR, and when trying to change the TCR register when hardware flow
  control was enabled.

Fix this by ensuring that we always have ECB set whenever the TCRTLR bit
is changed.

Moreover, we start out by reading the EFR and MCR registers, which may
have indeterminent bit settings for the ECB and TCRTLR bits.  Ensure
that these bits always start off in a known state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 5333f19..391087e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -700,9 +700,10 @@ serial_omap_configure_xonxoff
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
-	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, up->lcr);
 }
 
@@ -720,7 +721,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 	unsigned char cval = 0;
-	unsigned char efr = 0;
 	unsigned long flags = 0;
 	unsigned int baud, quot;
 
@@ -832,12 +832,12 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
-	up->efr = serial_in(up, UART_EFR);
+	up->efr = serial_in(up, UART_EFR) & ~UART_EFR_ECB;
 	up->efr &= ~UART_EFR_SCD;
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-	up->mcr = serial_in(up, UART_MCR);
+	up->mcr = serial_in(up, UART_MCR) & ~UART_MCR_TCRTLR;
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	/* FIFO ENABLE, DMA MODE */
 
@@ -857,9 +857,12 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial_out(up, UART_OMAP_SCR, up->scr);
 
-	serial_out(up, UART_EFR, up->efr);
+	/* Reset UART_MCR_TCRTLR: this must be done with the EFR_ECB bit set */
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_MCR, up->mcr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, up->efr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 
 	/* Protocol, Baud Rate, and Interrupt Settings */
 
@@ -900,20 +903,21 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* Hardware Flow Control Configuration */
 
 	if (termios->c_cflag & CRTSCTS) {
-		efr |= (UART_EFR_CTS | UART_EFR_RTS);
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-
-		up->mcr = serial_in(up, UART_MCR);
-		serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
-
+		/* Enable access to TCR/TLR */
 		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		up->efr = serial_in(up, UART_EFR);
 		serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+		serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 
 		serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
-		serial_out(up, UART_EFR, efr); /* Enable AUTORTS and AUTOCTS */
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+
+		/* Enable AUTORTS and AUTOCTS */
+		up->efr |= UART_EFR_CTS | UART_EFR_RTS;
+
+		/* Disable access to TCR/TLR */
 		serial_out(up, UART_MCR, up->mcr | UART_MCR_RTS);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(up, UART_EFR, up->efr);
 		serial_out(up, UART_LCR, cval);
 	}
 
-- 
1.7.4.4

