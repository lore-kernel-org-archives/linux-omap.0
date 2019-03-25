From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] gpio: gpio-omap: limit errata 1.101 handling to wkup
 domain gpios only
Date: Mon, 25 Mar 2019 15:43:16 -0700
Message-ID: <20190325224318.15076-2-tony@atomide.com>
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

We need to only apply errata 1.101 handling to clear non-wakeup edge gpios
for idle to the gpio bank(s) in the wkup domain to prevent spurious wake-up
events.

And we must restore what we did after idle manually as the gpio bank in
wkup domain is not restored otherwise.

Let's keep bank->saved_datain register reading separate, that's not related
to the 1.101 errata and is used separately on restore.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1444,7 +1444,10 @@ static void omap_gpio_restore_context(struct gpio_bank *bank);
 static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 {
 	struct device *dev = bank->chip.parent;
-	u32 l1 = 0, l2 = 0;
+	void __iomem *base = bank->base;
+	u32 nowake;
+
+	bank->saved_datain = readl_relaxed(base + bank->regs->datain);
 
 	if (bank->funcs.idle_enable_level_quirk)
 		bank->funcs.idle_enable_level_quirk(bank);
@@ -1456,20 +1459,15 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 		goto update_gpio_context_count;
 
 	/*
-	 * If going to OFF, remove triggering for all
+	 * If going to OFF, remove triggering for all wkup domain
 	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
 	 * generated.  See OMAP2420 Errata item 1.101.
 	 */
-	bank->saved_datain = readl_relaxed(bank->base +
-						bank->regs->datain);
-	l1 = bank->context.fallingdetect;
-	l2 = bank->context.risingdetect;
-
-	l1 &= ~bank->enabled_non_wakeup_gpios;
-	l2 &= ~bank->enabled_non_wakeup_gpios;
-
-	writel_relaxed(l1, bank->base + bank->regs->fallingdetect);
-	writel_relaxed(l2, bank->base + bank->regs->risingdetect);
+	if (!bank->loses_context && bank->enabled_non_wakeup_gpios) {
+		nowake = bank->enabled_non_wakeup_gpios;
+		omap_gpio_rmw(base, bank->regs->fallingdetect, nowake, ~nowake);
+		omap_gpio_rmw(base, bank->regs->risingdetect, nowake, ~nowake);
+	}
 
 	bank->workaround_enabled = true;
 
@@ -1518,6 +1516,12 @@ static void omap_gpio_unidle(struct gpio_bank *bank)
 				return;
 			}
 		}
+	} else {
+		/* Restore changes done for OMAP2420 errata 1.101 */
+		writel_relaxed(bank->context.fallingdetect,
+			       bank->base + bank->regs->fallingdetect);
+		writel_relaxed(bank->context.risingdetect,
+			       bank->base + bank->regs->risingdetect);
 	}
 
 	if (!bank->workaround_enabled)
-- 
2.21.0
