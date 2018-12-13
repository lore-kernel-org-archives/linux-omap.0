From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 9/9] ARM: smp: remove arch-provided "pen_release"
Date: Thu, 13 Dec 2018 18:01:22 +0000
Message-ID: <E1gXVIY-0008DI-MU@rmk-PC.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181213175952.GC26090@n2100.armlinux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Cc: Viresh Kumar <vireshk@kernel.org>, Barry Song <baohua@kernel.org>, Kukjin Kim <kgene@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-omap@vger.kernel.org

Consolidating the "pen_release" stuff amongst the various SoC
implementations gives credence to having a CPU holding pen for
secondary CPUs.  However, this is far from the truth.

Many SoC implementations cargo-cult copied various bits of the pen
release implementation from the initial Realview/Versatile Express
implementation without understanding what it was or why it existed.
The reason it existed is because these are _development_ platforms,
and some board firmware is unable to individually control the
startup of secondary CPUs.  Moreover, they do not have a way to
power down or reset secondary CPUs for hot-unplug.  Hence, the
pen_release implementation was designed for ARM Ltd's development
platforms to provide a working implementation, even though it is
very far from what is required.

It was decided a while back to reduce the duplication by consolidating
the "pen_release" variable, but this only made the situation worse -
we have ended up with several implementations that read this variable
but do not write it - again, showing the cargo-cult mentality at work,
lack of proper review of new code, and in some cases a lack of testing.

While it would be preferable to remove pen_release entirely from the
kernel, this is not possible without help from the SoC maintainers,
which seems to be lacking.  However, I want to remove pen_release from
arch code to remove the credence that having it gives.

This patch removes pen_release from the arch code entirely, adding
private per-SoC definitions for it instead, and explicitly stating
that write_pen_release() is cargo-cult copied and should not be
copied any further.  Rename write_pen_release() in a similar fashion
as well.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/smp.h     |  1 -
 arch/arm/kernel/smp.c          |  6 ------
 arch/arm/mach-exynos/headsmp.S |  2 +-
 arch/arm/mach-exynos/platsmp.c | 31 ++++++++++++++++++-------------
 arch/arm/mach-prima2/common.h  |  2 ++
 arch/arm/mach-prima2/headsmp.S |  2 +-
 arch/arm/mach-prima2/hotplug.c |  3 ++-
 arch/arm/mach-prima2/platsmp.c | 17 ++++++++++-------
 arch/arm/mach-spear/generic.h  |  2 ++
 arch/arm/mach-spear/headsmp.S  |  2 +-
 arch/arm/mach-spear/hotplug.c  |  4 +++-
 arch/arm/mach-spear/platsmp.c  | 27 ++++++++++++++++-----------
 12 files changed, 56 insertions(+), 43 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 709a55989cb0..451ae684aaf4 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -67,7 +67,6 @@ struct secondary_data {
 	void *stack;
 };
 extern struct secondary_data secondary_data;
-extern volatile int pen_release;
 extern void secondary_startup(void);
 extern void secondary_startup_arm(void);
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 0978282d5fc2..04aa1bcb8d98 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -61,12 +61,6 @@
  */
 struct secondary_data secondary_data;
 
-/*
- * control for which core is the next to come out of the secondary
- * boot "holding pen"
- */
-volatile int pen_release = -1;
-
 enum ipi_msg_type {
 	IPI_WAKEUP,
 	IPI_TIMER,
diff --git a/arch/arm/mach-exynos/headsmp.S b/arch/arm/mach-exynos/headsmp.S
index 005695c9bf40..0ac2cb9a7355 100644
--- a/arch/arm/mach-exynos/headsmp.S
+++ b/arch/arm/mach-exynos/headsmp.S
@@ -36,4 +36,4 @@ ENDPROC(exynos4_secondary_startup)
 
 	.align 2
 1:	.long	.
-	.long	pen_release
+	.long	exynos_pen_release
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 6a1e682371b3..76c3f05854e4 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -28,6 +28,9 @@
 
 extern void exynos4_secondary_startup(void);
 
+/* XXX exynos_pen_release is cargo culted code - DO NOT COPY XXX */
+volatile int exynos_pen_release = -1;
+
 #ifdef CONFIG_HOTPLUG_CPU
 static inline void cpu_leave_lowpower(u32 core_id)
 {
@@ -57,7 +60,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 
 		wfi();
 
-		if (pen_release == core_id) {
+		if (exynos_pen_release == core_id) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
@@ -228,15 +231,17 @@ void exynos_core_restart(u32 core_id)
 }
 
 /*
- * Write pen_release in a way that is guaranteed to be visible to all
- * observers, irrespective of whether they're taking part in coherency
+ * XXX CARGO CULTED CODE - DO NOT COPY XXX
+ *
+ * Write exynos_pen_release in a way that is guaranteed to be visible to
+ * all observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
  */
-static void write_pen_release(int val)
+static void exynos_write_pen_release(int val)
 {
-	pen_release = val;
+	exynos_pen_release = val;
 	smp_wmb();
-	sync_cache_w(&pen_release);
+	sync_cache_w(&exynos_pen_release);
 }
 
 static DEFINE_SPINLOCK(boot_lock);
@@ -247,7 +252,7 @@ static void exynos_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	write_pen_release(-1);
+	exynos_write_pen_release(-1);
 
 	/*
 	 * Synchronise with the boot thread.
@@ -322,12 +327,12 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	/*
 	 * The secondary processor is waiting to be released from
 	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
+	 * that it has been released by resetting exynos_pen_release.
 	 *
-	 * Note that "pen_release" is the hardware CPU core ID, whereas
+	 * Note that "exynos_pen_release" is the hardware CPU core ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
-	write_pen_release(core_id);
+	exynos_write_pen_release(core_id);
 
 	if (!exynos_cpu_power_state(core_id)) {
 		exynos_cpu_power_up(core_id);
@@ -376,13 +381,13 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		else
 			arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
-		if (pen_release == -1)
+		if (exynos_pen_release == -1)
 			break;
 
 		udelay(10);
 	}
 
-	if (pen_release != -1)
+	if (exynos_pen_release != -1)
 		ret = -ETIMEDOUT;
 
 	/*
@@ -392,7 +397,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 fail:
 	spin_unlock(&boot_lock);
 
-	return pen_release != -1 ? ret : 0;
+	return exynos_pen_release != -1 ? ret : 0;
 }
 
 static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index 6d77b622d168..457eb7b18160 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -15,6 +15,8 @@
 #include <asm/mach/time.h>
 #include <asm/exception.h>
 
+extern volatile int prima2_pen_release;
+
 extern const struct smp_operations sirfsoc_smp_ops;
 extern void sirfsoc_secondary_startup(void);
 extern void sirfsoc_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-prima2/headsmp.S b/arch/arm/mach-prima2/headsmp.S
index 209d9fc5c16c..6cf4fc60347b 100644
--- a/arch/arm/mach-prima2/headsmp.S
+++ b/arch/arm/mach-prima2/headsmp.S
@@ -34,4 +34,4 @@ ENDPROC(sirfsoc_secondary_startup)
 
         .align
 1:      .long   .
-        .long   pen_release
+        .long   prima2_pen_release
diff --git a/arch/arm/mach-prima2/hotplug.c b/arch/arm/mach-prima2/hotplug.c
index a728c78b996f..b6cf1527e330 100644
--- a/arch/arm/mach-prima2/hotplug.c
+++ b/arch/arm/mach-prima2/hotplug.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 
 #include <asm/smp_plat.h>
+#include "common.h"
 
 static inline void platform_do_lowpower(unsigned int cpu)
 {
@@ -18,7 +19,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 	for (;;) {
 		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
 			: : : "memory");
-		if (pen_release == cpu_logical_map(cpu)) {
+		if (prima2_pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index 75ef5d4be554..d1f8b5168083 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -24,13 +24,16 @@ static void __iomem *clk_base;
 
 static DEFINE_SPINLOCK(boot_lock);
 
+/* XXX prima2_pen_release is cargo culted code - DO NOT COPY XXX */
+volatile int prima2_pen_release = -1;
+
 static void sirfsoc_secondary_init(unsigned int cpu)
 {
 	/*
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	pen_release = -1;
+	prima2_pen_release = -1;
 	smp_wmb();
 
 	/*
@@ -80,13 +83,13 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	/*
 	 * The secondary processor is waiting to be released from
 	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
+	 * that it has been released by resetting prima2_pen_release.
 	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * Note that "prima2_pen_release" is the hardware CPU ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
-	pen_release = cpu_logical_map(cpu);
-	sync_cache_w(&pen_release);
+	prima2_pen_release = cpu_logical_map(cpu);
+	sync_cache_w(&prima2_pen_release);
 
 	/*
 	 * Send the secondary CPU SEV, thereby causing the boot monitor to read
@@ -97,7 +100,7 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
 		smp_rmb();
-		if (pen_release == -1)
+		if (prima2_pen_release == -1)
 			break;
 
 		udelay(10);
@@ -109,7 +112,7 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	spin_unlock(&boot_lock);
 
-	return pen_release != -1 ? -ENOSYS : 0;
+	return prima2_pen_release != -1 ? -ENOSYS : 0;
 }
 
 const struct smp_operations sirfsoc_smp_ops __initconst = {
diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
index 909b97c0b237..815333fc320c 100644
--- a/arch/arm/mach-spear/generic.h
+++ b/arch/arm/mach-spear/generic.h
@@ -20,6 +20,8 @@
 
 #include <asm/mach/time.h>
 
+extern volatile int prima2_pen_release;
+
 extern void spear13xx_timer_init(void);
 extern void spear3xx_timer_init(void);
 extern struct pl022_ssp_controller pl022_plat_data;
diff --git a/arch/arm/mach-spear/headsmp.S b/arch/arm/mach-spear/headsmp.S
index c52192dc3d9f..6e250b6c0aa2 100644
--- a/arch/arm/mach-spear/headsmp.S
+++ b/arch/arm/mach-spear/headsmp.S
@@ -43,5 +43,5 @@ pen:	ldr	r7, [r6]
 
 	.align
 1:	.long	.
-	.long	pen_release
+	.long	spear_pen_release
 ENDPROC(spear13xx_secondary_startup)
diff --git a/arch/arm/mach-spear/hotplug.c b/arch/arm/mach-spear/hotplug.c
index 12edd1cf8a12..0dd84f609627 100644
--- a/arch/arm/mach-spear/hotplug.c
+++ b/arch/arm/mach-spear/hotplug.c
@@ -16,6 +16,8 @@
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 
+#include "generic.h"
+
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
@@ -57,7 +59,7 @@ static inline void spear13xx_do_lowpower(unsigned int cpu, int *spurious)
 	for (;;) {
 		wfi();
 
-		if (pen_release == cpu) {
+		if (spear_pen_release == cpu) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index 39038a03836a..b1ff4bb86f6d 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -20,16 +20,21 @@
 #include <mach/spear.h>
 #include "generic.h"
 
+/* XXX spear_pen_release is cargo culted code - DO NOT COPY XXX */
+volatile int spear_pen_release = -1;
+
 /*
- * Write pen_release in a way that is guaranteed to be visible to all
- * observers, irrespective of whether they're taking part in coherency
+ * XXX CARGO CULTED CODE - DO NOT COPY XXX
+ *
+ * Write spear_pen_release in a way that is guaranteed to be visible to
+ * all observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
  */
-static void write_pen_release(int val)
+static void spear_write_pen_release(int val)
 {
-	pen_release = val;
+	spear_pen_release = val;
 	smp_wmb();
-	sync_cache_w(&pen_release);
+	sync_cache_w(&spear_pen_release);
 }
 
 static DEFINE_SPINLOCK(boot_lock);
@@ -42,7 +47,7 @@ static void spear13xx_secondary_init(unsigned int cpu)
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
 	 */
-	write_pen_release(-1);
+	spear_write_pen_release(-1);
 
 	/*
 	 * Synchronise with the boot thread.
@@ -64,17 +69,17 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	/*
 	 * The secondary processor is waiting to be released from
 	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
+	 * that it has been released by resetting spear_pen_release.
 	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * Note that "spear_pen_release" is the hardware CPU ID, whereas
 	 * "cpu" is Linux's internal ID.
 	 */
-	write_pen_release(cpu);
+	spear_write_pen_release(cpu);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
 		smp_rmb();
-		if (pen_release == -1)
+		if (spear_pen_release == -1)
 			break;
 
 		udelay(10);
@@ -86,7 +91,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	spin_unlock(&boot_lock);
 
-	return pen_release != -1 ? -ENOSYS : 0;
+	return spear_pen_release != -1 ? -ENOSYS : 0;
 }
 
 /*
-- 
2.7.4
