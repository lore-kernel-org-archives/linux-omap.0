From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v5 6/8] clocksource: dmtimer: Populate the timer ops to the pdata
Date: Tue, 12 Dec 2017 11:42:15 +0530
Message-ID: <1513059137-21593-7-git-send-email-j-keerthy@ti.com>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

Add the timer ops to the platform data

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---

Changes in v3:

  * Added Sebastian's Reviewed-by.

Changes in v2:

  * No code changes in this v2 version. Only enhanced patch
    statistics for renames.

 drivers/clocksource/timer-dm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
index afe1dc9..1cbd954 100644
--- a/drivers/clocksource/timer-dm.c
+++ b/drivers/clocksource/timer-dm.c
@@ -922,8 +922,33 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static struct omap_dm_timer_ops dmtimer_ops = {
+	.request_by_node = omap_dm_timer_request_by_node,
+	.request_specific = omap_dm_timer_request_specific,
+	.request = omap_dm_timer_request,
+	.set_source = omap_dm_timer_set_source,
+	.get_irq = omap_dm_timer_get_irq,
+	.set_int_enable = omap_dm_timer_set_int_enable,
+	.set_int_disable = omap_dm_timer_set_int_disable,
+	.free = omap_dm_timer_free,
+	.enable = omap_dm_timer_enable,
+	.disable = omap_dm_timer_disable,
+	.get_fclk = omap_dm_timer_get_fclk,
+	.start = omap_dm_timer_start,
+	.stop = omap_dm_timer_stop,
+	.set_load = omap_dm_timer_set_load,
+	.set_match = omap_dm_timer_set_match,
+	.set_pwm = omap_dm_timer_set_pwm,
+	.set_prescaler = omap_dm_timer_set_prescaler,
+	.read_counter = omap_dm_timer_read_counter,
+	.write_counter = omap_dm_timer_write_counter,
+	.read_status = omap_dm_timer_read_status,
+	.write_status = omap_dm_timer_write_status,
+};
+
 static const struct dmtimer_platform_data omap3plus_pdata = {
 	.timer_errata = OMAP_TIMER_ERRATA_I103_I767,
+	.timer_ops = &dmtimer_ops,
 };
 
 static const struct of_device_id omap_timer_match[] = {
-- 
1.9.1
