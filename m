From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH v2 1/3] serial: mctrl_gpio: restrict MCTRL initialization
Date: Mon, 31 Jul 2017 09:13:21 +0200
Message-ID: <1501485203-13185-2-git-send-email-yegorslists@googlemail.com>
References: <1501485203-13185-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501485203-13185-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julia.lawall-L2FTfq7BK8M@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

GPIOs specified for serial port can be used either as GPIO driven MCTRL
or as a wakeup-source. Use the latter property to abort the MCTRL
initialization.

Return -ENOSYS as this would just skip mctrl initialization in the
case of wakeup source usage and not disable the port completely due to
failed serial8250_register_8250_port().

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index d2da6aa..dce661c 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/gpio/consumer.h>
 #include <linux/termios.h>
+#include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/module.h>
 
@@ -118,6 +119,9 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
 	struct mctrl_gpios *gpios;
 	enum mctrl_gpio_idx i;
 
+	if (device_property_present(dev, "wakeup-source"))
+		return ERR_PTR(-ENOSYS);
+
 	gpios = devm_kzalloc(dev, sizeof(*gpios), GFP_KERNEL);
 	if (!gpios)
 		return ERR_PTR(-ENOMEM);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
