From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v8 2/8] can: c_can: Introduce c_can_driver_data structure
Date: Fri, 14 Nov 2014 19:09:45 +0100
Message-ID: <1415988591-6032-3-git-send-email-mkl@pengutronix.de>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, rogerq@ti.com, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

We want to have more data than just can_dev_id to be present
in the driver data e.g. TI platforms need RAMINIT register
description. Introduce the c_can_driver_data structure and move
the can_dev_id into it.

Tidy up the way it is used on probe().

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.h          |  4 +++
 drivers/net/can/c_can/c_can_platform.c | 52 +++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 99ad1aa576b0..26c975d914e3 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -169,6 +169,10 @@ enum c_can_dev_id {
 	BOSCH_D_CAN,
 };
 
+struct c_can_driver_data {
+	enum c_can_dev_id id;
+};
+
 /* c_can private data structure */
 struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 106c203fc5eb..44c293926f78 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -168,26 +168,34 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 	}
 }
 
+static const struct c_can_driver_data c_can_drvdata = {
+	.id = BOSCH_C_CAN,
+};
+
+static const struct c_can_driver_data d_can_drvdata = {
+	.id = BOSCH_D_CAN,
+};
+
 static struct platform_device_id c_can_id_table[] = {
-	[BOSCH_C_CAN_PLATFORM] = {
+	{
 		.name = KBUILD_MODNAME,
-		.driver_data = BOSCH_C_CAN,
+		.driver_data = (kernel_ulong_t)&c_can_drvdata,
 	},
-	[BOSCH_C_CAN] = {
+	{
 		.name = "c_can",
-		.driver_data = BOSCH_C_CAN,
+		.driver_data = (kernel_ulong_t)&c_can_drvdata,
 	},
-	[BOSCH_D_CAN] = {
+	{
 		.name = "d_can",
-		.driver_data = BOSCH_D_CAN,
-	}, {
-	}
+		.driver_data = (kernel_ulong_t)&d_can_drvdata,
+	},
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(platform, c_can_id_table);
 
 static const struct of_device_id c_can_of_table[] = {
-	{ .compatible = "bosch,c_can", .data = &c_can_id_table[BOSCH_C_CAN] },
-	{ .compatible = "bosch,d_can", .data = &c_can_id_table[BOSCH_D_CAN] },
+	{ .compatible = "bosch,c_can", .data = &c_can_drvdata },
+	{ .compatible = "bosch,d_can", .data = &d_can_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, c_can_of_table);
@@ -199,21 +207,19 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	struct net_device *dev;
 	struct c_can_priv *priv;
 	const struct of_device_id *match;
-	const struct platform_device_id *id;
 	struct resource *mem, *res;
 	int irq;
 	struct clk *clk;
-
-	if (pdev->dev.of_node) {
-		match = of_match_device(c_can_of_table, &pdev->dev);
-		if (!match) {
-			dev_err(&pdev->dev, "Failed to find matching dt id\n");
-			ret = -EINVAL;
-			goto exit;
-		}
-		id = match->data;
+	const struct c_can_driver_data *drvdata;
+
+	match = of_match_device(c_can_of_table, &pdev->dev);
+	if (match) {
+		drvdata = match->data;
+	} else if (pdev->id_entry->driver_data) {
+		drvdata = (struct c_can_driver_data *)
+			platform_get_device_id(pdev)->driver_data;
 	} else {
-		id = platform_get_device_id(pdev);
+		return -ENODEV;
 	}
 
 	/* get the appropriate clk */
@@ -245,7 +251,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	}
 
 	priv = netdev_priv(dev);
-	switch (id->driver_data) {
+	switch (drvdata->id) {
 	case BOSCH_C_CAN:
 		priv->regs = reg_map_c_can;
 		switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
@@ -304,7 +310,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	priv->device = &pdev->dev;
 	priv->can.clock.freq = clk_get_rate(clk);
 	priv->priv = clk;
-	priv->type = id->driver_data;
+	priv->type = drvdata->id;
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
-- 
2.1.1

