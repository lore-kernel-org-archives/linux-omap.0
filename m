From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v4 7/8] pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops
Date: Fri, 1 Dec 2017 10:46:36 +0530
Message-ID: <1512105397-2544-8-git-send-email-j-keerthy@ti.com>
References: <1512105397-2544-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512105397-2544-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: t-kristo@ti.com, linux@armlinux.org.uk, grygorii.strashko@ti.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, ladis@linux-mips.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Adapt driver to utilize dmtimer pdata ops instead of pdata-quirks.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v4:

  * Switched to dev_get_platdata.

Changes in v3:

  * Used of_find_platdata_by_node function to fetch platform
    data for timer node.

 drivers/pwm/pwm-omap-dmtimer.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 5ad42f3..3b27aff 100644
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
 
@@ -242,19 +243,33 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
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
 	int status;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "Missing dmtimer platform data\n");
+	timer = of_parse_phandle(np, "ti,timers", 0);
+	if (!timer)
+		return -ENODEV;
+
+	timer_pdev = of_find_device_by_node(timer);
+	if (!timer_pdev) {
+		dev_err(&pdev->dev, "Unable to find Timer pdev\n");
+		return -ENODEV;
+	}
+
+	timer_pdata = dev_get_platdata(&timer_pdev->dev);
+	if (!timer_pdata) {
+		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
 		return -EINVAL;
 	}
 
-	if (!pdata->request_by_node ||
+	pdata = timer_pdata->timer_ops;
+
+	if (!pdata || !pdata->request_by_node ||
 	    !pdata->free ||
 	    !pdata->enable ||
 	    !pdata->disable ||
@@ -270,10 +285,6 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	timer = of_parse_phandle(np, "ti,timers", 0);
-	if (!timer)
-		return -ENODEV;
-
 	if (!of_get_property(timer, "ti,timer-pwm", NULL)) {
 		dev_err(&pdev->dev, "Missing ti,timer-pwm capability\n");
 		return -ENODEV;
@@ -291,13 +302,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
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
-- 
1.9.1
