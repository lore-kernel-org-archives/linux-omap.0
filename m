From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v6 06/10] clocksource: dmtimer: Populate the timer ops to the pdata
Date: Tue, 2 Jan 2018 15:39:55 +0530
Message-ID: <1514887799-24605-7-git-send-email-j-keerthy@ti.com>
References: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: ladis@linux-mips.org, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Add the timer ops to the platform data

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Ladislav Michl <ladis@linux-mips.org>
---
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
