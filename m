From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/7] gpio: fix GPIO clock code for 3430
Date: Thu, 27 Sep 2007 00:11:26 -0600
Message-ID: <20070927061257.207258559@pwsan.com>
References: <20070927061119.551228401@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=fix_gpio_for_3430_clock.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Fix GPIO code to use the correct clock names for OMAP3430.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/plat-omap/gpio.c        |   40 +++++++++++++++++++++++++++++++++++----
 include/asm-arm/arch-omap/gpio.h |    2 +
 2 files changed, 38 insertions(+), 4 deletions(-)

Index: linux-omap/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/gpio.c	2007-09-19 13:07:55.000000000 -0600
+++ linux-omap/arch/arm/plat-omap/gpio.c	2007-09-19 13:08:57.000000000 -0600
@@ -1277,21 +1277,30 @@
 /*---------------------------------------------------------------------*/
 
 static int initialized;
+#if !defined(CONFIG_ARCH_OMAP34XX)
 static struct clk * gpio_ick;
 static struct clk * gpio_fck;
+#endif
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2430)
 static struct clk * gpio5_ick;
 static struct clk * gpio5_fck;
 #endif
 
+#if defined(CONFIG_ARCH_OMAP3)
+static struct clk *gpio_fclks[OMAP34XX_NR_GPIOS];
+static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
+#endif
+
 static int __init _omap_gpio_init(void)
 {
 	int i;
 	struct gpio_bank *bank;
+	char clk_name[11];
 
 	initialized = 1;
 
+#if defined(CONFIG_ARCH_OMAP1)
 	if (cpu_is_omap15xx()) {
 		gpio_ick = clk_get(NULL, "arm_gpio_ck");
 		if (IS_ERR(gpio_ick))
@@ -1299,6 +1308,8 @@
 		else
 			clk_enable(gpio_ick);
 	}
+#endif
+#if defined(CONFIG_ARCH_OMAP2)
 	if (cpu_class_is_omap2()) {
 		gpio_ick = clk_get(NULL, "gpios_ick");
 		if (IS_ERR(gpio_ick))
@@ -1314,8 +1325,8 @@
 		/*
 		 * On 2430 & 3430 GPIO 5 uses CORE L4 ICLK
 		 */
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
-		if (cpu_is_omap2430() || cpu_is_omap3430()) {
+#if defined(CONFIG_ARCH_OMAP2430)
+		if (cpu_is_omap2430()) {
 			gpio5_ick = clk_get(NULL, "gpio5_ick");
 			if (IS_ERR(gpio5_ick))
 				printk("Could not get gpio5_ick\n");
@@ -1329,6 +1340,27 @@
 		}
 #endif
 	}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP3)
+	if (cpu_is_omap34xx()) {
+		for (i = 0; i < OMAP34XX_NR_GPIOS; i++) {
+			sprintf(clk_name, "gpio%d_ick", i + 1);
+			gpio_iclks[i] = clk_get(NULL, clk_name);
+			if (IS_ERR(gpio_iclks[i]))
+				printk(KERN_ERR "Could not get %s\n", clk_name);
+			else
+				clk_enable(gpio_iclks[i]);
+			sprintf(clk_name, "gpio%d_fck", i + 1);
+			gpio_fclks[i] = clk_get(NULL, clk_name);
+			if (IS_ERR(gpio_fclks[i]))
+				printk(KERN_ERR "Could not get %s\n", clk_name);
+			else
+				clk_enable(gpio_fclks[i]);
+		}
+	}
+#endif
+
 
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap15xx()) {
@@ -1380,7 +1412,7 @@
 	if (cpu_is_omap34xx()) {
 		int rev;
 
-		gpio_bank_count = 6;
+		gpio_bank_count = OMAP34XX_NR_GPIOS;
 		gpio_bank = gpio_bank_34xx;
 		rev = omap_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
 		printk(KERN_INFO "OMAP34xx GPIO hardware version %d.%d\n",
Index: linux-omap/include/asm-arm/arch-omap/gpio.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/gpio.h	2007-09-19 13:07:02.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/gpio.h	2007-09-19 13:07:57.000000000 -0600
@@ -62,6 +62,8 @@
 #define OMAP_MPUIO_LATCH		0x34
 #endif
 
+#define OMAP34XX_NR_GPIOS		6
+
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
 

-- 
