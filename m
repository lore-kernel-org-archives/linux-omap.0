From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4 23/39] ARM: OMAP2+: board 3630sdp: gpmc driver adaptation
Date: Tue, 1 May 2012 17:52:15 +0530
Message-ID: <7762bf10ee38177a070b84e8e42f7853e48f569b.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60468 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757888Ab2EAMjY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:39:24 -0400
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-3630sdp.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 143e47f..4e0298a 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -27,18 +27,29 @@
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
 
+static struct gpmc_device_pdata *gpmc_device_data[4];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
 static struct omap_smc91x_platform_data board_smc91x_data = {
 	.cs             = 3,
 	.flags          = GPMC_MUX_ADD_DATA | IORESOURCE_IRQ_LOWLEVEL,
 	.skip_timing	= true,
+	.gpio_irq	= 158,
 };
 
 static void __init board_smc91x_init(void)
 {
-	board_smc91x_data.gpio_irq = 158;
-	gpmc_smc91x_init(&board_smc91x_data);
+	*gpmc_cur = gpmc_smc91x_init(&board_smc91x_data);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: unable to initilaize gpmc smsc911x\n");
 }
 
 #else
@@ -204,9 +215,13 @@ static void __init omap_sdp_init(void)
 	omap_sdrc_init(h8mbx00u0mer0em_sdrc_params,
 				  h8mbx00u0mer0em_sdrc_params);
 	zoom_display_init();
+
 	board_smc91x_init();
-	board_flash_init(sdp_flash_partitions, chip_sel_sdp,
-		NAND_BUSWIDTH_16, NULL);
+	gpmc_data.num_device += board_flash_init(sdp_flash_partitions,
+					chip_sel_sdp, NAND_BUSWIDTH_16,
+					gpmc_cur) - gpmc_cur;
+	omap_init_gpmc(&gpmc_data);
+
 	enable_board_wakeup_source();
 	usbhs_init(&usbhs_bdata);
 }
-- 
1.7.10

