From: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/5] mfd: twl: use mfd_add_devices for TWL6032 regulator
Date: Sat, 26 Nov 2016 20:13:26 +0200
Message-ID: <20161126181326.14951-6-Nicolae_Rosia@mentor.com>
References: <20161126181326.14951-1-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161126181326.14951-1-Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

TWL6032 regulator driver uses the drvdata twl_priv pointer.
In order to avoid accessing an invalid drvdata
when the driver gets unbinded, make sure we remove the
child devices before deleting the drvdata.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/mfd/twl-core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 409b836..1e94364 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -43,6 +43,7 @@
 #include <linux/of_platform.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/mfd/core.h>
 
 #include <linux/regulator/machine.h>
 
@@ -155,8 +156,16 @@ int twl4030_init_irq(struct device *dev, int irq_num);
 int twl4030_exit_irq(void);
 int twl4030_init_chip_irq(const char *chip);
 
+
 static struct twlcore *twl_priv;
 
+static struct mfd_cell twl6032_devs[] = {
+	{
+		.name = "twl6032-regulator",
+		.of_compatible = "ti,twl6032-regulator",
+	},
+};
+
 static struct twl_mapping twl4030_map[] = {
 	/*
 	 * NOTE:  don't change this table without updating the
@@ -665,6 +674,8 @@ static int twl_remove(struct i2c_client *client)
 	unsigned i, num_slaves;
 	int status;
 
+	mfd_remove_devices(&client->dev);
+
 	if (twl_class_is_4030())
 		status = twl4030_exit_irq();
 	else
@@ -834,6 +845,17 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 				 TWL4030_DCDC_GLOBAL_CFG);
 	}
 
+	if (id->driver_data & TWL6032_SUBCLASS) {
+		status = mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
+					 twl6032_devs, ARRAY_SIZE(twl6032_devs),
+					 NULL, 0, NULL);
+		if (status != 0) {
+			dev_err(&client->dev, "failed to add mfd devices: %d\n",
+				status);
+			goto fail;
+		}
+	}
+
 fail:
 	if (status < 0)
 		twl_remove(client);
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
