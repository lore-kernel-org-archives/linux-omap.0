From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 6/8] input: ti_am335x_tsc: Add DT support
Date: Thu, 24 Jan 2013 09:15:10 +0530
Message-ID: <1358999112-31192-7-git-send-email-rachna@ti.com>
References: <1358999112-31192-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1358999112-31192-1-git-send-email-rachna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, gururaja.hebbar-l0cyMroinI0@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>

Add DT support for client touchscreen driver

Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
---
Changes in v4:
	Non-standard properties prefixed with vendor name.

 drivers/input/touchscreen/ti_am335x_tsc.c |   94 +++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 064d2b2..6ff5a76 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -26,6 +26,8 @@
 #include <linux/io.h>
 #include <linux/input/ti_am335x_tsc.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 
@@ -366,6 +368,74 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
+					struct titsc *ts_dev)
+{
+	struct device_node *node = tscadc_dev->dev->of_node;
+	int err, i;
+	u32 val32, wires_conf[4];
+
+	if (!node)
+		return -EINVAL;
+	else {
+		node = of_find_node_by_name(node, "tsc");
+		if (!node)
+			return -EINVAL;
+		else {
+			err = of_property_read_u32(node, "ti,wires", &val32);
+			if (err < 0)
+				goto error_ret;
+			else
+				ts_dev->wires = val32;
+
+			err = of_property_read_u32(node,
+					"ti,x-plate-resistance", &val32);
+			if (err < 0)
+				goto error_ret;
+			else
+				ts_dev->x_plate_resistance = val32;
+
+			err = of_property_read_u32(node,
+					"ti,steps-to-configure", &val32);
+			if (err < 0)
+				goto error_ret;
+			else
+				ts_dev->steps_to_configure = val32;
+
+			err = of_property_read_u32_array(node, "ti,wire-config",
+					wires_conf, ARRAY_SIZE(wires_conf));
+			if (err < 0)
+				goto error_ret;
+			else {
+				for (i = 0; i < ARRAY_SIZE(wires_conf); i++)
+					ts_dev->config_inp[i] = wires_conf[i];
+			}
+		}
+	}
+	return 0;
+
+error_ret:
+	return err;
+}
+
+static int titsc_parse_pdata(struct ti_tscadc_dev *tscadc_dev,
+					struct titsc *ts_dev)
+{
+	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
+
+	if (!pdata)
+		return -EINVAL;
+
+	ts_dev->wires = pdata->tsc_init->wires;
+	ts_dev->x_plate_resistance =
+		pdata->tsc_init->x_plate_resistance;
+	ts_dev->steps_to_configure =
+		pdata->tsc_init->steps_to_configure;
+	memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
+		sizeof(pdata->tsc_init->wire_config));
+	return 0;
+}
+
 /*
  * The functions for inserting/removing driver as a module.
  */
@@ -375,16 +445,8 @@ static int titsc_probe(struct platform_device *pdev)
 	struct titsc *ts_dev;
 	struct input_dev *input_dev;
 	struct ti_tscadc_dev *tscadc_dev = pdev->dev.platform_data;
-	struct mfd_tscadc_board	*pdata;
 	int err;
 
-	pdata = tscadc_dev->dev->platform_data;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "Could not find platform data\n");
-		return -EINVAL;
-	}
-
 	/* Allocate memory for device */
 	ts_dev = kzalloc(sizeof(struct titsc), GFP_KERNEL);
 	input_dev = input_allocate_device();
@@ -398,11 +460,17 @@ static int titsc_probe(struct platform_device *pdev)
 	ts_dev->mfd_tscadc = tscadc_dev;
 	ts_dev->input = input_dev;
 	ts_dev->irq = tscadc_dev->irq;
-	ts_dev->wires = pdata->tsc_init->wires;
-	ts_dev->x_plate_resistance = pdata->tsc_init->x_plate_resistance;
-	ts_dev->steps_to_configure = pdata->tsc_init->steps_to_configure;
-	memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
-			sizeof(pdata->tsc_init->wire_config));
+
+	if (tscadc_dev->dev->platform_data)
+		err = titsc_parse_pdata(tscadc_dev, ts_dev);
+	else
+		err = titsc_parse_dt(tscadc_dev, ts_dev);
+
+	if (err) {
+		dev_err(&pdev->dev, "Could not find platform data\n");
+		err = -EINVAL;
+		goto err_free_mem;
+	}
 
 	err = request_irq(ts_dev->irq, titsc_irq,
 			  0, pdev->dev.driver->name, ts_dev);
-- 
1.7.9.5
