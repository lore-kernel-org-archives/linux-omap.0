From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] reboot: Introduce emergency poweroff function
Date: Thu, 28 Jan 2016 18:36:28 +0530
Message-ID: <1453986389-15887-2-git-send-email-j-keerthy@ti.com>
References: <1453986389-15887-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453986389-15887-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, oleg@redhat.com, toshi.kani@hp.com, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-patch-review@list.ti.com
Cc: j-keerthy@ti.com, nm@ti.com, grygorii.strashko@ti.com, mingo@kernel.org, josh@joshtriplett.org, rui.zhang@intel.com, edubezval@gmail.com
List-Id: linux-omap@vger.kernel.org

emergency_poweroff function can be called in critical situations
to poweroff the system after a configurable period of time. The
default value of the delay is 0 triggers system poweroff immediately.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Reported-by: Nishanth Menon <nm@ti.com>
---
 arch/Kconfig           |  9 +++++++++
 include/linux/reboot.h |  1 +
 kernel/reboot.c        | 31 +++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index f6b649d..0962ea7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -37,6 +37,15 @@ config OPROFILE_NMI_TIMER
 	def_bool y
 	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !PPC64
 
+config EMERGENCY_POWEROFF_DELAY_MS
+	int "Emergency poweroff delay in milli-seconds"
+	default 0
+	help
+	  The number of milliseconds to delay before emergency
+	  poweroff kicks in.
+
+	  If set to 0 poweroff will happen immediately.
+
 config KPROBES
 	bool "Kprobes"
 	depends on MODULES
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index a7ff409..108b4ce 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -71,6 +71,7 @@ void ctrl_alt_del(void);
 extern char poweroff_cmd[POWEROFF_CMD_PATH_LEN];
 
 extern void orderly_poweroff(bool force);
+extern void emergency_poweroff(void);
 extern void orderly_reboot(void);
 
 /*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index bd30a97..def195b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -469,6 +469,37 @@ void orderly_poweroff(bool force)
 }
 EXPORT_SYMBOL_GPL(orderly_poweroff);
 
+/**
+ * emergency_poweroff_func - emergency poweroff work after a known delay
+ * @work: work_struct associated with the emergency poweroff function
+ *
+ * This function is called in very critical situations to force
+ * a kernel poweroff after a configurable timeout value.
+ */
+static void emergency_poweroff_func(struct work_struct *work)
+{
+	pr_warn("Attempting kernel_power_off\n");
+	kernel_power_off();
+
+	pr_warn("kernel_power_off has failed! Attempting emergency_restart\n");
+	emergency_restart();
+}
+
+static DECLARE_DELAYED_WORK(emergency_poweroff_work, emergency_poweroff_func);
+
+/**
+ * emergency_poweroff - Trigger an emergency system poweroff
+ *
+ * This may be called from any critical situation to trigger a system shutdown
+ * after a known period of time. By default the delay is 0 millisecond
+ */
+void emergency_poweroff(void)
+{
+	schedule_delayed_work(&emergency_poweroff_work,
+			msecs_to_jiffies(CONFIG_EMERGENCY_POWEROFF_DELAY_MS));
+}
+EXPORT_SYMBOL_GPL(emergency_poweroff);
+
 static void reboot_work_func(struct work_struct *work)
 {
 	__orderly_reboot();
-- 
1.9.1
