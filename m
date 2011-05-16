From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [RFC PATCH 03/10] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
Date: Mon, 16 May 2011 17:11:37 +0530
Message-ID: <1305546104-1511-4-git-send-email-tarun.kanti@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48339 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab1EPLlx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 07:41:53 -0400
In-Reply-To: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

From: Charulatha V <charu@ti.com>

Non-wakeup GPIOs are available only in OMAP2420 and OMAP3430. But
the GPIO driver initializes the non-wakeup GPIO bits for OMAP24xx
(bothe OMAP 2420 and 2430) & not for OMAP3 which is incorrect.

Fix the above by providing non-wakeup GPIO information through pdata
specific to the SoC.

The GPIO rev id provided in the hwmod database is the same for OMAP2420
and OMAP2430. Change the GPIO rev ids in hwmod database as given below
so that it can be used to identify OMAP2420 and OMAP2430.
OMAP2420 - 0
OMAP2430 - 1
OMAP3    - 2
OMAP4    - 3

Signed-off-by: Charulatha V <charu@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpio.c                 |   26 ++++++++++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 arch/arm/plat-omap/gpio.c                  |   11 +++--------
 arch/arm/plat-omap/include/plat/gpio.h     |    1 +
 6 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 0446bd1..6cd26b4 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -56,6 +56,28 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return -ENOMEM;
 	}
 
+	switch (oh->class->rev) {
+	case 0:
+		if (id == 1)
+			/* non-wakeup GPIO pins for OMAP2420 Bank1 */
+			pdata->non_wakeup_gpios = 0xe203ffc0;
+		else if (id == 2)
+			/* non-wakeup GPIO pins for OMAP2420 Bank2 */
+			pdata->non_wakeup_gpios = 0x08700040;
+		break;
+	case 2:
+		if (id == 2)
+			/* non-wakeup GPIO pins for OMAP3 Bank2 */
+			pdata->non_wakeup_gpios = 0x00000001;
+		else if (id == 6)
+			/* non-wakeup GPIO pins for OMAP3 Bank6 */
+			pdata->non_wakeup_gpios = 0x08000000;
+		break;
+	default:
+		/* No non-wakeup GPIO pins for other SoCs */
+		break;
+	}
+
 	dev_attr = (struct omap_gpio_dev_attr *)oh->dev_attr;
 	pdata->bank_width = dev_attr->bank_width;
 	pdata->dbck_flag = dev_attr->dbck_flag;
@@ -70,6 +92,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	switch (oh->class->rev) {
 	case 0:
 	case 1:
+	case 2:
 		pdata->bank_type = METHOD_GPIO_24XX;
 		pdata->regs->revision = OMAP24XX_GPIO_REVISION;
 		pdata->regs->direction = OMAP24XX_GPIO_OE;
@@ -86,7 +109,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
 		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
 		break;
-	case 2:
+	case 3:
 		pdata->bank_type = METHOD_GPIO_44XX;
 		pdata->regs->revision = OMAP4_GPIO_REVISION;
 		pdata->regs->direction = OMAP4_GPIO_OE;
@@ -108,7 +131,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		kfree(pdata);
 		return -EINVAL;
 	}
-
 	od = omap_device_build(name, id - 1, oh, pdata,
 				sizeof(*pdata),	omap_gpio_latency,
 				ARRAY_SIZE(omap_gpio_latency),
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index e6e3810..dc819aa 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1728,7 +1728,7 @@ static struct omap_hwmod_class_sysconfig omap243x_gpio_sysc = {
 static struct omap_hwmod_class omap243x_gpio_hwmod_class = {
 	.name = "gpio",
 	.sysc = &omap243x_gpio_sysc,
-	.rev = 0,
+	.rev = 1,
 };
 
 /* gpio1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index b98e2df..010e3c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2117,7 +2117,7 @@ static struct omap_hwmod_class_sysconfig omap3xxx_gpio_sysc = {
 static struct omap_hwmod_class omap3xxx_gpio_hwmod_class = {
 	.name = "gpio",
 	.sysc = &omap3xxx_gpio_sysc,
-	.rev = 1,
+	.rev = 2,
 };
 
 /* gpio_dev_attr*/
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3e88dd3..df8e629 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1703,7 +1703,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
 static struct omap_hwmod_class omap44xx_gpio_hwmod_class = {
 	.name	= "gpio",
 	.sysc	= &omap44xx_gpio_sysc,
-	.rev	= 2,
+	.rev	= 3,
 };
 
 /* gpio dev_attr */
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 65f9cbc..12deb1c 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1010,7 +1010,7 @@ static inline int init_gpio_info(struct platform_device *pdev)
 }
 
 /* TODO: Cleanup cpu_is_* checks */
-static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
+static void omap_gpio_mod_init(struct gpio_bank *bank)
 {
 	if (cpu_class_is_omap2()) {
 		if (cpu_is_omap44xx()) {
@@ -1030,12 +1030,6 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 
 			/* Initialize interface clk ungated, module enabled */
 			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
-		} else if (cpu_is_omap24xx()) {
-			static const u32 non_wakeup_gpios[] = {
-				0xe203ffc0, 0x08700040
-			};
-			if (id < ARRAY_SIZE(non_wakeup_gpios))
-				bank->non_wakeup_gpios = non_wakeup_gpios[id];
 		}
 	} else if (cpu_class_is_omap1()) {
 		if (bank_is_mpuio(bank))
@@ -1181,6 +1175,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
+	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
 
 	bank->regs = pdata->regs;
 
@@ -1207,7 +1202,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	pm_runtime_enable(bank->dev);
 	pm_runtime_get_sync(bank->dev);
 
-	omap_gpio_mod_init(bank, id);
+	omap_gpio_mod_init(bank);
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index caf432c..8014a8a 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -199,6 +199,7 @@ struct omap_gpio_platform_data {
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
+	u32 non_wakeup_gpios;
 
 	struct omap_gpio_reg_offs *regs;
 };
-- 
1.7.1
