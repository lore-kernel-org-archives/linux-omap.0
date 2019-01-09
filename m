From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/3] serial: 8250_omap: Drop check for of_node
Date: Wed, 9 Jan 2019 14:42:04 +0530
Message-ID: <20190109091206.25759-2-vigneshr@ti.com>
References: <20190109091206.25759-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109091206.25759-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

8250_omap is DT only driver so dev->of_node always exists. Drop check
for existence of valid dev->of_node to simplify omap8250_probe().

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 63 +++++++++++++----------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ad7ba7d0f28d..a74126569785 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1134,10 +1134,12 @@ static int omap8250_probe(struct platform_device *pdev)
 {
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	struct device_node *np = pdev->dev.of_node;
 	struct omap8250_priv *priv;
 	struct uart_8250_port up;
 	int ret;
 	void __iomem *membase;
+	const struct of_device_id *id;
 
 	if (!regs || !irq) {
 		dev_err(&pdev->dev, "missing registers or irq\n");
@@ -1194,27 +1196,20 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.unthrottle = omap_8250_unthrottle;
 	up.port.rs485_config = omap_8250_rs485_config;
 
-	if (pdev->dev.of_node) {
-		const struct of_device_id *id;
-
-		ret = of_alias_get_id(pdev->dev.of_node, "serial");
-
-		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-				     &up.port.uartclk);
-		priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
-
-		id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
-		if (id && id->data)
-			priv->habit |= *(u8 *)id->data;
-	} else {
-		ret = pdev->id;
-	}
+	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get alias/pdev id\n");
+		dev_err(&pdev->dev, "failed to get alias\n");
 		return ret;
 	}
 	up.port.line = ret;
 
+	of_property_read_u32(np, "clock-frequency", &up.port.uartclk);
+	priv->wakeirq = irq_of_parse_and_map(np, 1);
+
+	id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
+	if (id && id->data)
+		priv->habit |= *(u8 *)id->data;
+
 	if (!up.port.uartclk) {
 		up.port.uartclk = DEFAULT_CLK_SPEED;
 		dev_warn(&pdev->dev,
@@ -1242,25 +1237,23 @@ static int omap8250_probe(struct platform_device *pdev)
 	omap_serial_fill_features_erratas(&up, priv);
 	up.port.handle_irq = omap8250_no_handle_irq;
 #ifdef CONFIG_SERIAL_8250_DMA
-	if (pdev->dev.of_node) {
-		/*
-		 * Oh DMA support. If there are no DMA properties in the DT then
-		 * we will fall back to a generic DMA channel which does not
-		 * really work here. To ensure that we do not get a generic DMA
-		 * channel assigned, we have the the_no_dma_filter_fn() here.
-		 * To avoid "failed to request DMA" messages we check for DMA
-		 * properties in DT.
-		 */
-		ret = of_property_count_strings(pdev->dev.of_node, "dma-names");
-		if (ret == 2) {
-			up.dma = &priv->omap8250_dma;
-			priv->omap8250_dma.fn = the_no_dma_filter_fn;
-			priv->omap8250_dma.tx_dma = omap_8250_tx_dma;
-			priv->omap8250_dma.rx_dma = omap_8250_rx_dma;
-			priv->omap8250_dma.rx_size = RX_TRIGGER;
-			priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
-			priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
-		}
+	/*
+	 * Oh DMA support. If there are no DMA properties in the DT then
+	 * we will fall back to a generic DMA channel which does not
+	 * really work here. To ensure that we do not get a generic DMA
+	 * channel assigned, we have the the_no_dma_filter_fn() here.
+	 * To avoid "failed to request DMA" messages we check for DMA
+	 * properties in DT.
+	 */
+	ret = of_property_count_strings(np, "dma-names");
+	if (ret == 2) {
+		up.dma = &priv->omap8250_dma;
+		priv->omap8250_dma.fn = the_no_dma_filter_fn;
+		priv->omap8250_dma.tx_dma = omap_8250_tx_dma;
+		priv->omap8250_dma.rx_dma = omap_8250_rx_dma;
+		priv->omap8250_dma.rx_size = RX_TRIGGER;
+		priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
+		priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
 	}
 #endif
 	ret = serial8250_register_8250_port(&up);
-- 
2.20.1
