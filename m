From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 1/1] MMC1 support for OMAP3 EVM with PR785 power modules
Date: Thu,  4 Dec 2008 17:12:16 +0530
Message-ID: <1228390936-11504-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57560 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbYLDLmZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2008 06:42:25 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mB4BgHRH017461
	for <linux-omap@vger.kernel.org>; Thu, 4 Dec 2008 05:42:24 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manikandan Pillai <mani.pillai@ti.com>

This patch allows the MMC1 support on OMAP2 EVM board with
TPS6235x based PR785 boards. Files mmc-pr785.* contain the
drivers.

Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 arch/arm/mach-omap2/Makefile          |    9 +++++-
 arch/arm/mach-omap2/board-omap3evm.c  |   22 ++++++++++++-
 arch/arm/mach-omap2/mux.c             |   13 ++++++++
 arch/arm/plat-omap/devices.c          |   11 +++++++
 arch/arm/plat-omap/include/mach/mmc.h |   12 +++++++
 arch/arm/plat-omap/include/mach/mux.h |    7 ++++
 drivers/mmc/host/omap_hsmmc.c         |   52 +++++++++++++++++++++++++++++++++
 7 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3897347..3a0b3f5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -56,10 +56,17 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   usb-ehci.o \
 					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
-					   mmc-twl4030.o \
 					   usb-musb.o usb-ehci.o \
 					   board-omap3evm-flash.o \
 					   twl4030-generic-scripts.o
+ifeq ($(CONFIG_PR785),y)
+obj-$(CONFIG_MACH_OMAP3EVM)             += mmc-pr785.o
+endif
+ifeq ($(CONFIG_TWL4030_CORE),y)
+obj-$(CONFIG_MACH_OMAP3EVM)             += mmc-twl4030.o
+endif
+
+
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   usb-musb.o usb-ehci.o \
 					   mmc-twl4030.o \
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ab3070d..e8eaa6b 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -40,7 +40,12 @@
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "twl4030-generic-scripts.h"
+#if defined(CONFIG_PR785)
+#include "mmc-pr785.h"
+#endif
+#if defined(CONFIG_TWL4030_CORE)
 #include "mmc-twl4030.h"
+#endif
 
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
@@ -258,15 +263,28 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3evm_smc911x_device,
 };
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
+#if defined(CONFIG_PR785)
+static struct pr785_hsmmc_info mmc[] __initdata = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
-		.gpio_cd	= -EINVAL,
+		.gpio_cd	= (IH_GPIO_BASE + 140),
 		.gpio_wp	= -EINVAL,
 	},
 	{}	/* Terminator */
 };
+#endif
+#if defined(CONFIG_TWL4030_CORE)
+static struct twl4030_hsmmc_info mmc[] __initdata = {
+	{
+		.mmc            = 1,
+		.wires          = 4,
+		.gpio_cd        = -EINVAL,
+		.gpio_wp        = -EINVAL,
+	},
+	{}      /* Terminator */
+};
+#endif
 
 static void __init omap3_evm_init(void)
 {
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index dacb41f..68531b6 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -459,6 +459,19 @@ MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AF6_34XX_GPIO140", 0x16c,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 4c81eaf..85cf2ad 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -420,6 +420,16 @@ static struct regulator_init_data tps_regulator_data[] = {
 
 static void omap_init_pr785(void)
 {
+	/* Initialize the mux settings for PR785 power module board */
+	if (cpu_is_omap343x()) {
+		omap_cfg_reg(AF26_34XX_GPIO0);
+		omap_cfg_reg(AF22_34XX_GPIO9);
+		omap_cfg_reg(AF6_34XX_GPIO140);
+		omap_cfg_reg(AE6_34XX_GPIO141);
+		omap_cfg_reg(AF5_34XX_GPIO142);
+		omap_cfg_reg(AE5_34XX_GPIO143);
+	}
+
 	(void) platform_device_register(&omap_tps6235x_device[0]);
 	(void) platform_device_register(&omap_tps6235x_device[1]);
 }
@@ -458,6 +468,7 @@ static int __init omap_init_devices(void)
 	omap_init_uwire();
 	omap_init_wdt();
 	omap_init_rng();
+	omap_init_pr785();
 	return 0;
 }
 arch_initcall(omap_init_devices);
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index 031250f..9ccceed 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -36,6 +36,18 @@
 
 #define OMAP_MMC_MAX_SLOTS	2
 
+#if defined(CONFIG_MACH_OMAP3EVM) && defined(CONFIG_PR785)
+#define OMAP_PR785_MMC1_VSET    0
+#define OMAP_PR785_MMC1_EN      9
+#define OMAP_PR785_MMC1_CD      140
+#define OMAP_PR785_MMC1_CD_MSK  ((1<<12))
+
+/* Workaround for MMC Card insertion and deletion interrupt since
+   Rising and falling interupt detection does not work */
+#define OMAP_GPIO5_MMC_LOWLVL   (0x49056040)
+#define OMAP_GPIO5_MMC_HIGHLVL  (0x49056044)
+#endif
+
 struct omap_mmc_platform_data {
 
 	/* number of slots per controller */
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index f4362b8..ef1ef9b 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -790,6 +790,13 @@ enum omap34xx_index {
 	 */
 	AH8_34XX_GPIO29,
 	J25_34XX_GPIO170,
+	AF26_34XX_GPIO0,
+	AF22_34XX_GPIO9,
+	AF6_34XX_GPIO140,
+	AE6_34XX_GPIO141,
+	AF5_34XX_GPIO142,
+	AE5_34XX_GPIO143
+
 };
 
 struct omap_mux_cfg {
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0df6841..0dc7ddf 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -32,6 +32,8 @@
 #include <mach/board.h>
 #include <mach/mmc.h>
 #include <mach/cpu.h>
+#include <mach/gpio.h>
+#include <mach/io.h>
 
 /* OMAP HSMMC Host Controller Registers */
 #define OMAP_HSMMC_SYSCONFIG	0x0010
@@ -538,6 +540,32 @@ static void mmc_omap_detect(struct work_struct *work)
 static irqreturn_t omap_mmc_cd_handler(int irq, void *dev_id)
 {
 	struct mmc_omap_host *host = (struct mmc_omap_host *)dev_id;
+	unsigned int value;
+
+#if defined(CONFIG_MACH_OMAP3EVM) && defined(CONFIG_PR785)
+	value = omap_readl(OMAP_GPIO5_MMC_LOWLVL);
+	if (value & OMAP_PR785_MMC1_CD_MSK) {
+		/* if a card is inserted, CD pin is low and hence to detect
+		Card pull, the interrupt is set to high level */
+		value = omap_readl(OMAP_GPIO5_MMC_LOWLVL);
+		value &= ~(OMAP_PR785_MMC1_CD_MSK);
+		omap_writel(value, OMAP_GPIO5_MMC_LOWLVL);
+
+		value = omap_readl(OMAP_GPIO5_MMC_HIGHLVL);
+		value |= OMAP_PR785_MMC1_CD_MSK;
+		omap_writel(value, OMAP_GPIO5_MMC_HIGHLVL);
+	} else {
+		/* if a card is removed, CD pin is high and hence to detect
+		Card plug, the interrupt is set to low level */
+		value = omap_readl(OMAP_GPIO5_MMC_HIGHLVL);
+		value &= ~(OMAP_PR785_MMC1_CD_MSK);
+		omap_writel(value, OMAP_GPIO5_MMC_HIGHLVL);
+
+		value = omap_readl(OMAP_GPIO5_MMC_LOWLVL);
+		value |= OMAP_PR785_MMC1_CD_MSK;
+		omap_writel(value, OMAP_GPIO5_MMC_LOWLVL);
+	}
+#endif
 
 	host->carddetect = mmc_slot(host).card_detect(irq);
 	schedule_work(&host->mmc_carddetect_work);
@@ -863,6 +891,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	int ret = 0, irq;
 	u32 hctl, capa;
 
+
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "Platform Data is missing\n");
 		return -ENXIO;
@@ -1009,7 +1038,11 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	if ((mmc_slot(host).card_detect_irq) && (mmc_slot(host).card_detect)) {
 		ret = request_irq(mmc_slot(host).card_detect_irq,
 				  omap_mmc_cd_handler,
+#if defined(CONFIG_MACH_OMAP3EVM) && defined(CONFIG_PR785)
+				  IRQF_TRIGGER_LOW
+#else
 				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
+#endif
 					  | IRQF_DISABLED,
 				  mmc_hostname(mmc), host);
 		if (ret) {
@@ -1223,6 +1256,22 @@ static struct platform_driver omap_mmc_driver = {
 
 static int __init omap_mmc_init(void)
 {
+#if defined(CONFIG_MACH_OMAP3EVM) && defined(CONFIG_PR785)
+	/* setup the GPIO for MMC for PR785 Rev ES2 power module */
+	/* Setup GPIO 0 - MMC1_VSET */
+	gpio_direction_output(OMAP_PR785_MMC1_VSET, 1);
+	/* Setup GPIO 9 - MMC1_EN */
+	gpio_direction_output(OMAP_PR785_MMC1_EN, 1);
+
+	/* Setup GPIO 140 - MMC1_CD as input */
+	if (omap_request_gpio(OMAP_PR785_MMC1_CD) < 0) {
+		printk(KERN_ERR "Failed to request MMC IRQ %d \n",
+			OMAP_PR785_MMC1_CD);
+		return -1;
+	}
+	gpio_direction_input(OMAP_PR785_MMC1_CD);
+#endif
+
 	/* Register the MMC driver */
 	return platform_driver_register(&omap_mmc_driver);
 }
@@ -1231,6 +1280,9 @@ static void __exit omap_mmc_cleanup(void)
 {
 	/* Unregister MMC driver */
 	platform_driver_unregister(&omap_mmc_driver);
+#if defined(CONFIG_MACH_OMAP3EVM) && defined(CONFIG_PR785)
+	omap_free_gpio(OMAP_PR785_MMC1_CD);
+#endif
 }
 
 module_init(omap_mmc_init);
-- 
1.5.6

