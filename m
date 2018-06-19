From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/4] soc: ti: pm33xx: Save/restore clk context based on enable_off_mode setting
Date: Tue, 19 Jun 2018 09:58:25 +0530
Message-ID: <1529382505-3069-5-git-send-email-j-keerthy@ti.com>
References: <1529382505-3069-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529382505-3069-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, sboyd@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, d-gerlach@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Save/restore clk context based on enable_off_mode setting.
The context needs to be saved at the very end of suspend path
and restored at the beginning of resume path.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/pm33xx-core.c    | 15 +++++++++++++++
 drivers/soc/ti/pm33xx.c              | 13 +++++++++++++
 include/linux/platform_data/pm33xx.h |  1 +
 3 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index 9b3755a..29f848f 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -37,6 +37,20 @@ static int __init am43xx_map_scu(void)
 	return 0;
 }
 
+static int am43xx_check_off_mode_enable(void)
+{
+	/*
+	 * Check for am437x-sk-evm which due to HW design cannot support
+	 * this mode reliably.
+	 */
+	if (of_machine_is_compatible("ti,am437x-sk-evm") && enable_off_mode) {
+		pr_warn("WARNING: This platform does not support off-mode, entering DeepSleep suspend.\n");
+		return 0;
+	}
+
+	return enable_off_mode;
+}
+
 static int amx3_common_init(void)
 {
 	gfx_pwrdm = pwrdm_lookup("gfx_pwrdm");
@@ -161,6 +175,7 @@ static struct am33xx_pm_sram_addr *amx3_get_sram_addrs(void)
 	.init = am43xx_suspend_init,
 	.soc_suspend = am43xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
+	.check_off_mode_enable = am43xx_check_off_mode_enable,
 };
 
 static struct am33xx_pm_platform_data *am33xx_pm_get_pdata(void)
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 652739c..e749b8d 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -6,6 +6,7 @@
  *	Vaibhav Bedia, Dave Gerlach
  */
 
+#include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
@@ -52,6 +53,14 @@ static int am33xx_pm_suspend(suspend_state_t suspend_state)
 {
 	int i, ret = 0;
 
+	/*
+	 * For RTC only mode with DDR in selfresh we need to save
+	 * clocks context at the very end
+	 */
+	if (suspend_state == PM_SUSPEND_MEM &&
+	    pm_ops->check_off_mode_enable())
+		clk_save_context();
+
 	ret = pm_ops->soc_suspend((unsigned long)suspend_state,
 				  am33xx_do_wfi_sram);
 
@@ -77,6 +86,10 @@ static int am33xx_pm_suspend(suspend_state_t suspend_state)
 		}
 	}
 
+	if (suspend_state == PM_SUSPEND_MEM &&
+	    pm_ops->check_off_mode_enable())
+		clk_restore_context();
+
 	return ret;
 }
 
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index f9bed2a..36f7007 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -25,6 +25,7 @@ struct am33xx_pm_platform_data {
 	int	(*init)(void);
 	int	(*soc_suspend)(unsigned int state, int (*fn)(unsigned long));
 	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
+	int (*check_off_mode_enable)(void);
 };
 
 struct am33xx_pm_sram_data {
-- 
1.9.1
