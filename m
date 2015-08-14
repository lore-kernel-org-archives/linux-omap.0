From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] serial: 8250: move rx_running out of the bitfield
Date: Fri, 14 Aug 2015 18:01:02 +0200
Message-ID: <1439568064-7907-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peter@hurleysoftware.com
Cc: linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

That bitfield is modified by read + or + write operation. If someone
sets any of the other two bits it might render the lock useless.

While at it, remove other bitfields as well to avoid more such
errors.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index c43f74c53cd9..a407757dcecc 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -42,9 +42,9 @@ struct uart_8250_dma {
 	size_t			rx_size;
 	size_t			tx_size;
 
-	unsigned char		tx_running:1;
-	unsigned char		tx_err: 1;
-	unsigned char		rx_running:1;
+	unsigned char		tx_running;
+	unsigned char		tx_err;
+	unsigned char		rx_running;
 };
 
 struct old_serial_port {
-- 
2.5.0
