From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] PM / wakeirq: Fix dedicated wakeirq for drivers not using autosuspend
Date: Mon,  5 Dec 2016 16:38:16 -0800
Message-ID: <20161206003816.22696-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I noticed some wakeirq flakeyness with consumer drivers not using
autosuspend. For drivers not using autosuspend, the wakeirq may never
get unmasked in rpm_suspend() because of irq desc->depth.

We are configuring dedicated wakeirqs to start with IRQ_NOAUTOEN as we
naturally don't want them running until rpm_suspend() is called.

However, when a consumer driver initially calls pm_runtime_get, we now
wrongly start with disable_irq_nosync() call on the dedicated wakeirq
that is disabled to start with.

This causes desc->depth to toggle between 1 and 2 instead of the usual
0 and 1. This can prevent enable_irq() from unmasking the wakeirq as
that only happens at desc->depth 1.

This does not necessarily show up with drivers using autosuspend as
there is time for disable_irq_nosync() before rpm_suspend() gets called
after the autosuspend timeout.

Let's fix the issue by adding wirq->status that lazily gets set on
the first rpm_suspend(). We also need PM runtime core private functions
for dev_pm_enable_wake_irq_check() and dev_pm_disable_wake_irq_check()
so we can enable the dedicated wakeirq on the first rpm_suspend().

While at it, let's also fix the comments for dev_pm_enable_wake_irq()
and dev_pm_disable_wake_irq(). Those can still be used by the consumer
drivers as needed because the irq core manages the interrupt usecount
for us.

Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ
handling")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/power.h   | 19 ++++++++++-
 drivers/base/power/runtime.c |  8 ++---
 drivers/base/power/wakeirq.c | 76 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 88 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -21,14 +21,22 @@ extern void pm_runtime_init(struct device *dev);
 extern void pm_runtime_reinit(struct device *dev);
 extern void pm_runtime_remove(struct device *dev);
 
+#define WAKE_IRQ_DEDICATED_ALLOCATED	BIT(0)
+#define WAKE_IRQ_DEDICATED_MANAGED	BIT(1)
+#define WAKE_IRQ_DEDICATED_MASK		(WAKE_IRQ_DEDICATED_ALLOCATED | \
+					 WAKE_IRQ_DEDICATED_MANAGED)
+
 struct wake_irq {
 	struct device *dev;
+	unsigned int status;
 	int irq;
-	bool dedicated_irq:1;
 };
 
 extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
+extern void dev_pm_enable_wake_irq_check(struct device *dev,
+					 bool can_change_status);
+extern void dev_pm_disable_wake_irq_check(struct device *dev);
 
 #ifdef CONFIG_PM_SLEEP
 
@@ -104,6 +112,15 @@ static inline void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 {
 }
 
+static inline void dev_pm_enable_wake_irq_check(struct device *dev,
+						bool can_change_status)
+{
+}
+
+static inline void dev_pm_disable_wake_irq_check(struct device *dev)
+{
+}
+
 #endif
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -592,7 +592,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
-	dev_pm_enable_wake_irq(dev);
+	dev_pm_enable_wake_irq_check(dev, true);
 	retval = rpm_callback(callback, dev);
 	if (retval)
 		goto fail;
@@ -631,7 +631,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	return retval;
 
  fail:
-	dev_pm_disable_wake_irq(dev);
+	dev_pm_disable_wake_irq_check(dev);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -814,12 +814,12 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
-	dev_pm_disable_wake_irq(dev);
+	dev_pm_disable_wake_irq_check(dev);
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);
 		pm_runtime_cancel_pending(dev);
-		dev_pm_enable_wake_irq(dev);
+		dev_pm_enable_wake_irq_check(dev, false);
 	} else {
  no_callback:
 		__update_runtime_status(dev, RPM_ACTIVE);
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -110,8 +110,10 @@ void dev_pm_clear_wake_irq(struct device *dev)
 	dev->power.wakeirq = NULL;
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
-	if (wirq->dedicated_irq)
+	if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED) {
 		free_irq(wirq->irq, wirq);
+		wirq->status &= ~WAKE_IRQ_DEDICATED_MASK;
+	}
 	kfree(wirq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
@@ -181,7 +183,6 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 
 	wirq->dev = dev;
 	wirq->irq = irq;
-	wirq->dedicated_irq = true;
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 
 	/*
@@ -197,6 +198,8 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	if (err)
 		goto err_free_irq;
 
+	wirq->status = WAKE_IRQ_DEDICATED_ALLOCATED;
+
 	return err;
 
 err_free_irq:
@@ -212,9 +215,9 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
  * dev_pm_enable_wake_irq - Enable device wake-up interrupt
  * @dev: Device
  *
- * Called from the bus code or the device driver for
- * runtime_suspend() to enable the wake-up interrupt while
- * the device is running.
+ * Optionally called from the bus code or the device driver for
+ * runtime_resume() to override the PM runtime core managed wake-up
+ * interrupt handling to enable the wake-up interrupt.
  *
  * Note that for runtime_suspend()) the wake-up interrupts
  * should be unconditionally enabled unlike for suspend()
@@ -224,7 +227,7 @@ void dev_pm_enable_wake_irq(struct device *dev)
 {
 	struct wake_irq *wirq = dev->power.wakeirq;
 
-	if (wirq && wirq->dedicated_irq)
+	if (wirq && (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED))
 		enable_irq(wirq->irq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_enable_wake_irq);
@@ -233,20 +236,73 @@ EXPORT_SYMBOL_GPL(dev_pm_enable_wake_irq);
  * dev_pm_disable_wake_irq - Disable device wake-up interrupt
  * @dev: Device
  *
- * Called from the bus code or the device driver for
- * runtime_resume() to disable the wake-up interrupt while
- * the device is running.
+ * Optionally called from the bus code or the device driver for
+ * runtime_suspend() to override the PM runtime core managed wake-up
+ * interrupt handling to disable the wake-up interrupt.
  */
 void dev_pm_disable_wake_irq(struct device *dev)
 {
 	struct wake_irq *wirq = dev->power.wakeirq;
 
-	if (wirq && wirq->dedicated_irq)
+	if (wirq && (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED))
 		disable_irq_nosync(wirq->irq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
 
 /**
+ * dev_pm_enable_wake_irq_check - Checks and enables wake-up interrupt
+ * @dev: Device
+ * @can_change_status: Can change wake-up interrupt status
+ *
+ * Enables wakeirq conditionally. We need to enable wake-up interrupt
+ * lazily on the first rpm_suspend(). This is needed as the consumer device
+ * starts in RPM_SUSPENDED state, and the the first pm_runtime_get() would
+ * otherwise try to disable already disabled wakeirq. The wake-up interrupt
+ * starts disabled with IRQ_NOAUTOEN set.
+ *
+ * Should be only called from rpm_suspend() and rpm_resume() path.
+ * Caller must hold &dev->power.lock to change wirq->status
+ */
+void dev_pm_enable_wake_irq_check(struct device *dev,
+				  bool can_change_status)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+
+	if (!wirq || !((wirq->status & WAKE_IRQ_DEDICATED_MASK)))
+		return;
+
+	if (likely(wirq->status & WAKE_IRQ_DEDICATED_MANAGED)) {
+		goto enable;
+	} else if (can_change_status) {
+		wirq->status |= WAKE_IRQ_DEDICATED_MANAGED;
+		goto enable;
+	}
+
+	return;
+
+enable:
+	enable_irq(wirq->irq);
+}
+
+/**
+ * dev_pm_disable_wake_irq_check - Checks and disables wake-up interrupt
+ * @dev: Device
+ *
+ * Disables wake-up interrupt conditionally based on status.
+ * Should be only called from rpm_suspend() and rpm_resume() path.
+ */
+void dev_pm_disable_wake_irq_check(struct device *dev)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+
+	if (!wirq || !((wirq->status & WAKE_IRQ_DEDICATED_MASK)))
+		return;
+
+	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
+		disable_irq_nosync(wirq->irq);
+}
+
+/**
  * dev_pm_arm_wake_irq - Arm device wake-up
  * @wirq: Device wake-up interrupt
  *
-- 
2.11.0
