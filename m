From: Falempe Jocelyn <jocelyn.falempe@motorola.com>
Subject: New feature proposal "quickwakeup"
Date: Fri, 06 Nov 2009 17:00:41 +0100
Message-ID: <1257523241.1318.367.camel@xhp836-11>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:59639 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759377AbZKFQBJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 11:01:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-omap@vger.kernel.org

Hi All,

The purpose of this feature is to drastically reduce the suspend/resume
time for device driver which needs to do periodic job.
In our use case (android smartphone), the system is most of the time in
suspend to RAM, and needs to send a low level command every 30s. With
current framework it takes about 500ms on omap3430 to resume the full
system, and then suspend again. With quickwakup feature, in the resume
process after resuming sysdev and re-enabling irq, the driver handler is
executed, and then it suspends again.
This new path takes 20ms for us, which leads to good power-saving.

This can be used for battery-level check, or for SIM card polling on GSM
network for example.

I need your feedback to know if we should keep it internally or if it
can make its way to the mainline kernel.

here is a patch with my current work, it doesn't compile, it's a kind of
early prototype.
there are still a lot of open issues, like race condition with other
wakeup events ( I use wakelocks on android, but don't know how to have a
similar thing on linux ) ...

basically, a driver who wants to use this feature will register two
functions :
a check function, called with interrupt disable. the driver should read
the irqstatus of his hw and return if the wakeup is for him or not.
a callback function, called with interrupt enable, and sysdev resumed.
it should block until the end of the task. if it returns an error, the
other drivers and userspace are resumed. otherwise it goes to suspend to
RAM again.

I rebased my patches on the branch linux-next, I'm not sure if it is the
right branch.

Best regards,

Jocelyn


---
 include/linux/quickwakeup.h |   33 +++++++++++++++++++++++
 kernel/power/Kconfig        |    8 +++++
 kernel/power/Makefile       |    2 +-
 kernel/power/quickwakeup.c  |   60 +++++++++++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c      |   42 +++++++++++++++++++++--------
 5 files changed, 132 insertions(+), 13 deletions(-)
 create mode 100755 include/linux/quickwakeup.h
 create mode 100644 kernel/power/quickwakeup.c

diff --git a/include/linux/quickwakeup.h b/include/linux/quickwakeup.h
new file mode 100755
index 0000000..60df3b8
--- /dev/null
+++ b/include/linux/quickwakeup.h
@@ -0,0 +1,33 @@
+/* include/linux/quickwakeup.h
+ *
+ * Copyright (C) 2009 Motorola.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+struct quickwakeup_ops {
+	struct list_head list;
+	int (*qw_callback) (void);
+	int (*qw_check)(void);
+	int checked;
+};
+
+#ifdef CONFIG_QUICK_WAKEUP
+
+int quickwakeup_register(struct quickwakeup_ops *ops);
+int quickwakeup_check(void);
+int quickwakeup_execute(void);
+void quickwakeup_unregister(struct quickwakeup_ops *ops);
+
+#else
+static int quickwakeup_register(struct quickwakeup_ops *ops) { return 0; };
+void quickwakeup_unregister(struct quickwakeup_ops *ops) {};
+#endif
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 39263f4..5671f98 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -236,3 +236,11 @@ config PM_RUNTIME
 	  and the bus type drivers of the buses the devices are on are
 	  responsible for the actual handling of the autosuspend requests and
 	  wake-up events.
+
+config QUICK_WAKEUP
+	bool "Quick wakeup"
+	depends on SUSPEND
+	default n
+	---help---
+	  Allow kernel driver to do periodic jobs without resuming the full system
+	  This option can increase battery life on android powered smartphone.
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 4319181..18b55e5 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -10,5 +10,5 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o
 obj-$(CONFIG_HIBERNATION_NVS)	+= hibernate_nvs.o
-
+obj-$(CONFIG_QUICK_WAKEUP)	+= quickwakeup.o
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
diff --git a/kernel/power/quickwakeup.c b/kernel/power/quickwakeup.c
new file mode 100644
index 0000000..3ad7392
--- /dev/null
+++ b/kernel/power/quickwakeup.c
@@ -0,0 +1,60 @@
+/* kernel/power/quickwakeup.c
+ *
+ * Copyright (C) 2009 Motorola.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/quickwakeup.h>
+
+static LIST_HEAD(qw_head);
+
+int quickwakeup_register(struct quickwakeup_ops *ops)
+{
+	list_add(&ops->list, &qw_head);
+	return 0;
+}
+
+void quickwakeup_unregister(struct quickwakeup_ops *ops)
+{
+	list_del(&ops->list);
+}
+
+int quickwakeup_check(void)
+{
+	int ret = 0;
+	struct quickwakeup_ops *index;
+
+	list_for_each_entry(index, &qw_head, list) {
+		index->checked = index->qw_check();
+		ret |= index->checked;
+	}
+	return ret;
+}
+
+int quickwakeup_execute(void)
+{
+	int ret;
+	int count = 0;
+	struct quickwakeup_ops *index;
+
+	list_for_each_entry(index, &qw_head, list) {
+		if (index->checked)
+			ret = index->qw_callback();
+		if (ret != 0)
+			return ret;
+		count++;
+	}
+	if (!count)
+		return -1;
+	return 0;
+}
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 6f10dfc..3fe1ec0 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -116,6 +116,28 @@ void __attribute__ ((weak)) arch_suspend_enable_irqs(void)
 	local_irq_enable();
 }
 
+static int _suspend_enter(suspend_state_t state)
+{
+	int error;
+	arch_suspend_disable_irqs();
+	BUG_ON(!irqs_disabled());
+
+	error = sysdev_suspend(PMSG_SUSPEND);
+	if (!error) {
+		if (!suspend_test(TEST_CORE))
+			error = suspend_ops->enter(state);
+		sysdev_resume();
+	}
+	if (!error) {
+#ifdef CONFIG_QUICK_WAKEUP
+		quickwakeup_check();
+#endif
+	}
+	arch_suspend_enable_irqs();
+	BUG_ON(irqs_disabled());
+	return error;
+}
+
 /**
  *	suspend_enter - enter the desired system sleep state.
  *	@state:		state to enter
@@ -151,18 +173,14 @@ static int suspend_enter(suspend_state_t state)
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
-	arch_suspend_disable_irqs();
-	BUG_ON(!irqs_disabled());
-
-	error = sysdev_suspend(PMSG_SUSPEND);
-	if (!error) {
-		if (!suspend_test(TEST_CORE))
-			error = suspend_ops->enter(state);
-		sysdev_resume();
-	}
-
-	arch_suspend_enable_irqs();
-	BUG_ON(irqs_disabled());
+	error = _suspend_enter(state);
+#ifdef CONFIG_QUICK_WAKEUP
+		while (!error && !quickwakeup_execute()) {
+			if (has_wake_lock(WAKE_LOCK_SUSPEND))
+				break;
+			error = _suspend_enter(state);
+		}
+#endif
 
  Enable_cpus:
 	enable_nonboot_cpus();
-- 
1.6.3.3


