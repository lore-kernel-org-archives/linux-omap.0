From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 30/39] ARM: OMAP2+: board omap3logic: gpmc driver adaptation
Date: Tue, 1 May 2012 17:39:39 +0530
Message-ID: <e040c11706547d01fb2744246d83c0cba30003ef.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756836Ab2EAM0p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:26:45 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap3logic.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 9b3c141..9867fc8 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -55,6 +55,12 @@
 #define OMAP3_TORPEDO_MMC_GPIO_CD		127
 #define OMAP3_TORPEDO_SMSC911X_GPIO_IRQ		129
 
+static struct gpmc_device_pdata *gpmc_device_data[1];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 static struct regulator_consumer_supply omap3logic_vmmc1_supply[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
@@ -180,7 +186,11 @@ static inline void __init board_smsc911x_init(void)
 		return;
 	}
 
-	gpmc_smsc911x_init(&board_smsc911x_data);
+	*gpmc_device_data = gpmc_smsc911x_init(&board_smsc911x_data);
+	if (*gpmc_device_data)
+		gpmc_data.num_device++;
+	else
+		pr_err("error: unable to initilaize gpmc smsc911x\n");
 }
 
 #ifdef CONFIG_OMAP_MUX
@@ -204,6 +214,7 @@ static void __init omap3logic_init(void)
 	omap_sdrc_init(NULL, NULL);
 	board_mmc_init();
 	board_smsc911x_init();
+	omap_init_gpmc(&gpmc_data);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
-- 
1.7.10

