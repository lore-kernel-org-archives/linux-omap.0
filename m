From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v6 4/6] gpio: tps65218-gpio: Add platform_device_id table
Date: Tue, 28 Jun 2016 18:00:52 +0530
Message-ID: <1467117054-12943-5-git-send-email-j-keerthy@ti.com>
References: <1467117054-12943-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467117054-12943-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

platform_device_id table is needed for adding the tps65218-gpio
module to the mfd_cell array.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---

Changes in v4:

  * Retained the compatible strings in order to interrogate the DT in the
    normal way.

 drivers/gpio/gpio-tps65218.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index 0f9d9bd..0961f3a 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -231,6 +231,12 @@ static const struct of_device_id tps65218_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tps65218_dt_match);
 
+static const struct platform_device_id tps65218_gpio_id_table[] = {
+	{ "tps65218-gpio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, tps65218_gpio_id_table);
+
 static struct platform_driver tps65218_gpio_driver = {
 	.driver = {
 		.name = "tps65218-gpio",
@@ -238,6 +244,7 @@ static struct platform_driver tps65218_gpio_driver = {
 	},
 	.probe = tps65218_gpio_probe,
 	.remove = tps65218_gpio_remove,
+	.id_table = tps65218_gpio_id_table,
 };
 
 module_platform_driver(tps65218_gpio_driver);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
