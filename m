From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add synchronous runtime interface for
	interrupt handlers
Date: Fri, 1 Oct 2010 00:02:19 +0200
Message-ID: <201010010002.19204.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009301420520.1314-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009301420520.1314-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday, September 30, 2010, Alan Stern wrote:
> This patch (as1431) adds a synchronous runtime-PM interface suitable
> for use in interrupt handlers.  Four new helper functions are defined:
> 
> 	pm_runtime_suspend_irq(), pm_runtime_resume_irq(),
> 	pm_runtime_get_sync_irq(), pm_runtime_put_sync_irq(),
> 
> together with pm_runtime_callbacks_in_irq(), which subsystems use to
> tell the PM core that the runtime callbacks should be invoked with
> interrupts disabled.

BTW, I like some changes made by your patch that aren't really related to
the issue at hand, so I think the patch below can be applied regardless of
the other changes, unless I made a mistake I can see now.

Thanks,
Rafael


---
 drivers/base/power/runtime.c |  123 +++++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 72 deletions(-)

Index: linux-2.6/drivers/base/power/runtime.c
===================================================================
--- linux-2.6.orig/drivers/base/power/runtime.c
+++ linux-2.6/drivers/base/power/runtime.c
@@ -153,6 +153,27 @@ static int rpm_check_suspend_allowed(str
 	return retval;
 }
 
+/**
+ * rpm_callback - Run a given runtime PM callback for a given device.
+ * @cb: Runtime PM callback to run.
+ * @dev: Device to run the callback for.
+ */
+static int rpm_callback(int (*cb)(struct device *), struct device *dev)
+	__releases(&dev->power.lock) __acquires(&dev->power.lock)
+{
+	int retval;
+
+	if (!cb)
+		return -ENOSYS;
+
+	spin_unlock_irq(&dev->power.lock);
+
+	retval = cb(dev);
+
+	spin_lock_irq(&dev->power.lock);
+
+	return retval;
+}
 
 /**
  * rpm_idle - Notify device bus type if the device can be suspended.
@@ -167,8 +188,8 @@ static int rpm_check_suspend_allowed(str
  * This function must be called under dev->power.lock with interrupts disabled.
  */
 static int rpm_idle(struct device *dev, int rpmflags)
-	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
+	int (*callback)(struct device *);
 	int retval;
 
 	retval = rpm_check_suspend_allowed(dev);
@@ -214,26 +235,16 @@ static int rpm_idle(struct device *dev, 
 
 	dev->power.idle_notification = true;
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
-
-		dev->bus->pm->runtime_idle(dev);
-
-		spin_lock_irq(&dev->power.lock);
-	} else if (dev->type && dev->type->pm && dev->type->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
-
-		dev->type->pm->runtime_idle(dev);
-
-		spin_lock_irq(&dev->power.lock);
-	} else if (dev->class && dev->class->pm
-	    && dev->class->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle)
+		callback = dev->bus->pm->runtime_idle;
+	else if (dev->type && dev->type->pm && dev->type->pm->runtime_idle)
+		callback = dev->type->pm->runtime_idle;
+	else if (dev->class && dev->class->pm)
+		callback = dev->class->pm->runtime_idle;
+	else
+		callback = NULL;
 
-		dev->class->pm->runtime_idle(dev);
-
-		spin_lock_irq(&dev->power.lock);
-	}
+	rpm_callback(callback, dev);
 
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -261,6 +272,7 @@ static int rpm_idle(struct device *dev, 
 static int rpm_suspend(struct device *dev, int rpmflags)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
+	int (*callback)(struct device *);
 	struct device *parent = NULL;
 	bool notify = false;
 	int retval;
@@ -351,33 +363,16 @@ static int rpm_suspend(struct device *de
 
 	__update_runtime_status(dev, RPM_SUSPENDING);
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->bus->pm->runtime_suspend(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->type && dev->type->pm
-	    && dev->type->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->type->pm->runtime_suspend(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->class && dev->class->pm
-	    && dev->class->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->class->pm->runtime_suspend(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else {
-		retval = -ENOSYS;
-	}
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
+		callback = dev->bus->pm->runtime_suspend;
+	else if (dev->type && dev->type->pm && dev->type->pm->runtime_suspend)
+		callback = dev->type->pm->runtime_suspend;
+	else if (dev->class && dev->class->pm)
+		callback = dev->class->pm->runtime_suspend;
+	else
+		callback = NULL;
 
+	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_ACTIVE);
 		dev->power.deferred_resume = 0;
@@ -443,6 +438,7 @@ static int rpm_suspend(struct device *de
 static int rpm_resume(struct device *dev, int rpmflags)
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
+	int (*callback)(struct device *);
 	struct device *parent = NULL;
 	int retval = 0;
 
@@ -563,33 +559,16 @@ static int rpm_resume(struct device *dev
 
 	__update_runtime_status(dev, RPM_RESUMING);
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->bus->pm->runtime_resume(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->type && dev->type->pm
-	    && dev->type->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->type->pm->runtime_resume(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->class && dev->class->pm
-	    && dev->class->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->class->pm->runtime_resume(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else {
-		retval = -ENOSYS;
-	}
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
+		callback = dev->bus->pm->runtime_resume;
+	else if (dev->type && dev->type->pm && dev->type->pm->runtime_resume)
+		callback = dev->type->pm->runtime_resume;
+	else if (dev->class && dev->class->pm)
+		callback = dev->class->pm->runtime_resume;
+	else
+		callback = NULL;
 
+	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);
 		pm_runtime_cancel_pending(dev);
