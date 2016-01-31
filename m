From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/5] HSI: nokia-modem: simplify kernel access to gpios
Date: Sun, 31 Jan 2016 02:19:43 +0100
Message-ID: <1454203187-688-2-git-send-email-sre@kernel.org>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454203187-688-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

For implementing kernel based modem power management, the
gpios should be accessible via name from the kernel. The
old code would require walking through the gpio array
comparing the name of each gpio. This is no longer needed
by the new code, which does the comparing once at probe
time. As a side effect the code now checks, that all
required gpios are provided.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/nokia-modem.c | 115 ++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 30 deletions(-)

diff --git a/drivers/hsi/clients/nokia-modem.c b/drivers/hsi/clients/nokia-modem.c
index c000780d931f..f20ede611593 100644
--- a/drivers/hsi/clients/nokia-modem.c
+++ b/drivers/hsi/clients/nokia-modem.c
@@ -34,19 +34,23 @@ module_param(pm, int, 0400);
 MODULE_PARM_DESC(pm,
 	"Enable power management (0=disabled, 1=userland based [default])");
 
-struct nokia_modem_gpio {
-	struct gpio_desc	*gpio;
-	const char		*name;
+enum nokia_modem_type {
+	RAPUYAMA_V1,
+	RAPUYAMA_V2,
 };
 
 struct nokia_modem_device {
 	struct tasklet_struct	nokia_modem_rst_ind_tasklet;
 	int			nokia_modem_rst_ind_irq;
 	struct device		*device;
-	struct nokia_modem_gpio	*gpios;
-	int			gpio_amount;
 	struct hsi_client	*ssi_protocol;
 	struct hsi_client	*cmt_speech;
+	enum nokia_modem_type	type;
+	struct gpio_desc        *gpio_cmt_en;
+	struct gpio_desc	*gpio_cmt_apeslpx;
+	struct gpio_desc	*gpio_cmt_rst_rq;
+	struct gpio_desc	*gpio_cmt_rst;
+	struct gpio_desc	*gpio_cmt_bsi;
 };
 
 static void do_nokia_modem_rst_ind_tasklet(unsigned long data)
@@ -74,11 +78,33 @@ static irqreturn_t nokia_modem_rst_ind_isr(int irq, void *data)
 static void nokia_modem_gpio_unexport(struct device *dev)
 {
 	struct nokia_modem_device *modem = dev_get_drvdata(dev);
-	int i;
 
-	for (i = 0; i < modem->gpio_amount; i++) {
-		sysfs_remove_link(&dev->kobj, modem->gpios[i].name);
-		gpiod_unexport(modem->gpios[i].gpio);
+	if (pm != 1)
+		return;
+
+	if (modem->gpio_cmt_en) {
+		sysfs_remove_link(&dev->kobj, "cmt_en");
+		gpiod_unexport(modem->gpio_cmt_en);
+	}
+
+	if (modem->gpio_cmt_apeslpx) {
+		sysfs_remove_link(&dev->kobj, "cmt_apeslpx");
+		gpiod_unexport(modem->gpio_cmt_apeslpx);
+	}
+
+	if (modem->gpio_cmt_rst_rq) {
+		sysfs_remove_link(&dev->kobj, "cmt_rst_rq");
+		gpiod_unexport(modem->gpio_cmt_rst_rq);
+	}
+
+	if (modem->gpio_cmt_rst) {
+		sysfs_remove_link(&dev->kobj, "cmt_rst");
+		gpiod_unexport(modem->gpio_cmt_rst);
+	}
+
+	if (modem->gpio_cmt_bsi) {
+		sysfs_remove_link(&dev->kobj, "cmt_bsi");
+		gpiod_unexport(modem->gpio_cmt_bsi);
 	}
 }
 
@@ -102,38 +128,61 @@ static int nokia_modem_gpio_probe(struct device *dev)
 		return -EINVAL;
 	}
 
-	modem->gpios = devm_kzalloc(dev, gpio_count *
-				sizeof(struct nokia_modem_gpio), GFP_KERNEL);
-	if (!modem->gpios) {
-		dev_err(dev, "Could not allocate memory for gpios\n");
-		return -ENOMEM;
-	}
-
-	modem->gpio_amount = gpio_count;
-
 	for (i = 0; i < gpio_count; i++) {
-		modem->gpios[i].gpio = devm_gpiod_get_index(dev, NULL, i,
-							    GPIOD_OUT_LOW);
-		if (IS_ERR(modem->gpios[i].gpio)) {
+		const char *gpio_name;
+		struct gpio_desc *gpio_val;
+
+		gpio_val = devm_gpiod_get_index(dev, NULL, i, GPIOD_OUT_LOW);
+		if (IS_ERR(gpio_val)) {
 			dev_err(dev, "Could not get gpio %d\n", i);
-			return PTR_ERR(modem->gpios[i].gpio);
+			return PTR_ERR(gpio_val);
 		}
 
 		err = of_property_read_string_index(np, "gpio-names", i,
-						&(modem->gpios[i].name));
+						    &gpio_name);
 		if (err) {
 			dev_err(dev, "Could not get gpio name %d\n", i);
 			return err;
 		}
 
-		err = gpiod_export(modem->gpios[i].gpio, 0);
-		if (err)
-			return err;
+		if (strcmp(gpio_name, "cmt_en") == 0) {
+			modem->gpio_cmt_en = gpio_val;
+		} else if(strcmp(gpio_name, "cmt_apeslpx") == 0) {
+			modem->gpio_cmt_apeslpx = gpio_val;
+		} else if(strcmp(gpio_name, "cmt_rst_rq") == 0) {
+			modem->gpio_cmt_rst_rq = gpio_val;
+		} else if(strcmp(gpio_name, "cmt_rst") == 0) {
+			modem->gpio_cmt_rst = gpio_val;
+		} else if(strcmp(gpio_name, "cmt_bsi") == 0) {
+			modem->gpio_cmt_bsi = gpio_val;
+		} else {
+			dev_err(dev, "Unknown gpio '%s'\n", gpio_name);
+			return -EINVAL;
+		}
 
-		err = gpiod_export_link(dev, modem->gpios[i].name,
-							modem->gpios[i].gpio);
-		if (err)
-			return err;
+		if (pm == 1) {
+			err = gpiod_export(gpio_val, 0);
+			if (err)
+				return err;
+
+			err = gpiod_export_link(dev, gpio_name, gpio_val);
+			if (err)
+				return err;
+		}
+	}
+
+	/* gpios required by both generations */
+	if (!modem->gpio_cmt_en || !modem->gpio_cmt_apeslpx ||
+	    !modem->gpio_cmt_rst_rq) {
+		dev_err(dev, "missing gpio!");
+		return -ENXIO;
+	}
+
+	/* gpios required by first generations */
+	if (modem->type == RAPUYAMA_V1 &&
+	   (!modem->gpio_cmt_rst || !modem->gpio_cmt_bsi)) {
+		dev_err(dev, "missing gpio!");
+		return -ENXIO;
 	}
 
 	return 0;
@@ -163,6 +212,12 @@ static int nokia_modem_probe(struct device *dev)
 	dev_set_drvdata(dev, modem);
 	modem->device = dev;
 
+	if (of_device_is_compatible(np, "nokia,n900-modem")) {
+		modem->type = RAPUYAMA_V1;
+	} else {
+		modem->type = RAPUYAMA_V2;
+	}
+
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		dev_err(dev, "Invalid rst_ind interrupt (%d)\n", irq);
-- 
2.7.0.rc3
