From: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 10/13] extcon: extcon-gpio: add devicetree support
Date: Mon, 14 Apr 2014 13:46:21 +0200
Message-ID: <1397475984-28001-11-git-send-email-r.baldyga@samsung.com>
References: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1397475984-28001-1-git-send-email-r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rongjun.ying-kQvG35nSl+M@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch modifies extcon-gpio driver to use initialization data from
devicetree if platform data is not available. It allows to set controller
and cable names, and another parameters from devicetree bindings.

Signed-off-by: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/extcon/extcon-gpio.c       |   70 +++++++++++++++++++++++++++++++-----
 include/linux/extcon/extcon-gpio.h |    2 +-
 2 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/extcon/extcon-gpio.c b/drivers/extcon/extcon-gpio.c
index fc90b7a..ef05bcb 100644
--- a/drivers/extcon/extcon-gpio.c
+++ b/drivers/extcon/extcon-gpio.c
@@ -28,6 +28,8 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/extcon.h>
 #include <linux/extcon/extcon-gpio.h>
 
@@ -53,7 +55,7 @@ static void gpio_extcon_work(struct work_struct *work)
 	state = gpio_get_value(data->gpio);
 	if (data->gpio_active_low)
 		state = !state;
-	extcon_set_state(&data->edev, state);
+	extcon_set_cable_state_(&data->edev, 0, state);
 }
 
 static irqreturn_t gpio_irq_handler(int irq, void *dev_id)
@@ -70,7 +72,7 @@ static ssize_t extcon_gpio_print_state(struct extcon_dev *edev, char *buf)
 	struct gpio_extcon_data	*extcon_data =
 		container_of(edev, struct gpio_extcon_data, edev);
 	const char *state;
-	if (extcon_get_state(edev))
+	if (extcon_get_cable_state_(edev, 0))
 		state = extcon_data->state_on;
 	else
 		state = extcon_data->state_off;
@@ -80,17 +82,57 @@ static ssize_t extcon_gpio_print_state(struct extcon_dev *edev, char *buf)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_OF
+static struct gpio_extcon_platform_data *get_pdata_from_dt(struct device *dev)
+{
+	int ret;
+	struct gpio_extcon_platform_data *pdata =
+				devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+
+	ret = of_property_read_string_index(dev->of_node,
+				"gpio-controller-name", 0, &pdata->name);
+	if (ret)
+		return NULL;
+
+	ret = of_property_read_string_index(dev->of_node,
+				"gpio-cable-name", 0, &pdata->cable_name);
+	if (ret)
+		return NULL;
+
+	ret = of_property_read_u32_array(dev->of_node,
+				"gpio-debounce", &pdata->debounce, 0);
+	if (ret)
+		pdata->debounce = 0;
+
+	pdata->gpio = of_get_gpio(dev->of_node, 0);
+	if (pdata->gpio < 0)
+		return NULL;
+
+	pdata->gpio_active_low = of_property_read_bool(dev->of_node,
+					"gpio-active-low");
+
+	pdata->check_on_resume = of_property_read_bool(dev->of_node,
+					"check-on-resume");
+	return pdata;
+}
+#else
+static struct gpio_extcon_platform_data *get_pdata_from_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 static int gpio_extcon_probe(struct platform_device *pdev)
 {
 	struct gpio_extcon_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct gpio_extcon_data *extcon_data;
+	const char *gpio_extcon_cable[2];
 	int ret;
 
-	if (!pdata)
-		return -EBUSY;
-	if (!pdata->irq_flags) {
-		dev_err(&pdev->dev, "IRQ flag is not specified.\n");
-		return -EINVAL;
+	if (!pdata) {
+		pdata = get_pdata_from_dt(&pdev->dev);
+		if (!pdata)
+			return -EINVAL;
 	}
 
 	extcon_data = devm_kzalloc(&pdev->dev, sizeof(struct gpio_extcon_data),
@@ -98,10 +140,14 @@ static int gpio_extcon_probe(struct platform_device *pdev)
 	if (!extcon_data)
 		return -ENOMEM;
 
+	gpio_extcon_cable[0] = pdata->cable_name;
+	gpio_extcon_cable[1] = NULL;
+
 	extcon_data->edev.name = pdata->name;
 	extcon_data->edev.dev.parent = &pdev->dev;
 	extcon_data->edev.node = pdev->dev.of_node;
 	extcon_data->gpio = pdata->gpio;
+	extcon_data->edev.supported_cable = gpio_extcon_cable;
 	extcon_data->gpio_active_low = pdata->gpio_active_low;
 	extcon_data->state_on = pdata->state_on;
 	extcon_data->state_off = pdata->state_off;
@@ -135,8 +181,8 @@ static int gpio_extcon_probe(struct platform_device *pdev)
 	}
 
 	ret = request_any_context_irq(extcon_data->irq, gpio_irq_handler,
-				      pdata->irq_flags, pdev->name,
-				      extcon_data);
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			pdev->name, extcon_data);
 	if (ret < 0)
 		goto err;
 
@@ -177,6 +223,11 @@ static int gpio_extcon_resume(struct device *dev)
 }
 #endif
 
+static struct of_device_id of_gpio_match_tbl[] = {
+	{ .compatible = "extcon-gpio", },
+	{ /* end */ },
+};
+
 static SIMPLE_DEV_PM_OPS(gpio_extcon_pm_ops, NULL, gpio_extcon_resume);
 
 static struct platform_driver gpio_extcon_driver = {
@@ -184,6 +235,7 @@ static struct platform_driver gpio_extcon_driver = {
 	.remove		= gpio_extcon_remove,
 	.driver		= {
 		.name	= "extcon-gpio",
+		.of_match_table = of_gpio_match_tbl,
 		.owner	= THIS_MODULE,
 		.pm	= &gpio_extcon_pm_ops,
 	},
diff --git a/include/linux/extcon/extcon-gpio.h b/include/linux/extcon/extcon-gpio.h
index 8900fdf..3850588 100644
--- a/include/linux/extcon/extcon-gpio.h
+++ b/include/linux/extcon/extcon-gpio.h
@@ -43,10 +43,10 @@
  */
 struct gpio_extcon_platform_data {
 	const char *name;
+	const char *cable_name;
 	unsigned gpio;
 	bool gpio_active_low;
 	unsigned long debounce;
-	unsigned long irq_flags;
 
 	/* if NULL, "0" or "1" will be printed */
 	const char *state_on;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
