From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] PM / wakeirq: report a wakeup_event on dedicated wekup irq
Date: Mon, 13 Feb 2017 12:43:22 -0800
Message-ID: <20170213204322.27588-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

There are two reasons for reporting wakeup event when dedicated wakeup
IRQ is triggered:

- wakeup events accounting, so proper statistical data will be
  displayed in sysfs and debugfs;

- there are small window when System is entering suspend during which
  dedicated wakeup IRQ can be lost:

dpm_suspend_noirq()
  |- device_wakeup_arm_wake_irqs()
      |- dev_pm_arm_wake_irq(X)
         |- IRQ is enabled and marked as wakeup source
[1]...
  |- suspend_device_irqs()
     |- suspend_device_irq(X)
	|- irqd_set(X, IRQD_WAKEUP_ARMED);
	   |- wakup IRQ armed

The wakeup IRQ can be lost if it's triggered at point [1]
and not armed yet.

Hence, fix above cases by adding simple pm_wakeup_event() call in
handle_threaded_wake_irq().

Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ
handling")
Cc: Brian Norris <briannorris@chromium.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Tested-by: Keerthy <j-keerthy@ti.com>
[tony@atomide.com: added missing return to avoid warnings]
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/wakeirq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -141,6 +141,13 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
 	struct wake_irq *wirq = _wirq;
 	int res;
 
+	/* Maybe abort suspend? */
+	if (irqd_is_wakeup_set(irq_get_irq_data(irq))) {
+		pm_wakeup_event(wirq->dev, 0);
+
+		return IRQ_HANDLED;
+	}
+
 	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
 	res = pm_runtime_resume(wirq->dev);
 	if (res < 0)
-- 
2.11.1
