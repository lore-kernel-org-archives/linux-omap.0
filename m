From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 RESEND 4/4] ti: pm33xx: Save/restore clk context based on
 enable_off_mode setting
Date: Tue, 4 Sep 2018 12:19:38 +0530
Message-ID: <1536043778-2232-5-git-send-email-j-keerthy@ti.com>
References: <1536043778-2232-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1536043778-2232-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, mturquette@baylibre.com, sboyd@kernel.org, t-kristo@ti.com
Cc: d-gerlach@ti.com, j-keerthy@ti.com, russ.dill@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
index f4971e4..ccba2cd 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -38,6 +38,20 @@ static int __init am43xx_map_scu(void)
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
@@ -166,6 +180,7 @@ void __iomem *am43xx_get_rtc_base_addr(void)
 	.soc_suspend = am33xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
 	.get_rtc_base_addr = am43xx_get_rtc_base_addr,
+	.check_off_mode_enable = am43xx_check_off_mode_enable,
 };
 
 static struct am33xx_pm_platform_data am43xx_ops = {
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index d0dab32..1a8df56 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -6,6 +6,7 @@
  *	Vaibhav Bedia, Dave Gerlach
  */
 
+#include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
@@ -54,6 +55,14 @@ static int am33xx_pm_suspend(suspend_state_t suspend_state)
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
 				  am33xx_do_wfi_sram, suspend_wfi_flags);
 
@@ -79,6 +88,10 @@ static int am33xx_pm_suspend(suspend_state_t suspend_state)
 		}
 	}
 
+	if (suspend_state == PM_SUSPEND_MEM &&
+	    pm_ops->check_off_mode_enable())
+		clk_restore_context();
+
 	return ret;
 }
 
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index fbf5ed7..dcea606 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -51,6 +51,7 @@ struct am33xx_pm_platform_data {
 			       unsigned long args);
 	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
 	void __iomem *(*get_rtc_base_addr)(void);
+	int (*check_off_mode_enable)(void);
 };
 
 struct am33xx_pm_sram_data {
-- 
1.9.1
