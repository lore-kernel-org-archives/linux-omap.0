From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] ARM: OMAP2+: timer: Add a powerup function
Date: Mon, 21 Jul 2014 04:00:57 -0700
Message-ID: <20140721110057.GV18374@atomide.com>
References: <1398216429-4681-1-git-send-email-joelf@ti.com>
 <1398216429-4681-2-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398216429-4681-2-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Joel Fernandes <joelf@ti.com> [140422 18:27]:
> In an effort to isolate the time power initialization for future purposes, add
> a function to do the same. This primarily involves a hwmod lookup, setup and
> enable.

No users yet for this function? Can you remove the same code from
somewhere else in this patch?

Regards,

Tony
 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index dfb19df..ec427e6 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -210,6 +210,31 @@ static void __init omap_dmtimer_init(void)
>  	}
>  }
>  
> +int __init omap_dmtimer_powerup(struct device_node *np)
> +{
> +	struct omap_hwmod *oh;
> +	const char *oh_name = NULL;
> +	int ret;
> +
> +	of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
> +	if (!oh_name)
> +		return -ENODEV;
> +
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh)
> +		return -ENODEV;
> +
> +	ret = omap_hwmod_setup_one(oh_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = omap_hwmod_enable(oh);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  /**
>   * omap_dm_timer_get_errata - get errata flags for a timer
>   *
> -- 
> 1.7.9.5
> 
