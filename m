From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 1/8] gpio/omap: remove virtual_irq_start variable
Date: Fri, 27 Apr 2012 19:43:31 +0530
Message-ID: <1335536018-16004-2-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53976 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760165Ab2D0ON7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 10:13:59 -0400
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

This cleanup got missed while implementing following:
25db711 gpio/omap: Fix IRQ handling for SPARSE_IRQ
384ebe1 gpio/omap: Add DT support to GPIO driver

Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    2 --
 arch/arm/mach-omap1/gpio16xx.c         |    5 -----
 arch/arm/mach-omap1/gpio7xx.c          |    7 -------
 arch/arm/mach-omap2/gpio.c             |    1 -
 arch/arm/plat-omap/include/plat/gpio.h |    1 -
 5 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 634903e..ebef15e 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -46,7 +46,6 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
-	.virtual_irq_start	= IH_MPUIO_BASE,
 	.is_mpuio		= true,
 	.bank_width		= 16,
 	.bank_stride		= 1,
@@ -89,7 +88,6 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
-	.virtual_irq_start	= IH_GPIO_BASE,
 	.bank_width		= 16,
 	.regs                   = &omap15xx_gpio_regs,
 };
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 1fb3b9a..2a48cd2 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -52,7 +52,6 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
-	.virtual_irq_start	= IH_MPUIO_BASE,
 	.is_mpuio		= true,
 	.bank_width		= 16,
 	.bank_stride		= 1,
@@ -99,7 +98,6 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
-	.virtual_irq_start	= IH_GPIO_BASE,
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
@@ -128,7 +126,6 @@ static struct __initdata resource omap16xx_gpio2_resources[] = {
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio2_config = {
-	.virtual_irq_start	= IH_GPIO_BASE + 16,
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
@@ -157,7 +154,6 @@ static struct __initdata resource omap16xx_gpio3_resources[] = {
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio3_config = {
-	.virtual_irq_start	= IH_GPIO_BASE + 32,
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
@@ -186,7 +182,6 @@ static struct __initdata resource omap16xx_gpio4_resources[] = {
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio4_config = {
-	.virtual_irq_start	= IH_GPIO_BASE + 48,
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 4771d6b..acf12b7 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -51,7 +51,6 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
-	.virtual_irq_start	= IH_MPUIO_BASE,
 	.is_mpuio		= true,
 	.bank_width		= 16,
 	.bank_stride		= 2,
@@ -93,7 +92,6 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
-	.virtual_irq_start	= IH_GPIO_BASE,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -122,7 +120,6 @@ static struct __initdata resource omap7xx_gpio2_resources[] = {
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio2_config = {
-	.virtual_irq_start	= IH_GPIO_BASE + 32,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -151,7 +148,6 @@ static struct __initdata resource omap7xx_gpio3_resources[] = {
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio3_config = {
-	.virtual_irq_start	= IH_GPIO_BASE + 64,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -180,7 +176,6 @@ static struct __initdata resource omap7xx_gpio4_resources[] = {
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio4_config = {
-	.virtual_irq_start	= IH_GPIO_BASE + 96,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -209,7 +204,6 @@ static struct __initdata resource omap7xx_gpio5_resources[] = {
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio5_config = {
-	.virtual_irq_start	= IH_GPIO_BASE + 128,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -238,7 +232,6 @@ static struct __initdata resource omap7xx_gpio6_resources[] = {
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio6_config = {
-	.virtual_irq_start	= IH_GPIO_BASE + 160,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 2f994e5..86f91a6 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -55,7 +55,6 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	dev_attr = (struct omap_gpio_dev_attr *)oh->dev_attr;
 	pdata->bank_width = dev_attr->bank_width;
 	pdata->dbck_flag = dev_attr->dbck_flag;
-	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
 	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 	pdata->regs = kzalloc(sizeof(struct omap_gpio_reg_offs), GFP_KERNEL);
 	if (!pdata) {
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 2f6e992..d903e7d 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -193,7 +193,6 @@ struct omap_gpio_reg_offs {
 };
 
 struct omap_gpio_platform_data {
-	u16 virtual_irq_start;
 	int bank_type;
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
-- 
1.7.0.4

