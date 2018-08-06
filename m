From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clocksource: ti-32k: Remove CLOCK_SOURCE_SUSPEND_NONSTOP
 flag
Date: Mon, 6 Aug 2018 01:16:56 -0700
Message-ID: <20180806081656.GN99251@atomide.com>
References: <1533191716-20476-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533191716-20476-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, baolin.wang@linaro.org, d-gerlach@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Keerthy,

* Keerthy <j-keerthy@ti.com> [180802 06:39]:
> With the introduction of below commit:
> 
> commit 39232ed5a1793f67b11430c43ed8a9ed6e96c6eb
> 
> time: Introduce one suspend clocksource to compensate the suspend time
> 
> The suspend/resume fails on AM437x platforms as the source is not
> a non-stop while trying to compensate time using this.
>
> Hence remove the CLOCK_SOURCE_SUSPEND_NONSTOP flag.

The 32k timer only stops on am4, on omap3 to omap5 and dra7 it's always
on. So the NONSTOP flag should be removed only for am4.

Care to do an incremental patch clearing NONSTOP based on compatible
property?

Regards,

Tony

> Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/clocksource/timer-ti-32k.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
> index 880a861..7368e8e 100644
> --- a/drivers/clocksource/timer-ti-32k.c
> +++ b/drivers/clocksource/timer-ti-32k.c
> @@ -78,8 +78,7 @@ static u64 notrace ti_32k_read_cycles(struct clocksource *cs)
>  		.rating		= 250,
>  		.read		= ti_32k_read_cycles,
>  		.mask		= CLOCKSOURCE_MASK(32),
> -		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
> -				CLOCK_SOURCE_SUSPEND_NONSTOP,
> +		.flags		= CLOCK_SOURCE_IS_CONTINUOUS, 
>  	},
>  };
>  
> -- 
> 1.9.1
> 
