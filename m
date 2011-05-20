From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 14/14] GPIO: OMAP: cleanup show revision, remove cpu_is checks, display only once
Date: Fri, 20 May 2011 17:14:57 +0200
Message-ID: <1305904497-26013-15-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:48691 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933776Ab1ETPPu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:50 -0400
Received: by mail-wy0-f172.google.com with SMTP id 29so3221874wyb.31
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:49 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

Remove cpu_is_* checks from gpio_show_revision() by passing in the
revision address offset from platform data.  SoCs with no revision
register (15xx, 7xx, and all MPUIOs) use -1 (actually, USHRT_MAX) to
signify no register.

While here, all GPIO banks are assumed to be the same revision, so fix
show_revision() to only show the revision for the first bank it finds.
This removes duplicate GPIO revision prints during boot.

Thanks to Charulatha V <charu@ti.com> for finding/fixing a few -1s
that were missed in the original patch.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    2 ++
 arch/arm/mach-omap1/gpio16xx.c         |    2 ++
 arch/arm/mach-omap1/gpio7xx.c          |    2 ++
 arch/arm/mach-omap2/gpio.c             |    2 ++
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 drivers/gpio/gpio_omap.c               |   14 ++++++--------
 6 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 9175624..f79c6ae 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -35,6 +35,7 @@ static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
+	.revision       = USHRT_MAX,
 	.direction	= OMAP_MPUIO_IO_CNTL,
 	.datain		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout	= OMAP_MPUIO_OUTPUT,
@@ -75,6 +76,7 @@ static struct __initdata resource omap15xx_gpio_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
+	.revision	= USHRT_MAX,
 	.direction	= OMAP1510_GPIO_DIR_CONTROL,
 	.datain		= OMAP1510_GPIO_DATA_INPUT,
 	.dataout	= OMAP1510_GPIO_DATA_OUTPUT,
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index a6d4a71..c69b3b1 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -38,6 +38,7 @@ static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
+	.revision       = USHRT_MAX,
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
index 12bcd9f..d7f2ad3 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -40,6 +40,7 @@ static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
+	.revision	= USHRT_MAX,
 	.direction	= OMAP_MPUIO_IO_CNTL / 2,
 	.datain		= OMAP_MPUIO_INPUT_LATCH / 2,
 	.dataout	= OMAP_MPUIO_OUTPUT / 2,
@@ -80,6 +81,7 @@ static struct __initdata resource omap7xx_gpio1_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
+	.revision	= USHRT_MAX,
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
diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 072d568..a490cb1 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -984,19 +984,17 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
 
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
+	if (called || bank->regs->revision == USHRT_MAX)
 		return;
 
-	printk(KERN_INFO "OMAP GPIO hardware version %d.%d\n",
+	rev = __raw_readw(bank->base + bank->regs->revision);
+	pr_info("OMAP GPIO hardware version %d.%d\n",
 		(rev >> 4) & 0x0f, rev & 0x0f);
+
+	called = true;
 }
 
 /* This lock class tells lockdep that GPIO irqs are in a different
-- 
1.7.3.4

