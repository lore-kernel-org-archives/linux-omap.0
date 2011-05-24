From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 14/15] OMAP: GPIO: Use memset for omap_gpio_reg_offs
Date: Tue, 24 May 2011 19:54:53 +0530
Message-ID: <1306247094-25372-15-git-send-email-tarun.kanti@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49771 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092Ab1EXOZL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 10:25:11 -0400
In-Reply-To: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Charulatha V <charu@ti.com>

Use memset to fill omap_gpio_reg_offs structure with 0xFFFF
instead of filling each and every undefined register offset
separately with USHRT_MAX in a given OMAP SoC. This would ease
while adding new register offsets in the future SoCs.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c |   63 ++++++++++++---------------------
 arch/arm/mach-omap1/gpio16xx.c |   74 +++++++++++++++++-----------------------
 arch/arm/mach-omap1/gpio7xx.c  |   62 ++++++++++++---------------------
 arch/arm/mach-omap2/gpio.c     |    5 +--
 4 files changed, 78 insertions(+), 126 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index ceee046..7f90bcf 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -34,26 +34,7 @@ static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
 	},
 };
 
-static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
-	.revision       = USHRT_MAX,
-	.direction	= OMAP_MPUIO_IO_CNTL,
-	.datain		= OMAP_MPUIO_INPUT_LATCH,
-	.dataout	= OMAP_MPUIO_OUTPUT,
-	.irqstatus	= OMAP_MPUIO_GPIO_INT,
-	.irqenable	= OMAP_MPUIO_GPIO_MASKIT,
-	.irqenable_inv	= true,
-	.ctrl		= USHRT_MAX,
-	.wkupstatus	= USHRT_MAX,
-	.wkupclear	= USHRT_MAX,
-	.wkupset	= USHRT_MAX,
-	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE,
-	.edgectrl1	= USHRT_MAX,
-	.edgectrl2	= USHRT_MAX,
-	.leveldetect0	= USHRT_MAX,
-	.leveldetect1	= USHRT_MAX,
-	.risingdetect	= USHRT_MAX,
-	.fallingdetect	= USHRT_MAX,
-};
+static struct omap_gpio_reg_offs omap15xx_mpuio_regs;
 
 static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
@@ -86,26 +67,7 @@ static struct __initdata resource omap15xx_gpio_resources[] = {
 	},
 };
 
-static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
-	.revision	= USHRT_MAX,
-	.direction	= OMAP1510_GPIO_DIR_CONTROL,
-	.datain		= OMAP1510_GPIO_DATA_INPUT,
-	.dataout	= OMAP1510_GPIO_DATA_OUTPUT,
-	.irqstatus	= OMAP1510_GPIO_INT_STATUS,
-	.irqenable	= OMAP1510_GPIO_INT_MASK,
-	.irqenable_inv	= true,
-	.ctrl		= USHRT_MAX,
-	.wkupstatus	= USHRT_MAX,
-	.wkupclear	= USHRT_MAX,
-	.wkupset	= USHRT_MAX,
-	.irqctrl	= OMAP1510_GPIO_INT_CONTROL,
-	.edgectrl1	= USHRT_MAX,
-	.edgectrl2	= USHRT_MAX,
-	.leveldetect0	= USHRT_MAX,
-	.leveldetect1	= USHRT_MAX,
-	.risingdetect	= USHRT_MAX,
-	.fallingdetect	= USHRT_MAX,
-};
+static struct omap_gpio_reg_offs omap15xx_gpio_regs;
 
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
@@ -134,7 +96,28 @@ static int __init omap15xx_gpio_init(void)
 	if (!cpu_is_omap15xx())
 		return -EINVAL;
 
+	memset(&omap15xx_mpuio_regs, USHRT_MAX, sizeof(omap15xx_mpuio_regs));
+
+	omap15xx_mpuio_regs.direction = OMAP_MPUIO_IO_CNTL;
+	omap15xx_mpuio_regs.datain = OMAP_MPUIO_INPUT_LATCH;
+	omap15xx_mpuio_regs.dataout = OMAP_MPUIO_OUTPUT;
+	omap15xx_mpuio_regs.irqstatus = OMAP_MPUIO_GPIO_INT;
+	omap15xx_mpuio_regs.irqenable = OMAP_MPUIO_GPIO_MASKIT;
+	omap15xx_mpuio_regs.irqenable_inv = true;
+	omap15xx_mpuio_regs.irqctrl = OMAP_MPUIO_GPIO_INT_EDGE;
+
 	platform_device_register(&omap15xx_mpu_gpio);
+
+	memset(&omap15xx_gpio_regs, USHRT_MAX, sizeof(omap15xx_gpio_regs));
+
+	omap15xx_gpio_regs.direction = OMAP1510_GPIO_DIR_CONTROL;
+	omap15xx_gpio_regs.datain = OMAP1510_GPIO_DATA_INPUT;
+	omap15xx_gpio_regs.dataout = OMAP1510_GPIO_DATA_OUTPUT;
+	omap15xx_gpio_regs.irqstatus = OMAP1510_GPIO_INT_STATUS;
+	omap15xx_gpio_regs.irqenable = OMAP1510_GPIO_INT_MASK;
+	omap15xx_gpio_regs.irqenable_inv = true;
+	omap15xx_gpio_regs.irqctrl = OMAP1510_GPIO_INT_CONTROL;
+
 	platform_device_register(&omap15xx_gpio);
 
 	return 0;
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index b2479c5..24f6cfa 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -37,26 +37,7 @@ static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
 	},
 };
 
-static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
-	.revision       = USHRT_MAX,
-	.direction	= OMAP_MPUIO_IO_CNTL,
-	.datain		= OMAP_MPUIO_INPUT_LATCH,
-	.dataout	= OMAP_MPUIO_OUTPUT,
-	.irqstatus	= OMAP_MPUIO_GPIO_INT,
-	.irqenable	= OMAP_MPUIO_GPIO_MASKIT,
-	.irqenable_inv	= true,
-	.ctrl		= USHRT_MAX,
-	.wkupstatus	= USHRT_MAX,
-	.wkupclear	= USHRT_MAX,
-	.wkupset	= USHRT_MAX,
-	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE,
-	.edgectrl1	= USHRT_MAX,
-	.edgectrl2	= USHRT_MAX,
-	.leveldetect0	= USHRT_MAX,
-	.leveldetect1	= USHRT_MAX,
-	.risingdetect	= USHRT_MAX,
-	.fallingdetect	= USHRT_MAX,
-};
+static struct omap_gpio_reg_offs omap16xx_mpuio_regs;
 
 static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
@@ -89,29 +70,7 @@ static struct __initdata resource omap16xx_gpio1_resources[] = {
 	},
 };
 
-static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
-	.revision       = OMAP1610_GPIO_REVISION,
-	.direction	= OMAP1610_GPIO_DIRECTION,
-	.set_dataout	= OMAP1610_GPIO_SET_DATAOUT,
-	.clr_dataout	= OMAP1610_GPIO_CLEAR_DATAOUT,
-	.datain		= OMAP1610_GPIO_DATAIN,
-	.dataout	= OMAP1610_GPIO_DATAOUT,
-	.irqstatus	= OMAP1610_GPIO_IRQSTATUS1,
-	.irqenable	= OMAP1610_GPIO_IRQENABLE1,
-	.set_irqenable	= OMAP1610_GPIO_SET_IRQENABLE1,
-	.clr_irqenable	= OMAP1610_GPIO_CLEAR_IRQENABLE1,
-	.ctrl		= USHRT_MAX,
-	.wkupstatus	= OMAP1610_GPIO_WAKEUPENABLE,
-	.wkupclear	= OMAP1610_GPIO_CLEAR_WAKEUPENA,
-	.wkupset	= OMAP1610_GPIO_SET_WAKEUPENA,
-	.irqctrl	= USHRT_MAX,
-	.edgectrl1	= OMAP1610_GPIO_EDGE_CTRL1,
-	.edgectrl2	= OMAP1610_GPIO_EDGE_CTRL2,
-	.leveldetect0	= USHRT_MAX,
-	.leveldetect1	= USHRT_MAX,
-	.risingdetect	= USHRT_MAX,
-	.fallingdetect	= USHRT_MAX,
-};
+static struct omap_gpio_reg_offs omap16xx_gpio_regs;
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
@@ -240,6 +199,35 @@ static int __init omap16xx_gpio_init(void)
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
 
+	memset(&omap16xx_mpuio_regs, 0xFF, sizeof(omap16xx_mpuio_regs));
+
+	omap16xx_mpuio_regs.direction = OMAP_MPUIO_IO_CNTL;
+	omap16xx_mpuio_regs.datain = OMAP_MPUIO_INPUT_LATCH;
+	omap16xx_mpuio_regs.dataout = OMAP_MPUIO_OUTPUT;
+	omap16xx_mpuio_regs.irqstatus = OMAP_MPUIO_GPIO_INT;
+	omap16xx_mpuio_regs.irqenable = OMAP_MPUIO_GPIO_MASKIT;
+	omap16xx_mpuio_regs.irqenable_inv = true;
+	omap16xx_mpuio_regs.irqctrl = OMAP_MPUIO_GPIO_INT_EDGE;
+
+	memset(&omap16xx_gpio_regs, 0xFF, sizeof(omap16xx_gpio_regs));
+
+	omap16xx_gpio_regs.revision = OMAP1610_GPIO_REVISION;
+	omap16xx_gpio_regs.direction = OMAP1610_GPIO_DIRECTION;
+	omap16xx_gpio_regs.set_dataout = OMAP1610_GPIO_SET_DATAOUT;
+	omap16xx_gpio_regs.clr_dataout = OMAP1610_GPIO_CLEAR_DATAOUT;
+	omap16xx_gpio_regs.datain = OMAP1610_GPIO_DATAIN;
+	omap16xx_gpio_regs.dataout = OMAP1610_GPIO_DATAOUT;
+	omap16xx_gpio_regs.irqstatus = OMAP1610_GPIO_IRQSTATUS1;
+	omap16xx_gpio_regs.irqenable = OMAP1610_GPIO_IRQENABLE1;
+	omap16xx_gpio_regs.irqenable_inv = false;
+	omap16xx_gpio_regs.set_irqenable = OMAP1610_GPIO_SET_IRQENABLE1;
+	omap16xx_gpio_regs.clr_irqenable = OMAP1610_GPIO_CLEAR_IRQENABLE1;
+	omap16xx_gpio_regs.wkupstatus = OMAP1610_GPIO_WAKEUPENABLE;
+	omap16xx_gpio_regs.wkupclear = OMAP1610_GPIO_CLEAR_WAKEUPENA;
+	omap16xx_gpio_regs.wkupset = OMAP1610_GPIO_SET_WAKEUPENA;
+	omap16xx_gpio_regs.edgectrl1 = OMAP1610_GPIO_EDGE_CTRL1;
+	omap16xx_gpio_regs.edgectrl2 = OMAP1610_GPIO_EDGE_CTRL2;
+
 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
 		platform_device_register(omap16xx_gpio_dev[i]);
 
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index ceac936..b7ae003 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -39,26 +39,7 @@ static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
 	},
 };
 
-static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
-	.revision	= USHRT_MAX,
-	.direction	= OMAP_MPUIO_IO_CNTL / 2,
-	.datain		= OMAP_MPUIO_INPUT_LATCH / 2,
-	.dataout	= OMAP_MPUIO_OUTPUT / 2,
-	.irqstatus	= OMAP_MPUIO_GPIO_INT / 2,
-	.irqenable	= OMAP_MPUIO_GPIO_MASKIT / 2,
-	.irqenable_inv	= true,
-	.ctrl		= USHRT_MAX,
-	.wkupstatus	= USHRT_MAX,
-	.wkupclear	= USHRT_MAX,
-	.wkupset	= USHRT_MAX,
-	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE / 2,
-	.edgectrl1	= USHRT_MAX,
-	.edgectrl2	= USHRT_MAX,
-	.leveldetect0	= USHRT_MAX,
-	.leveldetect1	= USHRT_MAX,
-	.risingdetect	= USHRT_MAX,
-	.fallingdetect	= USHRT_MAX,
-};
+static struct omap_gpio_reg_offs omap7xx_mpuio_regs;
 
 static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
@@ -91,26 +72,7 @@ static struct __initdata resource omap7xx_gpio1_resources[] = {
 	},
 };
 
-static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
-	.revision	= USHRT_MAX,
-	.direction	= OMAP7XX_GPIO_DIR_CONTROL,
-	.datain		= OMAP7XX_GPIO_DATA_INPUT,
-	.dataout	= OMAP7XX_GPIO_DATA_OUTPUT,
-	.irqstatus	= OMAP7XX_GPIO_INT_STATUS,
-	.irqenable	= OMAP7XX_GPIO_INT_MASK,
-	.irqenable_inv	= true,
-	.ctrl		= USHRT_MAX,
-	.wkupstatus	= USHRT_MAX,
-	.wkupclear	= USHRT_MAX,
-	.wkupset	= USHRT_MAX,
-	.irqctrl	= OMAP7XX_GPIO_INT_CONTROL,
-	.edgectrl1	= USHRT_MAX,
-	.edgectrl2	= USHRT_MAX,
-	.leveldetect0	= USHRT_MAX,
-	.leveldetect1	= USHRT_MAX,
-	.risingdetect	= USHRT_MAX,
-	.fallingdetect	= USHRT_MAX,
-};
+static struct omap_gpio_reg_offs omap7xx_gpio_regs;
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
@@ -301,6 +263,26 @@ static int __init omap7xx_gpio_init(void)
 	if (!cpu_is_omap7xx())
 		return -EINVAL;
 
+	memset(&omap7xx_mpuio_regs, USHRT_MAX, sizeof(omap7xx_mpuio_regs));
+
+	omap7xx_mpuio_regs.direction = OMAP_MPUIO_IO_CNTL / 2;
+	omap7xx_mpuio_regs.datain = OMAP_MPUIO_INPUT_LATCH / 2;
+	omap7xx_mpuio_regs.dataout = OMAP_MPUIO_OUTPUT / 2;
+	omap7xx_mpuio_regs.irqstatus = OMAP_MPUIO_GPIO_INT / 2;
+	omap7xx_mpuio_regs.irqenable = OMAP_MPUIO_GPIO_MASKIT / 2;
+	omap7xx_mpuio_regs.irqenable_inv = true;
+	omap7xx_mpuio_regs.irqctrl = OMAP_MPUIO_GPIO_INT_EDGE / 2;
+
+	memset(&omap7xx_gpio_regs, USHRT_MAX, sizeof(omap7xx_gpio_regs));
+
+	omap7xx_gpio_regs.direction = OMAP7XX_GPIO_DIR_CONTROL;
+	omap7xx_gpio_regs.datain = OMAP7XX_GPIO_DATA_INPUT;
+	omap7xx_gpio_regs.dataout = OMAP7XX_GPIO_DATA_OUTPUT;
+	omap7xx_gpio_regs.irqstatus = OMAP7XX_GPIO_INT_STATUS;
+	omap7xx_gpio_regs.irqenable = OMAP7XX_GPIO_INT_MASK;
+	omap7xx_gpio_regs.irqenable_inv	= true;
+	omap7xx_gpio_regs.irqctrl = OMAP7XX_GPIO_INT_CONTROL;
+
 	for (i = 0; i < ARRAY_SIZE(omap7xx_gpio_dev); i++)
 		platform_device_register(omap7xx_gpio_dev[i]);
 
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index eda1846..dce56d9 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -92,9 +92,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return -ENOMEM;
 	}
 
-	pdata->regs->irqctrl = USHRT_MAX;
-	pdata->regs->edgectrl1 = USHRT_MAX;
-	pdata->regs->edgectrl2 = USHRT_MAX;
+	memset(pdata->regs, USHRT_MAX, sizeof(struct omap_gpio_reg_offs));
+	pdata->regs->irqenable_inv = false;
 
 	switch (oh->class->rev) {
 	case 0:
-- 
1.6.0.4

