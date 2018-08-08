From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for non-am43 SoCs
Date: Wed, 8 Aug 2018 18:44:59 +0530
Message-ID: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tglx@linutronix.de
Cc: lokeshvutla@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, baolin.wang@linaro.org, d-gerlach@ti.com, tony@atomide.com, grygorii.strashko@ti.com, j-keerthy@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
add the flag for all the other SoCs.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Keerthy <j-keerthy@ti.com> 
Acked-by: Tony Lindgren <tony@atomide.com>
---

Changes in v2:

  * Changed am43 compatible to more generic ti,am43 to cover epos boards.
  * Added Tony's Ack.

 drivers/clocksource/timer-ti-32k.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 29e2e1a..dd09171 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
 		return -ENXIO;
 	}
 
+	if (!of_machine_is_compatible("ti,am43"))
+		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
+
 	ti_32k_timer.counter = ti_32k_timer.base;
 
 	/*
-- 
1.9.1
