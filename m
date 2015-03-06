From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] PM / Wakeirq: Add minimal device wakeirq helper functions
Date: Thu,  5 Mar 2015 16:34:06 -0800
Message-ID: <1425602049-2674-2-git-send-email-tony@atomide.com>
References: <1425602049-2674-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425602049-2674-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some devices have separate wake-up interrupts in addition to the
normal device interrupts. The wake-up interrupts can be connected
to a separate interrupt controller that is always powered. This
allows the devices and the whole system to enter deeper idle states
while still being able to wake-up to events.

As some devices are already using wake-up interrupts, let's add
some helper functions. This is to avoid having the drivers getting
things wrong in a different ways. Some of these drivers also have
a interrupt re-entrancy problem as the normal device interrupt
handler is being called from the wake-up interrupt as pointed out
by Thomas Gleixner <tglx@linutronix.de>.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig  |   1 +
 drivers/base/power/Makefile  |   1 +
 drivers/base/power/wakeirq.c | 201 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_wakeirq.h   |  69 +++++++++++++++
 kernel/power/Kconfig         |   4 +
 5 files changed, 276 insertions(+)
 create mode 100644 drivers/base/power/wakeirq.c
 create mode 100644 include/linux/pm_wakeirq.h

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2b8e477..f3e9b88 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -83,6 +83,7 @@ config ARCH_OMAP2PLUS
 	select OMAP_DM_TIMER
 	select OMAP_GPMC
 	select PINCTRL
+	select PM_WAKEIRQ
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
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
new file mode 100644
index 0000000..566d69d
--- /dev/null
+++ b/drivers/base/power/wakeirq.c
@@ -0,0 +1,201 @@
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
+/**
+ * handle_dedicated_wakeirq - Handler for device wake-up interrupts
+ * @wakeirq: Separate wake-up interrupt for a device different
+ * @_wirq: Wake-up interrupt data
+ *
+ * Some devices have a separate wake-up interrupt in addition to the
+ * regular device interrupt. The wake-up interrupts signal that the
+ * device should be woken up from a deeper idle state. This handler
+ * uses device specific pm_runtime functions to wake-up the device
+ * and then it's up to the device to do whatever it needs to. Note
+ * as the device may need to restore context and start up regulators,
+ * this is not a fast path.
+ *
+ * Note that we are not resending the lost device interrupts. We assume
+ * that the wake-up interrupt just needs to wake-up the device, and
+ * the device pm_runtime_resume() can deal with the situation.
+ */
+static irqreturn_t handle_dedicated_wakeirq(int wakeirq, void *_wirq)
+{
+	struct wakeirq_source *wirq = _wirq;
+	irqreturn_t ret = IRQ_NONE;
+
+	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
+	if (pm_runtime_suspended(wirq->dev)) {
+		pm_runtime_mark_last_busy(wirq->dev);
+		pm_runtime_resume(wirq->dev);
+		ret = IRQ_HANDLED;
+	}
+
+	if (wirq->handler)
+		ret = wirq->handler(wakeirq, wirq->data);
+
+	return ret;
+}
+
+static void dev_pm_wakeirq_init(struct device *dev,
+				struct wakeirq_source *wirq)
+{
+	wirq->dev = dev;
+	wirq->wakeirq = -EINVAL;
+	wirq->handler = NULL;
+	wirq->data = NULL;
+	wirq->initialized = true;
+}
+
+/**
+ * dev_pm_wakeirq_request - Request a wake-up interrupt
+ * @dev: Device dev entry
+ * @wakeirq: Device wake-up interrupt
+ * @handler: Optional device specific handler
+ * @irqflags: Optional irqflags, IRQF_ONESHOT if not specified
+ * @data: Optional device specific data
+ * @wirq: Wake-up irq data
+ *
+ * Sets up a threaded interrupt handler for a device that
+ * by default just wakes up the device on a wake-up interrupt.
+ * The interrupt starts disabled, and needs to be managed for
+ * the device by the bus code or the device driver using
+ * dev_pm_wakeirq_enable() and dev_pm_wakeirq_disable()
+ * functions.
+ */
+int dev_pm_wakeirq_request(struct device *dev,
+			   int wakeirq,
+			   irq_handler_t handler,
+			   unsigned long irqflags,
+			   void *data,
+			   struct wakeirq_source *wirq)
+{
+	int err;
+
+	if (!dev || !wirq)
+		return -EINVAL;
+
+	if (!wirq->initialized)
+		dev_pm_wakeirq_init(dev, wirq);
+
+	if (!irqflags)
+		irqflags = IRQF_ONESHOT;
+
+	irq_set_status_flags(wakeirq, IRQ_NOAUTOEN);
+
+	/*
+	 * Consumer device may need to power up and restore state
+	 * so let's just use threaded irq.
+	 */
+	err = devm_request_threaded_irq(wirq->dev,
+					wakeirq,
+					handler,
+					handle_dedicated_wakeirq,
+					irqflags,
+					dev_name(wirq->dev),
+					wirq);
+	if (err)
+		return err;
+
+	wirq->wakeirq = wakeirq;
+	wirq->handler = handler;
+	wirq->data = data;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_wakeirq_request);
+
+static int is_valid_wakeirq(struct wakeirq_source *wirq)
+{
+	return wirq && wirq->initialized && (wirq->wakeirq >= 0);
+}
+
+#define is_invalid_wakeirq(w)	!is_valid_wakeirq(w)
+
+/**
+ * dev_pm_wakeirq_free - Free a wake-up interrupt
+ * @wirq: Device wake-up interrupt
+ */
+void dev_pm_wakeirq_free(struct wakeirq_source *wirq)
+{
+	if (is_invalid_wakeirq(wirq))
+		return;
+
+	devm_free_irq(wirq->dev, wirq->wakeirq, wirq);
+	wirq->wakeirq = -EINVAL;
+}
+EXPORT_SYMBOL_GPL(dev_pm_wakeirq_free);
+
+/**
+ * dev_pm_wakeirq_enable - Enable device wake-up interrupt
+ * @wirq: Device wake-up interrupt
+ *
+ * Called from the bus code or the device driver for
+ * runtime_suspend() to enable the wake-up interrupt while
+ * the device is running.
+ *
+ * Note that for runtime_suspend()) the wake-up interrupts
+ * should be unconditionally enabled unlike for suspend()
+ * that is conditional.
+ */
+void dev_pm_wakeirq_enable(struct wakeirq_source *wirq)
+{
+	if (is_invalid_wakeirq(wirq))
+		return;
+
+	enable_irq(wirq->wakeirq);
+}
+EXPORT_SYMBOL_GPL(dev_pm_wakeirq_enable);
+
+/**
+ * dev_pm_wakeirq_disable - Disable device wake-up interrupt
+ * @wirq: Device wake-up interrupt
+ *
+ * Called from the bus code or the device driver for
+ * runtime_resume() to disable the wake-up interrupt while
+ * the device is running.
+ */
+void dev_pm_wakeirq_disable(struct wakeirq_source *wirq)
+{
+	if (is_invalid_wakeirq(wirq))
+		return;
+
+	disable_irq_nosync(wirq->wakeirq);
+}
+EXPORT_SYMBOL_GPL(dev_pm_wakeirq_disable);
+
+/**
+ * dev_pm_wakeirq_arm_for_suspend - Configure device wake-up
+ * @wirq: Device wake-up interrupt
+ *
+ * Called from the bus code or the device driver for
+ * device suspend(). Just sets up the wake-up event
+ * conditionally based on the device_may_wake(). The
+ * rest is handled automatically by the generic suspend()
+ * code and runtime_suspend().
+ */
+void dev_pm_wakeirq_arm_for_suspend(struct wakeirq_source *wirq)
+{
+	if (is_invalid_wakeirq(wirq))
+		return;
+
+	irq_set_irq_wake(wirq->wakeirq,
+			 device_may_wakeup(wirq->dev));
+}
+EXPORT_SYMBOL_GPL(dev_pm_wakeirq_arm_for_suspend);
+
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
new file mode 100644
index 0000000..3ecbc1a
--- /dev/null
+++ b/include/linux/pm_wakeirq.h
@@ -0,0 +1,69 @@
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
+struct wakeirq_source {
+	struct device *dev;
+	int wakeirq;
+	bool initialized;
+	bool enabled;
+	irq_handler_t handler;
+	void *data;
+};
+
+#ifdef CONFIG_PM_WAKEIRQ
+
+extern int dev_pm_wakeirq_request(struct device *dev,
+				  int wakeirq,
+				  irq_handler_t handler,
+				  unsigned long irqflags,
+				  void *data,
+				  struct wakeirq_source *wirq);
+extern void dev_pm_wakeirq_free(struct wakeirq_source *wirq);
+extern void dev_pm_wakeirq_enable(struct wakeirq_source *wirq);
+extern void dev_pm_wakeirq_disable(struct wakeirq_source *wirq);
+extern void dev_pm_wakeirq_arm_for_suspend(struct wakeirq_source *wirq);
+
+#else	/* !CONFIG_PM_WAKEIRQ */
+
+static inline int dev_pm_wakeirq_request(struct device *dev,
+					 int wakeirq,
+					 irq_handler_t handler,
+					 unsigned long irqflags,
+					 void *data,
+					 struct wakeirq_source *wirq)
+{
+	return 0;
+}
+
+static inline void dev_pm_wakeirq_free(struct wakeirq_source *wirq)
+{
+}
+
+static inline void dev_pm_wakeirq_enable(struct wakeirq_source *wirq)
+{
+}
+
+static inline void dev_pm_wakeirq_disable(struct wakeirq_source *wirq)
+{
+}
+
+static inline void
+dev_pm_wakeirq_arm_for_suspend(struct wakeirq_source *wirq)
+{
+}
+
+#endif	/* CONFIG_PM_WAKEIRQ */
+#endif	/* _LINUX_PM_WAKEIRQ_H */
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 7e01f78..c249845 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -267,6 +267,10 @@ config PM_CLK
 	def_bool y
 	depends on PM && HAVE_CLK
 
+config PM_WAKEIRQ
+	bool
+	depends on PM
+
 config PM_GENERIC_DOMAINS
 	bool
 	depends on PM
-- 
2.1.4
