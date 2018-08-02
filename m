From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] clocksource: ti-32k: Remove CLOCK_SOURCE_SUSPEND_NONSTOP flag
Date: Thu, 2 Aug 2018 12:05:16 +0530
Message-ID: <1533191716-20476-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, baolin.wang@linaro.org, d-gerlach@ti.com, tony@atomide.com, grygorii.strashko@ti.com, j-keerthy@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

With the introduction of below commit:

commit 39232ed5a1793f67b11430c43ed8a9ed6e96c6eb

time: Introduce one suspend clocksource to compensate the suspend time

The suspend/resume fails on AM437x platforms as the source is not
a non-stop while trying to compensate time using this.

Hence remove the CLOCK_SOURCE_SUSPEND_NONSTOP flag.

Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/clocksource/timer-ti-32k.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 880a861..7368e8e 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -78,8 +78,7 @@ static u64 notrace ti_32k_read_cycles(struct clocksource *cs)
 		.rating		= 250,
 		.read		= ti_32k_read_cycles,
 		.mask		= CLOCKSOURCE_MASK(32),
-		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
-				CLOCK_SOURCE_SUSPEND_NONSTOP,
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS, 
 	},
 };
 
-- 
1.9.1
