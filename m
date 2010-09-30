From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: add synchronous runtime interface for interrupt handlers
Date: Thu, 30 Sep 2010 14:25:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009301420520.1314-100000@iolanthe.rowland.org>
References: <201009282019.07598.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37052 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755836Ab0I3SZn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 14:25:43 -0400
In-Reply-To: <201009282019.07598.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

This patch (as1431) adds a synchronous runtime-PM interface suitable
for use in interrupt handlers.  Four new helper functions are defined:

	pm_runtime_suspend_irq(), pm_runtime_resume_irq(),
	pm_runtime_get_sync_irq(), pm_runtime_put_sync_irq(),

together with pm_runtime_callbacks_in_irq(), which subsystems use to
tell the PM core that the runtime callbacks should be invoked with
interrupts disabled.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

In the end it turned out that a new RPM_IRQ call flag was needed along
with the callbacks_in_irq flag in dev_pm_info.  The latter is required
for the reasons I explained before, and RPM_IRQ tells the core whether
or not it must leave interrupts disabled while waiting for a concurrent
state change.

Kevin, this should be good enough to satisfy all your needs.  How does 
it look?

Alan Stern


Index: usb-2.6/include/linux/pm.h
===================================================================
--- usb-2.6.orig/include/linux/pm.h
+++ usb-2.6/include/linux/pm.h
@@ -485,6 +485,7 @@ struct dev_pm_info {
 	unsigned int		run_wake:1;
 	unsigned int		runtime_auto:1;
 	unsigned int		no_callbacks:1;
+	unsigned int		callbacks_in_irq:1;
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	enum rpm_request	request;
Index: usb-2.6/include/linux/pm_runtime.h
===================================================================
--- usb-2.6.orig/include/linux/pm_runtime.h
+++ usb-2.6/include/linux/pm_runtime.h
@@ -21,6 +21,7 @@
 #define RPM_GET_PUT		0x04	/* Increment/decrement the
 					    usage_count */
 #define RPM_AUTO		0x08	/* Use autosuspend_delay */
+#define RPM_IRQ			0x10	/* Don't enable interrupts */
 
 #ifdef CONFIG_PM_RUNTIME
 
@@ -40,6 +41,7 @@ extern int pm_generic_runtime_idle(struc
 extern int pm_generic_runtime_suspend(struct device *dev);
 extern int pm_generic_runtime_resume(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
+extern void pm_runtime_callbacks_in_irq(struct device *dev);
 extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
 extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
 extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
@@ -123,6 +125,7 @@ static inline int pm_generic_runtime_idl
 static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
 static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
 static inline void pm_runtime_no_callbacks(struct device *dev) {}
+static inline void pm_runtime_callbacks_in_irq(struct device *dev) {}
 
 static inline void pm_runtime_mark_last_busy(struct device *dev) {}
 static inline void __pm_runtime_use_autosuspend(struct device *dev,
@@ -144,6 +147,11 @@ static inline int pm_runtime_suspend(str
 	return __pm_runtime_suspend(dev, 0);
 }
 
+static inline int pm_runtime_suspend_irq(struct device *dev)
+{
+	return __pm_runtime_suspend(dev, RPM_IRQ);
+}
+
 static inline int pm_runtime_autosuspend(struct device *dev)
 {
 	return __pm_runtime_suspend(dev, RPM_AUTO);
@@ -154,6 +162,11 @@ static inline int pm_runtime_resume(stru
 	return __pm_runtime_resume(dev, 0);
 }
 
+static inline int pm_runtime_resume_irq(struct device *dev)
+{
+	return __pm_runtime_resume(dev, RPM_IRQ);
+}
+
 static inline int pm_request_idle(struct device *dev)
 {
 	return __pm_runtime_idle(dev, RPM_ASYNC);
@@ -179,6 +192,11 @@ static inline int pm_runtime_get_sync(st
 	return __pm_runtime_resume(dev, RPM_GET_PUT);
 }
 
+static inline int pm_runtime_get_sync_irq(struct device *dev)
+{
+	return __pm_runtime_resume(dev, RPM_GET_PUT | RPM_IRQ);
+}
+
 static inline int pm_runtime_put(struct device *dev)
 {
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
@@ -195,6 +213,11 @@ static inline int pm_runtime_put_sync(st
 	return __pm_runtime_idle(dev, RPM_GET_PUT);
 }
 
+static inline int pm_runtime_put_sync_irq(struct device *dev)
+{
+	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_IRQ);
+}
+
 static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
 {
 	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_AUTO);
Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -170,10 +170,13 @@ static int rpm_idle(struct device *dev, 
 	__releases(&dev->power.lock) __acquires(&dev->power.lock)
 {
 	int retval;
+	int (*func)(struct device *dev);
 
 	retval = rpm_check_suspend_allowed(dev);
 	if (retval < 0)
 		;	/* Conditions are wrong. */
+	else if ((rpmflags & RPM_IRQ) && !dev->power.callbacks_in_irq)
+		retval = -EWOULDBLOCK;
 
 	/* Idle notifications are allowed only in the RPM_ACTIVE state. */
 	else if (dev->power.runtime_status != RPM_ACTIVE)
@@ -214,25 +217,27 @@ static int rpm_idle(struct device *dev, 
 
 	dev->power.idle_notification = true;
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
-
-		dev->bus->pm->runtime_idle(dev);
-
-		spin_lock_irq(&dev->power.lock);
-	} else if (dev->type && dev->type->pm && dev->type->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
+	func = NULL;
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle)
+		func = dev->bus->pm->runtime_idle;
+	else if (dev->type && dev->type->pm && dev->type->pm->runtime_idle)
+		func = dev->type->pm->runtime_idle;
+	else if (dev->class && dev->class->pm && dev->class->pm->runtime_idle)
+		func = dev->class->pm->runtime_idle;
+	if (func) {
+		if (dev->power.callbacks_in_irq) {
+			spin_unlock(&dev->power.lock);
 
-		dev->type->pm->runtime_idle(dev);
+			func(dev);
 
-		spin_lock_irq(&dev->power.lock);
-	} else if (dev->class && dev->class->pm
-	    && dev->class->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
+			spin_lock(&dev->power.lock);
+		} else {
+			spin_unlock_irq(&dev->power.lock);
 
-		dev->class->pm->runtime_idle(dev);
+			func(dev);
 
-		spin_lock_irq(&dev->power.lock);
+			spin_lock_irq(&dev->power.lock);
+		}
 	}
 
 	dev->power.idle_notification = false;
@@ -264,6 +269,7 @@ static int rpm_suspend(struct device *de
 	struct device *parent = NULL;
 	bool notify = false;
 	int retval;
+	int (*func)(struct device *dev);
 
 	dev_dbg(dev, "%s flags 0x%x\n", __func__, rpmflags);
 
@@ -272,6 +278,8 @@ static int rpm_suspend(struct device *de
 
 	if (retval < 0)
 		;	/* Conditions are wrong. */
+	else if ((rpmflags & RPM_IRQ) && !dev->power.callbacks_in_irq)
+		retval = -EWOULDBLOCK;
 
 	/* Synchronous suspends are not allowed in the RPM_RESUMING state. */
 	else if (dev->power.runtime_status == RPM_RESUMING &&
@@ -310,27 +318,35 @@ static int rpm_suspend(struct device *de
 	pm_runtime_cancel_pending(dev);
 
 	if (dev->power.runtime_status == RPM_SUSPENDING) {
-		DEFINE_WAIT(wait);
-
 		if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
 			retval = -EINPROGRESS;
 			goto out;
 		}
 
 		/* Wait for the other suspend running in parallel with us. */
-		for (;;) {
-			prepare_to_wait(&dev->power.wait_queue, &wait,
-					TASK_UNINTERRUPTIBLE);
-			if (dev->power.runtime_status != RPM_SUSPENDING)
-				break;
+		if (rpmflags & RPM_IRQ) {
+			spin_unlock(&dev->power.lock);
+
+			while (dev->power.runtime_status == RPM_SUSPENDING)
+				cpu_relax();
+
+			spin_lock(&dev->power.lock);
+		} else {
+			DEFINE_WAIT(wait);
 
 			spin_unlock_irq(&dev->power.lock);
 
-			schedule();
+			for (;;) {
+				prepare_to_wait(&dev->power.wait_queue, &wait,
+				    TASK_UNINTERRUPTIBLE);
+				if (dev->power.runtime_status != RPM_SUSPENDING)
+					break;
+				schedule();
+			}
+			finish_wait(&dev->power.wait_queue, &wait);
 
 			spin_lock_irq(&dev->power.lock);
 		}
-		finish_wait(&dev->power.wait_queue, &wait);
 		goto repeat;
 	}
 
@@ -351,28 +367,28 @@ static int rpm_suspend(struct device *de
 
 	__update_runtime_status(dev, RPM_SUSPENDING);
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->bus->pm->runtime_suspend(dev);
+	func = NULL;
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
+		func = dev->bus->pm->runtime_suspend;
+	else if (dev->type && dev->type->pm && dev->type->pm->runtime_suspend)
+		func = dev->type->pm->runtime_suspend;
+	else if (dev->class && dev->class->pm &&
+	    dev->class->pm->runtime_suspend)
+		func = dev->class->pm->runtime_suspend;
+	if (func) {
+		if (dev->power.callbacks_in_irq) {
+			spin_unlock(&dev->power.lock);
 
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->type && dev->type->pm
-	    && dev->type->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
+			retval = func(dev);
 
-		retval = dev->type->pm->runtime_suspend(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->class && dev->class->pm
-	    && dev->class->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
+			spin_lock(&dev->power.lock);
+		} else {
+			spin_unlock_irq(&dev->power.lock);
 
-		retval = dev->class->pm->runtime_suspend(dev);
+			retval = func(dev);
 
-		spin_lock_irq(&dev->power.lock);
+			spin_lock_irq(&dev->power.lock);
+		}
 		dev->power.runtime_error = retval;
 	} else {
 		retval = -ENOSYS;
@@ -401,20 +417,20 @@ static int rpm_suspend(struct device *de
 	wake_up_all(&dev->power.wait_queue);
 
 	if (dev->power.deferred_resume) {
-		rpm_resume(dev, 0);
+		rpm_resume(dev, rpmflags);
 		retval = -EAGAIN;
 		goto out;
 	}
 
 	if (notify)
-		rpm_idle(dev, 0);
+		rpm_idle(dev, rpmflags);
 
 	if (parent && !parent->power.ignore_children) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock(&dev->power.lock);
 
 		pm_request_idle(parent);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock(&dev->power.lock);
 	}
 
  out:
@@ -445,6 +461,7 @@ static int rpm_resume(struct device *dev
 {
 	struct device *parent = NULL;
 	int retval = 0;
+	int (*func)(struct device *dev);
 
 	dev_dbg(dev, "%s flags 0x%x\n", __func__, rpmflags);
 
@@ -453,6 +470,8 @@ static int rpm_resume(struct device *dev
 		retval = -EINVAL;
 	else if (dev->power.disable_depth > 0)
 		retval = -EAGAIN;
+	else if ((rpmflags & RPM_IRQ) && !dev->power.callbacks_in_irq)
+		retval = -EWOULDBLOCK;
 	if (retval)
 		goto out;
 
@@ -473,8 +492,6 @@ static int rpm_resume(struct device *dev
 
 	if (dev->power.runtime_status == RPM_RESUMING
 	    || dev->power.runtime_status == RPM_SUSPENDING) {
-		DEFINE_WAIT(wait);
-
 		if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
 			if (dev->power.runtime_status == RPM_SUSPENDING)
 				dev->power.deferred_resume = true;
@@ -484,20 +501,31 @@ static int rpm_resume(struct device *dev
 		}
 
 		/* Wait for the operation carried out in parallel with us. */
-		for (;;) {
-			prepare_to_wait(&dev->power.wait_queue, &wait,
-					TASK_UNINTERRUPTIBLE);
-			if (dev->power.runtime_status != RPM_RESUMING
-			    && dev->power.runtime_status != RPM_SUSPENDING)
-				break;
+		if (rpmflags & RPM_IRQ) {
+			spin_unlock(&dev->power.lock);
+
+			while (dev->power.runtime_status == RPM_SUSPENDING
+			    || dev->power.runtime_status == RPM_RESUMING)
+				cpu_relax();
+
+			spin_lock(&dev->power.lock);
+		} else {
+			DEFINE_WAIT(wait);
 
 			spin_unlock_irq(&dev->power.lock);
 
-			schedule();
+			for (;;) {
+				prepare_to_wait(&dev->power.wait_queue, &wait,
+				    TASK_UNINTERRUPTIBLE);
+				if (dev->power.runtime_status != RPM_SUSPENDING
+				    && dev->power.runtime_status != RPM_RESUMING)
+					break;
+				schedule();
+			}
+			finish_wait(&dev->power.wait_queue, &wait);
 
 			spin_lock_irq(&dev->power.lock);
 		}
-		finish_wait(&dev->power.wait_queue, &wait);
 		goto repeat;
 	}
 
@@ -546,7 +574,7 @@ static int rpm_resume(struct device *dev
 		 */
 		if (!parent->power.disable_depth
 		    && !parent->power.ignore_children) {
-			rpm_resume(parent, 0);
+			rpm_resume(parent, rpmflags & ~RPM_NOWAIT);
 			if (parent->power.runtime_status != RPM_ACTIVE)
 				retval = -EBUSY;
 		}
@@ -563,28 +591,28 @@ static int rpm_resume(struct device *dev
 
 	__update_runtime_status(dev, RPM_RESUMING);
 
-	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
-
-		retval = dev->bus->pm->runtime_resume(dev);
+	func = NULL;
+	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
+		func = dev->bus->pm->runtime_resume;
+	else if (dev->type && dev->type->pm && dev->type->pm->runtime_resume)
+		func = dev->type->pm->runtime_resume;
+	else if (dev->class && dev->class->pm &&
+	    dev->class->pm->runtime_resume)
+		func = dev->class->pm->runtime_resume;
+	if (func) {
+		if (dev->power.callbacks_in_irq) {
+			spin_unlock(&dev->power.lock);
 
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->type && dev->type->pm
-	    && dev->type->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
+			retval = func(dev);
 
-		retval = dev->type->pm->runtime_resume(dev);
-
-		spin_lock_irq(&dev->power.lock);
-		dev->power.runtime_error = retval;
-	} else if (dev->class && dev->class->pm
-	    && dev->class->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
+			spin_lock(&dev->power.lock);
+		} else {
+			spin_unlock_irq(&dev->power.lock);
 
-		retval = dev->class->pm->runtime_resume(dev);
+			retval = func(dev);
 
-		spin_lock_irq(&dev->power.lock);
+			spin_lock_irq(&dev->power.lock);
+		}
 		dev->power.runtime_error = retval;
 	} else {
 		retval = -ENOSYS;
@@ -602,15 +630,15 @@ static int rpm_resume(struct device *dev
 	wake_up_all(&dev->power.wait_queue);
 
 	if (!retval)
-		rpm_idle(dev, RPM_ASYNC);
+		rpm_idle(dev, rpmflags | RPM_ASYNC);
 
  out:
 	if (parent) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock(&dev->power.lock);
 
 		pm_runtime_put(parent);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock(&dev->power.lock);
 	}
 
 	dev_dbg(dev, "%s returns %d\n", __func__, retval);
@@ -1086,7 +1114,6 @@ EXPORT_SYMBOL_GPL(pm_runtime_allow);
  * Set the power.no_callbacks flag, which tells the PM core that this
  * device is power-managed through its parent and has no run-time PM
  * callbacks of its own.  The run-time sysfs attributes will be removed.
- *
  */
 void pm_runtime_no_callbacks(struct device *dev)
 {
@@ -1099,6 +1126,22 @@ void pm_runtime_no_callbacks(struct devi
 EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);
 
 /**
+ * pm_runtime_callbacks_in_irq - Leave interrupts disabled during callbacks.
+ * @dev: Device to handle
+ *
+ * Set the power.callbacks_in_irq flag, which tells the PM core that the
+ * run-time PM callbacks for this device should always be invoked with
+ * interrupts disabled.
+ */
+void pm_runtime_callbacks_in_irq(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	dev->power.callbacks_in_irq = 1;
+	spin_unlock_irq(&dev->power.lock);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_callbacks_in_irq);
+
+/**
  * update_autosuspend - Handle a change to a device's autosuspend settings.
  * @dev: Device to handle.
  * @old_delay: The former autosuspend_delay value.
Index: usb-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- usb-2.6.orig/Documentation/power/runtime_pm.txt
+++ usb-2.6/Documentation/power/runtime_pm.txt
@@ -50,6 +50,18 @@ type's callbacks are not defined) of giv
 and device class callbacks are referred to as subsystem-level callbacks in what
 follows.
 
+By default, the callbacks are always invoked in process context with interrupts
+enabled.  However subsystems can tell the PM core that the callbacks for a
+device should be invoked with interrupts disabled, by calling
+pm_runtime_callbacks_in_irq().  This implies that the callback routines must
+not block or sleep, but it also means that the following synchronous helper
+functions can be used from within an interrupt handler:
+
+		pm_runtime_resume_irq(),
+		pm_runtime_suspend_irq(),
+		pm_runtime_get_sync_irq(),
+		pm_runtime_put_sync_irq().
+
 The subsystem-level suspend callback is _entirely_ _responsible_ for handling
 the suspend of the device as appropriate, which may, but need not include
 executing the device driver's own ->runtime_suspend() callback (from the
@@ -237,6 +249,10 @@ defined in include/linux/pm.h:
       Section 8); it may be modified only by the pm_runtime_no_callbacks()
       helper function
 
+  unsigned int callbacks_in_irq;
+    - indicates that the ->runtime_idle(), ->runtime_suspend(), and
+      ->runtime_resume() callbacks should be invoked with interrupts disabled.
+
   unsigned int use_autosuspend;
     - indicates that the device's driver supports delayed autosuspend (see
       Section 9); it may be modified only by the
@@ -285,6 +301,11 @@ drivers/base/power/runtime.c and include
       not yet expired then an autosuspend is scheduled for the appropriate time
       and 0 is returned
 
+  int pm_runtime_suspend_irq(struct device *dev);
+    - same as pm_runtime_suspend() except that this function may be called
+      in interrupt context; returns an error unless
+      pm_runtime_callbacks_in_irq(dev) was called previously
+
   int pm_runtime_resume(struct device *dev);
     - execute the subsystem-level resume callback for the device; returns 0 on
       success, 1 if the device's run-time PM status was already 'active' or
@@ -292,6 +313,11 @@ drivers/base/power/runtime.c and include
       resume the device again in future, but 'power.runtime_error' should be
       checked additionally
 
+  int pm_runtime_resume_irq(struct device *dev);
+    - same as pm_runtime_resume() except that this function may be called
+      in interrupt context; returns an error unless
+      pm_runtime_callbacks_in_irq(dev) was called previously
+
   int pm_request_idle(struct device *dev);
     - submit a request to execute the subsystem-level idle callback for the
       device (the request is represented by a work item in pm_wq); returns 0 on
@@ -329,6 +355,10 @@ drivers/base/power/runtime.c and include
     - increment the device's usage counter, run pm_runtime_resume(dev) and
       return its result
 
+  int pm_runtime_get_sync_irq(struct device *dev);
+    - increment the device's usage counter, run pm_runtime_resume_irq(dev) and
+      return its result
+
   void pm_runtime_put_noidle(struct device *dev);
     - decrement the device's usage counter
 
@@ -344,6 +374,10 @@ drivers/base/power/runtime.c and include
     - decrement the device's usage counter; if the result is 0 then run
       pm_runtime_idle(dev) and return its result
 
+  int pm_runtime_put_sync_irq(struct device *dev);
+    - decrement the device's usage counter; if the result is 0 then run
+      pm_runtime_idle(dev) and return its result
+
   int pm_runtime_put_sync_autosuspend(struct device *dev);
     - decrement the device's usage counter; if the result is 0 then run
       pm_runtime_autosuspend(dev) and return its result
@@ -397,6 +431,10 @@ drivers/base/power/runtime.c and include
       PM attributes from /sys/devices/.../power (or prevent them from being
       added when the device is registered)
 
+  void pm_runtime_callbacks_in_irq(struct device *dev);
+    - set the power.callbacks_in_irq flag for the device, causing all callbacks
+      to be invoked with interrupts disabled
+
   void pm_runtime_mark_last_busy(struct device *dev);
     - set the power.last_busy field to the current time
 
@@ -422,14 +460,18 @@ drivers/base/power/runtime.c and include
 It is safe to execute the following helper functions from interrupt context:
 
 pm_request_idle()
+pm_runtime_suspend_irq()
 pm_request_autosuspend()
 pm_schedule_suspend()
+pm_runtime_resume_irq()
 pm_request_resume()
 pm_runtime_get_noresume()
 pm_runtime_get()
+pm_runtime_get_sync_irq()
 pm_runtime_put_noidle()
 pm_runtime_put()
 pm_runtime_put_autosuspend()
+pm_runtime_put_sync_irq()
 pm_runtime_enable()
 pm_suspend_ignore_children()
 pm_runtime_set_active()

