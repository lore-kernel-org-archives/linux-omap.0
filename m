From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 37/39] ARM: OMAP2+: board zoom-debugboard: gpmc driver adaptation
Date: Tue, 1 May 2012 17:40:30 +0530
Message-ID: <7c68bdb43ff3d41568f993609239487792399d82.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42991 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755901Ab2EAM1g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:27:36 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-zoom-debugboard.c |   47 +++++++++++++++------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index f64f441..dae7df2 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -31,6 +31,13 @@
 #define DEBUG_BASE		0x08000000
 #define ZOOM_ETHR_START	DEBUG_BASE
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 static struct omap_smsc911x_platform_data zoom_smsc911x_cfg = {
 	.cs             = ZOOM_SMSC911X_CS,
 	.gpio_irq       = ZOOM_SMSC911X_GPIO,
@@ -40,7 +47,11 @@ static struct omap_smsc911x_platform_data zoom_smsc911x_cfg = {
 
 static inline void __init zoom_init_smsc911x(void)
 {
-	gpmc_smsc911x_init(&zoom_smsc911x_cfg);
+	*gpmc_cur = gpmc_smsc911x_init(&zoom_smsc911x_cfg);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: %s: gpmc smsc911x setup\n", __func__);
 }
 
 static struct plat_serial8250_port serial_platform_data[] = {
@@ -56,18 +67,22 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	}
 };
 
-static struct platform_device zoom_debugboard_serial_device = {
+static struct gpmc_cs_data zoom_debugboard_gpmc_cs_serial_data = {
+	.cs		= ZOOM_QUADUART_CS,
+	.mem_size	= SZ_1M,
+};
+
+static struct gpmc_device_pdata zoom_debugboard_gpmc_serial_data = {
 	.name			= "serial8250",
 	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= serial_platform_data,
-	},
+	.pdata			= serial_platform_data,
+	.pdata_size		= sizeof(serial_platform_data),
+	.cs_data		= &zoom_debugboard_gpmc_cs_serial_data,
+	.num_cs			= 1,
 };
 
 static inline void __init zoom_init_quaduart(void)
 {
-	int quart_cs;
-	unsigned long cs_mem_base;
 	int quart_gpio = 0;
 
 	if (gpio_request_one(ZOOM_QUADUART_RST_GPIO,
@@ -78,14 +93,6 @@ static inline void __init zoom_init_quaduart(void)
 		return;
 	}
 
-	quart_cs = ZOOM_QUADUART_CS;
-
-	if (gpmc_cs_request(quart_cs, SZ_1M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem"
-				"for Quad UART(TL16CP754C)\n");
-		return;
-	}
-
 	quart_gpio = ZOOM_QUADUART_GPIO;
 
 	if (gpio_request_one(quart_gpio, GPIOF_IN, "TL16CP754C GPIO") < 0)
@@ -93,6 +100,9 @@ static inline void __init zoom_init_quaduart(void)
 								quart_gpio);
 
 	serial_platform_data[0].irq = gpio_to_irq(102);
+
+	*gpmc_cur++ = &zoom_debugboard_gpmc_serial_data;
+	gpmc_data.num_device++;
 }
 
 static inline int omap_zoom_debugboard_detect(void)
@@ -116,10 +126,6 @@ static inline int omap_zoom_debugboard_detect(void)
 	return ret;
 }
 
-static struct platform_device *zoom_devices[] __initdata = {
-	&zoom_debugboard_serial_device,
-};
-
 static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
 	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
@@ -133,5 +139,6 @@ int __init zoom_debugboard_init(void)
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	zoom_init_smsc911x();
 	zoom_init_quaduart();
-	return platform_add_devices(zoom_devices, ARRAY_SIZE(zoom_devices));
+	omap_init_gpmc(&gpmc_data);
+	return 0;
 }
-- 
1.7.10

