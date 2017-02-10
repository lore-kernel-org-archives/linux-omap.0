From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] PM / wakeirq: Enable dedicated wakeirq for suspend
Date: Fri, 10 Feb 2017 14:25:00 -0800
Message-ID: <20170210222501.7948-2-tony@atomide.com>
References: <20170210222501.7948-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170210222501.7948-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

We currently rely on runtime PM to enable dedicated wakeirq for suspend.
This assumption fails in the following two cases:

1. If the consumer driver does not have runtime PM implemented, the
   dedicated wakeirq never gets enabled for suspend

2. If the consumer driver has runtime PM implemented, but does not idle
   in suspend

Let's fix the issue by always enabling the dedicated wakeirq during
suspend.

Depends-on: bed570307ed7 ("PM / wakeirq: Fix dedicated wakeirq for
drivers not using autosuspend")
Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ
handling")
Cc: Brian Norris <briannorris@chromium.org>
Cc: Tero Kristo <t-kristo@ti.com>
Reported-by: Keerthy <j-keerthy@ti.com>
Tested-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
[tony@atomide.com: updated based on bed570307ed7, added description]
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/wakeirq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -312,8 +312,12 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 	if (!wirq)
 		return;
 
-	if (device_may_wakeup(wirq->dev))
+	if (device_may_wakeup(wirq->dev)) {
+		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+			enable_irq(wirq->irq);
+
 		enable_irq_wake(wirq->irq);
+	}
 }
 
 /**
@@ -328,6 +332,10 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 	if (!wirq)
 		return;
 
-	if (device_may_wakeup(wirq->dev))
+	if (device_may_wakeup(wirq->dev)) {
 		disable_irq_wake(wirq->irq);
+
+		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+			disable_irq_nosync(wirq->irq);
+	}
 }
-- 
2.11.1
