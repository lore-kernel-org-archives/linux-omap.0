From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] PM: runtime PM + idle: allow usage when interrupts are disabled
Date: Tue, 10 Aug 2010 09:54:21 -0700
Message-ID: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:37976 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222Ab0HJQyY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 12:54:24 -0400
Received: by pxi10 with SMTP id 10so150638pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 09:54:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org

When using runtime PM in combination with CPUidle, the runtime PM
transtions of some devices may be triggered during the idle path.
Late in the idle sequence, interrupts will likely be disabled when
runtime PM for these devices is initiated.

Currently, the runtime PM core assumes methods are called with
interrupts enabled.  However, if it is called with interrupts
disabled, the internal locking unconditionally enables interrupts, for
example:

pm_runtime_put_sync()
    __pm_runtime_put()
        pm_runtime_idle()
            spin_lock_irq()
            __pm_runtime_idle()
                spin_unlock_irq()   <--- interrupts unconditionally enabled
                dev->bus->pm->runtime_idle()
                spin_lock_irq()
             spin_unlock_irq()

Unconditionally enabling interrupts late in the idle sequence is not
desired behavior.  To fix, use the save/restore versions of the
spinlock API.

Reported-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
RFC: I'm not crazy about having the 'flags' in struct dev_pm_info, but
since the locks are taken and released in separate functions, this
seems better than changing the function APIs to pass around the flags.

 drivers/base/power/runtime.c |   68 ++++++++++++++++++++++-------------------
 include/linux/pm.h           |    1 +
 2 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index b78c401..0caaef1 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -80,24 +80,24 @@ static int __pm_runtime_idle(struct device *dev)
 	dev->power.idle_notification = true;
 
 	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		dev->bus->pm->runtime_idle(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 	} else if (dev->type && dev->type->pm && dev->type->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		dev->type->pm->runtime_idle(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 	} else if (dev->class && dev->class->pm
 	    && dev->class->pm->runtime_idle) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		dev->class->pm->runtime_idle(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 	}
 
 	dev->power.idle_notification = false;
@@ -115,9 +115,9 @@ int pm_runtime_idle(struct device *dev)
 {
 	int retval;
 
-	spin_lock_irq(&dev->power.lock);
+	spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 	retval = __pm_runtime_idle(dev);
-	spin_unlock_irq(&dev->power.lock);
+	spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 	return retval;
 }
@@ -226,11 +226,13 @@ int __pm_runtime_suspend(struct device *dev, bool from_wq)
 			if (dev->power.runtime_status != RPM_SUSPENDING)
 				break;
 
-			spin_unlock_irq(&dev->power.lock);
+			spin_unlock_irqrestore(&dev->power.lock,
+					       dev->power.lock_flags);
 
 			schedule();
 
-			spin_lock_irq(&dev->power.lock);
+			spin_lock_irqsave(&dev->power.lock,
+					  dev->power.lock_flags);
 		}
 		finish_wait(&dev->power.wait_queue, &wait);
 		goto repeat;
@@ -240,27 +242,27 @@ int __pm_runtime_suspend(struct device *dev, bool from_wq)
 	dev->power.deferred_resume = false;
 
 	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		retval = dev->bus->pm->runtime_suspend(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 		dev->power.runtime_error = retval;
 	} else if (dev->type && dev->type->pm
 	    && dev->type->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		retval = dev->type->pm->runtime_suspend(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 		dev->power.runtime_error = retval;
 	} else if (dev->class && dev->class->pm
 	    && dev->class->pm->runtime_suspend) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		retval = dev->class->pm->runtime_suspend(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 		dev->power.runtime_error = retval;
 	} else {
 		retval = -ENOSYS;
@@ -296,11 +298,11 @@ int __pm_runtime_suspend(struct device *dev, bool from_wq)
 		__pm_runtime_idle(dev);
 
 	if (parent && !parent->power.ignore_children) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		pm_request_idle(parent);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 	}
 
  out:
@@ -317,9 +319,9 @@ int pm_runtime_suspend(struct device *dev)
 {
 	int retval;
 
-	spin_lock_irq(&dev->power.lock);
+	spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 	retval = __pm_runtime_suspend(dev, false);
-	spin_unlock_irq(&dev->power.lock);
+	spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 	return retval;
 }
@@ -381,11 +383,13 @@ int __pm_runtime_resume(struct device *dev, bool from_wq)
 			    && dev->power.runtime_status != RPM_SUSPENDING)
 				break;
 
-			spin_unlock_irq(&dev->power.lock);
+			spin_unlock_irqrestore(&dev->power.lock,
+					       dev->power.lock_flags);
 
 			schedule();
 
-			spin_lock_irq(&dev->power.lock);
+			spin_lock_irqsave(&dev->power.lock,
+					  dev->power.lock_flags);
 		}
 		finish_wait(&dev->power.wait_queue, &wait);
 		goto repeat;
@@ -423,27 +427,27 @@ int __pm_runtime_resume(struct device *dev, bool from_wq)
 	__update_runtime_status(dev, RPM_RESUMING);
 
 	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		retval = dev->bus->pm->runtime_resume(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 		dev->power.runtime_error = retval;
 	} else if (dev->type && dev->type->pm
 	    && dev->type->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		retval = dev->type->pm->runtime_resume(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 		dev->power.runtime_error = retval;
 	} else if (dev->class && dev->class->pm
 	    && dev->class->pm->runtime_resume) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		retval = dev->class->pm->runtime_resume(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 		dev->power.runtime_error = retval;
 	} else {
 		retval = -ENOSYS;
@@ -464,11 +468,11 @@ int __pm_runtime_resume(struct device *dev, bool from_wq)
 
  out:
 	if (parent) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 		pm_runtime_put(parent);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 	}
 
 	dev_dbg(dev, "__pm_runtime_resume() returns %d!\n", retval);
@@ -484,9 +488,9 @@ int pm_runtime_resume(struct device *dev)
 {
 	int retval;
 
-	spin_lock_irq(&dev->power.lock);
+	spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
 	retval = __pm_runtime_resume(dev, false);
-	spin_unlock_irq(&dev->power.lock);
+	spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
 
 	return retval;
 }
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 52e8c55..8515153 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -465,6 +465,7 @@ struct dev_pm_info {
 	struct work_struct	work;
 	wait_queue_head_t	wait_queue;
 	spinlock_t		lock;
+	unsigned long           lock_flags;
 	atomic_t		usage_count;
 	atomic_t		child_count;
 	unsigned int		disable_depth:3;
-- 
1.7.2.1

