From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: [PATCH] OMAP/serial: Fix division by zero exception on 3M+ baud rates
Date: Sat, 21 Sep 2013 03:43:44 -0400
Message-ID: <20130921074344.GA15524@inertiallabs-linux64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Alexey Pelykh <alexey.pelykh@gmail.com>

Fixes issue with division-by-zero exception, that occurred when a baud rate higher than 3Mbaud was requested.

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
index 816d1a2..808a880 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -240,8 +240,8 @@ serial_omap_baud_is_mode16(struct uart_port *port, unsigned int baud)
 {
 	unsigned int n13 = port->uartclk / (13 * baud);
 	unsigned int n16 = port->uartclk / (16 * baud);
-	int baudAbsDiff13 = baud - (port->uartclk / (13 * n13));
-	int baudAbsDiff16 = baud - (port->uartclk / (16 * n16));
+	int baudAbsDiff13 = n13 ? (baud - (port->uartclk / (13 * n13))) : INT_MAX;
+	int baudAbsDiff16 = n16 ? (baud - (port->uartclk / (16 * n16))) : INT_MAX;
 	if(baudAbsDiff13 < 0)
 		baudAbsDiff13 = -baudAbsDiff13;
 	if(baudAbsDiff16 < 0)

