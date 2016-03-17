From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 08/15] genirq: Add runtime power management support for IRQ chips
Date: Thu, 17 Mar 2016 14:19:12 +0000
Message-ID: <1458224359-32665-9-git-send-email-jonathanh@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458224359-32665-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Some IRQ chips may be located in a power domain outside of the CPU
subsystem and hence will require device specific runtime power
management. In order to support such IRQ chips, add a pointer for a
device structure to the irq_chip structure, and if this pointer is
populated by the IRQ chip driver and CONFIG_PM is selected in the kernel
configuration, then the pm_runtime_get/put APIs for this chip will be
called when an IRQ is requested/freed, respectively.

When entering system suspend and each interrupt is disabled if there is
no wake-up set for that interrupt. For an IRQ chip that utilises runtime
power management, print a warning message for each active interrupt that
has no wake-up set because these interrupts may be unnecessarily keeping
the IRQ chip enabled during system suspend.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/linux/irq.h    |  5 +++++
 kernel/irq/chip.c      | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/irq/internals.h |  1 +
 kernel/irq/manage.c    | 14 +++++++++++---
 kernel/irq/pm.c        |  3 +++
 5 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c4de62348ff2..82f36390048d 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -315,6 +315,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
 /**
  * struct irq_chip - hardware interrupt chip descriptor
  *
+ * @parent:		pointer to associated device
  * @name:		name for /proc/interrupts
  * @irq_startup:	start up the interrupt (defaults to ->enable if NULL)
  * @irq_shutdown:	shut down the interrupt (defaults to ->disable if NULL)
@@ -354,6 +355,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @flags:		chip specific flags
  */
 struct irq_chip {
+	struct device	*parent;
 	const char	*name;
 	unsigned int	(*irq_startup)(struct irq_data *data);
 	void		(*irq_shutdown)(struct irq_data *data);
@@ -488,6 +490,9 @@ extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
+extern int irq_chip_pm_get(struct irq_data *data);
+extern int irq_chip_pm_put(struct irq_data *data);
+extern bool irq_chip_pm_suspended(struct irq_data *data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern void irq_chip_enable_parent(struct irq_data *data);
 extern void irq_chip_disable_parent(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 2f9f2b0e79f2..c575b700e88a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1093,3 +1093,55 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	return 0;
 }
+
+/**
+ * irq_chip_pm_get - Enable power for an IRQ chip
+ * @data:	Pointer to interrupt specific data
+ *
+ * Enable the power to the IRQ chip referenced by the interrupt data
+ * structure.
+ */
+int irq_chip_pm_get(struct irq_data *data)
+{
+	int retval = 0;
+
+	if (IS_ENABLED(CONFIG_PM) && data->chip->parent)
+		retval = pm_runtime_get_sync(data->chip->parent);
+
+	return (retval < 0) ? retval : 0;
+}
+
+/**
+ * irq_chip_pm_put - Disable power for an IRQ chip
+ * @data:	Pointer to interrupt specific data
+ *
+ * Disable the power to the IRQ chip referenced by the interrupt data
+ * structure, belongs. Note that power will only be disabled, once this
+ * function has been called for all IRQs that have called irq_chip_pm_get().
+ */
+int irq_chip_pm_put(struct irq_data *data)
+{
+	int retval = 0;
+
+	if (IS_ENABLED(CONFIG_PM) && data->chip->parent)
+		retval = pm_runtime_put(data->chip->parent);
+
+	return (retval < 0) ? retval : 0;
+}
+
+/**
+ * irq_chip_pm_suspended - Power status for an IRQ chip
+ * @data:	Pointer to interrupt specific data
+ *
+ * Return the runtime power status for an IRQ chip referenced by the
+ * interrupt data structure.
+ */
+bool irq_chip_pm_suspended(struct irq_data *data)
+{
+	bool status = true;
+
+	if (IS_ENABLED(CONFIG_PM) && data->chip->parent)
+		status = pm_runtime_status_suspended(data->chip->parent);
+
+	return status;
+}
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 09be2c903c6d..d5edcdc9382a 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -7,6 +7,7 @@
  */
 #include <linux/irqdesc.h>
 #include <linux/kernel_stat.h>
+#include <linux/pm_runtime.h>
 
 #ifdef CONFIG_SPARSE_IRQ
 # define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b2a93a37f772..65878e7c7c82 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1114,6 +1114,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (!try_module_get(desc->owner))
 		return -ENODEV;
 
+	ret = irq_chip_pm_get(&desc->irq_data);
+	if (ret < 0)
+		goto out_mput;
+
 	new->irq = irq;
 
 	/*
@@ -1131,7 +1135,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (nested) {
 		if (!new->thread_fn) {
 			ret = -EINVAL;
-			goto out_mput;
+			goto out_pm;
 		}
 		/*
 		 * Replace the primary handler which was provided from
@@ -1143,7 +1147,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		if (irq_settings_can_thread(desc)) {
 			ret = irq_setup_forced_threading(new);
 			if (ret)
-				goto out_mput;
+				goto out_pm;
 		}
 	}
 
@@ -1155,7 +1159,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (new->thread_fn && !nested) {
 		ret = setup_irq_thread(new, irq, false);
 		if (ret)
-			goto out_mput;
+			goto out_pm;
 		if (new->secondary) {
 			ret = setup_irq_thread(new->secondary, irq, true);
 			if (ret)
@@ -1397,6 +1401,8 @@ out_thread:
 		kthread_stop(t);
 		put_task_struct(t);
 	}
+out_pm:
+	irq_chip_pm_put(&desc->irq_data);
 out_mput:
 	module_put(desc->owner);
 	return ret;
@@ -1513,6 +1519,7 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
 		}
 	}
 
+	irq_chip_pm_put(&desc->irq_data);
 	module_put(desc->owner);
 	kfree(action->secondary);
 	return action;
@@ -1829,6 +1836,7 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 
 	unregister_handler_proc(irq, action);
 
+	irq_chip_pm_put(&desc->irq_data);
 	module_put(desc->owner);
 	return action;
 
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index cea1de0161f1..ab436119084f 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -83,6 +83,9 @@ static bool suspend_device_irq(struct irq_desc *desc)
 		 * suspend_device_irqs().
 		 */
 		return true;
+	} else if (!irq_chip_pm_suspended(&desc->irq_data)) {
+		pr_warn("irq %d has no wakeup set and has not been freed!\n",
+			desc->irq_data.irq);
 	}
 
 	desc->istate |= IRQS_SUSPENDED;
-- 
2.1.4
