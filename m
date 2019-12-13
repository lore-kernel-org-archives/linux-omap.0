From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/5] ARM: OMAP2+: pm33xx-core: Add cpuidle_ops for am335x/am437x
Date: Thu, 12 Dec 2019 21:07:52 -0600
Message-ID: <20191213030755.16096-3-d-gerlach@ti.com>
References: <20191213030755.16096-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191213030755.16096-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

am335x and am437x can now make use of the generic cpuidle-arm driver.
This requires that we define init and suspend ops to be passed set as
the cpuidle ops for the SoC. These ops are invoked directly at the last
stage of the cpuidle-arm driver in order to allow low level platform
code to run and bring the CPU the rest of the way into it's desired idle
state. It is required that the CPUIDLE_METHOD_OF_DECLARE be called from
code that is built in so define these ops in pm33xx-core where the
always built-in portion of the PM code for these SoCs lives.

Additionally, although an soc_suspend function is already exposed by the
pm33xx platform code, it contains additional operations needed for full
SoC suspend beyond what is needed for a relatively simple CPU suspend
needed during cpuidle. To get around this introduce cpu_suspend ops to
be used by the am335x and am437x PM driver for the last stage of cpuidle
path.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/pm33xx-core.c    | 117 ++++++++++++++++++++++++++-
 include/linux/platform_data/pm33xx.h |   3 +
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index f11442ed3eff..dc43736f0ae6 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -6,11 +6,14 @@
  *	Dave Gerlach
  */
 
+#include <linux/cpuidle.h>
+#include <linux/platform_data/pm33xx.h>
+#include <asm/cpuidle.h>
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 #include <linux/errno.h>
-#include <linux/platform_data/pm33xx.h>
 #include <linux/clk.h>
+#include <linux/cpu.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/wkup_m3_ipc.h>
@@ -34,6 +37,14 @@ static struct clockdomain *gfx_l4ls_clkdm;
 static void __iomem *scu_base;
 static struct omap_hwmod *rtc_oh;
 
+static int (*idle_fn)(u32 wfi_flags);
+
+struct amx3_idle_state {
+	int wfi_flags;
+};
+
+static struct amx3_idle_state *idle_states;
+
 static int am43xx_map_scu(void)
 {
 	scu_base = ioremap(scu_a9_get_base(), SZ_256);
@@ -177,6 +188,43 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
 	return ret;
 }
 
+static int am33xx_cpu_suspend(int (*fn)(unsigned long), unsigned long args)
+{
+	int ret = 0;
+
+	if (omap_irq_pending() || need_resched())
+		return ret;
+
+	ret = cpu_suspend(args, fn);
+
+	return ret;
+}
+
+static int am43xx_cpu_suspend(int (*fn)(unsigned long), unsigned long args)
+{
+	int ret = 0;
+
+	if (!scu_base)
+		return 0;
+
+	scu_power_mode(scu_base, SCU_PM_DORMANT);
+	ret = cpu_suspend(args, fn);
+	scu_power_mode(scu_base, SCU_PM_NORMAL);
+
+	return ret;
+}
+
+static void amx3_begin_suspend(void)
+{
+	cpu_idle_poll_ctrl(true);
+}
+
+static void amx3_finish_suspend(void)
+{
+	cpu_idle_poll_ctrl(false);
+}
+
+
 static struct am33xx_pm_sram_addr *amx3_get_sram_addrs(void)
 {
 	if (soc_is_am33xx())
@@ -230,6 +278,9 @@ static void am43xx_prepare_rtc_resume(void)
 static struct am33xx_pm_platform_data am33xx_ops = {
 	.init = am33xx_suspend_init,
 	.soc_suspend = am33xx_suspend,
+	.cpu_suspend = am33xx_cpu_suspend,
+	.begin_suspend = amx3_begin_suspend,
+	.finish_suspend = amx3_finish_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
 	.save_context = am33xx_save_context,
 	.restore_context = am33xx_restore_context,
@@ -242,6 +293,9 @@ static struct am33xx_pm_platform_data am33xx_ops = {
 static struct am33xx_pm_platform_data am43xx_ops = {
 	.init = am43xx_suspend_init,
 	.soc_suspend = am43xx_suspend,
+	.cpu_suspend = am43xx_cpu_suspend,
+	.begin_suspend = amx3_begin_suspend,
+	.finish_suspend = amx3_finish_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
 	.save_context = am43xx_save_context,
 	.restore_context = am43xx_restore_context,
@@ -277,3 +331,64 @@ int __init amx3_common_pm_init(void)
 
 	return 0;
 }
+
+static int __init amx3_idle_init(struct device_node *cpu_node, int cpu)
+{
+	struct device_node *state_node;
+	struct amx3_idle_state states[CPUIDLE_STATE_MAX];
+	int i;
+	int state_count = 1;
+
+	for (i = 0; ; i++) {
+		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		if (!state_node)
+			break;
+
+		if (!of_device_is_available(state_node))
+			continue;
+
+		if (i == CPUIDLE_STATE_MAX) {
+			pr_warn("%s: cpuidle states reached max possible\n",
+				__func__);
+			break;
+		}
+
+		states[state_count].wfi_flags = 0;
+
+		if (of_property_read_bool(state_node, "ti,idle-wkup-m3"))
+			states[state_count].wfi_flags |= WFI_FLAG_WAKE_M3 |
+							 WFI_FLAG_FLUSH_CACHE;
+
+		state_count++;
+	}
+
+	idle_states = kcalloc(state_count, sizeof(*idle_states), GFP_KERNEL);
+	if (!idle_states)
+		return -ENOMEM;
+
+	for (i = 1; i < state_count; i++)
+		idle_states[i].wfi_flags = states[i].wfi_flags;
+
+	return 0;
+}
+
+static int amx3_idle_enter(unsigned long index)
+{
+	struct amx3_idle_state *idle_state = &idle_states[index];
+
+	if (!idle_state)
+		return -EINVAL;
+
+	if (idle_fn)
+		idle_fn(idle_state->wfi_flags);
+
+	return 0;
+}
+
+static struct cpuidle_ops amx3_cpuidle_ops __initdata = {
+	.init = amx3_idle_init,
+	.suspend = amx3_idle_enter,
+};
+
+CPUIDLE_METHOD_OF_DECLARE(pm33xx_idle, "ti,am3352", &amx3_cpuidle_ops);
+CPUIDLE_METHOD_OF_DECLARE(pm43xx_idle, "ti,am4372", &amx3_cpuidle_ops);
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index dd5971937a64..8e59f2db2adc 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -49,6 +49,9 @@ struct am33xx_pm_platform_data {
 	int	(*init)(void);
 	int	(*soc_suspend)(unsigned int state, int (*fn)(unsigned long),
 			       unsigned long args);
+	int	(*cpu_suspend)(int (*fn)(unsigned long), unsigned long args);
+	void    (*begin_suspend)(void);
+	void    (*finish_suspend)(void);
 	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
 	void __iomem *(*get_rtc_base_addr)(void);
 	void (*save_context)(void);
-- 
2.20.1
