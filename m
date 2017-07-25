From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/11] mfd: Drop unnecessary static
Date: Tue, 25 Jul 2017 09:00:09 +0100
Message-ID: <20170725080009.sm675kxlj7mhjqhi@dell>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
 <1500149266-32357-8-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500149266-32357-8-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Tony Lindgren <tony@atomide.com>, keescook@chromium.org, kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 15 Jul 2017, Julia Lawall wrote:

> Drop static on a local variable, when the variable is initialized before
> any possible use.  Thus, the static has no benefit.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @bad exists@
> position p;
> identifier x;
> type T;
> @@
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
> -static
>  T x@p;
>  ... when != x
>      when strict
> ?x = e;
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
> These patches are all independent of each other.
> 
>  drivers/mfd/twl4030-irq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks like I didn't reply to this patch.

Just to let you know, it has been applied.

> diff -u -p a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -685,7 +685,7 @@ int twl4030_sih_setup(struct device *dev
>  
>  int twl4030_init_irq(struct device *dev, int irq_num)
>  {
> -	static struct irq_chip	twl4030_irq_chip;
> +	struct irq_chip		twl4030_irq_chip;
>  	int			status, i;
>  	int			irq_base, irq_end, nr_irqs;
>  	struct			device_node *node = dev->of_node;
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
