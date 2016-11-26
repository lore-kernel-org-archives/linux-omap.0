From: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/5] mfd: twl: move structure definitions to a public header
Date: Sat, 26 Nov 2016 20:13:24 +0200
Message-ID: <20161126181326.14951-4-Nicolae_Rosia@mentor.com>
References: <20161126181326.14951-1-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161126181326.14951-1-Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We want to get rid of exported symbols and have
the child devices use structure members directly.
Move the structure definitions to header and set
drvdata so child devices can access it.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/mfd/twl-core.c       | 27 ++++-----------------------
 include/linux/mfd/twl-core.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/mfd/twl-core.h

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index e16084e..409b836 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -48,6 +48,7 @@
 
 #include <linux/i2c.h>
 #include <linux/i2c/twl.h>
+#include <linux/mfd/twl-core.h>
 
 /* Register descriptions for audio */
 #include <linux/mfd/twl4030-audio.h>
@@ -154,28 +155,7 @@ int twl4030_init_irq(struct device *dev, int irq_num);
 int twl4030_exit_irq(void);
 int twl4030_init_chip_irq(const char *chip);
 
-/* Structure for each TWL4030/TWL6030 Slave */
-struct twl_client {
-	struct i2c_client *client;
-	struct regmap *regmap;
-};
-
-/* mapping the module id to slave id and base address */
-struct twl_mapping {
-	unsigned char sid;	/* Slave ID */
-	unsigned char base;	/* base address */
-};
-
-struct twl_private {
-	bool ready; /* The core driver is ready to be used */
-	u32 twl_idcode; /* TWL IDCODE Register value */
-	unsigned int twl_id;
-
-	struct twl_mapping *twl_map;
-	struct twl_client *twl_modules;
-};
-
-static struct twl_private *twl_priv;
+static struct twlcore *twl_priv;
 
 static struct twl_mapping twl4030_map[] = {
 	/*
@@ -745,7 +725,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto free;
 	}
 
-	twl_priv = devm_kzalloc(&client->dev, sizeof(struct twl_private),
+	twl_priv = devm_kzalloc(&client->dev, sizeof(struct twlcore),
 				GFP_KERNEL);
 	if (!twl_priv) {
 		status = -ENOMEM;
@@ -803,6 +783,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	twl_priv->ready = true;
+	dev_set_drvdata(&client->dev, twl_priv);
 
 	/* setup clock framework */
 	clocks_init(&pdev->dev);
diff --git a/include/linux/mfd/twl-core.h b/include/linux/mfd/twl-core.h
new file mode 100644
index 0000000..d1c01b3
--- /dev/null
+++ b/include/linux/mfd/twl-core.h
@@ -0,0 +1,35 @@
+/*
+ * MFD core driver for the Texas Instruments TWL PMIC family
+ *
+ * Copyright (C) 2016 Nicolae Rosia <nicolae.rosia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __TWL_CORE_H__
+#define __TWL_CORE_H__
+
+/* Structure for each TWL4030/TWL6030 Slave */
+struct twl_client {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+/* mapping the module id to slave id and base address */
+struct twl_mapping {
+	unsigned char sid; /* Slave ID */
+	unsigned char base; /* base address */
+};
+
+struct twlcore {
+	bool ready; /* The core driver is ready to be used */
+	u32 twl_idcode; /* TWL IDCODE Register value */
+	unsigned int twl_id;
+
+	struct twl_mapping *twl_map;
+	struct twl_client *twl_modules;
+};
+
+#endif
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
