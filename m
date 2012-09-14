From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 3/4] lis3: lis3lv02d_i2c: Add lis3lv02d device tree init
Date: Fri, 14 Sep 2012 13:36:55 +0530
Message-ID: <1347610016-10123-4-git-send-email-anilkumar@ti.com>
References: <1347610016-10123-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46292 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756468Ab2INIHn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 04:07:43 -0400
In-Reply-To: <1347610016-10123-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org, eric.piel@tremplin-utc.net, jic23@cam.ac.uk, greg@kroah.com, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com, dmitry.torokhov@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Add lis3lv02d device tree initialization code/API to take pdata
from device node. Also adds device tree init matching table
support to lis3lv02d_i2c driver. If the driver data is passed
from device tree, then this driver picks up platform data
from device node through common/generic lis3lv02d.c driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
index 15255eb..56b5124 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -31,6 +31,9 @@
 #include <linux/i2c.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
 #include "lis3lv02d.h"
 
 #define DRV_NAME	"lis3lv02d_i2c"
@@ -102,12 +105,27 @@ static int lis3_i2c_init(struct lis3lv02d *lis3)
 static union axis_conversion lis3lv02d_axis_map =
 	{ .as_array = { LIS3_DEV_X, LIS3_DEV_Y, LIS3_DEV_Z } };
 
+static struct of_device_id lis3lv02d_i2c_dt_ids[] = {
+	{ .compatible = "st,lis3lv02d-i2c" },
+	{ .compatible = "st,lis331dlh-i2c" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lis3lv02d_i2c_dt_ids);
+
 static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	int ret = 0;
 	struct lis3lv02d_platform_data *pdata = client->dev.platform_data;
 
+	if (of_match_device(lis3lv02d_i2c_dt_ids, &client->dev)) {
+		lis3_dev.of_node = client->dev.of_node;
+		ret = lis3lv02d_init_dt(&lis3_dev);
+		if (ret)
+			return ret;
+		pdata = lis3_dev.pdata;
+	}
+
 	if (pdata) {
 		if ((pdata->driver_features & LIS3_USE_BLOCK_READ) &&
 			(i2c_check_functionality(client->adapter,
@@ -255,6 +273,7 @@ static struct i2c_driver lis3lv02d_i2c_driver = {
 		.name   = DRV_NAME,
 		.owner  = THIS_MODULE,
 		.pm     = &lis3_pm_ops,
+		.of_match_table = of_match_ptr(lis3lv02d_i2c_dt_ids),
 	},
 	.probe	= lis3lv02d_i2c_probe,
 	.remove	= __devexit_p(lis3lv02d_i2c_remove),
-- 
1.7.9.5

