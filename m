From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/21] ARM: OMAP: wakeupgen: Convert to hotplug state machine
Date: Tue,  6 Sep 2016 19:04:39 +0200
Message-ID: <20160906170457.32393-4-bigeasy@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160906170457.32393-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Install the callbacks via the state machine.

Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-omap2/omap-wakeupgen.c | 35 +++++++++++++-------------------=
---
 include/linux/cpuhotplug.h           |  1 +
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/oma=
p-wakeupgen.c
index 0c4754386532..369f95a703ac 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -322,34 +322,25 @@ static void irq_save_secure_context(void)
 #endif
=20
 #ifdef CONFIG_HOTPLUG_CPU
-static int irq_cpu_hotplug_notify(struct notifier_block *self,
-				  unsigned long action, void *hcpu)
+static int omap_wakeupgen_cpu_online(unsigned int cpu)
 {
-	unsigned int cpu =3D (unsigned int)hcpu;
-
-	/*
-	 * Corresponding FROZEN transitions do not have to be handled,
-	 * they are handled by at a higher level
-	 * (drivers/cpuidle/coupled.c).
-	 */
-	switch (action) {
-	case CPU_ONLINE:
-		wakeupgen_irqmask_all(cpu, 0);
-		break;
-	case CPU_DEAD:
-		wakeupgen_irqmask_all(cpu, 1);
-		break;
-	}
-	return NOTIFY_OK;
+	wakeupgen_irqmask_all(cpu, 0);
+	return 0;
 }
=20
-static struct notifier_block irq_hotplug_notifier =3D {
-	.notifier_call =3D irq_cpu_hotplug_notify,
-};
+static int omap_wakeupgen_cpu_dead(unsigned int cpu)
+{
+	wakeupgen_irqmask_all(cpu, 1);
+	return 0;
+}
=20
 static void __init irq_hotplug_init(void)
 {
-	register_hotcpu_notifier(&irq_hotplug_notifier);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "arm/omap-wake:online",
+				  omap_wakeupgen_cpu_online, NULL);
+	cpuhp_setup_state_nocalls(CPUHP_ARM_OMAP_WAKE_DEAD,
+				  "arm/omap-wake:dead", NULL,
+				  omap_wakeupgen_cpu_dead);
 }
 #else
 static void __init irq_hotplug_init(void)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 008eed0c0787..35859aafbbfc 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -21,6 +21,7 @@ enum cpuhp_state {
 	CPUHP_NET_MVNETA_DEAD,
 	CPUHP_CPUIDLE_DEAD,
 	CPUHP_ARM64_FPSIMD_DEAD,
+	CPUHP_ARM_OMAP_WAKE_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
--=20
2.9.3
