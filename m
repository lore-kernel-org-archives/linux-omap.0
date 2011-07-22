From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH v2] PM / Runtime: allow _put_sync() from interrupts-disabled context
Date: Fri, 22 Jul 2011 14:46:28 -0700
Message-ID: <1311371188-28879-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:34623 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932157Ab1GVVqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 17:46:14 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so4200290pzk.1
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 14:46:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Colin Cross <ccross@google.com>, Nishanth Menon <nm@ti.com>

Currently the use of pm_runtime_put_sync() is not safe from
interrupts-disabled context because rpm_idle() will release the
spinlock and enable interrupts for the idle callbacks.  This enables
interrupts during a time where interrupts were expected to be
disabled, and can have strange side effects on drivers that expected
interrupts to be disabled.

This is not a bug since the documentation clearly states that only
_put_sync_suspend() is safe in IRQ-safe mode.

However, pm_runtime_put_sync() could be made safe when in IRQ-safe
mode by releasing the spinlock but not re-enabling interrupts, which
is what this patch aims to do.

Problem was found when using some buggy drivers that set
pm_runtime_irq_safe() and used _put_sync() in interrupts-disabled
context.

The offending drivers have been fixed to use _put_sync_suspend(),
But this patch is an RFC to see if it might make sense to allow
using _put_sync() from interrupts-disabled context.

Reported-by: Colin Cross <ccross@google.com>
Tested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
v2: update documentation also

 Documentation/power/runtime_pm.txt |   10 +++++-----
 drivers/base/power/runtime.c       |   10 ++++++++--
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 14dd3c6..4ce5450 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -54,11 +54,10 @@ referred to as subsystem-level callbacks in what follows.
 By default, the callbacks are always invoked in process context with interrupts
 enabled.  However, subsystems can use the pm_runtime_irq_safe() helper function
 to tell the PM core that a device's ->runtime_suspend() and ->runtime_resume()
-callbacks should be invoked in atomic context with interrupts disabled
-(->runtime_idle() is still invoked the default way).  This implies that these
-callback routines must not block or sleep, but it also means that the
-synchronous helper functions listed at the end of Section 4 can be used within
-an interrupt handler or in an atomic context.
+callbacks should be invoked in atomic context with interrupts disabled.
+This implies that these callback routines must not block or sleep, but it also
+means that the synchronous helper functions listed at the end of Section 4 can
+be used within an interrupt handler or in an atomic context.
 
 The subsystem-level suspend callback is _entirely_ _responsible_ for handling
 the suspend of the device as appropriate, which may, but need not include
@@ -483,6 +482,7 @@ pm_runtime_suspend()
 pm_runtime_autosuspend()
 pm_runtime_resume()
 pm_runtime_get_sync()
+pm_runtime_put_sync()
 pm_runtime_put_sync_suspend()
 
 5. Runtime PM Initialization, Device Probing and Removal
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8dc247c..acb3f83 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -226,11 +226,17 @@ static int rpm_idle(struct device *dev, int rpmflags)
 		callback = NULL;
 
 	if (callback) {
-		spin_unlock_irq(&dev->power.lock);
+		if (dev->power.irq_safe)
+			spin_unlock(&dev->power.lock);
+		else
+			spin_unlock_irq(&dev->power.lock);
 
 		callback(dev);
 
-		spin_lock_irq(&dev->power.lock);
+		if (dev->power.irq_safe)
+			spin_lock(&dev->power.lock);
+		else
+			spin_lock_irq(&dev->power.lock);
 	}
 
 	dev->power.idle_notification = false;
-- 
1.7.6

