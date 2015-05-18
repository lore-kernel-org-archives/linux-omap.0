From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Mon, 18 May 2015 15:05:00 -0700
Message-ID: <20150518220459.GJ10274@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <20150514155945.GL15563@atomide.com>
 <20150514211501.GO15563@atomide.com>
 <3499196.MCAcS31ICO@vostro.rjw.lan>
 <20150514215921.GQ15563@atomide.com>
 <20150515222513.GB10274@atomide.com>
 <20150516015651.GA7493@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150516015651.GA7493@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150515 19:00]:
> On Fri, May 15, 2015 at 03:25:13PM -0700, Tony Lindgren wrote:
> > --- /dev/null
> > +++ b/drivers/base/power/wakeirq.c
> > +
> > +	spin_lock_irqsave(&dev->power.lock, flags);
> > +	if (WARN_ON(dev->power.wakeirq)) {
> > +		dev_err(dev, "wake irq already initialized\n");
> 
> these two can be combined if you can live with a WARN_ONCE() instead:
> 
> 	if (dev_WARN_ONCE(dev, dev->power.wakeirq,
> 		"wake irq already initialized\n")) {
> 		spin_unlock_irqrestore(&dev->power.lock, flags);
> 		return -EEXIST;
> 	}
> 
> dev_WARN() needs to be fixed at some point to accept a "condition"
> argument :s
> 
> But really, no strong feelings.

Sure, updated to use dev_WARN_ONCE.
 
> > +static irqreturn_t handle_threaded_wakeirq(int wakeirq, void *_wirq)
> > +{
> > +	struct wake_irq *wirq = _wirq;
> > +
> > +	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
> > +	return pm_runtime_resume(wirq->dev) ? IRQ_NONE : IRQ_HANDLED;
> 
> I wonder if you should add a pm_runtime_mark_last_busy() here. I guess
> not after your previous patch ?

Correct, that's no longer needed with patch 1 in this series.
 
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index 7726200..7191519 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -238,6 +239,100 @@ int device_wakeup_enable(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(device_wakeup_enable);
> >  
> > +#ifdef CONFIG_PM_WAKEIRQ
> > +
> > +/**
> > + * device_wakeup_attach_irq - Attach a wakeirq to a wakeup source
> > + * @dev: Device to handle
> > + * @irq: Device specific wakeirq entry
> 
> s/irq/wakeirq to match argument name below ?

I've updated the patch below to standardize on wake_irq naming for
the functions, then use just int irq in the functions.  I'll repost
the whole series after waiting a bit in case there are more comments.

Regards,

Tony

8< ----------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 13 May 2015 11:43:02 -0700
Subject: [PATCH] PM / Wakeirq: Add automated device wake IRQ handling

Turns out we can automate the handling for the device_may_wakeup()
quite a bit by using the kernel wakeup source list.

And as some hardware has separate dedicated wake-up interrupt
in addition to the IO interrupt, we can automate the handling by
adding a generic threaded interrupt handler that just calls the
device PM runtime to wake up the device.

This allows dropping code from device drivers as we currently
are doing it in multiple ways, and often wrong.

For most drivers, we should be able to drop the following
boilerplate code from runtime_suspend and runtime_resume
functions:

	...
	device_init_wakeup(dev, true);
	...
	if (device_may_wakeup(dev)
		enable_irq_wake(irq);
	...
	if (device_may_wakeup(dev)
		enable_irq_wake(irq);
	...
	device_init_wakeup(dev, false);
	...

We can replace it with just the following init and exit
time code:

	...
	device_init_wakeup(dev, true);
	dev_pm_set_wake_irq(dev, irq);
	...
	dev_pm_clear_wake_irq(dev);
	device_init_wakeup(dev, false);
	...

And for hardware with dedicated wake-up interrupts:

	...
	device_init_wakeup(dev, true);
	dev_pm_set_dedicated_wake_irq(dev, irq);
	...
	dev_pm_clear_wake_irq(dev);
	device_init_wakeup(dev, false);
	...

For now, let's only enable it for select PM_WAKEIRQ.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 1cb8544..527546e 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_OPP)	+= opp.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
+obj-$(CONFIG_PM_WAKEIRQ)	+= wakeirq.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3d874ec..6f2515c 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -24,6 +24,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm-trace.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/async.h>
@@ -587,6 +588,7 @@ void dpm_resume_noirq(pm_message_t state)
 	async_synchronize_full();
 	dpm_show_time(starttime, state, "noirq");
 	resume_device_irqs();
+	device_wakeup_disarm_wake_irqs();
 	cpuidle_resume();
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
 }
@@ -1104,6 +1106,7 @@ int dpm_suspend_noirq(pm_message_t state)
 
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
 	cpuidle_pause();
+	device_wakeup_arm_wake_irqs();
 	suspend_device_irqs();
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index b6b8a27..708de3b 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -20,6 +20,54 @@ static inline void pm_runtime_early_init(struct device *dev)
 extern void pm_runtime_init(struct device *dev);
 extern void pm_runtime_remove(struct device *dev);
 
+#ifdef CONFIG_PM_WAKEIRQ
+
+struct wake_irq {
+	struct device *dev;
+	int irq;
+	bool manage_irq:1;
+};
+
+extern int device_wakeup_attach_irq(struct device *dev,
+				    struct wake_irq *wakeirq);
+extern void device_wakeup_detach_irq(struct device *dev);
+extern void device_wakeup_arm_wake_irqs(void);
+extern void device_wakeup_disarm_wake_irqs(void);
+
+extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
+extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
+
+#else
+
+static inline int
+device_wakeup_attach_irq(struct device *dev,
+			 struct wake_irq *wakeirq)
+{
+	return 0;
+}
+
+static inline void device_wakeup_detach_irq(struct device *dev)
+{
+}
+
+static inline void device_wakeup_arm_wake_irqs(void)
+{
+}
+
+static inline void device_wakeup_disarm_wake_irqs(void)
+{
+}
+
+static inline void dev_pm_arm_wake_irq(struct wake_irq *wirq)
+{
+}
+
+static inline void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
+{
+}
+
+#endif /* CONFIG_PM_WAKEIRQ */
+
 /*
  * sysfs.c
  */
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4ffe4a2..e1a10a0 100644
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
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
new file mode 100644
index 0000000..6edb1f6
--- /dev/null
+++ b/drivers/base/power/wakeirq.c
@@ -0,0 +1,276 @@
+/*
+ * wakeirq.c - Device wakeirq helper functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
+
+#include "power.h"
+
+/**
+ * dev_pm_attach_wake_irq - Attach device interrupt as a wake IRQ
+ * @dev: Device entry
+ * @irq: Device wake-up capable interrupt
+ * @wirq: Wake irq specific data
+ *
+ * Internal function to attach either a device IO interrupt or a
+ * dedicated wake-up interrupt as a wake IRQ.
+ */
+static int dev_pm_attach_wake_irq(struct device *dev, int irq,
+				  struct wake_irq *wirq)
+{
+	unsigned long flags;
+	int err;
+
+	if (!dev || !wirq)
+		return -EINVAL;
+
+	if (!dev->power.wakeup) {
+		dev_err(dev, "forgot to call call device_init_wakeup?\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	if (dev_WARN_ONCE(dev, dev->power.wakeirq,
+			  "wake irq already initialized\n")) {
+		spin_unlock_irqrestore(&dev->power.lock, flags);
+		return -EEXIST;
+	}
+
+	dev->power.wakeirq = wirq;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	err = device_wakeup_attach_irq(dev, wirq);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * dev_pm_set_wake_irq - Attach device IO interrupt as wake IRQ
+ * @dev: Device entry
+ * @irq: Device IO interrupt
+ *
+ * Attach a device IO interrupt as a wake IRQ. The wake IRQ gets
+ * automatically configured for wake-up from suspend  based
+ * on the device specific sysfs wakeup entry. Typically called
+ * during driver probe after calling device_init_wakeup().
+ */
+int dev_pm_set_wake_irq(struct device *dev, int irq)
+{
+	struct wake_irq *wirq;
+	int err;
+
+	wirq = kzalloc(sizeof(*wirq), GFP_KERNEL);
+	if (!wirq)
+		return -ENOMEM;
+
+	wirq->dev = dev;
+	wirq->irq = irq;
+
+	err = dev_pm_attach_wake_irq(dev, irq, wirq);
+	if (err)
+		kfree(wirq);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dev_pm_set_wake_irq);
+
+/**
+ * dev_pm_clear_wake_irq - Detach a device IO interrupt wake IRQ
+ * @dev: Device entry
+ *
+ * Detach a device IO interrupt wake IRQ and free resources.
+ *
+ * Note that it's OK for drivers to call this without calling
+ * dev_pm_set_wake_irq() first as all the driver instances may
+ * not have the wake IRQ configured. This avoid adding wake IRQ
+ * checks into the drivers.
+ */
+void dev_pm_clear_wake_irq(struct device *dev)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+	unsigned long flags;
+
+	if (!wirq)
+		return;
+
+	device_wakeup_detach_irq(dev);
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	if (wirq->manage_irq) {
+		free_irq(wirq->irq, wirq);
+		wirq->manage_irq = false;
+	}
+	dev->power.wakeirq = NULL;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	wirq->irq = -EINVAL;
+	kfree(wirq);
+}
+EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
+
+/**
+ * handle_threaded_wake_irq - Handler for dedicated wake-up interrupts
+ * @irq: Device dedicated wake-up interrupt
+ * @_wirq: Wake IRQ data
+ *
+ * Some devices have a separate wake-up interrupt in addition to the
+ * device IO interrupt. The wake-up interrupts signal that the device
+ * should be woken up from a idle state. This handler uses device
+ * specific pm_runtime functions to wake the device and then it's
+ * up to the device to do whatever it needs to. Note as the device
+ * may need to restore context and start up regulators, we use a
+ * threaded IRQ.
+ *
+ * Also note that we are not resending the lost device interrupts.
+ * We assume that the wake-up interrupt just needs to wake-up the
+ * device, and the device pm_runtime_resume() can deal with the
+ * situation.
+ */
+static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
+{
+	struct wake_irq *wirq = _wirq;
+
+	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
+	return pm_runtime_resume(wirq->dev) ? IRQ_NONE : IRQ_HANDLED;
+}
+
+/**
+ * dev_pm_set_dedicated_wake_irq - Request a dedicated wake-up interrupt
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ *
+ * Unless your hardware has separate wake-up interrupts in addition
+ * to the device IO interrupts, you don't need this.
+ *
+ * Sets up a threaded interrupt handler for a device that has
+ * a dedicated wake-up interrupt in addition to the device IO
+ * interrupt.
+ *
+ * The interrupt starts disabled, and needs to be managed for
+ * the device by the bus code or the device driver using
+ * dev_pm_enable_wake_irq() and dev_pm_disable_wake_irq()
+ * functions.
+ */
+int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
+{
+	struct wake_irq *wirq;
+	int err;
+
+	wirq = kzalloc(sizeof(*wirq), GFP_KERNEL);
+	if (!wirq)
+		return -ENOMEM;
+
+	wirq->dev = dev;
+	wirq->irq = irq;
+	wirq->manage_irq = true;
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+
+	/*
+	 * Consumer device may need to power up and restore state
+	 * so we use a threaded irq.
+	 */
+	err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
+				   IRQF_ONESHOT, dev_name(dev), wirq);
+	if (err)
+		goto err_free;
+
+	err = dev_pm_attach_wake_irq(dev, irq, wirq);
+	if (err)
+		goto err_free_irq;
+
+	return err;
+
+err_free_irq:
+	free_irq(irq, wirq);
+err_free:
+	kfree(wirq);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
+
+/**
+ * dev_pm_enable_wake_irq - Enable device wake-up interrupt
+ * @dev: Device
+ *
+ * Called from the bus code or the device driver for
+ * runtime_suspend() to enable the wake-up interrupt while
+ * the device is running.
+ *
+ * Note that for runtime_suspend()) the wake-up interrupts
+ * should be unconditionally enabled unlike for suspend()
+ * that is conditional.
+ */
+void dev_pm_enable_wake_irq(struct device *dev)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+
+	if (wirq && wirq->manage_irq)
+		enable_irq(wirq->irq);
+}
+EXPORT_SYMBOL_GPL(dev_pm_enable_wake_irq);
+
+/**
+ * dev_pm_disable_wake_irq - Disable device wake-up interrupt
+ * @dev: Device
+ *
+ * Called from the bus code or the device driver for
+ * runtime_resume() to disable the wake-up interrupt while
+ * the device is running.
+ */
+void dev_pm_disable_wake_irq(struct device *dev)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+
+	if (wirq && wirq->manage_irq)
+		disable_irq_nosync(wirq->irq);
+}
+EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
+
+/**
+ * dev_pm_arm_wake_irq - Arm device wake-up
+ * @wirq: Device wake-up interrupt
+ *
+ * Sets up the wake-up event conditionally based on the
+ * device_may_wake().
+ */
+void dev_pm_arm_wake_irq(struct wake_irq *wirq)
+{
+	if (!wirq)
+		return;
+
+	if (device_may_wakeup(wirq->dev))
+		enable_irq_wake(wirq->irq);
+}
+
+/**
+ * dev_pm_disarm_wake_irq - Disarm device wake-up
+ * @wirq: Device wake-up interrupt
+ *
+ * Clears up the wake-up event conditionally based on the
+ * device_may_wake().
+ */
+void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
+{
+	if (!wirq)
+		return;
+
+	if (device_may_wakeup(wirq->dev))
+		disable_irq_wake(wirq->irq);
+}
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 7726200..bed2fbb 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -14,6 +14,7 @@
 #include <linux/suspend.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
+#include <linux/pm_wakeirq.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -238,6 +239,100 @@ int device_wakeup_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_wakeup_enable);
 
+#ifdef CONFIG_PM_WAKEIRQ
+
+/**
+ * device_wakeup_attach_irq - Attach a wakeirq to a wakeup source
+ * @dev: Device to handle
+ * @irq: Device specific wakeirq entry
+ *
+ * Attach a device specific wakeirq to the device specific
+ * wakeup source so the device wakeirq can be configured
+ * automatically for suspend and resume.
+ */
+int device_wakeup_attach_irq(struct device *dev,
+			     struct wake_irq *wakeirq)
+{
+	struct wakeup_source *ws;
+	int ret = 0;
+
+	spin_lock_irq(&dev->power.lock);
+	ws = dev->power.wakeup;
+	if (!ws) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (ws->wakeirq) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	ws->wakeirq = wakeirq;
+
+unlock:
+	spin_unlock_irq(&dev->power.lock);
+
+	return ret;
+}
+
+/**
+ * device_wakeup_detach_irq - Detach a wakeirq from a wakeup source
+ * @dev: Device to handle
+ *
+ * Removes the wakeirq from a wakeup source.
+ */
+void device_wakeup_detach_irq(struct device *dev)
+{
+	struct wakeup_source *ws;
+
+	spin_lock_irq(&dev->power.lock);
+	ws = dev->power.wakeup;
+	if (!ws)
+		goto unlock;
+
+	ws->wakeirq = NULL;
+
+unlock:
+	spin_unlock_irq(&dev->power.lock);
+}
+
+/**
+ * device_wakeup_arm_wake_irqs(void)
+ *
+ * Itereates over the list of wakeirqs to arm them.
+ */
+void device_wakeup_arm_wake_irqs(void)
+{
+	struct wakeup_source *ws;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+		if (ws->wakeirq)
+			dev_pm_arm_wake_irq(ws->wakeirq);
+	}
+	rcu_read_unlock();
+}
+
+/**
+ * device_wakeup_disarm_wake_irqs(void)
+ *
+ * Itereates over the list of wakeirqs to disarm them.
+ */
+void device_wakeup_disarm_wake_irqs(void)
+{
+	struct wakeup_source *ws;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
+		if (ws->wakeirq)
+			dev_pm_disarm_wake_irq(ws->wakeirq);
+	}
+	rcu_read_unlock();
+}
+
+#endif /* CONFIG_PM_WAKEIRQ */
+
 /**
  * device_wakeup_detach - Detach a device's wakeup source object from it.
  * @dev: Device to detach the wakeup source object from.
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 2d29c64..d1130d5 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -529,6 +529,7 @@ enum rpm_request {
 };
 
 struct wakeup_source;
+struct wake_irq;
 struct pm_domain_data;
 
 struct pm_subsys_data {
@@ -558,6 +559,7 @@ struct dev_pm_info {
 	struct list_head	entry;
 	struct completion	completion;
 	struct wakeup_source	*wakeup;
+	struct wake_irq		*wakeirq;
 	bool			wakeup_path:1;
 	bool			syscore:1;
 #else
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
new file mode 100644
index 0000000..d6478c7
--- /dev/null
+++ b/include/linux/pm_wakeirq.h
@@ -0,0 +1,52 @@
+/*
+ * pm_wakeirq.h - Device wakeirq helper functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_PM_WAKEIRQ_H
+#define _LINUX_PM_WAKEIRQ_H
+
+#ifdef CONFIG_PM_WAKEIRQ
+
+extern int dev_pm_set_wake_irq(struct device *dev, int irq);
+extern int dev_pm_set_dedicated_wake_irq(struct device *dev,
+					 int irq);
+extern void dev_pm_clear_wake_irq(struct device *dev);
+extern void dev_pm_enable_wake_irq(struct device *dev);
+extern void dev_pm_disable_wake_irq(struct device *dev);
+
+#else	/* !CONFIG_PM_WAKEIRQ */
+
+static inline int dev_pm_set_wake_irq(struct device *dev, int irq)
+{
+	return 0;
+}
+
+static inline int dev_pm_set_dedicated__wake_irq(struct device *dev,
+						 int irq)
+{
+	return 0;
+}
+
+static inline void dev_pm_clear_wake_irq(struct device *dev)
+{
+}
+
+static inline void dev_pm_enable_wake_irq(struct device *dev)
+{
+}
+
+static inline void dev_pm_disable_wake_irq(struct device *dev)
+{
+}
+
+#endif	/* CONFIG_PM_WAKEIRQ */
+#endif	/* _LINUX_PM_WAKEIRQ_H */
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index a0f7080..86d1cbe 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -28,9 +28,15 @@
 
 #include <linux/types.h>
 
+struct wake_irq;
+
 /**
  * struct wakeup_source - Representation of wakeup sources
  *
+ * @name: Name of the wakeup source
+ * @entry: Wakeup source list entry
+ * @lock: Wakeup source lock
+ * @wakeirq: Optional device specific wakeirq
  * @total_time: Total time this wakeup source has been active.
  * @max_time: Maximum time this wakeup source has been continuously active.
  * @last_time: Monotonic clock when the wakeup source's was touched last time.
@@ -47,6 +53,7 @@ struct wakeup_source {
 	const char 		*name;
 	struct list_head	entry;
 	spinlock_t		lock;
+	struct wake_irq		*wakeirq;
 	struct timer_list	timer;
 	unsigned long		timer_expires;
 	ktime_t total_time;
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 7e01f78..d3735bd 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -267,6 +267,10 @@ config PM_CLK
 	def_bool y
 	depends on PM && HAVE_CLK
 
+config PM_WAKEIRQ
+	bool
+	depends on PM_SLEEP
+
 config PM_GENERIC_DOMAINS
 	bool
 	depends on PM
