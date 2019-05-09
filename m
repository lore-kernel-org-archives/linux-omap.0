From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: gpio-omap: Fix lost edge wake-up interrupts
Date: Wed, 8 May 2019 17:49:51 -0700
Message-ID: <20190509004951.GT8007@atomide.com>
References: <20190508181939.1990-1-tony@atomide.com>
 <20190508204015.GS8007@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190508204015.GS8007@atomide.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190508 20:40]:
> * Tony Lindgren <tony@atomide.com> [190508 11:20]:
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -1279,7 +1279,14 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
> >  	void __iomem *base = bank->base;
> >  	u32 nowake;
> >  
> > +	/*
> > +	 * Save datain register to trigger edge interrupts on unidle for GPIOS
> > +	 * that are not wake-up capable. Ignore any enabled_non_wakeup_gpios
> > +	 * that may have just triggered as we're entering idle. Otherwise unidle
> > +	 * will not notice them.
> > +	 */
> >  	bank->saved_datain = readl_relaxed(base + bank->regs->datain);
> > +	bank->saved_datain |= bank->enabled_non_wakeup_gpios;
> 
> Oops, sorry this is not complete yet. We need to enable or clear
> the possible pending interrupt in saved_datain based on the edge
> interrupt polarity. I'll fix and resend.

Below seems to behave for me based on light testing..
Might be worth thinking about this a bit more, anybody got
better ideas? :)

Regards,

Tony

8< --------------------
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1277,10 +1277,24 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 {
 	struct device *dev = bank->chip.parent;
 	void __iomem *base = bank->base;
-	u32 nowake;
+	u32 mask, nowake;
 
+	/*
+	 * Save datain register to trigger edge interrupts on unidle for GPIOS
+	 * that are not wake-up capable. Ignore any enabled_non_wakeup_gpios
+	 * that may have just triggered as we're entering idle. Otherwise unidle
+	 * will not notice them. Note that this does not help with EDGE_BOTH.
+	 */
 	bank->saved_datain = readl_relaxed(base + bank->regs->datain);
 
+	mask = bank->enabled_non_wakeup_gpios & bank->context.fallingdetect;
+	mask &= ~bank->context.risingdetect;
+	bank->saved_datain |= mask;
+
+	mask = bank->enabled_non_wakeup_gpios & bank->context.risingdetect;
+	mask &= ~bank->context.fallingdetect;
+	bank->saved_datain &= ~mask;
+
 	if (!bank->enabled_non_wakeup_gpios)
 		goto update_gpio_context_count;
 
-- 
2.21.0
