From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 1/1] MMC/SD hot plug fix for TWL based boards
Date: Mon,  9 Feb 2009 14:08:38 +0530
Message-ID: <1234168718-12881-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57381 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbZBIIiu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Feb 2009 03:38:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david-b@pacbell.net, linux-omap@vger.kernel.org
Cc: Manikandan Pillai <mani.pillai@ti.com>

MMC hotplug was not functioning properly since the SYS_nIRQ
MUX was setup as GPIO by default in the u-boot and was not
being set properly in the Linux kernel.

Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   32 +++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/mmc-twl4030.c    |    2 --
 drivers/mmc/host/omap_hsmmc.c        |    5 ++++-
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6386c25..6e9a399 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/input.h>
+#include <linux/leds.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
@@ -50,6 +51,11 @@
 #endif
 
 
+#if defined(CONFIG_TWL4030_CORE)
+static int omap3evm_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio);
+#endif
+
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
 		.start  = OMAP3EVM_ETHR_START,
@@ -102,6 +108,9 @@ static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.pulldowns	= BIT(2) | BIT(6) | BIT(8) | BIT(13)
+				| BIT(16) | BIT(17),
+	.setup		= omap3evm_twl_gpio_setup,
 };
 
 static struct twl4030_usb_data omap3evm_usb_data = {
@@ -463,6 +472,27 @@ static void omap_init_pr785(void)
 }
 #endif
 
+#if defined(CONFIG_TWL4030_CORE)
+static int omap3evm_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+	mmc[0].gpio_cd = gpio + 0;
+	twl4030_mmc_init(mmc);
+
+	return 0;
+}
+
+static void omap_init_twl4030(void)
+{
+	if (cpu_is_omap343x()) {
+		omap_cfg_reg(AF26_34XX_GPIO0);
+		omap_cfg_reg(L8_34XX_GPIO63);
+	}
+}
+#endif
+
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_i2c_init();
@@ -476,7 +506,7 @@ static void __init omap3_evm_init(void)
 
 	omap_serial_init();
 #if defined(CONFIG_TWL4030_CORE)
-	twl4030_mmc_init(mmc);
+	omap_init_twl4030();
 #endif
 #if defined(CONFIG_OMAP3EVM_PR785)
 	omap_init_pr785();
diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 88ae1bf..00a200f 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -125,7 +125,6 @@ int twl_mmc_set_voltage(struct hsmmc_controller *c, int vdd)
 	else
 		dev_grp_val = LDO_CLR;		/* Power down */
 
-#if defined(CONFIG_TWL4030_CORE)
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					dev_grp_val, c->hsmmc_dev_grp);
 	if (ret)
@@ -133,7 +132,6 @@ int twl_mmc_set_voltage(struct hsmmc_controller *c, int vdd)
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					vmmc, c->hsmmc_dedicated);
-#endif
 	return ret;
 }
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index db37490..2f16072 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -518,6 +518,9 @@ static void mmc_omap_detect(struct work_struct *work)
 	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
 						mmc_carddetect_work);
 
+	struct omap_mmc_slot_data *slot = &mmc_slot(host);
+	host->carddetect = slot->card_detect(slot->card_detect_irq);
+
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 	if (host->carddetect) {
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
@@ -947,7 +950,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
+	host->dbclk = clk_get(&pdev->dev, "mmchs_fck");
 	/*
 	 * MMC can still work without debounce clock.
 	 */
-- 
1.5.6

