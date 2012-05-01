From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 22/39] ARM: OMAP2+: board h4: gpmc driver adaptation
Date: Tue, 1 May 2012 17:52:08 +0530
Message-ID: <624518d4bf1edf104b06e6a8bbc7b212f5d6d44e.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1335874494.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.
Remove unused h4_init_debug too.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-h4.c |  130 +++++-----------------------------------
 1 file changed, 15 insertions(+), 115 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 0bbbabe..7926082 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -186,22 +186,24 @@ static struct physmap_flash_data h4_flash_data = {
 	.nr_parts	= ARRAY_SIZE(h4_partitions),
 };
 
-static struct resource h4_flash_resource = {
-	.flags		= IORESOURCE_MEM,
+static struct gpmc_cs_data h4_gpmc_cs_flash_data = {
+	.cs		= H4_FLASH_CS,
+	.mem_size	= SZ_64M,
 };
 
-static struct platform_device h4_flash_device = {
+static struct gpmc_device_pdata h4_gpmc_flash_data = {
 	.name		= "physmap-flash",
 	.id		= 0,
-	.dev		= {
-		.platform_data	= &h4_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &h4_flash_resource,
+	.pdata		= &h4_flash_data,
+	.pdata_size	= sizeof(h4_flash_data),
+	.cs_data	= &h4_gpmc_cs_flash_data,
+	.num_cs		= 1,
 };
 
-static struct platform_device *h4_devices[] __initdata = {
-	&h4_flash_device,
+static struct gpmc_device_pdata *gpmc_device_data[1];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
 };
 
 static struct panel_generic_dpi_data h4_panel_data = {
@@ -226,109 +228,6 @@ static struct omap_dss_board_info h4_dss_data = {
 	.default_device	= &h4_lcd_device,
 };
 
-/* 2420 Sysboot setup (2430 is different) */
-static u32 get_sysboot_value(void)
-{
-	return (omap_ctrl_readl(OMAP24XX_CONTROL_STATUS) &
-		(OMAP2_SYSBOOT_5_MASK | OMAP2_SYSBOOT_4_MASK |
-		 OMAP2_SYSBOOT_3_MASK | OMAP2_SYSBOOT_2_MASK |
-		 OMAP2_SYSBOOT_1_MASK | OMAP2_SYSBOOT_0_MASK));
-}
-
-/* H4-2420's always used muxed mode, H4-2422's always use non-muxed
- *
- * Note: OMAP-GIT doesn't correctly do is_cpu_omap2422 and is_cpu_omap2423
- *  correctly.  The macro needs to look at production_id not just hawkeye.
- */
-static u32 is_gpmc_muxed(void)
-{
-	u32 mux;
-	mux = get_sysboot_value();
-	if ((mux & 0xF) == 0xd)
-		return 1;	/* NAND config (could be either) */
-	if (mux & 0x2)		/* if mux'ed */
-		return 1;
-	else
-		return 0;
-}
-
-static inline void __init h4_init_debug(void)
-{
-	int eth_cs;
-	unsigned long cs_mem_base;
-	unsigned int muxed, rate;
-	struct clk *gpmc_fck;
-
-	eth_cs	= H4_SMC91X_CS;
-
-	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
-	if (IS_ERR(gpmc_fck)) {
-		WARN_ON(1);
-		return;
-	}
-
-	clk_enable(gpmc_fck);
-	rate = clk_get_rate(gpmc_fck);
-	clk_disable(gpmc_fck);
-	clk_put(gpmc_fck);
-
-	if (is_gpmc_muxed())
-		muxed = 0x200;
-	else
-		muxed = 0;
-
-	/* Make sure CS1 timings are correct */
-	gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG1,
-			  0x00011000 | muxed);
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
-	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
-		goto out;
-	}
-
-	udelay(100);
-
-	omap_mux_init_gpio(92, 0);
-	if (debug_card_init(cs_mem_base, H4_ETHR_GPIO_IRQ) < 0)
-		gpmc_cs_free(eth_cs);
-
-out:
-	clk_disable(gpmc_fck);
-	clk_put(gpmc_fck);
-}
-
-static void __init h4_init_flash(void)
-{
-	unsigned long base;
-
-	if (gpmc_cs_request(H4_FLASH_CS, SZ_64M, &base) < 0) {
-		printk("Can't request GPMC CS for flash\n");
-		return;
-	}
-	h4_flash_resource.start	= base;
-	h4_flash_resource.end	= base + SZ_64M - 1;
-}
