From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 12/13] tty: serial: omap: fix Sparse warnings
Date: Wed, 23 Apr 2014 09:58:36 -0500
Message-ID: <1398265117-11793-12-git-send-email-balbi@ti.com>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398265117-11793-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, jslaby@suse.cz, grant.likely@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Fix the following Sparse warnings:

drivers/tty/serial/omap-serial.c:1418:49: warning: incorrect \
	type in argument 2 (different address spaces)
drivers/tty/serial/omap-serial.c:1418:49:    expected void const \
	[noderef] <asn:1>*from
drivers/tty/serial/omap-serial.c:1418:49:    got struct serial_rs485 \
	*<noident>
drivers/tty/serial/omap-serial.c:1426:35: warning: incorrect \
	type in argument 1 (different address spaces)
drivers/tty/serial/omap-serial.c:1426:35:    expected void [noderef] \
	<asn:1>*to
drivers/tty/serial/omap-serial.c:1426:35:    got struct serial_rs485 \
	*<noident>

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ab22dab..d017cec 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1398,7 +1398,7 @@ serial_omap_ioctl(struct uart_port *port, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case TIOCSRS485:
-		if (copy_from_user(&rs485conf, (struct serial_rs485 *) arg,
+		if (copy_from_user(&rs485conf, (void __user *) arg,
 					sizeof(rs485conf)))
 			return -EFAULT;
 
@@ -1406,7 +1406,7 @@ serial_omap_ioctl(struct uart_port *port, unsigned int cmd, unsigned long arg)
 		break;
 
 	case TIOCGRS485:
-		if (copy_to_user((struct serial_rs485 *) arg,
+		if (copy_to_user((void __user *) arg,
 					&(to_uart_omap_port(port)->rs485),
 					sizeof(rs485conf)))
 			return -EFAULT;
-- 
1.9.2.459.g68773ac
