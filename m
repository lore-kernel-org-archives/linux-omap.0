From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] gpio: gpio-omap: always scan for triggered non-wakeup
 capable interrupts
Date: Mon, 25 Mar 2019 15:43:17 -0700
Message-ID: <20190325224318.15076-3-tony@atomide.com>
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

The bank->workaround_enabled should be for omap24xx erratum 1.101 but is not
needed any longer as erratum 1.101 handling only needs to happen based on
!bank->loses_context with patch "gpio: omap: Limit errata 1.101 handling to
wkup domain gpios only".

Further Grygorii Strashko <grygorii.strashko@ti.com> points out that we are
now tagging all edge GPIOs as non-wakeup GPIOs and rely on original erratum
1.101 handling for scacnning for edge interrupts that have triggered during
idle.

Also the TI Android kernel tree has an earlier commit "GPIO: OMAP: Always
scan gpios during runtime resume" by Tero Kristo <t-kristo@ti.com> saying:

 "This allows the driver to generate interrupts for GPIOs that can't
  wakeup but have changed state during runtime suspend. We cannot
  depend on the decision based on no need to restore, as the system
  state might change and pending events could gather up."

So let's remove bank->workaround_enabled and always scan for triggered edge
interrupts on resume. We do that based on bank->enabled_non_wakeup_gpios.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -83,7 +83,6 @@ struct gpio_bank {
 	int stride;
 	u32 width;
 	int context_loss_count;
-	bool workaround_enabled;
 	u32 quirks;
 
 	void (*set_dataout)(struct gpio_bank *bank, unsigned gpio, int enable);
@@ -1469,8 +1468,6 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 		omap_gpio_rmw(base, bank->regs->risingdetect, nowake, ~nowake);
 	}
 
-	bank->workaround_enabled = true;
-
 update_gpio_context_count:
 	if (bank->get_context_loss_count)
 		bank->context_loss_count =
@@ -1524,9 +1521,6 @@ static void omap_gpio_unidle(struct gpio_bank *bank)
 			       bank->base + bank->regs->risingdetect);
 	}
 
-	if (!bank->workaround_enabled)
-		return;
-
 	l = readl_relaxed(bank->base + bank->regs->datain);
 
 	/*
@@ -1576,8 +1570,6 @@ static void omap_gpio_unidle(struct gpio_bank *bank)
 		writel_relaxed(old0, bank->base + bank->regs->leveldetect0);
 		writel_relaxed(old1, bank->base + bank->regs->leveldetect1);
 	}
-
-	bank->workaround_enabled = false;
 }
 
 static void omap_gpio_init_context(struct gpio_bank *p)
-- 
2.21.0
