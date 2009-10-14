From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 02/17] OMAP7XX: GPIO: Remove duplicate omap850 code
Date: Wed, 14 Oct 2009 20:50:20 +0100
Message-ID: <3d374d00910141250ib308dcbw9c3e89fba22b575a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch is part of a series which unifies all duplicated code between
omap730 and omap850. All cpu checks are converted to cpu_is_omap7xx() and
CONFIG_ARCH_OMAP850 is added to all CONFIG_ARCH_OMAP730 checks.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/plat-omap/gpio.c |  133 +++++----------------------------------------
 1 files changed, 14 insertions(+), 119 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 71ebd7f..665ca05 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -83,22 +83,6 @@
 #define OMAP730_GPIO_INT_MASK		0x10
 #define OMAP730_GPIO_INT_STATUS		0x14

-/*
- * OMAP850 specific GPIO registers
- */
-#define OMAP850_GPIO1_BASE		OMAP1_IO_ADDRESS(0xfffbc000)
-#define OMAP850_GPIO2_BASE		OMAP1_IO_ADDRESS(0xfffbc800)
-#define OMAP850_GPIO3_BASE		OMAP1_IO_ADDRESS(0xfffbd000)
-#define OMAP850_GPIO4_BASE		OMAP1_IO_ADDRESS(0xfffbd800)
-#define OMAP850_GPIO5_BASE		OMAP1_IO_ADDRESS(0xfffbe000)
-#define OMAP850_GPIO6_BASE		OMAP1_IO_ADDRESS(0xfffbe800)
-#define OMAP850_GPIO_DATA_INPUT		0x00
-#define OMAP850_GPIO_DATA_OUTPUT	0x04
-#define OMAP850_GPIO_DIR_CONTROL	0x08
-#define OMAP850_GPIO_INT_CONTROL	0x0c
-#define OMAP850_GPIO_INT_MASK		0x10
-#define OMAP850_GPIO_INT_STATUS		0x14
-
 #define OMAP1_MPUIO_VBASE		OMAP1_IO_ADDRESS(OMAP1_MPUIO_BASE)

 /*
@@ -216,7 +200,6 @@ struct gpio_bank {
 #define METHOD_GPIO_1510	1
 #define METHOD_GPIO_1610	2
 #define METHOD_GPIO_730		3
-#define METHOD_GPIO_850		4
 #define METHOD_GPIO_24XX	5

 #ifdef CONFIG_ARCH_OMAP16XX
@@ -236,7 +219,7 @@ static struct gpio_bank gpio_bank_1510[2] = {
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 static struct gpio_bank gpio_bank_730[7] = {
 	{ OMAP1_MPUIO_VBASE,    INT_730_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
 	{ OMAP730_GPIO1_BASE,  INT_730_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_730 },
@@ -248,19 +231,6 @@ static struct gpio_bank gpio_bank_730[7] = {
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP850
-static struct gpio_bank gpio_bank_850[7] = {
-	{ OMAP1_MPUIO_VBASE,     INT_850_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
-	{ OMAP850_GPIO1_BASE,  INT_850_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_850 },
-	{ OMAP850_GPIO2_BASE,  INT_850_GPIO_BANK2,  IH_GPIO_BASE +
32,	METHOD_GPIO_850 },
-	{ OMAP850_GPIO3_BASE,  INT_850_GPIO_BANK3,  IH_GPIO_BASE +
64,	METHOD_GPIO_850 },
-	{ OMAP850_GPIO4_BASE,  INT_850_GPIO_BANK4,  IH_GPIO_BASE +
96,	METHOD_GPIO_850 },
-	{ OMAP850_GPIO5_BASE,  INT_850_GPIO_BANK5,  IH_GPIO_BASE + 128,
METHOD_GPIO_850 },
-	{ OMAP850_GPIO6_BASE,  INT_850_GPIO_BANK6,  IH_GPIO_BASE + 160,
METHOD_GPIO_850 },
-};
-#endif
-
-
 #ifdef CONFIG_ARCH_OMAP24XX

 static struct gpio_bank gpio_bank_242x[4] = {
@@ -402,16 +372,11 @@ static void _set_gpio_direction(struct gpio_bank
*bank, int gpio, int is_input)
 		reg += OMAP1610_GPIO_DIRECTION;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_DIR_CONTROL;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	case METHOD_GPIO_850:
-		reg += OMAP850_GPIO_DIR_CONTROL;
-		break;
-#endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_OE;
@@ -469,7 +434,7 @@ static void _set_gpio_dataout(struct gpio_bank
*bank, int gpio, int enable)
 		l = 1 << gpio;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_DATA_OUTPUT;
 		l = __raw_readl(reg);
@@ -479,16 +444,6 @@ static void _set_gpio_dataout(struct gpio_bank
*bank, int gpio, int enable)
 			l &= ~(1 << gpio);
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	case METHOD_GPIO_850:
-		reg += OMAP850_GPIO_DATA_OUTPUT;
-		l = __raw_readl(reg);
-		if (enable)
-			l |= 1 << gpio;
-		else
-			l &= ~(1 << gpio);
-		break;
-#endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		if (enable)
@@ -537,16 +492,11 @@ static int _get_gpio_datain(struct gpio_bank
*bank, int gpio)
 		reg += OMAP1610_GPIO_DATAIN;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_DATA_INPUT;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	case METHOD_GPIO_850:
-		reg += OMAP850_GPIO_DATA_INPUT;
-		break;
-#endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_DATAIN;
@@ -588,16 +538,11 @@ static int _get_gpio_dataout(struct gpio_bank
*bank, int gpio)
 		reg += OMAP1610_GPIO_DATAOUT;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_DATA_OUTPUT;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	case METHOD_GPIO_850:
-		reg += OMAP850_GPIO_DATA_OUTPUT;
-		break;
-#endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
 		defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
@@ -797,7 +742,7 @@ static int _set_gpio_triggering(struct gpio_bank
*bank, int gpio, int trigger)
 			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA);
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_CONTROL;
 		l = __raw_readl(reg);
@@ -809,18 +754,6 @@ static int _set_gpio_triggering(struct gpio_bank
*bank, int gpio, int trigger)
 			goto bad;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	case METHOD_GPIO_850:
-		reg += OMAP850_GPIO_INT_CONTROL;
-		l = __raw_readl(reg);
-		if (trigger & IRQ_TYPE_EDGE_RISING)
-			l |= 1 << gpio;
-		else if (trigger & IRQ_TYPE_EDGE_FALLING)
-			l &= ~(1 << gpio);
-		else
-			goto bad;
-		break;
-#endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
 				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
@@ -897,16 +830,11 @@ static void _clear_gpio_irqbank(struct gpio_bank
*bank, int gpio_mask)
 		reg += OMAP1610_GPIO_IRQSTATUS1;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_STATUS;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	case METHOD_GPIO_850:
-		reg += OMAP850_GPIO_INT_STATUS;
-		break;
-#endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQSTATUS1;
@@ -971,20 +899,13 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 		mask = 0xffff;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_MASK;
 		mask = 0xffffffff;
 		inv = 1;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	case METHOD_GPIO_850:
-		reg += OMAP850_GPIO_INT_MASK;
-		mask = 0xffffffff;
-		inv = 1;
-		break;
-#endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
@@ -1044,7 +965,7 @@ static void _enable_gpio_irqbank(struct gpio_bank
*bank, int gpio_mask, int enab
 		l = gpio_mask;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_MASK;
 		l = __raw_readl(reg);
@@ -1054,16 +975,6 @@ static void _enable_gpio_irqbank(struct
gpio_bank *bank, int gpio_mask, int enab
 			l |= gpio_mask;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	case METHOD_GPIO_850:
-		reg += OMAP850_GPIO_INT_MASK;
-		l = __raw_readl(reg);
-		if (enable)
-			l &= ~(gpio_mask);
-		else
-			l |= gpio_mask;
-		break;
-#endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		if (enable)
@@ -1249,14 +1160,10 @@ static void gpio_irq_handler(unsigned int irq,
struct irq_desc *desc)
 	if (bank->method == METHOD_GPIO_1610)
 		isr_reg = bank->base + OMAP1610_GPIO_IRQSTATUS1;
 #endif
-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	if (bank->method == METHOD_GPIO_730)
 		isr_reg = bank->base + OMAP730_GPIO_INT_STATUS;
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	if (bank->method == METHOD_GPIO_850)
-		isr_reg = bank->base + OMAP850_GPIO_INT_STATUS;
-#endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	if (bank->method == METHOD_GPIO_24XX)
 		isr_reg = bank->base + OMAP24XX_GPIO_IRQSTATUS1;
@@ -1527,9 +1434,6 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_DIR_CONTROL;
 		break;
-	case METHOD_GPIO_850:
-		reg += OMAP850_GPIO_DIR_CONTROL;
-		break;
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_OE;
 		break;
@@ -1695,21 +1599,13 @@ static int __init _omap_gpio_init(void)
 		       (rev >> 4) & 0x0f, rev & 0x0f);
 	}
 #endif
-#ifdef CONFIG_ARCH_OMAP730
-	if (cpu_is_omap730()) {
-		printk(KERN_INFO "OMAP730 GPIO hardware\n");
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+	if (cpu_is_omap7xx()) {
+		printk(KERN_INFO "OMAP7XX GPIO hardware\n");
 		gpio_bank_count = 7;
 		gpio_bank = gpio_bank_730;
 	}
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	if (cpu_is_omap850()) {
-		printk(KERN_INFO "OMAP850 GPIO hardware\n");
-		gpio_bank_count = 7;
-		gpio_bank = gpio_bank_850;
-	}
-#endif
-
 #ifdef CONFIG_ARCH_OMAP24XX
 	if (cpu_is_omap242x()) {
 		int rev;
@@ -2160,8 +2056,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)

 		if (bank_is_mpuio(bank))
 			gpio = OMAP_MPUIO(0);
-		else if (cpu_class_is_omap2() || cpu_is_omap730() ||
-				cpu_is_omap850())
+		else if (cpu_class_is_omap2() || cpu_is_omap7xx())
 			bankwidth = 32;

 		for (j = 0; j < bankwidth; j++, gpio++, mask <<= 1) {
-- 
1.6.5
