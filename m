From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 15/15] OMAP: GPIO: cleanup show revision, remove cpu_is checks, display only once
Date: Fri, 22 Apr 2011 16:02:07 -0700
Message-ID: <1303513327-14532-16-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:51644 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755489Ab1DVXAe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 19:00:34 -0400
Received: by mail-pw0-f43.google.com with SMTP id 4so508899pwj.30
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 16:00:33 -0700 (PDT)
In-Reply-To: <1303513327-14532-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: charu@ti.com

Remove cpu_is_* checks from gpio_show_revision() by passing in the
revision address offset from platform data.  SoCs with no revision
register (15xx, 7xx, and all MPUIOs) use -1 to signify no register.

While here, all GPIO banks are assumed to be the same revision, so fix
show_revision() to only show the revision for the first bank it finds.
This removes duplicate GPIO revision prints during boot.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    2 ++
 arch/arm/mach-omap1/gpio16xx.c         |    2 ++
 arch/arm/mach-omap1/gpio7xx.c          |    2 ++
 arch/arm/mach-omap2/gpio.c             |    2 ++
 arch/arm/plat-omap/gpio.c              |   14 ++++++--------
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 6 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 9175624..6f77c36 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -35,6 +35,7 @@ static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
+	.revision       = -1,
 	.direction	= OMAP_MPUIO_IO_CNTL,
 	.datain		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout	= OMAP_MPUIO_OUTPUT,
@@ -75,6 +76,7 @@ static struct __initdata resource omap15xx_gpio_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
+	.revision	= -1,
 	.direction	= OMAP1510_GPIO_DIR_CONTROL,
 	.datain		= OMAP1510_GPIO_DATA_INPUT,
 	.dataout	= OMAP1510_GPIO_DATA_OUTPUT,
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index a6d4a71..6cbfc70 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -38,6 +38,7 @@ static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
+	.revision       = -1,
 	.direction	= OMAP_MPUIO_IO_CNTL,
 	.datain		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout	= OMAP_MPUIO_OUTPUT,
@@ -78,6 +79,7 @@ static struct __initdata resource omap16xx_gpio1_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
+	.revision       = OMAP1610_GPIO_REVISION,
 	.direction	= OMAP1610_GPIO_DIRECTION,
 	.set_dataout	= OMAP1610_GPIO_SET_DATAOUT,
 	.clr_dataout	= OMAP1610_GPIO_CLEAR_DATAOUT,
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 880f3cb..293a22e 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -40,6 +40,7 @@ static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
+	.revision       = -1,
 	.direction	= OMAP_MPUIO_IO_CNTL / 2,
 	.datain		= OMAP_MPUIO_INPUT_LATCH / 2,
 	.dataout	= OMAP_MPUIO_OUTPUT / 2,
@@ -80,6 +81,7 @@ static struct __initdata resource omap7xx_gpio1_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
+	.revision       = -1,
 	.direction	= OMAP7XX_GPIO_DIR_CONTROL,
 	.datain		= OMAP7XX_GPIO_DATA_INPUT,
 	.dataout	= OMAP7XX_GPIO_DATA_OUTPUT,
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 316d930..9a46d77 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -71,6 +71,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	case 0:
 	case 1:
 		pdata->bank_type = METHOD_GPIO_24XX;
+		pdata->regs->revision = OMAP24XX_GPIO_REVISION;
 		pdata->regs->direction = OMAP24XX_GPIO_OE;
 		pdata->regs->datain = OMAP24XX_GPIO_DATAIN;
 		pdata->regs->dataout = OMAP24XX_GPIO_DATAOUT;
@@ -86,6 +87,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
+		pdata->regs->revision = OMAP4_GPIO_REVISION;
 		pdata->regs->direction = OMAP4_GPIO_OE;
 		pdata->regs->datain = OMAP4_GPIO_DATAIN;
 		pdata->regs->dataout = OMAP4_GPIO_DATAOUT;
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 17f29cc..f88616e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -985,19 +985,17 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
 
 static void __init omap_gpio_show_rev(struct gpio_bank *bank)
 {
+	static bool called;
 	u32 rev;
 
-	if (cpu_is_omap16xx() && !(bank->method != METHOD_MPUIO))
-		rev = __raw_readw(bank->base + OMAP1610_GPIO_REVISION);
-	else if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		rev = __raw_readl(bank->base + OMAP24XX_GPIO_REVISION);
-	else if (cpu_is_omap44xx())
-		rev = __raw_readl(bank->base + OMAP4_GPIO_REVISION);
-	else
+	if (called || bank->regs->revision == -1)
 		return;
 
-	printk(KERN_INFO "OMAP GPIO hardware version %d.%d\n",
+	rev = __raw_readw(bank->base + bank->regs->revision);
+	pr_info("OMAP GPIO hardware version %d.%d\n",
 		(rev >> 4) & 0x0f, rev & 0x0f);
+
+	called = true;
 }
 
 /* This lock class tells lockdep that GPIO irqs are in a different
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 7a3f067..91e8de3 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -175,6 +175,7 @@ struct omap_gpio_dev_attr {
 };
 
 struct omap_gpio_reg_offs {
+	u16 revision;
 	u16 direction;
 	u16 datain;
 	u16 dataout;
-- 
1.7.4

