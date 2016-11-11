From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/14] ARM: OMAP2+: Remove legacy PM init
Date: Fri, 11 Nov 2016 11:17:00 -0800
Message-ID: <20161111191711.5079-4-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is no longer needed when booted with device tree.
And let's replace cpu_is with soc_is for the PM code to
avoid confusion, they do the same thing.

Note that omap_pmic_late_init() now just calls
omap3_twl_init() and omap4_twl_init() to initialize the
voltage layer so we can remove the remaining references
to twl-common code and remove it in the following patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm.c | 66 +++++-------------------------------------------
 1 file changed, 6 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -30,7 +30,6 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include "pm.h"
-#include "twl-common.h"
 
 #ifdef CONFIG_SUSPEND
 /*
@@ -72,42 +71,6 @@ void omap_pm_get_oscillator(u32 *tstart, u32 *tshut)
 }
 #endif
 
-static int __init _init_omap_device(char *name)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-
-	oh = omap_hwmod_lookup(name);
-	if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
-		 __func__, name))
-		return -ENODEV;
-
-	pdev = omap_device_build(oh->name, 0, oh, NULL, 0);
-	if (WARN(IS_ERR(pdev), "%s: could not build omap_device for %s\n",
-		 __func__, name))
-		return -ENODEV;
-
-	return 0;
-}
-
-/*
- * Build omap_devices for processors and bus.
- */
-static void __init omap2_init_processor_devices(void)
-{
-	_init_omap_device("mpu");
-	if (omap3_has_iva())
-		_init_omap_device("iva");
-
-	if (cpu_is_omap44xx()) {
-		_init_omap_device("l3_main_1");
-		_init_omap_device("dsp");
-		_init_omap_device("iva");
-	} else {
-		_init_omap_device("l3_main");
-	}
-}
-
 int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	clkdm_allow_idle(clkdm);
@@ -215,7 +178,7 @@ static int omap_pm_enter(suspend_state_t suspend_state)
 static int omap_pm_begin(suspend_state_t state)
 {
 	cpu_idle_poll_ctrl(true);
-	if (cpu_is_omap34xx())
+	if (soc_is_omap34xx())
 		omap_prcm_irq_prepare();
 	return 0;
 }
@@ -227,7 +190,7 @@ static void omap_pm_end(void)
 
 static void omap_pm_finish(void)
 {
-	if (cpu_is_omap34xx())
+	if (soc_is_omap34xx())
 		omap_prcm_irq_complete();
 }
 
@@ -252,7 +215,7 @@ void omap_common_suspend_init(void *pm_suspend)
 
 static void __init omap3_init_voltages(void)
 {
-	if (!cpu_is_omap34xx())
+	if (!soc_is_omap34xx())
 		return;
 
 	omap2_set_init_voltage("mpu_iva", "dpll1_ck", "mpu");
@@ -261,7 +224,7 @@ static void __init omap3_init_voltages(void)
 
 static void __init omap4_init_voltages(void)
 {
-	if (!cpu_is_omap44xx())
+	if (!soc_is_omap44xx())
 		return;
 
 	omap2_set_init_voltage("mpu", "dpll_mpu_ck", "mpu");
@@ -269,18 +232,8 @@ static void __init omap4_init_voltages(void)
 	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", "iva");
 }
 
-static inline void omap_init_cpufreq(void)
-{
-	struct platform_device_info devinfo = { .name = "omap-cpufreq" };
-
-	if (!of_have_populated_dt())
-		platform_device_register_full(&devinfo);
-}
-
 static int __init omap2_common_pm_init(void)
 {
-	if (!of_have_populated_dt())
-		omap2_init_processor_devices();
 	omap_pm_if_init();
 
 	return 0;
@@ -289,13 +242,9 @@ omap_postcore_initcall(omap2_common_pm_init);
 
 int __init omap2_common_pm_late_init(void)
 {
-	if (of_have_populated_dt()) {
-		omap3_twl_init();
-		omap4_twl_init();
-	}
-
 	/* Init the voltage layer */
-	omap_pmic_late_init();
+	omap3_twl_init();
+	omap4_twl_init();
 	omap_voltage_late_init();
 
 	/* Initialize the voltages */
@@ -305,8 +254,5 @@ int __init omap2_common_pm_late_init(void)
 	/* Smartreflex device init */
 	omap_devinit_smartreflex();
 
-	/* cpufreq dummy device instantiation */
-	omap_init_cpufreq();
-
 	return 0;
 }
-- 
2.10.2
