From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 5/7] clocksource: dmtimer: Populate the timer ops to the pdata
Date: Tue, 31 Oct 2017 15:58:44 +0530
Message-ID: <1509445726-21040-6-git-send-email-j-keerthy@ti.com>
References: <1509445726-21040-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1509445726-21040-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Add the timer ops to the platform data

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/clocksource/dmtimer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/dmtimer.c b/drivers/clocksource/dmtimer.c
index afe1dc9..1cbd954 100644
--- a/drivers/clocksource/dmtimer.c
+++ b/drivers/clocksource/dmtimer.c
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
