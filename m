From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 36/39] ARM: OMAP2+: board rx51: gpmc driver adaptation
Date: Tue, 1 May 2012 17:40:23 +0530
Message-ID: <5841f9504787c7d7cf5066c197ef53dcb6a2b18b.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42985 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755635Ab2EAM1b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:27:31 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ae957c9..af7909e 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -73,6 +73,13 @@ enum {
 static struct wl12xx_platform_data wl1251_pdata;
 static struct tsc2005_platform_data tsc2005_pdata;
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
 static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
 	.cover_comp_gain = 16,
@@ -1039,7 +1046,11 @@ static void __init board_smc91x_init(void)
 	omap_mux_init_gpio(86, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(164, OMAP_PIN_OUTPUT);
 
-	gpmc_smc91x_init(&board_smc91x_data);
+	*gpmc_cur = gpmc_smc91x_init(&board_smc91x_data);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: gpmc smsc911x setup\n");
 }
 
 #else
@@ -1136,8 +1147,10 @@ void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
 	regulator_has_full_constraints();
-	gpmc_onenand_init(board_onenand_data);
+	*gpmc_cur++ = gpmc_onenand_init(board_onenand_data);
+	gpmc_data.num_device++;
 	board_smc91x_init();
+	omap_init_gpmc(&gpmc_data);
 	rx51_add_gpio_keys();
 	rx51_init_wl1251();
 	rx51_init_tsc2005();
-- 
1.7.10

