From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 03/13] Revert "serial: omap: unlock the port lock"
Date: Wed, 23 Apr 2014 09:58:27 -0500
Message-ID: <1398265117-11793-3-git-send-email-balbi@ti.com>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398265117-11793-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, jslaby@suse.cz, grant.likely@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

This reverts commit 0324a821029e1f54e7a7f8fed48693cfce42dc0e.

That commit tried to fix a deadlock problem when using
hci_ldisc, but it turns out the bug was in hci_ldsic
all along where it was calling ->write() from within
->write_wakeup() callback.

The problem is that ->write_wakeup() was called with
port lock held and ->write() tried to grab the same
port lock.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 08b6b94..837f6c1 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -398,11 +398,8 @@ static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
 			break;
 	} while (--count > 0);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
-		spin_unlock(&up->port.lock);
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&up->port);
-		spin_lock(&up->port.lock);
-	}
 
 	if (uart_circ_empty(xmit))
 		serial_omap_stop_tx(&up->port);
-- 
1.9.2.459.g68773ac
