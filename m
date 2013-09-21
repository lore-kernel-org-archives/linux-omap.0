From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: [PATCH] OMAP/serial: Fix misnamed variable
Date: Sat, 21 Sep 2013 04:04:35 -0400
Message-ID: <20130921080435.GA15678@inertiallabs-linux64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Alexey Pelykh <alexey.pelykh@gmail.com>

Fix misnamed variable to eliminate confusion.

Signed-off-by: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 808a880..7d348c8 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -258,13 +258,13 @@ serial_omap_baud_is_mode16(struct uart_port *port, unsigned int baud)
 static unsigned int
 serial_omap_get_divisor(struct uart_port *port, unsigned int baud)
 {
-	unsigned int divisor;
+	unsigned int mode;
 
 	if (!serial_omap_baud_is_mode16(port, baud))
-		divisor = 13;
+		mode = 13;
 	else
-		divisor = 16;
-	return port->uartclk/(baud * divisor);
+		mode = 16;
+	return port->uartclk/(mode * baud);
 }
 
 static void serial_omap_enable_ms(struct uart_port *port)

