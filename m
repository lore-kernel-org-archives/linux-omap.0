From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 16/18] OMAP: GPIO: move omap_gpio_mod_init to mach-omap
Date: Fri, 22 Apr 2011 16:38:30 +0530
Message-ID: <1303470512-19671-17-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38687 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab1DVLEw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 07:04:52 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Move omap_gpio_mod_init() from plat-omap/ to mach-omap*/
as this function handles architecture specific GPIO module
initialization.

Provide non_wakeup_gpios information through pdata.

With this change all the cpu_is* checks & #ifdef CONFIG_ARCH_OMAP*
will be removed from OMAP GPIO driver.

Also remove all the unsused register offset macros.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    7 ++
 arch/arm/mach-omap1/gpio16xx.c         |   24 +++++
 arch/arm/mach-omap1/gpio7xx.c          |    7 ++
 arch/arm/mach-omap2/gpio.c             |   31 +++++-
 arch/arm/plat-omap/gpio.c              |  172 ++------------------------------
 arch/arm/plat-omap/include/plat/gpio.h |    2 +
 6 files changed, 74 insertions(+), 169 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 3763db3..f8303e6 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -163,6 +163,12 @@ static void gpio_enable_irq(void __iomem *base, int gpio_mask, int enable)
 	gpio_write(l, base, IRQENABLE1);
 }
 
+static void gpio_init(void __iomem *base, u32 id)
+{
+	gpio_write(0xffff, base, INT_CTRL);
+	gpio_write(0, base, IRQSTATUS_REG0);
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
@@ -171,6 +177,7 @@ static struct omap_gpio_func gpio_fn = {
 	.gpio_set_trigger = gpio_set_trigger,
 	.gpio_is_irqena = gpio_is_irqena,
 	.gpio_enable_irq = gpio_enable_irq,
+	.gpio_init = gpio_init,
 };
 
 /*
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index cbac063..37820ba 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -291,6 +291,29 @@ static void gpio_enable_irq(void __iomem *base, int gpio_mask, int enable)
 		gpio_write(gpio_mask, base, CLEARIRQENA1);
 }
 
+/*
+ * GPIO SYSCONFIG needs to be set expicitly in
+ * the driver code only for OMAP16xx. For OMAP2plus
+ * this is taken care by PM runtime framework.
+ * Hence no specific field is required to defined in
+ * omap_gpio_reg_offsets.
+ */
+#define OMAP1610_GPIO_SYSCONFIG		0x0010
+
+static void gpio_init(void __iomem *base, u32 id)
+{
+	gpio_write(0, base, IRQENABLE1);
+	gpio_write(0xffff, base, IRQSTATUS_REG0);
+	__raw_writew(0x0014, base + OMAP1610_GPIO_SYSCONFIG);
+
+	/*
+	 * Enable system clock for GPIO module.
+	 * The CAM_CLK_CTRL *is* really the right place.
+	 */
+	omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
+					ULPD_CAM_CLK_CTRL);
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
@@ -299,6 +322,7 @@ static struct omap_gpio_func gpio_fn = {
 	.gpio_set_trigger = gpio_set_trigger,
 	.gpio_is_irqena = gpio_is_irqena,
 	.gpio_enable_irq = gpio_enable_irq,
+	.gpio_init = gpio_init,
 };
 
 /*
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index cd6bad7..792156c 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -325,6 +325,12 @@ static void gpio_enable_irq(void __iomem *base, int gpio_mask, int enable)
 	gpio_write(l, base, IRQENABLE1);
 }
 
+static void gpio_init(void __iomem *base, u32 id)
+{
+	gpio_write(0xffffffff, base, INT_CTRL);
+	gpio_write(0, base, IRQSTATUS_REG0);
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
@@ -333,6 +339,7 @@ static struct omap_gpio_func gpio_fn = {
 	.gpio_set_trigger = gpio_set_trigger,
 	.gpio_is_irqena = gpio_is_irqena,
 	.gpio_enable_irq = gpio_enable_irq,
+	.gpio_init = gpio_init,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 73b5705..f5615a7 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -421,6 +421,22 @@ static void gpio_restore_ctx(void __iomem *base, u32 id)
 	}
 }
 
+static void gpio_init(void __iomem *base, u32 id)
+{
+	if (cpu_is_omap44xx()) {
+		gpio_write(0xffffffff, base, IRQSTATUSCLR0);
+		gpio_write(0x00000000, base, DEBOUNCE_EN);
+		/* Initialize interface clk ungated, module enabled */
+		gpio_write(0, base, CTRL);
+	} else if (cpu_is_omap34xx()) {
+		gpio_write(0x00000000, base, IRQENABLE1);
+		gpio_write(0xffffffff, base, IRQSTATUS_REG0);
+		gpio_write(0x00000000, base, DEBOUNCE_EN);
+		/* Initialize interface clk ungated, module enabled */
+		gpio_write(0, base, CTRL);
+	}
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
@@ -434,6 +450,7 @@ static struct omap_gpio_func gpio_fn = {
 	.gpio_resume_after_idle = gpio_resume_after_idle,
 	.gpio_save_ctx = gpio_save_ctx,
 	.gpio_restore_ctx = gpio_restore_ctx,
+	.gpio_init = gpio_init,
 };
 
 static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
@@ -442,7 +459,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	struct omap_gpio_platform_data *pdata;
 	struct omap_gpio_dev_attr *dev_attr;
 	char *name = "omap_gpio";
-	int id;
+	int id, i;
 	struct gpio_state *gpio_dev_state;
 
 	/*
@@ -454,6 +471,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	 * or make use of static variable mechanism to handle this.
 	 */
 	sscanf(oh->name, "gpio%d", &id);
+	i = id - 1;
 
 	pdata = kzalloc(sizeof(struct omap_gpio_platform_data), GFP_KERNEL);
 	if (!pdata) {
@@ -465,12 +483,17 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	bank_width = dev_attr->bank_width;
 	pdata->bank_width = bank_width;
 	pdata->dbck_flag = dev_attr->dbck_flag;
-	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
+	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * i;
 	pdata->gpio_fn = &gpio_fn;
 	pdata->suspend_resume_support = true;
 
 	switch (oh->class->rev) {
 	case 0:
+		if (!i)
+			pdata->non_wakeup_gpios = 0xe203ffc0;
+		else if (i == 1)
+			pdata->non_wakeup_gpios = 0x08700040;
+		/* FALL THROUGH */
 	case 1:
 		pdata->bank_type = METHOD_GPIO_24XX;
 		reg_map = omap2_gpio_reg_offsets;
@@ -493,10 +516,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return -ENOMEM;
 	}
 
-	gpio_dev_state->id = id - 1;
+	gpio_dev_state->id = i;
 	list_add_tail(&gpio_dev_state->node, &omap_gpio_ctx_list);
 
-	od = omap_device_build(name, id - 1, oh, pdata,
+	od = omap_device_build(name, i, oh, pdata,
 				sizeof(*pdata),	omap_gpio_latency,
 				ARRAY_SIZE(omap_gpio_latency),
 				false);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 637db76..9c3e865 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -33,108 +33,6 @@
 
 #define OMAP_GPIO_WAKE_SET_CLR_ALL	0xffffffff
 #define	MPUIO_GPIO_IRQENA_MASK	0xffff
-/*
- * OMAP1510 GPIO registers
- */
-#define OMAP1510_GPIO_DATA_INPUT	0x00
-#define OMAP1510_GPIO_DATA_OUTPUT	0x04
-#define OMAP1510_GPIO_DIR_CONTROL	0x08
-#define OMAP1510_GPIO_INT_CONTROL	0x0c
-#define OMAP1510_GPIO_INT_MASK		0x10
-#define OMAP1510_GPIO_INT_STATUS	0x14
-#define OMAP1510_GPIO_PIN_CONTROL	0x18
-
-#define OMAP1510_IH_GPIO_BASE		64
-
-/*
- * OMAP1610 specific GPIO registers
- */
-#define OMAP1610_GPIO_REVISION		0x0000
-#define OMAP1610_GPIO_SYSCONFIG		0x0010
-#define OMAP1610_GPIO_SYSSTATUS		0x0014
-#define OMAP1610_GPIO_IRQSTATUS1	0x0018
-#define OMAP1610_GPIO_IRQENABLE1	0x001c
-#define OMAP1610_GPIO_WAKEUPENABLE	0x0028
-#define OMAP1610_GPIO_DATAIN		0x002c
-#define OMAP1610_GPIO_DATAOUT		0x0030
-#define OMAP1610_GPIO_DIRECTION		0x0034
-#define OMAP1610_GPIO_EDGE_CTRL1	0x0038
-#define OMAP1610_GPIO_EDGE_CTRL2	0x003c
-#define OMAP1610_GPIO_CLEAR_IRQENABLE1	0x009c
-#define OMAP1610_GPIO_CLEAR_WAKEUPENA	0x00a8
-#define OMAP1610_GPIO_CLEAR_DATAOUT	0x00b0
-#define OMAP1610_GPIO_SET_IRQENABLE1	0x00dc
-#define OMAP1610_GPIO_SET_WAKEUPENA	0x00e8
-#define OMAP1610_GPIO_SET_DATAOUT	0x00f0
-
-/*
- * OMAP7XX specific GPIO registers
- */
-#define OMAP7XX_GPIO_DATA_INPUT		0x00
-#define OMAP7XX_GPIO_DATA_OUTPUT	0x04
-#define OMAP7XX_GPIO_DIR_CONTROL	0x08
-#define OMAP7XX_GPIO_INT_CONTROL	0x0c
-#define OMAP7XX_GPIO_INT_MASK		0x10
-#define OMAP7XX_GPIO_INT_STATUS		0x14
-
-/*
- * omap2+ specific GPIO registers
- */
-#define OMAP24XX_GPIO_REVISION		0x0000
-#define OMAP24XX_GPIO_IRQSTATUS1	0x0018
-#define OMAP24XX_GPIO_IRQSTATUS2	0x0028
-#define OMAP24XX_GPIO_IRQENABLE2	0x002c
-#define OMAP24XX_GPIO_IRQENABLE1	0x001c
-#define OMAP24XX_GPIO_WAKE_EN		0x0020
-#define OMAP24XX_GPIO_CTRL		0x0030
-#define OMAP24XX_GPIO_OE		0x0034
-#define OMAP24XX_GPIO_DATAIN		0x0038
-#define OMAP24XX_GPIO_DATAOUT		0x003c
-#define OMAP24XX_GPIO_LEVELDETECT0	0x0040
-#define OMAP24XX_GPIO_LEVELDETECT1	0x0044
-#define OMAP24XX_GPIO_RISINGDETECT	0x0048
-#define OMAP24XX_GPIO_FALLINGDETECT	0x004c
-#define OMAP24XX_GPIO_DEBOUNCE_EN	0x0050
-#define OMAP24XX_GPIO_DEBOUNCE_VAL	0x0054
-#define OMAP24XX_GPIO_CLEARIRQENABLE1	0x0060
-#define OMAP24XX_GPIO_SETIRQENABLE1	0x0064
-#define OMAP24XX_GPIO_CLEARWKUENA	0x0080
-#define OMAP24XX_GPIO_SETWKUENA		0x0084
-#define OMAP24XX_GPIO_CLEARDATAOUT	0x0090
-#define OMAP24XX_GPIO_SETDATAOUT	0x0094
-
-#define OMAP4_GPIO_REVISION		0x0000
-#define OMAP4_GPIO_EOI			0x0020
-#define OMAP4_GPIO_IRQSTATUSRAW0	0x0024
-#define OMAP4_GPIO_IRQSTATUSRAW1	0x0028
-#define OMAP4_GPIO_IRQSTATUS0		0x002c
-#define OMAP4_GPIO_IRQSTATUS1		0x0030
-#define OMAP4_GPIO_IRQSTATUSSET0	0x0034
-#define OMAP4_GPIO_IRQSTATUSSET1	0x0038
-#define OMAP4_GPIO_IRQSTATUSCLR0	0x003c
-#define OMAP4_GPIO_IRQSTATUSCLR1	0x0040
-#define OMAP4_GPIO_IRQWAKEN0		0x0044
-#define OMAP4_GPIO_IRQWAKEN1		0x0048
-#define OMAP4_GPIO_IRQENABLE1		0x011c
-#define OMAP4_GPIO_WAKE_EN		0x0120
-#define OMAP4_GPIO_IRQSTATUS2		0x0128
-#define OMAP4_GPIO_IRQENABLE2		0x012c
-#define OMAP4_GPIO_CTRL			0x0130
-#define OMAP4_GPIO_OE			0x0134
-#define OMAP4_GPIO_DATAIN		0x0138
-#define OMAP4_GPIO_DATAOUT		0x013c
-#define OMAP4_GPIO_LEVELDETECT0		0x0140
-#define OMAP4_GPIO_LEVELDETECT1		0x0144
-#define OMAP4_GPIO_RISINGDETECT		0x0148
-#define OMAP4_GPIO_FALLINGDETECT	0x014c
-#define OMAP4_GPIO_DEBOUNCENABLE	0x0150
-#define OMAP4_GPIO_DEBOUNCINGTIME	0x0154
-#define OMAP4_GPIO_CLEARIRQENABLE1	0x0160
-#define OMAP4_GPIO_SETIRQENABLE1	0x0164
-#define OMAP4_GPIO_CLEARWKUENA		0x0180
-#define OMAP4_GPIO_SETWKUENA		0x0184
-#define OMAP4_GPIO_CLEARDATAOUT		0x0190
-#define OMAP4_GPIO_SETDATAOUT		0x0194
 
 static LIST_HEAD(omap_gpio_list);
 
@@ -1048,68 +946,6 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
  */
 static struct lock_class_key gpio_lock_class;
 
-/* TODO: Cleanup cpu_is_* checks */
-static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
-{
-	if (cpu_class_is_omap2()) {
-		if (cpu_is_omap44xx()) {
-			__raw_writel(0xffffffff, bank->base +
-					OMAP4_GPIO_IRQSTATUSCLR0);
-			__raw_writel(0x00000000, bank->base +
-					 OMAP4_GPIO_DEBOUNCENABLE);
-			/* Initialize interface clk ungated, module enabled */
-			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
-		} else if (cpu_is_omap34xx()) {
-			__raw_writel(0x00000000, bank->base +
-					OMAP24XX_GPIO_IRQENABLE1);
-			__raw_writel(0xffffffff, bank->base +
-					OMAP24XX_GPIO_IRQSTATUS1);
-			__raw_writel(0x00000000, bank->base +
-					OMAP24XX_GPIO_DEBOUNCE_EN);
-
-			/* Initialize interface clk ungated, module enabled */
-			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
-		} else if (cpu_is_omap24xx()) {
-			static const u32 non_wakeup_gpios[] = {
-				0xe203ffc0, 0x08700040
-			};
-			if (id < ARRAY_SIZE(non_wakeup_gpios))
-				bank->non_wakeup_gpios = non_wakeup_gpios[id];
-		}
-	} else if (cpu_class_is_omap1()) {
-		if (bank->method == METHOD_MPUIO)
-			__raw_writew(0xffff, bank->base +
-				OMAP_MPUIO_GPIO_MASKIT / bank->stride);
-		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
-			__raw_writew(0xffff, bank->base
-						+ OMAP1510_GPIO_INT_MASK);
-			__raw_writew(0x0000, bank->base
-						+ OMAP1510_GPIO_INT_STATUS);
-		}
-		if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
-			__raw_writew(0x0000, bank->base
-						+ OMAP1610_GPIO_IRQENABLE1);
-			__raw_writew(0xffff, bank->base
-						+ OMAP1610_GPIO_IRQSTATUS1);
-			__raw_writew(0x0014, bank->base
-						+ OMAP1610_GPIO_SYSCONFIG);
-
-			/*
-			 * Enable system clock for GPIO module.
-			 * The CAM_CLK_CTRL *is* really the right place.
-			 */
-			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
-						ULPD_CAM_CLK_CTRL);
-		}
-		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
-			__raw_writel(0xffffffff, bank->base
-						+ OMAP7XX_GPIO_INT_MASK);
-			__raw_writel(0x00000000, bank->base
-						+ OMAP7XX_GPIO_INT_STATUS);
-		}
-	}
-}
-
 static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 {
 	int j;
@@ -1197,6 +1033,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank->suspend_resume_support = pdata->suspend_resume_support;
+	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
 	bank_width = pdata->bank_width;
 
 	if (pdata->suspend_resume_support) {
@@ -1235,7 +1072,12 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	pm_runtime_enable(bank->dev);
 	pm_runtime_get_sync(bank->dev);
 
-	omap_gpio_mod_init(bank, pdev->id);
+	if (bank->method == METHOD_MPUIO)
+		__raw_writew(0xffff, bank->base +
+			OMAP_MPUIO_GPIO_MASKIT / bank->stride);
+	else
+		pdata->gpio_fn->gpio_init(bank->base, bank->id);
+
 	omap_gpio_chip_init(bank);
 
 	list_add_tail(&bank->node, &omap_gpio_list);
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 5a0d946..87fee8d 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -124,6 +124,7 @@ struct omap_gpio_func {
 			void __iomem *base);
 	void (*gpio_save_ctx)(void __iomem *base, u32 id);
 	void (*gpio_restore_ctx)(void __iomem *base, u32 id);
+	void (*gpio_init)(void __iomem *base, u32 id);
 };
 
 struct omap_gpio_platform_data {
@@ -134,6 +135,7 @@ struct omap_gpio_platform_data {
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
 	bool suspend_resume_support; /* True for OMAP16XX, OMAP2PLUS */
+	u32 non_wakeup_gpios;
 };
 
 extern void omap2_gpio_prepare_for_idle(int off_mode);
-- 
1.7.1

