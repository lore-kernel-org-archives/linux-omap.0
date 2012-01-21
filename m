From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA mode
Date: Sat, 21 Jan 2012 00:27:40 -0700
Message-ID: <20120121072737.18707.77811.stgit@dusk>
References: <20120121071934.18707.64258.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120121071934.18707.64258.stgit@dusk>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Govindraj Raja <govindraj.r@ti.com>, Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, alan@linux.intel.com
List-Id: linux-omap@vger.kernel.org

Ensure FIFO levels are set correctly in non-DMA mode (the default).
This patch will cause a receive FIFO threshold interrupt to be raised when
there is at least one byte in the RX FIFO.  It will also cause a transmit
FIFO threshold interrupt when there is only one byte remaining in the TX
FIFO.

These changes fix the receive interrupt problem and part of the
transmit interrupt problem.  A separate set of issues must be worked
around for the transmit path to have a basic level of functionality; a
subsequent patch will address these.

DMA operation is unaffected by this patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Govindraj Raja <govindraj.r@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 drivers/tty/serial/omap-serial.c |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d192dcb..9de7d71 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -46,6 +46,18 @@
 
 #define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
 
+/* SCR register bitmasks */
+#define OMAP_UART_SCR_RX_TRIG_GRANU1_MASK		(1 << 7)
+#define OMAP_UART_SCR_TX_TRIG_GRANU1_MASK		(1 << 6)
+
+/* FCR register bitmasks */
+#define OMAP_UART_FCR_RX_FIFO_TRIG_SHIFT		6
+#define OMAP_UART_FCR_RX_FIFO_TRIG_MASK			(0x3 << 6)
+#define OMAP_UART_FCR_TX_FIFO_TRIG_SHIFT		4
+
+/* TLR register bitmasks */
+#define OMAP_UART_TLR_TX_FIFO_TRIG_DMA_SHIFT		0
+
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
@@ -694,6 +706,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned char efr = 0;
 	unsigned long flags = 0;
 	unsigned int baud, quot;
+	u32 tlr;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
@@ -811,14 +824,28 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	up->mcr = serial_in(up, UART_MCR);
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	/* FIFO ENABLE, DMA MODE */
-	serial_out(up, UART_FCR, up->fcr);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	up->scr |= OMAP_UART_SCR_TX_TRIG_GRANU1_MASK;
+	up->scr |= OMAP_UART_SCR_RX_TRIG_GRANU1_MASK;
 
 	if (up->use_dma) {
-		serial_out(up, UART_TI752_TLR, 0);
-		up->scr |= (UART_FCR_TRIGGER_4 | UART_FCR_TRIGGER_8);
+		tlr = 0;
+	} else {
+		up->scr &= ~OMAP_UART_SCR_TX_EMPTY;
+
+		/* Set receive FIFO threshold to 1 */
+		up->fcr &= ~OMAP_UART_FCR_RX_FIFO_TRIG_MASK;
+		up->fcr |= (0x1 << OMAP_UART_FCR_RX_FIFO_TRIG_SHIFT);
+
+		/* Set TX FIFO threshold to "63" (actually 1) */
+		up->fcr |= (0x3 << OMAP_UART_FCR_TX_FIFO_TRIG_SHIFT);
+		tlr = (0xf << OMAP_UART_TLR_TX_FIFO_TRIG_DMA_SHIFT);
 	}
 
+	serial_out(up, UART_TI752_TLR, tlr);
+	serial_out(up, UART_FCR, up->fcr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
 	serial_out(up, UART_OMAP_SCR, up->scr);
 
 	serial_out(up, UART_EFR, up->efr);


