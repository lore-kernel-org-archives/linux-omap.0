From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt
 handlers
Date: Fri, 19 Nov 2010 10:45:48 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011191044400.1344-100000@iolanthe.rowland.org>
References: <201010062347.18232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43217 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751324Ab0KSPpt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 10:45:49 -0500
In-Reply-To: <201010062347.18232.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

This patch (as1431b) makes the synchronous runtime-PM interface
suitable for use in interrupt handlers.  Subsystems can call the new
pm_runtime_irq_safe() function to tell the PM core that a device's
runtime-PM callbacks should be invoked with interrupts disabled
(runtime_suspend and runtime_resume callbacks will be invoked with the
spinlock held as well).  This permits the pm_runtime_get_sync() and
pm_runtime_put_sync() routines to be called from within interrupt
handlers.

When a device is declared irq-safe in this way, the PM core increments
the parent's usage count, so the parent will never be runtime
suspended.  This prevents difficult situations in which an irq-safe
device can't resume because it is forced to wait for its non-irq-safe
parent.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/include/linux/pm.h
===================================================================
--- usb-2.6.orig/include/linux/pm.h
+++ usb-2.6/include/linux/pm.h
@@ -486,6 +486,7 @@ struct dev_pm_info {
 	unsigned int		run_wake:1;
 	unsigned int		runtime_auto:1;
 	unsigned int		no_callbacks:1;
+	unsigned int		irq_safe:1;
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	enum rpm_request	request;
Index: usb-2.6/include/linux/pm_runtime.h
===================================================================
--- usb-2.6.orig/include/linux/pm_runtime.h
+++ usb-2.6/include/linux/pm_runtime.h
@@ -40,6 +40,7 @@ extern int pm_generic_runtime_idle(struc
 extern int pm_generic_runtime_suspend(struct device *dev);
 extern int pm_generic_runtime_resume(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
+extern void pm_runtime_irq_safe(struct device *dev);
 extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
 extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
 extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
@@ -123,6 +124,7 @@ static inline int pm_generic_runtime_idl
 static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
 static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
 static inline void pm_runtime_no_callbacks(struct device *dev) {}
+static inline void pm_runtime_irq_safe(struct device *dev) {}
 
 static inline void pm_runtime_mark_last_busy(struct device *dev) {}
 static inline void __pm_runtime_use_autosuspend(struct device *dev,
Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -223,11 +223,19 @@ static int rpm_idle(struct device *dev, 
 		callback = NULL;
 
 	if (callback) {
-		spin_unlock_irq(&dev->power.lock);
+		if (dev->power.irq_safe) {
+			spin_unlock(&dev->power.lock);
 
-		callback(dev);
+			callback(dev);
 
-		spin_lock_irq(&dev->power.lock);
+			spin_lock(&dev->power.lock);
+		} else {
+			spin_unlock_irq(&dev->power.lock);
+
+			callback(dev);
+
+			spin_lock_irq(&dev->power.lock);
+		}
 	}
 
 	dev->power.idle_notification = false;
@@ -250,13 +258,16 @@ static int rpm_callback(int (*cb)(struct
 	if (!cb)
 		return -ENOSYS;
 
-	spin_unlock_irq(&dev->power.lock);
+	if (dev->power.irq_safe) {
+		retval = cb(dev);
+	} else {
+		spin_unlock_irq(&dev->power.lock);
 
-	retval = cb(dev);
+		retval = cb(dev);
 
-	spin_lock_irq(&dev->power.lock);
+		spin_lock_irq(&dev->power.lock);
+	}
 	dev->power.runtime_error = retval;
-
 	return retval;
 }
 
@@ -404,7 +415,7 @@ static int rpm_suspend(struct device *de
 		goto out;
 	}
 
-	if (parent && !parent->power.ignore_children) {
+	if (parent && !parent->power.ignore_children && !dev->power.irq_safe) {
 		spin_unlock_irq(&dev->power.lock);
 
 		pm_request_idle(parent);
@@ -527,10 +538,13 @@ static int rpm_resume(struct device *dev
 
 	if (!parent && dev->parent) {
 		/*
-		 * Increment the parent's resume counter and resume it if
-		 * necessary.
+		 * Increment the parent's usage counter and resume it if
+		 * necessary.  Not needed if dev is irq-safe; then the
+		 * parent is permanently resumed.
 		 */
 		parent = dev->parent;
+		if (dev->power.irq_safe)
+			goto skip_parent;
 		spin_unlock(&dev->power.lock);
 
 		pm_runtime_get_noresume(parent);
@@ -553,6 +567,7 @@ static int rpm_resume(struct device *dev
 			goto out;
 		goto repeat;
 	}
+ skip_parent:
 
 	if (dev->power.no_callbacks)
 		goto no_callback;	/* Assume success. */
@@ -584,7 +599,7 @@ static int rpm_resume(struct device *dev
 		rpm_idle(dev, RPM_ASYNC);
 
  out:
-	if (parent) {
+	if (parent && !dev->power.irq_safe) {
 		spin_unlock_irq(&dev->power.lock);
 
 		pm_runtime_put(parent);
@@ -1065,7 +1080,6 @@ EXPORT_SYMBOL_GPL(pm_runtime_allow);
  * Set the power.no_callbacks flag, which tells the PM core that this
  * device is power-managed through its parent and has no run-time PM
  * callbacks of its own.  The run-time sysfs attributes will be removed.
- *
  */
 void pm_runtime_no_callbacks(struct device *dev)
 {
@@ -1078,6 +1092,28 @@ void pm_runtime_no_callbacks(struct devi
 EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);
 
 /**
+ * pm_runtime_irq_safe - Leave interrupts disabled during callbacks.
+ * @dev: Device to handle
+ *
+ * Set the power.irq_safe flag, which tells the PM core that the
+ * ->runtime_suspend() and ->runtime_resume() callbacks for this device should
+ * always be invoked with the spinlock held, and all three callbacks should
+ * always be invoked with interrupts disabled.  It also causes the parent's
+ * usage counter to be permanently incremented, preventing the parent from
+ * runtime suspending -- otherwise an irq-safe child might have to wait for a
+ * non-irq-safe parent.
+ */
+void pm_runtime_irq_safe(struct device *dev)
+{
+	if (dev->parent)
+		pm_runtime_get_sync(dev->parent);
+	spin_lock_irq(&dev->power.lock);
+	dev->power.irq_safe = 1;
+	spin_unlock_irq(&dev->power.lock);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_irq_safe);
+
+/**
  * update_autosuspend - Handle a change to a device's autosuspend settings.
  * @dev: Device to handle.
  * @old_delay: The former autosuspend_delay value.
@@ -1199,4 +1235,6 @@ void pm_runtime_remove(struct device *de
 	/* Change the status back to 'suspended' to match the initial status. */
 	if (dev->power.runtime_status == RPM_ACTIVE)
 		pm_runtime_set_suspended(dev);
+	if (dev->power.irq_safe && dev->parent)
+		pm_runtime_put_sync(dev->parent);
 }
Index: usb-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- usb-2.6.orig/Documentation/power/runtime_pm.txt
+++ usb-2.6/Documentation/power/runtime_pm.txt
@@ -50,6 +50,13 @@ type's callbacks are not defined) of giv
 and device class callbacks are referred to as subsystem-level callbacks in what
 follows.
 
+By default, the callbacks are always invoked in process context with interrupts
+enabled.  However subsystems can use the pm_runtime_irq_safe() helper function
+to tell the PM core that a device's callbacks should always be invoked with
+interrupts disabled.  This implies that the callback routines must not block
+or sleep, but it also means that the synchronous helper functions listed at the
+end of Section 4 can be used from within an interrupt handler.
+
 The subsystem-level suspend callback is _entirely_ _responsible_ for handling
 the suspend of the device as appropriate, which may, but need not include
 executing the device driver's own ->runtime_suspend() callback (from the
@@ -237,6 +244,11 @@ defined in include/linux/pm.h:
       Section 8); it may be modified only by the pm_runtime_no_callbacks()
       helper function
 
+  unsigned int irq_safe;
+    - indicates that the runtime-PM callbacks should be invoked with interrupts
+      disabled; the ->runtime_suspend() and ->runtime_resume() callbacks will
+      be made with the spinlock held as well
+
   unsigned int use_autosuspend;
     - indicates that the device's driver supports delayed autosuspend (see
       Section 9); it may be modified only by the
@@ -397,6 +409,10 @@ drivers/base/power/runtime.c and include
       PM attributes from /sys/devices/.../power (or prevent them from being
       added when the device is registered)
 
+  void pm_runtime_irq_safe(struct device *dev);
+    - set the power.irq_safe flag for the device, causing the runtime-PM
+      callbacks to be invoked with interrupts disabled
+
   void pm_runtime_mark_last_busy(struct device *dev);
     - set the power.last_busy field to the current time
 
@@ -438,6 +454,16 @@ pm_runtime_suspended()
 pm_runtime_mark_last_busy()
 pm_runtime_autosuspend_expiration()
 
+If pm_runtime_irq_safe() has been called for a device then the following helper
+functions may also be called in interrupt context:
+
+pm_runtime_idle()
+pm_runtime_suspend()
+pm_runtime_autosuspend()
+pm_runtime_resume()
+pm_runtime_get_sync()
+pm_runtime_put_sync()
+
 5. Run-time PM Initialization, Device Probing and Removal
 
 Initially, the run-time PM is disabled for all devices, which means that the

