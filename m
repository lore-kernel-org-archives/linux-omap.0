From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] tty: serial: 8250_omap: do not use RX DMA if pause is not supported
Date: Fri, 14 Aug 2015 17:52:07 +0200
Message-ID: <1439567527-19928-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peter@hurleysoftware.com
Cc: linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de
List-Id: linux-omap@vger.kernel.org

The 8250-omap driver requires the DMA-engine driver to support the paus=
e
command in order to properly turn off programmed RX transfer before the
driver stars manually reading from the FIFO.
The lacking support of the requirement has been discovered recently. In
order to stay safe here we disable RX-DMA completly on probe.
The rx_dma_broken assignment on probe could be removed once we working
pause function in omap-dma.

Cc: <stable@vger.kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
 - disable RX-DMA right on boot

 drivers/tty/serial/8250/8250_omap.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8=
250/8250_omap.c
index d9a37191a1ae..2ac63c8bd946 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -112,6 +112,7 @@ struct omap8250_priv {
 	struct work_struct qos_work;
 	struct uart_8250_dma omap8250_dma;
 	spinlock_t rx_dma_lock;
+	bool rx_dma_broken;
 };
=20
 static u32 uart_read(struct uart_8250_port *up, u32 reg)
@@ -773,6 +774,7 @@ static void omap_8250_rx_dma_flush(struct uart_8250=
_port *p)
 	struct omap8250_priv	*priv =3D p->port.private_data;
 	struct uart_8250_dma	*dma =3D p->dma;
 	unsigned long		flags;
+	int ret;
=20
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
=20
@@ -781,7 +783,9 @@ static void omap_8250_rx_dma_flush(struct uart_8250=
_port *p)
 		return;
 	}
=20
-	dmaengine_pause(dma->rxchan);
+	ret =3D dmaengine_pause(dma->rxchan);
+	if (WARN_ON_ONCE(ret))
+		priv->rx_dma_broken =3D true;
=20
 	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
=20
@@ -825,6 +829,9 @@ static int omap_8250_rx_dma(struct uart_8250_port *=
p, unsigned int iir)
 		break;
 	}
=20
+	if (priv->rx_dma_broken)
+		return -EINVAL;
+
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
=20
 	if (dma->rx_running)
@@ -1219,6 +1226,11 @@ static int omap8250_probe(struct platform_device=
 *pdev)
=20
 			if (of_machine_is_compatible("ti,am33xx"))
 				priv->habit |=3D OMAP_DMA_TX_KICK;
+			/*
+			 * pause is currently not supported atleast on omap-sdma
+			 * and edma on most earlier kernels.
+			 */
+			priv->rx_dma_broken =3D true;
 		}
 	}
 #endif
--=20
2.5.0
