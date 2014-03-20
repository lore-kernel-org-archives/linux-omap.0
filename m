From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 08/26] arm: Replace various irq_desc accesses
Date: Thu, 20 Mar 2014 16:22:27 +0100
Message-ID: <201403201622.27725.arnd@arndb.de>
References: <20140223212703.511977310@linutronix.de>
 <20140223212737.099151500@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140223212737.099151500@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, omap <linux-omap@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-omap@vger.kernel.org

On Sunday 23 February 2014, Thomas Gleixner wrote:
> --- tip.orig/arch/arm/mach-omap1/ams-delta-fiq.c
> +++ tip/arch/arm/mach-omap1/ams-delta-fiq.c
> @@ -44,13 +44,10 @@ static unsigned int irq_counter[16];
>  
>  static irqreturn_t deferred_fiq(int irq, void *dev_id)
>  {
> -       struct irq_desc *irq_desc;
> -       struct irq_chip *irq_chip = NULL;
>         int gpio, irq_num, fiq_count;
> +       struct irq_chip *irq_chip;
>  
> -       irq_desc = irq_to_desc(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));
> -       if (irq_desc)
> -               irq_chip = irq_desc->irq_data.chip;
> +       irq_chip = irq_get_irq_chip(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));

I got a compile error because irq_get_irq_chip() doesn't exist. I suppose
you meant irq_get_chip.

	Arnd
