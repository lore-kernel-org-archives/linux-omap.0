From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP: convert omap_device_build() and callers to __init
Date: Wed, 15 Feb 2012 14:05:22 -0800
Message-ID: <1329343522-15759-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48864 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755717Ab2BOWEs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 17:04:48 -0500
Received: by mail-pw0-f51.google.com with SMTP id rp2so2418361pbb.24
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 14:04:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

Building omap_devices should only be done at init time, and since
omap_device_build() is using early_platform calls which are also
__init, this ensures that omap_device isn't trying to use functions
that disappear.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, I tested this on top of your MMC series, and it gets rid of the
rest of the section mismatch warnings except the
omap_secondary_startup() one which is unrelated to this patch.

 arch/arm/mach-omap2/devices.c    |    8 ++++----
 arch/arm/mach-omap2/gpio.c       |    2 +-
 arch/arm/mach-omap2/mcbsp.c      |    2 +-
 arch/arm/mach-omap2/pm.c         |    2 +-
 arch/arm/mach-omap2/sr_device.c  |    2 +-
 arch/arm/plat-omap/omap_device.c |    7 ++++---
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 283d11e..01cffce 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -276,7 +276,7 @@ int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 }
 
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
-static inline void omap_init_mbox(void)
+static inline void __init omap_init_mbox(void)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
@@ -337,7 +337,7 @@ static inline void omap_init_audio(void) {}
 #if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
 		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
 
-static void omap_init_mcpdm(void)
+static void __init omap_init_mcpdm(void)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
@@ -358,7 +358,7 @@ static inline void omap_init_mcpdm(void) {}
 #if defined(CONFIG_SND_OMAP_SOC_DMIC) || \
 		defined(CONFIG_SND_OMAP_SOC_DMIC_MODULE)
 
-static void omap_init_dmic(void)
+static void __init omap_init_dmic(void)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
@@ -380,7 +380,7 @@ static inline void omap_init_dmic(void) {}
 
 #include <plat/mcspi.h>
 
-static int omap_mcspi_init(struct omap_hwmod *oh, void *unused)
+static int __init omap_mcspi_init(struct omap_hwmod *oh, void *unused)
 {
 	struct platform_device *pdev;
 	char *name = "omap2_mcspi";
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 8cbfbc2..64c0cae 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -24,7 +24,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
-static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
+static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 {
 	struct platform_device *pdev;
 	struct omap_gpio_platform_data *pdata;
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index fb4bcf8..5f8a876 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -122,7 +122,7 @@ static int omap3_enable_st_clock(unsigned int id, bool enable)
 	return 0;
 }
 
-static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
+static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 {
 	int id, count = 1;
 	char *name = "omap-mcbsp";
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1881fe9..fb9b85b 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -28,7 +28,7 @@
 
 static struct omap_device_pm_latency *pm_lats;
 
-static int _init_omap_device(char *name)
+static int __init _init_omap_device(char *name)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 9f43fcc..78c9437 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -69,7 +69,7 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 	sr_data->nvalue_count = count;
 }
 
-static int sr_dev_init(struct omap_hwmod *oh, void *user)
+static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 {
 	struct omap_sr_data *sr_data;
 	struct platform_device *pdev;
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index f72fafc..2d00ab0 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -1,3 +1,4 @@
+
 /*
  * omap_device implementation
  *
@@ -612,7 +613,7 @@ void omap_device_delete(struct omap_device *od)
  * information.  Returns ERR_PTR(-EINVAL) if @oh is NULL; otherwise,
  * passes along the return value of omap_device_build_ss().
  */
-struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
+struct platform_device __init *omap_device_build(const char *pdev_name, int pdev_id,
 				      struct omap_hwmod *oh, void *pdata,
 				      int pdata_len,
 				      struct omap_device_pm_latency *pm_lats,
@@ -645,7 +646,7 @@ struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
  * platform_device record.  Returns an ERR_PTR() on error, or passes
  * along the return value of omap_device_register().
  */
-struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
+struct platform_device __init *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **ohs, int oh_cnt,
 					 void *pdata, int pdata_len,
 					 struct omap_device_pm_latency *pm_lats,
@@ -710,7 +711,7 @@ odbs_exit:
  * platform_early_add_device() on the underlying platform_device.
  * Returns 0 by default.
  */
-static int omap_early_device_register(struct platform_device *pdev)
+static int __init omap_early_device_register(struct platform_device *pdev)
 {
 	struct platform_device *devices[1];
 
-- 
1.7.9

