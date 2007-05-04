From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 1/2] ARM: OMAP: add 24xx GPIO debounce support
Date: Fri, 04 May 2007 14:40:29 -0700
Message-ID: <20070504214039.205092845@mvista.com>
References: <20070504214028.649198901@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=gpio-debounce.patch
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

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/plat-omap/gpio.c        |   39 +++++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/gpio.h |    5 +++++
 2 files changed, 44 insertions(+)

Index: dev/arch/arm/plat-omap/gpio.c
===================================================================
--- dev.orig/arch/arm/plat-omap/gpio.c
+++ dev/arch/arm/plat-omap/gpio.c
@@ -111,6 +111,8 @@
 #define OMAP24XX_GPIO_LEVELDETECT1	0x0044
 #define OMAP24XX_GPIO_RISINGDETECT	0x0048
 #define OMAP24XX_GPIO_FALLINGDETECT	0x004c
+#define OMAP24XX_GPIO_DEBOUNCE_EN	0x0050
+#define OMAP24XX_GPIO_DEBOUNCE_VAL	0x0054
 #define OMAP24XX_GPIO_CLEARIRQENABLE1	0x0060
 #define OMAP24XX_GPIO_SETIRQENABLE1	0x0064
 #define OMAP24XX_GPIO_CLEARWKUENA	0x0080
@@ -484,6 +486,43 @@ static inline void set_24xx_gpio_trigger
 	/* FIXME: Possibly do 'set_irq_handler(j, handle_level_irq)' if only level
 	 * triggering requested. */
 }
+
+void
+omap_set_gpio_debounce(int gpio, int enable)
+{
+	struct gpio_bank *bank;
+	void __iomem *reg;
+	u32 val, l = 1 << get_gpio_index(gpio);
+
+	bank = get_gpio_bank(gpio);
+	reg = bank->base;
+
+	reg += OMAP24XX_GPIO_DEBOUNCE_EN;
+	val = __raw_readl(reg);
+
+	if (enable)
+		val |= l;
+	else
+		val &= ~l;
+
+	__raw_writel(val, reg);
+}
+EXPORT_SYMBOL(omap_set_gpio_debounce);
+
+void
+omap_set_gpio_debounce_time(int gpio, int enc_time)
+{
+	struct gpio_bank *bank;
+	void __iomem *reg;
+
+	bank = get_gpio_bank(gpio);
+	reg = bank->base;
+
+	enc_time &= 0xff;
+	reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
+	__raw_writel(enc_time, reg);
+}
+EXPORT_SYMBOL(omap_set_gpio_debounce_time);
 #endif
 
 static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
Index: dev/include/asm-arm/arch-omap/gpio.h
===================================================================
--- dev.orig/include/asm-arm/arch-omap/gpio.h
+++ dev/include/asm-arm/arch-omap/gpio.h
@@ -78,6 +78,11 @@ extern int omap_get_gpio_datain(int gpio
 extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
 
+#ifdef CONFIG_ARCH_OMAP24XX
+extern void omap_set_gpio_debounce(int gpio, int enable);
+extern void omap_set_gpio_debounce_time(int gpio, int enable);
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 /* wrappers for "new style" GPIO calls. the old OMAP-specfic ones should

--
