From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] genirq: export handle_bad_irq
Date: Wed, 7 Oct 2015 14:18:24 -0500
Message-ID: <56157000.4010009@ti.com>
References: <5847725.4IBopItaOr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5847725.4IBopItaOr@wuerfel>
Sender: linux-gpio-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Austin Schuh <austin@peloton-tech.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On 10/06/2015 03:24 PM, Arnd Bergmann wrote:
> A cleanup of the omap gpio driver introduced a use of the
> handle_bad_irq() function in a device driver that can be
> a loadable module.
>
> This broke the ARM allmodconfig build:
>
> ERROR: "handle_bad_irq" [drivers/gpio/gpio-omap.ko] undefined!
>
> This patch exports the handle_bad_irq symbol in order to
> allow the use in modules.
>

Thanks for fixing it and sorry for the mess.
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>


> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 450fa54cfd66 ("gpio: omap: convert to use generic irq handler")
>
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index ea7b5fd99ba5..142bbf3b607f 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -35,6 +35,7 @@ void handle_bad_irq(struct irq_desc *desc)
>   	kstat_incr_irqs_this_cpu(desc);
>   	ack_bad_irq(irq);
>   }
> +EXPORT_SYMBOL_GPL(handle_bad_irq);
>
>   /*
>    * Special, empty irq handler:
>


-- 
regards,
-grygorii
