From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 33/39] ARM: OMAP2+: board omap4pcm049: gpmc driver adaptation
Date: Tue, 1 May 2012 17:40:00 +0530
Message-ID: <5defad2fdc7a94ccb4275b544a8396c18aa46093.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42958 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757122Ab2EAM1G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:27:06 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap4pcm049.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
index 81de7d5..b4ead86 100644
--- a/arch/arm/mach-omap2/board-omap4pcm049.c
+++ b/arch/arm/mach-omap2/board-omap4pcm049.c
@@ -130,6 +130,12 @@ static struct omap2_hsmmc_info mmc[] = {
 	}, {}	/* Terminator */
 };
 
+static struct gpmc_device_pdata *gpmc_device_data[1];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
@@ -147,7 +153,11 @@ static inline void __init pcm049_init_smsc911x(void)
 {
 	omap_mux_init_gpio(OMAP4_PCM049_ETH_GPIO_IRQ, OMAP_PIN_INPUT);
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
-	gpmc_smsc911x_init(&board_smsc911x_data);
+	*gpmc_device_data = gpmc_smsc911x_init(&board_smsc911x_data);
+	if (*gpmc_device_data)
+		gpmc_data.num_device++;
+	else
+		pr_err("error: unable to initilaize gpmc smsc911x\n");
 }
 #else
 static inline void __init pcm049_init_smsc911x(void) { return; }
@@ -562,6 +572,7 @@ static void __init pcm049_init(void)
 	pm_power_off = pcm049_power_off;
 	omap4_mux_init(board_mux, NULL, OMAP_PACKAGE_CBS);
 	pcm049_init_smsc911x();
+	omap_init_gpmc(&gpmc_data);
 	pcm049_i2c_init();
 	platform_add_devices(pcm049_devices, ARRAY_SIZE(pcm049_devices));
 	board_serial_init();
-- 
1.7.10

