From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 8/12] OMAP 3430 support for plat-omap
Date: Thu, 31 May 2007 12:59:14 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701063218@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Adding OMAP 3430 Support to arch/arm/plat-omap

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 Kconfig    |    9 ++--
 common.c   |    2
 devices.c  |    8 +--
 dma.c      |    2
 dmtimer.c  |   43 ++++++++++++++++---
 gpio.c     |  132
 sram.c     |   12 ++---
 timer32k.c |    8 ++-
 8 files changed, 154 insertions(+), 62 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/plat-omap/Kconfig =
val_3430_GIT/arch/arm/plat-omap/Kconfig
--- linux-omap/arch/arm/plat-omap/Kconfig	2007-05-16 14:32:40.000000000 =
-0500
+++ val_3430_GIT/arch/arm/plat-omap/Kconfig	2007-05-28 =
12:47:13.000000000 -0500
@@ -15,6 +15,9 @@ config ARCH_OMAP1
 config ARCH_OMAP2
 	bool "TI OMAP2"
=20
+config ARCH_OMAP3
+	bool "TI OMAP3"
+
 endchoice
=20
 comment "OMAP Feature Selections"
@@ -148,13 +151,13 @@ config OMAP_MPU_TIMER
=20
 config OMAP_32K_TIMER
 	bool "Use 32KHz timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
 	help
 	  Select this option if you want to enable the OMAP 32KHz timer.
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
 	  support for no tick during idle. The 32KHz timer provides less
 	  intra-tick resolution than OMAP_MPU_TIMER. The 32KHz timer is
-	  currently only available for OMAP16XX and 24XX.
+	  currently only available for OMAP16XX, 24XX and 34XX.
=20
 endchoice
=20
@@ -169,7 +172,7 @@ config OMAP_32K_TIMER_HZ
=20
 config OMAP_DM_TIMER
 	bool "Use dual-mode timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
=20
diff -purN linux-omap/arch/arm/plat-omap/common.c =
val_3430_GIT/arch/arm/plat-omap/common.c
--- linux-omap/arch/arm/plat-omap/common.c	2007-05-25 15:52:23.000000000 =
-0500
+++ val_3430_GIT/arch/arm/plat-omap/common.c	2007-05-29 =
15:32:26.000000000 -0500
@@ -218,7 +218,7 @@ static int __init omap_init_clocksource_
 	static char err[] __initdata =3D KERN_ERR
 			"%s: can't register clocksource!\n";
=20
-	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		clocksource_32k.mult =3D clocksource_hz2mult(32768,
 					    clocksource_32k.shift);
=20
diff -purN linux-omap/arch/arm/plat-omap/devices.c =
val_3430_GIT/arch/arm/plat-omap/devices.c
--- linux-omap/arch/arm/plat-omap/devices.c	2007-04-27 =
11:01:33.000000000 -0500
+++ val_3430_GIT/arch/arm/plat-omap/devices.c	2007-05-29 =
15:31:35.000000000 -0500
@@ -141,7 +141,7 @@ static void omap_init_i2c(void)
 	 * either don't wire up I2C, or chips that mux it differently...
 	 * it can include clocking and address info, maybe more.
 	 */
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		if (machine_is_omap_h4()) {
 			omap_cfg_reg(M19_24XX_I2C1_SCL);
 			omap_cfg_reg(L15_24XX_I2C1_SDA);
@@ -164,7 +164,7 @@ static inline void omap_init_i2c(void) {
 static void omap_init_kp(void)
 {
 	/* REVISIT: 2430 keypad is on TWL4030 */
-	if (cpu_is_omap2430())
+	if (cpu_is_omap2430() || cpu_is_omap34xx())
 		return;
=20
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
@@ -295,7 +295,7 @@ static void __init omap_init_mmc(void)
 	const struct omap_mmc_conf	*mmc;
=20
 	/* REVISIT: 2430 has HS MMC */
-	if (cpu_is_omap2430())
+	if (cpu_is_omap2430() || cpu_is_omap34xx())
 		return;
=20
 	/* NOTE:  assumes MMC was never (wrongly) enabled */
@@ -526,7 +526,7 @@ static int __init omap_init_devices(void
 	omap_init_uwire();
 	omap_init_wdt();
 	omap_init_rng();
-	if (!cpu_is_omap2430()) {
+	if (!cpu_is_omap2430() && !cpu_is_omap34xx()) {
 		omap_init_i2c();
 	}
 	return 0;
diff -purN linux-omap/arch/arm/plat-omap/dma.c =
val_3430_GIT/arch/arm/plat-omap/dma.c
--- linux-omap/arch/arm/plat-omap/dma.c	2007-05-25 13:27:04.000000000 =
-0500
+++ val_3430_GIT/arch/arm/plat-omap/dma.c	2007-05-28 12:49:40.000000000 =
-0500
@@ -628,7 +628,7 @@ void omap_clear_dma(int lch)
=20
 	if (cpu_is_omap24xx()) {
 		int i;
-		u32 lch_base =3D OMAP24XX_DMA_BASE + lch * 0x60 + 0x80;
+		u32 lch_base =3D OMAP_DMA4_BASE + lch * 0x60 + 0x80;
 		for (i =3D 0; i < 0x44; i +=3D 4)
 			omap_writel(0, lch_base + i);
 	}
diff -purN linux-omap/arch/arm/plat-omap/dmtimer.c =
val_3430_GIT/arch/arm/plat-omap/dmtimer.c
--- linux-omap/arch/arm/plat-omap/dmtimer.c	2007-04-04 =
18:13:49.000000000 -0500
+++ val_3430_GIT/arch/arm/plat-omap/dmtimer.c	2007-05-29 =
15:30:32.000000000 -0500
@@ -70,7 +70,7 @@
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int irq;
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	struct clk *iclk, *fclk;
 #endif
 	void __iomem *io_base;
@@ -122,6 +122,34 @@ static const char *dm_source_names[] =3D {
=20
 static struct clk *dm_source_clocks[3];
=20
+#elif defined(CONFIG_ARCH_OMAP3)
+
+#define omap_dm_clk_enable(x) clk_enable(x)
+#define omap_dm_clk_disable(x) clk_disable(x)
+
+static struct omap_dm_timer dm_timers[] =3D {
+	{ .phys_base	=3D 0x48318000, .irq	=3D INT_24XX_GPTIMER1 },
+	{ .phys_base	=3D 0x49032000, .irq	=3D INT_24XX_GPTIMER2 },
+	{ .phys_base	=3D 0x49034000, .irq	=3D INT_24XX_GPTIMER3 },
+	{ .phys_base	=3D 0x49036000, .irq	=3D INT_24XX_GPTIMER4 },
+	{ .phys_base	=3D 0x49038000, .irq	=3D INT_24XX_GPTIMER5 },
+	{ .phys_base	=3D 0x4903A000, .irq	=3D INT_24XX_GPTIMER6 },
+	{ .phys_base	=3D 0x4903C000, .irq	=3D INT_24XX_GPTIMER7 },
+	{ .phys_base	=3D 0x4903E000, .irq	=3D INT_24XX_GPTIMER8 },
+	{ .phys_base	=3D 0x49040000, .irq	=3D INT_24XX_GPTIMER9 },
+	{ .phys_base	=3D 0x48086000, .irq	=3D INT_24XX_GPTIMER10 },
+	{ .phys_base	=3D 0x48088000, .irq	=3D INT_24XX_GPTIMER11 },
+	{ .phys_base	=3D 0x48304000, .irq	=3D INT_24XX_GPTIMER12 },
+};
+
+static const char *dm_source_names[] =3D {
+	"sys_ck",
+	"func_32k_ck",
+	"alt_ck"
+};
+
+static struct clk *dm_source_clocks[3];
+
 #else
=20
 #error OMAP architecture not supported!
@@ -191,7 +219,6 @@ struct omap_dm_timer *omap_dm_timer_requ
 	struct omap_dm_timer *timer =3D NULL;
 	unsigned long flags;
 	int i;
-
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	for (i =3D 0; i < dm_timer_count; i++) {
 		if (dm_timers[i].reserved)
@@ -299,7 +326,7 @@ __u32 omap_dm_timer_modify_idlect_mask(_
 	return inputmask;
 }
=20
-#elif defined(CONFIG_ARCH_OMAP2)
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
=20
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
@@ -491,27 +518,27 @@ int omap_dm_timer_init(void)
 	struct omap_dm_timer *timer;
 	int i;
=20
-	if (!(cpu_is_omap16xx() || cpu_is_omap24xx()))
+	if (!(cpu_is_omap16xx() || cpu_class_is_omap2()))
 		return -ENODEV;
=20
 	spin_lock_init(&dm_timer_lock);
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	for (i =3D 0; i < ARRAY_SIZE(dm_source_names); i++) {
 		dm_source_clocks[i] =3D clk_get(NULL, dm_source_names[i]);
 		BUG_ON(dm_source_clocks[i] =3D=3D NULL);
 	}
 #endif
-	if (cpu_is_omap243x())
+	if (cpu_is_omap243x() || cpu_is_omap343x())
 		dm_timers[0].phys_base =3D 0x49018000;
=20
 	for (i =3D 0; i < dm_timer_count; i++) {
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		char clk_name[16];
 #endif
=20
 		timer =3D &dm_timers[i];
 		timer->io_base =3D (void __iomem *) io_p2v(timer->phys_base);
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		sprintf(clk_name, "gpt%d_ick", i + 1);
 		timer->iclk =3D clk_get(NULL, clk_name);
 		sprintf(clk_name, "gpt%d_fck", i + 1);
diff -purN linux-omap/arch/arm/plat-omap/gpio.c =
val_3430_GIT/arch/arm/plat-omap/gpio.c
--- linux-omap/arch/arm/plat-omap/gpio.c	2007-05-07 20:57:49.000000000 =
-0500
+++ val_3430_GIT/arch/arm/plat-omap/gpio.c	2007-05-29 15:29:30.000000000 =
-0500
@@ -120,17 +120,29 @@
 #define OMAP24XX_GPIO_CLEARDATAOUT	0x0090
 #define OMAP24XX_GPIO_SETDATAOUT	0x0094
=20
+/*
+ * omap34xx specific GPIO registers
+ */
+
+#define OMAP34XX_GPIO1_BASE		(void __iomem *)0x48310000
+#define OMAP34XX_GPIO2_BASE		(void __iomem *)0x49050000
+#define OMAP34XX_GPIO3_BASE		(void __iomem *)0x49052000
+#define OMAP34XX_GPIO4_BASE		(void __iomem *)0x49054000
+#define OMAP34XX_GPIO5_BASE		(void __iomem *)0x49056000
+#define OMAP34XX_GPIO6_BASE		(void __iomem *)0x49058000
+
+
 struct gpio_bank {
 	void __iomem *base;
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
 	u32 reserved_map;
-#if defined (CONFIG_ARCH_OMAP16XX) || defined (CONFIG_ARCH_OMAP24XX)
+#if defined (CONFIG_ARCH_OMAP16XX) || defined (CONFIG_ARCH_OMAP24XX) || =
defined(CONFIG_ARCH_OMAP34XX)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
=20
@@ -195,6 +207,18 @@ static struct gpio_bank gpio_bank_243x[5
=20
 #endif
=20
+#ifdef CONFIG_ARCH_OMAP34XX
+static struct gpio_bank gpio_bank_34xx[6] =3D {
+	{ OMAP34XX_GPIO1_BASE, INT_34XX_GPIO_BANK1, IH_GPIO_BASE,	=
METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO2_BASE, INT_34XX_GPIO_BANK2, IH_GPIO_BASE + 32,	=
METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO3_BASE, INT_34XX_GPIO_BANK3, IH_GPIO_BASE + 64,	=
METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO4_BASE, INT_34XX_GPIO_BANK4, IH_GPIO_BASE + 96,	=
METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO5_BASE, INT_34XX_GPIO_BANK5, IH_GPIO_BASE + 128, =
METHOD_GPIO_24XX },
+	{ OMAP34XX_GPIO6_BASE, INT_34XX_GPIO_BANK6, IH_GPIO_BASE + 160, =
METHOD_GPIO_24XX },
+};
+
+#endif
+
 static struct gpio_bank *gpio_bank;
 static int gpio_bank_count;
=20
@@ -225,6 +249,10 @@ static inline struct gpio_bank *get_gpio
 	if (cpu_is_omap24xx())
 		return &gpio_bank[gpio >> 5];
 #endif
+#ifdef CONFIG_ARCH_OMAP34XX
+	if (cpu_is_omap34xx())
+		return &gpio_bank[gpio >> 5];
+#endif
 }
=20
 static inline int get_gpio_index(int gpio)
@@ -237,6 +265,10 @@ static inline int get_gpio_index(int gpi
 	if (cpu_is_omap24xx())
 		return gpio & 0x1f;
 #endif
+#ifdef CONFIG_ARCH_OMAP34XX
+	if (cpu_is_omap34xx())
+		return gpio & 0x1f;
+#endif
 	return gpio & 0x0f;
 }
=20
@@ -267,6 +299,10 @@ static inline int gpio_valid(int gpio)
 	if (cpu_is_omap24xx() && gpio < 128)
 		return 0;
 #endif
+#ifdef CONFIG_ARCH_OMAP34XX
+	if (cpu_is_omap34xx() && gpio < 160)
+		return 0;
+#endif
 	return -1;
 }
=20
@@ -306,7 +342,7 @@ static void _set_gpio_direction(struct g
 		reg +=3D OMAP730_GPIO_DIR_CONTROL;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg +=3D OMAP24XX_GPIO_OE;
 		break;
@@ -380,7 +416,7 @@ static void _set_gpio_dataout(struct gpi
 			l &=3D ~(1 << gpio);
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg +=3D OMAP24XX_GPIO_SETDATAOUT;
@@ -438,7 +474,7 @@ int omap_get_gpio_datain(int gpio)
 		reg +=3D OMAP730_GPIO_DATA_INPUT;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg +=3D OMAP24XX_GPIO_DATAIN;
 		break;
@@ -458,7 +494,7 @@ do {	\
 	__raw_writel(l, base + reg); \
 } while(0)
=20
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int =
gpio, int trigger)
 {
 	void __iomem *base =3D bank->base;
@@ -587,7 +623,7 @@ static int _set_gpio_triggering(struct g
 			goto bad;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		set_24xx_gpio_triggering(bank, gpio, trigger);
 		break;
@@ -607,7 +643,7 @@ static int gpio_irq_type(unsigned irq, u
 	unsigned gpio;
 	int retval;
=20
-	if (!cpu_is_omap24xx() && irq > IH_MPUIO_BASE)
+	if (!(cpu_class_is_omap2()) && irq > IH_MPUIO_BASE)
 		gpio =3D OMAP_MPUIO(irq - IH_MPUIO_BASE);
 	else
 		gpio =3D irq - IH_GPIO_BASE;
@@ -619,7 +655,7 @@ static int gpio_irq_type(unsigned irq, u
 		return -EINVAL;
=20
 	/* OMAP1 allows only only edge triggering */
-	if (!cpu_is_omap24xx()
+	if (!(cpu_class_is_omap2())
 			&& (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
=20
@@ -660,7 +696,7 @@ static void _clear_gpio_irqbank(struct g
 		reg +=3D OMAP730_GPIO_INT_STATUS;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg +=3D OMAP24XX_GPIO_IRQSTATUS1;
 		break;
@@ -672,8 +708,10 @@ static void _clear_gpio_irqbank(struct g
 	__raw_writel(gpio_mask, reg);
=20
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
-	if (cpu_is_omap2420())
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+	if (cpu_is_omap2420() || cpu_is_omap34xx())
 		__raw_writel(gpio_mask, bank->base + OMAP24XX_GPIO_IRQSTATUS2);
+#endif
 }
=20
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int =
gpio)
@@ -716,7 +754,7 @@ static u32 _get_gpio_irqbank_mask(struct
 		inv =3D 1;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		reg +=3D OMAP24XX_GPIO_IRQENABLE1;
 		mask =3D 0xffffffff;
@@ -779,7 +817,7 @@ static void _enable_gpio_irqbank(struct=20
 			l |=3D gpio_mask;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg +=3D OMAP24XX_GPIO_SETIRQENABLE1;
@@ -825,7 +863,7 @@ static int _set_gpio_wakeup(struct gpio_
 		spin_unlock(&bank->lock);
 		return 0;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			printk(KERN_ERR "Unable to modify wakeup on "
@@ -931,7 +969,7 @@ void omap_free_gpio(int gpio)
 		__raw_writel(1 << get_gpio_index(gpio), reg);
 	}
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	if (bank->method =3D=3D METHOD_GPIO_24XX) {
 		/* Disable wake-up during idle for dynamic tick */
 		void __iomem *reg =3D bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -980,7 +1018,7 @@ static void gpio_irq_handler(unsigned in
 	if (bank->method =3D=3D METHOD_GPIO_730)
 		isr_reg =3D bank->base + OMAP730_GPIO_INT_STATUS;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	if (bank->method =3D=3D METHOD_GPIO_24XX)
 		isr_reg =3D bank->base + OMAP24XX_GPIO_IRQSTATUS1;
 #endif
@@ -994,7 +1032,7 @@ static void gpio_irq_handler(unsigned in
 		if (cpu_is_omap15xx() && (bank->method =3D=3D METHOD_MPUIO))
 			isr &=3D 0x0000ffff;
=20
-		if (cpu_is_omap24xx()) {
+		if (cpu_class_is_omap2()) {
 			level_mask =3D
 				__raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0) |
@@ -1063,7 +1101,7 @@ static void gpio_irq_handler(unsigned in
 			}
 		}
=20
-		if (cpu_is_omap24xx()) {
+		if (cpu_class_is_omap2()) {
 			/* clear level sensitive interrupts after handler(s) */
 			_enable_gpio_irqbank(bank, isr_saved & level_mask, 0);
 			_clear_gpio_irqbank(bank, isr_saved & level_mask);
@@ -1242,7 +1280,7 @@ static int initialized;
 static struct clk * gpio_ick;
 static struct clk * gpio_fck;
=20
-#ifdef CONFIG_ARCH_OMAP2430
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
 static struct clk * gpio5_ick;
 static struct clk * gpio5_fck;
 #endif
@@ -1261,7 +1299,7 @@ static int __init _omap_gpio_init(void)
 		else
 			clk_enable(gpio_ick);
 	}
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		gpio_ick =3D clk_get(NULL, "gpios_ick");
 		if (IS_ERR(gpio_ick))
 			printk("Could not get gpios_ick\n");
@@ -1274,10 +1312,10 @@ static int __init _omap_gpio_init(void)
 			clk_enable(gpio_fck);
=20
 		/*
-		 * On 2430 GPIO 5 uses CORE L4 ICLK
+		 * On 2430 & 3430 GPIO 5 uses CORE L4 ICLK
 		 */
-#ifdef CONFIG_ARCH_OMAP2430
-		if (cpu_is_omap2430()) {
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+		if (cpu_is_omap2430() || cpu_is_omap3430()) {
 			gpio5_ick =3D clk_get(NULL, "gpio5_ick");
 			if (IS_ERR(gpio5_ick))
 				printk("Could not get gpio5_ick\n");
@@ -1290,7 +1328,7 @@ static int __init _omap_gpio_init(void)
 				clk_enable(gpio5_fck);
 		}
 #endif
-}
+	}
=20
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap15xx()) {
@@ -1338,6 +1376,17 @@ static int __init _omap_gpio_init(void)
 			(rev >> 4) & 0x0f, rev & 0x0f);
 	}
 #endif
+#ifdef CONFIG_ARCH_OMAP34XX
+	if (cpu_is_omap34xx()) {
+		int rev;
+
+		gpio_bank_count =3D 6;
+		gpio_bank =3D gpio_bank_34xx;
+		rev =3D omap_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
+		printk(KERN_INFO "OMAP34xx GPIO hardware version %d.%d\n",
+			(rev >> 4) & 0x0f, rev & 0x0f);
+	}
+#endif
 	for (i =3D 0; i < gpio_bank_count; i++) {
 		int j, gpio_count =3D 16;
=20
@@ -1368,7 +1417,7 @@ static int __init _omap_gpio_init(void)
 			gpio_count =3D 32; /* 730 has 32-bit GPIOs */
 		}
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		if (bank->method =3D=3D METHOD_GPIO_24XX) {
 			static const u32 non_wakeup_gpios[] =3D {
 				0xe203ffc0, 0x08700040
@@ -1404,21 +1453,23 @@ static int __init _omap_gpio_init(void)
 	if (cpu_is_omap16xx())
 		omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04, ULPD_CAM_CLK_CTRL);
=20
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX)
 	/* Enable autoidle for the OCP interface */
 	if (cpu_is_omap24xx())
 		omap_writel(1 << 0, 0x48019010);
+#elif defined(CONFIG_ARCH_OMAP34XX)
+	if (cpu_is_omap34xx())
+		omap_writel(1 << 0, 0x48306814);
 #endif
-
 	return 0;
 }
=20
-#if defined (CONFIG_ARCH_OMAP16XX) || defined (CONFIG_ARCH_OMAP24XX)
+#if defined (CONFIG_ARCH_OMAP16XX) || defined (CONFIG_ARCH_OMAP24XX) || =
defined (CONFIG_ARCH_OMAP34XX)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
 	int i;
=20
-	if (!cpu_is_omap24xx() && !cpu_is_omap16xx())
+	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
 		return 0;
=20
 	for (i =3D 0; i < gpio_bank_count; i++) {
@@ -1435,7 +1486,7 @@ static int omap_gpio_suspend(struct sys_
 			wake_set =3D bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		case METHOD_GPIO_24XX:
 			wake_status =3D bank->base + OMAP24XX_GPIO_SETWKUENA;
 			wake_clear =3D bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -1475,7 +1526,7 @@ static int omap_gpio_resume(struct sys_d
 			wake_set =3D bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		case METHOD_GPIO_24XX:
 			wake_clear =3D bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set =3D bank->base + OMAP24XX_GPIO_SETWKUENA;
@@ -1507,7 +1558,7 @@ static struct sys_device omap_gpio_devic
=20
 #endif
=20
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
=20
 static int workaround_enabled;
=20
@@ -1523,15 +1574,19 @@ void omap2_gpio_prepare_for_retention(vo
=20
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		bank->saved_datain =3D __raw_readl(bank->base + =
OMAP24XX_GPIO_DATAIN);
 		l1 =3D __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		l2 =3D __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
+#endif
 		bank->saved_fallingdetect =3D l1;
 		bank->saved_risingdetect =3D l2;
 		l1 &=3D ~bank->enabled_non_wakeup_gpios;
 		l2 &=3D ~bank->enabled_non_wakeup_gpios;
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
+#endif
 		c++;
 	}
 	if (!c) {
@@ -1553,26 +1608,31 @@ void omap2_gpio_resume_after_retention(v
=20
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(bank->saved_risingdetect,
 				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
+#endif
 		/* Check if any of the non-wakeup interrupt GPIOs have changed
 		 * state.  If so, generate an IRQ by software.  This is
 		 * horribly racy, but it's the best we can do to work around
 		 * this silicon bug. */
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 		l =3D __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
+#endif
 		l ^=3D bank->saved_datain;
 		l &=3D bank->non_wakeup_gpios;
 		if (l) {
 			u32 old0, old1;
-
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 			old0 =3D __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			old1 =3D __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			__raw_writel(old1 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			__raw_writel(old1, bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+#endif
 		}
 	}
=20
@@ -1601,8 +1661,8 @@ static int __init omap_gpio_sysinit(void
=20
 	mpuio_init();
=20
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX)
-	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || =
defined(CONFIG_ARCH_OMAP34XX)
+	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		if (ret =3D=3D 0) {
 			ret =3D sysdev_class_register(&omap_gpio_sysclass);
 			if (ret =3D=3D 0)
@@ -1664,7 +1724,7 @@ static int dbg_gpio_show(struct seq_file
=20
 		if (bank_is_mpuio(bank))
 			gpio =3D OMAP_MPUIO(0);
-		else if (cpu_is_omap24xx() || cpu_is_omap730())
+		else if (cpu_class_is_omap2() || cpu_is_omap730())
 			bankwidth =3D 32;
=20
 		for (j =3D 0; j < bankwidth; j++, gpio++, mask <<=3D 1) {
diff -purN linux-omap/arch/arm/plat-omap/sram.c =
val_3430_GIT/arch/arm/plat-omap/sram.c
--- linux-omap/arch/arm/plat-omap/sram.c	2007-05-25 13:27:04.000000000 =
-0500
+++ val_3430_GIT/arch/arm/plat-omap/sram.c	2007-05-29 15:23:47.000000000 =
-0500
@@ -31,7 +31,7 @@
 #define OMAP2_SRAM_VA		0xd0000000
 #define OMAP2_SRAM_PUB_VA	0xd0000800
=20
-#if defined(CONFIG_ARCH_OMAP24XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00
 #else
 #define SRAM_BOOTLOADER_SZ	0x80
@@ -92,7 +92,7 @@ void __init omap_detect_sram(void)
 {
 	unsigned long reserved;
=20
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		if (is_sram_locked()) {
 			omap_sram_base =3D OMAP2_SRAM_PUB_VA;
 			omap_sram_start =3D OMAP2_SRAM_PUB_PA;
@@ -102,7 +102,7 @@ void __init omap_detect_sram(void)
 			omap_sram_start =3D OMAP2_SRAM_PA;
 			if (cpu_is_omap242x())
 				omap_sram_size =3D 0xa0000; /* 640K */
-			else if (cpu_is_omap243x())
+			else if (cpu_is_omap243x() || cpu_is_omap34xx())
 				omap_sram_size =3D 0x10000; /* 64K */
 		}
 	} else {
@@ -149,7 +149,7 @@ void __init omap_map_sram(void)
 	if (omap_sram_size =3D=3D 0)
 		return;
=20
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		omap_sram_io_desc[0].virtual =3D OMAP2_SRAM_VA;
=20
 		base =3D OMAP2_SRAM_PA;
@@ -224,7 +224,7 @@ int __init omap1_sram_init(void)
 #define omap1_sram_init()	do {} while (0)
 #endif
=20
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
=20
 static void (*_omap2_sram_ddr_init)(u32 *slow_dll_ctrl, u32 =
fast_dll_ctrl,
 			      u32 base_cs, u32 force_unlock);
@@ -279,7 +279,7 @@ int __init omap_sram_init(void)
 	omap_detect_sram();
 	omap_map_sram();
=20
-	if (!cpu_is_omap24xx())
+	if (!(cpu_class_is_omap2()))
 		omap1_sram_init();
 	else
 		omap2_sram_init();
diff -purN linux-omap/arch/arm/plat-omap/timer32k.c =
val_3430_GIT/arch/arm/plat-omap/timer32k.c
--- linux-omap/arch/arm/plat-omap/timer32k.c	2007-05-25 =
15:52:23.000000000 -0500
+++ val_3430_GIT/arch/arm/plat-omap/timer32k.c	2007-05-29 =
15:21:46.000000000 -0500
@@ -72,6 +72,8 @@ struct sys_timer omap_timer;
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
 #elif defined(CONFIG_ARCH_OMAP24XX)
 #define TIMER_32K_SYNCHRONIZED		(OMAP2_32KSYNCT_BASE + 0x10)
+#elif defined(CONFIG_ARCH_OMAP34XX)
+#define TIMER_32K_SYNCHRONIZED		0x48320010
 #else
 #error OMAP 32KHz timer does not currently work on 15XX!
 #endif
@@ -120,7 +122,7 @@ static inline void omap_32k_timer_stop(v
=20
 #define omap_32k_timer_ack_irq()
=20
-#elif defined(CONFIG_ARCH_OMAP2)
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
=20
 static struct omap_dm_timer *gptimer;
=20
@@ -223,9 +225,9 @@ static __init void omap_init_32k_timer(v
 	if (cpu_class_is_omap1())
 		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
=20
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	/* REVISIT: Check 24xx TIOCP_CFG settings after idle works */
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		gptimer =3D omap_dm_timer_request_specific(1);
 		BUG_ON(gptimer =3D=3D NULL);
=20
