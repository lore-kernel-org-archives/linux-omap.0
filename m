From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/14] omap2/3/4: Replace orred CONFIG_ARCH_OMAP2/3/4 with
	CONFIG_ARCH_OMAP2PLUS
Date: Tue, 26 Jan 2010 12:13:01 -0800
Message-ID: <20100126201301.15382.4646.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60980 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab0AZUMn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:43 -0500
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

omap: Replace orred CONFIG_ARCH_OMAP2/3/4 with CONFIG_ARCH_OMAP2PLUS

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig               |    2 +-
 arch/arm/plat-omap/Kconfig                |    4 ++-
 arch/arm/plat-omap/dma.c                  |    3 +-
 arch/arm/plat-omap/dmtimer.c              |   12 +++-------
 arch/arm/plat-omap/gpio.c                 |   36 ++++++++++-------------------
 arch/arm/plat-omap/include/plat/clock.h   |    6 ++---
 arch/arm/plat-omap/include/plat/control.h |    3 +-
 arch/arm/plat-omap/include/plat/mcbsp.h   |    3 +-
 arch/arm/plat-omap/include/plat/memory.h  |    3 +-
 9 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 317b8cb..f90b225 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -29,7 +29,7 @@ config OMAP_PACKAGE_CBP
        bool
 
 comment "OMAP Board Type"
-	depends on ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
+	depends on ARCH_OMAP2PLUS
 
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 1e22392..97d0c79 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -125,7 +125,7 @@ config OMAP_MPU_TIMER
 
 config OMAP_32K_TIMER
 	bool "Use 32KHz timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
+	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
 	help
 	  Select this option if you want to enable the OMAP 32KHz timer.
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
@@ -146,7 +146,7 @@ config OMAP_32K_TIMER_HZ
 
 config OMAP_DM_TIMER
 	bool "Use dual-mode timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
+	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 728c642..30ff525 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1870,8 +1870,7 @@ static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
 #define omap1_dma_irq_handler	NULL
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-			defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 
 static int omap2_dma_handle_ch(int ch)
 {
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c588cdf..24bf692 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -153,8 +153,7 @@
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int irq;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-			defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	struct clk *iclk, *fclk;
 #endif
 	void __iomem *io_base;
@@ -490,8 +489,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
-#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-				defined(CONFIG_ARCH_OMAP4)
+#else
 
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
@@ -535,8 +533,7 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 	if (l & OMAP_TIMER_CTRL_ST) {
 		l &= ~0x1;
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-			defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 		/* Readback to make sure write has completed */
 		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 		 /*
@@ -781,8 +778,7 @@ int __init omap_dm_timer_init(void)
 		timer->io_base = ioremap(timer->phys_base, map_size);
 		BUG_ON(!timer->io_base);
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-					defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 		if (cpu_class_is_omap2()) {
 			char clk_name[16];
 			sprintf(clk_name, "gpt%d_ick", i + 1);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c8b581f..51c53fc 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -177,13 +177,11 @@ struct gpio_bank {
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) ||  \
-		defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-			defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 
@@ -592,8 +590,7 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 		reg += OMAP7XX_GPIO_DATA_OUTPUT;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-		defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_DATAOUT;
 		break;
@@ -684,8 +681,7 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce_time);
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-				defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 						int trigger)
 {
@@ -856,8 +852,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 			goto bad;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-				defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	case METHOD_GPIO_24XX:
 		set_24xx_gpio_triggering(bank, gpio, trigger);
 		break;
@@ -1131,8 +1126,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-				defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	case METHOD_GPIO_24XX:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			printk(KERN_ERR "Unable to modify wakeup on "
@@ -1227,8 +1221,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-				defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	if (bank->method == METHOD_GPIO_24XX) {
 		/* Disable wake-up during idle for dynamic tick */
 		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -1809,8 +1802,7 @@ static int __init _omap_gpio_init(void)
 			gpio_count = 32; /* 7xx has 32-bit GPIOs */
 		}
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-				defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 		if (bank->method == METHOD_GPIO_24XX) {
 			static const u32 non_wakeup_gpios[] = {
 				0xe203ffc0, 0x08700040
@@ -1903,8 +1895,7 @@ static int __init _omap_gpio_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) || \
-		defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
 	int i;
@@ -2013,8 +2004,7 @@ static struct sys_device omap_gpio_device = {
 
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-				defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 
 static int workaround_enabled;
 
@@ -2240,8 +2230,7 @@ static int __init omap_gpio_sysinit(void)
 
 	mpuio_init();
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) || \
-		defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		if (ret == 0) {
 			ret = sysdev_class_register(&omap_gpio_sysclass);
@@ -2300,8 +2289,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 /* FIXME for at least omap2, show pullup/pulldown state */
 
 			irqstat = irq_desc[irq].status;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2) ||	\
-		defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 			if (is_in && ((bank->suspend_wakeup & mask)
 					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
 				char	*trigger = NULL;
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 94fe2a0..5832e9f 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -26,8 +26,7 @@ struct clkops {
 	void			(*find_companion)(struct clk *, void __iomem **, u8 *);
 };
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-		defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 
 struct clksel_rate {
 	u32			val;
@@ -88,8 +87,7 @@ struct clk {
 	void			(*init)(struct clk *);
 	__u8			enable_bit;
 	__s8			usecount;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-		defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	u8			fixed_div;
 	void __iomem		*clksel_reg;
 	u32			clksel_mask;
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index a745d62..3e2c91f 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -292,8 +292,7 @@
 
 
 #ifndef __ASSEMBLY__
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-		defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_ARCH_OMAP2PLUS
 extern void __iomem *omap_ctrl_base_get(void);
 extern u8 omap_ctrl_readb(u16 offset);
 extern u16 omap_ctrl_readw(u16 offset);
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 0d7e536..d93fa44 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -103,8 +103,7 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
 
-#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-	defined(CONFIG_ARCH_OMAP4)
+#else
 
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x04
diff --git a/arch/arm/plat-omap/include/plat/memory.h b/arch/arm/plat-omap/include/plat/memory.h
index 3325f7b..d5306be 100644
--- a/arch/arm/plat-omap/include/plat/memory.h
+++ b/arch/arm/plat-omap/include/plat/memory.h
@@ -38,8 +38,7 @@
  */
 #if defined(CONFIG_ARCH_OMAP1)
 #define PHYS_OFFSET		UL(0x10000000)
-#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-			defined(CONFIG_ARCH_OMAP4)
+#else
 #define PHYS_OFFSET		UL(0x80000000)
 #endif
 

