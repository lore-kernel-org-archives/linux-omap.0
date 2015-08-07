From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] tty: serial: 8250_omap: do not use RX DMA if pause is not supported
Date: Fri,  7 Aug 2015 22:00:17 +0200
Message-ID: <1438977619-15488-2-git-send-email-bigeasy@linutronix.de>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, peter@hurleysoftware.com
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

The 8250-omap driver requires the DMA-engine driver to support the pause
command in order to properly turn off programmed RX transfer before the
driver stars manually reading from the FIFO.
The lacking support of the requirement has been discovered recently. In
order to stay safe here we disable support for RX-DMA as soon as we
notice that it does not work. This should happen very early.
If the user does not want to see this backtrace he can either disable
DMA support (completely or RX-only) or backport the required patches for
edma / omap-dma once they hit mainline.

Cc: <stable@vger.kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 0340ee6ba970..07a11e0935e4 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -112,6 +112,7 @@ struct omap8250_priv {
 	struct work_struct qos_work;
 	struct uart_8250_dma omap8250_dma;
 	spinlock_t rx_dma_lock;
+	bool rx_dma_broken;
 };
 
 static u32 uart_read(struct uart_8250_port *up, u32 reg)
@@ -761,6 +762,7 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 	struct omap8250_priv	*priv = p->port.private_data;
 	struct uart_8250_dma	*dma = p->dma;
 	unsigned long		flags;
+	int ret;
 
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
 
@@ -769,7 +771,9 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 		return;
 	}
 
-	dmaengine_pause(dma->rxchan);
+	ret = dmaengine_pause(dma->rxchan);
+	if (WARN_ON_ONCE(ret))
+		priv->rx_dma_broken = true;
 
 	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
 
@@ -813,6 +817,9 @@ static int omap_8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 		break;
 	}
 
+	if (priv->rx_dma_broken)
+		return -EINVAL;
+
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
 
 	if (dma->rx_running)
-- 
2.5.0
