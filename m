From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl4030-irq: remove unnecessary static in
 twl4030_init_irq()
Date: Tue, 18 Jul 2017 09:45:42 +0100
Message-ID: <20170718084542.s37jidpes3rfin5j@dell>
References: <20170717162636.GA30142@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717162636.GA30142@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 17 Jul 2017, Gustavo A. R. Silva wrote:

> Remove unnecessary static on local variable twl4030_irq_chip.
> Such variable is initialized before being used, on every
> execution path throughout the function. The static has no
> benefit and, removing it reduces the object file size.
> 
> This issue was detected using Coccinelle and the following semantic patch:
> 
> @bad exists@
> position p;
> identifier x;
> type T;
> @@
> 
> static T x@p;
> ...
> x = <+...x...+>
> 
> @@
> identifier x;
> expression e;
> type T;
> position p != bad.p;
> @@
> 
> -static
>  T x@p;
>  ... when != x
>      when strict
> ?x = e;
> 
> In the following log you can see a significant difference in the object
> file size. This log is the output of the size command, before and after
> the code change:
> 
> before:
>    text    data     bss     dec     hex filename
>    7076    2400     640   10116    2784 drivers/mfd/twl4030-irq.o
> 
> after:
>    text    data     bss     dec     hex filename
>    7119    2344     320    9783    2637 drivers/mfd/twl4030-irq.o
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mfd/twl4030-irq.c             | 2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index 378c02d..65d5500 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -685,7 +685,7 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base)
>  
>  int twl4030_init_irq(struct device *dev, int irq_num)
>  {
> -	static struct irq_chip	twl4030_irq_chip;
> +	struct irq_chip	twl4030_irq_chip;
>  	int			status, i;
>  	int			irq_base, irq_end, nr_irqs;
>  	struct			device_node *node = dev->of_node;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
