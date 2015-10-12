From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] sched_clock: add data pointer argument to read callback
Date: Mon, 12 Oct 2015 15:02:42 +0200
Message-ID: <87io6c6xzh.fsf@free-electrons.com>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444427858-576-1-git-send-email-mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org> (Mans Rullgard's
	message of "Fri, 9 Oct 2015 22:57:35 +0100")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans Ulli Kroll <ulli.kroll-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mikael Starvik <starvik-VrBV9hrLPhE@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Srinivas Kandagatla <srinivas.kanda>
List-Id: linux-omap@vger.kernel.org

Hi Mans,
 
 On ven., oct. 09 2015, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org> wrote:

> This passes a data pointer specified in the sched_clock_register()
> call to the read callback allowing simpler implementations thereof.
>
> In this patch, existing uses of this interface are simply updated
> with a null pointer.
>
> Signed-off-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
> ---
[...]
> diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> index 2162796..a13b73b 100644
> --- a/drivers/clocksource/time-armada-370-xp.c
> +++ b/drivers/clocksource/time-armada-370-xp.c
> @@ -92,7 +92,7 @@ static void local_timer_ctrl_clrset(u32 clr, u32 set)
>  		local_base + TIMER_CTRL_OFF);
>  }
>  
> -static u64 notrace armada_370_xp_read_sched_clock(void)
> +static u64 notrace armada_370_xp_read_sched_clock(void *data)
>  {
>  	return ~readl(timer_base + TIMER0_VAL_OFF);
>  }
> @@ -290,7 +290,8 @@ static void __init armada_370_xp_timer_common_init(struct device_node *np)
>  	/*
>  	 * Set scale and timer for sched_clock.
>  	 */
> -	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk);
> +	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk,
> +			     NULL);
>  
>  	clocksource_mmio_init(timer_base + TIMER0_VAL_OFF,
>  			      "armada_370_xp_clocksource",

For the time-armada-370-xp.c file:

Acked-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
