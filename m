From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] gpio: gpio-omap: add check for off wake capable gpios
Date: Mon, 25 Mar 2019 15:43:18 -0700
Message-ID: <20190325224318.15076-4-tony@atomide.com>
References: <20190325224318.15076-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190325224318.15076-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are currently assuming all GPIOs are non-wakeup capable GPIOs as we
not configuring the bank->non_wakeup_gpios like we used to earlier with
platform_data.

Let's add omap_gpio_is_off_wakeup_capable() to make the handling clearer
while considering that later patches may want to configure SoC specific
bank->non_wakeup_gpios for the GPIOs in wakeup domain.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -352,6 +352,22 @@ static void omap_clear_gpio_debounce(struct gpio_bank *bank, unsigned offset)
 	}
 }
 
+/*
+ * Off mode wake-up capable GPIOs in bank(s) that are in the wakeup domain.
+ * See TRM section for GPIO for "Wake-Up Generation" for the list of GPIOs
+ * in wakeup domain. If bank->non_wakeup_gpios is not configured, assume none
+ * are capable waking up the system from off mode.
+ */
+static bool omap_gpio_is_off_wakeup_capable(struct gpio_bank *bank, u32 gpio_mask)
+{
+	u32 no_wake = bank->non_wakeup_gpios;
+
+	if (no_wake)
+		return !!(~no_wake & gpio_mask);
+
+	return false;
+}
+
 static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 						unsigned trigger)
 {
@@ -383,13 +399,7 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 	}
 
 	/* This part needs to be executed always for OMAP{34xx, 44xx} */
-	if (!bank->regs->irqctrl) {
-		/* On omap24xx proceed only when valid GPIO bit is set */
-		if (bank->non_wakeup_gpios) {
-			if (!(bank->non_wakeup_gpios & gpio_bit))
-				goto exit;
-		}
-
+	if (!bank->regs->irqctrl && !omap_gpio_is_off_wakeup_capable(bank, gpio)) {
 		/*
 		 * Log the edge gpio and manually trigger the IRQ
 		 * after resume if the input level changes
@@ -402,7 +412,6 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
 	}
 
-exit:
 	bank->level_mask =
 		readl_relaxed(bank->base + bank->regs->leveldetect0) |
 		readl_relaxed(bank->base + bank->regs->leveldetect1);
-- 
2.21.0
