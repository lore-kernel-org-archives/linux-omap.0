From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/7] serial: 8250_dma: continue TX dma on dma error
Date: Tue, 29 Jul 2014 20:59:00 +0200
Message-ID: <1406660344-25307-4-git-send-email-bigeasy@linutronix.de>
References: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

After TX dma completes the code will queue another DMA transfer. If
serial8250_tx_dma() fails then there is no plan B to continue the
transfer manually.
This patch enables the TX-fifo empty event so it can be tried again via
DMA or use the manual fallback in case it fails.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_dma.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 148ffe4..f9ef69f 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -36,8 +36,15 @@ static void __dma_tx_complete(void *param)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&p->port);
 
-	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port))
-		serial8250_tx_dma(p);
+	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port)) {
+		int ret;
+
+		ret = serial8250_tx_dma(p);
+		if (ret && !(p->ier & UART_IER_THRI)) {
+			p->ier |= UART_IER_THRI;
+			serial_port_out(&p->port, UART_IER, p->ier);
+		}
+	}
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
 }
-- 
2.0.1
