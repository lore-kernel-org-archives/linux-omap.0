From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH RFC 1/7] platform: add a device node
Date: Sat,  9 Feb 2013 21:44:25 +0100
Message-ID: <1360442671-15216-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40047 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540Ab3BIUou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 15:44:50 -0500
In-Reply-To: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

When using Device Trees, it is necessary to associate a
device node with a platform device.

Usually this device node has to used in the device probe
function (e.g: to initizalize the pinctrl pads assocaited
with the device).

So, platform code needs to pass a device node as a platform
device info to the platform device registration function.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-imx/devices/platform-gpio-mxc.c |    2 +-
 arch/arm/mach-imx/devices/platform-imx-dma.c  |    4 ++--
 arch/arm/mach-imx/mach-armadillo5x0.c         |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c   |    3 ++-
 arch/arm/mach-imx/mach-mx1ads.c               |    2 +-
 arch/arm/mach-nomadik/cpu-8815.c              |    2 +-
 arch/arm/mach-omap2/fb.c                      |    2 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c           |    2 +-
 arch/arm/mach-ux500/board-mop500-audio.c      |    2 +-
 arch/arm/mach-ux500/devices-common.c          |    3 ++-
 arch/arm/mach-ux500/devices-db8500.h          |    2 +-
 arch/unicore32/kernel/puv3-core.c             |    2 +-
 arch/unicore32/kernel/puv3-nb0916.c           |    2 +-
 drivers/base/platform.c                       |    1 +
 drivers/leds/leds-gpio-register.c             |    2 +-
 drivers/virtio/virtio_mmio.c                  |    2 +-
 include/linux/platform_device.h               |    9 ++++++---
 sound/soc/samsung/i2s.c                       |    2 +-
 18 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-imx/devices/platform-gpio-mxc.c b/arch/arm/mach-imx/devices/platform-gpio-mxc.c
index 26483fa..4f4d8f9 100644
--- a/arch/arm/mach-imx/devices/platform-gpio-mxc.c
+++ b/arch/arm/mach-imx/devices/platform-gpio-mxc.c
@@ -28,5 +28,5 @@ struct platform_device *__init mxc_register_gpio(char *name, int id,
 	};
 
 	return platform_device_register_resndata(&mxc_aips_bus,
-			name, id, res, ARRAY_SIZE(res), NULL, 0);
+			name, id, res, ARRAY_SIZE(res), NULL, 0, NULL);
 }
diff --git a/arch/arm/mach-imx/devices/platform-imx-dma.c b/arch/arm/mach-imx/devices/platform-imx-dma.c
index ccdb5dc..1e3838c 100644
--- a/arch/arm/mach-imx/devices/platform-imx-dma.c
+++ b/arch/arm/mach-imx/devices/platform-imx-dma.c
@@ -28,7 +28,7 @@ struct platform_device __init __maybe_unused *imx_add_imx_dma(char *name,
 	};
 
 	return platform_device_register_resndata(&mxc_ahb_bus,
-			name, -1, res, ARRAY_SIZE(res), NULL, 0);
+			name, -1, res, ARRAY_SIZE(res), NULL, 0, NULL);
 }
 
 struct platform_device __init __maybe_unused *imx_add_imx_sdma(char *name,
@@ -47,5 +47,5 @@ struct platform_device __init __maybe_unused *imx_add_imx_sdma(char *name,
 	};
 
 	return platform_device_register_resndata(&mxc_ahb_bus, name,
-			-1, res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+			-1, res, ARRAY_SIZE(res), pdata, sizeof(*pdata), NULL);
 }
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index 59bd6b0..e664681 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -519,7 +519,7 @@ static void __init armadillo5x0_init(void)
 	platform_device_register_resndata(NULL, "physmap-flash", -1,
 			&armadillo5x0_nor_flash_resource, 1,
 			&armadillo5x0_nor_flash_pdata,
-			sizeof(armadillo5x0_nor_flash_pdata));
+			sizeof(armadillo5x0_nor_flash_pdata), NULL);
 
 	/* Register NAND Flash */
 	imx31_add_mxc_nand(&armadillo5x0_nand_board_info);
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 318bd8d..5065f67 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -570,7 +570,8 @@ static void __init visstrim_m10_board_init(void)
 	imx_add_platform_device("mx27vis", 0, NULL, 0, &snd_mx27vis_pdata,
 				sizeof(snd_mx27vis_pdata));
 	platform_device_register_resndata(NULL, "soc-camera-pdrv", 0, NULL, 0,
-				      &iclink_tvp5150, sizeof(iclink_tvp5150));
+				      &iclink_tvp5150, sizeof(iclink_tvp5150),
+				      NULL);
 	gpio_led_register_device(0, &visstrim_m10_led_data);
 
 	/* Use mother board version to decide what video devices we shall use */
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 06b4837..9ce64a5 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -118,7 +118,7 @@ static void __init mx1ads_init(void)
 	/* Physmap flash */
 	platform_device_register_resndata(NULL, "physmap-flash", 0,
 			&flash_resource, 1,
-			&mx1ads_flash_data, sizeof(mx1ads_flash_data));
+			&mx1ads_flash_data, sizeof(mx1ads_flash_data), NULL);
 
 	/* I2C */
 	i2c_register_board_info(0, mx1ads_i2c_devices,
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 1273931..b117d6c 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -65,7 +65,7 @@ cpu8815_add_gpio(int id, resource_size_t addr, int irq,
 
 	return platform_device_register_resndata(NULL, "gpio", id,
 				resources, ARRAY_SIZE(resources),
-				pdata, sizeof(*pdata));
+				pdata, sizeof(*pdata), NULL);
 }
 
 void cpu8815_add_gpios(resource_size_t *base, int num, int irq,
diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
index 190ae49..ba2e5ae 100644
--- a/arch/arm/mach-omap2/fb.c
+++ b/arch/arm/mach-omap2/fb.c
@@ -81,7 +81,7 @@ static int __init omap_init_vrfb(void)
 	}
 
 	pdev = platform_device_register_resndata(NULL, "omapvrfb", -1,
-			res, num_res, NULL, 0);
+			res, num_res, NULL, 0, NULL);
 
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index ef99011..5ce00ad2 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -82,7 +82,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
 
 	pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
 		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
-		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config));
+		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config), NULL);
 	if (!pdev) {
 		pr_err("Unable to register platform device\n");
 		gpio_free(gpmc_cfg->gpio_reset);
diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
index 7209db7..5ebbc65 100644
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -129,7 +129,7 @@ static struct platform_device *db8500_add_msp_i2s(struct device *parent,
 		id, irq);
 	pdev = platform_device_register_resndata(parent, "ux500-msp-i2s", id,
 						res, ARRAY_SIZE(res),
-						pdata, sizeof(*pdata));
+						pdata, sizeof(*pdata), NULL);
 	if (!pdev) {
 		pr_err("Failed to register platform-device 'ux500-msp-i2s.%d'!\n",
 			id);
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 16b5f71..dcbe6c2 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -42,7 +42,8 @@ dbx500_add_gpio(struct device *parent, int id, resource_size_t addr, int irq,
 		resources,
 		ARRAY_SIZE(resources),
 		pdata,
-		sizeof(*pdata));
+		sizeof(*pdata),
+		NULL);
 }
 
 void dbx500_add_gpios(struct device *parent, resource_size_t *base, int num,
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index a5e05f6..5a8ed73 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -26,7 +26,7 @@ db8500_add_ske_keypad(struct device *parent,
 	};
 
 	return platform_device_register_resndata(parent, "nmk-ske-keypad", -1,
-						 resources, 2, pdata, size);
+						 resources, 2, pdata, size, NULL);
 }
 
 static inline struct amba_device *
diff --git a/arch/unicore32/kernel/puv3-core.c b/arch/unicore32/kernel/puv3-core.c
index 254adee..8143a18 100644
--- a/arch/unicore32/kernel/puv3-core.c
+++ b/arch/unicore32/kernel/puv3-core.c
@@ -274,6 +274,6 @@ void __init puv3_core_init(void)
 	platform_device_register_simple("PKUnity-v3-AC97", -1, NULL, 0);
 	platform_device_register_resndata(&platform_bus, "musb_hdrc", -1,
 			puv3_usb_resources, ARRAY_SIZE(puv3_usb_resources),
-			&puv3_usb_plat, sizeof(puv3_usb_plat));
+			&puv3_usb_plat, sizeof(puv3_usb_plat), NULL);
 }
 
diff --git a/arch/unicore32/kernel/puv3-nb0916.c b/arch/unicore32/kernel/puv3-nb0916.c
index 181108b..b2a55cb 100644
--- a/arch/unicore32/kernel/puv3-nb0916.c
+++ b/arch/unicore32/kernel/puv3-nb0916.c
@@ -119,7 +119,7 @@ int __init mach_nb0916_init(void)
 
 	platform_device_register_resndata(&platform_bus, "physmap-flash", -1,
 			&physmap_flash_resource, 1,
-			&physmap_flash_data, sizeof(physmap_flash_data));
+			&physmap_flash_data, sizeof(physmap_flash_data), NULL);
 
 	if (request_irq(gpio_to_irq(GPI_LCD_CASE_OFF),
 		&nb0916_lcdcaseoff_handler,
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index c0b8df3..79ba66a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -437,6 +437,7 @@ struct platform_device *platform_device_register_full(
 		goto err_alloc;
 
 	pdev->dev.parent = pdevinfo->parent;
+	pdev->dev.of_node = pdevinfo->of_node;
 	ACPI_HANDLE_SET(&pdev->dev, pdevinfo->acpi_node.handle);
 
 	if (pdevinfo->dma_mask) {
diff --git a/drivers/leds/leds-gpio-register.c b/drivers/leds/leds-gpio-register.c
index 1c4ed55..e1f1c15 100644
--- a/drivers/leds/leds-gpio-register.c
+++ b/drivers/leds/leds-gpio-register.c
@@ -34,7 +34,7 @@ struct platform_device *__init gpio_led_register_device(
 		return ERR_PTR(-ENOMEM);
 
 	ret = platform_device_register_resndata(NULL, "leds-gpio", id,
-			NULL, 0, &_pdata, sizeof(_pdata));
+			NULL, 0, &_pdata, sizeof(_pdata), NULL);
 	if (IS_ERR(ret))
 		kfree(_pdata.leds);
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 31f966f..0709ad6 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -566,7 +566,7 @@ static int vm_cmdline_set(const char *device,
 
 	pdev = platform_device_register_resndata(&vm_cmdline_parent,
 			"virtio-mmio", vm_cmdline_id++,
-			resources, ARRAY_SIZE(resources), NULL, 0);
+			resources, ARRAY_SIZE(resources), NULL, 0, NULL);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index a9ded9a..29393bd 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -66,6 +66,7 @@ struct platform_device_info {
 		const void *data;
 		size_t size_data;
 		u64 dma_mask;
+		struct device_node *of_node;
 };
 extern struct platform_device *platform_device_register_full(
 		const struct platform_device_info *pdevinfo);
@@ -81,13 +82,14 @@ extern struct platform_device *platform_device_register_full(
  * @num: number of resources
  * @data: platform specific data for this platform device
  * @size: size of platform specific data
+ * @of_node: device node of this platform device
  *
  * Returns &struct platform_device pointer on success, or ERR_PTR() on error.
  */
 static inline struct platform_device *platform_device_register_resndata(
 		struct device *parent, const char *name, int id,
 		const struct resource *res, unsigned int num,
-		const void *data, size_t size) {
+		const void *data, size_t size, struct device_node *of_node) {
 
 	struct platform_device_info pdevinfo = {
 		.parent = parent,
@@ -98,6 +100,7 @@ static inline struct platform_device *platform_device_register_resndata(
 		.data = data,
 		.size_data = size,
 		.dma_mask = 0,
+		.of_node = of_node,
 	};
 
 	return platform_device_register_full(&pdevinfo);
@@ -130,7 +133,7 @@ static inline struct platform_device *platform_device_register_simple(
 		const struct resource *res, unsigned int num)
 {
 	return platform_device_register_resndata(NULL, name, id,
-			res, num, NULL, 0);
+			res, num, NULL, 0, NULL);
 }
 
 /**
@@ -154,7 +157,7 @@ static inline struct platform_device *platform_device_register_data(
 		const void *data, size_t size)
 {
 	return platform_device_register_resndata(parent, name, id,
-			NULL, 0, data, size);
+			NULL, 0, data, size, NULL);
 }
 
 extern struct platform_device *platform_device_alloc(const char *name, int id);
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d2d124f..e6eabb9 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -982,7 +982,7 @@ static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 	} else {	/* Create a new platform_device for Secondary */
 		i2s->pdev = platform_device_register_resndata(NULL,
 				pdev->name, pdev->id + SAMSUNG_I2S_SECOFF,
-				NULL, 0, NULL, 0);
+				NULL, 0, NULL, 0, NULL);
 		if (IS_ERR(i2s->pdev))
 			return NULL;
 	}
-- 
1.7.7.6

