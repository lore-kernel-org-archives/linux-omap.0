From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH] OMAP3: GPIO: Enable debounce clock only when debounce is enabled v2.
Date: Tue, 16 Sep 2008 15:16:19 +0300
Message-ID: <1221567379-2177-1-git-send-email-jouni.hogander@nokia.com>
References: <873ak0mk5t.fsf@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28779 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYIPMPD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:15:03 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8GCEPuf013124
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 07:15:01 -0500
In-Reply-To: <873ak0mk5t.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch changes gpio "driver" to enable debounce clock for
gpio-bank only when debounce is enabled for some gpio in that bank.

Gpio functional clocks are also renamed in clock tree, gpioX_fck ->
gpioX_dbck.

This patch triggers problem with gpio wake-up and Omap3. Gpios in PER
domain aren't capable to generate wake-up if PER domain is in sleep
state. For this iopad wake-up should be used and needed pad
configuration should be done. Enabling iopad wake-up for gpio pads is
left for bootloader or omap mux configuration in kernel.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h |   36 ++++++++++++++++++------------------
 arch/arm/plat-omap/gpio.c       |   29 ++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 41f91f8..b81b69b 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2399,8 +2399,8 @@ static struct clk wkup_32k_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio1_fck = {
-	.name		= "gpio1_fck",
+static struct clk gpio1_dbck = {
+	.name		= "gpio1_dbck",
 	.parent		= &wkup_32k_fck,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
@@ -2643,8 +2643,8 @@ static struct clk per_32k_alwon_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio6_fck = {
-	.name		= "gpio6_fck",
+static struct clk gpio6_dbck = {
+	.name		= "gpio6_dbck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
@@ -2653,8 +2653,8 @@ static struct clk gpio6_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio5_fck = {
-	.name		= "gpio5_fck",
+static struct clk gpio5_dbck = {
+	.name		= "gpio5_dbck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
@@ -2663,8 +2663,8 @@ static struct clk gpio5_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio4_fck = {
-	.name		= "gpio4_fck",
+static struct clk gpio4_dbck = {
+	.name		= "gpio4_dbck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
@@ -2673,8 +2673,8 @@ static struct clk gpio4_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio3_fck = {
-	.name		= "gpio3_fck",
+static struct clk gpio3_dbck = {
+	.name		= "gpio3_dbck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
@@ -2683,8 +2683,8 @@ static struct clk gpio3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio2_fck = {
-	.name		= "gpio2_fck",
+static struct clk gpio2_dbck = {
+	.name		= "gpio2_dbck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
@@ -3290,7 +3290,7 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&usim_fck,
 	&gpt1_fck,
 	&wkup_32k_fck,
-	&gpio1_fck,
+	&gpio1_dbck,
 	&wdt2_fck,
 	&wkup_l4_ick,
 	&usim_ick,
@@ -3312,11 +3312,11 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&gpt8_fck,
 	&gpt9_fck,
 	&per_32k_alwon_fck,
-	&gpio6_fck,
-	&gpio5_fck,
-	&gpio4_fck,
-	&gpio3_fck,
-	&gpio2_fck,
+	&gpio6_dbck,
+	&gpio5_dbck,
+	&gpio4_dbck,
+	&gpio3_dbck,
+	&gpio2_dbck,
 	&wdt3_fck,
 	&per_l4_ick,
 	&gpio6_ick,
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index ac55616..77a6d90 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -151,6 +151,9 @@ struct gpio_bank {
 	u32 level_mask;
 	spinlock_t lock;
 	struct gpio_chip chip;
+#if defined(CONFIG_ARCH_OMAP3)
+	struct clk *dbck;
+#endif
 };
 
 #define METHOD_MPUIO		0
@@ -483,11 +486,17 @@ void omap_set_gpio_debounce(int gpio, int enable)
 	reg += OMAP24XX_GPIO_DEBOUNCE_EN;
 	val = __raw_readl(reg);
 
-	if (enable)
+	if (enable && !(val & l))
 		val |= l;
-	else
+	else if (!enable && val & l)
 		val &= ~l;
+	else
+		return;
 
+#if defined(CONFIG_ARCH_OMAP3)
+	if (cpu_is_omap34xx())
+		enable ? clk_enable(bank->dbck) : clk_disable(bank->dbck);
+#endif
 	__raw_writel(val, reg);
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce);
@@ -1298,7 +1307,6 @@ static struct clk * gpio5_fck;
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3)
-static struct clk *gpio_fclks[OMAP34XX_NR_GPIOS];
 static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
 #endif
 
@@ -1369,12 +1377,6 @@ static int __init _omap_gpio_init(void)
 				printk(KERN_ERR "Could not get %s\n", clk_name);
 			else
 				clk_enable(gpio_iclks[i]);
-			sprintf(clk_name, "gpio%d_fck", i + 1);
-			gpio_fclks[i] = clk_get(NULL, clk_name);
-			if (IS_ERR(gpio_fclks[i]))
-				printk(KERN_ERR "Could not get %s\n", clk_name);
-			else
-				clk_enable(gpio_fclks[i]);
 		}
 	}
 #endif
@@ -1513,6 +1515,15 @@ static int __init _omap_gpio_init(void)
 		}
 		set_irq_chained_handler(bank->irq, gpio_irq_handler);
 		set_irq_data(bank->irq, bank);
+
+#if defined(CONFIG_ARCH_OMAP3)
+		if (cpu_is_omap34xx()) {
+			sprintf(clk_name, "gpio%d_dbck", i + 1);
+			bank->dbck = clk_get(NULL, clk_name);
+			if (IS_ERR(bank->dbck))
+				printk(KERN_ERR "Could not get %s\n", clk_name);
+		}
+#endif
 	}
 
 	/* Enable system clock for GPIO module.
-- 
1.5.5

