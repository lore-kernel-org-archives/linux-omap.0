From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 25/39] ARM: OMAP2+: board 2430sdp: gpmc driver adaptation
Date: Tue, 1 May 2012 17:39:03 +0530
Message-ID: <ee9b21e9616dce9479b9c50f2428c9f74bcf85bf.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1335873032.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
