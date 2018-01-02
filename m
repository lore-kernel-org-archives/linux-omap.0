From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v6 07/10] clocksource: timer-dm: Hook device platform data if not already assigned
Date: Tue, 2 Jan 2018 15:39:56 +0530
Message-ID: <1514887799-24605-8-git-send-email-j-keerthy@ti.com>
References: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: ladis@linux-mips.org, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

From: Ladislav Michl <ladis@linux-mips.org>

In the case of device tree boot the device platform data is usually
NULL so hook the platform data obtained from the match.
As part of un-constify the platform_data pointer.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/clocksource/timer-dm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
index 1cbd954..60db173 100644
--- a/drivers/clocksource/timer-dm.c
+++ b/drivers/clocksource/timer-dm.c
@@ -806,14 +806,16 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	struct omap_dm_timer *timer;
 	struct resource *mem, *irq;
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
 	const struct dmtimer_platform_data *pdata;
 	int ret;
 
-	match = of_match_device(of_match_ptr(omap_timer_match), dev);
-	pdata = match ? match->data : dev->platform_data;
+	pdata = of_device_get_match_data(dev);
+	if (!pdata)
+		pdata = dev_get_platdata(dev);
+	else
+		dev->platform_data = (void *)pdata;
 
-	if (!pdata && !dev->of_node) {
+	if (!pdata) {
 		dev_err(dev, "%s: no platform data.\n", __func__);
 		return -ENODEV;
 	}
-- 
1.9.1
