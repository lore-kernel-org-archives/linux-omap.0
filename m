From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] ARM: Remove __ref on hotplug cpu die path
Date: Mon, 14 Sep 2015 17:23:17 -0700
Message-ID: <1442276597-14325-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: arm@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Barry Song <baohua@kernel.org>, Andy Gross <agross@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Now that __cpuinit has been removed, the __ref markings on these
functions are useless. Remove them. This also reduces the size of
the multi_v7_defconfig image:

$ size before after
   text    data     bss     dec     hex filename
   12683578        1470996  348904 14503478         dd4e36 before
   12683274        1470996  348904 14503174         dd4d06 after

presumably because now we don't have to jump to code in the
.ref.text section and/or the noinline marking is removed.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Andy Gross <agross@codeaurora.org>
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <linux-omap@vger.kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Cc: <spear-devel@list.st.com>
Cc: <linux-tegra@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This patch can be broken up into per-SoC if desired.

 arch/arm/kernel/psci_smp.c           | 4 ++--
 arch/arm/mach-omap2/omap-hotplug.c   | 2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c | 2 +-
 arch/arm/mach-prima2/hotplug.c       | 2 +-
 arch/arm/mach-qcom/platsmp.c         | 2 +-
 arch/arm/mach-realview/hotplug.c     | 2 +-
 arch/arm/mach-spear/hotplug.c        | 2 +-
 arch/arm/mach-tegra/hotplug.c        | 2 +-
 arch/arm/mach-ux500/hotplug.c        | 2 +-
 arch/arm/mach-vexpress/hotplug.c     | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index 61c04b02faeb..9d479b2ea40d 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -71,7 +71,7 @@ int psci_cpu_disable(unsigned int cpu)
 	return 0;
 }
 
-void __ref psci_cpu_die(unsigned int cpu)
+void psci_cpu_die(unsigned int cpu)
 {
 	u32 state = PSCI_POWER_STATE_TYPE_POWER_DOWN <<
 		    PSCI_0_2_POWER_STATE_TYPE_SHIFT;
@@ -83,7 +83,7 @@ void __ref psci_cpu_die(unsigned int cpu)
 	panic("psci: cpu %d failed to shutdown\n", cpu);
 }
 
-int __ref psci_cpu_kill(unsigned int cpu)
+int psci_cpu_kill(unsigned int cpu)
 {
 	int err, i;
 
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 971791fe9a3f..593fec753b28 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -27,7 +27,7 @@
  * platform-specific code to shutdown a CPU
  * Called with IRQs disabled
  */
-void __ref omap4_cpu_die(unsigned int cpu)
+void omap4_cpu_die(unsigned int cpu)
 {
 	unsigned int boot_cpu = 0;
 	void __iomem *base = omap_get_wakeupgen_base();
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index e1d2e991d17a..d9b317706e63 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -330,7 +330,7 @@ static int irq_cpu_hotplug_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __refdata irq_hotplug_notifier = {
+static struct notifier_block irq_hotplug_notifier = {
 	.notifier_call = irq_cpu_hotplug_notify,
 };
 
diff --git a/arch/arm/mach-prima2/hotplug.c b/arch/arm/mach-prima2/hotplug.c
index 0ab2f8bae28e..a728c78b996f 100644
--- a/arch/arm/mach-prima2/hotplug.c
+++ b/arch/arm/mach-prima2/hotplug.c
@@ -32,7 +32,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void __ref sirfsoc_cpu_die(unsigned int cpu)
+void sirfsoc_cpu_die(unsigned int cpu)
 {
 	platform_do_lowpower(cpu);
 }
diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 5cde63a64b34..9b00123a315d 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -49,7 +49,7 @@ extern void secondary_startup_arm(void);
 static DEFINE_SPINLOCK(boot_lock);
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void __ref qcom_cpu_die(unsigned int cpu)
+static void qcom_cpu_die(unsigned int cpu)
 {
 	wfi();
 }
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index ac22dd41b135..968e2d1964f6 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -90,7 +90,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
  *
  * Called with IRQs disabled
  */
-void __ref realview_cpu_die(unsigned int cpu)
+void realview_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
diff --git a/arch/arm/mach-spear/hotplug.c b/arch/arm/mach-spear/hotplug.c
index d97749c642ce..12edd1cf8a12 100644
--- a/arch/arm/mach-spear/hotplug.c
+++ b/arch/arm/mach-spear/hotplug.c
@@ -80,7 +80,7 @@ static inline void spear13xx_do_lowpower(unsigned int cpu, int *spurious)
  *
  * Called with IRQs disabled
  */
-void __ref spear13xx_cpu_die(unsigned int cpu)
+void spear13xx_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 6fc71f1534b0..1b129899a277 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -37,7 +37,7 @@ int tegra_cpu_kill(unsigned cpu)
  *
  * Called with IRQs disabled
  */
-void __ref tegra_cpu_die(unsigned int cpu)
+void tegra_cpu_die(unsigned int cpu)
 {
 	if (!tegra_hotplug_shutdown) {
 		WARN(1, "hotplug is not yet initialized\n");
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index 2bc00b085e38..1cbed0331fd3 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -21,7 +21,7 @@
  *
  * Called with IRQs disabled
  */
-void __ref ux500_cpu_die(unsigned int cpu)
+void ux500_cpu_die(unsigned int cpu)
 {
 	/* directly enter low power state, skipping secure registers */
 	for (;;) {
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index f0ce6b8f5e71..f2fafc10a91d 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -85,7 +85,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
  *
  * Called with IRQs disabled
  */
-void __ref vexpress_cpu_die(unsigned int cpu)
+void vexpress_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
