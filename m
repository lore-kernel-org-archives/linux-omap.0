From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] reboot: Backup orderly_poweroff
Date: Wed, 13 Jan 2016 18:03:25 +0530
Message-ID: <1452688405-15087-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: edubezval@gmail.com, grygorii.strashko@ti.com, j-keerthy@ti.com, nm@ti.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, joel@jms.id.au, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org, mingo@kernel.org, peterz@infradead.org, dyoung@redhat.com, josh@joshtriplett.org, mpe@ellerman.id.au
List-Id: linux-omap@vger.kernel.org

orderly_poweroff is triggered when a graceful shutdown
of system is desired. This may be used in many critical states of the
kernel such as when subsystems detects conditions such as critical
temperature conditions. However, in certain conditions in system
boot up sequences like those in the middle of driver probes being
initiated, userspace will be unable to power off the system in a clean
manner and leaves the system in a critical state. In cases like these,
the /sbin/poweroff will return success (having forked off to attempt
powering off the system. However, the system overall will fail to
completely poweroff (since other modules will be probed) and the system
is still functional with no userspace (since that would have shut itself
off).

However, there is no clean way of detecting such failure of userspace
powering off the system. In such scenarios, it is necessary for a backup
workqueue to be able to force a shutdown of the system when orderly
shutdown is not successful after a configurable time period.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Suggested-by: Eduardo Valentin <edubezval@gmail.com> 
Reported-by: Nishanth Menon <nm@ti.com>
---
Links to previous discussion can be found here:

http://www.spinics.net/lists/linux-omap/msg124925.html

Boot tested on DRA7.

changes in v2:

	* Changed #ifdef to #if CONFIG_SHUTDOWN_BACKUP_DELAY_MS

 arch/Kconfig    |  7 +++++++
 kernel/reboot.c | 23 ++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

Index: linux/arch/Kconfig
===================================================================
--- linux.orig/arch/Kconfig	2016-01-11 15:26:07.732173131 +0530
+++ linux/arch/Kconfig	2016-01-11 15:26:07.728173205 +0530
@@ -37,6 +37,18 @@
 	def_bool y
 	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !PPC64
 
+config SHUTDOWN_BACKUP_DELAY_MS
+	int "Backup shutdown delay in milli-seconds"
+	default 0
+	help
+	  The number of milliseconds to delay before backup workqueue
+	  executes attempting to poweroff the system after the
+	  orderly_poweroff function has failed to complete.
+
+	  If set to 0, the backup workqueue is not active. The value
+	  should be conservatively configured based on userspace latencies
+	  expected for a given system.
+
 config KPROBES
 	bool "Kprobes"
 	depends on MODULES
Index: linux/kernel/reboot.c
===================================================================
--- linux.orig/kernel/reboot.c	2016-01-11 15:26:07.732173131 +0530
+++ linux/kernel/reboot.c	2016-01-11 15:38:33.502341511 +0530
@@ -424,6 +424,38 @@
 	return ret;
 }
 
+#if CONFIG_SHUTDOWN_BACKUP_DELAY_MS
+
+/**
+ * shutdown_backup_func - shutdown backup work after a known delay
+ * @work: work_struct associated with the backup shutdown function
+ *
+ * In system bootup sequences like those in the middle of driver probes being
+ * initiated, userspace will be unable to power off the system in a clean
+ * manner and leaves the system in a critical state.
+ * In such scenarios, this backup workqueue forces a shutdown of the system
+ * when orderly shutdown is not successful after a configurable time period.
+ */
+static void shutdown_backup_func(struct work_struct *work)
+{
+	pr_warn("Orderly_poweroff has failed! Attempting kernel_power_off\n");
+	kernel_power_off();
+
+	pr_warn("kernel_power_off has failed! Attempting emergency_restart\n");
+	emergency_restart();
+}
+
+static DECLARE_DELAYED_WORK(bkup_shutdown_work, shutdown_backup_func);
+
+static inline void setup_backup_shutdown_workqueue(void)
+{
+	schedule_delayed_work(&bkup_shutdown_work,
+		      msecs_to_jiffies(CONFIG_SHUTDOWN_BACKUP_DELAY_MS));
+}
+#else
+static inline void setup_backup_shutdown_workqueue(void) { }
+#endif
+
 static int __orderly_poweroff(bool force)
 {
 	int ret;
@@ -442,6 +474,12 @@
 		kernel_power_off();
 	}
 
+	/*
+	 * Schedule a backup work function to execute after a known time
+	 * when orderly shutdown fails.
+	 */
+	setup_backup_shutdown_workqueue();
+
 	return ret;
 }
 
