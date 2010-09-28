From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] ARM: add cpu_idle_wait() to support CPUidle on SMP systems.
Date: Tue, 28 Sep 2010 09:43:12 -0700
Message-ID: <1285692192-32075-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47667 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab0I1QnQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 12:43:16 -0400
Received: by pwi1 with SMTP id 1so360316pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 09:43:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

In order for CPUidle to work on SMP systems, an implementation of
cpu_idle_wait() is needed.

This patch duplicates the x86 implementation of cpu_idle_wait() for
ARM.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/Kconfig              |    3 +++
 arch/arm/include/asm/system.h |    2 ++
 arch/arm/kernel/process.c     |   19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 553b7cf..10ce6dc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -145,6 +145,9 @@ config ARCH_HAS_CPUFREQ
 	  and that the relevant menu configurations are displayed for
 	  it.
 
+config ARCH_HAS_CPU_IDLE_WAIT
+       def_bool y
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 8ba1ccf..48e360c 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -325,6 +325,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 extern void disable_hlt(void);
 extern void enable_hlt(void);
 
+void cpu_idle_wait(void);
+
 #include <asm-generic/cmpxchg-local.h>
 
 #if __LINUX_ARM_ARCH__ < 6
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 401e38b..23def52 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -135,6 +135,25 @@ EXPORT_SYMBOL(pm_power_off);
 void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
 EXPORT_SYMBOL_GPL(arm_pm_restart);
 
+static void do_nothing(void *unused)
+{
+}
+
+/*
+ * cpu_idle_wait - Used to ensure that all the CPUs discard old value of
+ * pm_idle and update to new pm_idle value. Required while changing pm_idle
+ * handler on SMP systems.
+ *
+ * Caller must have changed pm_idle to the new value before the call. Old
+ * pm_idle value will not be used by any CPU after the return of this function.
+ */
+void cpu_idle_wait(void)
+{
+	smp_mb();
+	/* kick all the CPUs so that they exit out of pm_idle */
+	smp_call_function(do_nothing, NULL, 1);
+}
+EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
 /*
  * This is our default idle handler.  We need to disable
-- 
1.7.2.1

