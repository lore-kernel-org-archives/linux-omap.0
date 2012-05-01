From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 21/39] ARM: OMAP2+: board apollon: gpmc driver adaptation
Date: Tue, 1 May 2012 17:38:34 +0530
Message-ID: <a1c92e12679c348d8dd972b59e23424a4f66288f.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33159 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571Ab2EAMZm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:25:42 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board code to
provide gpmc driver with required information. It is believed that
apollon board was added before gpmc-smc91x helper functions were
added. Reuse the now available gpmc_smc91x_init adapted for gpmc
driver.

Note: Timing values were hardcoded and written onto registers,
whether making use of gpmc_smc91x_init would configure timing
properly has to be tested.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-apollon.c |  152 +++++++++--------------------------
 1 file changed, 38 insertions(+), 114 deletions(-)

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 768ece2..6a402e1 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -39,6 +39,7 @@
 #include <plat/board.h>
 #include "common.h"
 #include <plat/gpmc.h>
+#include <plat/gpmc-smc91x.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
@@ -58,6 +59,12 @@
 #define APOLLON_ETH_CS		1
 #define APOLLON_ETHR_GPIO_IRQ	74
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 static struct mtd_partition apollon_partitions[] = {
 	{
 		.name		= "X-Loader + U-Boot",
@@ -97,57 +104,26 @@ static struct onenand_platform_data apollon_flash_data = {
 	.nr_parts	= ARRAY_SIZE(apollon_partitions),
 };
 
-static struct resource apollon_flash_resource[] = {
-	[0] = {
-		.flags		= IORESOURCE_MEM,
-	},
+static struct gpmc_cs_data apollon_gpmc_onenand_cs_data = {
+	.cs		= APOLLON_FLASH_CS,
+	.mem_size	= SZ_128K,
 };
 
-static struct platform_device apollon_onenand_device = {
+static struct gpmc_device_pdata apollon_gpmc_onenand_data = {
 	.name		= "onenand-flash",
 	.id		= -1,
-	.dev		= {
-		.platform_data	= &apollon_flash_data,
-	},
-	.num_resources	= ARRAY_SIZE(apollon_flash_resource),
-	.resource	= apollon_flash_resource,
-};
-
-static void __init apollon_flash_init(void)
-{
-	unsigned long base;
-
-	if (gpmc_cs_request(APOLLON_FLASH_CS, SZ_128K, &base) < 0) {
-		printk(KERN_ERR "Cannot request OneNAND GPMC CS\n");
-		return;
-	}
-	apollon_flash_resource[0].start = base;
-	apollon_flash_resource[0].end   = base + SZ_128K - 1;
-}
-
-static struct smc91x_platdata appolon_smc91x_info = {
-	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
-	.leda	= RPC_LED_100_10,
-	.ledb	= RPC_LED_TX_RX,
+	.pdata		= &apollon_flash_data,
+	.pdata_size	= sizeof(apollon_flash_data),
+	.cs_data	= &apollon_gpmc_onenand_cs_data,
+	.num_cs		= 1,
 };
 
-static struct resource apollon_smc91x_resources[] = {
-	[0] = {
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
-	},
-};
-
-static struct platform_device apollon_smc91x_device = {
-	.name		= "smc91x",
-	.id		= -1,
-	.dev	= {
-		.platform_data	= &appolon_smc91x_info,
-	},
-	.num_resources	= ARRAY_SIZE(apollon_smc91x_resources),
-	.resource	= apollon_smc91x_resources,
+static struct omap_smc91x_platform_data apollon_smc91x_data = {
+	.gpio_irq	= APOLLON_ETHR_GPIO_IRQ,
+	.cs		= APOLLON_ETH_CS,
+	.wait_pin	= GPMC_WAITPIN_1,
+	.flags		= GPMC_TIMINGS_SMC91C96 | IORESOURCE_IRQ_HIGHEDGE |
+				GPMC_MUXADDDATA,
 };
 
 static struct omap_led_config apollon_led_config[] = {
@@ -185,74 +161,9 @@ static struct platform_device apollon_led_device = {
 };
 
 static struct platform_device *apollon_devices[] __initdata = {
-	&apollon_onenand_device,
-	&apollon_smc91x_device,
 	&apollon_led_device,
 };
 
-static inline void __init apollon_init_smc91x(void)
-{
-	unsigned long base;
-
-	unsigned int rate;
-	struct clk *gpmc_fck;
-	int eth_cs;
-	int err;
-
-	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
-	if (IS_ERR(gpmc_fck)) {
-		WARN_ON(1);
-		return;
-	}
-
-	clk_enable(gpmc_fck);
-	rate = clk_get_rate(gpmc_fck);
-
-	eth_cs = APOLLON_ETH_CS;
-
-	/* Make sure CS1 timings are correct */
-	gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG1, 0x00011200);
-
-	if (rate >= 160000000) {
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f01);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080803);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1c0b1c0a);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
-	} else if (rate >= 130000000) {
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
-	} else {/* rate = 100000000 */
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x031A1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000003C2);
-	}
-
-	if (gpmc_cs_request(APOLLON_ETH_CS, SZ_16M, &base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC CS for smc91x\n");
-		goto out;
-	}
-	apollon_smc91x_resources[0].start = base + 0x300;
-	apollon_smc91x_resources[0].end   = base + 0x30f;
-	udelay(100);
-
-	omap_mux_init_gpio(APOLLON_ETHR_GPIO_IRQ, 0);
-	err = gpio_request_one(APOLLON_ETHR_GPIO_IRQ, GPIOF_IN, "SMC91x irq");
-	if (err) {
-		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
-			APOLLON_ETHR_GPIO_IRQ);
-		gpmc_cs_free(APOLLON_ETH_CS);
-	}
-out:
-	clk_disable(gpmc_fck);
-	clk_put(gpmc_fck);
-}
-
 static struct omap_usb_config apollon_usb_config __initdata = {
 	.register_dev	= 1,
 	.hmc_mode	= 0x14,	/* 0:dev 1:host1 2:disable */
@@ -315,12 +226,27 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init omap_apollon_init(void)
 {
 	u32 v;
+	int err, idx = 0;
 
 	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAC);
 
-	apollon_init_smc91x();
+	gpmc_device_data[idx++] = &apollon_gpmc_onenand_data;
+	gpmc_data.num_device++;
+
+	omap_mux_init_gpio(apollon_smc91x_data.gpio_irq, 0);
+	err = gpio_request_one(apollon_smc91x_data.gpio_irq,
+			GPIOF_IN, "SMC91x irq");
+	if (err) {
+		pr_err("error: %s: Failed to request GPIO%d for smc91x IRQ\n",
+			__func__, apollon_smc91x_data.gpio_irq);
+	} else {
+		gpmc_device_data[idx++] =
+			gpmc_smc91x_init(&apollon_smc91x_data);
+		gpmc_data.num_device++;
+	}
+	omap_init_gpmc(&gpmc_data);
+
 	apollon_led_init();
-	apollon_flash_init();
 	apollon_usb_init();
 
 	/* REVISIT: where's the correct place */
@@ -339,8 +265,6 @@ static void __init omap_apollon_init(void)
 	 * You have to mux them off in device drivers later on
 	 * if not needed.
 	 */
-	apollon_smc91x_resources[1].start = gpio_to_irq(APOLLON_ETHR_GPIO_IRQ);
-	apollon_smc91x_resources[1].end = gpio_to_irq(APOLLON_ETHR_GPIO_IRQ);
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-- 
1.7.10

