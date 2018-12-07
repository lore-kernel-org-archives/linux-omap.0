From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] gpio: gpio-omap: Revert deferred wakeup quirk handling for
 regressions
Date: Fri,  7 Dec 2018 11:08:29 -0800
Message-ID: <20181207190829.57864-1-tony@atomide.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Commit ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4
based SoCs") attempted to fix omap4 GPIO wakeup handling as it was
blocking deeper SoC idle states. However this caused a regression for
GPIOs during runtime having over second long latencies for Ethernet
GPIO interrupt as reportedy by Russell King <rmk+kernel@armlinux.org.uk>.

Let's fix this issue by doing a partial revert of the breaking commit.
We still want to keep the quirk handling around as it is also used for
OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER.

The real fix for omap4 GPIO wakeup handling involves fixes for
omap_set_gpio_trigger() and omap_gpio_unmask_irq() and will be posted
separately. And we must keep the wakeup bit enabled during runtime
because of module doing clock autogating with autoidle configured.

Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Fixes: ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4
based SoCs")
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c | 64 ++++------------------------------------
 1 file changed, 5 insertions(+), 59 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -32,7 +32,6 @@
 #define OMAP4_GPIO_DEBOUNCINGTIME_MASK 0xFF
 
 #define OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER	BIT(2)
-#define OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN	BIT(1)
 
 struct gpio_regs {
 	u32 irqenable1;
@@ -379,18 +378,9 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 			readl_relaxed(bank->base + bank->regs->fallingdetect);
 
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		/* Defer wkup_en register update until we idle? */
-		if (bank->quirks & OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN) {
-			if (trigger)
-				bank->context.wake_en |= gpio_bit;
-			else
-				bank->context.wake_en &= ~gpio_bit;
-		} else {
-			omap_gpio_rmw(base, bank->regs->wkup_en, gpio_bit,
-				      trigger != 0);
-			bank->context.wake_en =
-				readl_relaxed(bank->base + bank->regs->wkup_en);
-		}
+		omap_gpio_rmw(base, bank->regs->wkup_en, gpio_bit, trigger != 0);
+		bank->context.wake_en =
+			readl_relaxed(bank->base + bank->regs->wkup_en);
 	}
 
 	/* This part needs to be executed always for OMAP{34xx, 44xx} */
@@ -942,44 +932,6 @@ omap2_gpio_disable_level_quirk(struct gpio_bank *bank)
 		       bank->base + bank->regs->risingdetect);
 }
 
-/*
- * On omap4 and later SoC variants a level interrupt with wkup_en
- * enabled blocks the GPIO functional clock from idling until the GPIO
- * instance has been reset. To avoid that, we must set wkup_en only for
- * idle for level interrupts, and clear level registers for the duration
- * of idle. The level interrupts will be still there on wakeup by their
- * nature.
- */
-static void __maybe_unused
-omap4_gpio_enable_level_quirk(struct gpio_bank *bank)
-{
-	/* Update wake register for idle, edge bits might be already set */
-	writel_relaxed(bank->context.wake_en,
-		       bank->base + bank->regs->wkup_en);
-
-	/* Clear level registers for idle */
-	writel_relaxed(0, bank->base + bank->regs->leveldetect0);
-	writel_relaxed(0, bank->base + bank->regs->leveldetect1);
-}
-
-static void __maybe_unused
-omap4_gpio_disable_level_quirk(struct gpio_bank *bank)
-{
-	/* Restore level registers after idle */
-	writel_relaxed(bank->context.leveldetect0,
-		       bank->base + bank->regs->leveldetect0);
-	writel_relaxed(bank->context.leveldetect1,
-		       bank->base + bank->regs->leveldetect1);
-
-	/* Clear saved wkup_en for level, it will be set for next idle again */
-	bank->context.wake_en &= ~(bank->context.leveldetect0 |
-				   bank->context.leveldetect1);
-
-	/* Update wake with only edge configuration */
-	writel_relaxed(bank->context.wake_en,
-		       bank->base + bank->regs->wkup_en);
-}
-
 /*---------------------------------------------------------------------*/
 
 static int omap_mpuio_suspend_noirq(struct device *dev)
@@ -1412,12 +1364,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 				omap_set_gpio_dataout_mask_multiple;
 	}
 
-	if (bank->quirks & OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN) {
-		bank->funcs.idle_enable_level_quirk =
-			omap4_gpio_enable_level_quirk;
-		bank->funcs.idle_disable_level_quirk =
-			omap4_gpio_disable_level_quirk;
-	} else if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER) {
+	if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER) {
 		bank->funcs.idle_enable_level_quirk =
 			omap2_gpio_enable_level_quirk;
 		bank->funcs.idle_disable_level_quirk =
@@ -1806,8 +1753,7 @@ static const struct omap_gpio_platform_data omap4_pdata = {
 	.regs = &omap4_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
-	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER |
-		  OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN,
+	.quirks = OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER,
 };
 
 static const struct of_device_id omap_gpio_match[] = {
-- 
2.19.2
