From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/8] ARM: OMAP2+: Use omap initcalls
Date: Wed, 19 Dec 2012 11:26:16 -0800
Message-ID: <20121219192616.22098.31294.stgit@muffinssi.local>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62664 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751622Ab2LST0U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 14:26:20 -0500
In-Reply-To: <20121219192354.22098.33408.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This way the initcalls don't run on other SoCs on multiplatform
kernels. Otherwise we'll get something like this when booting
on vexpress:

omap_hwmod: _ensure_mpu_hwmod_is_setup: MPU initiator hwmod mpu not yet registered
...
WARNING: at arch/arm/mach-omap2/pm.c:82 _init_omap_device+0x74/0x94()
_init_omap_device: could not find omap_hwmod for mpu
...
omap-dma-engine omap-dma-engine: OMAP DMA engine driver
...

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c  |    2 +-
 arch/arm/mach-omap2/board-rx51-video.c   |    3 ++-
 arch/arm/mach-omap2/clock2xxx.c          |    2 +-
 arch/arm/mach-omap2/clock3xxx.c          |    2 +-
 arch/arm/mach-omap2/devices.c            |    6 +++---
 arch/arm/mach-omap2/dma.c                |    2 +-
 arch/arm/mach-omap2/drm.c                |    2 +-
 arch/arm/mach-omap2/emu.c                |    2 +-
 arch/arm/mach-omap2/fb.c                 |    4 ++--
 arch/arm/mach-omap2/gpio.c               |    5 +++--
 arch/arm/mach-omap2/gpmc.c               |    4 ++--
 arch/arm/mach-omap2/hdq1w.c              |    3 ++-
 arch/arm/mach-omap2/hwspinlock.c         |    2 +-
 arch/arm/mach-omap2/mcbsp.c              |    3 ++-
 arch/arm/mach-omap2/omap-iommu.c         |    2 +-
 arch/arm/mach-omap2/omap2-restart.c      |    3 ++-
 arch/arm/mach-omap2/omap4-common.c       |    4 ++--
 arch/arm/mach-omap2/omap_device.c        |    5 +++--
 arch/arm/mach-omap2/omap_hwmod.c         |    2 +-
 arch/arm/mach-omap2/omap_phy_internal.c  |    2 +-
 arch/arm/mach-omap2/opp3xxx_data.c       |    2 +-
 arch/arm/mach-omap2/opp4xxx_data.c       |    2 +-
 arch/arm/mach-omap2/pm-debug.c           |    2 +-
 arch/arm/mach-omap2/pm.c                 |    2 +-
 arch/arm/mach-omap2/pmu.c                |    2 +-
 arch/arm/mach-omap2/prm3xxx.c            |    2 +-
 arch/arm/mach-omap2/prm44xx.c            |    2 +-
 arch/arm/mach-omap2/serial.c             |    2 +-
 arch/arm/mach-omap2/smartreflex-class3.c |    2 +-
 arch/arm/mach-omap2/timer.c              |    2 +-
 arch/arm/mach-omap2/wd_timer.c           |    2 +-
 31 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 22c483d..5c68009 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -494,7 +494,7 @@ static int __init beagle_opp_init(void)
 	}
 	return 0;
 }
-device_initcall(beagle_opp_init);
+omap_device_initcall(beagle_opp_init);
 
 static void __init omap3_beagle_init(void)
 {
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 46f4fc9..eb66726 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -18,6 +18,7 @@
 #include <video/omapdss.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
+#include "soc.h"
 #include "board-rx51.h"
 
 #include "mux.h"
@@ -85,5 +86,5 @@ static int __init rx51_video_init(void)
 	return 0;
 }
 
-subsys_initcall(rx51_video_init);
+omap_subsys_initcall(rx51_video_init);
 #endif /* defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE) */
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 1ff6469..b870f6a 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -52,6 +52,6 @@ static int __init omap2xxx_clk_arch_init(void)
 	return ret;
 }
 
-arch_initcall(omap2xxx_clk_arch_init);
+omap_arch_initcall(omap2xxx_clk_arch_init);
 
 
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 4eacab8..0b02b41 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -94,6 +94,6 @@ static int __init omap3xxx_clk_arch_init(void)
 	return ret;
 }
 
-arch_initcall(omap3xxx_clk_arch_init);
+omap_arch_initcall(omap3xxx_clk_arch_init);
 
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 4abb8b5..8b142da 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -68,7 +68,7 @@ static int __init omap3_l3_init(void)
 
 	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
 }
-postcore_initcall(omap3_l3_init);
+omap_postcore_initcall(omap3_l3_init);
 
 static int __init omap4_l3_init(void)
 {
@@ -103,7 +103,7 @@ static int __init omap4_l3_init(void)
 
 	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
 }
-postcore_initcall(omap4_l3_init);
+omap_postcore_initcall(omap4_l3_init);
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
@@ -734,4 +734,4 @@ static int __init omap2_init_devices(void)
 
 	return 0;
 }
-arch_initcall(omap2_init_devices);
+omap_arch_initcall(omap2_init_devices);
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 612b982..e034ab6 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -293,4 +293,4 @@ static int __init omap2_system_dma_init(void)
 	return omap_hwmod_for_each_by_class("dma",
 			omap2_system_dma_init_dev, NULL);
 }
-arch_initcall(omap2_system_dma_init);
+omap_arch_initcall(omap2_system_dma_init);
diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 4c7566c..ab8a0e6 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -62,6 +62,6 @@ static int __init omap_init_drm(void)
 
 }
 
-arch_initcall(omap_init_drm);
+omap_arch_initcall(omap_init_drm);
 
 #endif
diff --git a/arch/arm/mach-omap2/emu.c b/arch/arm/mach-omap2/emu.c
index b3566f6..cbeaca2 100644
--- a/arch/arm/mach-omap2/emu.c
+++ b/arch/arm/mach-omap2/emu.c
@@ -47,4 +47,4 @@ static int __init emu_init(void)
 	return 0;
 }
 
-subsys_initcall(emu_init);
+omap_subsys_initcall(emu_init);
diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
index d9bd965..190ae49 100644
--- a/arch/arm/mach-omap2/fb.c
+++ b/arch/arm/mach-omap2/fb.c
@@ -89,7 +89,7 @@ static int __init omap_init_vrfb(void)
 		return 0;
 }
 
-arch_initcall(omap_init_vrfb);
+omap_arch_initcall(omap_init_vrfb);
 #endif
 
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
@@ -113,6 +113,6 @@ static int __init omap_init_fb(void)
 	return platform_device_register(&omap_fb_device);
 }
 
-arch_initcall(omap_init_fb);
+omap_arch_initcall(omap_init_fb);
 
 #endif
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 399acab..40950f5 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/platform_data/gpio-omap.h>
 
+#include "soc.h"
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include "omap-pm.h"
@@ -147,7 +148,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 /*
  * gpio_init needs to be done before
  * machine_init functions access gpio APIs.
- * Hence gpio_init is a postcore_initcall.
+ * Hence gpio_init is a omap_postcore_initcall.
  */
 static int __init omap2_gpio_init(void)
 {
@@ -157,4 +158,4 @@ static int __init omap2_gpio_init(void)
 
 	return omap_hwmod_for_each_by_class("gpio", omap2_gpio_dev_init, NULL);
 }
-postcore_initcall(omap2_gpio_init);
+omap_postcore_initcall(omap2_gpio_init);
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 65468f6..24f8add 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1205,7 +1205,7 @@ static __exit void gpmc_exit(void)
 
 }
 
-postcore_initcall(gpmc_init);
+omap_postcore_initcall(gpmc_init);
 module_exit(gpmc_exit);
 
 static int __init omap_gpmc_init(void)
@@ -1225,7 +1225,7 @@ static int __init omap_gpmc_init(void)
 
 	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
 }
-postcore_initcall(omap_gpmc_init);
+omap_postcore_initcall(omap_gpmc_init);
 
 static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 {
diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
index ab7bf18..f6e0e7e 100644
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 
+#include "soc.h"
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include "hdq1w.h"
@@ -93,4 +94,4 @@ static int __init omap_init_hdq(void)
 
 	return 0;
 }
-arch_initcall(omap_init_hdq);
+omap_arch_initcall(omap_init_hdq);
diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index 1df9b5f..ce1b5b6 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -57,4 +57,4 @@ static int __init hwspinlocks_init(void)
 	return retval;
 }
 /* early board code might need to reserve specific hwspinlock instances */
-postcore_initcall(hwspinlocks_init);
+omap_postcore_initcall(hwspinlocks_init);
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index df49f2a..1c0968d 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -23,6 +23,7 @@
 
 #include <linux/omap-dma.h>
 
+#include "soc.h"
 #include "omap_device.h"
 
 /*
@@ -118,4 +119,4 @@ static int __init omap2_mcbsp_init(void)
 
 	return 0;
 }
-arch_initcall(omap2_mcbsp_init);
+omap_arch_initcall(omap2_mcbsp_init);
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index a6a4ff8..f8afcf8 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -151,7 +151,7 @@ err_out:
 	return err;
 }
 /* must be ready before omap3isp is probed */
-subsys_initcall(omap_iommu_init);
+omap_subsys_initcall(omap_iommu_init);
 
 static void __exit omap_iommu_exit(void)
 {
diff --git a/arch/arm/mach-omap2/omap2-restart.c b/arch/arm/mach-omap2/omap2-restart.c
index be6bc89..719b716 100644
--- a/arch/arm/mach-omap2/omap2-restart.c
+++ b/arch/arm/mach-omap2/omap2-restart.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include "soc.h"
 #include "common.h"
 #include "prm2xxx.h"
 
@@ -62,4 +63,4 @@ static int __init omap2xxx_common_look_up_clks_for_reset(void)
 
 	return 0;
 }
-core_initcall(omap2xxx_common_look_up_clks_for_reset);
+omap_core_initcall(omap2xxx_common_look_up_clks_for_reset);
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6897ae21b..ec11e49 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -225,7 +225,7 @@ static int __init omap_l2_cache_init(void)
 
 	return 0;
 }
-early_initcall(omap_l2_cache_init);
+omap_early_initcall(omap_l2_cache_init);
 #endif
 
 void __iomem *omap4_get_sar_ram_base(void)
@@ -253,7 +253,7 @@ static int __init omap4_sar_ram_init(void)
 
 	return 0;
 }
-early_initcall(omap4_sar_ram_init);
+omap_early_initcall(omap4_sar_ram_init);
 
 static struct of_device_id irq_match[] __initdata = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index e065daa..d109f06 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -89,6 +89,7 @@
 #include <linux/of.h>
 #include <linux/notifier.h>
 
+#include "soc.h"
 #include "omap_device.h"
 #include "omap_hwmod.h"
 
@@ -1259,7 +1260,7 @@ static int __init omap_device_init(void)
 	bus_register_notifier(&platform_bus_type, &platform_nb);
 	return 0;
 }
-core_initcall(omap_device_init);
+omap_core_initcall(omap_device_init);
 
 /**
  * omap_device_late_idle - idle devices without drivers
@@ -1297,4 +1298,4 @@ static int __init omap_device_late_init(void)
 	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
 	return 0;
 }
-late_initcall(omap_device_late_init);
+omap_late_initcall(omap_device_late_init);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4653efb..6e70707 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3303,7 +3303,7 @@ static int __init omap_hwmod_setup_all(void)
 
 	return 0;
 }
-core_initcall(omap_hwmod_setup_all);
+omap_core_initcall(omap_hwmod_setup_all);
 
 /**
  * omap_hwmod_enable - enable an omap_hwmod
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index e237602..eb8a25d 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -63,7 +63,7 @@ static int __init omap4430_phy_power_down(void)
 
 	return 0;
 }
-early_initcall(omap4430_phy_power_down);
+omap_early_initcall(omap4430_phy_power_down);
 
 void am35x_musb_reset(void)
 {
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index 62772e0..fc67add 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -168,4 +168,4 @@ int __init omap3_opp_init(void)
 
 	return r;
 }
-device_initcall(omap3_opp_init);
+omap_device_initcall(omap3_opp_init);
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index d470b72..1ef7a3e 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -177,4 +177,4 @@ int __init omap4_opp_init(void)
 			ARRAY_SIZE(omap446x_opp_def_list));
 	return r;
 }
-device_initcall(omap4_opp_init);
+omap_device_initcall(omap4_opp_init);
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index e2c291f..e0ac8a3 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -279,6 +279,6 @@ static int __init pm_dbg_init(void)
 
 	return 0;
 }
-arch_initcall(pm_dbg_init);
+omap_arch_initcall(pm_dbg_init);
 
 #endif
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index f4b3143..9c65edd 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -336,7 +336,7 @@ static int __init omap2_common_pm_init(void)
 
 	return 0;
 }
-postcore_initcall(omap2_common_pm_init);
+omap_postcore_initcall(omap2_common_pm_init);
 
 int __init omap2_common_pm_late_init(void)
 {
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index eb78ae7..75052b3 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -89,4 +89,4 @@ static int __init omap_init_pmu(void)
 
 	return omap2_init_pmu(oh_num, oh_names);
 }
-subsys_initcall(omap_init_pmu);
+omap_subsys_initcall(omap_init_pmu);
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 39822aa..ea60b1d 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -405,7 +405,7 @@ static int __init omap3xxx_prm_late_init(void)
 
 	return ret;
 }
-subsys_initcall(omap3xxx_prm_late_init);
+omap_subsys_initcall(omap3xxx_prm_late_init);
 
 static void __exit omap3xxx_prm_exit(void)
 {
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 7498bc7..f1f80e0 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -665,7 +665,7 @@ static int __init omap44xx_prm_late_init(void)
 
 	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
 }
-subsys_initcall(omap44xx_prm_late_init);
+omap_subsys_initcall(omap44xx_prm_late_init);
 
 static void __exit omap44xx_prm_exit(void)
 {
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 04fdbc4..24e9ad3 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -254,7 +254,7 @@ static int __init omap_serial_early_init(void)
 
 	return 0;
 }
-core_initcall(omap_serial_early_init);
+omap_core_initcall(omap_serial_early_init);
 
 /**
  * omap_serial_init_port() - initialize single serial port
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 1da8f03..80f3acb 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -58,4 +58,4 @@ static int __init sr_class3_init(void)
 	pr_info("SmartReflex Class3 initialized\n");
 	return sr_register_class(&class3_data);
 }
-late_initcall(sr_class3_init);
+omap_late_initcall(sr_class3_init);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 06e1415..5e30b4a 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -742,7 +742,7 @@ static int __init omap2_dm_timer_init(void)
 
 	return 0;
 }
-arch_initcall(omap2_dm_timer_init);
+omap_arch_initcall(omap2_dm_timer_init);
 
 /**
  * omap2_override_clocksource - clocksource override with user configuration
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index 7c2b4ed..70240a5 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -130,4 +130,4 @@ static int __init omap_init_wdt(void)
 	     dev_name, oh->name);
 	return 0;
 }
-subsys_initcall(omap_init_wdt);
+omap_subsys_initcall(omap_init_wdt);

