From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Thu, 14 May 2015 14:15:01 -0700
Message-ID: <20150514211501.GO15563@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <1431560196-5722-3-git-send-email-tony@atomide.com>
 <20150514020634.GB20006@saruman.tx.rr.com>
 <20150514155945.GL15563@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150514155945.GL15563@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150514 09:01]:
> * Felipe Balbi <balbi@ti.com> [150513 19:09]:
> > > +void dev_pm_enable_wake_irq(struct device *dev)
> > > +{
> > > +	struct wake_irq *wirq = dev->power.wakeirq;
> > > +
> > > +	if (wirq && wirq->manage_irq)
> > > +		enable_irq(wirq->irq);
> > > +}
> > > +EXPORT_SYMBOL_GPL(dev_pm_enable_wake_irq);
> > 
> > you probably want to enable dev_pm_enable_wake_irq() automatically for
> > from rpm_suspend(). According to runtime_pm documentation, wakeup should
> > always be enabled for runtime suspended devices. I didn't really look
> > through the whole thing yet to know if you did call it or not.
> 
> Yes I think we can also automate that part, I've been playing with an
> additional patch doing that for pm runtime. Been still thinking if
> there's any need to manage that in the consomer driver, I guess not.

Here's what that would roughly look and now I also remember why
I did not include it. It adds currently extra checks also for
devices not using dedicated wakeirqs. But basically this would
allow leaving out the enable/disable PM runtime calls from drivers.

Regards,

Tony

8< -------------------
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/export.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include <trace/events/rpm.h>
 #include "power.h"
 
@@ -514,6 +515,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
+	dev_pm_enable_wake_irq(dev);
 	retval = rpm_callback(callback, dev);
 	if (retval)
 		goto fail;
@@ -552,6 +554,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	return retval;
 
  fail:
+	dev_pm_disable_wake_irq(dev);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -734,10 +737,12 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
+	dev_pm_disable_wake_irq(dev);
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);
 		pm_runtime_cancel_pending(dev);
+		dev_pm_enable_wake_irq(dev);
 	} else {
  no_callback:
 		__update_runtime_status(dev, RPM_ACTIVE);
@@ -1427,6 +1432,7 @@ int pm_runtime_force_suspend(struct device *dev)
 		goto err;
 	}
 
+	dev_pm_enable_wake_irq(dev);
 	ret = callback(dev);
 	if (ret)
 		goto err;
@@ -1434,6 +1440,7 @@ int pm_runtime_force_suspend(struct device *dev)
 	pm_runtime_set_suspended(dev);
 	return 0;
 err:
+	dev_pm_disable_wake_irq(dev);
 	pm_runtime_enable(dev);
 	return ret;
 }
@@ -1463,6 +1470,7 @@ int pm_runtime_force_resume(struct device *dev)
 		goto out;
 	}
 
+	dev_pm_disable_wake_irq(dev);
 	ret = callback(dev);
 	if (ret)
 		goto out;
@@ -1470,6 +1478,7 @@ int pm_runtime_force_resume(struct device *dev)
 	pm_runtime_set_active(dev);
 	pm_runtime_mark_last_busy(dev);
 out:
+	dev_pm_enable_wake_irq(dev);
 	pm_runtime_enable(dev);
 	return ret;
 }
