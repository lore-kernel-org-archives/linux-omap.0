From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC PATCH 4/4] timer-ti-dm: Fix omap_dm_timer_of_set_source()
Date: Mon, 16 Jul 2018 22:39:02 +0200
Message-ID: <1531773542-15736-5-git-send-email-narmstrong@baylibre.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, daniel.lezcano@linaro.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, aford173@gmail.com, drivshin@awxrd.com
List-Id: linux-omap@vger.kernel.org

With the move to clocksource, the omap_dm_timer_of_set_source() broke
because the "fclk" clock is now defined in the DT.
The omap_dm_timer_of_set_source() was using the first clock declared in the
timer node, but now this clock must be named as "src" and clk_get() use
"src" as clock name to permit specifiying the parent clock of the timer "fclk".

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clocksource/timer-ti-dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4cce6b2..868bc78 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -150,7 +150,7 @@ static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
 	if (!timer->fclk)
 		return -ENODEV;
 
-	parent = clk_get(&timer->pdev->dev, NULL);
+	parent = clk_get(&timer->pdev->dev, "src");
 	if (IS_ERR(parent))
 		return -ENODEV;
 
-- 
2.7.4
