From: Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 1/2] mfd: twl6030: fix lockdep recursion warning on setting wake IRQs
Date: Mon, 26 Sep 2011 16:44:23 -0700
Message-ID: <1317080664-28096-1-git-send-email-toddpoynor@google.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:61118 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab1IZXoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 19:44:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Todd Poynor <toddpoynor@google.com>

LOCKDEP explicitly sets all irq_desc locks as a single lock-class,
causing "possible recursive locking detected" when the TWL RTC
driver calls through enable_irq_wake to twl6030_irq_set_wake,
which recursively calls irq_set_irq_wake.  Although the
irq_desc and lock are different, LOCKDEP treats these as
equivalent, presumably due to problems that can be incurred
when locking more than one irq_desc, so best to avoid this.

Suspend/resume actions implemented as PM notifiers to avoid
touch the TWL core for this.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---

This patch applies on top of the patch from Santosh:
[PATCH] mfd: twl6030: Setup irq_wake infrastructure.

If PM notifiers aren't preferred then could change
twl-core to add suspend/resume callbacks, was trying to
make a lower-impact change.

This complexity assumes there are systems that include twl6030
and don't want its IRQs to act as wakeup.  Alternatively,
could just always enable wake for twl6030's IRQ.

 drivers/mfd/twl6030-irq.c |   46 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 4477134..7d6553c 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -37,6 +37,7 @@
 #include <linux/kthread.h>
 #include <linux/i2c/twl.h>
 #include <linux/platform_device.h>
+#include <linux/suspend.h>
 
 #include "twl-core.h"
 
@@ -83,8 +84,42 @@ static int twl6030_interrupt_mapping[24] = {
 /*----------------------------------------------------------------------*/
 
 static unsigned twl6030_irq_base;
+static int twl_irq;
+static bool twl_irq_wake_enabled;
 
 static struct completion irq_event;
+static atomic_t twl6030_wakeirqs = ATOMIC_INIT(0);
+
+static int twl6030_irq_pm_notifier(struct notifier_block *notifier,
+				   unsigned long pm_event, void *unused)
+{
+	int chained_wakeups;
+
+	switch (pm_event) {
+	case PM_SUSPEND_PREPARE:
+		chained_wakeups = atomic_read(&twl6030_wakeirqs);
+
+		if (chained_wakeups && !twl_irq_wake_enabled) {
+			if (enable_irq_wake(twl_irq))
+				pr_err("twl6030 IRQ wake enable failed\n");
+			else
+				twl_irq_wake_enabled = true;
+		} else if (!chained_wakeups && twl_irq_wake_enabled) {
+			disable_irq_wake(twl_irq);
+			twl_irq_wake_enabled = false;
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block twl6030_irq_pm_notifier_block = {
+	.notifier_call = twl6030_irq_pm_notifier,
+};
 
 /*
  * This thread processes interrupts reported by the Primary Interrupt Handler.
@@ -189,9 +224,12 @@ static inline void activate_irq(int irq)
 
 int twl6030_irq_set_wake(struct irq_data *d, unsigned int on)
 {
-	int twl_irq = (int)irq_get_chip_data(d->irq);
+	if (on)
+		atomic_inc(&twl6030_wakeirqs);
+	else
+		atomic_dec(&twl6030_wakeirqs);
 
-	return irq_set_irq_wake(twl_irq, on);
+	return 0;
 }
 
 /*----------------------------------------------------------------------*/
@@ -353,6 +391,9 @@ int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 		pr_err("twl6030: could not claim irq%d: %d\n", irq_num, status);
 		goto fail_irq;
 	}
+
+	twl_irq = irq_num;
+	register_pm_notifier(&twl6030_irq_pm_notifier_block);
 	return status;
 fail_irq:
 	free_irq(irq_num, &irq_event);
@@ -365,6 +406,7 @@ fail_kthread:
 
 int twl6030_exit_irq(void)
 {
+	unregister_pm_notifier(&twl6030_irq_pm_notifier_block);
 
 	if (twl6030_irq_base) {
 		pr_err("twl6030: can't yet clean up IRQs?\n");
-- 
1.7.3.1

