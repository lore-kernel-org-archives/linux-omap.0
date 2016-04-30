From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/6] HSI: omap_ssi_port: switch to gpiod API
Date: Sat, 30 Apr 2016 04:09:08 +0200
Message-ID: <1461982153-19139-2-git-send-email-sre@kernel.org>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461982153-19139-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Simplify driver by switching to new gpio descriptor based API.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.c      |  1 -
 drivers/hsi/controllers/omap_ssi.h      |  4 ++--
 drivers/hsi/controllers/omap_ssi_port.c | 31 ++++++++++---------------------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi.c b/drivers/hsi/controllers/omap_ssi.c
index 27b91f14ba7a..c582229d1cd2 100644
--- a/drivers/hsi/controllers/omap_ssi.c
+++ b/drivers/hsi/controllers/omap_ssi.c
@@ -24,7 +24,6 @@
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
diff --git a/drivers/hsi/controllers/omap_ssi.h b/drivers/hsi/controllers/omap_ssi.h
index f9aaf37262be..1fa028078a3c 100644
--- a/drivers/hsi/controllers/omap_ssi.h
+++ b/drivers/hsi/controllers/omap_ssi.h
@@ -27,7 +27,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/hsi/hsi.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 
@@ -97,7 +97,7 @@ struct omap_ssi_port {
 	struct list_head	brkqueue;
 	unsigned int		irq;
 	int			wake_irq;
-	int			wake_gpio;
+	struct gpio_desc	*wake_gpio;
 	struct tasklet_struct	pio_tasklet;
 	struct tasklet_struct	wake_tasklet;
 	bool			wktest:1; /* FIXME: HACK to be removed */
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index e80a66e20998..948bdc7946fb 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -24,7 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/debugfs.h>
 
 #include "omap_ssi_regs.h"
@@ -43,7 +43,7 @@ static inline int hsi_dummy_cl(struct hsi_client *cl __maybe_unused)
 static inline unsigned int ssi_wakein(struct hsi_port *port)
 {
 	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
-	return gpio_get_value(omap_port->wake_gpio);
+	return gpiod_get_value(omap_port->wake_gpio);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -1036,12 +1036,12 @@ static int __init ssi_wake_irq(struct hsi_port *port,
 	int cawake_irq;
 	int err;
 
-	if (omap_port->wake_gpio == -1) {
+	if (!omap_port->wake_gpio) {
 		omap_port->wake_irq = -1;
 		return 0;
 	}
 
-	cawake_irq = gpio_to_irq(omap_port->wake_gpio);
+	cawake_irq = gpiod_to_irq(omap_port->wake_gpio);
 
 	omap_port->wake_irq = cawake_irq;
 	tasklet_init(&omap_port->wake_tasklet, ssi_wake_tasklet,
@@ -1111,7 +1111,7 @@ static int __init ssi_port_probe(struct platform_device *pd)
 	struct omap_ssi_port *omap_port;
 	struct hsi_controller *ssi = dev_get_drvdata(pd->dev.parent);
 	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
-	int cawake_gpio = 0;
+	struct gpio_desc *cawake_gpio = NULL;
 	u32 port_id;
 	int err;
 
@@ -1147,20 +1147,10 @@ static int __init ssi_port_probe(struct platform_device *pd)
 		goto error;
 	}
 
-	err = of_get_named_gpio(np, "ti,ssi-cawake-gpio", 0);
-	if (err < 0) {
-		dev_err(&pd->dev, "DT data is missing cawake gpio (err=%d)\n",
-			err);
-		goto error;
-	}
-	cawake_gpio = err;
-
-	err = devm_gpio_request_one(&port->device, cawake_gpio, GPIOF_DIR_IN,
-		"cawake");
-	if (err) {
-		dev_err(&pd->dev, "could not request cawake gpio (err=%d)!\n",
-			err);
-		err = -ENXIO;
+	cawake_gpio = devm_gpiod_get(&pd->dev, "ti,ssi-cawake", GPIOD_IN);
+	if (IS_ERR(cawake_gpio)) {
+		err = PTR_ERR(cawake_gpio);
+		dev_err(&pd->dev, "couldn't get cawake gpio (err=%d)!\n", err);
 		goto error;
 	}
 
@@ -1219,8 +1209,7 @@ static int __init ssi_port_probe(struct platform_device *pd)
 
 	hsi_add_clients_from_dt(port, np);
 
-	dev_info(&pd->dev, "ssi port %u successfully initialized (cawake=%d)\n",
-		port_id, cawake_gpio);
+	dev_info(&pd->dev, "ssi port %u successfully initialized\n", port_id);
 
 	return 0;
 
-- 
2.8.1
