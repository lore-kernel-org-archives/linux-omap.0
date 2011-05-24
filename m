From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 04/15] OMAP2PLUS: GPIO: Use flag to identify wkup dmn GPIO
Date: Tue, 24 May 2011 19:54:43 +0530
Message-ID: <1306247094-25372-5-git-send-email-tarun.kanti@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43541 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932126Ab1EXOZX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 10:25:23 -0400
In-Reply-To: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

In omap3, save/restore context is implemented for GPIO
banks 2-6 as GPIO bank1 is in wakeup domain. Instead
of identifying bank's power domain by bank id, make use
of a flag "loses_context" which is filled by
pwrdm_can_ever_lose_context() during dev_init.

For getting the powerdomain pointer, omap_hwmod_get_pwrdm()
is used. omap_device_get_pwrdm() could not be used as the
pwrdm information needs to be filled in pdata, whereas
omap_device_get_pwrdm() could be used only after
omap_device_build() call.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |    7 +++++++
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 drivers/gpio/gpio_omap.c               |   12 ++++++------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 487b49a..0782e06 100644
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
@@ -131,6 +134,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		kfree(pdata);
 		return -EINVAL;
 	}
+
+	pwrdm = omap_hwmod_get_pwrdm(oh);
+	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
+
 	od = omap_device_build(name, id - 1, oh, pdata,
 				sizeof(*pdata),	omap_gpio_latency,
 				ARRAY_SIZE(omap_gpio_latency),
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index ad9e668..64b1ee7 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -199,6 +199,7 @@ struct omap_gpio_platform_data {
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
+	bool loses_context;	/* whether the bank would ever lose context */
 	u32 non_wakeup_gpios;
 
 	struct omap_gpio_reg_offs *regs;
diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index c6a1ec9..3f1c932 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -56,6 +56,7 @@ struct gpio_bank {
 	u32 dbck_enable_mask;
 	struct device *dev;
 	bool dbck_flag;
+	bool loses_context;
 	int stride;
 	u32 width;
 	u16 id;
@@ -1159,6 +1160,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
 	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
+	bank->loses_context = pdata->loses_context;
 
 	bank->regs = pdata->regs;
 
@@ -1323,8 +1325,7 @@ void omap2_gpio_prepare_for_idle(int off_mode)
 		u32 l1 = 0, l2 = 0;
 		int j;
 
-		/* TODO: Do not use cpu_is_omap34xx */
-		if ((cpu_is_omap34xx()) && (bank->id == 0))
+		if (!bank->loses_context)
 			continue;
 
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
@@ -1391,8 +1392,7 @@ void omap2_gpio_resume_after_idle(void)
 		u32 l = 0, gen, gen0, gen1;
 		int j;
 
-		/* TODO: Do not use cpu_is_omap34xx */
-		if ((cpu_is_omap34xx()) && (bank->id == 0))
+		if (!bank->loses_context)
 			continue;
 
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
@@ -1491,7 +1491,7 @@ void omap_gpio_save_context(void)
 	list_for_each_entry(bank, &omap_gpio_list, node) {
 		i++;
 
-		if (bank->id == 0)
+		if (!bank->loses_context)
 			continue;
 
 		gpio_context[i].irqenable1 =
@@ -1525,7 +1525,7 @@ void omap_gpio_restore_context(void)
 	list_for_each_entry(bank, &omap_gpio_list, node) {
 		i++;
 
-		if (bank->id == 0)
+		if (!bank->loses_context)
 			continue;
 
 		__raw_writel(gpio_context[i].irqenable1,
-- 
1.6.0.4

