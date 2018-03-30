From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 03/10] mfd: ti-lmu: use managed resource for everything
Date: Fri, 30 Mar 2018 19:24:07 +0200
Message-ID: <20180330172414.26575-4-sebastian.reichel@collabora.co.uk>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

This replaces all remaining unmanaged resources with device
managed ones, so that the remove function is no longer needed.
This makes the code slightly shorter and fixes two problems:

1. The hardware is disabled after the child devices have
   been removed. Previously there was a potential race
   condition.
2. The hardware is disabled when mfd_add_devices fails
   during probe.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/mfd/ti-lmu.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index e14cb9f41b44..2ee09d099832 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -47,8 +47,9 @@ static int ti_lmu_enable_hw(struct ti_lmu *lmu, enum ti_lmu_id id)
 	return 0;
 }
 
-static void ti_lmu_disable_hw(struct ti_lmu *lmu)
+static void ti_lmu_disable_hw(void *data)
 {
+	struct ti_lmu *lmu = data;
 	if (lmu->en_gpio)
 		gpiod_set_value(lmu->en_gpio, 0);
 }
@@ -205,6 +206,10 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, ti_lmu_disable_hw, lmu);
+	if (ret)
+		return ret;
+
 	/*
 	 * Fault circuit(open/short) can be detected by ti-lmu-fault-monitor.
 	 * After fault detection is done, some devices should re-initialize
@@ -214,17 +219,8 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 
 	i2c_set_clientdata(cl, lmu);
 
-	return mfd_add_devices(lmu->dev, 0, data->cells,
-			       data->num_cells, NULL, 0, NULL);
-}
-
-static int ti_lmu_remove(struct i2c_client *cl)
-{
-	struct ti_lmu *lmu = i2c_get_clientdata(cl);
-
-	ti_lmu_disable_hw(lmu);
-	mfd_remove_devices(lmu->dev);
-	return 0;
+	return devm_mfd_add_devices(lmu->dev, 0, data->cells,
+				    data->num_cells, NULL, 0, NULL);
 }
 
 static const struct i2c_device_id ti_lmu_ids[] = {
@@ -240,7 +236,6 @@ MODULE_DEVICE_TABLE(i2c, ti_lmu_ids);
 
 static struct i2c_driver ti_lmu_driver = {
 	.probe = ti_lmu_probe,
-	.remove = ti_lmu_remove,
 	.driver = {
 		.name = "ti-lmu",
 		.of_match_table = ti_lmu_of_match,
-- 
2.16.2
