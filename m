From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP2+: omap_device: remove obsolete pm_lats and
 early_device code
Date: Mon, 21 Jan 2013 01:42:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301210141550.31667@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60459 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab3AUBmk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Jan 2013 20:42:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Remove now-obsolete code from arch/arm/mach-omap2/omap_device.c.  This
mostly consists of removing the first attempt at device PM latency
handling.  This was never really used, has been replaced by the common
dev_pm_qos code, and needs to go away as part of the DT conversion.
Also, the early platform_device creation code has been removed, as it
appears to be unused.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/am35xx-emac.c |    2 +-
 arch/arm/mach-omap2/devices.c     |   25 +-
 arch/arm/mach-omap2/display.c     |    2 +-
 arch/arm/mach-omap2/dma.c         |    2 +-
 arch/arm/mach-omap2/drm.c         |    3 +-
 arch/arm/mach-omap2/gpio.c        |    3 +-
 arch/arm/mach-omap2/gpmc.c        |    2 +-
 arch/arm/mach-omap2/hdq1w.c       |    2 +-
 arch/arm/mach-omap2/hsmmc.c       |    2 +-
 arch/arm/mach-omap2/hwspinlock.c  |    3 +-
 arch/arm/mach-omap2/i2c.c         |    3 +-
 arch/arm/mach-omap2/mcbsp.c       |    2 +-
 arch/arm/mach-omap2/msdi.c        |    2 +-
 arch/arm/mach-omap2/omap-iommu.c  |    3 +-
 arch/arm/mach-omap2/omap_device.c |  537 ++++---------------------------------
 arch/arm/mach-omap2/omap_device.h |   79 +-----
 arch/arm/mach-omap2/pm.c          |    4 +-
 arch/arm/mach-omap2/pmu.c         |    3 +-
 arch/arm/mach-omap2/serial.c      |    3 +-
 arch/arm/mach-omap2/sr_device.c   |    3 +-
 arch/arm/mach-omap2/timer.c       |    3 +-
 arch/arm/mach-omap2/usb-host.c    |   16 +-
 arch/arm/mach-omap2/usb-musb.c    |    2 +-
 arch/arm/mach-omap2/wd_timer.c    |    3 +-
 24 files changed, 99 insertions(+), 610 deletions(-)

diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index af11dcd..a00d391 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -63,7 +63,7 @@ static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
 	struct platform_device *pdev;
 
 	pdev = omap_device_build(oh->class->name, 0, oh, pdata, pdata_len,
-				 NULL, 0, false);
+				 false);
 	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n",
 		     oh->class->name, oh->name);
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5e304d0..2b71352 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -61,8 +61,7 @@ static int __init omap3_l3_init(void)
 	if (!oh)
 		pr_err("could not look up %s\n", oh_name);
 
-	pdev = omap_device_build("omap_l3_smx", 0, oh, NULL, 0,
-							   NULL, 0, 0);
+	pdev = omap_device_build("omap_l3_smx", 0, oh, NULL, 0);
 
 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
@@ -96,8 +95,7 @@ static int __init omap4_l3_init(void)
 			pr_err("could not look up %s\n", oh_name);
 	}
 
-	pdev = omap_device_build_ss("omap_l3_noc", 0, oh, 3, NULL,
-						     0, NULL, 0, 0);
+	pdev = omap_device_build_ss("omap_l3_noc", 0, oh, 3, NULL, 0);
 
 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
@@ -273,7 +271,7 @@ int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 	keypad_data = sdp4430_keypad_data;
 
 	pdev = omap_device_build(name, id, oh, keypad_data,
-			sizeof(struct omap4_keypad_platform_data), NULL, 0, 0);
+				 sizeof(struct omap4_keypad_platform_data));
 
 	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n",
@@ -297,7 +295,7 @@ static inline void __init omap_init_mbox(void)
 		return;
 	}
 
-	pdev = omap_device_build("omap-mailbox", -1, oh, NULL, 0, NULL, 0, 0);
+	pdev = omap_device_build("omap-mailbox", -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "%s: could not build device, err %ld\n",
 						__func__, PTR_ERR(pdev));
 }
@@ -337,7 +335,7 @@ static void __init omap_init_mcpdm(void)
 		return;
 	}
 
-	pdev = omap_device_build("omap-mcpdm", -1, oh, NULL, 0, NULL, 0, 0);
+	pdev = omap_device_build("omap-mcpdm", -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "Can't build omap_device for omap-mcpdm.\n");
 }
 #else
@@ -358,7 +356,7 @@ static void __init omap_init_dmic(void)
 		return;
 	}
 
-	pdev = omap_device_build("omap-dmic", -1, oh, NULL, 0, NULL, 0, 0);
+	pdev = omap_device_build("omap-dmic", -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "Can't build omap_device for omap-dmic.\n");
 }
 #else
@@ -384,8 +382,7 @@ static void __init omap_init_hdmi_audio(void)
 		return;
 	}
 
-	pdev = omap_device_build("omap-hdmi-audio-dai",
-		-1, oh, NULL, 0, NULL, 0, 0);
+	pdev = omap_device_build("omap-hdmi-audio-dai", -1, oh, NULL, 0, 0);
 	WARN(IS_ERR(pdev),
 	     "Can't build omap_device for omap-hdmi-audio-dai.\n");
 
@@ -429,8 +426,7 @@ static int __init omap_mcspi_init(struct omap_hwmod *oh, void *unused)
 	}
 
 	spi_num++;
-	pdev = omap_device_build(name, spi_num, oh, pdata,
-				sizeof(*pdata),	NULL, 0, 0);
+	pdev = omap_device_build(name, spi_num, oh, pdata, sizeof(*pdata));
 	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s\n",
 				name, oh->name);
 	kfree(pdata);
@@ -460,7 +456,7 @@ static void omap_init_rng(void)
 	if (!oh)
 		return;
 
-	pdev = omap_device_build("omap_rng", -1, oh, NULL, 0, NULL, 0, 0);
+	pdev = omap_device_build("omap_rng", -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "Can't build omap_device for omap_rng\n");
 }
 
@@ -689,8 +685,7 @@ static void omap_init_ocp2scp(void)
 
 	pdata->dev_cnt	= dev_cnt;
 
-	pdev = omap_device_build(name, bus_id, oh, pdata, sizeof(*pdata), NULL,
-								0, false);
+	pdev = omap_device_build(name, bus_id, oh, pdata, sizeof(*pdata));
 	if (IS_ERR(pdev)) {
 		pr_err("Could not build omap_device for %s %s\n",
 						name, oh_name);
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index cc75aaf..ff37be1 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -226,7 +226,7 @@ static struct platform_device *create_dss_pdev(const char *pdev_name,
 		dev_set_name(&pdev->dev, "%s", pdev->name);
 
 	ohs[0] = oh;
-	od = omap_device_alloc(pdev, ohs, 1, NULL, 0);
+	od = omap_device_alloc(pdev, ohs, 1);
 	if (IS_ERR(od)) {
 		pr_err("Could not alloc omap_device for %s\n", pdev_name);
 		r = -ENOMEM;
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 612b982..491c5c8 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -248,7 +248,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 
 	p->errata		= configure_dma_errata();
 
-	pdev = omap_device_build(name, 0, oh, p, sizeof(*p), NULL, 0, 0);
+	pdev = omap_device_build(name, 0, oh, p, sizeof(*p));
 	kfree(p);
 	if (IS_ERR(pdev)) {
 		pr_err("%s: Can't build omap_device for %s:%s.\n",
diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 4c7566c..c880e87 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -50,8 +50,7 @@ static int __init omap_init_drm(void)
 	oh = omap_hwmod_lookup("dmm");
 
 	if (oh) {
-		pdev = omap_device_build(oh->name, -1, oh, NULL, 0, NULL, 0,
-					false);
+		pdev = omap_device_build(oh->name, -1, oh, NULL, 0);
 		WARN(IS_ERR(pdev), "Could not build omap_device for %s\n",
 			oh->name);
 	}
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 399acab..482ade1 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -131,8 +131,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	pwrdm = omap_hwmod_get_pwrdm(oh);
 	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
 
-	pdev = omap_device_build(name, id - 1, oh, pdata,
-				sizeof(*pdata),	NULL, 0, false);
+	pdev = omap_device_build(name, id - 1, oh, pdata, sizeof(*pdata));
 	kfree(pdata);
 
 	if (IS_ERR(pdev)) {
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 8033cb7..bc07833 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1220,7 +1220,7 @@ static int __init omap_gpmc_init(void)
 		return -ENODEV;
 	}
 
-	pdev = omap_device_build(DEVICE_NAME, -1, oh, NULL, 0, NULL, 0, 0);
+	pdev = omap_device_build(DEVICE_NAME, -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
 	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
index ab7bf18..b7aa8ba 100644
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -87,7 +87,7 @@ static int __init omap_init_hdq(void)
 	if (!oh)
 		return 0;
 
-	pdev = omap_device_build(devname, id, oh, NULL, 0, NULL, 0, 0);
+	pdev = omap_device_build(devname, id, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s.\n",
 	     devname, oh->name);
 
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 4a96433..2ef1f87 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -522,7 +522,7 @@ static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 	}
 	dev_set_name(&pdev->dev, "%s.%d", pdev->name, pdev->id);
 
-	od = omap_device_alloc(pdev, ohs, 1, NULL, 0);
+	od = omap_device_alloc(pdev, ohs, 1);
 	if (IS_ERR(od)) {
 		pr_err("Could not allocate od for %s\n", name);
 		goto put_pdev;
diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index 1df9b5f..c368890 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -46,8 +46,7 @@ static int __init hwspinlocks_init(void)
 		return -EINVAL;
 
 	pdev = omap_device_build(dev_name, 0, oh, &omap_hwspinlock_pdata,
-				sizeof(struct hwspinlock_pdata),
-				NULL, 0, false);
+				sizeof(struct hwspinlock_pdata));
 	if (IS_ERR(pdev)) {
 		pr_err("Can't build omap_device for %s:%s\n", dev_name,
 								oh_name);
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index b9074dd..c11a23f 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -178,8 +178,7 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
 	if (cpu_is_omap34xx())
 		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
 	pdev = omap_device_build(name, bus_id, oh, pdata,
-			sizeof(struct omap_i2c_bus_platform_data),
-			NULL, 0, 0);
+				 sizeof(struct omap_i2c_bus_platform_data));
 	WARN(IS_ERR(pdev), "Could not build omap_device for %s\n", name);
 
 	return PTR_RET(pdev);
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index df49f2a..4535804 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -101,7 +101,7 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		count++;
 	}
 	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
-				sizeof(*pdata), NULL, 0, false);
+				    sizeof(*pdata));
 	kfree(pdata);
 	if (IS_ERR(pdev))  {
 		pr_err("%s: Can't build omap_device for %s:%s.\n", __func__,
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index aafdd4c..c52d8b4 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -150,7 +150,7 @@ void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 		return;
 	}
 	pdev = omap_device_build(dev_name, id, oh, mmc_data[0],
-				 sizeof(struct omap_mmc_platform_data), NULL, 0, 0);
+				 sizeof(struct omap_mmc_platform_data));
 	if (IS_ERR(pdev))
 		WARN(1, "Can'd build omap_device for %s:%s.\n",
 					dev_name, oh->name);
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 6da4f7a..f7f38c7 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -41,8 +41,7 @@ static int __init omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->deassert_reset = omap_device_deassert_hardreset;
 	}
 
-	pdev = omap_device_build("omap-iommu", i, oh, pdata, sizeof(*pdata),
-				NULL, 0, 0);
+	pdev = omap_device_build("omap-iommu", i, oh, pdata, sizeof(*pdata));
 
 	kfree(pdata);
 
diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index e065daa..6ee3ad3 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -17,68 +17,15 @@
  * to control power management and interconnect properties of their
  * devices.
  *
- * In the medium- to long-term, this code should either be
- * a) implemented via arch-specific pointers in platform_data
- * or
- * b) implemented as a proper omap_bus/omap_device in Linux, no more
- *    platform_data func pointers
+ * In the medium- to long-term, this code should be implemented as a
+ * proper omap_bus/omap_device in Linux, no more platform_data func
+ * pointers
  *
  *
- * Guidelines for usage by driver authors:
- *
- * 1. These functions are intended to be used by device drivers via
- * function pointers in struct platform_data.  As an example,
- * omap_device_enable() should be passed to the driver as
- *
- * struct foo_driver_platform_data {
- * ...
- *      int (*device_enable)(struct platform_device *pdev);
- * ...
- * }
- *
- * Note that the generic "device_enable" name is used, rather than
- * "omap_device_enable".  This is so other architectures can pass in their
- * own enable/disable functions here.
- *
- * This should be populated during device setup:
- *
- * ...
- * pdata->device_enable = omap_device_enable;
- * ...
- *
- * 2. Drivers should first check to ensure the function pointer is not null
- * before calling it, as in:
- *
- * if (pdata->device_enable)
- *     pdata->device_enable(pdev);
- *
- * This allows other architectures that don't use similar device_enable()/
- * device_shutdown() functions to execute normally.
- *
- * ...
- *
- * Suggested usage by device drivers:
- *
- * During device initialization:
- * device_enable()
- *
- * During device idle:
- * (save remaining device context if necessary)
- * device_idle();
- *
- * During device resume:
- * device_enable();
- * (restore context if necessary)
- *
- * During device shutdown:
- * device_shutdown()
- * (device must be reinitialized at this point to use it again)
- *
  */
 #undef DEBUG
 
 #include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -92,155 +39,8 @@
 #include "omap_device.h"
 #include "omap_hwmod.h"
 
-/* These parameters are passed to _omap_device_{de,}activate() */
-#define USE_WAKEUP_LAT			0
-#define IGNORE_WAKEUP_LAT		1
-
-static int omap_early_device_register(struct platform_device *pdev);
-
-static struct omap_device_pm_latency omap_default_latency[] = {
-	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func   = omap_device_enable_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	}
-};
-
 /* Private functions */
 
-/**
- * _omap_device_activate - increase device readiness
- * @od: struct omap_device *
- * @ignore_lat: increase to latency target (0) or full readiness (1)?
- *
- * Increase readiness of omap_device @od (thus decreasing device
- * wakeup latency, but consuming more power).  If @ignore_lat is
- * IGNORE_WAKEUP_LAT, make the omap_device fully active.  Otherwise,
- * if @ignore_lat is USE_WAKEUP_LAT, and the device's maximum wakeup
- * latency is greater than the requested maximum wakeup latency, step
- * backwards in the omap_device_pm_latency table to ensure the
- * device's maximum wakeup latency is less than or equal to the
- * requested maximum wakeup latency.  Returns 0.
- */
-static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
-{
-	struct timespec a, b, c;
-
-	dev_dbg(&od->pdev->dev, "omap_device: activating\n");
-
-	while (od->pm_lat_level > 0) {
-		struct omap_device_pm_latency *odpl;
-		unsigned long long act_lat = 0;
-
-		od->pm_lat_level--;
-
-		odpl = od->pm_lats + od->pm_lat_level;
-
-		if (!ignore_lat &&
-		    (od->dev_wakeup_lat <= od->_dev_wakeup_lat_limit))
-			break;
-
-		read_persistent_clock(&a);
-
-		/* XXX check return code */
-		odpl->activate_func(od);
-
-		read_persistent_clock(&b);
-
-		c = timespec_sub(b, a);
-		act_lat = timespec_to_ns(&c);
-
-		dev_dbg(&od->pdev->dev,
-			"omap_device: pm_lat %d: activate: elapsed time %llu nsec\n",
-			od->pm_lat_level, act_lat);
-
-		if (act_lat > odpl->activate_lat) {
-			odpl->activate_lat_worst = act_lat;
-			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
-				odpl->activate_lat = act_lat;
-				dev_dbg(&od->pdev->dev,
-					"new worst case activate latency %d: %llu\n",
-					od->pm_lat_level, act_lat);
-			} else
-				dev_warn(&od->pdev->dev,
-					 "activate latency %d higher than expected. (%llu > %d)\n",
-					 od->pm_lat_level, act_lat,
-					 odpl->activate_lat);
-		}
-
-		od->dev_wakeup_lat -= odpl->activate_lat;
-	}
-
-	return 0;
-}
-
-/**
- * _omap_device_deactivate - decrease device readiness
- * @od: struct omap_device *
- * @ignore_lat: decrease to latency target (0) or full inactivity (1)?
- *
- * Decrease readiness of omap_device @od (thus increasing device
- * wakeup latency, but conserving power).  If @ignore_lat is
- * IGNORE_WAKEUP_LAT, make the omap_device fully inactive.  Otherwise,
- * if @ignore_lat is USE_WAKEUP_LAT, and the device's maximum wakeup
- * latency is less than the requested maximum wakeup latency, step
- * forwards in the omap_device_pm_latency table to ensure the device's
- * maximum wakeup latency is less than or equal to the requested
- * maximum wakeup latency.  Returns 0.
- */
-static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
-{
-	struct timespec a, b, c;
-
-	dev_dbg(&od->pdev->dev, "omap_device: deactivating\n");
-
-	while (od->pm_lat_level < od->pm_lats_cnt) {
-		struct omap_device_pm_latency *odpl;
-		unsigned long long deact_lat = 0;
-
-		odpl = od->pm_lats + od->pm_lat_level;
-
-		if (!ignore_lat &&
-		    ((od->dev_wakeup_lat + odpl->activate_lat) >
-		     od->_dev_wakeup_lat_limit))
-			break;
-
-		read_persistent_clock(&a);
-
-		/* XXX check return code */
-		odpl->deactivate_func(od);
-
-		read_persistent_clock(&b);
-
-		c = timespec_sub(b, a);
-		deact_lat = timespec_to_ns(&c);
-
-		dev_dbg(&od->pdev->dev,
-			"omap_device: pm_lat %d: deactivate: elapsed time %llu nsec\n",
-			od->pm_lat_level, deact_lat);
-
-		if (deact_lat > odpl->deactivate_lat) {
-			odpl->deactivate_lat_worst = deact_lat;
-			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
-				odpl->deactivate_lat = deact_lat;
-				dev_dbg(&od->pdev->dev,
-					"new worst case deactivate latency %d: %llu\n",
-					od->pm_lat_level, deact_lat);
-			} else
-				dev_warn(&od->pdev->dev,
-					 "deactivate latency %d higher than expected. (%llu > %d)\n",
-					 od->pm_lat_level, deact_lat,
-					 odpl->deactivate_lat);
-		}
-
-		od->dev_wakeup_lat += odpl->activate_lat;
-
-		od->pm_lat_level++;
-	}
-
-	return 0;
-}
-
 static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 		       const char *clk_name)
 {
@@ -315,9 +115,6 @@ static void _add_hwmod_clocks_clkdev(struct omap_device *od,
  * @oh: ptr to the single omap_hwmod that backs this omap_device
  * @pdata: platform_data ptr to associate with the platform_device
  * @pdata_len: amount of memory pointed to by @pdata
- * @pm_lats: pointer to a omap_device_pm_latency array for this device
- * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
- * @is_early_device: should the device be registered as an early device or not
  *
  * Function for building an omap_device already registered from device-tree
  *
@@ -356,7 +153,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 		hwmods[i] = oh;
 	}
 
-	od = omap_device_alloc(pdev, hwmods, oh_cnt, NULL, 0);
+	od = omap_device_alloc(pdev, hwmods, oh_cnt);
 	if (!od) {
 		dev_err(&pdev->dev, "Cannot allocate omap_device for :%s\n",
 			oh_name);
@@ -407,6 +204,39 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+/**
+ * _omap_device_enable_hwmods - call omap_hwmod_enable() on all hwmods
+ * @od: struct omap_device *od
+ *
+ * Enable all underlying hwmods.  Returns 0.
+ */
+static int _omap_device_enable_hwmods(struct omap_device *od)
+{
+	int i;
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		omap_hwmod_enable(od->hwmods[i]);
+
+	/* XXX pass along return value here? */
+	return 0;
+}
+
+/**
+ * _omap_device_idle_hwmods - call omap_hwmod_idle() on all hwmods
+ * @od: struct omap_device *od
+ *
+ * Idle all underlying hwmods.  Returns 0.
+ */
+static int _omap_device_idle_hwmods(struct omap_device *od)
+{
+	int i;
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		omap_hwmod_idle(od->hwmods[i]);
+
+	/* XXX pass along return value here? */
+	return 0;
+}
 
 /* Public functions for use by core code */
 
@@ -526,18 +356,14 @@ static int _od_fill_dma_resources(struct omap_device *od,
  * @oh: ptr to the single omap_hwmod that backs this omap_device
  * @pdata: platform_data ptr to associate with the platform_device
  * @pdata_len: amount of memory pointed to by @pdata
- * @pm_lats: pointer to a omap_device_pm_latency array for this device
- * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
  *
  * Convenience function for allocating an omap_device structure and filling
- * hwmods, resources and pm_latency attributes.
+ * hwmods, and resources.
  *
  * Returns an struct omap_device pointer or ERR_PTR() on error;
  */
 struct omap_device *omap_device_alloc(struct platform_device *pdev,
-					struct omap_hwmod **ohs, int oh_cnt,
-					struct omap_device_pm_latency *pm_lats,
-					int pm_lats_cnt)
+					struct omap_hwmod **ohs, int oh_cnt)
 {
 	int ret = -ENOMEM;
 	struct omap_device *od;
@@ -626,18 +452,6 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
 		goto oda_exit3;
 
 have_everything:
-	if (!pm_lats) {
-		pm_lats = omap_default_latency;
-		pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
-	}
-
-	od->pm_lats_cnt = pm_lats_cnt;
-	od->pm_lats = kmemdup(pm_lats,
-			sizeof(struct omap_device_pm_latency) * pm_lats_cnt,
-			GFP_KERNEL);
-	if (!od->pm_lats)
-		goto oda_exit3;
-
 	pdev->archdata.od = od;
 
 	for (i = 0; i < oh_cnt; i++) {
@@ -663,7 +477,6 @@ void omap_device_delete(struct omap_device *od)
 		return;
 
 	od->pdev->archdata.od = NULL;
-	kfree(od->pm_lats);
 	kfree(od->hwmods);
 	kfree(od);
 }
@@ -675,9 +488,6 @@ void omap_device_delete(struct omap_device *od)
  * @oh: ptr to the single omap_hwmod that backs this omap_device
  * @pdata: platform_data ptr to associate with the platform_device
  * @pdata_len: amount of memory pointed to by @pdata
- * @pm_lats: pointer to a omap_device_pm_latency array for this device
- * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
- * @is_early_device: should the device be registered as an early device or not
  *
  * Convenience function for building and registering a single
  * omap_device record, which in turn builds and registers a
@@ -685,11 +495,10 @@ void omap_device_delete(struct omap_device *od)
  * information.  Returns ERR_PTR(-EINVAL) if @oh is NULL; otherwise,
  * passes along the return value of omap_device_build_ss().
  */
-struct platform_device __init *omap_device_build(const char *pdev_name, int pdev_id,
-				      struct omap_hwmod *oh, void *pdata,
-				      int pdata_len,
-				      struct omap_device_pm_latency *pm_lats,
-				      int pm_lats_cnt, int is_early_device)
+struct platform_device __init *omap_device_build(const char *pdev_name,
+						 int pdev_id,
+						 struct omap_hwmod *oh,
+						 void *pdata, int pdata_len)
 {
 	struct omap_hwmod *ohs[] = { oh };
 
@@ -697,8 +506,7 @@ struct platform_device __init *omap_device_build(const char *pdev_name, int pdev
 		return ERR_PTR(-EINVAL);
 
 	return omap_device_build_ss(pdev_name, pdev_id, ohs, 1, pdata,
-				    pdata_len, pm_lats, pm_lats_cnt,
-				    is_early_device);
+				    pdata_len);
 }
 
 /**
@@ -708,9 +516,6 @@ struct platform_device __init *omap_device_build(const char *pdev_name, int pdev
  * @oh: ptr to the single omap_hwmod that backs this omap_device
  * @pdata: platform_data ptr to associate with the platform_device
  * @pdata_len: amount of memory pointed to by @pdata
- * @pm_lats: pointer to a omap_device_pm_latency array for this device
- * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
- * @is_early_device: should the device be registered as an early device or not
  *
  * Convenience function for building and registering an omap_device
  * subsystem record.  Subsystem records consist of multiple
@@ -718,11 +523,11 @@ struct platform_device __init *omap_device_build(const char *pdev_name, int pdev
  * platform_device record.  Returns an ERR_PTR() on error, or passes
  * along the return value of omap_device_register().
  */
-struct platform_device __init *omap_device_build_ss(const char *pdev_name, int pdev_id,
-					 struct omap_hwmod **ohs, int oh_cnt,
-					 void *pdata, int pdata_len,
-					 struct omap_device_pm_latency *pm_lats,
-					 int pm_lats_cnt, int is_early_device)
+struct platform_device __init *omap_device_build_ss(const char *pdev_name,
+						    int pdev_id,
+						    struct omap_hwmod **ohs,
+						    int oh_cnt, void *pdata,
+						    int pdata_len)
 {
 	int ret = -ENOMEM;
 	struct platform_device *pdev;
@@ -746,7 +551,7 @@ struct platform_device __init *omap_device_build_ss(const char *pdev_name, int p
 	else
 		dev_set_name(&pdev->dev, "%s", pdev->name);
 
-	od = omap_device_alloc(pdev, ohs, oh_cnt, pm_lats, pm_lats_cnt);
+	od = omap_device_alloc(pdev, ohs, oh_cnt);
 	if (IS_ERR(od))
 		goto odbs_exit1;
 
@@ -754,10 +559,7 @@ struct platform_device __init *omap_device_build_ss(const char *pdev_name, int p
 	if (ret)
 		goto odbs_exit2;
 
-	if (is_early_device)
-		ret = omap_early_device_register(pdev);
-	else
-		ret = omap_device_register(pdev);
+	ret = omap_device_register(pdev);
 	if (ret)
 		goto odbs_exit2;
 
@@ -774,24 +576,6 @@ odbs_exit:
 	return ERR_PTR(ret);
 }
 
-/**
- * omap_early_device_register - register an omap_device as an early platform
- * device.
- * @od: struct omap_device * to register
- *
- * Register the omap_device structure.  This currently just calls
- * platform_early_add_device() on the underlying platform_device.
- * Returns 0 by default.
- */
-static int __init omap_early_device_register(struct platform_device *pdev)
-{
-	struct platform_device *devices[1];
-
-	devices[0] = pdev;
-	early_platform_add_devices(devices, 1);
-	return 0;
-}
-
 #ifdef CONFIG_PM_RUNTIME
 static int _od_runtime_suspend(struct device *dev)
 {
@@ -902,10 +686,9 @@ int omap_device_register(struct platform_device *pdev)
  * to be accessible and ready to operate.  This generally involves
  * enabling clocks, setting SYSCONFIG registers; and in the future may
  * involve remuxing pins.  Device drivers should call this function
- * (through platform_data function pointers) where they would normally
- * enable clocks, etc.  Returns -EINVAL if called when the omap_device
- * is already enabled, or passes along the return value of
- * _omap_device_activate().
+ * indirectly via pm_runtime_get*().  Returns -EINVAL if called when
+ * the omap_device is already enabled, or passes along the return
+ * value of _omap_device_enable_hwmods().
  */
 int omap_device_enable(struct platform_device *pdev)
 {
@@ -921,14 +704,8 @@ int omap_device_enable(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Enable everything if we're enabling this device from scratch */
-	if (od->_state == OMAP_DEVICE_STATE_UNKNOWN)
-		od->pm_lat_level = od->pm_lats_cnt;
-
-	ret = _omap_device_activate(od, IGNORE_WAKEUP_LAT);
+	ret = _omap_device_enable_hwmods(od);
 
-	od->dev_wakeup_lat = 0;
-	od->_dev_wakeup_lat_limit = UINT_MAX;
 	od->_state = OMAP_DEVICE_STATE_ENABLED;
 
 	return ret;
@@ -938,14 +715,10 @@ int omap_device_enable(struct platform_device *pdev)
  * omap_device_idle - idle an omap_device
  * @od: struct omap_device * to idle
  *
- * Idle omap_device @od by calling as many .deactivate_func() entries
- * in the omap_device's pm_lats table as is possible without exceeding
- * the device's maximum wakeup latency limit, pm_lat_limit.  Device
- * drivers should call this function (through platform_data function
- * pointers) where they would normally disable clocks after operations
- * complete, etc..  Returns -EINVAL if the omap_device is not
+ * Idle omap_device @od.  Device drivers call this function indirectly
+ * via pm_runtime_put*().  Returns -EINVAL if the omap_device is not
  * currently enabled, or passes along the return value of
- * _omap_device_deactivate().
+ * _omap_device_idle_hwmods().
  */
 int omap_device_idle(struct platform_device *pdev)
 {
@@ -961,7 +734,7 @@ int omap_device_idle(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = _omap_device_deactivate(od, USE_WAKEUP_LAT);
+	ret = _omap_device_idle_hwmods(od);
 
 	od->_state = OMAP_DEVICE_STATE_IDLE;
 
@@ -969,42 +742,6 @@ int omap_device_idle(struct platform_device *pdev)
 }
 
 /**
- * omap_device_shutdown - shut down an omap_device
- * @od: struct omap_device * to shut down
- *
- * Shut down omap_device @od by calling all .deactivate_func() entries
- * in the omap_device's pm_lats table and then shutting down all of
- * the underlying omap_hwmods.  Used when a device is being "removed"
- * or a device driver is being unloaded.  Returns -EINVAL if the
- * omap_device is not currently enabled or idle, or passes along the
- * return value of _omap_device_deactivate().
- */
-int omap_device_shutdown(struct platform_device *pdev)
-{
-	int ret, i;
-	struct omap_device *od;
-
-	od = to_omap_device(pdev);
-
-	if (od->_state != OMAP_DEVICE_STATE_ENABLED &&
-	    od->_state != OMAP_DEVICE_STATE_IDLE) {
-		dev_warn(&pdev->dev,
-			 "omap_device: %s() called from invalid state %d\n",
-			 __func__, od->_state);
-		return -EINVAL;
-	}
-
-	ret = _omap_device_deactivate(od, IGNORE_WAKEUP_LAT);
-
-	for (i = 0; i < od->hwmods_cnt; i++)
-		omap_hwmod_shutdown(od->hwmods[i]);
-
-	od->_state = OMAP_DEVICE_STATE_SHUTDOWN;
-
-	return ret;
-}
-
-/**
  * omap_device_assert_hardreset - set a device's hardreset line
  * @pdev: struct platform_device * to reset
  * @name: const char * name of the reset line
@@ -1060,86 +797,6 @@ int omap_device_deassert_hardreset(struct platform_device *pdev,
 }
 
 /**
- * omap_device_align_pm_lat - activate/deactivate device to match wakeup lat lim
- * @od: struct omap_device *
- *
- * When a device's maximum wakeup latency limit changes, call some of
- * the .activate_func or .deactivate_func function pointers in the
- * omap_device's pm_lats array to ensure that the device's maximum
- * wakeup latency is less than or equal to the new latency limit.
- * Intended to be called by OMAP PM code whenever a device's maximum
- * wakeup latency limit changes (e.g., via
- * omap_pm_set_dev_wakeup_lat()).  Returns 0 if nothing needs to be
- * done (e.g., if the omap_device is not currently idle, or if the
- * wakeup latency is already current with the new limit) or passes
- * along the return value of _omap_device_deactivate() or
- * _omap_device_activate().
- */
-int omap_device_align_pm_lat(struct platform_device *pdev,
-			     u32 new_wakeup_lat_limit)
-{
-	int ret = -EINVAL;
-	struct omap_device *od;
-
-	od = to_omap_device(pdev);
-
-	if (new_wakeup_lat_limit == od->dev_wakeup_lat)
-		return 0;
-
-	od->_dev_wakeup_lat_limit = new_wakeup_lat_limit;
-
-	if (od->_state != OMAP_DEVICE_STATE_IDLE)
-		return 0;
-	else if (new_wakeup_lat_limit > od->dev_wakeup_lat)
-		ret = _omap_device_deactivate(od, USE_WAKEUP_LAT);
-	else if (new_wakeup_lat_limit < od->dev_wakeup_lat)
-		ret = _omap_device_activate(od, USE_WAKEUP_LAT);
-
-	return ret;
-}
-
-/**
- * omap_device_get_pwrdm - return the powerdomain * associated with @od
- * @od: struct omap_device *
- *
- * Return the powerdomain associated with the first underlying
- * omap_hwmod for this omap_device.  Intended for use by core OMAP PM
- * code.  Returns NULL on error or a struct powerdomain * upon
- * success.
- */
-struct powerdomain *omap_device_get_pwrdm(struct omap_device *od)
-{
-	/*
-	 * XXX Assumes that all omap_hwmod powerdomains are identical.
-	 * This may not necessarily be true.  There should be a sanity
-	 * check in here to WARN() if any difference appears.
-	 */
-	if (!od->hwmods_cnt)
-		return NULL;
-
-	return omap_hwmod_get_pwrdm(od->hwmods[0]);
-}
-
-/**
- * omap_device_get_mpu_rt_va - return the MPU's virtual addr for the hwmod base
- * @od: struct omap_device *
- *
- * Return the MPU's virtual address for the base of the hwmod, from
- * the ioremap() that the hwmod code does.  Only valid if there is one
- * hwmod associated with this device.  Returns NULL if there are zero
- * or more than one hwmods associated with this omap_device;
- * otherwise, passes along the return value from
- * omap_hwmod_get_mpu_rt_va().
- */
-void __iomem *omap_device_get_rt_va(struct omap_device *od)
-{
-	if (od->hwmods_cnt != 1)
-		return NULL;
-
-	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
-}
-
-/**
  * omap_device_get_by_hwmod_name() - convert a hwmod name to
  * device pointer.
  * @oh_name: name of the hwmod device
@@ -1173,82 +830,6 @@ struct device *omap_device_get_by_hwmod_name(const char *oh_name)
 
 	return &oh->od->pdev->dev;
 }
-EXPORT_SYMBOL(omap_device_get_by_hwmod_name);
-
-/*
- * Public functions intended for use in omap_device_pm_latency
- * .activate_func and .deactivate_func function pointers
- */
-
-/**
- * omap_device_enable_hwmods - call omap_hwmod_enable() on all hwmods
- * @od: struct omap_device *od
- *
- * Enable all underlying hwmods.  Returns 0.
- */
-int omap_device_enable_hwmods(struct omap_device *od)
-{
-	int i;
-
-	for (i = 0; i < od->hwmods_cnt; i++)
-		omap_hwmod_enable(od->hwmods[i]);
-
-	/* XXX pass along return value here? */
-	return 0;
-}
-
-/**
- * omap_device_idle_hwmods - call omap_hwmod_idle() on all hwmods
- * @od: struct omap_device *od
- *
- * Idle all underlying hwmods.  Returns 0.
- */
-int omap_device_idle_hwmods(struct omap_device *od)
-{
-	int i;
-
-	for (i = 0; i < od->hwmods_cnt; i++)
-		omap_hwmod_idle(od->hwmods[i]);
-
-	/* XXX pass along return value here? */
-	return 0;
-}
-
-/**
- * omap_device_disable_clocks - disable all main and interface clocks
- * @od: struct omap_device *od
- *
- * Disable the main functional clock and interface clock for all of the
- * omap_hwmods associated with the omap_device.  Returns 0.
- */
-int omap_device_disable_clocks(struct omap_device *od)
-{
-	int i;
-
-	for (i = 0; i < od->hwmods_cnt; i++)
-		omap_hwmod_disable_clocks(od->hwmods[i]);
-
-	/* XXX pass along return value here? */
-	return 0;
-}
-
-/**
- * omap_device_enable_clocks - enable all main and interface clocks
- * @od: struct omap_device *od
- *
- * Enable the main functional clock and interface clock for all of the
- * omap_hwmods associated with the omap_device.  Returns 0.
- */
-int omap_device_enable_clocks(struct omap_device *od)
-{
-	int i;
-
-	for (i = 0; i < od->hwmods_cnt; i++)
-		omap_hwmod_enable_clocks(od->hwmods[i]);
-
-	/* XXX pass along return value here? */
-	return 0;
-}
 
 static struct notifier_block platform_nb = {
 	.notifier_call = _omap_device_notifier_call,
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index 0933c59..044c31d 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -13,20 +13,12 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Eventually this type of functionality should either be
- * a) implemented via arch-specific pointers in platform_device
- * or
- * b) implemented as a proper omap_bus/omap_device in Linux, no more
- *    platform_device
+ * This type of functionality should be implemented as a proper
+ * omap_bus/omap_device in Linux.
  *
  * omap_device differs from omap_hwmod in that it includes external
  * (e.g., board- and system-level) integration details.  omap_hwmod
  * stores hardware data that is invariant for a given OMAP chip.
- *
- * To do:
- * - GPIO integration
- * - regulator integration
- *
  */
 #ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_DEVICE_H
 #define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_DEVICE_H
@@ -45,19 +37,14 @@ extern struct dev_pm_domain omap_device_pm_domain;
 #define OMAP_DEVICE_STATE_SHUTDOWN	3
 
 /* omap_device.flags values */
-#define OMAP_DEVICE_SUSPENDED BIT(0)
-#define OMAP_DEVICE_NO_IDLE_ON_SUSPEND BIT(1)
+#define OMAP_DEVICE_SUSPENDED		BIT(0)
+#define OMAP_DEVICE_NO_IDLE_ON_SUSPEND	BIT(1)
 
 /**
  * struct omap_device - omap_device wrapper for platform_devices
  * @pdev: platform_device
  * @hwmods: (one .. many per omap_device)
  * @hwmods_cnt: ARRAY_SIZE() of @hwmods
- * @pm_lats: ptr to an omap_device_pm_latency table
- * @pm_lats_cnt: ARRAY_SIZE() of what is passed to @pm_lats
- * @pm_lat_level: array index of the last odpl entry executed - -1 if never
- * @dev_wakeup_lat: dev wakeup latency in nanoseconds
- * @_dev_wakeup_lat_limit: dev wakeup latency limit in nsec - set by OMAP PM
  * @_state: one of OMAP_DEVICE_STATE_* (see above)
  * @flags: device flags
  * @_driver_status: one of BUS_NOTIFY_*_DRIVER from <linux/device.h>
@@ -71,12 +58,7 @@ extern struct dev_pm_domain omap_device_pm_domain;
 struct omap_device {
 	struct platform_device		*pdev;
 	struct omap_hwmod		**hwmods;
-	struct omap_device_pm_latency	*pm_lats;
-	u32				dev_wakeup_lat;
-	u32				_dev_wakeup_lat_limit;
 	unsigned long			_driver_status;
-	u8				pm_lats_cnt;
-	s8				pm_lat_level;
 	u8				hwmods_cnt;
 	u8				_state;
 	u8                              flags;
@@ -86,36 +68,25 @@ struct omap_device {
 
 int omap_device_enable(struct platform_device *pdev);
 int omap_device_idle(struct platform_device *pdev);
-int omap_device_shutdown(struct platform_device *pdev);
 
 /* Core code interface */
 
 struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
-				      struct omap_hwmod *oh, void *pdata,
-				      int pdata_len,
-				      struct omap_device_pm_latency *pm_lats,
-				      int pm_lats_cnt, int is_early_device);
+					  struct omap_hwmod *oh, void *pdata,
+					  int pdata_len);
 
 struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **oh, int oh_cnt,
-					 void *pdata, int pdata_len,
-					 struct omap_device_pm_latency *pm_lats,
-					 int pm_lats_cnt, int is_early_device);
+					 void *pdata, int pdata_len);
 
 struct omap_device *omap_device_alloc(struct platform_device *pdev,
-				      struct omap_hwmod **ohs, int oh_cnt,
-				      struct omap_device_pm_latency *pm_lats,
-				      int pm_lats_cnt);
+				      struct omap_hwmod **ohs, int oh_cnt);
 void omap_device_delete(struct omap_device *od);
 int omap_device_register(struct platform_device *pdev);
 
-void __iomem *omap_device_get_rt_va(struct omap_device *od);
 struct device *omap_device_get_by_hwmod_name(const char *oh_name);
 
 /* OMAP PM interface */
-int omap_device_align_pm_lat(struct platform_device *pdev,
-			     u32 new_wakeup_lat_limit);
-struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
 int omap_device_get_context_loss_count(struct platform_device *pdev);
 
 /* Other */
@@ -124,40 +95,6 @@ int omap_device_assert_hardreset(struct platform_device *pdev,
 				 const char *name);
 int omap_device_deassert_hardreset(struct platform_device *pdev,
 				 const char *name);
-int omap_device_idle_hwmods(struct omap_device *od);
-int omap_device_enable_hwmods(struct omap_device *od);
-
-int omap_device_disable_clocks(struct omap_device *od);
-int omap_device_enable_clocks(struct omap_device *od);
-
-/*
- * Entries should be kept in latency order ascending
- *
- * deact_lat is the maximum number of microseconds required to complete
- * deactivate_func() at the device's slowest OPP.
- *
- * act_lat is the maximum number of microseconds required to complete
- * activate_func() at the device's slowest OPP.
- *
- * This will result in some suboptimal power management decisions at fast
- * OPPs, but avoids having to recompute all device power management decisions
- * if the system shifts from a fast OPP to a slow OPP (in order to meet
- * latency requirements).
- *
- * XXX should deactivate_func/activate_func() take platform_device pointers
- * rather than omap_device pointers?
- */
-struct omap_device_pm_latency {
-	u32 deactivate_lat;
-	u32 deactivate_lat_worst;
-	int (*deactivate_func)(struct omap_device *od);
-	u32 activate_lat;
-	u32 activate_lat_worst;
-	int (*activate_func)(struct omap_device *od);
-	u32 flags;
-};
-
-#define OMAP_DEVICE_LATENCY_AUTO_ADJUST BIT(1)
 
 /* Get omap_device pointer from platform_device pointer */
 static inline struct omap_device *to_omap_device(struct platform_device *pdev)
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index f4b3143..9627547 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -32,8 +32,6 @@
 #include "pm.h"
 #include "twl-common.h"
 
-static struct omap_device_pm_latency *pm_lats;
-
 /*
  * omap_pm_suspend: points to a function that does the SoC-specific
  * suspend work
@@ -82,7 +80,7 @@ static int __init _init_omap_device(char *name)
 		 __func__, name))
 		return -ENODEV;
 
-	pdev = omap_device_build(oh->name, 0, oh, NULL, 0, pm_lats, 0, false);
+	pdev = omap_device_build(oh->name, 0, oh, NULL, 0);
 	if (WARN(IS_ERR(pdev), "%s: could not build omap_device for %s\n",
 		 __func__, name))
 		return -ENODEV;
diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index eb78ae7..0ef4d6a 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -48,8 +48,7 @@ static int __init omap2_init_pmu(unsigned oh_num, char *oh_names[])
 		}
 	}
 
-	omap_pmu_dev = omap_device_build_ss(dev_name, -1, oh, oh_num, NULL, 0,
-					    NULL, 0, 0);
+	omap_pmu_dev = omap_device_build_ss(dev_name, -1, oh, oh_num, NULL, 0);
 	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
 	     dev_name);
 
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 04fdbc4..d01c373 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -316,8 +316,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	if (WARN_ON(!oh))
 		return;
 
-	pdev = omap_device_build(name, uart->num, oh, pdata, pdata_size,
-				 NULL, 0, false);
+	pdev = omap_device_build(name, uart->num, oh, pdata, pdata_size);
 	if (IS_ERR(pdev)) {
 		WARN(1, "Could not build omap_device for %s: %s.\n", name,
 		     oh->name);
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index b9753fe..bb829e0 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -152,8 +152,7 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 
 	sr_data->enable_on_init = sr_enable_on_init;
 
-	pdev = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
-				 NULL, 0, 0);
+	pdev = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data), 0);
 	if (IS_ERR(pdev))
 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
 			__func__, name, oh->name);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 691aa67..adc9553 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -706,8 +706,7 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	pdata->timer_errata = omap_dm_timer_get_errata();
 	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 
-	pdev = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
-				 NULL, 0, 0);
+	pdev = omap_device_build(name, id, oh, pdata, sizeof(*pdata));
 
 	if (IS_ERR(pdev)) {
 		pr_err("%s: Can't build omap_device for %s: %s.\n",
diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 2e44e8a..99f04de 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -42,14 +42,6 @@ static struct usbtll_omap_platform_data		usbtll_data;
 static struct ehci_hcd_omap_platform_data	ehci_data;
 static struct ohci_hcd_omap_platform_data	ohci_data;
 
-static struct omap_device_pm_latency omap_uhhtll_latency[] = {
-	  {
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func	 = omap_device_enable_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	  },
-};
-
 /* MUX settings for EHCI pins */
 /*
  * setup_ehci_io_mux - initialize IO pad mux for USBHOST
@@ -530,9 +522,7 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 	}
 
 	pdev = omap_device_build(OMAP_USBTLL_DEVICE, bus_id, tll_hwm,
-				&usbtll_data, sizeof(usbtll_data),
-				omap_uhhtll_latency,
-				ARRAY_SIZE(omap_uhhtll_latency), false);
+				 &usbtll_data, sizeof(usbtll_data));
 	if (IS_ERR(pdev)) {
 		pr_err("Could not build hwmod device %s\n",
 		       USBHS_TLL_HWMODNAME);
@@ -540,9 +530,7 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 	}
 
 	pdev = omap_device_build(OMAP_USBHS_DEVICE, bus_id, uhh_hwm,
-				&usbhs_data, sizeof(usbhs_data),
-				omap_uhhtll_latency,
-				ARRAY_SIZE(omap_uhhtll_latency), false);
+				&usbhs_data, sizeof(usbhs_data));
 	if (IS_ERR(pdev)) {
 		pr_err("Could not build hwmod devices %s\n",
 		       USBHS_UHH_HWMODNAME);
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 7b33b37..8c4de27 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -102,7 +102,7 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
                 return;
 
 	pdev = omap_device_build(name, bus_id, oh, &musb_plat,
-			       sizeof(musb_plat), NULL, 0, false);
+				 sizeof(musb_plat));
 	if (IS_ERR(pdev)) {
 		pr_err("Could not build omap_device for %s %s\n",
 						name, oh_name);
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index 7c2b4ed..910243f 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -124,8 +124,7 @@ static int __init omap_init_wdt(void)
 	pdata.read_reset_sources = prm_read_reset_sources;
 
 	pdev = omap_device_build(dev_name, id, oh, &pdata,
-				 sizeof(struct omap_wd_timer_platform_data),
-				 NULL, 0, 0);
+				 sizeof(struct omap_wd_timer_platform_data));
 	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s.\n",
 	     dev_name, oh->name);
 	return 0;
-- 
1.7.10.4

