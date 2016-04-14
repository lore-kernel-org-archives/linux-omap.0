From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 05/28] ARM: OMAP2+: clock: use the new ti_clk_get for fetching clocks
Date: Thu, 14 Apr 2016 14:07:54 +0300
Message-ID: <1460632097-25727-6-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Use the new ti_clk_get API instead of common implementation, to get rid
of most of the DT_CLK() aliases under drivers/clk/ti.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    2 +-
 arch/arm/mach-omap2/clock.c                  |    6 +++---
 arch/arm/mach-omap2/io.c                     |    2 +-
 arch/arm/mach-omap2/mcbsp.c                  |    2 +-
 arch/arm/mach-omap2/omap2-restart.c          |    5 +++--
 arch/arm/mach-omap2/pm.c                     |    2 +-
 arch/arm/mach-omap2/pm24xx.c                 |    4 ++--
 arch/arm/mach-omap2/timer.c                  |    7 ++++---
 arch/arm/mach-omap2/voltage.c                |    3 ++-
 9 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index b64d717..2a9739e 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -200,7 +200,7 @@ void omap2xxx_clkt_vps_late_init(void)
 {
 	struct clk *c;
 
-	c = clk_get(NULL, "sys_ck");
+	c = ti_clk_get("sys_ck");
 	if (IS_ERR(c)) {
 		WARN(1, "could not locate sys_ck\n");
 	} else {
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d058125..50fbff0 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -151,15 +151,15 @@ void __init omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 	struct clk *hfclkin_ck, *core_ck, *mpu_ck;
 	unsigned long hfclkin_rate;
 
-	mpu_ck = clk_get(NULL, mpu_ck_name);
+	mpu_ck = ti_clk_get(mpu_ck_name);
 	if (WARN(IS_ERR(mpu_ck), "clock: failed to get %s.\n", mpu_ck_name))
 		return;
 
-	core_ck = clk_get(NULL, core_ck_name);
+	core_ck = ti_clk_get(core_ck_name);
 	if (WARN(IS_ERR(core_ck), "clock: failed to get %s.\n", core_ck_name))
 		return;
 
-	hfclkin_ck = clk_get(NULL, hfclkin_ck_name);
+	hfclkin_ck = ti_clk_get(hfclkin_ck_name);
 	if (WARN(IS_ERR(hfclkin_ck), "Failed to get %s.\n", hfclkin_ck_name))
 		return;
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3c87e40..42e502f 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -389,7 +389,7 @@ static int __init _omap2_init_reprogram_sdrc(void)
 	if (!cpu_is_omap34xx())
 		return 0;
 
-	dpll3_m2_ck = clk_get(NULL, "dpll3_m2_ck");
+	dpll3_m2_ck = ti_clk_get("dpll3_m2_ck");
 	if (IS_ERR(dpll3_m2_ck))
 		return -EINVAL;
 
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index b4ac3af..8098546 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -98,7 +98,7 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
 		pdata->enable_st_clock = omap3_enable_st_clock;
 		sprintf(clk_name, "mcbsp%d_ick", id);
-		mcbsp_iclks[id] = clk_get(NULL, clk_name);
+		mcbsp_iclks[id] = ti_clk_get(clk_name);
 		count++;
 	}
 	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
diff --git a/arch/arm/mach-omap2/omap2-restart.c b/arch/arm/mach-omap2/omap2-restart.c
index 497269d..0540495 100644
--- a/arch/arm/mach-omap2/omap2-restart.c
+++ b/arch/arm/mach-omap2/omap2-restart.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/clk/ti.h>
 
 #include "soc.h"
 #include "common.h"
@@ -52,11 +53,11 @@ void omap2xxx_restart(enum reboot_mode mode, const char *cmd)
  */
 static int __init omap2xxx_common_look_up_clks_for_reset(void)
 {
-	reset_virt_prcm_set_ck = clk_get(NULL, "virt_prcm_set");
+	reset_virt_prcm_set_ck = ti_clk_get("virt_prcm_set");
 	if (IS_ERR(reset_virt_prcm_set_ck))
 		return -EINVAL;
 
-	reset_sys_ck = clk_get(NULL, "sys_ck");
+	reset_sys_ck = ti_clk_get("sys_ck");
 	if (IS_ERR(reset_sys_ck))
 		return -EINVAL;
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 58920bc..83143fe 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -164,7 +164,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 		goto exit;
 	}
 
-	clk =  clk_get(NULL, clk_name);
+	clk =  ti_clk_get(clk_name);
 	if (IS_ERR(clk)) {
 		pr_err("%s: unable to get clk %s\n", __func__, clk_name);
 		goto exit;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 2a1a418..f74a46f 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -286,14 +286,14 @@ int __init omap2_pm_init(void)
 		pr_err("PM: gfx_clkdm not found\n");
 
 
-	osc_ck = clk_get(NULL, "osc_ck");
+	osc_ck = ti_clk_get("osc_ck");
 	if (IS_ERR(osc_ck)) {
 		printk(KERN_ERR "could not get osc_ck\n");
 		return -ENODEV;
 	}
 
 	if (cpu_is_omap242x()) {
-		emul_ck = clk_get(NULL, "emul_ck");
+		emul_ck = ti_clk_get("emul_ck");
 		if (IS_ERR(emul_ck)) {
 			printk(KERN_ERR "could not get emul_ck\n");
 			clk_put(osc_ck);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 5b385bb..08e08db 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -42,6 +42,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
 #include <linux/sched_clock.h>
+#include <linux/clk/ti.h>
 
 #include <asm/mach/time.h>
 #include <asm/smp_twd.h>
@@ -290,11 +291,11 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		return -ENXIO;
 
 	/* After the dmtimer is using hwmod these clocks won't be needed */
-	timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
+	timer->fclk = ti_clk_get(omap_hwmod_get_main_clk(oh));
 	if (IS_ERR(timer->fclk))
 		return PTR_ERR(timer->fclk);
 
-	src = clk_get(NULL, fck_source);
+	src = ti_clk_get(fck_source);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
@@ -556,7 +557,7 @@ static void __init realtime_counter_init(void)
 		pr_err("%s: ioremap failed\n", __func__);
 		return;
 	}
-	sys_clk = clk_get(NULL, "sys_clkin");
+	sys_clk = ti_clk_get("sys_clkin");
 	if (IS_ERR(sys_clk)) {
 		pr_err("%s: failed to get system clock handle\n", __func__);
 		iounmap(base);
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index cba8cad..68d2852 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -26,6 +26,7 @@
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/clk/ti.h>
 
 #include "common.h"
 
@@ -246,7 +247,7 @@ int __init omap_voltage_late_init(void)
 		if (!voltdm->scalable)
 			continue;
 
-		sys_ck = clk_get(NULL, voltdm->sys_clk.name);
+		sys_ck = ti_clk_get(voltdm->sys_clk.name);
 		if (IS_ERR(sys_ck)) {
 			pr_warn("%s: Could not get sys clk.\n", __func__);
 			return -EINVAL;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
