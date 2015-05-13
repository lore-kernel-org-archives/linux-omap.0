From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Wed, 13 May 2015 16:36:33 -0700
Message-ID: <1431560196-5722-3-git-send-email-tony@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nov-007-i588.relay.mailchannels.net ([46.232.183.142]:53456
	"EHLO relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754701AbbEMXhT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2015 19:37:19 -0400
In-Reply-To: <1431560196-5722-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org

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
	if (device_may_wakeup(dev)
		enable_irq_wake(irq);
	...
	if (device_may_wakeup(dev)
		enable_irq_wake(irq);
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
	dev_pm_request_wake_irq(dev, wakeirq, NULL, 0, NULL);
	...
	dev_pm_enable_wake_irq(dev);
	...
	dev_pm_disable_wake_irq(dev);
	...
	dev_pm_free_wake_irq(dev);
	device_init_wakeup(dev, false);
	...

For now, let's only enable it for select PM_WAKEIRQ.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig  |   1 +
 drivers/base/power/Makefile  |   1 +
 drivers/base/power/main.c    |   2 +
 drivers/base/power/power.h   |  38 ++++++
 drivers/base/power/wakeirq.c | 316 +++++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/wakeup.c  |  96 +++++++++++++
 include/linux/pm.h           |   2 +
 include/linux/pm_wakeirq.h   |  72 ++++++++++
 include/linux/pm_wakeup.h    |   7 +
 kernel/power/Kconfig         |   4 +
 10 files changed, 539 insertions(+)
 create mode 100644 drivers/base/power/wakeirq.c
 create mode 100644 include/linux/pm_wakeirq.h

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 6468f15..ac7b570 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -85,6 +85,7 @@ config ARCH_OMAP2PLUS
 	select OMAP_DM_TIMER
 	select OMAP_GPMC
 	select PINCTRL
+	select PM_WAKEIRQ if PM_SLEEP
 	select SOC_BUS
 	select TI_PRIV_EDMA
 	select OMAP_IRQCHIP
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
index 3d874ec..24515e7 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -587,6 +587,7 @@ void dpm_resume_noirq(pm_message_t state)
 	async_synchronize_full();
 	dpm_show_time(starttime, state, "noirq");
 	resume_device_irqs();
+	device_wakeup_disarm_wakeirqs();
 	cpuidle_resume();
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
 }
@@ -1104,6 +1105,7 @@ int dpm_suspend_noirq(pm_message_t state)
 
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
 	cpuidle_pause();
+	device_wakeup_arm_wakeirqs();
 	suspend_device_irqs();
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index b6b8a27..6183c5d 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -20,6 +20,44 @@ static inline void pm_runtime_early_init(struct device *dev)
 extern void pm_runtime_init(struct device *dev);
 extern void pm_runtime_remove(struct device *dev);
 
+#ifdef CONFIG_PM_WAKEIRQ
+
+extern int device_wakeup_attach_irq(struct device *dev,
+				    struct wake_irq *wakeirq);
+extern void device_wakeup_detach_irq(struct device *dev);
+extern void device_wakeup_arm_wakeirqs(void);
+extern void device_wakeup_disarm_wakeirqs(void);
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
+static inline void device_wakeup_arm_wakeirqs(void)
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
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
new file mode 100644
index 0000000..579157b
--- /dev/null
+++ b/drivers/base/power/wakeirq.c
@@ -0,0 +1,316 @@
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
+	if (WARN_ON(dev->power.wakeirq)) {
+		dev_err(dev, "wake irq already initialized\n");
+		err = -EEXIST;
+		goto err_unlock;
+	}
+
+	dev->power.wakeirq = wirq;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	err = device_wakeup_attach_irq(dev, wirq);
+	if (err)
+		goto err_free_mem;
+
+	return 0;
+
+err_unlock:
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+err_free_mem:
+
+	return err;
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
+	wirq = devm_kzalloc(dev, sizeof(*wirq), GFP_KERNEL);
+	if (!wirq)
+		return -ENOMEM;
+
+	wirq->dev = dev;
+	wirq->irq = irq;
+
+	err = dev_pm_attach_wake_irq(dev, irq, wirq);
+	if (err)
+		devm_kfree(dev, wirq);
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
+	dev->power.wakeirq = NULL;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	wirq->irq = -EINVAL;
+	devm_kfree(dev, wirq);
+}
+EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
+
+/**
+ * handle_threaded_wakeirq - Handler for dedicated wake-up interrupts
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
+static irqreturn_t handle_threaded_wakeirq(int wakeirq, void *_wirq)
+{
+	struct wake_irq *wirq = _wirq;
+	irqreturn_t ret = IRQ_NONE;
+
+	if (!pm_runtime_suspended(wirq->dev))
+		goto out;
+
+	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
+	pm_runtime_resume(wirq->dev);
+	ret = IRQ_HANDLED;
+
+	if (wirq->handler)
+		ret = wirq->handler(wakeirq, wirq->data);
+out:
+	return ret;
+}
+
+/**
+ * dev_pm_request_wake_irq - Request a dedicated wake-up interrupt
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ * @handler: Optional device specific handler
+ * @irqflags: Optional irqflags, IRQF_ONESHOT if not specified
+ * @data: Optional device specific data
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
+int dev_pm_request_wake_irq(struct device *dev,
+			    int irq,
+			    irq_handler_t handler,
+			    unsigned long irqflags,
+			    void *data)
+{
+	struct wake_irq *wirq;
+	int err;
+
+	wirq = devm_kzalloc(dev, sizeof(*wirq), GFP_KERNEL);
+	if (!wirq)
+		return -ENOMEM;
+
+	wirq->dev = dev;
+	wirq->irq = irq;
+	wirq->handler = handler;
+	wirq->data = data;
+	if (!irqflags) {
+		irqflags = IRQF_ONESHOT;
+		wirq->manage_irq = true;
+	}
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+
+	/*
+	 * Consumer device may need to power up and restore state
+	 * so we use a threaded irq.
+	 */
+	err = devm_request_threaded_irq(dev, irq, handler,
+					handle_threaded_wakeirq,
+					irqflags, dev_name(dev),
+					wirq);
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
+	devm_free_irq(dev, irq, wirq);
+err_free:
+	devm_kfree(dev, wirq);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dev_pm_request_wake_irq);
+
+/**
+ * dev_pm_free_wake_irq - Free a wake-up interrupt
+ * @wirq: Device wake-up interrupt
+ */
+void dev_pm_free_wake_irq(struct device *dev)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+	unsigned long flags;
+
+	if (!wirq)
+		return;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	wirq->manage_irq = false;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+	devm_free_irq(wirq->dev, wirq->irq, wirq);
+	dev_pm_clear_wake_irq(dev);
+}
+EXPORT_SYMBOL_GPL(dev_pm_free_wake_irq);
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
index 7726200..47ae173 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -11,9 +11,11 @@
 #include <linux/sched.h>
 #include <linux/capability.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
+#include <linux/pm_wakeirq.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -238,6 +240,100 @@ int device_wakeup_enable(struct device *dev)
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
+ * device_wakeup_arm_wakeirqs(void)
+ *
+ * Itereates over the list of wakeirqs to arm them.
+ */
+void device_wakeup_arm_wakeirqs(void)
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
+ * device_wakeup_disarm_wakeirqs(void)
+ *
+ * Itereates over the list of wakeirqs to disarm them.
+ */
+void device_wakeup_disarm_wakeirqs(void)
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
index 0000000..48bbc1c
--- /dev/null
+++ b/include/linux/pm_wakeirq.h
@@ -0,0 +1,72 @@
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
+struct wake_irq {
+	struct device *dev;
+	int irq;
+	irq_handler_t handler;
+	void *data;
+	bool manage_irq:1;
+};
+
+#ifdef CONFIG_PM_WAKEIRQ
+
+extern int dev_pm_set_wake_irq(struct device *dev, int irq);
+extern void dev_pm_clear_wake_irq(struct device *dev);
+
+extern int dev_pm_request_wake_irq(struct device *dev,
+				   int wakeirq,
+				   irq_handler_t handler,
+				   unsigned long irqflags,
+				   void *data);
+extern void dev_pm_free_wake_irq(struct device *dev);
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
+static inline void dev_pm_clear_wake_irq(struct device *dev)
+{
+}
+
+static inline int dev_pm_request_wake_irq(struct device *dev,
+					  int wakeirq,
+					  irq_handler_t handler,
+					  unsigned long irqflags,
+					  void *data)
+{
+	return 0;
+}
+
+static inline void dev_pm_free_wake_irq(struct device *dev)
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
-- 
2.1.4

