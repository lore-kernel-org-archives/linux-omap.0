From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 06/14] OMAP: omap_device: when building return
	platform_device instead of omap_device
Date: Tue, 09 Aug 2011 19:10:24 +0500
Message-ID: <1312897232-4792-7-git-send-email-manjugk@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>

All of the device init and device driver interaction with omap_device
is done using platform_device pointers.  To make this more explicit,
have omap_device return a platform_device pointer instead of an
omap_device pointer.

All current users of the omap_device pointer were only using it to get
at the platform_device pointer or struct device pointer, so fixing all
of the users was trivial.

This also makes it more difficult for device init code to directly
access members of struct omap_device, and allows for easier changing
of omap_device internals.

Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/devices.c                 |   44 ++++++++++++------------
 arch/arm/mach-omap2/display.c                 |    6 ++--
 arch/arm/mach-omap2/dma.c                     |   16 ++++----
 arch/arm/mach-omap2/gpio.c                    |    8 ++--
 arch/arm/mach-omap2/hsmmc.c                   |    8 ++--
 arch/arm/mach-omap2/hwspinlock.c              |    8 ++--
 arch/arm/mach-omap2/mcbsp.c                   |    8 ++--
 arch/arm/mach-omap2/pm.c                      |    8 ++--
 arch/arm/mach-omap2/serial.c                  |   12 +++---
 arch/arm/plat-omap/i2c.c                      |    8 ++--
 arch/arm/plat-omap/include/plat/omap_device.h |    4 +-
 arch/arm/plat-omap/omap_device.c              |    6 ++--
 12 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5b8ca68..458f7be 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -44,7 +44,7 @@ static int __init omap3_l3_init(void)
 {
 	int l;
 	struct omap_hwmod *oh;
-	struct omap_device *od;
+	struct platform_device *pdev;
 	char oh_name[L3_MODULES_MAX_LEN];
 
 	/*
@@ -61,12 +61,12 @@ static int __init omap3_l3_init(void)
 	if (!oh)
 		pr_err("could not look up %s\n", oh_name);
 
-	od = omap_device_build("omap_l3_smx", 0, oh, NULL, 0,
+	pdev = omap_device_build("omap_l3_smx", 0, oh, NULL, 0,
 							   NULL, 0, 0);
 
-	WARN(IS_ERR(od), "could not build omap_device for %s\n", oh_name);
+	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
-	return IS_ERR(od) ? PTR_ERR(od) : 0;
+	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
 }
 postcore_initcall(omap3_l3_init);
 
@@ -74,7 +74,7 @@ static int __init omap4_l3_init(void)
 {
 	int l, i;
 	struct omap_hwmod *oh[3];
-	struct omap_device *od;
+	struct platform_device *pdev;
 	char oh_name[L3_MODULES_MAX_LEN];
 
 	/*
@@ -92,12 +92,12 @@ static int __init omap4_l3_init(void)
 			pr_err("could not look up %s\n", oh_name);
 	}
 
-	od = omap_device_build_ss("omap_l3_noc", 0, oh, 3, NULL,
+	pdev = omap_device_build_ss("omap_l3_noc", 0, oh, 3, NULL,
 						     0, NULL, 0, 0);
 
-	WARN(IS_ERR(od), "could not build omap_device for %s\n", oh_name);
+	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
-	return IS_ERR(od) ? PTR_ERR(od) : 0;
+	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
 }
 postcore_initcall(omap4_l3_init);
 
@@ -232,7 +232,7 @@ struct omap_device_pm_latency omap_keyboard_latency[] = {
 int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 						*sdp4430_keypad_data)
 {
-	struct omap_device *od;
+	struct platform_device *pdev;
 	struct omap_hwmod *oh;
 	struct omap4_keypad_platform_data *keypad_data;
 	unsigned int id = -1;
@@ -247,15 +247,15 @@ int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 
 	keypad_data = sdp4430_keypad_data;
 
-	od = omap_device_build(name, id, oh, keypad_data,
+	pdev = omap_device_build(name, id, oh, keypad_data,
 			sizeof(struct omap4_keypad_platform_data),
 			omap_keyboard_latency,
 			ARRAY_SIZE(omap_keyboard_latency), 0);
 
-	if (IS_ERR(od)) {
+	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n",
 						name, oh->name);
-		return PTR_ERR(od);
+		return PTR_ERR(pdev);
 	}
 
 	return 0;
@@ -273,7 +273,7 @@ static struct omap_device_pm_latency mbox_latencies[] = {
 static inline void omap_init_mbox(void)
 {
 	struct omap_hwmod *oh;
-	struct omap_device *od;
+	struct platform_device *pdev;
 
 	oh = omap_hwmod_lookup("mailbox");
 	if (!oh) {
@@ -281,10 +281,10 @@ static inline void omap_init_mbox(void)
 		return;
 	}
 
-	od = omap_device_build("omap-mailbox", -1, oh, NULL, 0,
+	pdev = omap_device_build("omap-mailbox", -1, oh, NULL, 0,
 				mbox_latencies, ARRAY_SIZE(mbox_latencies), 0);
-	WARN(IS_ERR(od), "%s: could not build device, err %ld\n",
-						__func__, PTR_ERR(od));
+	WARN(IS_ERR(pdev), "%s: could not build device, err %ld\n",
+						__func__, PTR_ERR(pdev));
 }
 #else
 static inline void omap_init_mbox(void) { }
@@ -343,7 +343,7 @@ struct omap_device_pm_latency omap_mcspi_latency[] = {
 
 static int omap_mcspi_init(struct omap_hwmod *oh, void *unused)
 {
-	struct omap_device *od;
+	struct platform_device *pdev;
 	char *name = "omap2_mcspi";
 	struct omap2_mcspi_platform_config *pdata;
 	static int spi_num;
@@ -370,10 +370,10 @@ static int omap_mcspi_init(struct omap_hwmod *oh, void *unused)
 	}
 
 	spi_num++;
-	od = omap_device_build(name, spi_num, oh, pdata,
+	pdev = omap_device_build(name, spi_num, oh, pdata,
 				sizeof(*pdata),	omap_mcspi_latency,
 				ARRAY_SIZE(omap_mcspi_latency), 0);
-	WARN(IS_ERR(od), "Can't build omap_device for %s:%s\n",
+	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s\n",
 				name, oh->name);
 	kfree(pdata);
 	return 0;
@@ -708,7 +708,7 @@ static struct omap_device_pm_latency omap_wdt_latency[] = {
 static int __init omap_init_wdt(void)
 {
 	int id = -1;
-	struct omap_device *od;
+	struct platform_device *pdev;
 	struct omap_hwmod *oh;
 	char *oh_name = "wd_timer2";
 	char *dev_name = "omap_wdt";
@@ -722,10 +722,10 @@ static int __init omap_init_wdt(void)
 		return -EINVAL;
 	}
 
-	od = omap_device_build(dev_name, id, oh, NULL, 0,
+	pdev = omap_device_build(dev_name, id, oh, NULL, 0,
 				omap_wdt_latency,
 				ARRAY_SIZE(omap_wdt_latency), 0);
-	WARN(IS_ERR(od), "Can't build omap_device for %s:%s.\n",
+	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s.\n",
 				dev_name, oh->name);
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 543fcb8..225347d 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -91,7 +91,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 {
 	int r = 0;
 	struct omap_hwmod *oh;
-	struct omap_device *od;
+	struct platform_device *pdev;
 	int i, oh_count;
 	struct omap_display_platform_data pdata;
 	const struct omap_dss_hwmod_data *curr_dss_hwmod;
@@ -128,13 +128,13 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 			return -ENODEV;
 		}
 
-		od = omap_device_build(curr_dss_hwmod[i].dev_name,
+		pdev = omap_device_build(curr_dss_hwmod[i].dev_name,
 				curr_dss_hwmod[i].id, oh, &pdata,
 				sizeof(struct omap_display_platform_data),
 				omap_dss_latency,
 				ARRAY_SIZE(omap_dss_latency), 0);
 
-		if (WARN((IS_ERR(od)), "Could not build omap_device for %s\n",
+		if (WARN((IS_ERR(pdev)), "Could not build omap_device for %s\n",
 				curr_dss_hwmod[i].oh_name))
 			return -ENODEV;
 	}
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index c9ff0e7..ae8cb3f 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -228,7 +228,7 @@ static u32 configure_dma_errata(void)
 /* One time initializations */
 static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 {
-	struct omap_device			*od;
+	struct platform_device			*pdev;
 	struct omap_system_dma_plat_info	*p;
 	struct resource				*mem;
 	char					*name = "omap_dma_system";
@@ -258,23 +258,23 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 
 	p->errata		= configure_dma_errata();
 
-	od = omap_device_build(name, 0, oh, p, sizeof(*p),
+	pdev = omap_device_build(name, 0, oh, p, sizeof(*p),
 			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
 	kfree(p);
-	if (IS_ERR(od)) {
+	if (IS_ERR(pdev)) {
 		pr_err("%s: Can't build omap_device for %s:%s.\n",
 			__func__, name, oh->name);
-		return PTR_ERR(od);
+		return PTR_ERR(pdev);
 	}
 
-	mem = platform_get_resource(&od->pdev, IORESOURCE_MEM, 0);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
-		dev_err(&od->pdev.dev, "%s: no mem resource\n", __func__);
+		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
 		return -EINVAL;
 	}
 	dma_base = ioremap(mem->start, resource_size(mem));
 	if (!dma_base) {
-		dev_err(&od->pdev.dev, "%s: ioremap fail\n", __func__);
+		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -283,7 +283,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 					(d->lch_count), GFP_KERNEL);
 
 	if (!d->chan) {
-		dev_err(&od->pdev.dev, "%s: kzalloc fail\n", __func__);
+		dev_err(&pdev->dev, "%s: kzalloc fail\n", __func__);
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 9529842..b3aaafb 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -34,7 +34,7 @@ static struct omap_device_pm_latency omap_gpio_latency[] = {
 
 static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 {
-	struct omap_device *od;
+	struct platform_device *pdev;
 	struct omap_gpio_platform_data *pdata;
 	struct omap_gpio_dev_attr *dev_attr;
 	char *name = "omap_gpio";
@@ -75,16 +75,16 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return -EINVAL;
 	}
 
-	od = omap_device_build(name, id - 1, oh, pdata,
+	pdev = omap_device_build(name, id - 1, oh, pdata,
 				sizeof(*pdata),	omap_gpio_latency,
 				ARRAY_SIZE(omap_gpio_latency),
 				false);
 	kfree(pdata);
 
-	if (IS_ERR(od)) {
+	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n",
 					name, oh->name);
-		return PTR_ERR(od);
+		return PTR_ERR(pdev);
 	}
 
 	gpio_bank_count++;
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 66868c5..a7305cf 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -431,7 +431,7 @@ static struct omap_device_pm_latency omap_hsmmc_latency[] = {
 void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 {
 	struct omap_hwmod *oh;
-	struct omap_device *od;
+	struct platform_device *pdev;
 	struct omap_device_pm_latency *ohl;
 	char oh_name[MAX_OMAP_MMC_HWMOD_NAME_LEN];
 	struct omap_mmc_platform_data *mmc_data;
@@ -472,9 +472,9 @@ void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 		mmc_data->controller_flags = mmc_dev_attr->flags;
 	}
 
-	od = omap_device_build(name, ctrl_nr - 1, oh, mmc_data,
+	pdev = omap_device_build(name, ctrl_nr - 1, oh, mmc_data,
 		sizeof(struct omap_mmc_platform_data), ohl, ohl_cnt, false);
-	if (IS_ERR(od)) {
+	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n", name, oh->name);
 		kfree(mmc_data->slots[0].name);
 		goto done;
@@ -483,7 +483,7 @@ void __init omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
 	 * return device handle to board setup code
 	 * required to populate for regulator framework structure
 	 */
-	hsmmcinfo->dev = &od->pdev.dev;
+	hsmmcinfo->dev = &pdev->dev;
 
 done:
 	kfree(mmc_data);
diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index 06d4a80..0b3ae9d 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -35,7 +35,7 @@ int __init hwspinlocks_init(void)
 {
 	int retval = 0;
 	struct omap_hwmod *oh;
-	struct omap_device *od;
+	struct platform_device *pdev;
 	const char *oh_name = "spinlock";
 	const char *dev_name = "omap_hwspinlock";
 
@@ -48,13 +48,13 @@ int __init hwspinlocks_init(void)
 	if (oh == NULL)
 		return -EINVAL;
 
-	od = omap_device_build(dev_name, 0, oh, NULL, 0,
+	pdev = omap_device_build(dev_name, 0, oh, NULL, 0,
 				omap_spinlock_latency,
 				ARRAY_SIZE(omap_spinlock_latency), false);
-	if (IS_ERR(od)) {
+	if (IS_ERR(pdev)) {
 		pr_err("Can't build omap_device for %s:%s\n", dev_name,
 								oh_name);
-		retval = PTR_ERR(od);
+		retval = PTR_ERR(pdev);
 	}
 
 	return retval;
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 4a6ef6a..7a42f32 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -116,7 +116,7 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 	char *name = "omap-mcbsp";
 	struct omap_hwmod *oh_device[2];
 	struct omap_mcbsp_platform_data *pdata = NULL;
-	struct omap_device *od;
+	struct platform_device *pdev;
 
 	sscanf(oh->name, "mcbsp%d", &id);
 
@@ -144,14 +144,14 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
 		count++;
 	}
-	od = omap_device_build_ss(name, id, oh_device, count, pdata,
+	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
 				sizeof(*pdata), omap2_mcbsp_latency,
 				ARRAY_SIZE(omap2_mcbsp_latency), false);
 	kfree(pdata);
-	if (IS_ERR(od))  {
+	if (IS_ERR(pdev))  {
 		pr_err("%s: Can't build omap_device for %s:%s.\n", __func__,
 					name, oh->name);
-		return PTR_ERR(od);
+		return PTR_ERR(pdev);
 	}
 	omap_mcbsp_count++;
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 49486f5..a6f0f0e 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -60,19 +60,19 @@ EXPORT_SYMBOL(omap4_get_dsp_device);
 static int _init_omap_device(char *name, struct device **new_dev)
 {
 	struct omap_hwmod *oh;
-	struct omap_device *od;
+	struct platform_device *pdev;
 
 	oh = omap_hwmod_lookup(name);
 	if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
 		 __func__, name))
 		return -ENODEV;
 
-	od = omap_device_build(oh->name, 0, oh, NULL, 0, pm_lats, 0, false);
-	if (WARN(IS_ERR(od), "%s: could not build omap_device for %s\n",
+	pdev = omap_device_build(oh->name, 0, oh, NULL, 0, pm_lats, 0, false);
+	if (WARN(IS_ERR(pdev), "%s: could not build omap_device for %s\n",
 		 __func__, name))
 		return -ENODEV;
 
-	*new_dev = &od->pdev.dev;
+	*new_dev = &pdev->dev;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 1ac361b..3781bcb 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -711,7 +711,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 {
 	struct omap_uart_state *uart;
 	struct omap_hwmod *oh;
-	struct omap_device *od;
+	struct platform_device *pdev;
 	void *pdata = NULL;
 	u32 pdata_size = 0;
 	char *name;
@@ -799,10 +799,10 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	if (WARN_ON(!oh))
 		return;
 
-	od = omap_device_build(name, uart->num, oh, pdata, pdata_size,
+	pdev = omap_device_build(name, uart->num, oh, pdata, pdata_size,
 			       omap_uart_latency,
 			       ARRAY_SIZE(omap_uart_latency), false);
-	WARN(IS_ERR(od), "Could not build omap_device for %s: %s.\n",
+	WARN(IS_ERR(pdev), "Could not build omap_device for %s: %s.\n",
 	     name, oh->name);
 
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
@@ -811,7 +811,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	uart->regshift = 2;
 	uart->mapbase = oh->slaves[0]->addr->pa_start;
 	uart->membase = omap_hwmod_get_mpu_rt_va(oh);
-	uart->pdev = &od->pdev;
+	uart->pdev = pdev;
 
 	oh->dev_attr = uart;
 
@@ -845,8 +845,8 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	if ((cpu_is_omap34xx() && uart->padconf) ||
 	    (uart->wk_en && uart->wk_mask)) {
-		device_init_wakeup(&od->pdev.dev, true);
-		DEV_CREATE_FILE(&od->pdev.dev, &dev_attr_sleep_timeout);
+		device_init_wakeup(&pdev->dev, true);
+		DEV_CREATE_FILE(&pdev->dev, &dev_attr_sleep_timeout);
 	}
 
 	/* Enable the MDR1 errata for OMAP3 */
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 3341ca4..0c7caf2 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -135,7 +135,7 @@ static inline int omap2_i2c_add_bus(int bus_id)
 {
 	int l;
 	struct omap_hwmod *oh;
-	struct omap_device *od;
+	struct platform_device *pdev;
 	char oh_name[MAX_OMAP_I2C_HWMOD_NAME_LEN];
 	struct omap_i2c_bus_platform_data *pdata;
 
@@ -160,12 +160,12 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	 */
 	if (cpu_is_omap34xx())
 		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
-	od = omap_device_build(name, bus_id, oh, pdata,
+	pdev = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
-	WARN(IS_ERR(od), "Could not build omap_device for %s\n", name);
+	WARN(IS_ERR(pdev), "Could not build omap_device for %s\n", name);
 
-	return PTR_ERR(od);
+	return PTR_ERR(pdev);
 }
 #else
 static inline int omap2_i2c_add_bus(int bus_id)
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 0a53a0a..7a3ec4f 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -83,13 +83,13 @@ int omap_device_shutdown(struct platform_device *pdev);
 
 /* Core code interface */
 
-struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
+struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
 				      struct omap_hwmod *oh, void *pdata,
 				      int pdata_len,
 				      struct omap_device_pm_latency *pm_lats,
 				      int pm_lats_cnt, int is_early_device);
 
-struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
+struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **oh, int oh_cnt,
 					 void *pdata, int pdata_len,
 					 struct omap_device_pm_latency *pm_lats,
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 4737b60..7d5e76b 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -391,7 +391,7 @@ static int omap_device_fill_resources(struct omap_device *od,
  * information.  Returns ERR_PTR(-EINVAL) if @oh is NULL; otherwise,
  * passes along the return value of omap_device_build_ss().
  */
-struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
+struct platform_device *omap_device_build(const char *pdev_name, int pdev_id,
 				      struct omap_hwmod *oh, void *pdata,
 				      int pdata_len,
 				      struct omap_device_pm_latency *pm_lats,
@@ -424,7 +424,7 @@ struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
  * platform_device record.  Returns an ERR_PTR() on error, or passes
  * along the return value of omap_device_register().
  */
-struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
+struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_hwmod **ohs, int oh_cnt,
 					 void *pdata, int pdata_len,
 					 struct omap_device_pm_latency *pm_lats,
@@ -499,7 +499,7 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	if (ret)
 		goto odbs_exit4;
 
-	return od;
+	return &od->pdev;
 
 odbs_exit4:
 	kfree(res);
-- 
1.7.1
