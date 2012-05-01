From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 34/39] ARM: OMAP2+: board overo: gpmc driver adaptation
Date: Tue, 1 May 2012 17:40:08 +0530
Message-ID: <b110c0f582a8b629bc32c557ea287c4a8b4fe4d6.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37442 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab2EAM1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 08:27:13 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-overo.c |   29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index e08479a..fa0197e 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -72,6 +72,13 @@
 #define OVERO_SMSC911X2_CS     4
 #define OVERO_SMSC911X2_GPIO   65
 
+static struct gpmc_device_pdata *gpmc_device_data[3];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 
@@ -137,8 +144,16 @@ static struct omap_smsc911x_platform_data smsc911x2_cfg = {
 
 static void __init overo_init_smsc911x(void)
 {
-	gpmc_smsc911x_init(&smsc911x_cfg);
-	gpmc_smsc911x_init(&smsc911x2_cfg);
+	*gpmc_cur = gpmc_smsc911x_init(&smsc911x_cfg);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: %s: smsc911x instance 1 setup\n", __func__);
+	*gpmc_cur = gpmc_smsc911x_init(&smsc911x2_cfg);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: %s: smsc911x instance 1 setup\n", __func__);
 }
 
 #else
@@ -509,6 +524,7 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 static void __init overo_init(void)
 {
 	int ret;
+	struct omap_nand_platform_data *nand_data;
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -518,12 +534,19 @@ static void __init overo_init(void)
 	omap_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
-	board_nand_init(overo_nand_partitions,
+
+	nand_data = board_nand_init(overo_nand_partitions,
 		ARRAY_SIZE(overo_nand_partitions), GPMC_CS_NUM, 0, NULL);
+	if (nand_data != NULL) {
+		*gpmc_cur++ = gpmc_nand_init(nand_data);
+		gpmc_data.num_device++;
+	}
+
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	overo_spi_init();
 	overo_init_smsc911x();
+	omap_init_gpmc(&gpmc_data);
 	overo_display_init();
 	overo_init_led();
 	overo_init_keys();
-- 
1.7.10

