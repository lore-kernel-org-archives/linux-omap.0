From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl: single: ensure pcs irq will not be forced
 threaded
Date: Mon, 6 Jul 2015 08:29:21 -0700
Message-ID: <20150706152921.GM10705@atomide.com>
References: <1436195617-24003-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436195617-24003-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [150706 08:16]:
> The PSC IRQ is requested using request_irq() API and as result it can
> be forced to be threaded IRQ in RT-Kernel if PCS_QUIRK_HAS_SHARED_IRQ
> is enabled for pinctrl domain.
> 
> As result, following 'possible irq lock inversion dependency' report
> can be seen:
...
 
> To fix it use IRQF_NO_THREAD to ensure that pcs irq will not be forced threaded.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/pinctrl/pinctrl-single.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index b2de09d..0b8d480 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1760,7 +1760,8 @@ static int pcs_irq_init_chained_handler(struct pcs_device *pcs,
>  		int res;
>  
>  		res = request_irq(pcs_soc->irq, pcs_irq_handler,
> -				  IRQF_SHARED | IRQF_NO_SUSPEND,
> +				  IRQF_SHARED | IRQF_NO_SUSPEND |
> +				  IRQF_NO_THREAD,
>  				  name, pcs_soc);
>  		if (res) {
>  			pcs_soc->irq = -1;

Looks OK to me. The only case this would be a problem if a system has
a huge number of wake-up events as the list of status registers to
check could grow to the number of GPIO pins in theory. Anyways,
feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
