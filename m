From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 6/6] OMAP2+: devices: Remove all omap_device_pm_latency structures
Date: Tue, 27 Sep 2011 19:18:06 +0200
Message-ID: <1317143886-13285-7-git-send-email-b-cousson@ti.com>
References: <1317143886-13285-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58371 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631Ab1I0RTG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 13:19:06 -0400
In-Reply-To: <1317143886-13285-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Remove all these duplicated structures since a default one is now
available.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/devices.c    |   46 +++----------------------------------
 arch/arm/mach-omap2/display.c    |   11 +--------
 arch/arm/mach-omap2/dma.c        |   11 +--------
 arch/arm/mach-omap2/gpio.c       |   12 +---------
 arch/arm/mach-omap2/hsmmc.c      |   18 +--------------
 arch/arm/mach-omap2/hwspinlock.c |   12 +---------
 arch/arm/mach-omap2/mcbsp.c      |   11 +--------
 arch/arm/mach-omap2/serial.c     |   25 +-------------------
 arch/arm/mach-omap2/sr_device.c  |   11 +--------
 arch/arm/mach-omap2/usb-musb.c   |   11 +--------
 arch/arm/plat-omap/i2c.c         |   10 +-------
 11 files changed, 14 insertions(+), 164 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 10adf66..2d4a199 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -221,14 +221,6 @@ static inline void omap_init_camera(void)
 #endif
 }
 
-struct omap_device_pm_latency omap_keyboard_latency[] = {
-	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func   = omap_device_enable_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 			*sdp4430_keypad_data, struct omap_board_data *bdata)
 {
@@ -248,9 +240,7 @@ int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 	keypad_data = sdp4430_keypad_data;
 
 	pdev = omap_device_build(name, id, oh, keypad_data,
-			sizeof(struct omap4_keypad_platform_data),
-			omap_keyboard_latency,
-			ARRAY_SIZE(omap_keyboard_latency), 0);
+			sizeof(struct omap4_keypad_platform_data), NULL, 0, 0);
 
 	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n",
@@ -263,14 +253,6 @@ int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 }
 
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
-static struct omap_device_pm_latency mbox_latencies[] = {
-	[0] = {
-		.activate_func = omap_device_enable_hwmods,
-		.deactivate_func = omap_device_idle_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static inline void omap_init_mbox(void)
 {
 	struct omap_hwmod *oh;
@@ -282,8 +264,7 @@ static inline void omap_init_mbox(void)
 		return;
 	}
 
-	pdev = omap_device_build("omap-mailbox", -1, oh, NULL, 0,
-				mbox_latencies, ARRAY_SIZE(mbox_latencies), 0);
+	pdev = omap_device_build("omap-mailbox", -1, oh, NULL, 0, NULL, 0, 0);
 	WARN(IS_ERR(pdev), "%s: could not build device, err %ld\n",
 						__func__, PTR_ERR(pdev));
 }
@@ -334,14 +315,6 @@ static inline void omap_init_audio(void) {}
 
 #include <plat/mcspi.h>
 
-struct omap_device_pm_latency omap_mcspi_latency[] = {
-	[0] = {
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func   = omap_device_enable_hwmods,
-		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static int omap_mcspi_init(struct omap_hwmod *oh, void *unused)
 {
 	struct platform_device *pdev;
@@ -372,8 +345,7 @@ static int omap_mcspi_init(struct omap_hwmod *oh, void *unused)
 
 	spi_num++;
 	pdev = omap_device_build(name, spi_num, oh, pdata,
-				sizeof(*pdata),	omap_mcspi_latency,
-				ARRAY_SIZE(omap_mcspi_latency), 0);
+				sizeof(*pdata),	NULL, 0, 0);
 	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s\n",
 				name, oh->name);
 	kfree(pdata);
@@ -698,14 +670,6 @@ static int __init omap2_init_devices(void)
 arch_initcall(omap2_init_devices);
 
 #if defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
-static struct omap_device_pm_latency omap_wdt_latency[] = {
-	[0] = {
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func   = omap_device_enable_hwmods,
-		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static int __init omap_init_wdt(void)
 {
 	int id = -1;
@@ -723,9 +687,7 @@ static int __init omap_init_wdt(void)
 		return -EINVAL;
 	}
 
-	pdev = omap_device_build(dev_name, id, oh, NULL, 0,
-				omap_wdt_latency,
-				ARRAY_SIZE(omap_wdt_latency), 0);
+	pdev = omap_device_build(dev_name, id, oh, NULL, 0, NULL, 0, 0);
 	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s.\n",
 				dev_name, oh->name);
 	return 0;
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 18693f6..8ad0a2f 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -35,14 +35,6 @@ static struct platform_device omap_display_device = {
 	},
 };
 
-static struct omap_device_pm_latency omap_dss_latency[] = {
-	[0] = {
-		.deactivate_func        = omap_device_idle_hwmods,
-		.activate_func          = omap_device_enable_hwmods,
-		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 struct omap_dss_hwmod_data {
 	const char *oh_name;
 	const char *dev_name;
@@ -111,8 +103,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		pdev = omap_device_build(curr_dss_hwmod[i].dev_name,
 				curr_dss_hwmod[i].id, oh, &pdata,
 				sizeof(struct omap_display_platform_data),
-				omap_dss_latency,
-				ARRAY_SIZE(omap_dss_latency), 0);
+				NULL, 0, 0);
 
 		if (WARN((IS_ERR(pdev)), "Could not build omap_device for %s\n",
 				curr_dss_hwmod[i].oh_name))
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index ae8cb3f..a59a45a 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -87,14 +87,6 @@ static u16 reg_map[] = {
 	[CCDN]			= 0xd8,
 };
 
-static struct omap_device_pm_latency omap2_dma_latency[] = {
-	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func	 = omap_device_enable_hwmods,
-		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static void __iomem *dma_base;
 static inline void dma_write(u32 val, int reg, int lch)
 {
@@ -258,8 +250,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 
 	p->errata		= configure_dma_errata();
 
-	pdev = omap_device_build(name, 0, oh, p, sizeof(*p),
-			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
+	pdev = omap_device_build(name, 0, oh, p, sizeof(*p), NULL, 0, 0);
 	kfree(p);
 	if (IS_ERR(pdev)) {
 		pr_err("%s: Can't build omap_device for %s:%s.\n",
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 652ccc5..8cbfbc2 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -24,14 +24,6 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
-static struct omap_device_pm_latency omap_gpio_latency[] = {
-	[0] = {
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func   = omap_device_enable_hwmods,
-		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 {
 	struct platform_device *pdev;
@@ -108,9 +100,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	}
 
 	pdev = omap_device_build(name, id - 1, oh, pdata,
-				sizeof(*pdata),	omap_gpio_latency,
-				ARRAY_SIZE(omap_gpio_latency),
-				false);
+				sizeof(*pdata),	NULL, 0, false);
 	kfree(pdata);
 
 	if (IS_ERR(pdev)) {
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index cc87919..fe16da4 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -413,31 +413,17 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	return 0;
 }
 
-static struct omap_device_pm_latency omap_hsmmc_latency[] = {
-	[0] = {
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func	 = omap_device_enable_hwmods,
-		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-	/*
-	 * XXX There should also be an entry here to power off/on the
-	 * MMC regulators/PBIAS cells, etc.
-	 */
-};
-
 #define MAX_OMAP_MMC_HWMOD_NAME_LEN		16
 
 void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
-	struct omap_device_pm_latency *ohl;
 	char oh_name[MAX_OMAP_MMC_HWMOD_NAME_LEN];
 	struct omap_mmc_platform_data *mmc_data;
 	struct omap_mmc_dev_attr *mmc_dev_attr;
 	char *name;
 	int l;
-	int ohl_cnt = 0;
 
 	mmc_data = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
 	if (!mmc_data) {
@@ -452,8 +438,6 @@ void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 	omap_hsmmc_mux(mmc_data, (ctrl_nr - 1));
 
 	name = "omap_hsmmc";
-	ohl = omap_hsmmc_latency;
-	ohl_cnt = ARRAY_SIZE(omap_hsmmc_latency);
 
 	l = snprintf(oh_name, MAX_OMAP_MMC_HWMOD_NAME_LEN,
 		     "mmc%d", ctrl_nr);
@@ -472,7 +456,7 @@ void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 	}
 
 	pdev = omap_device_build(name, ctrl_nr - 1, oh, mmc_data,
-		sizeof(struct omap_mmc_platform_data), ohl, ohl_cnt, false);
+		sizeof(struct omap_mmc_platform_data), NULL, 0, false);
 	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n", name, oh->name);
 		kfree(mmc_data->slots[0].name);
diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index 0b3ae9d..36e2109 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -23,14 +23,6 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
-struct omap_device_pm_latency omap_spinlock_latency[] = {
-	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func   = omap_device_enable_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	}
-};
-
 int __init hwspinlocks_init(void)
 {
 	int retval = 0;
@@ -48,9 +40,7 @@ int __init hwspinlocks_init(void)
 	if (oh == NULL)
 		return -EINVAL;
 
-	pdev = omap_device_build(dev_name, 0, oh, NULL, 0,
-				omap_spinlock_latency,
-				ARRAY_SIZE(omap_spinlock_latency), false);
+	pdev = omap_device_build(dev_name, 0, oh, NULL, 0, NULL, 0, false);
 	if (IS_ERR(pdev)) {
 		pr_err("Can't build omap_device for %s:%s\n", dev_name,
 								oh_name);
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 7a42f32..9fb5d7d 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -102,14 +102,6 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 }
 EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
 
-struct omap_device_pm_latency omap2_mcbsp_latency[] = {
-	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func   = omap_device_enable_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 {
 	int id, count = 1;
@@ -145,8 +137,7 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		count++;
 	}
 	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
-				sizeof(*pdata), omap2_mcbsp_latency,
-				ARRAY_SIZE(omap2_mcbsp_latency), false);
+				sizeof(*pdata), NULL, 0, false);
 	kfree(pdata);
 	if (IS_ERR(pdev))  {
 		pr_err("%s: Can't build omap_device for %s:%s.\n", __func__,
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3d1c1d3..9992dbf 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -107,28 +107,6 @@ struct omap_uart_state {
 static LIST_HEAD(uart_list);
 static u8 num_uarts;
 
-static int uart_idle_hwmod(struct omap_device *od)
-{
-	omap_hwmod_idle(od->hwmods[0]);
-
-	return 0;
-}
-
-static int uart_enable_hwmod(struct omap_device *od)
-{
-	omap_hwmod_enable(od->hwmods[0]);
-
-	return 0;
-}
-
-static struct omap_device_pm_latency omap_uart_latency[] = {
-	{
-		.deactivate_func = uart_idle_hwmod,
-		.activate_func	 = uart_enable_hwmod,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static inline unsigned int __serial_read_reg(struct uart_port *up,
 					     int offset)
 {
@@ -800,8 +778,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 		return;
 
 	pdev = omap_device_build(name, uart->num, oh, pdata, pdata_size,
-			       omap_uart_latency,
-			       ARRAY_SIZE(omap_uart_latency), false);
+				 NULL, 0, false);
 	WARN(IS_ERR(pdev), "Could not build omap_device for %s: %s.\n",
 	     name, oh->name);
 
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 624264d..3b5cf50 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -31,14 +31,6 @@
 
 static bool sr_enable_on_init;
 
-static struct omap_device_pm_latency omap_sr_latency[] = {
-	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func	 = omap_device_enable_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST
-	},
-};
-
 /* Read EFUSE values from control registers for OMAP3430 */
 static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 				struct omap_sr_data *sr_data)
@@ -121,8 +113,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	sr_data->enable_on_init = sr_enable_on_init;
 
 	pdev = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
-			       omap_sr_latency,
-			       ARRAY_SIZE(omap_sr_latency), 0);
+				 NULL, 0, 0);
 	if (IS_ERR(pdev))
 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
 			__func__, name, oh->name);
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a65145b..c13ff3f 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -60,14 +60,6 @@ static struct musb_hdrc_platform_data musb_plat = {
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
 
-static struct omap_device_pm_latency omap_musb_latency[] = {
-	{
-		.deactivate_func	= omap_device_idle_hwmods,
-		.activate_func		= omap_device_enable_hwmods,
-		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
 {
 	switch (board_data->interface_type) {
@@ -155,8 +147,7 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	}
 
 	od = omap_device_build(name, bus_id, oh, &musb_plat,
-			       sizeof(musb_plat), omap_musb_latency,
-			       ARRAY_SIZE(omap_musb_latency), false);
+			       sizeof(musb_plat), NULL, 0, false);
 	if (IS_ERR(od)) {
 		pr_err("Could not build omap_device for %s %s\n",
 						name, oh_name);
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 0c7caf2..c20beb8 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -123,14 +123,6 @@ static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
 	omap_pm_set_max_mpu_wakeup_lat(dev, t);
 }
 
-static struct omap_device_pm_latency omap_i2c_latency[] = {
-	[0] = {
-		.deactivate_func	= omap_device_idle_hwmods,
-		.activate_func		= omap_device_enable_hwmods,
-		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static inline int omap2_i2c_add_bus(int bus_id)
 {
 	int l;
@@ -162,7 +154,7 @@ static inline int omap2_i2c_add_bus(int bus_id)
 		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
 	pdev = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
-			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
+			NULL, 0, 0);
 	WARN(IS_ERR(pdev), "Could not build omap_device for %s\n", name);
 
 	return PTR_ERR(pdev);
-- 
1.7.0.4

