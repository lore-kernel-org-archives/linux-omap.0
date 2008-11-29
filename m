From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/11] ARM: OMAP: Enable GPIO debounce clock only when
	debounce is enabled v3
Date: Fri, 28 Nov 2008 17:09:50 -0800
Message-ID: <20081129010949.12337.33666.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57588 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbYK2BJt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:09:49 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

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
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock34xx.h |   36 ++++++++++++++++++------------------
 arch/arm/plat-omap/gpio.c       |   26 +++++++++++++++-----------
 2 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index c38a8a0..7217a08 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2280,8 +2280,8 @@ static struct clk wkup_32k_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio1_fck = {
-	.name		= "gpio1_fck",
+static struct clk gpio1_dbck = {
+	.name		= "gpio1_dbck",
 	.parent		= &wkup_32k_fck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
@@ -2527,8 +2527,8 @@ static struct clk per_32k_alwon_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio6_fck = {
-	.name		= "gpio6_fck",
+static struct clk gpio6_dbck = {
+	.name		= "gpio6_dbck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
@@ -2537,8 +2537,8 @@ static struct clk gpio6_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio5_fck = {
-	.name		= "gpio5_fck",
+static struct clk gpio5_dbck = {
+	.name		= "gpio5_dbck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
@@ -2547,8 +2547,8 @@ static struct clk gpio5_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio4_fck = {
-	.name		= "gpio4_fck",
+static struct clk gpio4_dbck = {
+	.name		= "gpio4_dbck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
@@ -2557,8 +2557,8 @@ static struct clk gpio4_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio3_fck = {
-	.name		= "gpio3_fck",
+static struct clk gpio3_dbck = {
+	.name		= "gpio3_dbck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
@@ -2567,8 +2567,8 @@ static struct clk gpio3_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpio2_fck = {
-	.name		= "gpio2_fck",
+static struct clk gpio2_dbck = {
+	.name		= "gpio2_dbck",
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
@@ -3170,7 +3170,7 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&usim_fck,
 	&gpt1_fck,
 	&wkup_32k_fck,
-	&gpio1_fck,
+	&gpio1_dbck,
 	&wdt2_fck,
 	&wkup_l4_ick,
 	&usim_ick,
@@ -3192,11 +3192,11 @@ static struct clk *onchip_34xx_clks[] __initdata = {
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
index 424049d..66e3647 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -152,6 +152,7 @@ struct gpio_bank {
 	u32 level_mask;
 	spinlock_t lock;
 	struct gpio_chip chip;
+	struct clk *dbck;
 };
 
 #define METHOD_MPUIO		0
@@ -484,10 +485,15 @@ void omap_set_gpio_debounce(int gpio, int enable)
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
+
+	if (cpu_is_omap34xx())
+		enable ? clk_enable(bank->dbck) : clk_disable(bank->dbck);
 
 	__raw_writel(val, reg);
 }
@@ -1296,7 +1302,6 @@ static struct clk * gpio5_fck;
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3)
-static struct clk *gpio_fclks[OMAP34XX_NR_GPIOS];
 static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
 #endif
 
@@ -1310,9 +1315,7 @@ static int __init _omap_gpio_init(void)
 	int i;
 	int gpio = 0;
 	struct gpio_bank *bank;
-#if defined(CONFIG_ARCH_OMAP3)
 	char clk_name[11];
-#endif
 
 	initialized = 1;
 
@@ -1367,12 +1370,6 @@ static int __init _omap_gpio_init(void)
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
@@ -1511,6 +1508,13 @@ static int __init _omap_gpio_init(void)
 		}
 		set_irq_chained_handler(bank->irq, gpio_irq_handler);
 		set_irq_data(bank->irq, bank);
+
+		if (cpu_is_omap34xx()) {
+			sprintf(clk_name, "gpio%d_dbck", i + 1);
+			bank->dbck = clk_get(NULL, clk_name);
+			if (IS_ERR(bank->dbck))
+				printk(KERN_ERR "Could not get %s\n", clk_name);
+		}
 	}
 
 	/* Enable system clock for GPIO module.

