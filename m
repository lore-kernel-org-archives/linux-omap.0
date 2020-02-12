From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/18] ARM: replace setup_irq() by request_irq()
Date: Wed, 12 Feb 2020 13:40:44 +0530
Message-ID: <20200212081044.lsw6to5kmzl22ywc@vireshk-i7>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
 <da7d11b6cf808ea95e2d852a2e8cbca3fde28b6f.1581478324.git.afzal.mohd.ma@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45246 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBLIKr (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 12 Feb 2020 03:10:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so651534pls.12
        for <linux-omap@vger.kernel.org>; Wed, 12 Feb 2020 00:10:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <da7d11b6cf808ea95e2d852a2e8cbca3fde28b6f.1581478324.git.afzal.mohd.ma@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: afzal mohammed <afzal.mohd.ma@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Krzysztof Halasa <khalasa@piap.pl>, Russell King <linux@armlinux.org.uk>, Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Lubomir Rintel <lkundrak@v3.sk>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas

On 12-02-20, 13:32, afzal mohammed wrote:
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
> ---
>  arch/arm/mach-spear/time.c               |  9 ++-------
>
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index 289e036c9c30..92b2850eeb4f 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -181,12 +181,6 @@ static irqreturn_t spear_timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct irqaction spear_timer_irq = {
> -	.name = "timer",
> -	.flags = IRQF_TIMER,
> -	.handler = spear_timer_interrupt
> -};
> -
>  static void __init spear_clockevent_init(int irq)
>  {
>  	u32 tick_rate;
> @@ -201,7 +195,8 @@ static void __init spear_clockevent_init(int irq)
>  
>  	clockevents_config_and_register(&clkevt, tick_rate, 3, 0xfff0);
>  
> -	setup_irq(irq, &spear_timer_irq);
> +	if (request_irq(irq, spear_timer_interrupt, IRQF_TIMER, "timer", NULL))
> +		pr_err("request_irq() on %s failed\n", "timer");
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
