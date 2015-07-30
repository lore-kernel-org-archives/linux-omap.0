From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 3/3] serial: 8250: omap: restore registers on shutdown
Date: Fri, 31 Jul 2015 00:54:45 +0200
Message-ID: <87egjp2r4a.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org, nsekhar@ti.comtony@atomide.com, nm@ti.com, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

If DMA is active during a shutdown, a delayed restore of the
registers may be pending. The restore must be performed after
the DMA is stopped, otherwise the delayed restore remains
pending and will fire upon the first DMA TX complete of a
totally different serial session.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5b39892..25f6255 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -657,9 +657,15 @@ static void omap_8250_shutdown(struct uart_port *port)
 	up->ier = 0;
 	serial_out(up, UART_IER, 0);
 
-	if (up->dma)
+	if (up->dma) {
 		serial8250_release_dma(up);
 
+		if (priv->delayed_restore) {
+			priv->delayed_restore = 0;
+			omap8250_restore_regs(up);
+		}
+	}
+
 	/*
 	 * Disable break condition and FIFOs
 	 */
-- 
1.7.10.4
