From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/7][RFC] OMAP4: Update common omap platform common sources.
Date: Tue, 21 Apr 2009 18:38:10 +0530
Message-ID: <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38829 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538AbZDUNIW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Apr 2009 09:08:22 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3LD8FZR020177
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 08:08:21 -0500
In-Reply-To: <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch updates the common platform source  files for OMAP4430.
Few OMAP4 peripherals are common with OMAP3 architecture.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/common.c  |   29 +++++++++++-
 arch/arm/plat-omap/devices.c |    2 +
 arch/arm/plat-omap/dma.c     |   10 +++-
 arch/arm/plat-omap/dmtimer.c |   42 +++++++++++++++--
 arch/arm/plat-omap/gpio.c    |  109 ++++++++++++++++++++++++++++-------------
 arch/arm/plat-omap/io.c      |   18 +++++++-
 arch/arm/plat-omap/mux.c     |    3 +
 arch/arm/plat-omap/sram.c    |   20 ++++++++
 8 files changed, 189 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index d179714..ca2c382 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -177,7 +177,8 @@ console_initcall(omap_add_serial_console);
 
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
-#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+		defined(CONFIG_ARCH_OMAP44XX)
 #define TIMER_32K_SYNCHRONIZED		(OMAP2_32KSYNCT_BASE + 0x10)
 #endif
 
@@ -252,6 +253,16 @@ static void __init __omap2_set_globals(void)
 
 #endif
 
+#if defined(CONFIG_ARCH_OMAP4) /* sdrc and sms are not needed on omap4*/
+static struct omap_globals *omap2_globals;
+
+static void __init __omap2_set_globals(void)
+{
+	omap2_set_globals_tap(omap2_globals);
+	omap2_set_globals_control(omap2_globals);
+}
+#endif
+
 #if defined(CONFIG_ARCH_OMAP2420)
 
 static struct omap_globals omap242x_globals = {
@@ -309,3 +320,19 @@ void __init omap2_set_globals_343x(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_OMAP4430)
+static struct omap_globals omap443x_globals = {
+	.class	= OMAP443X_CLASS,
+	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
+	.ctrl	= OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
+	.prm	= OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
+	.cm	= OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
+};
+
+void __init omap2_set_globals_443x(void)
+{
+	omap2_globals = &omap443x_globals;
+	__omap2_set_globals();
+}
+#endif
+
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 87fb7ff..a016c6c 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -311,6 +311,8 @@ static void omap_init_wdt(void)
 		wdt_resources[0].start = 0x49016000; /* WDT2 */
 	else if (cpu_is_omap343x())
 		wdt_resources[0].start = 0x48314000; /* WDT2 */
+	else if (cpu_is_omap44xx())
+		wdt_resources[0].start = 0x4A314000;
 	else
 		return;
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 21cc014..36d066d 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -852,7 +852,7 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 	}
 	l = dma_read(CCR(lch));
 	l &= ~((1 << 6) | (1 << 26));
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
+	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
 		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
 	else
 		l |= ((read_prio & 0x1) << 6);
@@ -1824,7 +1824,8 @@ static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
 #define omap1_dma_irq_handler	NULL
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+			defined(CONFIG_ARCH_OMAP4)
 
 static int omap2_dma_handle_ch(int ch)
 {
@@ -2319,6 +2320,9 @@ static int __init omap_init_dma(void)
 	} else if (cpu_is_omap34xx()) {
 		omap_dma_base = IO_ADDRESS(OMAP34XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
+	} else if (cpu_is_omap44xx()) {
+		omap_dma_base = IO_ADDRESS(OMAP44XX_DMA4_BASE);
+		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else {
 		pr_err("DMA init failed for unsupported omap\n");
 		return -ENODEV;
@@ -2417,7 +2421,7 @@ static int __init omap_init_dma(void)
 		}
 	}
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx())
 		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
 				DMA_DEFAULT_FIFO_DEPTH, 0);
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index bfd4757..d0e2119 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -150,7 +150,8 @@
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int irq;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+			defined(CONFIG_ARCH_OMAP4)
 	struct clk *iclk, *fclk;
 #endif
 	void __iomem *io_base;
@@ -250,6 +251,37 @@ static const char *omap3_dm_source_names[] __initdata = {
 static struct clk **omap3_dm_source_clocks[2];
 static const int dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
 
+#elif defined(CONFIG_ARCH_OMAP4)
+
+#define omap_dm_clk_enable(x)		clk_enable(x)
+#define omap_dm_clk_disable(x)		clk_disable(x)
+#define omap1_dm_timers			NULL
+#define omap2_dm_timers			NULL
+#define omap2_dm_source_names		NULL
+#define omap2_dm_source_clocks		NULL
+
+static struct omap_dm_timer omap3_dm_timers[] = {
+	{ .phys_base = 0x4A318000, .irq = INT_24XX_GPTIMER1 },
+	{ .phys_base = 0x48032000, .irq = INT_24XX_GPTIMER2 },
+	{ .phys_base = 0x48034000, .irq = INT_24XX_GPTIMER3 },
+	{ .phys_base = 0x48036000, .irq = INT_24XX_GPTIMER4 },
+	{ .phys_base = 0x40138000, .irq = INT_24XX_GPTIMER5 },
+	{ .phys_base = 0x4013A000, .irq = INT_24XX_GPTIMER6 },
+	{ .phys_base = 0x4013C000, .irq = INT_24XX_GPTIMER7 },
+	{ .phys_base = 0x4013E000, .irq = INT_24XX_GPTIMER8 },
+	{ .phys_base = 0x4803E000, .irq = INT_24XX_GPTIMER9 },
+	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
+	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
+	{ .phys_base = 0x4A320000, .irq = INT_24XX_GPTIMER12 },
+};
+static const char *omap3_dm_source_names[] __initdata = {
+	"sys_ck",
+	"omap_32k_fck",
+	NULL
+};
+static struct clk **omap3_dm_source_clocks[2];
+static const int dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
+
 #else
 
 #error OMAP architecture not supported!
@@ -461,7 +493,8 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
-#elif defined(CONFIG_ARCH_OMAP2) || defined (CONFIG_ARCH_OMAP3)
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+				defined(CONFIG_ARCH_OMAP4)
 
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
@@ -701,7 +734,7 @@ int __init omap_dm_timer_init(void)
 		dm_timers = omap2_dm_timers;
 		dm_source_names = (char **)omap2_dm_source_names;
 		dm_source_clocks = (struct clk **)omap2_dm_source_clocks;
-	} else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		dm_timers = omap3_dm_timers;
 		dm_source_names = (char **)omap3_dm_source_names;
 		dm_source_clocks = (struct clk **)omap3_dm_source_clocks;
@@ -717,7 +750,8 @@ int __init omap_dm_timer_init(void)
 	for (i = 0; i < dm_timer_count; i++) {
 		timer = &dm_timers[i];
 		timer->io_base = IO_ADDRESS(timer->phys_base);
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+					defined(CONFIG_ARCH_OMAP4)
 		if (cpu_class_is_omap2()) {
 			char clk_name[16];
 			sprintf(clk_name, "gpt%d_ick", i + 1);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d3fa41e..8bfc819 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -136,15 +136,24 @@
 #define OMAP24XX_GPIO_SETDATAOUT	0x0094
 
 /*
- * omap34xx specific GPIO registers
+ * omap34xx, omap44xx  specific GPIO registers
  */
 
+#ifdef CONFIG_ARCH_OMAP4430
+#define OMAP34XX_GPIO1_BASE             IO_ADDRESS(0x4A310000)
+#define OMAP34XX_GPIO2_BASE             IO_ADDRESS(0x48055000)
+#define OMAP34XX_GPIO3_BASE             IO_ADDRESS(0x48057000)
+#define OMAP34XX_GPIO4_BASE             IO_ADDRESS(0x48059000)
+#define OMAP34XX_GPIO5_BASE             IO_ADDRESS(0x4805B000)
+#define OMAP34XX_GPIO6_BASE             IO_ADDRESS(0x4805D000)
+#else
 #define OMAP34XX_GPIO1_BASE		IO_ADDRESS(0x48310000)
 #define OMAP34XX_GPIO2_BASE		IO_ADDRESS(0x49050000)
 #define OMAP34XX_GPIO3_BASE		IO_ADDRESS(0x49052000)
 #define OMAP34XX_GPIO4_BASE		IO_ADDRESS(0x49054000)
 #define OMAP34XX_GPIO5_BASE		IO_ADDRESS(0x49056000)
 #define OMAP34XX_GPIO6_BASE		IO_ADDRESS(0x49058000)
+#endif
 
 #define OMAP_MPUIO_VBASE		IO_ADDRESS(OMAP_MPUIO_BASE)
 
@@ -153,11 +162,13 @@ struct gpio_bank {
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) ||  \
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP44XX)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP44XX)
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 
@@ -239,7 +250,7 @@ static struct gpio_bank gpio_bank_243x[5] = {
 
 #endif
 
-#ifdef CONFIG_ARCH_OMAP34XX
+#if defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP44XX)
 static struct gpio_bank gpio_bank_34xx[6] = {
 	{ OMAP34XX_GPIO1_BASE, INT_34XX_GPIO_BANK1, IH_GPIO_BASE,	METHOD_GPIO_24XX },
 	{ OMAP34XX_GPIO2_BASE, INT_34XX_GPIO_BANK2, IH_GPIO_BASE + 32,	METHOD_GPIO_24XX },
@@ -275,6 +286,8 @@ static inline struct gpio_bank *get_gpio_bank(int gpio)
 		return &gpio_bank[gpio >> 5];
 	if (cpu_is_omap34xx())
 		return &gpio_bank[gpio >> 5];
+	if (cpu_is_omap44xx())
+		return &gpio_bank[gpio >> 5];
 	BUG();
 	return NULL;
 }
@@ -287,6 +300,8 @@ static inline int get_gpio_index(int gpio)
 		return gpio & 0x1f;
 	if (cpu_is_omap34xx())
 		return gpio & 0x1f;
+	if (cpu_is_omap44xx())
+		return gpio & 0x1f;
 	return gpio & 0x0f;
 }
 
@@ -309,6 +324,8 @@ static inline int gpio_valid(int gpio)
 		return 0;
 	if (cpu_is_omap34xx() && gpio < 160)
 		return 0;
+	if (cpu_is_omap44xx() && gpio < 160)
+		return 0;
 	return -1;
 }
 
@@ -353,7 +370,8 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 		reg += OMAP850_GPIO_DIR_CONTROL;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP44XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_OE;
 		break;
@@ -425,7 +443,8 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 			l &= ~(1 << gpio);
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP44XX)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETDATAOUT;
@@ -476,7 +495,8 @@ static int __omap_get_gpio_datain(int gpio)
 		reg += OMAP850_GPIO_DATA_INPUT;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP44XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_DATAIN;
 		break;
@@ -520,7 +540,7 @@ void omap_set_gpio_debounce(int gpio, int enable)
 	else
 		goto done;
 
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		if (enable)
 			clk_enable(bank->dbck);
 		else
@@ -550,7 +570,8 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce_time);
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 						int trigger)
 {
@@ -660,7 +681,8 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 			goto bad;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 	case METHOD_GPIO_24XX:
 		set_24xx_gpio_triggering(bank, gpio, trigger);
 		break;
@@ -745,7 +767,8 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 		reg += OMAP850_GPIO_INT_STATUS;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQSTATUS1;
 		break;
@@ -810,7 +833,8 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 		inv = 1;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
 		mask = 0xffffffff;
@@ -883,7 +907,8 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 			l |= gpio_mask;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+		defined(CONFIG_ARCH_OMAP44XX)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETIRQENABLE1;
@@ -931,7 +956,8 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 	case METHOD_GPIO_24XX:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			printk(KERN_ERR "Unable to modify wakeup on "
@@ -1019,7 +1045,8 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 	if (bank->method == METHOD_GPIO_24XX) {
 		/* Disable wake-up during idle for dynamic tick */
 		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -1071,7 +1098,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	if (bank->method == METHOD_GPIO_850)
 		isr_reg = bank->base + OMAP850_GPIO_INT_STATUS;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 	if (bank->method == METHOD_GPIO_24XX)
 		isr_reg = bank->base + OMAP24XX_GPIO_IRQSTATUS1;
 #endif
@@ -1348,7 +1376,7 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
 /*---------------------------------------------------------------------*/
 
 static int initialized;
-#if !defined(CONFIG_ARCH_OMAP3)
+#if !(defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4))
 static struct clk * gpio_ick;
 #endif
 
@@ -1361,7 +1389,7 @@ static struct clk * gpio5_ick;
 static struct clk * gpio5_fck;
 #endif
 
-#if defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
 #endif
 
@@ -1421,8 +1449,8 @@ static int __init _omap_gpio_init(void)
 	}
 #endif
 
-#if defined(CONFIG_ARCH_OMAP3)
-	if (cpu_is_omap34xx()) {
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		for (i = 0; i < OMAP34XX_NR_GPIOS; i++) {
 			sprintf(clk_name, "gpio%d_ick", i + 1);
 			gpio_iclks[i] = clk_get(NULL, clk_name);
@@ -1488,8 +1516,8 @@ static int __init _omap_gpio_init(void)
 			(rev >> 4) & 0x0f, rev & 0x0f);
 	}
 #endif
-#ifdef CONFIG_ARCH_OMAP34XX
-	if (cpu_is_omap34xx()) {
+#if defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP44XX)
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		int rev;
 
 		gpio_bank_count = OMAP34XX_NR_GPIOS;
@@ -1522,7 +1550,8 @@ static int __init _omap_gpio_init(void)
 			gpio_count = 32; /* 730 has 32-bit GPIOs */
 		}
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 		if (bank->method == METHOD_GPIO_24XX) {
 			static const u32 non_wakeup_gpios[] = {
 				0xe203ffc0, 0x08700040
@@ -1579,7 +1608,7 @@ static int __init _omap_gpio_init(void)
 		set_irq_chained_handler(bank->irq, gpio_irq_handler);
 		set_irq_data(bank->irq, bank);
 
-		if (cpu_is_omap34xx()) {
+		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 			sprintf(clk_name, "gpio%d_dbck", i + 1);
 			bank->dbck = clk_get(NULL, clk_name);
 			if (IS_ERR(bank->dbck))
@@ -1601,7 +1630,8 @@ static int __init _omap_gpio_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || \
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP44XX)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
 	int i;
@@ -1624,7 +1654,8 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 		case METHOD_GPIO_24XX:
 			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -1665,7 +1696,8 @@ static int omap_gpio_resume(struct sys_device *dev)
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP44XX)
 		case METHOD_GPIO_24XX:
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
@@ -1697,7 +1729,8 @@ static struct sys_device omap_gpio_device = {
 
 #endif
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 
 static int workaround_enabled;
 
@@ -1713,7 +1746,8 @@ void omap2_gpio_prepare_for_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP44XX)
 		bank->saved_datain = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
 		l1 = __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		l2 = __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
@@ -1722,7 +1756,8 @@ void omap2_gpio_prepare_for_retention(void)
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP44XX)
 		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
 #endif
@@ -1747,7 +1782,8 @@ void omap2_gpio_resume_after_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP44XX)
 		__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(bank->saved_risingdetect,
@@ -1757,14 +1793,16 @@ void omap2_gpio_resume_after_retention(void)
 		 * state.  If so, generate an IRQ by software.  This is
 		 * horribly racy, but it's the best we can do to work around
 		 * this silicon bug. */
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP44XX)
 		l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
 #endif
 		l ^= bank->saved_datain;
 		l &= bank->non_wakeup_gpios;
 		if (l) {
 			u32 old0, old1;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP44XX)
 			old0 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			old1 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
@@ -1800,7 +1838,8 @@ static int __init omap_gpio_sysinit(void)
 
 	mpuio_init();
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || \
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP44XX)
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		if (ret == 0) {
 			ret = sysdev_class_register(&omap_gpio_sysclass);
@@ -1889,7 +1928,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 
 			irqstat = irq_desc[irq].status;
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) ||	\
-		defined(CONFIG_ARCH_OMAP34XX)
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP44XX)
 			if (is_in && ((bank->suspend_wakeup & mask)
 					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
 				char	*trigger = NULL;
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index af326ef..a46f328 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -7,6 +7,7 @@
 #include <mach/omap16xx.h>
 #include <mach/omap24xx.h>
 #include <mach/omap34xx.h>
+#include <mach/omap44xx.h>
 
 #define BETWEEN(p,st,sz)	((p) >= (st) && (p) < ((st) + (sz)))
 #define XLATE(p,pst,vst)	((void __iomem *)((p) - (pst) + (vst)))
@@ -92,7 +93,22 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 			return XLATE(p, L4_EMU_34XX_PHYS, L4_EMU_34XX_VIRT);
 	}
 #endif
-
+#ifdef CONFIG_ARCH_OMAP4
+	if (cpu_is_omap44xx()) {
+		if (BETWEEN(p, L3_44XX_PHYS, L3_44XX_SIZE))
+			return XLATE(p, L3_44XX_PHYS, L3_44XX_VIRT);
+		if (BETWEEN(p, L4_44XX_PHYS, L4_44XX_SIZE))
+			return XLATE(p, L4_44XX_PHYS, L4_44XX_VIRT);
+		if (BETWEEN(p, L4_WK_44XX_PHYS, L4_WK_44XX_SIZE))
+			return XLATE(p, L4_WK_44XX_PHYS, L4_WK_44XX_VIRT);
+		if (BETWEEN(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_SIZE))
+			return XLATE(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_VIRT);
+		if (BETWEEN(p, L4_PER_44XX_PHYS, L4_PER_44XX_SIZE))
+			return XLATE(p, L4_PER_44XX_PHYS, L4_PER_44XX_VIRT);
+		if (BETWEEN(p, L4_EMU_44XX_PHYS, L4_EMU_44XX_SIZE))
+			return XLATE(p, L4_EMU_44XX_PHYS, L4_EMU_44XX_VIRT);
+	}
+#endif
 	return __arm_ioremap(p, size, type);
 }
 EXPORT_SYMBOL(omap_ioremap);
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index 80b040f..8d329fb 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -54,6 +54,9 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 {
 	struct pin_config *reg;
 
+	if (cpu_is_omap44xx())
+		return 0;
+
 	if (mux_cfg == NULL) {
 		printk(KERN_ERR "Pin mux table not initialized\n");
 		return -ENODEV;
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index fa5297d..4f45d6c 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -44,6 +44,8 @@
 #define OMAP3_SRAM_VA           0xd7000000
 #define OMAP3_SRAM_PUB_PA       0x40208000
 #define OMAP3_SRAM_PUB_VA       0xd7008000
+#define OMAP4_SRAM_PA		0x40200000		/*0x402f0000*/
+#define OMAP4_SRAM_VA		0xd7000000		/*0xd70f0000*/
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00
@@ -87,6 +89,10 @@ static int is_sram_locked(void)
 {
 	int type = 0;
 
+	if (cpu_is_omap44xx())
+		/* Not yet supported */
+		return 0;
+
 	if (cpu_is_omap242x())
 		type = omap_rev() & OMAP2_DEVICETYPE_MASK;
 
@@ -135,6 +141,10 @@ void __init omap_detect_sram(void)
 				omap_sram_base = OMAP3_SRAM_VA;
 				omap_sram_start = OMAP3_SRAM_PA;
 				omap_sram_size = 0x10000; /* 64K */
+			} else if (cpu_is_omap44xx()) {
+				omap_sram_base = OMAP4_SRAM_VA;
+				omap_sram_start = OMAP4_SRAM_PA;
+				omap_sram_size = 0x8000; /* 32K */
 			} else {
 				omap_sram_base = OMAP2_SRAM_VA;
 				omap_sram_start = OMAP2_SRAM_PA;
@@ -203,6 +213,12 @@ void __init omap_map_sram(void)
 		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
 	}
 
+	if (cpu_is_omap44xx()) {
+		omap_sram_io_desc[0].virtual = OMAP4_SRAM_VA;
+		base = OMAP4_SRAM_PA;
+		base = ROUND_DOWN(base, PAGE_SIZE);
+		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
+	}
 	omap_sram_io_desc[0].length = 1024 * 1024;	/* Use section desc */
 	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
 
@@ -242,10 +258,12 @@ void * omap_sram_push(void * start, unsigned long size)
 	return (void *)omap_sram_ceil;
 }
 
+#ifndef CONFIG_ARCH_OMAP4 /* to remove compile time warning */
 static void omap_sram_error(void)
 {
 	panic("Uninitialized SRAM function\n");
 }
+#endif
 
 #ifdef CONFIG_ARCH_OMAP1
 
@@ -406,6 +424,8 @@ int __init omap_sram_init(void)
 		omap243x_sram_init();
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
+	else if (cpu_is_omap44xx())
+		omap34xx_sram_init(); /* REVISIT: */
 
 	return 0;
 }
-- 
1.5.4.7

