From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP
 flag for non-am43 SoCs
Date: Tue, 7 Aug 2018 23:58:52 -0700
Message-ID: <20180808065852.GO99251@atomide.com>
References: <1533633926-28908-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533633926-28908-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, baolin.wang@linaro.org, d-gerlach@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180807 09:29]:
> The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
> add the flag for all the other SoCs.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com> 

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/clocksource/timer-ti-32k.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
> index 29e2e1a..dd09171 100644
> --- a/drivers/clocksource/timer-ti-32k.c
> +++ b/drivers/clocksource/timer-ti-32k.c
> @@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
>  		return -ENXIO;
>  	}
>  
> +	if (!of_machine_is_compatible("ti,am4372"))
> +		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> +
>  	ti_32k_timer.counter = ti_32k_timer.base;
>  
>  	/*
> -- 
> 1.9.1
> 
