From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/11] omap1: Fix gpio mpuio bank to work for multi-omap
 for 7xx/15xx/16xx
Date: Tue, 7 Dec 2010 15:23:16 -0800
Message-ID: <20101207232315.GE17435@atomide.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
 <20101201183357.GI17222@atomide.com>
 <87zkso4hu3.fsf@deeprootsystems.com>
 <AANLkTinY8FKbVvXD29KpgGnsnKwQziXws+zKLZWn69Hj@mail.gmail.com>
 <20101204212554.GM17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28418 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab0LGXX1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 18:23:27 -0500
Content-Disposition: inline
In-Reply-To: <20101204212554.GM17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, p-basak2@ti.com, Cory Maccarrone <darkstar6262@gmail.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

* Tony Lindgren <tony@atomide.com> [101204 13:16]:
> * Varadarajan, Charulatha <charu@ti.com> [101202 06:08]:
> > On Thu, Dec 2, 2010 at 15:28, Kevin Hilman <khilman@deeprootsystems.com> wrote:
> > 
> > >
> > > Tony, you can also add
> > >
> > > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> OK, updated. Also made one more GPIO patch to allow us to deal
> with the 7xx vs 15xx/16xx MPUIO registers.

Turns out that broke drivers/mtd/nand/ams-delta.c as it directly uses
multiple lines in parallel. So let's use 15xx/16xx offsets instead
and divide them by two.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Sat, 4 Dec 2010 12:39:43 -0800
Subject: [PATCH] omap1: Fix gpio mpuio bank to work for multi-omap for 7xx/15xx/16xx

We need to divide the 15xx/16xx offset by 2 for 7xx. Use bank->stride
for that. This allows us to get rid of the duplicate defines for the
MPUIO registers.

Note that this will cause omap-keypad.c driver to not work on 7xx.
However, the right fix there is to move over to gpio-keys instead as
suggested by Cory Maccarrone <darkstar6262@gmail.com> and
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>.

Cc: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index dbd8168..04c4b04 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -38,6 +38,7 @@ static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
 	.bank_type		= METHOD_MPUIO,
 	.bank_width		= 16,
+	.bank_stride		= 1,
 };
 
 static struct __initdata platform_device omap15xx_mpu_gpio = {
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 8d4d0a0..5dd0d4c 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -41,6 +41,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
 	.bank_type		= METHOD_MPUIO,
 	.bank_width		= 16,
+	.bank_stride		= 1,
 };
 
 static struct __initdata platform_device omap16xx_mpu_gpio = {
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 94bccd4..1204c8b 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -43,6 +43,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
 	.bank_type		= METHOD_MPUIO,
 	.bank_width		= 32,
+	.bank_stride		= 2,
 };
 
 static struct __initdata platform_device omap7xx_mpu_gpio = {
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 59afe77..de93251 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -159,6 +159,7 @@ struct gpio_bank {
 	u32 dbck_enable_mask;
 	struct device *dev;
 	bool dbck_flag;
+	int stride;
 };
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -267,7 +268,7 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_IO_CNTL;
+		reg += OMAP_MPUIO_IO_CNTL / bank->stride;
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -315,7 +316,7 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_OUTPUT;
+		reg += OMAP_MPUIO_OUTPUT / bank->stride;
 		l = __raw_readl(reg);
 		if (enable)
 			l |= 1 << gpio;
@@ -387,7 +388,7 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_INPUT_LATCH;
+		reg += OMAP_MPUIO_INPUT_LATCH / bank->stride;
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -433,7 +434,7 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_OUTPUT;
+		reg += OMAP_MPUIO_OUTPUT / bank->stride;
 		break;
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -620,7 +621,7 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 
 	switch (bank->method) {
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_INT_EDGE;
+		reg += OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
 		break;
 #ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
@@ -654,7 +655,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_INT_EDGE;
+		reg += OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
 		l = __raw_readl(reg);
 		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 			bank->toggle_mask |= 1 << gpio;
@@ -840,7 +841,7 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_MASKIT;
+		reg += OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 		mask = 0xffff;
 		inv = 1;
 		break;
@@ -897,7 +898,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_MASKIT;
+		reg += OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 		l = __raw_readl(reg);
 		if (enable)
 			l &= ~(gpio_mask);
@@ -1147,7 +1148,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	bank = get_irq_data(irq);
 #ifdef CONFIG_ARCH_OMAP1
 	if (bank->method == METHOD_MPUIO)
-		isr_reg = bank->base + OMAP_MPUIO_GPIO_INT;
+		isr_reg = bank->base +
+				OMAP_MPUIO_GPIO_INT / bank->stride;
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (bank->method == METHOD_GPIO_1510)
@@ -1340,7 +1342,8 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank	*bank = platform_get_drvdata(pdev);
-	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
+	void __iomem		*mask_reg = bank->base +
+					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
@@ -1355,7 +1358,8 @@ static int omap_mpuio_resume_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank	*bank = platform_get_drvdata(pdev);
-	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
+	void __iomem		*mask_reg = bank->base +
+					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
@@ -1435,7 +1439,7 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 
 	switch (bank->method) {
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_IO_CNTL;
+		reg += OMAP_MPUIO_IO_CNTL / bank->stride;
 		break;
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_DIR_CONTROL;
@@ -1596,8 +1600,8 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 		}
 	} else if (cpu_class_is_omap1()) {
 		if (bank_is_mpuio(bank))
-			__raw_writew(0xffff, bank->base
-						+ OMAP_MPUIO_GPIO_MASKIT);
+			__raw_writew(0xffff, bank->base +
+				OMAP_MPUIO_GPIO_MASKIT / bank->stride);
 		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
 			__raw_writew(0xffff, bank->base
 						+ OMAP1510_GPIO_INT_MASK);
@@ -1711,6 +1715,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->method = pdata->bank_type;
 	bank->dev = &pdev->dev;
 	bank->dbck_flag = pdata->dbck_flag;
+	bank->stride = pdata->bank_stride;
 	bank_width = pdata->bank_width;
 
 	spin_lock_init(&bank->lock);
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 5f118ff..41ff2f8 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -32,22 +32,10 @@
 
 #define OMAP1_MPUIO_BASE			0xfffb5000
 
-#if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
-
-#define OMAP_MPUIO_INPUT_LATCH		0x00
-#define OMAP_MPUIO_OUTPUT		0x02
-#define OMAP_MPUIO_IO_CNTL		0x04
-#define OMAP_MPUIO_KBR_LATCH		0x08
-#define OMAP_MPUIO_KBC			0x0a
-#define OMAP_MPUIO_GPIO_EVENT_MODE	0x0c
-#define OMAP_MPUIO_GPIO_INT_EDGE	0x0e
-#define OMAP_MPUIO_KBD_INT		0x10
-#define OMAP_MPUIO_GPIO_INT		0x12
-#define OMAP_MPUIO_KBD_MASKIT		0x14
-#define OMAP_MPUIO_GPIO_MASKIT		0x16
-#define OMAP_MPUIO_GPIO_DEBOUNCING	0x18
-#define OMAP_MPUIO_LATCH		0x1a
-#else
+/*
+ * These are the omap15xx/16xx offsets. The omap7xx offset are
+ * OMAP_MPUIO_ / 2 offsets below.
+ */
 #define OMAP_MPUIO_INPUT_LATCH		0x00
 #define OMAP_MPUIO_OUTPUT		0x04
 #define OMAP_MPUIO_IO_CNTL		0x08
@@ -61,7 +49,6 @@
 #define OMAP_MPUIO_GPIO_MASKIT		0x2c
 #define OMAP_MPUIO_GPIO_DEBOUNCING	0x30
 #define OMAP_MPUIO_LATCH		0x34
-#endif
 
 #define OMAP34XX_NR_GPIOS		6
 
@@ -88,6 +75,7 @@ struct omap_gpio_platform_data {
 	u16 virtual_irq_start;
 	int bank_type;
 	int bank_width;		/* GPIO bank width */
+	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
 };
 
