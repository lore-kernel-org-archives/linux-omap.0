From: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] tty: omap-serial: prevent division by zero
Date: Tue, 19 Aug 2014 14:14:46 +0200
Message-ID: <1408450488-4083-3-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
 <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408450488-4083-1-git-send-email-frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexey Pelykh <alexey.pelykh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Frans Klaver <fransklaver-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

If the chosen baud rate is large enough (e.g. 3.5 megabaud), the
calculated n values in calculate_baud_abs_diff may become 0. This causes
a division by zero when calculating the difference between calculated
and desired baud rates. To prevent this, cap n on 1.

Signed-off-by: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/serial/omap-serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ae935ce..14a0167 100644
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
+	abs_diff = baud - (uartclk / (mode * n));
 	if (abs_diff < 0)
 		abs_diff = -abs_diff;
 
-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
