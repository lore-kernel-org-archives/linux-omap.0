From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH 02/18] ARM: replace setup_irq() by request_irq()
Date: Thu, 13 Feb 2020 00:27:16 +0100
Message-ID: <20200213002716.99258cfd73002fdd4bbd17d9@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
        <da7d11b6cf808ea95e2d852a2e8cbca3fde28b6f.1581478324.git.afzal.mohd.ma@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50649 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBLX1Y (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 12 Feb 2020 18:27:24 -0500
In-Reply-To: <da7d11b6cf808ea95e2d852a2e8cbca3fde28b6f.1581478324.git.afzal.mohd.ma@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: afzal mohammed <afzal.mohd.ma@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Krzysztof Halasa <khalasa@piap.pl>, Russell King <linux@armlinux.org.uk>, Hartley Sweeten <hsweeten@visionengravers.com>, Lubomir Rintel <lkundrak@v3.sk>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arnd>

Hi!

On Wed, 12 Feb 2020 13:32:43 +0530
afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> request_irq() is preferred over setup_irq(). Existing callers of
> setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
> memory allocators are ready by 'mm_init()'.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> Seldom remove_irq() usage has been observed coupled with setup_irq(),
> wherever that has been found, it too has been replaced by free_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

For the EP93xx part:
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
> index de998830f534..0335f3b93340 100644
> --- a/arch/arm/mach-ep93xx/timer-ep93xx.c
> +++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
> @@ -117,13 +117,6 @@ static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct irqaction ep93xx_timer_irq = {
> -	.name		= "ep93xx timer",
> -	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
> -	.handler	= ep93xx_timer_interrupt,
> -	.dev_id		= &ep93xx_clockevent,
> -};
> -
>  void __init ep93xx_timer_init(void)
>  {
>  	/* Enable and register clocksource and sched_clock on timer 4 */
> @@ -136,7 +129,10 @@ void __init ep93xx_timer_init(void)
>  			     EP93XX_TIMER4_RATE);
>  
>  	/* Set up clockevent on timer 3 */
> -	setup_irq(IRQ_EP93XX_TIMER3, &ep93xx_timer_irq);
> +	if (request_irq(IRQ_EP93XX_TIMER3, ep93xx_timer_interrupt,
> +			IRQF_TIMER | IRQF_IRQPOLL, "ep93xx timer",
> +			&ep93xx_clockevent))
> +		pr_err("request_irq() on %s failed\n", "ep93xx timer");
>  	clockevents_config_and_register(&ep93xx_clockevent,
>  					EP93XX_TIMER123_RATE,
>  					1,

-- 
Alexander Sverdlin.
