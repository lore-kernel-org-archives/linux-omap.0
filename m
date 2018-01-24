From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v9 8/9] pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops
Date: Wed, 24 Jan 2018 16:49:24 +0530
Message-ID: <1516792764-2203-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi
Cc: j-keerthy@ti.com, Claudiu.Beznea@microchip.com, narmstrong@baylibre.com, linux-pwm@vger.kernel.org, ladis@linux-mips.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

Adapt driver to utilize dmtimer pdata ops instead of pdata-quirks.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
Changes in v9:

  * Reorganized the place where of_node_put was called.

Changes in v8:

  * Added of_node_put call in success case of probe.

Boot tested on am437x-gp-evm and dra7xx-evm.
Also compile tested omap1_defconfig with other patches of v7
posted here:

https://www.spinics.net/lists/linux-omap/msg141100.html

With v9 version of Patch 8/9.

 drivers/pwm/pwm-omap-dmtimer.c | 66 ++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 5ad42f3..aaf8d328 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -23,6 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/dmtimer-omap.h>
 #include <linux/platform_data/pwm_omap_dmtimer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -37,7 +38,7 @@ struct pwm_omap_dmtimer_chip {
 	struct pwm_chip chip;
 	struct mutex mutex;
 	pwm_omap_dmtimer *dm_timer;
-	struct pwm_omap_dmtimer_pdata *pdata;
+	struct omap_dm_timer_ops *pdata;
 	struct platform_device *dm_timer_pdev;
 };
 
@@ -242,19 +243,35 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *timer;
+	struct platform_device *timer_pdev;
 	struct pwm_omap_dmtimer_chip *omap;
-	struct pwm_omap_dmtimer_pdata *pdata;
+	struct dmtimer_platform_data *timer_pdata;
+	struct omap_dm_timer_ops *pdata;
 	pwm_omap_dmtimer *dm_timer;
 	u32 v;
-	int status;
+	int ret = 0;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "Missing dmtimer platform data\n");
-		return -EINVAL;
+	timer = of_parse_phandle(np, "ti,timers", 0);
+	if (!timer)
+		return -ENODEV;
+
+	timer_pdev = of_find_device_by_node(timer);
+	if (!timer_pdev) {
+		dev_err(&pdev->dev, "Unable to find Timer pdev\n");
+		ret = -ENODEV;
+		goto put;
 	}
 
-	if (!pdata->request_by_node ||
+	timer_pdata = dev_get_platdata(&timer_pdev->dev);
+	if (!timer_pdata) {
+		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
+		ret = -EINVAL;
+		goto put;
+	}
+
+	pdata = timer_pdata->timer_ops;
+
+	if (!pdata || !pdata->request_by_node ||
 	    !pdata->free ||
 	    !pdata->enable ||
 	    !pdata->disable ||
@@ -267,21 +284,26 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	    !pdata->set_prescaler ||
 	    !pdata->write_counter) {
 		dev_err(&pdev->dev, "Incomplete dmtimer pdata structure\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put;
 	}
 
-	timer = of_parse_phandle(np, "ti,timers", 0);
-	if (!timer)
-		return -ENODEV;
-
 	if (!of_get_property(timer, "ti,timer-pwm", NULL)) {
 		dev_err(&pdev->dev, "Missing ti,timer-pwm capability\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto put;
 	}
 
 	dm_timer = pdata->request_by_node(timer);
-	if (!dm_timer)
-		return -EPROBE_DEFER;
+	if (!dm_timer) {
+		ret = -EPROBE_DEFER;
+		goto put;
+	}
+
+put:
+	of_node_put(timer);
+	if (ret < 0)
+		return ret;
 
 	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
 	if (!omap) {
@@ -291,13 +313,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	omap->pdata = pdata;
 	omap->dm_timer = dm_timer;
-
-	omap->dm_timer_pdev = of_find_device_by_node(timer);
-	if (!omap->dm_timer_pdev) {
-		dev_err(&pdev->dev, "Unable to find timer pdev\n");
-		omap->pdata->free(dm_timer);
-		return -EINVAL;
-	}
+	omap->dm_timer_pdev = timer_pdev;
 
 	/*
 	 * Ensure that the timer is stopped before we allow PWM core to call
@@ -322,8 +338,8 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	mutex_init(&omap->mutex);
 
-	status = pwmchip_add(&omap->chip);
-	if (status < 0) {
+	ret = pwmchip_add(&omap->chip);
+	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM\n");
 		omap->pdata->free(omap->dm_timer);
 		return status;
-- 
1.9.1
