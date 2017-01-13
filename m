From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 3/3] tty: serial: 8250_omap: Remove rx_dma_broken flag
Date: Fri, 13 Jan 2017 13:32:01 +0530
Message-ID: <20170113080201.6515-4-vigneshr@ti.com>
References: <20170113080201.6515-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170113080201.6515-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

8250 UART DMA support was marked broken by default as it was not
possible to pause ongoing RX DMA transfer. Now that both SDMA and
EDMA can support pause operation for RX DMA transactions, don't set
rx_dma_broken to true by default. With this patch 8250_omap driver will
use DMA by default.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 97766dcd67d4..68a6393d9636 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1221,11 +1221,6 @@ static int omap8250_probe(struct platform_device *pdev)
 			priv->omap8250_dma.rx_size = RX_TRIGGER;
 			priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
 			priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
-			/*
-			 * pause is currently not supported atleast on omap-sdma
-			 * and edma on most earlier kernels.
-			 */
-			priv->rx_dma_broken = true;
 		}
 	}
 #endif
-- 
2.11.0
