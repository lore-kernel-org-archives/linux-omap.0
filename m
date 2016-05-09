From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 4/6] ARM: OMAP2+: pm34xx: Convert to use generic sram driver
 for idle code
Date: Mon, 9 May 2016 16:49:24 -0500
Message-ID: <1462830566-28708-5-git-send-email-d-gerlach@ti.com>
References: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Change to use the generic SRAM driver and genalloc framework to allocate
SRAM space for low-level ASM PM code instead of omap specific SRAM
allocator.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c | 82 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d44e0e2f1106..5ebbf5c30c6e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -24,17 +24,21 @@
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/err.h>
+#include <linux/genalloc.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/omap-dma.h>
 #include <linux/omap-gpmc.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/sizes.h>
 
 #include <trace/events/power.h>
 
 #include <asm/fncpy.h>
+#include <asm/proc-fns.h>
 #include <asm/suspend.h>
 #include <asm/system_misc.h>
 
@@ -68,6 +72,9 @@ static LIST_HEAD(pwrst_list);
 
 static int (*_omap_save_secure_sram)(u32 *addr);
 void (*omap3_do_wfi_sram)(void);
+static struct gen_pool *sram_pool;
+static phys_addr_t ocmcram_location;
+static phys_addr_t secure_ocmcram_location;
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
@@ -179,6 +186,71 @@ static void omap34xx_save_context(u32 *save)
 	*save++ = val;
 }
 
+/*
+ * Push functions to SRAM
+ *
+ * The minimum set of functions is pushed to SRAM for execution:
+ * - omap3_do_wfi for erratum i581 WA,
+ * - save_secure_ram_context for security extensions.
+ */
+static int omap3_prepare_push_sram_idle(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "ti,omap3-mpu");
+	if (!np) {
+		pr_warn("PM: %s: Unable to find device node for mpu\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	sram_pool = of_gen_pool_get(np, "sram", 0);
+
+	if (!sram_pool) {
+		pr_warn("PM: %s: Unable to get sram pool for ocmcram\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	ocmcram_location = gen_pool_alloc(sram_pool, omap3_do_wfi_sz);
+	if (!ocmcram_location) {
+		pr_warn("PM: %s: Unable to allocate memory from ocmcram for omap3_do_wfi_sz.\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+		secure_ocmcram_location =
+				gen_pool_alloc(sram_pool,
+					       save_secure_ram_context_sz);
+		if (!secure_ocmcram_location) {
+			pr_warn("PM: %s: Unable to allocate memory from ocmcram for save_secure_ram_context.\n",
+				__func__);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int omap3_push_sram_idle(void)
+{
+	omap3_do_wfi_sram = fncpy((void *)ocmcram_location,
+				  &omap3_do_wfi,
+				  omap3_do_wfi_sz);
+
+	return 0;
+}
+
+static int omap3_push_sram_secure_idle(void)
+{
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+		_omap_save_secure_sram = fncpy((void *)secure_ocmcram_location,
+					       &save_secure_ram_context,
+					       save_secure_ram_context_sz);
+	return 0;
+}
+
 static int omap34xx_do_sram_idle(unsigned long save_state)
 {
 	omap34xx_cpu_suspend(save_state);
@@ -281,7 +353,8 @@ void omap_sram_idle(void)
 	    pwrdm_read_prev_pwrst(core_pwrdm) == PWRDM_POWER_OFF) {
 		omap3_core_restore_context();
 		omap3_cm_restore_context();
-		omap3_sram_restore_context();
+		omap3_push_sram_idle();
+		omap3_push_sram_secure_idle();
 		omap2_sms_restore_context();
 	} else {
 		/*
@@ -517,6 +590,13 @@ int __init omap3_pm_init(void)
 	per_clkdm = clkdm_lookup("per_clkdm");
 	wkup_clkdm = clkdm_lookup("wkup_clkdm");
 
+	ret = omap3_prepare_push_sram_idle();
+	if (ret)
+		goto err3;
+
+	omap3_push_sram_idle();
+	omap3_push_sram_secure_idle();
+
 	omap_common_suspend_init(omap3_pm_suspend);
 
 	arm_pm_idle = omap3_pm_idle;
-- 
2.7.3
