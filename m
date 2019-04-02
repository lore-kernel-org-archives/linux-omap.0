From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 3/5] arm: mach-omap2: pm33xx: Add support for rtc+ddr in
 self refresh mode
Date: Tue, 2 Apr 2019 09:12:51 +0530
Message-ID: <20190402034253.4928-4-j-keerthy@ti.com>
References: <20190402034253.4928-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190402034253.4928-1-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, alexandre.belloni@bootlin.com, a.zummo@towertech.it, t-kristo@ti.com
Cc: linux-rtc@vger.kernel.org, d-gerlach@ti.com, j-keerthy@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add support for rtc+ddr in self refresh mode. Add addtional
pm hooks for save/restore and rtc suspend/resume.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * White list check of the boards which have HW support got this mode

 arch/arm/mach-omap2/pm33xx-core.c    | 76 +++++++++++++++++++++++++++-
 include/linux/platform_data/pm33xx.h |  5 ++
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index 724cf5774a6c..cd8cb12a5003 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -10,6 +10,12 @@
 #include <asm/suspend.h>
 #include <linux/errno.h>
 #include <linux/platform_data/pm33xx.h>
+#include <linux/clk.h>
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/wkup_m3_ipc.h>
+#include <linux/of.h>
+#include <linux/rtc.h>
 
 #include "cm33xx.h"
 #include "common.h"
@@ -38,6 +44,29 @@ static int am43xx_map_scu(void)
 	return 0;
 }
 
+static int am33xx_check_off_mode_enable(void)
+{
+	if (enable_off_mode)
+		pr_warn("WARNING: This platform does not support off-mode, entering DeepSleep suspend.\n");
+
+	/* off mode not supported on am335x so return 0 always */
+	return 0;
+}
+
+static int am43xx_check_off_mode_enable(void)
+{
+	/*
+	 * Check for am437x-gp-evm which has the right Hardware design to
+	 * support this mode reliably.
+	 */
+	if (of_machine_is_compatible("ti,am437x-gp-evm") && enable_off_mode) {
+		return enable_off_mode;
+	} else {
+		pr_warn("WARNING: This platform does not support off-mode, entering DeepSleep suspend.\n");
+		return 0;
+	}
+}
+
 static int amx3_common_init(void)
 {
 	gfx_pwrdm = pwrdm_lookup("gfx_pwrdm");
@@ -139,7 +168,9 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
 	scu_power_mode(scu_base, SCU_PM_POWEROFF);
 	ret = cpu_suspend(args, fn);
 	scu_power_mode(scu_base, SCU_PM_NORMAL);
-	amx3_post_suspend_common();
+
+	if (!am43xx_check_off_mode_enable())
+		amx3_post_suspend_common();
 
 	return ret;
 }
@@ -161,10 +192,48 @@ void __iomem *am43xx_get_rtc_base_addr(void)
 	return omap_hwmod_get_mpu_rt_va(rtc_oh);
 }
 
+static void am43xx_save_context(void)
+{
+}
+
+static void am33xx_save_context(void)
+{
+	omap_intc_save_context();
+}
+
+static void am33xx_restore_context(void)
+{
+	omap_intc_restore_context();
+}
+
+static void am43xx_restore_context(void)
+{
+	/*
+	 * HACK: restore dpll_per_clkdcoldo register contents, to avoid
+	 * breaking suspend-resume
+	 */
+	writel_relaxed(0x0, AM33XX_L4_WK_IO_ADDRESS(0x44df2e14));
+}
+
+static void am43xx_prepare_rtc_suspend(void)
+{
+	omap_hwmod_enable(rtc_oh);
+}
+
+static void am43xx_prepare_rtc_resume(void)
+{
+	omap_hwmod_idle(rtc_oh);
+}
+
 static struct am33xx_pm_platform_data am33xx_ops = {
 	.init = am33xx_suspend_init,
 	.soc_suspend = am33xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
+	.save_context = am33xx_save_context,
+	.restore_context = am33xx_restore_context,
+	.prepare_rtc_suspend = am43xx_prepare_rtc_suspend,
+	.prepare_rtc_resume = am43xx_prepare_rtc_resume,
+	.check_off_mode_enable = am33xx_check_off_mode_enable,
 	.get_rtc_base_addr = am43xx_get_rtc_base_addr,
 };
 
@@ -172,6 +241,11 @@ static struct am33xx_pm_platform_data am43xx_ops = {
 	.init = am43xx_suspend_init,
 	.soc_suspend = am43xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
+	.save_context = am43xx_save_context,
+	.restore_context = am43xx_restore_context,
+	.prepare_rtc_suspend = am43xx_prepare_rtc_suspend,
+	.prepare_rtc_resume = am43xx_prepare_rtc_resume,
+	.check_off_mode_enable = am43xx_check_off_mode_enable,
 	.get_rtc_base_addr = am43xx_get_rtc_base_addr,
 };
 
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index fbf5ed73c7cc..dd5971937a64 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -51,6 +51,11 @@ struct am33xx_pm_platform_data {
 			       unsigned long args);
 	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
 	void __iomem *(*get_rtc_base_addr)(void);
+	void (*save_context)(void);
+	void (*restore_context)(void);
+	void (*prepare_rtc_suspend)(void);
+	void (*prepare_rtc_resume)(void);
+	int (*check_off_mode_enable)(void);
 };
 
 struct am33xx_pm_sram_data {
-- 
2.17.1
