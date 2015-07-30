From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 2/3] serial: 8250: move rx_running out of the bitfield
Date: Fri, 31 Jul 2015 00:54:35 +0200
Message-ID: <87fv452r4k.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org, nsekhar@ti.comtony@atomide.com, nm@ti.com, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

That bitfield is modified by read + or + write operation. If someone
sets any of the other two bits it might render the lock useless.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index c43f74c..78f5e3a 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -44,7 +44,7 @@ struct uart_8250_dma {
 
 	unsigned char		tx_running:1;
 	unsigned char		tx_err: 1;
-	unsigned char		rx_running:1;
+	unsigned char		rx_running;
 };
 
 struct old_serial_port {
-- 
1.7.10.4
