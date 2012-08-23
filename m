From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v3 06/23] serial: omap: simplify IRQ handling
Date: Thu, 23 Aug 2012 13:32:46 +0300
Message-ID: <1345717983-18179-7-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1345717983-18179-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alan@linux.intel.com
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

quite a few changes here, though they are
pretty obvious. In summary we're making sure
to detect which interrupt type we need to
handle before calling the underlying interrupt
handling procedure.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 51 ++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 16808b6..1e91ca6 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -350,33 +350,58 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 {
 	struct uart_omap_port *up = dev_id;
 	unsigned int iir, lsr;
+	unsigned int type;
 	unsigned long flags;
+	irqreturn_t ret = IRQ_NONE;
 
+	spin_lock_irqsave(&up->port.lock, flags);
 	pm_runtime_get_sync(up->dev);
 	iir = serial_in(up, UART_IIR);
-	if (iir & UART_IIR_NO_INT) {
-		pm_runtime_mark_last_busy(up->dev);
-		pm_runtime_put_autosuspend(up->dev);
-		return IRQ_NONE;
-	}
+again:
+	if (iir & UART_IIR_NO_INT)
+		goto out;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	ret = IRQ_HANDLED;
 	lsr = serial_in(up, UART_LSR);
-	if (iir & UART_IIR_RLSI) {
+
+	/* extract IRQ type from IIR register */
+	type = iir & 0x3e;
+
+	switch (type) {
+	case UART_IIR_MSI:
+		check_modem_status(up);
+		break;
+	case UART_IIR_THRI:
+		if (lsr & UART_LSR_THRE)
+			transmit_chars(up);
+		break;
+	case UART_IIR_RDI:
 		if (lsr & UART_LSR_DR)
 			receive_chars(up, &lsr);
+		break;
+	case UART_IIR_RLSI:
+		if (lsr & UART_LSR_BRK_ERROR_BITS)
+			receive_chars(up, &lsr);
+		break;
+	case UART_IIR_RX_TIMEOUT:
+		receive_chars(up, &lsr);
+		break;
+	case UART_IIR_CTS_RTS_DSR:
+		iir = serial_in(up, UART_IIR);
+		goto again;
+	case UART_IIR_XOFF:
+		/* FALLTHROUGH */
+	default:
+		break;
 	}
 
-	check_modem_status(up);
-	if ((lsr & UART_LSR_THRE) && (iir & UART_IIR_THRI))
-		transmit_chars(up);
-
+out:
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
-
 	up->port_activity = jiffies;
-	return IRQ_HANDLED;
+
+	return ret;
 }
 
 static unsigned int serial_omap_tx_empty(struct uart_port *port)
-- 
1.7.12.rc3
