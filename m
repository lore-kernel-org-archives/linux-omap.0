From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 1/4] tty: omap-serial: pull out calculation from baud_is_mode16
Date: Tue, 19 Aug 2014 14:14:45 +0200
Message-ID: <1408450488-4083-2-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
 <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexey Pelykh <alexey.pelykh@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Frans Klaver <fransklaver@gmail.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

To determine the correct divisor, we need to know the difference between
the desired baud rate and the actual baud rate. The calculation for this
difference is implemented twice within omap_serial_baud_is_mode16().
Pull out the calculation for easier maintenance.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/tty/serial/omap-serial.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d017cec..ae935ce 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -239,6 +239,22 @@ static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 }
 
 /*
+ * Calculate the absolute difference between the desired and actual baud
+ * rate for the given mode.
+ */
+static inline int calculate_baud_abs_diff(struct uart_port *port,
+				unsigned int baud, unsigned int mode)
+{
+	unsigned int n = port->uartclk / (mode * baud);
+	int abs_diff = baud - (port->uartclk / (mode * n));
+
+	if (abs_diff < 0)
+		abs_diff = -abs_diff;
+
+	return abs_diff;
+}
+
+/*
  * serial_omap_baud_is_mode16 - check if baud rate is MODE16X
  * @port: uart port info
  * @baud: baudrate for which mode needs to be determined
@@ -252,14 +268,8 @@ static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 static bool
 serial_omap_baud_is_mode16(struct uart_port *port, unsigned int baud)
 {
-	unsigned int n13 = port->uartclk / (13 * baud);
-	unsigned int n16 = port->uartclk / (16 * baud);
-	int baudAbsDiff13 = baud - (port->uartclk / (13 * n13));
-	int baudAbsDiff16 = baud - (port->uartclk / (16 * n16));
-	if (baudAbsDiff13 < 0)
-		baudAbsDiff13 = -baudAbsDiff13;
-	if (baudAbsDiff16 < 0)
-		baudAbsDiff16 = -baudAbsDiff16;
+	int baudAbsDiff13 = calculate_baud_abs_diff(port, baud, 13);
+	int baudAbsDiff16 = calculate_baud_abs_diff(port, baud, 16);
 
 	return (baudAbsDiff13 >= baudAbsDiff16);
 }
-- 
1.9.3
