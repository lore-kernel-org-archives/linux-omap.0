From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v7 06/26] gpio/omap: make non-wakeup GPIO part of pdata
Date: Tue, 13 Sep 2011 18:32:39 +0530
Message-ID: <1315918979-26173-7-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49423 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629Ab1IMNDb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Sep 2011 09:03:31 -0400
In-Reply-To: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Non-wakeup GPIOs are available only in OMAP2. Avoid cpu_is checks by making
non_wakeup_gpios as part of pdata.

Signed-off-by: Charulatha V <charu@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |    8 ++++++++
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 drivers/gpio/gpio-omap.c               |    8 +-------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 6c6b1a7..a430fb1 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -75,6 +75,14 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 
 	switch (oh->class->rev) {
 	case 0:
+		if (id == 1)
+			/* non-wakeup GPIO pins for OMAP2 Bank1 */
+			pdata->non_wakeup_gpios = 0xe203ffc0;
+		else if (id == 2)
+			/* non-wakeup GPIO pins for OMAP2 Bank2 */
+			pdata->non_wakeup_gpios = 0x08700040;
+		/* fall through */
+
 	case 1:
 		pdata->bank_type = METHOD_GPIO_24XX;
 		pdata->regs->revision = OMAP24XX_GPIO_REVISION;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 2c06e43..a93adeb 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -199,6 +199,7 @@ struct omap_gpio_platform_data {
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
 	bool loses_context;	/* whether the bank would ever lose context */
+	u32 non_wakeup_gpios;
 
 	struct omap_gpio_reg_offs *regs;
 
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c3cf01f..090feb8 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1021,13 +1021,6 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 
 			/* Initialize interface clk ungated, module enabled */
 			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
-		} else if (cpu_is_omap24xx()) {
-			static const u32 non_wakeup_gpios[] = {
-				0xe203ffc0, 0x08700040
-			};
-			if (bank->id < ARRAY_SIZE(non_wakeup_gpios))
-				bank->non_wakeup_gpios =
-						non_wakeup_gpios[bank->id];
 		}
 	} else if (cpu_class_is_omap1()) {
 		if (bank_is_mpuio(bank)) {
@@ -1180,6 +1173,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
+	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
 	bank->loses_context = pdata->loses_context;
 	bank->get_context_loss_count = pdata->get_context_loss_count;
 	bank->regs = pdata->regs;
-- 
1.7.0.4

