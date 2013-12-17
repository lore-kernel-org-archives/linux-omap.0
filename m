From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 05/10] mfd: menelaus: Use for_each_set_bit()
Date: Mon, 16 Dec 2013 16:17:35 -0800
Message-ID: <1387239455.18217.61.camel@joe-AO722>
References: <20131216153936.GQ18769@lee--X1>
	 <1387238904-7843-1-git-send-email-balbi@ti.com>
	 <1387238904-7843-5-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387238904-7843-5-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: lee.jones@linaro.org, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On Mon, 2013-12-16 at 18:08 -0600, Felipe Balbi wrote:
> That macro just helps removing some extra line of code and hides ffs()
> calls.
> 
> While at that, also fix a variable shadowing bug where 'int irq' was
> being redeclared inside inner loop while it was also argument to
> interrupt handler.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index 87d80a8..d3e3022 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -795,24 +795,22 @@ static irqreturn_t menelaus_irq(int irq, void *_menelaus)
>  {
>  	struct menelaus_chip *menelaus = _menelaus;
>  	void (*handler)(struct menelaus_chip *menelaus);
> -	unsigned isr;
> +	unsigned long isr;
> +	unsigned long i;
>  
>  	isr = (menelaus_read_reg(MENELAUS_INT_STATUS2)
>  			& ~menelaus->mask2) << 8;
>  	isr |= menelaus_read_reg(MENELAUS_INT_STATUS1)
>  		& ~menelaus->mask1;
>  
> -	while (isr) {
> -		int irq = fls(isr) - 1;
> -		isr &= ~(1 << irq);
> -
> +	for_each_set_bit(i, &isr, 16) {
>  		mutex_lock(&menelaus->lock);
> -		menelaus_disable_irq(irq);
> -		menelaus_ack_irq(irq);
> -		handler = menelaus->handlers[irq];
> +		menelaus_disable_irq(i);
> +		menelaus_ack_irq(i);
> +		handler = menelaus->handlers[i];
>  		if (handler)
>  			handler(menelaus);
> -		menelaus_enable_irq(irq);
> +		menelaus_enable_irq(i);
>  		mutex_unlock(&menelaus->lock);
>  	}
>  

This could handle the irqs in reverse order.
Does that matter?
