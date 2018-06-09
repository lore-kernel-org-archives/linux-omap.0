From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 03/10] Input: ams_delta_serio: use private structure
Date: Sat,  9 Jun 2018 16:02:17 +0200
Message-ID: <20180609140224.32606-3-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Introduce a driver private structure and allocate it on device probe.
For now, use it instead of a static variable for storing a pointer to
serio structure.  Subsequent patches will populate it with more members
as needed.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

# Conflicts:
#	drivers/input/serio/ams_delta_serio.c
---
 drivers/input/serio/ams_delta_serio.c | 69 ++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index a2a7fa19bf49..551a4fa73fe4 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -37,17 +37,17 @@ MODULE_AUTHOR("Matt Callow");
 MODULE_DESCRIPTION("AMS Delta (E3) keyboard port driver");
 MODULE_LICENSE("GPL");
 
-static struct serio *ams_delta_serio;
+struct ams_delta_serio {
+	struct serio *serio;
+};
 
-static int check_data(int data)
+static int check_data(struct serio *serio, int data)
 {
 	int i, parity = 0;
 
 	/* check valid stop bit */
 	if (!(data & 0x400)) {
-		dev_warn(&ams_delta_serio->dev,
-				"invalid stop bit, data=0x%X\n",
-				data);
+		dev_warn(&serio->dev, "invalid stop bit, data=0x%X\n", data);
 		return SERIO_FRAME;
 	}
 	/* calculate the parity */
@@ -57,9 +57,9 @@ static int check_data(int data)
 	}
 	/* it should be odd */
 	if (!(parity & 0x01)) {
-		dev_warn(&ams_delta_serio->dev,
-				"parity check failed, data=0x%X parity=0x%X\n",
-				data, parity);
+		dev_warn(&serio->dev,
+			 "parity check failed, data=0x%X parity=0x%X\n", data,
+			 parity);
 		return SERIO_PARITY;
 	}
 	return 0;
@@ -67,6 +67,7 @@ static int check_data(int data)
 
 static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
 {
+	struct ams_delta_serio *priv = dev_id;
 	int *circ_buff = &fiq_buffer[FIQ_CIRC_BUFF];
 	int data, dfl;
 	u8 scancode;
@@ -84,9 +85,9 @@ static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
 		if (fiq_buffer[FIQ_HEAD_OFFSET] == fiq_buffer[FIQ_BUF_LEN])
 			fiq_buffer[FIQ_HEAD_OFFSET] = 0;
 
-		dfl = check_data(data);
+		dfl = check_data(priv->serio, data);
 		scancode = (u8) (data >> 1) & 0xFF;
-		serio_interrupt(ams_delta_serio, scancode, dfl);
+		serio_interrupt(priv->serio, scancode, dfl);
 	}
 	return IRQ_HANDLED;
 }
@@ -130,21 +131,14 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
 
 static int ams_delta_serio_init(struct platform_device *pdev)
 {
+	struct ams_delta_serio *priv;
+	struct serio *serio;
 	int err;
 
-	ams_delta_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!ams_delta_serio)
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
 
-	ams_delta_serio->id.type = SERIO_8042;
-	ams_delta_serio->open = ams_delta_serio_open;
-	ams_delta_serio->close = ams_delta_serio_close;
-	strlcpy(ams_delta_serio->name, "AMS DELTA keyboard adapter",
-			sizeof(ams_delta_serio->name));
-	strlcpy(ams_delta_serio->phys, dev_name(&pdev->dev),
-			sizeof(ams_delta_serio->phys));
-	ams_delta_serio->dev.parent = &pdev->dev;
-
 	err = gpio_request_array(ams_delta_gpios,
 				ARRAY_SIZE(ams_delta_gpios));
 	if (err) {
@@ -154,7 +148,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 
 	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
 			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
-			DRIVER_NAME, 0);
+			DRIVER_NAME, priv);
 	if (err < 0) {
 		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
 		goto gpio;
@@ -167,21 +161,44 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 	irq_set_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
 			handle_simple_irq);
 
-	serio_register_port(ams_delta_serio);
-	dev_info(&ams_delta_serio->dev, "%s\n", ams_delta_serio->name);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
+	if (!serio) {
+		err = -ENOMEM;
+		goto irq;
+	}
+
+	priv->serio = serio;
+
+	serio->id.type = SERIO_8042;
+	serio->open = ams_delta_serio_open;
+	serio->close = ams_delta_serio_close;
+	strlcpy(serio->name, "AMS DELTA keyboard adapter", sizeof(serio->name));
+	strlcpy(serio->phys, dev_name(&pdev->dev), sizeof(serio->phys));
+	serio->dev.parent = &pdev->dev;
+	serio->port_data = priv;
+
+	serio_register_port(serio);
+
+	platform_set_drvdata(pdev, priv);
+
+	dev_info(&serio->dev, "%s\n", serio->name);
 
 	return 0;
+
+irq:
+	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), priv);
 gpio:
 	gpio_free_array(ams_delta_gpios,
 			ARRAY_SIZE(ams_delta_gpios));
 serio:
-	kfree(ams_delta_serio);
 	return err;
 }
 
 static int ams_delta_serio_exit(struct platform_device *pdev)
 {
-	serio_unregister_port(ams_delta_serio);
+	struct ams_delta_serio *priv = platform_get_drvdata(pdev);
+
+	serio_unregister_port(priv->serio);
 	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
 	gpio_free_array(ams_delta_gpios,
 			ARRAY_SIZE(ams_delta_gpios));
-- 
2.16.1
