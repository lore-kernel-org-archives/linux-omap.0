From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 7/8] gpio/omap: remove cpu_is_omapxxxx() checks from *_runtime_resume()
Date: Fri, 27 Apr 2012 19:43:37 +0530
Message-ID: <1335536018-16004-8-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50695 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756683Ab2D0ONz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 10:13:55 -0400
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

Add register offsets for GPIO_IRQSTATUS_RAW_0, GPIO_IRQSTATUS_RAW_0
which are present on OMAP4+ processors. Now we can distinguish
conditions applicable to OMAP4,5 and those specific to OMAP24xx
and OMAP3xxx.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/gpio.c             |    2 ++
 arch/arm/plat-omap/include/plat/gpio.h |    2 ++
 drivers/gpio/gpio-omap.c               |    4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 86f91a6..a144e22 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -101,6 +101,8 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->dataout = OMAP4_GPIO_DATAOUT;
 		pdata->regs->set_dataout = OMAP4_GPIO_SETDATAOUT;
 		pdata->regs->clr_dataout = OMAP4_GPIO_CLEARDATAOUT;
+		pdata->regs->irqstatus_raw0 = OMAP4_GPIO_IRQSTATUSRAW0;
+		pdata->regs->irqstatus_raw1 = OMAP4_GPIO_IRQSTATUSRAW1;
 		pdata->regs->irqstatus = OMAP4_GPIO_IRQSTATUS0;
 		pdata->regs->irqstatus2 = OMAP4_GPIO_IRQSTATUS1;
 		pdata->regs->irqenable = OMAP4_GPIO_IRQSTATUSSET0;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index d903e7d..50fb7cc 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -172,6 +172,8 @@ struct omap_gpio_reg_offs {
 	u16 clr_dataout;
 	u16 irqstatus;
 	u16 irqstatus2;
+	u16 irqstatus_raw0;
+	u16 irqstatus_raw1;
 	u16 irqenable;
 	u16 irqenable2;
 	u16 set_irqenable;
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ae62c62..d238f84 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1289,14 +1289,14 @@ static int omap_gpio_runtime_resume(struct device *dev)
 		old0 = __raw_readl(bank->base + bank->regs->leveldetect0);
 		old1 = __raw_readl(bank->base + bank->regs->leveldetect1);
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		if (!bank->regs->irqstatus_raw0) {
 			__raw_writel(old0 | gen, bank->base +
 						bank->regs->leveldetect0);
 			__raw_writel(old1 | gen, bank->base +
 						bank->regs->leveldetect1);
 		}
 
-		if (cpu_is_omap44xx()) {
+		if (bank->regs->irqstatus_raw0) {
 			__raw_writel(old0 | l, bank->base +
 						bank->regs->leveldetect0);
 			__raw_writel(old1 | l, bank->base +
-- 
1.7.0.4

