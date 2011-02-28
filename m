From: Charulatha V <charu@ti.com>
Subject: [PATCH 2/5] OMAP: GPIO: use pwrdmn name to find wkup dmn GPIO
Date: Mon, 28 Feb 2011 16:27:47 +0530
Message-ID: <1298890670-5481-3-git-send-email-charu@ti.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37845 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753559Ab1B1K4g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 05:56:36 -0500
In-Reply-To: <1298890670-5481-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, paul@pwsan.com, Charulatha V <charu@ti.com>

In omap3, save/restore context is implemented for GPIO
banks 2-6 as GPIO bank1 is in wakeup domain. Instead
of identifying bank's power domain by bank id, make use
of powerdomain name itself.

For this, omap_hwmod_get_pwrdm() is used. omap_device_get_pwrdm()
could not be used as the pwrdm information needs to be filled
in pdata. But omap_device_get_pwrdm() can be used only after
omap_device_build() call.

Signed-off-by: Charulatha V <charu@ti.com>

Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
(2430-SDP testing)
---
 arch/arm/mach-omap2/gpio.c             |    6 ++++++
 arch/arm/plat-omap/gpio.c              |   31 ++++++++++++++++++++-----------
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 413de18..39b0d96 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -24,6 +24,8 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
+#include "powerdomain.h"
+
 static struct omap_device_pm_latency omap_gpio_latency[] = {
 	[0] = {
 		.deactivate_func = omap_device_idle_hwmods,
@@ -39,6 +41,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	struct omap_gpio_dev_attr *dev_attr;
 	char *name = "omap_gpio";
 	int id;
+	struct powerdomain *pwrdm;
 
 	/*
 	 * extract the device id from name field available in the
@@ -75,6 +78,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return -EINVAL;
 	}
 
+	pwrdm = omap_hwmod_get_pwrdm(oh);
+	strcpy(pdata->pwrdm_name, pwrdm->name);
+
 	od = omap_device_build(name, id - 1, oh, pdata,
 				sizeof(*pdata),	omap_gpio_latency,
 				ARRAY_SIZE(omap_gpio_latency),
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c6ab0ff..ff341ec 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -172,6 +172,7 @@ struct gpio_bank {
 	struct device *dev;
 	bool dbck_flag;
 	int stride;
+	const char *pwrdm_name;
 };
 
 /*
@@ -1720,6 +1721,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank_width = pdata->bank_width;
+	bank->pwrdm_name = pdata->pwrdm_name;
 
 	spin_lock_init(&bank->lock);
 
@@ -1865,16 +1867,15 @@ static int workaround_enabled;
 void omap2_gpio_prepare_for_idle(int off_mode)
 {
 	int i, c = 0;
-	int min = 0;
 
-	if (cpu_is_omap34xx())
-		min = 1;
-
-	for (i = min; i < gpio_bank_count; i++) {
+	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l1 = 0, l2 = 0;
 		int j;
 
+		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
+			continue;
+
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_disable(bank->dbck);
 
@@ -1934,15 +1935,15 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 void omap2_gpio_resume_after_idle(void)
 {
 	int i;
-	int min = 0;
 
-	if (cpu_is_omap34xx())
-		min = 1;
-	for (i = min; i < gpio_bank_count; i++) {
+	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l = 0, gen, gen0, gen1;
 		int j;
 
+		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
+			continue;
+
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 			clk_enable(bank->dbck);
 
@@ -2037,8 +2038,12 @@ void omap_gpio_save_context(void)
 	int i;
 
 	/* saving banks from 2-6 only since GPIO1 is in WKUP */
-	for (i = 1; i < gpio_bank_count; i++) {
+	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
+
+		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
+			continue;
+
 		bank->context.irqenable1 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		bank->context.irqenable2 =
@@ -2067,8 +2072,12 @@ void omap_gpio_restore_context(void)
 {
 	int i;
 
-	for (i = 1; i < gpio_bank_count; i++) {
+	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
+
+		if (!strcmp(bank->pwrdm_name, "wkup_pwrdm"))
+			continue;
+
 		__raw_writel(bank->context.irqenable1,
 				bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		__raw_writel(bank->context.irqenable2,
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index d6f9fa0..2c46caa 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -77,6 +77,7 @@ struct omap_gpio_platform_data {
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
+	char pwrdm_name[20];	/* bank powerdomain name */
 };
 
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
-- 
1.7.1

