From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by returning EPROBE_DEFER
Date: Sat, 28 Jul 2018 18:59:14 +0200
Message-ID: <20180728165914.15871-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, j-keerthy@ti.com, tony@atomide.com, linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

I got this in the kernel log:
[    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
[    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22

the probe function has to wait until omap_dm_timer_probe() in
clocksource/timer-ti-dm.c has initialized pdata, so defer probing

Fixes: b7290cf6ff78 (pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops)
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/pwm/pwm-omap-dmtimer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 665da3c8fbce..808835179c2e 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -264,8 +264,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
 	if (!timer_pdata) {
-		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
-		ret = -EINVAL;
+		ret = -EPROBE_DEFER;
 		goto put;
 	}
 
-- 
2.11.0
