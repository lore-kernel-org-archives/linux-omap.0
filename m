From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/3] tty: serial: 8250_omap: Add OMAP_DMA_TX_KICK quirk for AM437x
Date: Fri, 13 Jan 2017 13:32:00 +0530
Message-ID: <20170113080201.6515-3-vigneshr@ti.com>
References: <20170113080201.6515-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170113080201.6515-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

UART uses as EDMA as dma engine on AM437x SoC and therefore, requires
OMAP_DMA_TX_KICK quirk just like AM33xx. So, enable OMAP_DMA_TX_KICK
quirk for AM437x platform as well. While at that, drop use of
of_machine_is_compatible() and instead pass quirks via device data.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 4ad1934ef6ed..97766dcd67d4 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1078,15 +1078,15 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 }
 
 static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
-static const u8 am4372_habit = UART_ERRATA_CLOCK_DISABLE;
+static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
 
 static const struct of_device_id omap8250_dt_ids[] = {
 	{ .compatible = "ti,omap2-uart" },
 	{ .compatible = "ti,omap3-uart" },
 	{ .compatible = "ti,omap4-uart" },
 	{ .compatible = "ti,am3352-uart", .data = &am3352_habit, },
-	{ .compatible = "ti,am4372-uart", .data = &am4372_habit, },
-	{ .compatible = "ti,dra742-uart", .data = &am4372_habit, },
+	{ .compatible = "ti,am4372-uart", .data = &am3352_habit, },
+	{ .compatible = "ti,dra742-uart", .data = &dra742_habit, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap8250_dt_ids);
@@ -1221,9 +1221,6 @@ static int omap8250_probe(struct platform_device *pdev)
 			priv->omap8250_dma.rx_size = RX_TRIGGER;
 			priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
 			priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
-
-			if (of_machine_is_compatible("ti,am33xx"))
-				priv->habit |= OMAP_DMA_TX_KICK;
 			/*
 			 * pause is currently not supported atleast on omap-sdma
 			 * and edma on most earlier kernels.
-- 
2.11.0
