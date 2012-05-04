From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3.4-rc4] ARM: OMAP1: Amstrad Delta: Fix wrong IRQ base
 in FIQ handler
Date: Fri, 4 May 2012 09:59:49 -0700
Message-ID: <20120504165948.GC5613@atomide.com>
References: <1335806769-23711-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1335806769-23711-1-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120430 10:30]:
> Commit 384ebe1c2849160d040df3e68634ec506f13d9ff, "gpio/omap: Add DT
> support to GPIO driver", introduced dynamic IRQ numbering of OMAP GPIO
> interrupts, breaking all IH_GPIO_BASE based IRQ number calculations.
> This issue was corrected in the OMAP GPIO driver and the related header
> file with commit 25db711df3258d125dc1209800317e5c0ef3c870, "gpio/omap:
> Fix IRQ handling for SPARSE_IRQ".
> 
> However, the Amstrad Delta FIQ handler, which replaces the gpio-omap
> driver in serving GPIO interrupts on this board, still uses that
> outdated method. Fix it.

Thanks applying into fixes.
 
> Created and tested against linux-3.4-rc4.

I've dropped this last line as that's pretty obvious from the commit alone.
You can put extra comments like that could between some "---" lines:
---
This is based on -rc4...
---
So they get ignored when the patch gets applied. What is important,
is what it was tested on, so saying "Tested on ams delta" would be
more meaningful, although I guess that too is pretty obvious in this
case :)

Regards,

Tony


 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
>  arch/arm/mach-omap1/ams-delta-fiq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
> index fcce7ff..cfd98b1 100644
> --- a/arch/arm/mach-omap1/ams-delta-fiq.c
> +++ b/arch/arm/mach-omap1/ams-delta-fiq.c
> @@ -48,7 +48,7 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
>  	struct irq_chip *irq_chip = NULL;
>  	int gpio, irq_num, fiq_count;
>  
> -	irq_desc = irq_to_desc(IH_GPIO_BASE);
> +	irq_desc = irq_to_desc(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));
>  	if (irq_desc)
>  		irq_chip = irq_desc->irq_data.chip;
>  
> -- 
> 1.7.3.4
> 
