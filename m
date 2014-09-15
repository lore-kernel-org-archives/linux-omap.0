From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 2/4] tty: omap-serial: prevent division by zero
Date: Mon, 15 Sep 2014 16:00:08 +0200
Message-ID: <1410789610-23059-3-git-send-email-frans.klaver@xsens.com>
References: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Frans Klaver <frans.klaver@xsens.com>, Alexey Pelykh <alexey.pelykh@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If the chosen baud rate is large enough (e.g. 3.5 megabaud), the
calculated n values in calculate_baud_abs_diff may become 0. This causes
a division by zero when calculating the difference between calculated
and desired baud rates. To prevent this, cap n on 1.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/tty/serial/omap-serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ae935ce..7d3f557 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -246,8 +246,12 @@ static inline int calculate_baud_abs_diff(struct uart_port *port,
 				unsigned int baud, unsigned int mode)
 {
 	unsigned int n = port->uartclk / (mode * baud);
-	int abs_diff = baud - (port->uartclk / (mode * n));
+	int abs_diff;
 
+	if (n == 0)
+		n = 1;
+
+	abs_diff = baud - (port->uartclk / (mode * n));
 	if (abs_diff < 0)
 		abs_diff = -abs_diff;
 
-- 
2.1.0
