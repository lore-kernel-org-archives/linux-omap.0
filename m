From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] PM / wakeirq: Fix spurious wake-up events for dedicated wakeirqs
Date: Fri, 10 Feb 2017 14:25:01 -0800
Message-ID: <20170210222501.7948-3-tony@atomide.com>
References: <20170210222501.7948-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170210222501.7948-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

Dedicated wakeirq is a one time event to wake-up the system from
low-power state and then call pm_runtime_resume() on the device wired
with the dedicated wakeirq.

Sometimes dedicated wakeirqs can get deferred if they trigger after we
call disable_irq_nosync() in dev_pm_disable_wake_irq(). This can happen
if pm_runtime_get() is called around the same time a wakeirq fires.

If an interrupt fires after disable_irq_nosync(), by default it will get
tagged with IRQS_PENDING and will run later on when the interrupt is
enabled again.

Deferred wakeirqs usually just produce pointless wake-up events. But they
can also cause suspend to fail if the deferred wakeirq fires during
dpm_suspend_noirq() for example. So we really don't want to see the
deferred wakeirqs triggering after the device has resumed.

Let's fix the issue by setting IRQ_DISABLE_UNLAZY flag for the dedicated
wakeirqs. The other option would be to implement irq_disable() in the
dedicated wakeirq controller, but that's not a generic solution.

For reference below is what happens with a IRQ_TYPE_EDGE_BOTH IRQ
type wakeirq:

- resume by dedicated IRQ (EDGE_FALLING)
 - suspend_enter()
  ....
 - arch_suspend_enable_irqs()
   |- dedicated IRQ armed and fired
   |- irq_pm_check_wakeup()
      |- disarm, disable IRQ and mark as IRQS_PENDING
  ....
 - dpm_resume_noirq()
   |- resume_device_irqs()
      |- __enable_irq()
         |- check_irq_resend()
            |- handle_threaded_wake_irq()
 	       |- dedicated IRQ processed
   |- device_wakeup_disarm_wake_irqs()
      |- disable_irq_wake()
  ....
 !-> dedicated IRQ (EDGE_RISING)
     -| handle_edge_irq()
        |- IRQ disabled: mask_ack_irq and mark as IRQS_PENDING
  ....
- subsequent suspend
  ....
  |- dpm_suspend_noirq()
     |- device_wakeup_arm_wake_irqs()
        |- __enable_irq()
           |- check_irq_resend()
(a)           |- handle_threaded_wake_irq()
                 |- pm_wakeup_event() --> abort suspend
  ....
     |- suspend_device_irqs()
        |- suspend_device_irq()
           |-  dedicated IRQ armed
  ....
(b)  |- resend_irqs
        |- irq_pm_check_wakeup()
           |- IRQ armed -> abort suspend

because of pending IRQ System suspend can be aborted at points
(a)-not armed or (b)-armed.

Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ
handling")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
[tony@atomide.com: added a comment, updated the description]
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/wakeirq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -183,6 +183,9 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	wirq->irq = irq;
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 
+	/* Prevent deferred spurious wakeirqs with disable_irq_nosync() */
+	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
+
 	/*
 	 * Consumer device may need to power up and restore state
 	 * so we use a threaded irq.
-- 
2.11.1
