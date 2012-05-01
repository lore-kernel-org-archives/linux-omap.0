From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4 25/39] ARM: OMAP2+: board 2430sdp: gpmc driver adaptation
Date: Tue, 1 May 2012 17:52:27 +0530
Message-ID: <ee9b21e9616dce9479b9c50f2428c9f74bcf85bf.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43616 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757326Ab2EAMjg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:39:36 -0400
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |   42 +++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 68679a8..d94ada4 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -46,9 +46,16 @@
 #include "hsmmc.h"
 #include "common-board-devices.h"
 
-#define SDP2430_CS0_BASE	0x04000000
+#define SDP2430_FLASH_CS		0
 #define SECONDARY_LCD_GPIO		147
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 static struct mtd_partition sdp2430_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -86,24 +93,18 @@ static struct physmap_flash_data sdp2430_flash_data = {
 	.nr_parts	= ARRAY_SIZE(sdp2430_partitions),
 };
 
-static struct resource sdp2430_flash_resource = {
-	.start		= SDP2430_CS0_BASE,
-	.end		= SDP2430_CS0_BASE + SZ_64M - 1,
-	.flags		= IORESOURCE_MEM,
+static struct gpmc_cs_data sdp2430_gpmc_cs_flash_data = {
+	.cs		= SDP2430_FLASH_CS,
+	.mem_size	= SZ_64M,
 };
 
-static struct platform_device sdp2430_flash_device = {
+static struct gpmc_device_pdata sdp2430_gpmc_flash_device = {
 	.name		= "physmap-flash",
 	.id		= 0,
-	.dev = {
-		.platform_data	= &sdp2430_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &sdp2430_flash_resource,
-};
-
-static struct platform_device *sdp2430_devices[] __initdata = {
-	&sdp2430_flash_device,
+	.pdata		= &sdp2430_flash_data,
+	.pdata_size	= sizeof(sdp2430_flash_data),
+	.cs_data	= &sdp2430_gpmc_cs_flash_data,
+	.num_cs		= 1,
 };
 
 /* LCD */
@@ -181,7 +182,11 @@ static struct omap_smc91x_platform_data board_smc91x_data = {
 static void __init board_smc91x_init(void)
 {
 	omap_mux_init_gpio(149, OMAP_PIN_INPUT);
-	gpmc_smc91x_init(&board_smc91x_data);
+	*gpmc_cur = gpmc_smc91x_init(&board_smc91x_data);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: unable to initilaize gpmc smsc911x\n");
 }
 
 #else
@@ -276,7 +281,9 @@ static void __init omap_2430sdp_init(void)
 
 	omap2430_i2c_init();
 
-	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
+	*gpmc_cur++ = &sdp2430_gpmc_flash_device;
+	gpmc_data.num_device++;
+
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	omap_hsmmc_init(mmc);
@@ -286,6 +293,7 @@ static void __init omap_2430sdp_init(void)
 	usb_musb_init(NULL);
 
 	board_smc91x_init();
+	omap_init_gpmc(&gpmc_data);
 
 	/* Turn off secondary LCD backlight */
 	gpio_request_one(SECONDARY_LCD_GPIO, GPIOF_OUT_INIT_LOW,
-- 
1.7.10

