From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] clocksource: timer-ti-dm: Fix pwm dmtimer usage of
 fck reparenting
Date: Tue, 12 Feb 2019 10:08:29 +0100
Message-ID: <00e47cf9-b444-4fcf-0d1a-11ff61edf008@linaro.org>
References: <20190122175717.13428-1-tony@atomide.com>
 <20190122175717.13428-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122175717.13428-2-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, Keerthy <j-keerthy@ti.com>, Ladislav Michl <ladis@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 22/01/2019 18:57, Tony Lindgren wrote:
> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
> them with ti-sysc") moved some omap4 timers to probe with ti-sysc
> interconnect target module. Turns out this broke pwm-omap-dmtimer
> where we now try to reparent the clock to itself with the following:
> 
> omap_dm_timer_of_set_source: failed to set parent
> 
> With ti-sysc, we can now configure the clock sources in the dts
> with assigned-clocks and assigned-clock-parents. So we should be able
> to remove omap_dm_timer_of_set_source with clean-up patches later on.
> But for now, let's just fix it first by checking if parent and fck
> are the same and bail out of so.
> 
> Fixes: 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
> them with ti-sysc")
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Ladislav Michl <ladis@linux-mips.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Do you want me to take it through my tree (1 et 3)?

>  drivers/clocksource/timer-ti-dm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -154,6 +154,10 @@ static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
>  	if (IS_ERR(parent))
>  		return -ENODEV;
>  
> +	/* Bail out if both clocks point to fck */
> +	if (clk_is_match(parent, timer->fclk))
> +		return 0;
> +
>  	ret = clk_set_parent(timer->fclk, parent);
>  	if (ret < 0)
>  		pr_err("%s: failed to set parent\n", __func__);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
